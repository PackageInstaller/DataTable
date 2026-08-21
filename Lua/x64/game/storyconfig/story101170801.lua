return {
	Play117081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117081001
		arg_1_1.duration_ = 12.37

		local var_1_0 = {
			zh = 12.366,
			ja = 8.433
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
				arg_1_0:Play117081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "TI0101"

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
				local var_4_5 = arg_1_1.bgs_.TI0101

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
					if iter_4_0 ~= "TI0101" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 1.25

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_31 = arg_1_1:FormatText(StoryNameCfg[368].name)

				arg_1_1.leftNameTxt_.text = var_4_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_32 = arg_1_1:GetWordFromCfg(117081001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 50
				local var_4_35 = utf8.len(var_4_33)
				local var_4_36 = var_4_34 <= 0 and var_4_29 or var_4_29 * (var_4_35 / var_4_34)

				if var_4_36 > 0 and var_4_29 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_28 = var_4_28 + 0.3

					if var_4_36 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081001", "story_v_out_117081.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_117081", "117081001", "story_v_out_117081.awb") / 1000

					if var_4_37 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_28
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_117081", "117081001", "story_v_out_117081.awb")

						arg_1_1:RecordAudio("117081001", var_4_38)
						arg_1_1:RecordAudio("117081001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_117081", "117081001", "story_v_out_117081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_117081", "117081001", "story_v_out_117081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_28 + 0.3
			local var_4_40 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play117081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 117081002
		arg_8_1.duration_ = 11

		local var_8_0 = {
			zh = 9.2,
			ja = 11
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
				arg_8_0:Play117081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.2

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[368].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(117081002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081002", "story_v_out_117081.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081002", "story_v_out_117081.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_117081", "117081002", "story_v_out_117081.awb")

						arg_8_1:RecordAudio("117081002", var_11_9)
						arg_8_1:RecordAudio("117081002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_117081", "117081002", "story_v_out_117081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_117081", "117081002", "story_v_out_117081.awb")
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
	Play117081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 117081003
		arg_12_1.duration_ = 8

		local var_12_0 = {
			zh = 6.9,
			ja = 8
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
				arg_12_0:Play117081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.9

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[368].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(117081003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 36
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081003", "story_v_out_117081.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081003", "story_v_out_117081.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_117081", "117081003", "story_v_out_117081.awb")

						arg_12_1:RecordAudio("117081003", var_15_9)
						arg_12_1:RecordAudio("117081003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_117081", "117081003", "story_v_out_117081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_117081", "117081003", "story_v_out_117081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play117081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 117081004
		arg_16_1.duration_ = 8.37

		local var_16_0 = {
			zh = 8.366,
			ja = 6.7
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
				arg_16_0:Play117081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.15

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[368].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(117081004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081004", "story_v_out_117081.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081004", "story_v_out_117081.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_117081", "117081004", "story_v_out_117081.awb")

						arg_16_1:RecordAudio("117081004", var_19_9)
						arg_16_1:RecordAudio("117081004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_117081", "117081004", "story_v_out_117081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_117081", "117081004", "story_v_out_117081.awb")
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
	Play117081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 117081005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play117081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "ST24a"

			if arg_20_1.bgs_[var_23_0] == nil then
				local var_23_1 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_0)
				var_23_1.name = var_23_0
				var_23_1.transform.parent = arg_20_1.stage_.transform
				var_23_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_0] = var_23_1
			end

			local var_23_2 = 1.999999999999

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				local var_23_3 = manager.ui.mainCamera.transform.localPosition
				local var_23_4 = Vector3.New(0, 0, 10) + Vector3.New(var_23_3.x, var_23_3.y, 0)
				local var_23_5 = arg_20_1.bgs_.ST24a

				var_23_5.transform.localPosition = var_23_4
				var_23_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_6 = var_23_5:GetComponent("SpriteRenderer")

				if var_23_6 and var_23_6.sprite then
					local var_23_7 = (var_23_5.transform.localPosition - var_23_3).z
					local var_23_8 = manager.ui.mainCameraCom_
					local var_23_9 = 2 * var_23_7 * Mathf.Tan(var_23_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_10 = var_23_9 * var_23_8.aspect
					local var_23_11 = var_23_6.sprite.bounds.size.x
					local var_23_12 = var_23_6.sprite.bounds.size.y
					local var_23_13 = var_23_10 / var_23_11
					local var_23_14 = var_23_9 / var_23_12
					local var_23_15 = var_23_14 < var_23_13 and var_23_13 or var_23_14

					var_23_5.transform.localScale = Vector3.New(var_23_15, var_23_15, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST24a" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_17 = 1.999999999999

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Color.New(0, 0, 0)

				var_23_19.a = Mathf.Lerp(0, 1, var_23_18)
				arg_20_1.mask_.color = var_23_19
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				local var_23_20 = Color.New(0, 0, 0)

				var_23_20.a = 1
				arg_20_1.mask_.color = var_23_20
			end

			local var_23_21 = 2

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_22 = 1.999999999999

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22
				local var_23_24 = Color.New(0, 0, 0)

				var_23_24.a = Mathf.Lerp(1, 0, var_23_23)
				arg_20_1.mask_.color = var_23_24
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 then
				local var_23_25 = Color.New(0, 0, 0)
				local var_23_26 = 0

				arg_20_1.mask_.enabled = false
				var_23_25.a = var_23_26
				arg_20_1.mask_.color = var_23_25
			end

			local var_23_27 = 0
			local var_23_28 = 1

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				local var_23_29 = "play"
				local var_23_30 = "music"

				arg_20_1:AudioAction(var_23_29, var_23_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_23_31 = ""
				local var_23_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_23_32 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_32 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_32

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_32
						arg_20_1.bgmTxt2_.text = var_23_32
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_33 = 3.999999999999
			local var_23_34 = 1

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				local var_23_35 = "play"
				local var_23_36 = "music"

				arg_20_1:AudioAction(var_23_35, var_23_36, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_23_37 = ""
				local var_23_38 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_23_38 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_38 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_38

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_38
						arg_20_1.bgmTxt2_.text = var_23_38
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_39 = 3.999999999999
			local var_23_40 = 1.325

			if var_23_39 < arg_20_1.time_ and arg_20_1.time_ <= var_23_39 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_41 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_41:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_20_1.dialogCg_.alpha = arg_26_0
				end))
				var_23_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_42 = arg_20_1:GetWordFromCfg(117081005)
				local var_23_43 = arg_20_1:FormatText(var_23_42.content)

				arg_20_1.text_.text = var_23_43

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_44 = 53
				local var_23_45 = utf8.len(var_23_43)
				local var_23_46 = var_23_44 <= 0 and var_23_40 or var_23_40 * (var_23_45 / var_23_44)

				if var_23_46 > 0 and var_23_40 < var_23_46 then
					arg_20_1.talkMaxDuration = var_23_46
					var_23_39 = var_23_39 + 0.3

					if var_23_46 + var_23_39 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_46 + var_23_39
					end
				end

				arg_20_1.text_.text = var_23_43
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_47 = var_23_39 + 0.3
			local var_23_48 = math.max(var_23_40, arg_20_1.talkMaxDuration)

			if var_23_47 <= arg_20_1.time_ and arg_20_1.time_ < var_23_47 + var_23_48 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_47) / var_23_48

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_47 + var_23_48 and arg_20_1.time_ < var_23_47 + var_23_48 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play117081006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 117081006
		arg_28_1.duration_ = 5.93

		local var_28_0 = {
			zh = 5.933,
			ja = 3.8
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
				arg_28_0:Play117081007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10034"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10034")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(var_31_1, arg_28_1.canvasGo_.transform)

					var_31_2.transform:SetSiblingIndex(1)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_28_1.isInRecall_ then
						for iter_31_0, iter_31_1 in ipairs(var_31_3) do
							iter_31_1.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_4 = arg_28_1.actors_["10034"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos10034 = var_31_4.localPosition
				var_31_4.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10034", 2)

				local var_31_6 = var_31_4.childCount

				for iter_31_2 = 0, var_31_6 - 1 do
					local var_31_7 = var_31_4:GetChild(iter_31_2)

					if var_31_7.name == "split_2" or not string.find(var_31_7.name, "split") then
						var_31_7.gameObject:SetActive(true)
					else
						var_31_7.gameObject:SetActive(false)
					end
				end
			end

			local var_31_8 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_5) / var_31_8
				local var_31_10 = Vector3.New(-390, -415, -290)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10034, var_31_10, var_31_9)
			end

			if arg_28_1.time_ >= var_31_5 + var_31_8 and arg_28_1.time_ < var_31_5 + var_31_8 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_31_11 = "10035"

			if arg_28_1.actors_[var_31_11] == nil then
				local var_31_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_31_12) then
					local var_31_13 = Object.Instantiate(var_31_12, arg_28_1.canvasGo_.transform)

					var_31_13.transform:SetSiblingIndex(1)

					var_31_13.name = var_31_11
					var_31_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_[var_31_11] = var_31_13

					local var_31_14 = var_31_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_28_1.isInRecall_ then
						for iter_31_3, iter_31_4 in ipairs(var_31_14) do
							iter_31_4.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_15 = arg_28_1.actors_["10035"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos10035 = var_31_15.localPosition
				var_31_15.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10035", 4)

				local var_31_17 = var_31_15.childCount

				for iter_31_5 = 0, var_31_17 - 1 do
					local var_31_18 = var_31_15:GetChild(iter_31_5)

					if var_31_18.name == "split_4" or not string.find(var_31_18.name, "split") then
						var_31_18.gameObject:SetActive(true)
					else
						var_31_18.gameObject:SetActive(false)
					end
				end
			end

			local var_31_19 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_19 then
				local var_31_20 = (arg_28_1.time_ - var_31_16) / var_31_19
				local var_31_21 = Vector3.New(390, -410, -235)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10035, var_31_21, var_31_20)
			end

			if arg_28_1.time_ >= var_31_16 + var_31_19 and arg_28_1.time_ < var_31_16 + var_31_19 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(390, -410, -235)
			end

			local var_31_22 = arg_28_1.actors_["10034"]
			local var_31_23 = 0

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				local var_31_24 = var_31_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_31_24 then
					arg_28_1.var_.alphaOldValue10034 = var_31_24.alpha
					arg_28_1.var_.characterEffect10034 = var_31_24
				end

				arg_28_1.var_.alphaOldValue10034 = 0
			end

			local var_31_25 = 0.333333333333333

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_25 then
				local var_31_26 = (arg_28_1.time_ - var_31_23) / var_31_25
				local var_31_27 = Mathf.Lerp(arg_28_1.var_.alphaOldValue10034, 1, var_31_26)

				if arg_28_1.var_.characterEffect10034 then
					arg_28_1.var_.characterEffect10034.alpha = var_31_27
				end
			end

			if arg_28_1.time_ >= var_31_23 + var_31_25 and arg_28_1.time_ < var_31_23 + var_31_25 + arg_31_0 and arg_28_1.var_.characterEffect10034 then
				arg_28_1.var_.characterEffect10034.alpha = 1
			end

			local var_31_28 = arg_28_1.actors_["10035"]
			local var_31_29 = 0

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				local var_31_30 = var_31_28:GetComponentInChildren(typeof(CanvasGroup))

				if var_31_30 then
					arg_28_1.var_.alphaOldValue10035 = var_31_30.alpha
					arg_28_1.var_.characterEffect10035 = var_31_30
				end

				arg_28_1.var_.alphaOldValue10035 = 0
			end

			local var_31_31 = 0.333333333333333

			if var_31_29 <= arg_28_1.time_ and arg_28_1.time_ < var_31_29 + var_31_31 then
				local var_31_32 = (arg_28_1.time_ - var_31_29) / var_31_31
				local var_31_33 = Mathf.Lerp(arg_28_1.var_.alphaOldValue10035, 1, var_31_32)

				if arg_28_1.var_.characterEffect10035 then
					arg_28_1.var_.characterEffect10035.alpha = var_31_33
				end
			end

			if arg_28_1.time_ >= var_31_29 + var_31_31 and arg_28_1.time_ < var_31_29 + var_31_31 + arg_31_0 and arg_28_1.var_.characterEffect10035 then
				arg_28_1.var_.characterEffect10035.alpha = 1
			end

			local var_31_34 = arg_28_1.actors_["10035"]
			local var_31_35 = 0

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 and not isNil(var_31_34) and arg_28_1.var_.actorSpriteComps10035 == nil then
				arg_28_1.var_.actorSpriteComps10035 = var_31_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_36 = 0.2

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_36 and not isNil(var_31_34) then
				local var_31_37 = (arg_28_1.time_ - var_31_35) / var_31_36

				if arg_28_1.var_.actorSpriteComps10035 then
					for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_31_7 then
							if arg_28_1.isInRecall_ then
								local var_31_38 = Mathf.Lerp(iter_31_7.color.r, arg_28_1.hightColor2.r, var_31_37)
								local var_31_39 = Mathf.Lerp(iter_31_7.color.g, arg_28_1.hightColor2.g, var_31_37)
								local var_31_40 = Mathf.Lerp(iter_31_7.color.b, arg_28_1.hightColor2.b, var_31_37)

								iter_31_7.color = Color.New(var_31_38, var_31_39, var_31_40)
							else
								local var_31_41 = Mathf.Lerp(iter_31_7.color.r, 0.5, var_31_37)

								iter_31_7.color = Color.New(var_31_41, var_31_41, var_31_41)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_35 + var_31_36 and arg_28_1.time_ < var_31_35 + var_31_36 + arg_31_0 and not isNil(var_31_34) and arg_28_1.var_.actorSpriteComps10035 then
				for iter_31_8, iter_31_9 in pairs(arg_28_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_31_9 then
						if arg_28_1.isInRecall_ then
							iter_31_9.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10035 = nil
			end

			local var_31_42 = arg_28_1.actors_["10034"]
			local var_31_43 = 0

			if var_31_43 < arg_28_1.time_ and arg_28_1.time_ <= var_31_43 + arg_31_0 and not isNil(var_31_42) and arg_28_1.var_.actorSpriteComps10034 == nil then
				arg_28_1.var_.actorSpriteComps10034 = var_31_42:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_44 = 0.2

			if var_31_43 <= arg_28_1.time_ and arg_28_1.time_ < var_31_43 + var_31_44 and not isNil(var_31_42) then
				local var_31_45 = (arg_28_1.time_ - var_31_43) / var_31_44

				if arg_28_1.var_.actorSpriteComps10034 then
					for iter_31_10, iter_31_11 in pairs(arg_28_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_31_11 then
							if arg_28_1.isInRecall_ then
								local var_31_46 = Mathf.Lerp(iter_31_11.color.r, arg_28_1.hightColor1.r, var_31_45)
								local var_31_47 = Mathf.Lerp(iter_31_11.color.g, arg_28_1.hightColor1.g, var_31_45)
								local var_31_48 = Mathf.Lerp(iter_31_11.color.b, arg_28_1.hightColor1.b, var_31_45)

								iter_31_11.color = Color.New(var_31_46, var_31_47, var_31_48)
							else
								local var_31_49 = Mathf.Lerp(iter_31_11.color.r, 1, var_31_45)

								iter_31_11.color = Color.New(var_31_49, var_31_49, var_31_49)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_43 + var_31_44 and arg_28_1.time_ < var_31_43 + var_31_44 + arg_31_0 and not isNil(var_31_42) and arg_28_1.var_.actorSpriteComps10034 then
				for iter_31_12, iter_31_13 in pairs(arg_28_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_31_13 then
						if arg_28_1.isInRecall_ then
							iter_31_13.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_13.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10034 = nil
			end

			local var_31_50 = 0
			local var_31_51 = 0.55

			if var_31_50 < arg_28_1.time_ and arg_28_1.time_ <= var_31_50 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_52 = arg_28_1:FormatText(StoryNameCfg[367].name)

				arg_28_1.leftNameTxt_.text = var_31_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_53 = arg_28_1:GetWordFromCfg(117081006)
				local var_31_54 = arg_28_1:FormatText(var_31_53.content)

				arg_28_1.text_.text = var_31_54

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_55 = 22
				local var_31_56 = utf8.len(var_31_54)
				local var_31_57 = var_31_55 <= 0 and var_31_51 or var_31_51 * (var_31_56 / var_31_55)

				if var_31_57 > 0 and var_31_51 < var_31_57 then
					arg_28_1.talkMaxDuration = var_31_57

					if var_31_57 + var_31_50 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_57 + var_31_50
					end
				end

				arg_28_1.text_.text = var_31_54
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081006", "story_v_out_117081.awb") ~= 0 then
					local var_31_58 = manager.audio:GetVoiceLength("story_v_out_117081", "117081006", "story_v_out_117081.awb") / 1000

					if var_31_58 + var_31_50 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_58 + var_31_50
					end

					if var_31_53.prefab_name ~= "" and arg_28_1.actors_[var_31_53.prefab_name] ~= nil then
						local var_31_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_53.prefab_name].transform, "story_v_out_117081", "117081006", "story_v_out_117081.awb")

						arg_28_1:RecordAudio("117081006", var_31_59)
						arg_28_1:RecordAudio("117081006", var_31_59)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_117081", "117081006", "story_v_out_117081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_117081", "117081006", "story_v_out_117081.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_60 = math.max(var_31_51, arg_28_1.talkMaxDuration)

			if var_31_50 <= arg_28_1.time_ and arg_28_1.time_ < var_31_50 + var_31_60 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_50) / var_31_60

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_50 + var_31_60 and arg_28_1.time_ < var_31_50 + var_31_60 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play117081007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 117081007
		arg_32_1.duration_ = 6.03

		local var_32_0 = {
			zh = 3.1,
			ja = 6.033
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
				arg_32_0:Play117081008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10035"]
			local var_35_1 = 0.0333333333333333

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10035 == nil then
				arg_32_1.var_.actorSpriteComps10035 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10035 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 1, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10035 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10035 = nil
			end

			local var_35_8 = arg_32_1.actors_["10034"]
			local var_35_9 = 0.0333333333333333

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps10034 == nil then
				arg_32_1.var_.actorSpriteComps10034 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps10034 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 0.5, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps10034 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10034 = nil
			end

			local var_35_16 = 0
			local var_35_17 = 0.3

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[369].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(117081007)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 12
				local var_35_22 = utf8.len(var_35_20)
				local var_35_23 = var_35_21 <= 0 and var_35_17 or var_35_17 * (var_35_22 / var_35_21)

				if var_35_23 > 0 and var_35_17 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23

					if var_35_23 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081007", "story_v_out_117081.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081007", "story_v_out_117081.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_out_117081", "117081007", "story_v_out_117081.awb")

						arg_32_1:RecordAudio("117081007", var_35_25)
						arg_32_1:RecordAudio("117081007", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_117081", "117081007", "story_v_out_117081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_117081", "117081007", "story_v_out_117081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_26 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_26 and arg_32_1.time_ < var_35_16 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play117081008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 117081008
		arg_36_1.duration_ = 6.37

		local var_36_0 = {
			zh = 6.066,
			ja = 6.366
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
				arg_36_0:Play117081009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.8

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[369].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(117081008)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081008", "story_v_out_117081.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081008", "story_v_out_117081.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_117081", "117081008", "story_v_out_117081.awb")

						arg_36_1:RecordAudio("117081008", var_39_9)
						arg_36_1:RecordAudio("117081008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_117081", "117081008", "story_v_out_117081.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_117081", "117081008", "story_v_out_117081.awb")
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
	Play117081009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 117081009
		arg_40_1.duration_ = 4.7

		local var_40_0 = {
			zh = 3.966,
			ja = 4.7
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
				arg_40_0:Play117081010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10035"]
			local var_43_1 = 0.0333333333333333

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10035 == nil then
				arg_40_1.var_.actorSpriteComps10035 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10035 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 0.5, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10035 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10035 = nil
			end

			local var_43_8 = arg_40_1.actors_["10034"]
			local var_43_9 = 0.0333333333333333

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps10034 == nil then
				arg_40_1.var_.actorSpriteComps10034 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps10034 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								local var_43_12 = Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor1.r, var_43_11)
								local var_43_13 = Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor1.g, var_43_11)
								local var_43_14 = Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor1.b, var_43_11)

								iter_43_5.color = Color.New(var_43_12, var_43_13, var_43_14)
							else
								local var_43_15 = Mathf.Lerp(iter_43_5.color.r, 1, var_43_11)

								iter_43_5.color = Color.New(var_43_15, var_43_15, var_43_15)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps10034 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10034 = nil
			end

			local var_43_16 = 0
			local var_43_17 = 0.375

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_18 = arg_40_1:FormatText(StoryNameCfg[367].name)

				arg_40_1.leftNameTxt_.text = var_43_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_19 = arg_40_1:GetWordFromCfg(117081009)
				local var_43_20 = arg_40_1:FormatText(var_43_19.content)

				arg_40_1.text_.text = var_43_20

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_21 = 15
				local var_43_22 = utf8.len(var_43_20)
				local var_43_23 = var_43_21 <= 0 and var_43_17 or var_43_17 * (var_43_22 / var_43_21)

				if var_43_23 > 0 and var_43_17 < var_43_23 then
					arg_40_1.talkMaxDuration = var_43_23

					if var_43_23 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_16
					end
				end

				arg_40_1.text_.text = var_43_20
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081009", "story_v_out_117081.awb") ~= 0 then
					local var_43_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081009", "story_v_out_117081.awb") / 1000

					if var_43_24 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_24 + var_43_16
					end

					if var_43_19.prefab_name ~= "" and arg_40_1.actors_[var_43_19.prefab_name] ~= nil then
						local var_43_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_19.prefab_name].transform, "story_v_out_117081", "117081009", "story_v_out_117081.awb")

						arg_40_1:RecordAudio("117081009", var_43_25)
						arg_40_1:RecordAudio("117081009", var_43_25)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_117081", "117081009", "story_v_out_117081.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_117081", "117081009", "story_v_out_117081.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_26 = math.max(var_43_17, arg_40_1.talkMaxDuration)

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_26 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_16) / var_43_26

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_16 + var_43_26 and arg_40_1.time_ < var_43_16 + var_43_26 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play117081010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 117081010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play117081011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10034"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10034 == nil then
				arg_44_1.var_.actorSpriteComps10034 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps10034 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor2.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor2.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor2.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 0.5, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10034 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10034 = nil
			end

			local var_47_8 = 0
			local var_47_9 = 1

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				local var_47_10 = "play"
				local var_47_11 = "effect"

				arg_44_1:AudioAction(var_47_10, var_47_11, "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_47_12 = 0
			local var_47_13 = 0.475

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(117081010)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_16 = 19
				local var_47_17 = utf8.len(var_47_15)
				local var_47_18 = var_47_16 <= 0 and var_47_13 or var_47_13 * (var_47_17 / var_47_16)

				if var_47_18 > 0 and var_47_13 < var_47_18 then
					arg_44_1.talkMaxDuration = var_47_18

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_19 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_19 and arg_44_1.time_ < var_47_12 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play117081011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 117081011
		arg_48_1.duration_ = 3

		local var_48_0 = {
			zh = 2.4,
			ja = 3
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
				arg_48_0:Play117081012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10034"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10034 == nil then
				arg_48_1.var_.actorSpriteComps10034 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10034 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10034 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10034 = nil
			end

			local var_51_8 = 0
			local var_51_9 = 0.15

			if var_51_8 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_10 = arg_48_1:FormatText(StoryNameCfg[367].name)

				arg_48_1.leftNameTxt_.text = var_51_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_11 = arg_48_1:GetWordFromCfg(117081011)
				local var_51_12 = arg_48_1:FormatText(var_51_11.content)

				arg_48_1.text_.text = var_51_12

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 6
				local var_51_14 = utf8.len(var_51_12)
				local var_51_15 = var_51_13 <= 0 and var_51_9 or var_51_9 * (var_51_14 / var_51_13)

				if var_51_15 > 0 and var_51_9 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_12
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081011", "story_v_out_117081.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081011", "story_v_out_117081.awb") / 1000

					if var_51_16 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_8
					end

					if var_51_11.prefab_name ~= "" and arg_48_1.actors_[var_51_11.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_11.prefab_name].transform, "story_v_out_117081", "117081011", "story_v_out_117081.awb")

						arg_48_1:RecordAudio("117081011", var_51_17)
						arg_48_1:RecordAudio("117081011", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_117081", "117081011", "story_v_out_117081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_117081", "117081011", "story_v_out_117081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_18 and arg_48_1.time_ < var_51_8 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play117081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 117081012
		arg_52_1.duration_ = 2.17

		local var_52_0 = {
			zh = 2.166,
			ja = 1.4
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
				arg_52_0:Play117081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10035"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos10035 = var_55_0.localPosition
				var_55_0.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10035", 4)

				local var_55_2 = var_55_0.childCount

				for iter_55_0 = 0, var_55_2 - 1 do
					local var_55_3 = var_55_0:GetChild(iter_55_0)

					if var_55_3.name == "split_1" or not string.find(var_55_3.name, "split") then
						var_55_3.gameObject:SetActive(true)
					else
						var_55_3.gameObject:SetActive(false)
					end
				end
			end

			local var_55_4 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_4 then
				local var_55_5 = (arg_52_1.time_ - var_55_1) / var_55_4
				local var_55_6 = Vector3.New(390, -410, -235)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10035, var_55_6, var_55_5)
			end

			if arg_52_1.time_ >= var_55_1 + var_55_4 and arg_52_1.time_ < var_55_1 + var_55_4 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_55_7 = arg_52_1.actors_["10034"]
			local var_55_8 = 0

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.actorSpriteComps10034 == nil then
				arg_52_1.var_.actorSpriteComps10034 = var_55_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_9 = 0.2

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_9 and not isNil(var_55_7) then
				local var_55_10 = (arg_52_1.time_ - var_55_8) / var_55_9

				if arg_52_1.var_.actorSpriteComps10034 then
					for iter_55_1, iter_55_2 in pairs(arg_52_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_55_2 then
							if arg_52_1.isInRecall_ then
								local var_55_11 = Mathf.Lerp(iter_55_2.color.r, arg_52_1.hightColor2.r, var_55_10)
								local var_55_12 = Mathf.Lerp(iter_55_2.color.g, arg_52_1.hightColor2.g, var_55_10)
								local var_55_13 = Mathf.Lerp(iter_55_2.color.b, arg_52_1.hightColor2.b, var_55_10)

								iter_55_2.color = Color.New(var_55_11, var_55_12, var_55_13)
							else
								local var_55_14 = Mathf.Lerp(iter_55_2.color.r, 0.5, var_55_10)

								iter_55_2.color = Color.New(var_55_14, var_55_14, var_55_14)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_8 + var_55_9 and arg_52_1.time_ < var_55_8 + var_55_9 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.actorSpriteComps10034 then
				for iter_55_3, iter_55_4 in pairs(arg_52_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_55_4 then
						if arg_52_1.isInRecall_ then
							iter_55_4.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10034 = nil
			end

			local var_55_15 = arg_52_1.actors_["10035"]
			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 and not isNil(var_55_15) and arg_52_1.var_.actorSpriteComps10035 == nil then
				arg_52_1.var_.actorSpriteComps10035 = var_55_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_17 = 0.2

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 and not isNil(var_55_15) then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17

				if arg_52_1.var_.actorSpriteComps10035 then
					for iter_55_5, iter_55_6 in pairs(arg_52_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_55_6 then
							if arg_52_1.isInRecall_ then
								local var_55_19 = Mathf.Lerp(iter_55_6.color.r, arg_52_1.hightColor1.r, var_55_18)
								local var_55_20 = Mathf.Lerp(iter_55_6.color.g, arg_52_1.hightColor1.g, var_55_18)
								local var_55_21 = Mathf.Lerp(iter_55_6.color.b, arg_52_1.hightColor1.b, var_55_18)

								iter_55_6.color = Color.New(var_55_19, var_55_20, var_55_21)
							else
								local var_55_22 = Mathf.Lerp(iter_55_6.color.r, 1, var_55_18)

								iter_55_6.color = Color.New(var_55_22, var_55_22, var_55_22)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 and not isNil(var_55_15) and arg_52_1.var_.actorSpriteComps10035 then
				for iter_55_7, iter_55_8 in pairs(arg_52_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_55_8 then
						if arg_52_1.isInRecall_ then
							iter_55_8.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10035 = nil
			end

			local var_55_23 = 0
			local var_55_24 = 0.125

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_25 = arg_52_1:FormatText(StoryNameCfg[369].name)

				arg_52_1.leftNameTxt_.text = var_55_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_26 = arg_52_1:GetWordFromCfg(117081012)
				local var_55_27 = arg_52_1:FormatText(var_55_26.content)

				arg_52_1.text_.text = var_55_27

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_28 = 5
				local var_55_29 = utf8.len(var_55_27)
				local var_55_30 = var_55_28 <= 0 and var_55_24 or var_55_24 * (var_55_29 / var_55_28)

				if var_55_30 > 0 and var_55_24 < var_55_30 then
					arg_52_1.talkMaxDuration = var_55_30

					if var_55_30 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_30 + var_55_23
					end
				end

				arg_52_1.text_.text = var_55_27
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081012", "story_v_out_117081.awb") ~= 0 then
					local var_55_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081012", "story_v_out_117081.awb") / 1000

					if var_55_31 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_31 + var_55_23
					end

					if var_55_26.prefab_name ~= "" and arg_52_1.actors_[var_55_26.prefab_name] ~= nil then
						local var_55_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_26.prefab_name].transform, "story_v_out_117081", "117081012", "story_v_out_117081.awb")

						arg_52_1:RecordAudio("117081012", var_55_32)
						arg_52_1:RecordAudio("117081012", var_55_32)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_117081", "117081012", "story_v_out_117081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_117081", "117081012", "story_v_out_117081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_33 = math.max(var_55_24, arg_52_1.talkMaxDuration)

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_33 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_23) / var_55_33

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_23 + var_55_33 and arg_52_1.time_ < var_55_23 + var_55_33 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play117081013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 117081013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play117081014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10035"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10035 = var_59_0.localPosition
				var_59_0.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10035", 4)

				local var_59_2 = var_59_0.childCount

				for iter_59_0 = 0, var_59_2 - 1 do
					local var_59_3 = var_59_0:GetChild(iter_59_0)

					if var_59_3.name == "split_1" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_4 then
				local var_59_5 = (arg_56_1.time_ - var_59_1) / var_59_4
				local var_59_6 = Vector3.New(390, -410, -235)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10035, var_59_6, var_59_5)
			end

			if arg_56_1.time_ >= var_59_1 + var_59_4 and arg_56_1.time_ < var_59_1 + var_59_4 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_59_7 = arg_56_1.actors_["10035"]
			local var_59_8 = 0

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.actorSpriteComps10035 == nil then
				arg_56_1.var_.actorSpriteComps10035 = var_59_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_9 = 0.2

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_9 and not isNil(var_59_7) then
				local var_59_10 = (arg_56_1.time_ - var_59_8) / var_59_9

				if arg_56_1.var_.actorSpriteComps10035 then
					for iter_59_1, iter_59_2 in pairs(arg_56_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_59_2 then
							if arg_56_1.isInRecall_ then
								local var_59_11 = Mathf.Lerp(iter_59_2.color.r, arg_56_1.hightColor2.r, var_59_10)
								local var_59_12 = Mathf.Lerp(iter_59_2.color.g, arg_56_1.hightColor2.g, var_59_10)
								local var_59_13 = Mathf.Lerp(iter_59_2.color.b, arg_56_1.hightColor2.b, var_59_10)

								iter_59_2.color = Color.New(var_59_11, var_59_12, var_59_13)
							else
								local var_59_14 = Mathf.Lerp(iter_59_2.color.r, 0.5, var_59_10)

								iter_59_2.color = Color.New(var_59_14, var_59_14, var_59_14)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_8 + var_59_9 and arg_56_1.time_ < var_59_8 + var_59_9 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.actorSpriteComps10035 then
				for iter_59_3, iter_59_4 in pairs(arg_56_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_59_4 then
						if arg_56_1.isInRecall_ then
							iter_59_4.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10035 = nil
			end

			local var_59_15 = 0
			local var_59_16 = 1.15

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_17 = arg_56_1:GetWordFromCfg(117081013)
				local var_59_18 = arg_56_1:FormatText(var_59_17.content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_19 = 46
				local var_59_20 = utf8.len(var_59_18)
				local var_59_21 = var_59_19 <= 0 and var_59_16 or var_59_16 * (var_59_20 / var_59_19)

				if var_59_21 > 0 and var_59_16 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_22 and arg_56_1.time_ < var_59_15 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play117081014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 117081014
		arg_60_1.duration_ = 5.67

		local var_60_0 = {
			zh = 5.666,
			ja = 4.333
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play117081015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10034"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10034 = var_63_0.localPosition
				var_63_0.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("10034", 2)

				local var_63_2 = var_63_0.childCount

				for iter_63_0 = 0, var_63_2 - 1 do
					local var_63_3 = var_63_0:GetChild(iter_63_0)

					if var_63_3.name == "split_2" or not string.find(var_63_3.name, "split") then
						var_63_3.gameObject:SetActive(true)
					else
						var_63_3.gameObject:SetActive(false)
					end
				end
			end

			local var_63_4 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_4 then
				local var_63_5 = (arg_60_1.time_ - var_63_1) / var_63_4
				local var_63_6 = Vector3.New(-390, -415, -290)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10034, var_63_6, var_63_5)
			end

			if arg_60_1.time_ >= var_63_1 + var_63_4 and arg_60_1.time_ < var_63_1 + var_63_4 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_63_7 = arg_60_1.actors_["10034"]
			local var_63_8 = 0

			if var_63_8 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.actorSpriteComps10034 == nil then
				arg_60_1.var_.actorSpriteComps10034 = var_63_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_9 = 0.2

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_9 and not isNil(var_63_7) then
				local var_63_10 = (arg_60_1.time_ - var_63_8) / var_63_9

				if arg_60_1.var_.actorSpriteComps10034 then
					for iter_63_1, iter_63_2 in pairs(arg_60_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_63_2 then
							if arg_60_1.isInRecall_ then
								local var_63_11 = Mathf.Lerp(iter_63_2.color.r, arg_60_1.hightColor1.r, var_63_10)
								local var_63_12 = Mathf.Lerp(iter_63_2.color.g, arg_60_1.hightColor1.g, var_63_10)
								local var_63_13 = Mathf.Lerp(iter_63_2.color.b, arg_60_1.hightColor1.b, var_63_10)

								iter_63_2.color = Color.New(var_63_11, var_63_12, var_63_13)
							else
								local var_63_14 = Mathf.Lerp(iter_63_2.color.r, 1, var_63_10)

								iter_63_2.color = Color.New(var_63_14, var_63_14, var_63_14)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_8 + var_63_9 and arg_60_1.time_ < var_63_8 + var_63_9 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.actorSpriteComps10034 then
				for iter_63_3, iter_63_4 in pairs(arg_60_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_63_4 then
						if arg_60_1.isInRecall_ then
							iter_63_4.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10034 = nil
			end

			local var_63_15 = 0
			local var_63_16 = 0.425

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[367].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(117081014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 17
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081014", "story_v_out_117081.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_117081", "117081014", "story_v_out_117081.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_117081", "117081014", "story_v_out_117081.awb")

						arg_60_1:RecordAudio("117081014", var_63_24)
						arg_60_1:RecordAudio("117081014", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_117081", "117081014", "story_v_out_117081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_117081", "117081014", "story_v_out_117081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play117081015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 117081015
		arg_64_1.duration_ = 3.3

		local var_64_0 = {
			zh = 3.3,
			ja = 2.8
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play117081016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10035"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10035 = var_67_0.localPosition
				var_67_0.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10035", 4)

				local var_67_2 = var_67_0.childCount

				for iter_67_0 = 0, var_67_2 - 1 do
					local var_67_3 = var_67_0:GetChild(iter_67_0)

					if var_67_3.name == "split_4" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_4 then
				local var_67_5 = (arg_64_1.time_ - var_67_1) / var_67_4
				local var_67_6 = Vector3.New(390, -410, -235)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10035, var_67_6, var_67_5)
			end

			if arg_64_1.time_ >= var_67_1 + var_67_4 and arg_64_1.time_ < var_67_1 + var_67_4 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_67_7 = arg_64_1.actors_["10035"]
			local var_67_8 = 0

			if var_67_8 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.actorSpriteComps10035 == nil then
				arg_64_1.var_.actorSpriteComps10035 = var_67_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_9 = 0.2

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_9 and not isNil(var_67_7) then
				local var_67_10 = (arg_64_1.time_ - var_67_8) / var_67_9

				if arg_64_1.var_.actorSpriteComps10035 then
					for iter_67_1, iter_67_2 in pairs(arg_64_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_67_2 then
							if arg_64_1.isInRecall_ then
								local var_67_11 = Mathf.Lerp(iter_67_2.color.r, arg_64_1.hightColor1.r, var_67_10)
								local var_67_12 = Mathf.Lerp(iter_67_2.color.g, arg_64_1.hightColor1.g, var_67_10)
								local var_67_13 = Mathf.Lerp(iter_67_2.color.b, arg_64_1.hightColor1.b, var_67_10)

								iter_67_2.color = Color.New(var_67_11, var_67_12, var_67_13)
							else
								local var_67_14 = Mathf.Lerp(iter_67_2.color.r, 1, var_67_10)

								iter_67_2.color = Color.New(var_67_14, var_67_14, var_67_14)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_8 + var_67_9 and arg_64_1.time_ < var_67_8 + var_67_9 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.actorSpriteComps10035 then
				for iter_67_3, iter_67_4 in pairs(arg_64_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_67_4 then
						if arg_64_1.isInRecall_ then
							iter_67_4.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10035 = nil
			end

			local var_67_15 = arg_64_1.actors_["10034"]
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.actorSpriteComps10034 == nil then
				arg_64_1.var_.actorSpriteComps10034 = var_67_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_17 = 0.2

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_17 and not isNil(var_67_15) then
				local var_67_18 = (arg_64_1.time_ - var_67_16) / var_67_17

				if arg_64_1.var_.actorSpriteComps10034 then
					for iter_67_5, iter_67_6 in pairs(arg_64_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_67_6 then
							if arg_64_1.isInRecall_ then
								local var_67_19 = Mathf.Lerp(iter_67_6.color.r, arg_64_1.hightColor2.r, var_67_18)
								local var_67_20 = Mathf.Lerp(iter_67_6.color.g, arg_64_1.hightColor2.g, var_67_18)
								local var_67_21 = Mathf.Lerp(iter_67_6.color.b, arg_64_1.hightColor2.b, var_67_18)

								iter_67_6.color = Color.New(var_67_19, var_67_20, var_67_21)
							else
								local var_67_22 = Mathf.Lerp(iter_67_6.color.r, 0.5, var_67_18)

								iter_67_6.color = Color.New(var_67_22, var_67_22, var_67_22)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.actorSpriteComps10034 then
				for iter_67_7, iter_67_8 in pairs(arg_64_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_67_8 then
						if arg_64_1.isInRecall_ then
							iter_67_8.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10034 = nil
			end

			local var_67_23 = 0
			local var_67_24 = 0.275

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_25 = arg_64_1:FormatText(StoryNameCfg[369].name)

				arg_64_1.leftNameTxt_.text = var_67_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(117081015)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 11
				local var_67_29 = utf8.len(var_67_27)
				local var_67_30 = var_67_28 <= 0 and var_67_24 or var_67_24 * (var_67_29 / var_67_28)

				if var_67_30 > 0 and var_67_24 < var_67_30 then
					arg_64_1.talkMaxDuration = var_67_30

					if var_67_30 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_30 + var_67_23
					end
				end

				arg_64_1.text_.text = var_67_27
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081015", "story_v_out_117081.awb") ~= 0 then
					local var_67_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081015", "story_v_out_117081.awb") / 1000

					if var_67_31 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_23
					end

					if var_67_26.prefab_name ~= "" and arg_64_1.actors_[var_67_26.prefab_name] ~= nil then
						local var_67_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_26.prefab_name].transform, "story_v_out_117081", "117081015", "story_v_out_117081.awb")

						arg_64_1:RecordAudio("117081015", var_67_32)
						arg_64_1:RecordAudio("117081015", var_67_32)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_117081", "117081015", "story_v_out_117081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_117081", "117081015", "story_v_out_117081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_24, arg_64_1.talkMaxDuration)

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_23) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_23 + var_67_33 and arg_64_1.time_ < var_67_23 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play117081016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 117081016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play117081017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10035"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10035 == nil then
				arg_68_1.var_.actorSpriteComps10035 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10035 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								local var_71_4 = Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, var_71_3)
								local var_71_5 = Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, var_71_3)
								local var_71_6 = Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, var_71_3)

								iter_71_1.color = Color.New(var_71_4, var_71_5, var_71_6)
							else
								local var_71_7 = Mathf.Lerp(iter_71_1.color.r, 0.5, var_71_3)

								iter_71_1.color = Color.New(var_71_7, var_71_7, var_71_7)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10035 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10035 = nil
			end

			local var_71_8 = 0
			local var_71_9 = 1.4

			if var_71_8 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(117081016)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_12 = 56
				local var_71_13 = utf8.len(var_71_11)
				local var_71_14 = var_71_12 <= 0 and var_71_9 or var_71_9 * (var_71_13 / var_71_12)

				if var_71_14 > 0 and var_71_9 < var_71_14 then
					arg_68_1.talkMaxDuration = var_71_14

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_15 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_15

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_15 and arg_68_1.time_ < var_71_8 + var_71_15 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play117081017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 117081017
		arg_72_1.duration_ = 3.93

		local var_72_0 = {
			zh = 3.933,
			ja = 1.033
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play117081018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "1132"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(var_75_1, arg_72_1.canvasGo_.transform)

					var_75_2.transform:SetSiblingIndex(1)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_72_1.isInRecall_ then
						for iter_75_0, iter_75_1 in ipairs(var_75_3) do
							iter_75_1.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_75_4 = arg_72_1.actors_["1132"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1132 = var_75_4.localPosition
				var_75_4.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1132", 2)

				local var_75_6 = var_75_4.childCount

				for iter_75_2 = 0, var_75_6 - 1 do
					local var_75_7 = var_75_4:GetChild(iter_75_2)

					if var_75_7.name == "split_6" or not string.find(var_75_7.name, "split") then
						var_75_7.gameObject:SetActive(true)
					else
						var_75_7.gameObject:SetActive(false)
					end
				end
			end

			local var_75_8 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_5) / var_75_8
				local var_75_10 = Vector3.New(-390, -413, -185)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1132, var_75_10, var_75_9)
			end

			if arg_72_1.time_ >= var_75_5 + var_75_8 and arg_72_1.time_ < var_75_5 + var_75_8 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_75_11 = arg_72_1.actors_["1132"]
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.actorSpriteComps1132 == nil then
				arg_72_1.var_.actorSpriteComps1132 = var_75_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_13 = 0.2

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 and not isNil(var_75_11) then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13

				if arg_72_1.var_.actorSpriteComps1132 then
					for iter_75_3, iter_75_4 in pairs(arg_72_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_75_4 then
							if arg_72_1.isInRecall_ then
								local var_75_15 = Mathf.Lerp(iter_75_4.color.r, arg_72_1.hightColor1.r, var_75_14)
								local var_75_16 = Mathf.Lerp(iter_75_4.color.g, arg_72_1.hightColor1.g, var_75_14)
								local var_75_17 = Mathf.Lerp(iter_75_4.color.b, arg_72_1.hightColor1.b, var_75_14)

								iter_75_4.color = Color.New(var_75_15, var_75_16, var_75_17)
							else
								local var_75_18 = Mathf.Lerp(iter_75_4.color.r, 1, var_75_14)

								iter_75_4.color = Color.New(var_75_18, var_75_18, var_75_18)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.actorSpriteComps1132 then
				for iter_75_5, iter_75_6 in pairs(arg_72_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_75_6 then
						if arg_72_1.isInRecall_ then
							iter_75_6.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1132 = nil
			end

			local var_75_19 = 0
			local var_75_20 = 0.5

			if var_75_19 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_21 = arg_72_1:FormatText(StoryNameCfg[61].name)

				arg_72_1.leftNameTxt_.text = var_75_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_22 = arg_72_1:GetWordFromCfg(117081017)
				local var_75_23 = arg_72_1:FormatText(var_75_22.content)

				arg_72_1.text_.text = var_75_23

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_24 = 20
				local var_75_25 = utf8.len(var_75_23)
				local var_75_26 = var_75_24 <= 0 and var_75_20 or var_75_20 * (var_75_25 / var_75_24)

				if var_75_26 > 0 and var_75_20 < var_75_26 then
					arg_72_1.talkMaxDuration = var_75_26

					if var_75_26 + var_75_19 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_26 + var_75_19
					end
				end

				arg_72_1.text_.text = var_75_23
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081017", "story_v_out_117081.awb") ~= 0 then
					local var_75_27 = manager.audio:GetVoiceLength("story_v_out_117081", "117081017", "story_v_out_117081.awb") / 1000

					if var_75_27 + var_75_19 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_27 + var_75_19
					end

					if var_75_22.prefab_name ~= "" and arg_72_1.actors_[var_75_22.prefab_name] ~= nil then
						local var_75_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_22.prefab_name].transform, "story_v_out_117081", "117081017", "story_v_out_117081.awb")

						arg_72_1:RecordAudio("117081017", var_75_28)
						arg_72_1:RecordAudio("117081017", var_75_28)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_117081", "117081017", "story_v_out_117081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_117081", "117081017", "story_v_out_117081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_29 = math.max(var_75_20, arg_72_1.talkMaxDuration)

			if var_75_19 <= arg_72_1.time_ and arg_72_1.time_ < var_75_19 + var_75_29 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_19) / var_75_29

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_19 + var_75_29 and arg_72_1.time_ < var_75_19 + var_75_29 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play117081018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 117081018
		arg_76_1.duration_ = 2.23

		local var_76_0 = {
			zh = 2.233,
			ja = 1.233
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play117081019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10035"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10035 = var_79_0.localPosition
				var_79_0.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10035", 4)

				local var_79_2 = var_79_0.childCount

				for iter_79_0 = 0, var_79_2 - 1 do
					local var_79_3 = var_79_0:GetChild(iter_79_0)

					if var_79_3.name == "split_4" or not string.find(var_79_3.name, "split") then
						var_79_3.gameObject:SetActive(true)
					else
						var_79_3.gameObject:SetActive(false)
					end
				end
			end

			local var_79_4 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_4 then
				local var_79_5 = (arg_76_1.time_ - var_79_1) / var_79_4
				local var_79_6 = Vector3.New(390, -410, -235)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10035, var_79_6, var_79_5)
			end

			if arg_76_1.time_ >= var_79_1 + var_79_4 and arg_76_1.time_ < var_79_1 + var_79_4 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_79_7 = arg_76_1.actors_["1132"]
			local var_79_8 = 0

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 and not isNil(var_79_7) and arg_76_1.var_.actorSpriteComps1132 == nil then
				arg_76_1.var_.actorSpriteComps1132 = var_79_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_9 = 0.2

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_9 and not isNil(var_79_7) then
				local var_79_10 = (arg_76_1.time_ - var_79_8) / var_79_9

				if arg_76_1.var_.actorSpriteComps1132 then
					for iter_79_1, iter_79_2 in pairs(arg_76_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_79_2 then
							if arg_76_1.isInRecall_ then
								local var_79_11 = Mathf.Lerp(iter_79_2.color.r, arg_76_1.hightColor2.r, var_79_10)
								local var_79_12 = Mathf.Lerp(iter_79_2.color.g, arg_76_1.hightColor2.g, var_79_10)
								local var_79_13 = Mathf.Lerp(iter_79_2.color.b, arg_76_1.hightColor2.b, var_79_10)

								iter_79_2.color = Color.New(var_79_11, var_79_12, var_79_13)
							else
								local var_79_14 = Mathf.Lerp(iter_79_2.color.r, 0.5, var_79_10)

								iter_79_2.color = Color.New(var_79_14, var_79_14, var_79_14)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_8 + var_79_9 and arg_76_1.time_ < var_79_8 + var_79_9 + arg_79_0 and not isNil(var_79_7) and arg_76_1.var_.actorSpriteComps1132 then
				for iter_79_3, iter_79_4 in pairs(arg_76_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_79_4 then
						if arg_76_1.isInRecall_ then
							iter_79_4.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1132 = nil
			end

			local var_79_15 = arg_76_1.actors_["10035"]
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.actorSpriteComps10035 == nil then
				arg_76_1.var_.actorSpriteComps10035 = var_79_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_17 = 0.2

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 and not isNil(var_79_15) then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17

				if arg_76_1.var_.actorSpriteComps10035 then
					for iter_79_5, iter_79_6 in pairs(arg_76_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_79_6 then
							if arg_76_1.isInRecall_ then
								local var_79_19 = Mathf.Lerp(iter_79_6.color.r, arg_76_1.hightColor1.r, var_79_18)
								local var_79_20 = Mathf.Lerp(iter_79_6.color.g, arg_76_1.hightColor1.g, var_79_18)
								local var_79_21 = Mathf.Lerp(iter_79_6.color.b, arg_76_1.hightColor1.b, var_79_18)

								iter_79_6.color = Color.New(var_79_19, var_79_20, var_79_21)
							else
								local var_79_22 = Mathf.Lerp(iter_79_6.color.r, 1, var_79_18)

								iter_79_6.color = Color.New(var_79_22, var_79_22, var_79_22)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.actorSpriteComps10035 then
				for iter_79_7, iter_79_8 in pairs(arg_76_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_79_8 then
						if arg_76_1.isInRecall_ then
							iter_79_8.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10035 = nil
			end

			local var_79_23 = 0
			local var_79_24 = 0.075

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[369].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(117081018)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 3
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081018", "story_v_out_117081.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081018", "story_v_out_117081.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_out_117081", "117081018", "story_v_out_117081.awb")

						arg_76_1:RecordAudio("117081018", var_79_32)
						arg_76_1:RecordAudio("117081018", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_117081", "117081018", "story_v_out_117081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_117081", "117081018", "story_v_out_117081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play117081019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 117081019
		arg_80_1.duration_ = 7.13

		local var_80_0 = {
			zh = 4.666,
			ja = 7.133
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play117081020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10034"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10034 = var_83_0.localPosition
				var_83_0.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10034", 4)

				local var_83_2 = var_83_0.childCount

				for iter_83_0 = 0, var_83_2 - 1 do
					local var_83_3 = var_83_0:GetChild(iter_83_0)

					if var_83_3.name == "split_2" or not string.find(var_83_3.name, "split") then
						var_83_3.gameObject:SetActive(true)
					else
						var_83_3.gameObject:SetActive(false)
					end
				end
			end

			local var_83_4 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_4 then
				local var_83_5 = (arg_80_1.time_ - var_83_1) / var_83_4
				local var_83_6 = Vector3.New(390, -415, -290)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10034, var_83_6, var_83_5)
			end

			if arg_80_1.time_ >= var_83_1 + var_83_4 and arg_80_1.time_ < var_83_1 + var_83_4 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_83_7 = arg_80_1.actors_["10034"]
			local var_83_8 = 0

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.actorSpriteComps10034 == nil then
				arg_80_1.var_.actorSpriteComps10034 = var_83_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_9 = 0.2

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_9 and not isNil(var_83_7) then
				local var_83_10 = (arg_80_1.time_ - var_83_8) / var_83_9

				if arg_80_1.var_.actorSpriteComps10034 then
					for iter_83_1, iter_83_2 in pairs(arg_80_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_83_2 then
							if arg_80_1.isInRecall_ then
								local var_83_11 = Mathf.Lerp(iter_83_2.color.r, arg_80_1.hightColor1.r, var_83_10)
								local var_83_12 = Mathf.Lerp(iter_83_2.color.g, arg_80_1.hightColor1.g, var_83_10)
								local var_83_13 = Mathf.Lerp(iter_83_2.color.b, arg_80_1.hightColor1.b, var_83_10)

								iter_83_2.color = Color.New(var_83_11, var_83_12, var_83_13)
							else
								local var_83_14 = Mathf.Lerp(iter_83_2.color.r, 1, var_83_10)

								iter_83_2.color = Color.New(var_83_14, var_83_14, var_83_14)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_8 + var_83_9 and arg_80_1.time_ < var_83_8 + var_83_9 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.actorSpriteComps10034 then
				for iter_83_3, iter_83_4 in pairs(arg_80_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_83_4 then
						if arg_80_1.isInRecall_ then
							iter_83_4.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10034 = nil
			end

			local var_83_15 = 0
			local var_83_16 = 0.45

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[367].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_18 = arg_80_1:GetWordFromCfg(117081019)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 18
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_16 or var_83_16 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_16 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22

					if var_83_22 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081019", "story_v_out_117081.awb") ~= 0 then
					local var_83_23 = manager.audio:GetVoiceLength("story_v_out_117081", "117081019", "story_v_out_117081.awb") / 1000

					if var_83_23 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_15
					end

					if var_83_18.prefab_name ~= "" and arg_80_1.actors_[var_83_18.prefab_name] ~= nil then
						local var_83_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_18.prefab_name].transform, "story_v_out_117081", "117081019", "story_v_out_117081.awb")

						arg_80_1:RecordAudio("117081019", var_83_24)
						arg_80_1:RecordAudio("117081019", var_83_24)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_117081", "117081019", "story_v_out_117081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_117081", "117081019", "story_v_out_117081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_25 and arg_80_1.time_ < var_83_15 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play117081020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 117081020
		arg_84_1.duration_ = 11.7

		local var_84_0 = {
			zh = 11.7,
			ja = 11.566
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play117081021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1132"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1132 = var_87_0.localPosition
				var_87_0.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1132", 2)

				local var_87_2 = var_87_0.childCount

				for iter_87_0 = 0, var_87_2 - 1 do
					local var_87_3 = var_87_0:GetChild(iter_87_0)

					if var_87_3.name == "split_6" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_4 then
				local var_87_5 = (arg_84_1.time_ - var_87_1) / var_87_4
				local var_87_6 = Vector3.New(-390, -413, -185)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1132, var_87_6, var_87_5)
			end

			if arg_84_1.time_ >= var_87_1 + var_87_4 and arg_84_1.time_ < var_87_1 + var_87_4 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_87_7 = arg_84_1.actors_["10034"]
			local var_87_8 = 0

			if var_87_8 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.actorSpriteComps10034 == nil then
				arg_84_1.var_.actorSpriteComps10034 = var_87_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_9 = 0.2

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_9 and not isNil(var_87_7) then
				local var_87_10 = (arg_84_1.time_ - var_87_8) / var_87_9

				if arg_84_1.var_.actorSpriteComps10034 then
					for iter_87_1, iter_87_2 in pairs(arg_84_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_87_2 then
							if arg_84_1.isInRecall_ then
								local var_87_11 = Mathf.Lerp(iter_87_2.color.r, arg_84_1.hightColor2.r, var_87_10)
								local var_87_12 = Mathf.Lerp(iter_87_2.color.g, arg_84_1.hightColor2.g, var_87_10)
								local var_87_13 = Mathf.Lerp(iter_87_2.color.b, arg_84_1.hightColor2.b, var_87_10)

								iter_87_2.color = Color.New(var_87_11, var_87_12, var_87_13)
							else
								local var_87_14 = Mathf.Lerp(iter_87_2.color.r, 0.5, var_87_10)

								iter_87_2.color = Color.New(var_87_14, var_87_14, var_87_14)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_8 + var_87_9 and arg_84_1.time_ < var_87_8 + var_87_9 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.actorSpriteComps10034 then
				for iter_87_3, iter_87_4 in pairs(arg_84_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_87_4 then
						if arg_84_1.isInRecall_ then
							iter_87_4.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10034 = nil
			end

			local var_87_15 = arg_84_1.actors_["1132"]
			local var_87_16 = 0

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 and not isNil(var_87_15) and arg_84_1.var_.actorSpriteComps1132 == nil then
				arg_84_1.var_.actorSpriteComps1132 = var_87_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_17 = 0.2

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_17 and not isNil(var_87_15) then
				local var_87_18 = (arg_84_1.time_ - var_87_16) / var_87_17

				if arg_84_1.var_.actorSpriteComps1132 then
					for iter_87_5, iter_87_6 in pairs(arg_84_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_87_6 then
							if arg_84_1.isInRecall_ then
								local var_87_19 = Mathf.Lerp(iter_87_6.color.r, arg_84_1.hightColor1.r, var_87_18)
								local var_87_20 = Mathf.Lerp(iter_87_6.color.g, arg_84_1.hightColor1.g, var_87_18)
								local var_87_21 = Mathf.Lerp(iter_87_6.color.b, arg_84_1.hightColor1.b, var_87_18)

								iter_87_6.color = Color.New(var_87_19, var_87_20, var_87_21)
							else
								local var_87_22 = Mathf.Lerp(iter_87_6.color.r, 1, var_87_18)

								iter_87_6.color = Color.New(var_87_22, var_87_22, var_87_22)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_16 + var_87_17 and arg_84_1.time_ < var_87_16 + var_87_17 + arg_87_0 and not isNil(var_87_15) and arg_84_1.var_.actorSpriteComps1132 then
				for iter_87_7, iter_87_8 in pairs(arg_84_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_87_8 then
						if arg_84_1.isInRecall_ then
							iter_87_8.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1132 = nil
			end

			local var_87_23 = 0
			local var_87_24 = 1.175

			if var_87_23 < arg_84_1.time_ and arg_84_1.time_ <= var_87_23 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_25 = arg_84_1:FormatText(StoryNameCfg[61].name)

				arg_84_1.leftNameTxt_.text = var_87_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_26 = arg_84_1:GetWordFromCfg(117081020)
				local var_87_27 = arg_84_1:FormatText(var_87_26.content)

				arg_84_1.text_.text = var_87_27

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_28 = 46
				local var_87_29 = utf8.len(var_87_27)
				local var_87_30 = var_87_28 <= 0 and var_87_24 or var_87_24 * (var_87_29 / var_87_28)

				if var_87_30 > 0 and var_87_24 < var_87_30 then
					arg_84_1.talkMaxDuration = var_87_30

					if var_87_30 + var_87_23 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_30 + var_87_23
					end
				end

				arg_84_1.text_.text = var_87_27
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081020", "story_v_out_117081.awb") ~= 0 then
					local var_87_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081020", "story_v_out_117081.awb") / 1000

					if var_87_31 + var_87_23 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_31 + var_87_23
					end

					if var_87_26.prefab_name ~= "" and arg_84_1.actors_[var_87_26.prefab_name] ~= nil then
						local var_87_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_26.prefab_name].transform, "story_v_out_117081", "117081020", "story_v_out_117081.awb")

						arg_84_1:RecordAudio("117081020", var_87_32)
						arg_84_1:RecordAudio("117081020", var_87_32)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_117081", "117081020", "story_v_out_117081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_117081", "117081020", "story_v_out_117081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_33 = math.max(var_87_24, arg_84_1.talkMaxDuration)

			if var_87_23 <= arg_84_1.time_ and arg_84_1.time_ < var_87_23 + var_87_33 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_23) / var_87_33

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_23 + var_87_33 and arg_84_1.time_ < var_87_23 + var_87_33 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play117081021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 117081021
		arg_88_1.duration_ = 6.13

		local var_88_0 = {
			zh = 2.433,
			ja = 6.133
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play117081022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10034"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10034 == nil then
				arg_88_1.var_.actorSpriteComps10034 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps10034 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 1, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps10034 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10034 = nil
			end

			local var_91_8 = arg_88_1.actors_["1132"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1132 == nil then
				arg_88_1.var_.actorSpriteComps1132 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps1132 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								local var_91_12 = Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, var_91_11)
								local var_91_13 = Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, var_91_11)
								local var_91_14 = Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, var_91_11)

								iter_91_5.color = Color.New(var_91_12, var_91_13, var_91_14)
							else
								local var_91_15 = Mathf.Lerp(iter_91_5.color.r, 0.5, var_91_11)

								iter_91_5.color = Color.New(var_91_15, var_91_15, var_91_15)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1132 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1132 = nil
			end

			local var_91_16 = 0
			local var_91_17 = 0.25

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_18 = arg_88_1:FormatText(StoryNameCfg[367].name)

				arg_88_1.leftNameTxt_.text = var_91_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(117081021)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 10
				local var_91_22 = utf8.len(var_91_20)
				local var_91_23 = var_91_21 <= 0 and var_91_17 or var_91_17 * (var_91_22 / var_91_21)

				if var_91_23 > 0 and var_91_17 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081021", "story_v_out_117081.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081021", "story_v_out_117081.awb") / 1000

					if var_91_24 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_16
					end

					if var_91_19.prefab_name ~= "" and arg_88_1.actors_[var_91_19.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_19.prefab_name].transform, "story_v_out_117081", "117081021", "story_v_out_117081.awb")

						arg_88_1:RecordAudio("117081021", var_91_25)
						arg_88_1:RecordAudio("117081021", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_117081", "117081021", "story_v_out_117081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_117081", "117081021", "story_v_out_117081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_26 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_26 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_16) / var_91_26

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_16 + var_91_26 and arg_88_1.time_ < var_91_16 + var_91_26 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play117081022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 117081022
		arg_92_1.duration_ = 5.27

		local var_92_0 = {
			zh = 2.3,
			ja = 5.266
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play117081023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10034"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10034 == nil then
				arg_92_1.var_.actorSpriteComps10034 = var_95_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.actorSpriteComps10034 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								local var_95_4 = Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, var_95_3)
								local var_95_5 = Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, var_95_3)
								local var_95_6 = Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, var_95_3)

								iter_95_1.color = Color.New(var_95_4, var_95_5, var_95_6)
							else
								local var_95_7 = Mathf.Lerp(iter_95_1.color.r, 0.5, var_95_3)

								iter_95_1.color = Color.New(var_95_7, var_95_7, var_95_7)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.actorSpriteComps10034 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_95_3 then
						if arg_92_1.isInRecall_ then
							iter_95_3.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10034 = nil
			end

			local var_95_8 = arg_92_1.actors_["1132"]
			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1132 == nil then
				arg_92_1.var_.actorSpriteComps1132 = var_95_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_10 = 0.2

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_10 and not isNil(var_95_8) then
				local var_95_11 = (arg_92_1.time_ - var_95_9) / var_95_10

				if arg_92_1.var_.actorSpriteComps1132 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								local var_95_12 = Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor1.r, var_95_11)
								local var_95_13 = Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor1.g, var_95_11)
								local var_95_14 = Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor1.b, var_95_11)

								iter_95_5.color = Color.New(var_95_12, var_95_13, var_95_14)
							else
								local var_95_15 = Mathf.Lerp(iter_95_5.color.r, 1, var_95_11)

								iter_95_5.color = Color.New(var_95_15, var_95_15, var_95_15)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_9 + var_95_10 and arg_92_1.time_ < var_95_9 + var_95_10 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.actorSpriteComps1132 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_95_7 then
						if arg_92_1.isInRecall_ then
							iter_95_7.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1132 = nil
			end

			local var_95_16 = 0
			local var_95_17 = 0.375

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_18 = arg_92_1:FormatText(StoryNameCfg[61].name)

				arg_92_1.leftNameTxt_.text = var_95_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_19 = arg_92_1:GetWordFromCfg(117081022)
				local var_95_20 = arg_92_1:FormatText(var_95_19.content)

				arg_92_1.text_.text = var_95_20

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_21 = 15
				local var_95_22 = utf8.len(var_95_20)
				local var_95_23 = var_95_21 <= 0 and var_95_17 or var_95_17 * (var_95_22 / var_95_21)

				if var_95_23 > 0 and var_95_17 < var_95_23 then
					arg_92_1.talkMaxDuration = var_95_23

					if var_95_23 + var_95_16 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_16
					end
				end

				arg_92_1.text_.text = var_95_20
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081022", "story_v_out_117081.awb") ~= 0 then
					local var_95_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081022", "story_v_out_117081.awb") / 1000

					if var_95_24 + var_95_16 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_16
					end

					if var_95_19.prefab_name ~= "" and arg_92_1.actors_[var_95_19.prefab_name] ~= nil then
						local var_95_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_19.prefab_name].transform, "story_v_out_117081", "117081022", "story_v_out_117081.awb")

						arg_92_1:RecordAudio("117081022", var_95_25)
						arg_92_1:RecordAudio("117081022", var_95_25)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_117081", "117081022", "story_v_out_117081.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_117081", "117081022", "story_v_out_117081.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_26 = math.max(var_95_17, arg_92_1.talkMaxDuration)

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_26 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_16) / var_95_26

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_16 + var_95_26 and arg_92_1.time_ < var_95_16 + var_95_26 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play117081023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 117081023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play117081024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1132"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1132 == nil then
				arg_96_1.var_.actorSpriteComps1132 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps1132 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1132 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1132 = nil
			end

			local var_99_8 = 0
			local var_99_9 = 0.925

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(117081023)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 37
				local var_99_13 = utf8.len(var_99_11)
				local var_99_14 = var_99_12 <= 0 and var_99_9 or var_99_9 * (var_99_13 / var_99_12)

				if var_99_14 > 0 and var_99_9 < var_99_14 then
					arg_96_1.talkMaxDuration = var_99_14

					if var_99_14 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_15 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_15 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_15

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_15 and arg_96_1.time_ < var_99_8 + var_99_15 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play117081024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 117081024
		arg_100_1.duration_ = 6.33

		local var_100_0 = {
			zh = 6.333,
			ja = 5.933
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play117081025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10034"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10034 == nil then
				arg_100_1.var_.actorSpriteComps10034 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps10034 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 1, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10034 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10034 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 0.525

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[367].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_11 = arg_100_1:GetWordFromCfg(117081024)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 21
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081024", "story_v_out_117081.awb") ~= 0 then
					local var_103_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081024", "story_v_out_117081.awb") / 1000

					if var_103_16 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_16 + var_103_8
					end

					if var_103_11.prefab_name ~= "" and arg_100_1.actors_[var_103_11.prefab_name] ~= nil then
						local var_103_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_11.prefab_name].transform, "story_v_out_117081", "117081024", "story_v_out_117081.awb")

						arg_100_1:RecordAudio("117081024", var_103_17)
						arg_100_1:RecordAudio("117081024", var_103_17)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_117081", "117081024", "story_v_out_117081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_117081", "117081024", "story_v_out_117081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_18 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_18 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_18

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_18 and arg_100_1.time_ < var_103_8 + var_103_18 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play117081025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 117081025
		arg_104_1.duration_ = 5.1

		local var_104_0 = {
			zh = 5.1,
			ja = 2.7
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play117081026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10034"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10034 == nil then
				arg_104_1.var_.actorSpriteComps10034 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10034 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 0.5, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10034 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10034 = nil
			end

			local var_107_8 = 0
			local var_107_9 = 0.6

			if var_107_8 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_10 = arg_104_1:FormatText(StoryNameCfg[369].name)

				arg_104_1.leftNameTxt_.text = var_107_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_1")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_11 = arg_104_1:GetWordFromCfg(117081025)
				local var_107_12 = arg_104_1:FormatText(var_107_11.content)

				arg_104_1.text_.text = var_107_12

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 24
				local var_107_14 = utf8.len(var_107_12)
				local var_107_15 = var_107_13 <= 0 and var_107_9 or var_107_9 * (var_107_14 / var_107_13)

				if var_107_15 > 0 and var_107_9 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_12
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081025", "story_v_out_117081.awb") ~= 0 then
					local var_107_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081025", "story_v_out_117081.awb") / 1000

					if var_107_16 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_8
					end

					if var_107_11.prefab_name ~= "" and arg_104_1.actors_[var_107_11.prefab_name] ~= nil then
						local var_107_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_11.prefab_name].transform, "story_v_out_117081", "117081025", "story_v_out_117081.awb")

						arg_104_1:RecordAudio("117081025", var_107_17)
						arg_104_1:RecordAudio("117081025", var_107_17)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_117081", "117081025", "story_v_out_117081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_117081", "117081025", "story_v_out_117081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_18 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_18 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_18

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_18 and arg_104_1.time_ < var_107_8 + var_107_18 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play117081026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 117081026
		arg_108_1.duration_ = 8.87

		local var_108_0 = {
			zh = 6.8,
			ja = 8.866
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play117081027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1132"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1132 == nil then
				arg_108_1.var_.actorSpriteComps1132 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1132 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1132 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1132 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.8

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[61].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_11 = arg_108_1:GetWordFromCfg(117081026)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 32
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081026", "story_v_out_117081.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081026", "story_v_out_117081.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_117081", "117081026", "story_v_out_117081.awb")

						arg_108_1:RecordAudio("117081026", var_111_17)
						arg_108_1:RecordAudio("117081026", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_117081", "117081026", "story_v_out_117081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_117081", "117081026", "story_v_out_117081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_18 and arg_108_1.time_ < var_111_8 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play117081027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 117081027
		arg_112_1.duration_ = 3.97

		local var_112_0 = {
			zh = 3.233,
			ja = 3.966
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play117081028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1132"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1132 == nil then
				arg_112_1.var_.actorSpriteComps1132 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1132 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 0.5, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1132 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1132 = nil
			end

			local var_115_8 = arg_112_1.actors_["10034"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10034 == nil then
				arg_112_1.var_.actorSpriteComps10034 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.2

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps10034 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								local var_115_12 = Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor1.r, var_115_11)
								local var_115_13 = Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor1.g, var_115_11)
								local var_115_14 = Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor1.b, var_115_11)

								iter_115_5.color = Color.New(var_115_12, var_115_13, var_115_14)
							else
								local var_115_15 = Mathf.Lerp(iter_115_5.color.r, 1, var_115_11)

								iter_115_5.color = Color.New(var_115_15, var_115_15, var_115_15)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10034 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10034 = nil
			end

			local var_115_16 = arg_112_1.actors_["10034"].transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.var_.moveOldPos10034 = var_115_16.localPosition
				var_115_16.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10034", 4)

				local var_115_18 = var_115_16.childCount

				for iter_115_8 = 0, var_115_18 - 1 do
					local var_115_19 = var_115_16:GetChild(iter_115_8)

					if var_115_19.name == "split_3" or not string.find(var_115_19.name, "split") then
						var_115_19.gameObject:SetActive(true)
					else
						var_115_19.gameObject:SetActive(false)
					end
				end
			end

			local var_115_20 = 0.001

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_20 then
				local var_115_21 = (arg_112_1.time_ - var_115_17) / var_115_20
				local var_115_22 = Vector3.New(390, -415, -290)

				var_115_16.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10034, var_115_22, var_115_21)
			end

			if arg_112_1.time_ >= var_115_17 + var_115_20 and arg_112_1.time_ < var_115_17 + var_115_20 + arg_115_0 then
				var_115_16.localPosition = Vector3.New(390, -415, -290)
			end

			local var_115_23 = 0
			local var_115_24 = 0.4

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[367].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(117081027)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 16
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081027", "story_v_out_117081.awb") ~= 0 then
					local var_115_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081027", "story_v_out_117081.awb") / 1000

					if var_115_31 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_31 + var_115_23
					end

					if var_115_26.prefab_name ~= "" and arg_112_1.actors_[var_115_26.prefab_name] ~= nil then
						local var_115_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_26.prefab_name].transform, "story_v_out_117081", "117081027", "story_v_out_117081.awb")

						arg_112_1:RecordAudio("117081027", var_115_32)
						arg_112_1:RecordAudio("117081027", var_115_32)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_117081", "117081027", "story_v_out_117081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_117081", "117081027", "story_v_out_117081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_33 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_33 and arg_112_1.time_ < var_115_23 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play117081028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 117081028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play117081029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10034"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps10034 == nil then
				arg_116_1.var_.actorSpriteComps10034 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps10034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 0.5, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps10034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10034 = nil
			end

			local var_119_8 = 0
			local var_119_9 = 0.95

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(117081028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_12 = 38
				local var_119_13 = utf8.len(var_119_11)
				local var_119_14 = var_119_12 <= 0 and var_119_9 or var_119_9 * (var_119_13 / var_119_12)

				if var_119_14 > 0 and var_119_9 < var_119_14 then
					arg_116_1.talkMaxDuration = var_119_14

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_15 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_15 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_15

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_15 and arg_116_1.time_ < var_119_8 + var_119_15 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play117081029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 117081029
		arg_120_1.duration_ = 9.9

		local var_120_0 = {
			zh = 9.9,
			ja = 5.633
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play117081030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1132"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1132 = var_123_0.localPosition
				var_123_0.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1132", 2)

				local var_123_2 = var_123_0.childCount

				for iter_123_0 = 0, var_123_2 - 1 do
					local var_123_3 = var_123_0:GetChild(iter_123_0)

					if var_123_3.name == "split_1" or not string.find(var_123_3.name, "split") then
						var_123_3.gameObject:SetActive(true)
					else
						var_123_3.gameObject:SetActive(false)
					end
				end
			end

			local var_123_4 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_4 then
				local var_123_5 = (arg_120_1.time_ - var_123_1) / var_123_4
				local var_123_6 = Vector3.New(-390, -413, -185)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1132, var_123_6, var_123_5)
			end

			if arg_120_1.time_ >= var_123_1 + var_123_4 and arg_120_1.time_ < var_123_1 + var_123_4 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_123_7 = arg_120_1.actors_["1132"]
			local var_123_8 = 0

			if var_123_8 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.actorSpriteComps1132 == nil then
				arg_120_1.var_.actorSpriteComps1132 = var_123_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_9 = 0.2

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_9 and not isNil(var_123_7) then
				local var_123_10 = (arg_120_1.time_ - var_123_8) / var_123_9

				if arg_120_1.var_.actorSpriteComps1132 then
					for iter_123_1, iter_123_2 in pairs(arg_120_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_123_2 then
							if arg_120_1.isInRecall_ then
								local var_123_11 = Mathf.Lerp(iter_123_2.color.r, arg_120_1.hightColor1.r, var_123_10)
								local var_123_12 = Mathf.Lerp(iter_123_2.color.g, arg_120_1.hightColor1.g, var_123_10)
								local var_123_13 = Mathf.Lerp(iter_123_2.color.b, arg_120_1.hightColor1.b, var_123_10)

								iter_123_2.color = Color.New(var_123_11, var_123_12, var_123_13)
							else
								local var_123_14 = Mathf.Lerp(iter_123_2.color.r, 1, var_123_10)

								iter_123_2.color = Color.New(var_123_14, var_123_14, var_123_14)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_8 + var_123_9 and arg_120_1.time_ < var_123_8 + var_123_9 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.actorSpriteComps1132 then
				for iter_123_3, iter_123_4 in pairs(arg_120_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_123_4 then
						if arg_120_1.isInRecall_ then
							iter_123_4.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1132 = nil
			end

			local var_123_15 = 0
			local var_123_16 = 1.025

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[61].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(117081029)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 41
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081029", "story_v_out_117081.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_117081", "117081029", "story_v_out_117081.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_117081", "117081029", "story_v_out_117081.awb")

						arg_120_1:RecordAudio("117081029", var_123_24)
						arg_120_1:RecordAudio("117081029", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_117081", "117081029", "story_v_out_117081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_117081", "117081029", "story_v_out_117081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play117081030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 117081030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play117081031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1132"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1132 == nil then
				arg_124_1.var_.actorSpriteComps1132 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1132 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1132 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1132 = nil
			end

			local var_127_8 = 0
			local var_127_9 = 0.3

			if var_127_8 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(117081030)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_12 = 12
				local var_127_13 = utf8.len(var_127_11)
				local var_127_14 = var_127_12 <= 0 and var_127_9 or var_127_9 * (var_127_13 / var_127_12)

				if var_127_14 > 0 and var_127_9 < var_127_14 then
					arg_124_1.talkMaxDuration = var_127_14

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_15 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_15 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_15

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_15 and arg_124_1.time_ < var_127_8 + var_127_15 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play117081031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 117081031
		arg_128_1.duration_ = 5.1

		local var_128_0 = {
			zh = 5.1,
			ja = 2.133
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play117081032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10035"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos10035 = var_131_0.localPosition
				var_131_0.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10035", 4)

				local var_131_2 = var_131_0.childCount

				for iter_131_0 = 0, var_131_2 - 1 do
					local var_131_3 = var_131_0:GetChild(iter_131_0)

					if var_131_3.name == "split_4" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_4 then
				local var_131_5 = (arg_128_1.time_ - var_131_1) / var_131_4
				local var_131_6 = Vector3.New(390, -410, -235)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10035, var_131_6, var_131_5)
			end

			if arg_128_1.time_ >= var_131_1 + var_131_4 and arg_128_1.time_ < var_131_1 + var_131_4 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_131_7 = arg_128_1.actors_["10035"]
			local var_131_8 = 0

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.actorSpriteComps10035 == nil then
				arg_128_1.var_.actorSpriteComps10035 = var_131_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_9 = 0.2

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_9 and not isNil(var_131_7) then
				local var_131_10 = (arg_128_1.time_ - var_131_8) / var_131_9

				if arg_128_1.var_.actorSpriteComps10035 then
					for iter_131_1, iter_131_2 in pairs(arg_128_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_131_2 then
							if arg_128_1.isInRecall_ then
								local var_131_11 = Mathf.Lerp(iter_131_2.color.r, arg_128_1.hightColor1.r, var_131_10)
								local var_131_12 = Mathf.Lerp(iter_131_2.color.g, arg_128_1.hightColor1.g, var_131_10)
								local var_131_13 = Mathf.Lerp(iter_131_2.color.b, arg_128_1.hightColor1.b, var_131_10)

								iter_131_2.color = Color.New(var_131_11, var_131_12, var_131_13)
							else
								local var_131_14 = Mathf.Lerp(iter_131_2.color.r, 1, var_131_10)

								iter_131_2.color = Color.New(var_131_14, var_131_14, var_131_14)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_8 + var_131_9 and arg_128_1.time_ < var_131_8 + var_131_9 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.actorSpriteComps10035 then
				for iter_131_3, iter_131_4 in pairs(arg_128_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_131_4 then
						if arg_128_1.isInRecall_ then
							iter_131_4.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10035 = nil
			end

			local var_131_15 = 0
			local var_131_16 = 0.625

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[369].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(117081031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 25
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081031", "story_v_out_117081.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_117081", "117081031", "story_v_out_117081.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_117081", "117081031", "story_v_out_117081.awb")

						arg_128_1:RecordAudio("117081031", var_131_24)
						arg_128_1:RecordAudio("117081031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_117081", "117081031", "story_v_out_117081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_117081", "117081031", "story_v_out_117081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play117081032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 117081032
		arg_132_1.duration_ = 13.9

		local var_132_0 = {
			zh = 13.9,
			ja = 9.333
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play117081033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10035"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10035 == nil then
				arg_132_1.var_.actorSpriteComps10035 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10035 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 0.5, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10035 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10035 = nil
			end

			local var_135_8 = arg_132_1.actors_["1132"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1132 == nil then
				arg_132_1.var_.actorSpriteComps1132 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1132 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor1.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor1.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor1.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 1, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1132 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1132 = nil
			end

			local var_135_16 = 0
			local var_135_17 = 1.575

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_18 = arg_132_1:FormatText(StoryNameCfg[61].name)

				arg_132_1.leftNameTxt_.text = var_135_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_19 = arg_132_1:GetWordFromCfg(117081032)
				local var_135_20 = arg_132_1:FormatText(var_135_19.content)

				arg_132_1.text_.text = var_135_20

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_21 = 63
				local var_135_22 = utf8.len(var_135_20)
				local var_135_23 = var_135_21 <= 0 and var_135_17 or var_135_17 * (var_135_22 / var_135_21)

				if var_135_23 > 0 and var_135_17 < var_135_23 then
					arg_132_1.talkMaxDuration = var_135_23

					if var_135_23 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_16
					end
				end

				arg_132_1.text_.text = var_135_20
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081032", "story_v_out_117081.awb") ~= 0 then
					local var_135_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081032", "story_v_out_117081.awb") / 1000

					if var_135_24 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_24 + var_135_16
					end

					if var_135_19.prefab_name ~= "" and arg_132_1.actors_[var_135_19.prefab_name] ~= nil then
						local var_135_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_19.prefab_name].transform, "story_v_out_117081", "117081032", "story_v_out_117081.awb")

						arg_132_1:RecordAudio("117081032", var_135_25)
						arg_132_1:RecordAudio("117081032", var_135_25)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_117081", "117081032", "story_v_out_117081.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_117081", "117081032", "story_v_out_117081.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_26 = math.max(var_135_17, arg_132_1.talkMaxDuration)

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_26 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_16) / var_135_26

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_16 + var_135_26 and arg_132_1.time_ < var_135_16 + var_135_26 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play117081033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 117081033
		arg_136_1.duration_ = 2.53

		local var_136_0 = {
			zh = 1.866,
			ja = 2.533
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play117081034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.25

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[61].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(117081033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 10
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081033", "story_v_out_117081.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081033", "story_v_out_117081.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_117081", "117081033", "story_v_out_117081.awb")

						arg_136_1:RecordAudio("117081033", var_139_9)
						arg_136_1:RecordAudio("117081033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_117081", "117081033", "story_v_out_117081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_117081", "117081033", "story_v_out_117081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play117081034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 117081034
		arg_140_1.duration_ = 8.83

		local var_140_0 = {
			zh = 8.833,
			ja = 3.4
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play117081035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.875

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[61].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(117081034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 35
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081034", "story_v_out_117081.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081034", "story_v_out_117081.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_117081", "117081034", "story_v_out_117081.awb")

						arg_140_1:RecordAudio("117081034", var_143_9)
						arg_140_1:RecordAudio("117081034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_117081", "117081034", "story_v_out_117081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_117081", "117081034", "story_v_out_117081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play117081035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 117081035
		arg_144_1.duration_ = 5.03

		local var_144_0 = {
			zh = 5.033,
			ja = 3.266
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play117081036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1132"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1132 == nil then
				arg_144_1.var_.actorSpriteComps1132 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps1132 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 0.5, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1132 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1132 = nil
			end

			local var_147_8 = arg_144_1.actors_["10035"].transform
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.var_.moveOldPos10035 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10035", 4)

				local var_147_10 = var_147_8.childCount

				for iter_147_4 = 0, var_147_10 - 1 do
					local var_147_11 = var_147_8:GetChild(iter_147_4)

					if var_147_11.name == "split_1" or not string.find(var_147_11.name, "split") then
						var_147_11.gameObject:SetActive(true)
					else
						var_147_11.gameObject:SetActive(false)
					end
				end
			end

			local var_147_12 = 0.001

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_9) / var_147_12
				local var_147_14 = Vector3.New(390, -410, -235)

				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10035, var_147_14, var_147_13)
			end

			if arg_144_1.time_ >= var_147_9 + var_147_12 and arg_144_1.time_ < var_147_9 + var_147_12 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(390, -410, -235)
			end

			local var_147_15 = arg_144_1.actors_["10035"]
			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.actorSpriteComps10035 == nil then
				arg_144_1.var_.actorSpriteComps10035 = var_147_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_17 = 0.2

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_17 and not isNil(var_147_15) then
				local var_147_18 = (arg_144_1.time_ - var_147_16) / var_147_17

				if arg_144_1.var_.actorSpriteComps10035 then
					for iter_147_5, iter_147_6 in pairs(arg_144_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_147_6 then
							if arg_144_1.isInRecall_ then
								local var_147_19 = Mathf.Lerp(iter_147_6.color.r, arg_144_1.hightColor1.r, var_147_18)
								local var_147_20 = Mathf.Lerp(iter_147_6.color.g, arg_144_1.hightColor1.g, var_147_18)
								local var_147_21 = Mathf.Lerp(iter_147_6.color.b, arg_144_1.hightColor1.b, var_147_18)

								iter_147_6.color = Color.New(var_147_19, var_147_20, var_147_21)
							else
								local var_147_22 = Mathf.Lerp(iter_147_6.color.r, 1, var_147_18)

								iter_147_6.color = Color.New(var_147_22, var_147_22, var_147_22)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_16 + var_147_17 and arg_144_1.time_ < var_147_16 + var_147_17 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.actorSpriteComps10035 then
				for iter_147_7, iter_147_8 in pairs(arg_144_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_147_8 then
						if arg_144_1.isInRecall_ then
							iter_147_8.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10035 = nil
			end

			local var_147_23 = 0
			local var_147_24 = 0.225

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_25 = arg_144_1:FormatText(StoryNameCfg[369].name)

				arg_144_1.leftNameTxt_.text = var_147_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_26 = arg_144_1:GetWordFromCfg(117081035)
				local var_147_27 = arg_144_1:FormatText(var_147_26.content)

				arg_144_1.text_.text = var_147_27

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_28 = 9
				local var_147_29 = utf8.len(var_147_27)
				local var_147_30 = var_147_28 <= 0 and var_147_24 or var_147_24 * (var_147_29 / var_147_28)

				if var_147_30 > 0 and var_147_24 < var_147_30 then
					arg_144_1.talkMaxDuration = var_147_30

					if var_147_30 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_30 + var_147_23
					end
				end

				arg_144_1.text_.text = var_147_27
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081035", "story_v_out_117081.awb") ~= 0 then
					local var_147_31 = manager.audio:GetVoiceLength("story_v_out_117081", "117081035", "story_v_out_117081.awb") / 1000

					if var_147_31 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_31 + var_147_23
					end

					if var_147_26.prefab_name ~= "" and arg_144_1.actors_[var_147_26.prefab_name] ~= nil then
						local var_147_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_26.prefab_name].transform, "story_v_out_117081", "117081035", "story_v_out_117081.awb")

						arg_144_1:RecordAudio("117081035", var_147_32)
						arg_144_1:RecordAudio("117081035", var_147_32)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_117081", "117081035", "story_v_out_117081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_117081", "117081035", "story_v_out_117081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_33 = math.max(var_147_24, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_33 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_33

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_33 and arg_144_1.time_ < var_147_23 + var_147_33 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play117081036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 117081036
		arg_148_1.duration_ = 3.87

		local var_148_0 = {
			zh = 3.866,
			ja = 3.533
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play117081037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10035"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10035 == nil then
				arg_148_1.var_.actorSpriteComps10035 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10035 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 0.5, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10035 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10035 = nil
			end

			local var_151_8 = 0
			local var_151_9 = 0.275

			if var_151_8 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_10 = arg_148_1:FormatText(StoryNameCfg[367].name)

				arg_148_1.leftNameTxt_.text = var_151_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_11 = arg_148_1:GetWordFromCfg(117081036)
				local var_151_12 = arg_148_1:FormatText(var_151_11.content)

				arg_148_1.text_.text = var_151_12

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 11
				local var_151_14 = utf8.len(var_151_12)
				local var_151_15 = var_151_13 <= 0 and var_151_9 or var_151_9 * (var_151_14 / var_151_13)

				if var_151_15 > 0 and var_151_9 < var_151_15 then
					arg_148_1.talkMaxDuration = var_151_15

					if var_151_15 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_15 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_12
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081036", "story_v_out_117081.awb") ~= 0 then
					local var_151_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081036", "story_v_out_117081.awb") / 1000

					if var_151_16 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_16 + var_151_8
					end

					if var_151_11.prefab_name ~= "" and arg_148_1.actors_[var_151_11.prefab_name] ~= nil then
						local var_151_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_11.prefab_name].transform, "story_v_out_117081", "117081036", "story_v_out_117081.awb")

						arg_148_1:RecordAudio("117081036", var_151_17)
						arg_148_1:RecordAudio("117081036", var_151_17)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_117081", "117081036", "story_v_out_117081.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_117081", "117081036", "story_v_out_117081.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_18 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_18 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_18

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_18 and arg_148_1.time_ < var_151_8 + var_151_18 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play117081037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 117081037
		arg_152_1.duration_ = 9

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play117081038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = "TI0105"

			if arg_152_1.bgs_[var_155_0] == nil then
				local var_155_1 = Object.Instantiate(arg_152_1.paintGo_)

				var_155_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_155_0)
				var_155_1.name = var_155_0
				var_155_1.transform.parent = arg_152_1.stage_.transform
				var_155_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.bgs_[var_155_0] = var_155_1
			end

			local var_155_2 = 2

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				local var_155_3 = manager.ui.mainCamera.transform.localPosition
				local var_155_4 = Vector3.New(0, 0, 10) + Vector3.New(var_155_3.x, var_155_3.y, 0)
				local var_155_5 = arg_152_1.bgs_.TI0105

				var_155_5.transform.localPosition = var_155_4
				var_155_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_155_6 = var_155_5:GetComponent("SpriteRenderer")

				if var_155_6 and var_155_6.sprite then
					local var_155_7 = (var_155_5.transform.localPosition - var_155_3).z
					local var_155_8 = manager.ui.mainCameraCom_
					local var_155_9 = 2 * var_155_7 * Mathf.Tan(var_155_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_155_10 = var_155_9 * var_155_8.aspect
					local var_155_11 = var_155_6.sprite.bounds.size.x
					local var_155_12 = var_155_6.sprite.bounds.size.y
					local var_155_13 = var_155_10 / var_155_11
					local var_155_14 = var_155_9 / var_155_12
					local var_155_15 = var_155_14 < var_155_13 and var_155_13 or var_155_14

					var_155_5.transform.localScale = Vector3.New(var_155_15, var_155_15, 0)
				end

				for iter_155_0, iter_155_1 in pairs(arg_152_1.bgs_) do
					if iter_155_0 ~= "TI0105" then
						iter_155_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_17 = 2

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_17 then
				local var_155_18 = (arg_152_1.time_ - var_155_16) / var_155_17
				local var_155_19 = Color.New(0, 0, 0)

				var_155_19.a = Mathf.Lerp(0, 1, var_155_18)
				arg_152_1.mask_.color = var_155_19
			end

			if arg_152_1.time_ >= var_155_16 + var_155_17 and arg_152_1.time_ < var_155_16 + var_155_17 + arg_155_0 then
				local var_155_20 = Color.New(0, 0, 0)

				var_155_20.a = 1
				arg_152_1.mask_.color = var_155_20
			end

			local var_155_21 = 2

			if var_155_21 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_22 = 2

			if var_155_21 <= arg_152_1.time_ and arg_152_1.time_ < var_155_21 + var_155_22 then
				local var_155_23 = (arg_152_1.time_ - var_155_21) / var_155_22
				local var_155_24 = Color.New(0, 0, 0)

				var_155_24.a = Mathf.Lerp(1, 0, var_155_23)
				arg_152_1.mask_.color = var_155_24
			end

			if arg_152_1.time_ >= var_155_21 + var_155_22 and arg_152_1.time_ < var_155_21 + var_155_22 + arg_155_0 then
				local var_155_25 = Color.New(0, 0, 0)
				local var_155_26 = 0

				arg_152_1.mask_.enabled = false
				var_155_25.a = var_155_26
				arg_152_1.mask_.color = var_155_25
			end

			local var_155_27 = arg_152_1.actors_["1132"].transform
			local var_155_28 = 2

			if var_155_28 < arg_152_1.time_ and arg_152_1.time_ <= var_155_28 + arg_155_0 then
				arg_152_1.var_.moveOldPos1132 = var_155_27.localPosition
				var_155_27.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1132", 7)

				local var_155_29 = var_155_27.childCount

				for iter_155_2 = 0, var_155_29 - 1 do
					local var_155_30 = var_155_27:GetChild(iter_155_2)

					if var_155_30.name == "split_1" or not string.find(var_155_30.name, "split") then
						var_155_30.gameObject:SetActive(true)
					else
						var_155_30.gameObject:SetActive(false)
					end
				end
			end

			local var_155_31 = 0.001

			if var_155_28 <= arg_152_1.time_ and arg_152_1.time_ < var_155_28 + var_155_31 then
				local var_155_32 = (arg_152_1.time_ - var_155_28) / var_155_31
				local var_155_33 = Vector3.New(0, -2000, -185)

				var_155_27.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1132, var_155_33, var_155_32)
			end

			if arg_152_1.time_ >= var_155_28 + var_155_31 and arg_152_1.time_ < var_155_28 + var_155_31 + arg_155_0 then
				var_155_27.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_155_34 = arg_152_1.actors_["10035"].transform
			local var_155_35 = 2

			if var_155_35 < arg_152_1.time_ and arg_152_1.time_ <= var_155_35 + arg_155_0 then
				arg_152_1.var_.moveOldPos10035 = var_155_34.localPosition
				var_155_34.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10035", 7)

				local var_155_36 = var_155_34.childCount

				for iter_155_3 = 0, var_155_36 - 1 do
					local var_155_37 = var_155_34:GetChild(iter_155_3)

					if var_155_37.name == "split_1" or not string.find(var_155_37.name, "split") then
						var_155_37.gameObject:SetActive(true)
					else
						var_155_37.gameObject:SetActive(false)
					end
				end
			end

			local var_155_38 = 0.001

			if var_155_35 <= arg_152_1.time_ and arg_152_1.time_ < var_155_35 + var_155_38 then
				local var_155_39 = (arg_152_1.time_ - var_155_35) / var_155_38
				local var_155_40 = Vector3.New(0, -2000, -235)

				var_155_34.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10035, var_155_40, var_155_39)
			end

			if arg_152_1.time_ >= var_155_35 + var_155_38 and arg_152_1.time_ < var_155_35 + var_155_38 + arg_155_0 then
				var_155_34.localPosition = Vector3.New(0, -2000, -235)
			end

			local var_155_41 = arg_152_1.bgs_.TI0105.transform
			local var_155_42 = 2

			if var_155_42 < arg_152_1.time_ and arg_152_1.time_ <= var_155_42 + arg_155_0 then
				arg_152_1.var_.moveOldPosTI0105 = var_155_41.localPosition
			end

			local var_155_43 = 0.001

			if var_155_42 <= arg_152_1.time_ and arg_152_1.time_ < var_155_42 + var_155_43 then
				local var_155_44 = (arg_152_1.time_ - var_155_42) / var_155_43
				local var_155_45 = Vector3.New(0, 1, 9.5)

				var_155_41.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPosTI0105, var_155_45, var_155_44)
			end

			if arg_152_1.time_ >= var_155_42 + var_155_43 and arg_152_1.time_ < var_155_42 + var_155_43 + arg_155_0 then
				var_155_41.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_155_46 = arg_152_1.bgs_.TI0105.transform
			local var_155_47 = 2.034

			if var_155_47 < arg_152_1.time_ and arg_152_1.time_ <= var_155_47 + arg_155_0 then
				arg_152_1.var_.moveOldPosTI0105 = var_155_46.localPosition
			end

			local var_155_48 = 3

			if var_155_47 <= arg_152_1.time_ and arg_152_1.time_ < var_155_47 + var_155_48 then
				local var_155_49 = (arg_152_1.time_ - var_155_47) / var_155_48
				local var_155_50 = Vector3.New(0, 1, 10)

				var_155_46.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPosTI0105, var_155_50, var_155_49)
			end

			if arg_152_1.time_ >= var_155_47 + var_155_48 and arg_152_1.time_ < var_155_47 + var_155_48 + arg_155_0 then
				var_155_46.localPosition = Vector3.New(0, 1, 10)
			end

			local var_155_51 = 4

			if var_155_51 < arg_152_1.time_ and arg_152_1.time_ <= var_155_51 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			local var_155_52 = 1.034

			if arg_152_1.time_ >= var_155_51 + var_155_52 and arg_152_1.time_ < var_155_51 + var_155_52 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_53 = 4
			local var_155_54 = 1.425

			if var_155_53 < arg_152_1.time_ and arg_152_1.time_ <= var_155_53 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_55 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_55:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_56 = arg_152_1:GetWordFromCfg(117081037)
				local var_155_57 = arg_152_1:FormatText(var_155_56.content)

				arg_152_1.text_.text = var_155_57

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_58 = 57
				local var_155_59 = utf8.len(var_155_57)
				local var_155_60 = var_155_58 <= 0 and var_155_54 or var_155_54 * (var_155_59 / var_155_58)

				if var_155_60 > 0 and var_155_54 < var_155_60 then
					arg_152_1.talkMaxDuration = var_155_60
					var_155_53 = var_155_53 + 0.3

					if var_155_60 + var_155_53 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_60 + var_155_53
					end
				end

				arg_152_1.text_.text = var_155_57
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_61 = var_155_53 + 0.3
			local var_155_62 = math.max(var_155_54, arg_152_1.talkMaxDuration)

			if var_155_61 <= arg_152_1.time_ and arg_152_1.time_ < var_155_61 + var_155_62 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_61) / var_155_62

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_61 + var_155_62 and arg_152_1.time_ < var_155_61 + var_155_62 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "TI0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play117081038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 117081038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play117081039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.875

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(117081038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 35
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play117081039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 117081039
		arg_162_1.duration_ = 14.63

		local var_162_0 = {
			zh = 14.633,
			ja = 10.066
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play117081040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.375

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[367].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(117081039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 55
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081039", "story_v_out_117081.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081039", "story_v_out_117081.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_117081", "117081039", "story_v_out_117081.awb")

						arg_162_1:RecordAudio("117081039", var_165_9)
						arg_162_1:RecordAudio("117081039", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_117081", "117081039", "story_v_out_117081.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_117081", "117081039", "story_v_out_117081.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play117081040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 117081040
		arg_166_1.duration_ = 12.47

		local var_166_0 = {
			zh = 7.666,
			ja = 12.466
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play117081041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.825

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[369].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:GetWordFromCfg(117081040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 32
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081040", "story_v_out_117081.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081040", "story_v_out_117081.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_117081", "117081040", "story_v_out_117081.awb")

						arg_166_1:RecordAudio("117081040", var_169_9)
						arg_166_1:RecordAudio("117081040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_117081", "117081040", "story_v_out_117081.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_117081", "117081040", "story_v_out_117081.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play117081041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 117081041
		arg_170_1.duration_ = 4.57

		local var_170_0 = {
			zh = 4.4,
			ja = 4.566
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play117081042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.45

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[367].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(117081041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 18
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081041", "story_v_out_117081.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081041", "story_v_out_117081.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_117081", "117081041", "story_v_out_117081.awb")

						arg_170_1:RecordAudio("117081041", var_173_9)
						arg_170_1:RecordAudio("117081041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_117081", "117081041", "story_v_out_117081.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_117081", "117081041", "story_v_out_117081.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play117081042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 117081042
		arg_174_1.duration_ = 15.07

		local var_174_0 = {
			zh = 15.066,
			ja = 14.666
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play117081043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.775

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[369].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_3 = arg_174_1:GetWordFromCfg(117081042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 71
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081042", "story_v_out_117081.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081042", "story_v_out_117081.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_117081", "117081042", "story_v_out_117081.awb")

						arg_174_1:RecordAudio("117081042", var_177_9)
						arg_174_1:RecordAudio("117081042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_117081", "117081042", "story_v_out_117081.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_117081", "117081042", "story_v_out_117081.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_10 and arg_174_1.time_ < var_177_0 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play117081043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 117081043
		arg_178_1.duration_ = 4.03

		local var_178_0 = {
			zh = 2.266,
			ja = 4.033
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
				arg_178_0:Play117081044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.275

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[367].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(117081043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 11
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081043", "story_v_out_117081.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081043", "story_v_out_117081.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_117081", "117081043", "story_v_out_117081.awb")

						arg_178_1:RecordAudio("117081043", var_181_9)
						arg_178_1:RecordAudio("117081043", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_117081", "117081043", "story_v_out_117081.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_117081", "117081043", "story_v_out_117081.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play117081044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 117081044
		arg_182_1.duration_ = 6.37

		local var_182_0 = {
			zh = 2.566,
			ja = 6.366
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play117081045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.325

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[369].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(117081044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 13
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081044", "story_v_out_117081.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081044", "story_v_out_117081.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_117081", "117081044", "story_v_out_117081.awb")

						arg_182_1:RecordAudio("117081044", var_185_9)
						arg_182_1:RecordAudio("117081044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_117081", "117081044", "story_v_out_117081.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_117081", "117081044", "story_v_out_117081.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play117081045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 117081045
		arg_186_1.duration_ = 3.57

		local var_186_0 = {
			zh = 3.566,
			ja = 2.166
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
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play117081046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.225

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[61].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:GetWordFromCfg(117081045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 9
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081045", "story_v_out_117081.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081045", "story_v_out_117081.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_117081", "117081045", "story_v_out_117081.awb")

						arg_186_1:RecordAudio("117081045", var_189_9)
						arg_186_1:RecordAudio("117081045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_117081", "117081045", "story_v_out_117081.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_117081", "117081045", "story_v_out_117081.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play117081046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 117081046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play117081047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 1.275

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(117081046)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 51
				local var_193_5 = utf8.len(var_193_3)
				local var_193_6 = var_193_4 <= 0 and var_193_1 or var_193_1 * (var_193_5 / var_193_4)

				if var_193_6 > 0 and var_193_1 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_7 and arg_190_1.time_ < var_193_0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play117081047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 117081047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play117081048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 1.575

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_2 = arg_194_1:GetWordFromCfg(117081047)
				local var_197_3 = arg_194_1:FormatText(var_197_2.content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 57
				local var_197_5 = utf8.len(var_197_3)
				local var_197_6 = var_197_4 <= 0 and var_197_1 or var_197_1 * (var_197_5 / var_197_4)

				if var_197_6 > 0 and var_197_1 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_7 and arg_194_1.time_ < var_197_0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play117081048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 117081048
		arg_198_1.duration_ = 8.13

		local var_198_0 = {
			zh = 8.133,
			ja = 8.1
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play117081049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.55

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[369].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:GetWordFromCfg(117081048)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 22
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081048", "story_v_out_117081.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081048", "story_v_out_117081.awb") / 1000

					if var_201_8 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_0
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_117081", "117081048", "story_v_out_117081.awb")

						arg_198_1:RecordAudio("117081048", var_201_9)
						arg_198_1:RecordAudio("117081048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_117081", "117081048", "story_v_out_117081.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_117081", "117081048", "story_v_out_117081.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_10 and arg_198_1.time_ < var_201_0 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play117081049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 117081049
		arg_202_1.duration_ = 7.73

		local var_202_0 = {
			zh = 7.733,
			ja = 5.566
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play117081050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.775

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[369].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:GetWordFromCfg(117081049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 31
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081049", "story_v_out_117081.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081049", "story_v_out_117081.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_117081", "117081049", "story_v_out_117081.awb")

						arg_202_1:RecordAudio("117081049", var_205_9)
						arg_202_1:RecordAudio("117081049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_117081", "117081049", "story_v_out_117081.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_117081", "117081049", "story_v_out_117081.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play117081050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 117081050
		arg_206_1.duration_ = 3.23

		local var_206_0 = {
			zh = 3.233,
			ja = 1.8
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play117081051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.175

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[61].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:GetWordFromCfg(117081050)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 7
				local var_209_6 = utf8.len(var_209_4)
				local var_209_7 = var_209_5 <= 0 and var_209_1 or var_209_1 * (var_209_6 / var_209_5)

				if var_209_7 > 0 and var_209_1 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081050", "story_v_out_117081.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081050", "story_v_out_117081.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_117081", "117081050", "story_v_out_117081.awb")

						arg_206_1:RecordAudio("117081050", var_209_9)
						arg_206_1:RecordAudio("117081050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_117081", "117081050", "story_v_out_117081.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_117081", "117081050", "story_v_out_117081.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_10 and arg_206_1.time_ < var_209_0 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play117081051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 117081051
		arg_210_1.duration_ = 14.1

		local var_210_0 = {
			zh = 14.1,
			ja = 13.566
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play117081052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 1.65

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[61].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(117081051)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 66
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081051", "story_v_out_117081.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081051", "story_v_out_117081.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_117081", "117081051", "story_v_out_117081.awb")

						arg_210_1:RecordAudio("117081051", var_213_9)
						arg_210_1:RecordAudio("117081051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_117081", "117081051", "story_v_out_117081.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_117081", "117081051", "story_v_out_117081.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play117081052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 117081052
		arg_214_1.duration_ = 9

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play117081053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 2

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				local var_217_1 = manager.ui.mainCamera.transform.localPosition
				local var_217_2 = Vector3.New(0, 0, 10) + Vector3.New(var_217_1.x, var_217_1.y, 0)
				local var_217_3 = arg_214_1.bgs_.ST24a

				var_217_3.transform.localPosition = var_217_2
				var_217_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_217_4 = var_217_3:GetComponent("SpriteRenderer")

				if var_217_4 and var_217_4.sprite then
					local var_217_5 = (var_217_3.transform.localPosition - var_217_1).z
					local var_217_6 = manager.ui.mainCameraCom_
					local var_217_7 = 2 * var_217_5 * Mathf.Tan(var_217_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_217_8 = var_217_7 * var_217_6.aspect
					local var_217_9 = var_217_4.sprite.bounds.size.x
					local var_217_10 = var_217_4.sprite.bounds.size.y
					local var_217_11 = var_217_8 / var_217_9
					local var_217_12 = var_217_7 / var_217_10
					local var_217_13 = var_217_12 < var_217_11 and var_217_11 or var_217_12

					var_217_3.transform.localScale = Vector3.New(var_217_13, var_217_13, 0)
				end

				for iter_217_0, iter_217_1 in pairs(arg_214_1.bgs_) do
					if iter_217_0 ~= "ST24a" then
						iter_217_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_15 = 2

			if var_217_14 <= arg_214_1.time_ and arg_214_1.time_ < var_217_14 + var_217_15 then
				local var_217_16 = (arg_214_1.time_ - var_217_14) / var_217_15
				local var_217_17 = Color.New(0, 0, 0)

				var_217_17.a = Mathf.Lerp(0, 1, var_217_16)
				arg_214_1.mask_.color = var_217_17
			end

			if arg_214_1.time_ >= var_217_14 + var_217_15 and arg_214_1.time_ < var_217_14 + var_217_15 + arg_217_0 then
				local var_217_18 = Color.New(0, 0, 0)

				var_217_18.a = 1
				arg_214_1.mask_.color = var_217_18
			end

			local var_217_19 = 2

			if var_217_19 < arg_214_1.time_ and arg_214_1.time_ <= var_217_19 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_20 = 2

			if var_217_19 <= arg_214_1.time_ and arg_214_1.time_ < var_217_19 + var_217_20 then
				local var_217_21 = (arg_214_1.time_ - var_217_19) / var_217_20
				local var_217_22 = Color.New(0, 0, 0)

				var_217_22.a = Mathf.Lerp(1, 0, var_217_21)
				arg_214_1.mask_.color = var_217_22
			end

			if arg_214_1.time_ >= var_217_19 + var_217_20 and arg_214_1.time_ < var_217_19 + var_217_20 + arg_217_0 then
				local var_217_23 = Color.New(0, 0, 0)
				local var_217_24 = 0

				arg_214_1.mask_.enabled = false
				var_217_23.a = var_217_24
				arg_214_1.mask_.color = var_217_23
			end

			if arg_214_1.frameCnt_ <= 1 then
				arg_214_1.dialog_:SetActive(false)
			end

			local var_217_25 = 4
			local var_217_26 = 0.625

			if var_217_25 < arg_214_1.time_ and arg_214_1.time_ <= var_217_25 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_27 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_27:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_28 = arg_214_1:GetWordFromCfg(117081052)
				local var_217_29 = arg_214_1:FormatText(var_217_28.content)

				arg_214_1.text_.text = var_217_29

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_30 = 25
				local var_217_31 = utf8.len(var_217_29)
				local var_217_32 = var_217_30 <= 0 and var_217_26 or var_217_26 * (var_217_31 / var_217_30)

				if var_217_32 > 0 and var_217_26 < var_217_32 then
					arg_214_1.talkMaxDuration = var_217_32
					var_217_25 = var_217_25 + 0.3

					if var_217_32 + var_217_25 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_32 + var_217_25
					end
				end

				arg_214_1.text_.text = var_217_29
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_33 = var_217_25 + 0.3
			local var_217_34 = math.max(var_217_26, arg_214_1.talkMaxDuration)

			if var_217_33 <= arg_214_1.time_ and arg_214_1.time_ < var_217_33 + var_217_34 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_33) / var_217_34

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_33 + var_217_34 and arg_214_1.time_ < var_217_33 + var_217_34 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play117081053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 117081053
		arg_220_1.duration_ = 6.53

		local var_220_0 = {
			zh = 6.533,
			ja = 5
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play117081054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10035"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				local var_223_2 = var_223_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_223_2 then
					arg_220_1.var_.alphaOldValue10035 = var_223_2.alpha
					arg_220_1.var_.characterEffect10035 = var_223_2
				end

				arg_220_1.var_.alphaOldValue10035 = 0
			end

			local var_223_3 = 0.333333333333333

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Mathf.Lerp(arg_220_1.var_.alphaOldValue10035, 1, var_223_4)

				if arg_220_1.var_.characterEffect10035 then
					arg_220_1.var_.characterEffect10035.alpha = var_223_5
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 and arg_220_1.var_.characterEffect10035 then
				arg_220_1.var_.characterEffect10035.alpha = 1
			end

			local var_223_6 = arg_220_1.actors_["10035"]
			local var_223_7 = 0

			if var_223_7 < arg_220_1.time_ and arg_220_1.time_ <= var_223_7 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.actorSpriteComps10035 == nil then
				arg_220_1.var_.actorSpriteComps10035 = var_223_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_8 = 0.2

			if var_223_7 <= arg_220_1.time_ and arg_220_1.time_ < var_223_7 + var_223_8 and not isNil(var_223_6) then
				local var_223_9 = (arg_220_1.time_ - var_223_7) / var_223_8

				if arg_220_1.var_.actorSpriteComps10035 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_10 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, var_223_9)
								local var_223_11 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, var_223_9)
								local var_223_12 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, var_223_9)

								iter_223_1.color = Color.New(var_223_10, var_223_11, var_223_12)
							else
								local var_223_13 = Mathf.Lerp(iter_223_1.color.r, 1, var_223_9)

								iter_223_1.color = Color.New(var_223_13, var_223_13, var_223_13)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_7 + var_223_8 and arg_220_1.time_ < var_223_7 + var_223_8 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.actorSpriteComps10035 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_223_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10035 = nil
			end

			local var_223_14 = arg_220_1.actors_["10035"].transform
			local var_223_15 = 0

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1.var_.moveOldPos10035 = var_223_14.localPosition
				var_223_14.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10035", 4)

				local var_223_16 = var_223_14.childCount

				for iter_223_4 = 0, var_223_16 - 1 do
					local var_223_17 = var_223_14:GetChild(iter_223_4)

					if var_223_17.name == "split_4" or not string.find(var_223_17.name, "split") then
						var_223_17.gameObject:SetActive(true)
					else
						var_223_17.gameObject:SetActive(false)
					end
				end
			end

			local var_223_18 = 0.001

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_18 then
				local var_223_19 = (arg_220_1.time_ - var_223_15) / var_223_18
				local var_223_20 = Vector3.New(390, -410, -235)

				var_223_14.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10035, var_223_20, var_223_19)
			end

			if arg_220_1.time_ >= var_223_15 + var_223_18 and arg_220_1.time_ < var_223_15 + var_223_18 + arg_223_0 then
				var_223_14.localPosition = Vector3.New(390, -410, -235)
			end

			local var_223_21 = 0
			local var_223_22 = 0.7

			if var_223_21 < arg_220_1.time_ and arg_220_1.time_ <= var_223_21 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_23 = arg_220_1:FormatText(StoryNameCfg[369].name)

				arg_220_1.leftNameTxt_.text = var_223_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_24 = arg_220_1:GetWordFromCfg(117081053)
				local var_223_25 = arg_220_1:FormatText(var_223_24.content)

				arg_220_1.text_.text = var_223_25

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_26 = 28
				local var_223_27 = utf8.len(var_223_25)
				local var_223_28 = var_223_26 <= 0 and var_223_22 or var_223_22 * (var_223_27 / var_223_26)

				if var_223_28 > 0 and var_223_22 < var_223_28 then
					arg_220_1.talkMaxDuration = var_223_28

					if var_223_28 + var_223_21 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_28 + var_223_21
					end
				end

				arg_220_1.text_.text = var_223_25
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081053", "story_v_out_117081.awb") ~= 0 then
					local var_223_29 = manager.audio:GetVoiceLength("story_v_out_117081", "117081053", "story_v_out_117081.awb") / 1000

					if var_223_29 + var_223_21 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_29 + var_223_21
					end

					if var_223_24.prefab_name ~= "" and arg_220_1.actors_[var_223_24.prefab_name] ~= nil then
						local var_223_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_24.prefab_name].transform, "story_v_out_117081", "117081053", "story_v_out_117081.awb")

						arg_220_1:RecordAudio("117081053", var_223_30)
						arg_220_1:RecordAudio("117081053", var_223_30)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_117081", "117081053", "story_v_out_117081.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_117081", "117081053", "story_v_out_117081.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_31 = math.max(var_223_22, arg_220_1.talkMaxDuration)

			if var_223_21 <= arg_220_1.time_ and arg_220_1.time_ < var_223_21 + var_223_31 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_21) / var_223_31

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_21 + var_223_31 and arg_220_1.time_ < var_223_21 + var_223_31 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play117081054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 117081054
		arg_224_1.duration_ = 3.5

		local var_224_0 = {
			zh = 3.5,
			ja = 1.7
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play117081055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1132"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				local var_227_2 = var_227_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_227_2 then
					arg_224_1.var_.alphaOldValue1132 = var_227_2.alpha
					arg_224_1.var_.characterEffect1132 = var_227_2
				end

				arg_224_1.var_.alphaOldValue1132 = 0
			end

			local var_227_3 = 0.333333333333333

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_3 then
				local var_227_4 = (arg_224_1.time_ - var_227_1) / var_227_3
				local var_227_5 = Mathf.Lerp(arg_224_1.var_.alphaOldValue1132, 1, var_227_4)

				if arg_224_1.var_.characterEffect1132 then
					arg_224_1.var_.characterEffect1132.alpha = var_227_5
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_3 and arg_224_1.time_ < var_227_1 + var_227_3 + arg_227_0 and arg_224_1.var_.characterEffect1132 then
				arg_224_1.var_.characterEffect1132.alpha = 1
			end

			local var_227_6 = arg_224_1.actors_["1132"]
			local var_227_7 = 0

			if var_227_7 < arg_224_1.time_ and arg_224_1.time_ <= var_227_7 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.actorSpriteComps1132 == nil then
				arg_224_1.var_.actorSpriteComps1132 = var_227_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_8 = 0.2

			if var_227_7 <= arg_224_1.time_ and arg_224_1.time_ < var_227_7 + var_227_8 and not isNil(var_227_6) then
				local var_227_9 = (arg_224_1.time_ - var_227_7) / var_227_8

				if arg_224_1.var_.actorSpriteComps1132 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_10 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor2.r, var_227_9)
								local var_227_11 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor2.g, var_227_9)
								local var_227_12 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor2.b, var_227_9)

								iter_227_1.color = Color.New(var_227_10, var_227_11, var_227_12)
							else
								local var_227_13 = Mathf.Lerp(iter_227_1.color.r, 0.5, var_227_9)

								iter_227_1.color = Color.New(var_227_13, var_227_13, var_227_13)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_7 + var_227_8 and arg_224_1.time_ < var_227_7 + var_227_8 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.actorSpriteComps1132 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1132 = nil
			end

			local var_227_14 = arg_224_1.actors_["1132"].transform
			local var_227_15 = 0

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.var_.moveOldPos1132 = var_227_14.localPosition
				var_227_14.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("1132", 2)

				local var_227_16 = var_227_14.childCount

				for iter_227_4 = 0, var_227_16 - 1 do
					local var_227_17 = var_227_14:GetChild(iter_227_4)

					if var_227_17.name == "split_6" or not string.find(var_227_17.name, "split") then
						var_227_17.gameObject:SetActive(true)
					else
						var_227_17.gameObject:SetActive(false)
					end
				end
			end

			local var_227_18 = 0.001

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_18 then
				local var_227_19 = (arg_224_1.time_ - var_227_15) / var_227_18
				local var_227_20 = Vector3.New(-390, -410, -235)

				var_227_14.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1132, var_227_20, var_227_19)
			end

			if arg_224_1.time_ >= var_227_15 + var_227_18 and arg_224_1.time_ < var_227_15 + var_227_18 + arg_227_0 then
				var_227_14.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_227_21 = arg_224_1.actors_["10035"]
			local var_227_22 = 0

			if var_227_22 < arg_224_1.time_ and arg_224_1.time_ <= var_227_22 + arg_227_0 and not isNil(var_227_21) and arg_224_1.var_.actorSpriteComps10035 == nil then
				arg_224_1.var_.actorSpriteComps10035 = var_227_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_23 = 0.2

			if var_227_22 <= arg_224_1.time_ and arg_224_1.time_ < var_227_22 + var_227_23 and not isNil(var_227_21) then
				local var_227_24 = (arg_224_1.time_ - var_227_22) / var_227_23

				if arg_224_1.var_.actorSpriteComps10035 then
					for iter_227_5, iter_227_6 in pairs(arg_224_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_227_6 then
							if arg_224_1.isInRecall_ then
								local var_227_25 = Mathf.Lerp(iter_227_6.color.r, arg_224_1.hightColor2.r, var_227_24)
								local var_227_26 = Mathf.Lerp(iter_227_6.color.g, arg_224_1.hightColor2.g, var_227_24)
								local var_227_27 = Mathf.Lerp(iter_227_6.color.b, arg_224_1.hightColor2.b, var_227_24)

								iter_227_6.color = Color.New(var_227_25, var_227_26, var_227_27)
							else
								local var_227_28 = Mathf.Lerp(iter_227_6.color.r, 0.5, var_227_24)

								iter_227_6.color = Color.New(var_227_28, var_227_28, var_227_28)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_22 + var_227_23 and arg_224_1.time_ < var_227_22 + var_227_23 + arg_227_0 and not isNil(var_227_21) and arg_224_1.var_.actorSpriteComps10035 then
				for iter_227_7, iter_227_8 in pairs(arg_224_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_227_8 then
						if arg_224_1.isInRecall_ then
							iter_227_8.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10035 = nil
			end

			local var_227_29 = arg_224_1.actors_["1132"]
			local var_227_30 = 0

			if var_227_30 < arg_224_1.time_ and arg_224_1.time_ <= var_227_30 + arg_227_0 and not isNil(var_227_29) and arg_224_1.var_.actorSpriteComps1132 == nil then
				arg_224_1.var_.actorSpriteComps1132 = var_227_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_31 = 0.2

			if var_227_30 <= arg_224_1.time_ and arg_224_1.time_ < var_227_30 + var_227_31 and not isNil(var_227_29) then
				local var_227_32 = (arg_224_1.time_ - var_227_30) / var_227_31

				if arg_224_1.var_.actorSpriteComps1132 then
					for iter_227_9, iter_227_10 in pairs(arg_224_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_227_10 then
							if arg_224_1.isInRecall_ then
								local var_227_33 = Mathf.Lerp(iter_227_10.color.r, arg_224_1.hightColor1.r, var_227_32)
								local var_227_34 = Mathf.Lerp(iter_227_10.color.g, arg_224_1.hightColor1.g, var_227_32)
								local var_227_35 = Mathf.Lerp(iter_227_10.color.b, arg_224_1.hightColor1.b, var_227_32)

								iter_227_10.color = Color.New(var_227_33, var_227_34, var_227_35)
							else
								local var_227_36 = Mathf.Lerp(iter_227_10.color.r, 1, var_227_32)

								iter_227_10.color = Color.New(var_227_36, var_227_36, var_227_36)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_30 + var_227_31 and arg_224_1.time_ < var_227_30 + var_227_31 + arg_227_0 and not isNil(var_227_29) and arg_224_1.var_.actorSpriteComps1132 then
				for iter_227_11, iter_227_12 in pairs(arg_224_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_227_12 then
						if arg_224_1.isInRecall_ then
							iter_227_12.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_12.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1132 = nil
			end

			local var_227_37 = 0
			local var_227_38 = 0.375

			if var_227_37 < arg_224_1.time_ and arg_224_1.time_ <= var_227_37 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_39 = arg_224_1:FormatText(StoryNameCfg[61].name)

				arg_224_1.leftNameTxt_.text = var_227_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_40 = arg_224_1:GetWordFromCfg(117081054)
				local var_227_41 = arg_224_1:FormatText(var_227_40.content)

				arg_224_1.text_.text = var_227_41

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_42 = 15
				local var_227_43 = utf8.len(var_227_41)
				local var_227_44 = var_227_42 <= 0 and var_227_38 or var_227_38 * (var_227_43 / var_227_42)

				if var_227_44 > 0 and var_227_38 < var_227_44 then
					arg_224_1.talkMaxDuration = var_227_44

					if var_227_44 + var_227_37 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_44 + var_227_37
					end
				end

				arg_224_1.text_.text = var_227_41
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081054", "story_v_out_117081.awb") ~= 0 then
					local var_227_45 = manager.audio:GetVoiceLength("story_v_out_117081", "117081054", "story_v_out_117081.awb") / 1000

					if var_227_45 + var_227_37 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_45 + var_227_37
					end

					if var_227_40.prefab_name ~= "" and arg_224_1.actors_[var_227_40.prefab_name] ~= nil then
						local var_227_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_40.prefab_name].transform, "story_v_out_117081", "117081054", "story_v_out_117081.awb")

						arg_224_1:RecordAudio("117081054", var_227_46)
						arg_224_1:RecordAudio("117081054", var_227_46)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_117081", "117081054", "story_v_out_117081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_117081", "117081054", "story_v_out_117081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_47 = math.max(var_227_38, arg_224_1.talkMaxDuration)

			if var_227_37 <= arg_224_1.time_ and arg_224_1.time_ < var_227_37 + var_227_47 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_37) / var_227_47

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_37 + var_227_47 and arg_224_1.time_ < var_227_37 + var_227_47 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play117081055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 117081055
		arg_228_1.duration_ = 1

		local var_228_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play117081056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10035"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10035 == nil then
				arg_228_1.var_.actorSpriteComps10035 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps10035 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor1.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor1.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor1.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 1, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10035 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10035 = nil
			end

			local var_231_8 = arg_228_1.actors_["1132"]
			local var_231_9 = 0

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1132 == nil then
				arg_228_1.var_.actorSpriteComps1132 = var_231_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_10 = 0.2

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_10 and not isNil(var_231_8) then
				local var_231_11 = (arg_228_1.time_ - var_231_9) / var_231_10

				if arg_228_1.var_.actorSpriteComps1132 then
					for iter_231_4, iter_231_5 in pairs(arg_228_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_231_5 then
							if arg_228_1.isInRecall_ then
								local var_231_12 = Mathf.Lerp(iter_231_5.color.r, arg_228_1.hightColor2.r, var_231_11)
								local var_231_13 = Mathf.Lerp(iter_231_5.color.g, arg_228_1.hightColor2.g, var_231_11)
								local var_231_14 = Mathf.Lerp(iter_231_5.color.b, arg_228_1.hightColor2.b, var_231_11)

								iter_231_5.color = Color.New(var_231_12, var_231_13, var_231_14)
							else
								local var_231_15 = Mathf.Lerp(iter_231_5.color.r, 0.5, var_231_11)

								iter_231_5.color = Color.New(var_231_15, var_231_15, var_231_15)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_9 + var_231_10 and arg_228_1.time_ < var_231_9 + var_231_10 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1132 then
				for iter_231_6, iter_231_7 in pairs(arg_228_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_231_7 then
						if arg_228_1.isInRecall_ then
							iter_231_7.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps1132 = nil
			end

			local var_231_16 = 0
			local var_231_17 = 0.075

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_18 = arg_228_1:FormatText(StoryNameCfg[369].name)

				arg_228_1.leftNameTxt_.text = var_231_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(117081055)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_21 = 3
				local var_231_22 = utf8.len(var_231_20)
				local var_231_23 = var_231_21 <= 0 and var_231_17 or var_231_17 * (var_231_22 / var_231_21)

				if var_231_23 > 0 and var_231_17 < var_231_23 then
					arg_228_1.talkMaxDuration = var_231_23

					if var_231_23 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_16
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081055", "story_v_out_117081.awb") ~= 0 then
					local var_231_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081055", "story_v_out_117081.awb") / 1000

					if var_231_24 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_24 + var_231_16
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_117081", "117081055", "story_v_out_117081.awb")

						arg_228_1:RecordAudio("117081055", var_231_25)
						arg_228_1:RecordAudio("117081055", var_231_25)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_117081", "117081055", "story_v_out_117081.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_117081", "117081055", "story_v_out_117081.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_26 = math.max(var_231_17, arg_228_1.talkMaxDuration)

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_26 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_16) / var_231_26

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_16 + var_231_26 and arg_228_1.time_ < var_231_16 + var_231_26 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play117081056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 117081056
		arg_232_1.duration_ = 10.3

		local var_232_0 = {
			zh = 10.3,
			ja = 8.566
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play117081057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10035"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10035 == nil then
				arg_232_1.var_.actorSpriteComps10035 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps10035 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor2.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor2.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor2.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 0.5, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps10035 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10035 = nil
			end

			local var_235_8 = arg_232_1.actors_["1132"]
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps1132 == nil then
				arg_232_1.var_.actorSpriteComps1132 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_10 = 0.2

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_10 and not isNil(var_235_8) then
				local var_235_11 = (arg_232_1.time_ - var_235_9) / var_235_10

				if arg_232_1.var_.actorSpriteComps1132 then
					for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_235_5 then
							if arg_232_1.isInRecall_ then
								local var_235_12 = Mathf.Lerp(iter_235_5.color.r, arg_232_1.hightColor1.r, var_235_11)
								local var_235_13 = Mathf.Lerp(iter_235_5.color.g, arg_232_1.hightColor1.g, var_235_11)
								local var_235_14 = Mathf.Lerp(iter_235_5.color.b, arg_232_1.hightColor1.b, var_235_11)

								iter_235_5.color = Color.New(var_235_12, var_235_13, var_235_14)
							else
								local var_235_15 = Mathf.Lerp(iter_235_5.color.r, 1, var_235_11)

								iter_235_5.color = Color.New(var_235_15, var_235_15, var_235_15)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_9 + var_235_10 and arg_232_1.time_ < var_235_9 + var_235_10 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps1132 then
				for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_235_7 then
						if arg_232_1.isInRecall_ then
							iter_235_7.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps1132 = nil
			end

			local var_235_16 = 0
			local var_235_17 = 1.1

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_18 = arg_232_1:FormatText(StoryNameCfg[61].name)

				arg_232_1.leftNameTxt_.text = var_235_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_19 = arg_232_1:GetWordFromCfg(117081056)
				local var_235_20 = arg_232_1:FormatText(var_235_19.content)

				arg_232_1.text_.text = var_235_20

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_21 = 44
				local var_235_22 = utf8.len(var_235_20)
				local var_235_23 = var_235_21 <= 0 and var_235_17 or var_235_17 * (var_235_22 / var_235_21)

				if var_235_23 > 0 and var_235_17 < var_235_23 then
					arg_232_1.talkMaxDuration = var_235_23

					if var_235_23 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_16
					end
				end

				arg_232_1.text_.text = var_235_20
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081056", "story_v_out_117081.awb") ~= 0 then
					local var_235_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081056", "story_v_out_117081.awb") / 1000

					if var_235_24 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_24 + var_235_16
					end

					if var_235_19.prefab_name ~= "" and arg_232_1.actors_[var_235_19.prefab_name] ~= nil then
						local var_235_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_19.prefab_name].transform, "story_v_out_117081", "117081056", "story_v_out_117081.awb")

						arg_232_1:RecordAudio("117081056", var_235_25)
						arg_232_1:RecordAudio("117081056", var_235_25)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_117081", "117081056", "story_v_out_117081.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_117081", "117081056", "story_v_out_117081.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_26 = math.max(var_235_17, arg_232_1.talkMaxDuration)

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_26 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_16) / var_235_26

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_16 + var_235_26 and arg_232_1.time_ < var_235_16 + var_235_26 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play117081057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 117081057
		arg_236_1.duration_ = 6.6

		local var_236_0 = {
			zh = 6.6,
			ja = 5.633
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play117081058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.95

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[61].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:GetWordFromCfg(117081057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 38
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081057", "story_v_out_117081.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081057", "story_v_out_117081.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_117081", "117081057", "story_v_out_117081.awb")

						arg_236_1:RecordAudio("117081057", var_239_9)
						arg_236_1:RecordAudio("117081057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_117081", "117081057", "story_v_out_117081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_117081", "117081057", "story_v_out_117081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play117081058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 117081058
		arg_240_1.duration_ = 8.73

		local var_240_0 = {
			zh = 8.733,
			ja = 5.8
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play117081059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.1

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[61].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(117081058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 44
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081058", "story_v_out_117081.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081058", "story_v_out_117081.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_117081", "117081058", "story_v_out_117081.awb")

						arg_240_1:RecordAudio("117081058", var_243_9)
						arg_240_1:RecordAudio("117081058", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_117081", "117081058", "story_v_out_117081.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_117081", "117081058", "story_v_out_117081.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play117081059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 117081059
		arg_244_1.duration_ = 4.87

		local var_244_0 = {
			zh = 3.233,
			ja = 4.866
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play117081060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10035"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10035 == nil then
				arg_244_1.var_.actorSpriteComps10035 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps10035 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10035 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10035 = nil
			end

			local var_247_8 = arg_244_1.actors_["1132"]
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1132 == nil then
				arg_244_1.var_.actorSpriteComps1132 = var_247_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_10 = 0.2

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 and not isNil(var_247_8) then
				local var_247_11 = (arg_244_1.time_ - var_247_9) / var_247_10

				if arg_244_1.var_.actorSpriteComps1132 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								local var_247_12 = Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor2.r, var_247_11)
								local var_247_13 = Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor2.g, var_247_11)
								local var_247_14 = Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor2.b, var_247_11)

								iter_247_5.color = Color.New(var_247_12, var_247_13, var_247_14)
							else
								local var_247_15 = Mathf.Lerp(iter_247_5.color.r, 0.5, var_247_11)

								iter_247_5.color = Color.New(var_247_15, var_247_15, var_247_15)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1132 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_247_7 then
						if arg_244_1.isInRecall_ then
							iter_247_7.color = arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_247_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1132 = nil
			end

			local var_247_16 = 0
			local var_247_17 = 0.4

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_18 = arg_244_1:FormatText(StoryNameCfg[369].name)

				arg_244_1.leftNameTxt_.text = var_247_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_19 = arg_244_1:GetWordFromCfg(117081059)
				local var_247_20 = arg_244_1:FormatText(var_247_19.content)

				arg_244_1.text_.text = var_247_20

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_21 = 16
				local var_247_22 = utf8.len(var_247_20)
				local var_247_23 = var_247_21 <= 0 and var_247_17 or var_247_17 * (var_247_22 / var_247_21)

				if var_247_23 > 0 and var_247_17 < var_247_23 then
					arg_244_1.talkMaxDuration = var_247_23

					if var_247_23 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_16
					end
				end

				arg_244_1.text_.text = var_247_20
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081059", "story_v_out_117081.awb") ~= 0 then
					local var_247_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081059", "story_v_out_117081.awb") / 1000

					if var_247_24 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_24 + var_247_16
					end

					if var_247_19.prefab_name ~= "" and arg_244_1.actors_[var_247_19.prefab_name] ~= nil then
						local var_247_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_19.prefab_name].transform, "story_v_out_117081", "117081059", "story_v_out_117081.awb")

						arg_244_1:RecordAudio("117081059", var_247_25)
						arg_244_1:RecordAudio("117081059", var_247_25)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_117081", "117081059", "story_v_out_117081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_117081", "117081059", "story_v_out_117081.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_26 = math.max(var_247_17, arg_244_1.talkMaxDuration)

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_26 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_16) / var_247_26

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_16 + var_247_26 and arg_244_1.time_ < var_247_16 + var_247_26 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play117081060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 117081060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play117081061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10035"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10035 == nil then
				arg_248_1.var_.actorSpriteComps10035 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps10035 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor2.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor2.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor2.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 0.5, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps10035 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps10035 = nil
			end

			local var_251_8 = 0
			local var_251_9 = 0.725

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:GetWordFromCfg(117081060)
				local var_251_11 = arg_248_1:FormatText(var_251_10.content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_12 = 29
				local var_251_13 = utf8.len(var_251_11)
				local var_251_14 = var_251_12 <= 0 and var_251_9 or var_251_9 * (var_251_13 / var_251_12)

				if var_251_14 > 0 and var_251_9 < var_251_14 then
					arg_248_1.talkMaxDuration = var_251_14

					if var_251_14 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_15 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_15 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_15

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_15 and arg_248_1.time_ < var_251_8 + var_251_15 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play117081061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 117081061
		arg_252_1.duration_ = 6.33

		local var_252_0 = {
			zh = 4.4,
			ja = 6.333
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play117081062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10035"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10035 == nil then
				arg_252_1.var_.actorSpriteComps10035 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps10035 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor2.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor2.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor2.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 0.5, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10035 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10035 = nil
			end

			local var_255_8 = arg_252_1.actors_["1132"]
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps1132 == nil then
				arg_252_1.var_.actorSpriteComps1132 = var_255_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_10 = 0.2

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 and not isNil(var_255_8) then
				local var_255_11 = (arg_252_1.time_ - var_255_9) / var_255_10

				if arg_252_1.var_.actorSpriteComps1132 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								local var_255_12 = Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor1.r, var_255_11)
								local var_255_13 = Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor1.g, var_255_11)
								local var_255_14 = Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor1.b, var_255_11)

								iter_255_5.color = Color.New(var_255_12, var_255_13, var_255_14)
							else
								local var_255_15 = Mathf.Lerp(iter_255_5.color.r, 1, var_255_11)

								iter_255_5.color = Color.New(var_255_15, var_255_15, var_255_15)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps1132 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_255_7 then
						if arg_252_1.isInRecall_ then
							iter_255_7.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps1132 = nil
			end

			local var_255_16 = 0
			local var_255_17 = 0.475

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_18 = arg_252_1:FormatText(StoryNameCfg[61].name)

				arg_252_1.leftNameTxt_.text = var_255_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_19 = arg_252_1:GetWordFromCfg(117081061)
				local var_255_20 = arg_252_1:FormatText(var_255_19.content)

				arg_252_1.text_.text = var_255_20

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_21 = 19
				local var_255_22 = utf8.len(var_255_20)
				local var_255_23 = var_255_21 <= 0 and var_255_17 or var_255_17 * (var_255_22 / var_255_21)

				if var_255_23 > 0 and var_255_17 < var_255_23 then
					arg_252_1.talkMaxDuration = var_255_23

					if var_255_23 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_16
					end
				end

				arg_252_1.text_.text = var_255_20
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081061", "story_v_out_117081.awb") ~= 0 then
					local var_255_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081061", "story_v_out_117081.awb") / 1000

					if var_255_24 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_16
					end

					if var_255_19.prefab_name ~= "" and arg_252_1.actors_[var_255_19.prefab_name] ~= nil then
						local var_255_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_19.prefab_name].transform, "story_v_out_117081", "117081061", "story_v_out_117081.awb")

						arg_252_1:RecordAudio("117081061", var_255_25)
						arg_252_1:RecordAudio("117081061", var_255_25)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_117081", "117081061", "story_v_out_117081.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_117081", "117081061", "story_v_out_117081.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_26 = math.max(var_255_17, arg_252_1.talkMaxDuration)

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_26 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_16) / var_255_26

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_16 + var_255_26 and arg_252_1.time_ < var_255_16 + var_255_26 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play117081062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 117081062
		arg_256_1.duration_ = 15.43

		local var_256_0 = {
			zh = 11.7,
			ja = 15.433
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play117081063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.2

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[61].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(117081062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 48
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081062", "story_v_out_117081.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081062", "story_v_out_117081.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_117081", "117081062", "story_v_out_117081.awb")

						arg_256_1:RecordAudio("117081062", var_259_9)
						arg_256_1:RecordAudio("117081062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_117081", "117081062", "story_v_out_117081.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_117081", "117081062", "story_v_out_117081.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play117081063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 117081063
		arg_260_1.duration_ = 16.9

		local var_260_0 = {
			zh = 16.9,
			ja = 14.466
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play117081064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 2

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[61].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(117081063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 80
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081063", "story_v_out_117081.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081063", "story_v_out_117081.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_117081", "117081063", "story_v_out_117081.awb")

						arg_260_1:RecordAudio("117081063", var_263_9)
						arg_260_1:RecordAudio("117081063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_117081", "117081063", "story_v_out_117081.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_117081", "117081063", "story_v_out_117081.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play117081064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 117081064
		arg_264_1.duration_ = 14.07

		local var_264_0 = {
			zh = 8.133,
			ja = 14.066
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play117081065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.95

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[61].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:GetWordFromCfg(117081064)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 38
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081064", "story_v_out_117081.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081064", "story_v_out_117081.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_117081", "117081064", "story_v_out_117081.awb")

						arg_264_1:RecordAudio("117081064", var_267_9)
						arg_264_1:RecordAudio("117081064", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_117081", "117081064", "story_v_out_117081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_117081", "117081064", "story_v_out_117081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play117081065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 117081065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play117081066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1132"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps1132 == nil then
				arg_268_1.var_.actorSpriteComps1132 = var_271_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_2 = 0.2

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.actorSpriteComps1132 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								local var_271_4 = Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, var_271_3)
								local var_271_5 = Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, var_271_3)
								local var_271_6 = Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, var_271_3)

								iter_271_1.color = Color.New(var_271_4, var_271_5, var_271_6)
							else
								local var_271_7 = Mathf.Lerp(iter_271_1.color.r, 0.5, var_271_3)

								iter_271_1.color = Color.New(var_271_7, var_271_7, var_271_7)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps1132 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_271_3 then
						if arg_268_1.isInRecall_ then
							iter_271_3.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps1132 = nil
			end

			local var_271_8 = 0
			local var_271_9 = 0.775

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_10 = arg_268_1:GetWordFromCfg(117081065)
				local var_271_11 = arg_268_1:FormatText(var_271_10.content)

				arg_268_1.text_.text = var_271_11

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_12 = 31
				local var_271_13 = utf8.len(var_271_11)
				local var_271_14 = var_271_12 <= 0 and var_271_9 or var_271_9 * (var_271_13 / var_271_12)

				if var_271_14 > 0 and var_271_9 < var_271_14 then
					arg_268_1.talkMaxDuration = var_271_14

					if var_271_14 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_14 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_11
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_15 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_15 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_15

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_15 and arg_268_1.time_ < var_271_8 + var_271_15 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play117081066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 117081066
		arg_272_1.duration_ = 9.17

		local var_272_0 = {
			zh = 9.166,
			ja = 4.566
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play117081067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10035"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.actorSpriteComps10035 == nil then
				arg_272_1.var_.actorSpriteComps10035 = var_275_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_2 = 0.2

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.actorSpriteComps10035 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								local var_275_4 = Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor1.r, var_275_3)
								local var_275_5 = Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor1.g, var_275_3)
								local var_275_6 = Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor1.b, var_275_3)

								iter_275_1.color = Color.New(var_275_4, var_275_5, var_275_6)
							else
								local var_275_7 = Mathf.Lerp(iter_275_1.color.r, 1, var_275_3)

								iter_275_1.color = Color.New(var_275_7, var_275_7, var_275_7)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.actorSpriteComps10035 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_275_3 then
						if arg_272_1.isInRecall_ then
							iter_275_3.color = arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_275_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_272_1.var_.actorSpriteComps10035 = nil
			end

			local var_275_8 = 0
			local var_275_9 = 0.95

			if var_275_8 < arg_272_1.time_ and arg_272_1.time_ <= var_275_8 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_10 = arg_272_1:FormatText(StoryNameCfg[369].name)

				arg_272_1.leftNameTxt_.text = var_275_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_11 = arg_272_1:GetWordFromCfg(117081066)
				local var_275_12 = arg_272_1:FormatText(var_275_11.content)

				arg_272_1.text_.text = var_275_12

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_13 = 37
				local var_275_14 = utf8.len(var_275_12)
				local var_275_15 = var_275_13 <= 0 and var_275_9 or var_275_9 * (var_275_14 / var_275_13)

				if var_275_15 > 0 and var_275_9 < var_275_15 then
					arg_272_1.talkMaxDuration = var_275_15

					if var_275_15 + var_275_8 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_15 + var_275_8
					end
				end

				arg_272_1.text_.text = var_275_12
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081066", "story_v_out_117081.awb") ~= 0 then
					local var_275_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081066", "story_v_out_117081.awb") / 1000

					if var_275_16 + var_275_8 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_16 + var_275_8
					end

					if var_275_11.prefab_name ~= "" and arg_272_1.actors_[var_275_11.prefab_name] ~= nil then
						local var_275_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_11.prefab_name].transform, "story_v_out_117081", "117081066", "story_v_out_117081.awb")

						arg_272_1:RecordAudio("117081066", var_275_17)
						arg_272_1:RecordAudio("117081066", var_275_17)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_117081", "117081066", "story_v_out_117081.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_117081", "117081066", "story_v_out_117081.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_18 = math.max(var_275_9, arg_272_1.talkMaxDuration)

			if var_275_8 <= arg_272_1.time_ and arg_272_1.time_ < var_275_8 + var_275_18 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_8) / var_275_18

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_8 + var_275_18 and arg_272_1.time_ < var_275_8 + var_275_18 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play117081067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 117081067
		arg_276_1.duration_ = 6.63

		local var_276_0 = {
			zh = 4.033,
			ja = 6.633
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play117081068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10035"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10035 == nil then
				arg_276_1.var_.actorSpriteComps10035 = var_279_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_2 = 0.2

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.actorSpriteComps10035 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								local var_279_4 = Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor2.r, var_279_3)
								local var_279_5 = Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor2.g, var_279_3)
								local var_279_6 = Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor2.b, var_279_3)

								iter_279_1.color = Color.New(var_279_4, var_279_5, var_279_6)
							else
								local var_279_7 = Mathf.Lerp(iter_279_1.color.r, 0.5, var_279_3)

								iter_279_1.color = Color.New(var_279_7, var_279_7, var_279_7)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps10035 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_279_3 then
						if arg_276_1.isInRecall_ then
							iter_279_3.color = arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_279_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10035 = nil
			end

			local var_279_8 = 0
			local var_279_9 = 0.45

			if var_279_8 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_10 = arg_276_1:FormatText(StoryNameCfg[367].name)

				arg_276_1.leftNameTxt_.text = var_279_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_11 = arg_276_1:GetWordFromCfg(117081067)
				local var_279_12 = arg_276_1:FormatText(var_279_11.content)

				arg_276_1.text_.text = var_279_12

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 18
				local var_279_14 = utf8.len(var_279_12)
				local var_279_15 = var_279_13 <= 0 and var_279_9 or var_279_9 * (var_279_14 / var_279_13)

				if var_279_15 > 0 and var_279_9 < var_279_15 then
					arg_276_1.talkMaxDuration = var_279_15

					if var_279_15 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_15 + var_279_8
					end
				end

				arg_276_1.text_.text = var_279_12
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081067", "story_v_out_117081.awb") ~= 0 then
					local var_279_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081067", "story_v_out_117081.awb") / 1000

					if var_279_16 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_16 + var_279_8
					end

					if var_279_11.prefab_name ~= "" and arg_276_1.actors_[var_279_11.prefab_name] ~= nil then
						local var_279_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_11.prefab_name].transform, "story_v_out_117081", "117081067", "story_v_out_117081.awb")

						arg_276_1:RecordAudio("117081067", var_279_17)
						arg_276_1:RecordAudio("117081067", var_279_17)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_117081", "117081067", "story_v_out_117081.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_117081", "117081067", "story_v_out_117081.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_18 = math.max(var_279_9, arg_276_1.talkMaxDuration)

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_18 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_8) / var_279_18

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_8 + var_279_18 and arg_276_1.time_ < var_279_8 + var_279_18 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play117081068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 117081068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play117081069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.55

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(117081068)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 22
				local var_283_5 = utf8.len(var_283_3)
				local var_283_6 = var_283_4 <= 0 and var_283_1 or var_283_1 * (var_283_5 / var_283_4)

				if var_283_6 > 0 and var_283_1 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_7 and arg_280_1.time_ < var_283_0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play117081069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 117081069
		arg_284_1.duration_ = 9.93

		local var_284_0 = {
			zh = 9.933,
			ja = 7.2
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play117081070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1132"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1132 == nil then
				arg_284_1.var_.actorSpriteComps1132 = var_287_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.actorSpriteComps1132 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								local var_287_4 = Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor1.r, var_287_3)
								local var_287_5 = Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor1.g, var_287_3)
								local var_287_6 = Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor1.b, var_287_3)

								iter_287_1.color = Color.New(var_287_4, var_287_5, var_287_6)
							else
								local var_287_7 = Mathf.Lerp(iter_287_1.color.r, 1, var_287_3)

								iter_287_1.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1132 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_287_3 then
						if arg_284_1.isInRecall_ then
							iter_287_3.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps1132 = nil
			end

			local var_287_8 = 0
			local var_287_9 = 0.9

			if var_287_8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_10 = arg_284_1:FormatText(StoryNameCfg[61].name)

				arg_284_1.leftNameTxt_.text = var_287_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_11 = arg_284_1:GetWordFromCfg(117081069)
				local var_287_12 = arg_284_1:FormatText(var_287_11.content)

				arg_284_1.text_.text = var_287_12

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 36
				local var_287_14 = utf8.len(var_287_12)
				local var_287_15 = var_287_13 <= 0 and var_287_9 or var_287_9 * (var_287_14 / var_287_13)

				if var_287_15 > 0 and var_287_9 < var_287_15 then
					arg_284_1.talkMaxDuration = var_287_15

					if var_287_15 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_15 + var_287_8
					end
				end

				arg_284_1.text_.text = var_287_12
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081069", "story_v_out_117081.awb") ~= 0 then
					local var_287_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081069", "story_v_out_117081.awb") / 1000

					if var_287_16 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_16 + var_287_8
					end

					if var_287_11.prefab_name ~= "" and arg_284_1.actors_[var_287_11.prefab_name] ~= nil then
						local var_287_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_11.prefab_name].transform, "story_v_out_117081", "117081069", "story_v_out_117081.awb")

						arg_284_1:RecordAudio("117081069", var_287_17)
						arg_284_1:RecordAudio("117081069", var_287_17)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_117081", "117081069", "story_v_out_117081.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_117081", "117081069", "story_v_out_117081.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_18 = math.max(var_287_9, arg_284_1.talkMaxDuration)

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_18 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_8) / var_287_18

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_8 + var_287_18 and arg_284_1.time_ < var_287_8 + var_287_18 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play117081070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 117081070
		arg_288_1.duration_ = 9.1

		local var_288_0 = {
			zh = 6.8,
			ja = 9.1
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play117081071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.6

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[61].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:GetWordFromCfg(117081070)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 24
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081070", "story_v_out_117081.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_117081", "117081070", "story_v_out_117081.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_117081", "117081070", "story_v_out_117081.awb")

						arg_288_1:RecordAudio("117081070", var_291_9)
						arg_288_1:RecordAudio("117081070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_117081", "117081070", "story_v_out_117081.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_117081", "117081070", "story_v_out_117081.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play117081071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 117081071
		arg_292_1.duration_ = 13.07

		local var_292_0 = {
			zh = 13.066,
			ja = 11.833
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play117081072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10035"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps10035 == nil then
				arg_292_1.var_.actorSpriteComps10035 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps10035 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								local var_295_4 = Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, var_295_3)
								local var_295_5 = Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, var_295_3)
								local var_295_6 = Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, var_295_3)

								iter_295_1.color = Color.New(var_295_4, var_295_5, var_295_6)
							else
								local var_295_7 = Mathf.Lerp(iter_295_1.color.r, 1, var_295_3)

								iter_295_1.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps10035 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps10035 = nil
			end

			local var_295_8 = arg_292_1.actors_["1132"]
			local var_295_9 = 0

			if var_295_9 < arg_292_1.time_ and arg_292_1.time_ <= var_295_9 + arg_295_0 and not isNil(var_295_8) and arg_292_1.var_.actorSpriteComps1132 == nil then
				arg_292_1.var_.actorSpriteComps1132 = var_295_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_10 = 0.2

			if var_295_9 <= arg_292_1.time_ and arg_292_1.time_ < var_295_9 + var_295_10 and not isNil(var_295_8) then
				local var_295_11 = (arg_292_1.time_ - var_295_9) / var_295_10

				if arg_292_1.var_.actorSpriteComps1132 then
					for iter_295_4, iter_295_5 in pairs(arg_292_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_295_5 then
							if arg_292_1.isInRecall_ then
								local var_295_12 = Mathf.Lerp(iter_295_5.color.r, arg_292_1.hightColor2.r, var_295_11)
								local var_295_13 = Mathf.Lerp(iter_295_5.color.g, arg_292_1.hightColor2.g, var_295_11)
								local var_295_14 = Mathf.Lerp(iter_295_5.color.b, arg_292_1.hightColor2.b, var_295_11)

								iter_295_5.color = Color.New(var_295_12, var_295_13, var_295_14)
							else
								local var_295_15 = Mathf.Lerp(iter_295_5.color.r, 0.5, var_295_11)

								iter_295_5.color = Color.New(var_295_15, var_295_15, var_295_15)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_9 + var_295_10 and arg_292_1.time_ < var_295_9 + var_295_10 + arg_295_0 and not isNil(var_295_8) and arg_292_1.var_.actorSpriteComps1132 then
				for iter_295_6, iter_295_7 in pairs(arg_292_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_295_7 then
						if arg_292_1.isInRecall_ then
							iter_295_7.color = arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_295_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps1132 = nil
			end

			local var_295_16 = 0
			local var_295_17 = 1.375

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_18 = arg_292_1:FormatText(StoryNameCfg[369].name)

				arg_292_1.leftNameTxt_.text = var_295_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_19 = arg_292_1:GetWordFromCfg(117081071)
				local var_295_20 = arg_292_1:FormatText(var_295_19.content)

				arg_292_1.text_.text = var_295_20

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_21 = 55
				local var_295_22 = utf8.len(var_295_20)
				local var_295_23 = var_295_21 <= 0 and var_295_17 or var_295_17 * (var_295_22 / var_295_21)

				if var_295_23 > 0 and var_295_17 < var_295_23 then
					arg_292_1.talkMaxDuration = var_295_23

					if var_295_23 + var_295_16 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_23 + var_295_16
					end
				end

				arg_292_1.text_.text = var_295_20
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081071", "story_v_out_117081.awb") ~= 0 then
					local var_295_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081071", "story_v_out_117081.awb") / 1000

					if var_295_24 + var_295_16 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_24 + var_295_16
					end

					if var_295_19.prefab_name ~= "" and arg_292_1.actors_[var_295_19.prefab_name] ~= nil then
						local var_295_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_19.prefab_name].transform, "story_v_out_117081", "117081071", "story_v_out_117081.awb")

						arg_292_1:RecordAudio("117081071", var_295_25)
						arg_292_1:RecordAudio("117081071", var_295_25)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_117081", "117081071", "story_v_out_117081.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_117081", "117081071", "story_v_out_117081.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_26 = math.max(var_295_17, arg_292_1.talkMaxDuration)

			if var_295_16 <= arg_292_1.time_ and arg_292_1.time_ < var_295_16 + var_295_26 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_16) / var_295_26

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_16 + var_295_26 and arg_292_1.time_ < var_295_16 + var_295_26 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play117081072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 117081072
		arg_296_1.duration_ = 7.97

		local var_296_0 = {
			zh = 7.966,
			ja = 2.166
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play117081073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10035"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10035 == nil then
				arg_296_1.var_.actorSpriteComps10035 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps10035 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								local var_299_4 = Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, var_299_3)
								local var_299_5 = Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, var_299_3)
								local var_299_6 = Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, var_299_3)

								iter_299_1.color = Color.New(var_299_4, var_299_5, var_299_6)
							else
								local var_299_7 = Mathf.Lerp(iter_299_1.color.r, 0.5, var_299_3)

								iter_299_1.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10035 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10035 = nil
			end

			local var_299_8 = arg_296_1.actors_["1132"]
			local var_299_9 = 0

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 and not isNil(var_299_8) and arg_296_1.var_.actorSpriteComps1132 == nil then
				arg_296_1.var_.actorSpriteComps1132 = var_299_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_10 = 0.2

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_10 and not isNil(var_299_8) then
				local var_299_11 = (arg_296_1.time_ - var_299_9) / var_299_10

				if arg_296_1.var_.actorSpriteComps1132 then
					for iter_299_4, iter_299_5 in pairs(arg_296_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_299_5 then
							if arg_296_1.isInRecall_ then
								local var_299_12 = Mathf.Lerp(iter_299_5.color.r, arg_296_1.hightColor1.r, var_299_11)
								local var_299_13 = Mathf.Lerp(iter_299_5.color.g, arg_296_1.hightColor1.g, var_299_11)
								local var_299_14 = Mathf.Lerp(iter_299_5.color.b, arg_296_1.hightColor1.b, var_299_11)

								iter_299_5.color = Color.New(var_299_12, var_299_13, var_299_14)
							else
								local var_299_15 = Mathf.Lerp(iter_299_5.color.r, 1, var_299_11)

								iter_299_5.color = Color.New(var_299_15, var_299_15, var_299_15)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_9 + var_299_10 and arg_296_1.time_ < var_299_9 + var_299_10 + arg_299_0 and not isNil(var_299_8) and arg_296_1.var_.actorSpriteComps1132 then
				for iter_299_6, iter_299_7 in pairs(arg_296_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_299_7 then
						if arg_296_1.isInRecall_ then
							iter_299_7.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps1132 = nil
			end

			local var_299_16 = 0
			local var_299_17 = 0.575

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_18 = arg_296_1:FormatText(StoryNameCfg[61].name)

				arg_296_1.leftNameTxt_.text = var_299_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_19 = arg_296_1:GetWordFromCfg(117081072)
				local var_299_20 = arg_296_1:FormatText(var_299_19.content)

				arg_296_1.text_.text = var_299_20

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_21 = 23
				local var_299_22 = utf8.len(var_299_20)
				local var_299_23 = var_299_21 <= 0 and var_299_17 or var_299_17 * (var_299_22 / var_299_21)

				if var_299_23 > 0 and var_299_17 < var_299_23 then
					arg_296_1.talkMaxDuration = var_299_23

					if var_299_23 + var_299_16 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_23 + var_299_16
					end
				end

				arg_296_1.text_.text = var_299_20
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081072", "story_v_out_117081.awb") ~= 0 then
					local var_299_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081072", "story_v_out_117081.awb") / 1000

					if var_299_24 + var_299_16 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_24 + var_299_16
					end

					if var_299_19.prefab_name ~= "" and arg_296_1.actors_[var_299_19.prefab_name] ~= nil then
						local var_299_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_19.prefab_name].transform, "story_v_out_117081", "117081072", "story_v_out_117081.awb")

						arg_296_1:RecordAudio("117081072", var_299_25)
						arg_296_1:RecordAudio("117081072", var_299_25)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_117081", "117081072", "story_v_out_117081.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_117081", "117081072", "story_v_out_117081.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_26 = math.max(var_299_17, arg_296_1.talkMaxDuration)

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_26 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_16) / var_299_26

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_16 + var_299_26 and arg_296_1.time_ < var_299_16 + var_299_26 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play117081073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 117081073
		arg_300_1.duration_ = 1.7

		local var_300_0 = {
			zh = 1.7,
			ja = 1.133
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play117081074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10035"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10035 == nil then
				arg_300_1.var_.actorSpriteComps10035 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps10035 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor1.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor1.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor1.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 1, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10035 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_303_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10035 = nil
			end

			local var_303_8 = arg_300_1.actors_["1132"]
			local var_303_9 = 0

			if var_303_9 < arg_300_1.time_ and arg_300_1.time_ <= var_303_9 + arg_303_0 and not isNil(var_303_8) and arg_300_1.var_.actorSpriteComps1132 == nil then
				arg_300_1.var_.actorSpriteComps1132 = var_303_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_10 = 0.2

			if var_303_9 <= arg_300_1.time_ and arg_300_1.time_ < var_303_9 + var_303_10 and not isNil(var_303_8) then
				local var_303_11 = (arg_300_1.time_ - var_303_9) / var_303_10

				if arg_300_1.var_.actorSpriteComps1132 then
					for iter_303_4, iter_303_5 in pairs(arg_300_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_303_5 then
							if arg_300_1.isInRecall_ then
								local var_303_12 = Mathf.Lerp(iter_303_5.color.r, arg_300_1.hightColor2.r, var_303_11)
								local var_303_13 = Mathf.Lerp(iter_303_5.color.g, arg_300_1.hightColor2.g, var_303_11)
								local var_303_14 = Mathf.Lerp(iter_303_5.color.b, arg_300_1.hightColor2.b, var_303_11)

								iter_303_5.color = Color.New(var_303_12, var_303_13, var_303_14)
							else
								local var_303_15 = Mathf.Lerp(iter_303_5.color.r, 0.5, var_303_11)

								iter_303_5.color = Color.New(var_303_15, var_303_15, var_303_15)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_9 + var_303_10 and arg_300_1.time_ < var_303_9 + var_303_10 + arg_303_0 and not isNil(var_303_8) and arg_300_1.var_.actorSpriteComps1132 then
				for iter_303_6, iter_303_7 in pairs(arg_300_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_303_7 then
						if arg_300_1.isInRecall_ then
							iter_303_7.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps1132 = nil
			end

			local var_303_16 = 0
			local var_303_17 = 0.1

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_18 = arg_300_1:FormatText(StoryNameCfg[369].name)

				arg_300_1.leftNameTxt_.text = var_303_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_19 = arg_300_1:GetWordFromCfg(117081073)
				local var_303_20 = arg_300_1:FormatText(var_303_19.content)

				arg_300_1.text_.text = var_303_20

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_21 = 4
				local var_303_22 = utf8.len(var_303_20)
				local var_303_23 = var_303_21 <= 0 and var_303_17 or var_303_17 * (var_303_22 / var_303_21)

				if var_303_23 > 0 and var_303_17 < var_303_23 then
					arg_300_1.talkMaxDuration = var_303_23

					if var_303_23 + var_303_16 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_23 + var_303_16
					end
				end

				arg_300_1.text_.text = var_303_20
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081073", "story_v_out_117081.awb") ~= 0 then
					local var_303_24 = manager.audio:GetVoiceLength("story_v_out_117081", "117081073", "story_v_out_117081.awb") / 1000

					if var_303_24 + var_303_16 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_24 + var_303_16
					end

					if var_303_19.prefab_name ~= "" and arg_300_1.actors_[var_303_19.prefab_name] ~= nil then
						local var_303_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_19.prefab_name].transform, "story_v_out_117081", "117081073", "story_v_out_117081.awb")

						arg_300_1:RecordAudio("117081073", var_303_25)
						arg_300_1:RecordAudio("117081073", var_303_25)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_117081", "117081073", "story_v_out_117081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_117081", "117081073", "story_v_out_117081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_26 = math.max(var_303_17, arg_300_1.talkMaxDuration)

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_26 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_16) / var_303_26

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_16 + var_303_26 and arg_300_1.time_ < var_303_16 + var_303_26 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play117081074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 117081074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play117081075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1132"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				local var_307_2 = var_307_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_307_2 then
					arg_304_1.var_.alphaOldValue1132 = var_307_2.alpha
					arg_304_1.var_.characterEffect1132 = var_307_2
				end

				arg_304_1.var_.alphaOldValue1132 = 1
			end

			local var_307_3 = 0.5

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_3 then
				local var_307_4 = (arg_304_1.time_ - var_307_1) / var_307_3
				local var_307_5 = Mathf.Lerp(arg_304_1.var_.alphaOldValue1132, 0, var_307_4)

				if arg_304_1.var_.characterEffect1132 then
					arg_304_1.var_.characterEffect1132.alpha = var_307_5
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_3 and arg_304_1.time_ < var_307_1 + var_307_3 + arg_307_0 and arg_304_1.var_.characterEffect1132 then
				arg_304_1.var_.characterEffect1132.alpha = 0
			end

			local var_307_6 = arg_304_1.actors_["10035"]
			local var_307_7 = 0

			if var_307_7 < arg_304_1.time_ and arg_304_1.time_ <= var_307_7 + arg_307_0 then
				local var_307_8 = var_307_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_307_8 then
					arg_304_1.var_.alphaOldValue10035 = var_307_8.alpha
					arg_304_1.var_.characterEffect10035 = var_307_8
				end

				arg_304_1.var_.alphaOldValue10035 = 1
			end

			local var_307_9 = 0.5

			if var_307_7 <= arg_304_1.time_ and arg_304_1.time_ < var_307_7 + var_307_9 then
				local var_307_10 = (arg_304_1.time_ - var_307_7) / var_307_9
				local var_307_11 = Mathf.Lerp(arg_304_1.var_.alphaOldValue10035, 0, var_307_10)

				if arg_304_1.var_.characterEffect10035 then
					arg_304_1.var_.characterEffect10035.alpha = var_307_11
				end
			end

			if arg_304_1.time_ >= var_307_7 + var_307_9 and arg_304_1.time_ < var_307_7 + var_307_9 + arg_307_0 and arg_304_1.var_.characterEffect10035 then
				arg_304_1.var_.characterEffect10035.alpha = 0
			end

			local var_307_12 = 0
			local var_307_13 = 1

			if var_307_12 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 then
				local var_307_14 = "play"
				local var_307_15 = "effect"

				arg_304_1:AudioAction(var_307_14, var_307_15, "se_story_17", "se_story_17_elecclock", "")
			end

			local var_307_16 = 0
			local var_307_17 = 1.3

			if var_307_16 < arg_304_1.time_ and arg_304_1.time_ <= var_307_16 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(117081074)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 52
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_17 or var_307_17 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_17 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_16 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_16
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_23 = math.max(var_307_17, arg_304_1.talkMaxDuration)

			if var_307_16 <= arg_304_1.time_ and arg_304_1.time_ < var_307_16 + var_307_23 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_16) / var_307_23

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_16 + var_307_23 and arg_304_1.time_ < var_307_16 + var_307_23 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play117081075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 117081075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play117081076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.65

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(117081075)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 26
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play117081076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 117081076
		arg_312_1.duration_ = 6.6

		local var_312_0 = {
			zh = 6.6,
			ja = 3.466
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play117081077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1132"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1132 == nil then
				arg_312_1.var_.actorSpriteComps1132 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1132 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 1, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1132 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1132 = nil
			end

			local var_315_8 = arg_312_1.actors_["1132"].transform
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.var_.moveOldPos1132 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1132", 2)

				local var_315_10 = var_315_8.childCount

				for iter_315_4 = 0, var_315_10 - 1 do
					local var_315_11 = var_315_8:GetChild(iter_315_4)

					if var_315_11.name == "split_6" or not string.find(var_315_11.name, "split") then
						var_315_11.gameObject:SetActive(true)
					else
						var_315_11.gameObject:SetActive(false)
					end
				end
			end

			local var_315_12 = 0.001

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_9) / var_315_12
				local var_315_14 = Vector3.New(-390, -413, -185)

				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1132, var_315_14, var_315_13)
			end

			if arg_312_1.time_ >= var_315_9 + var_315_12 and arg_312_1.time_ < var_315_9 + var_315_12 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_315_15 = arg_312_1.actors_["1132"]
			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				local var_315_17 = var_315_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_315_17 then
					arg_312_1.var_.alphaOldValue1132 = var_315_17.alpha
					arg_312_1.var_.characterEffect1132 = var_315_17
				end

				arg_312_1.var_.alphaOldValue1132 = 0
			end

			local var_315_18 = 0.5

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_18 then
				local var_315_19 = (arg_312_1.time_ - var_315_16) / var_315_18
				local var_315_20 = Mathf.Lerp(arg_312_1.var_.alphaOldValue1132, 1, var_315_19)

				if arg_312_1.var_.characterEffect1132 then
					arg_312_1.var_.characterEffect1132.alpha = var_315_20
				end
			end

			if arg_312_1.time_ >= var_315_16 + var_315_18 and arg_312_1.time_ < var_315_16 + var_315_18 + arg_315_0 and arg_312_1.var_.characterEffect1132 then
				arg_312_1.var_.characterEffect1132.alpha = 1
			end

			local var_315_21 = 0
			local var_315_22 = 0.475

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_23 = arg_312_1:FormatText(StoryNameCfg[61].name)

				arg_312_1.leftNameTxt_.text = var_315_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_24 = arg_312_1:GetWordFromCfg(117081076)
				local var_315_25 = arg_312_1:FormatText(var_315_24.content)

				arg_312_1.text_.text = var_315_25

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_26 = 19
				local var_315_27 = utf8.len(var_315_25)
				local var_315_28 = var_315_26 <= 0 and var_315_22 or var_315_22 * (var_315_27 / var_315_26)

				if var_315_28 > 0 and var_315_22 < var_315_28 then
					arg_312_1.talkMaxDuration = var_315_28

					if var_315_28 + var_315_21 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_28 + var_315_21
					end
				end

				arg_312_1.text_.text = var_315_25
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081076", "story_v_out_117081.awb") ~= 0 then
					local var_315_29 = manager.audio:GetVoiceLength("story_v_out_117081", "117081076", "story_v_out_117081.awb") / 1000

					if var_315_29 + var_315_21 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_29 + var_315_21
					end

					if var_315_24.prefab_name ~= "" and arg_312_1.actors_[var_315_24.prefab_name] ~= nil then
						local var_315_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_24.prefab_name].transform, "story_v_out_117081", "117081076", "story_v_out_117081.awb")

						arg_312_1:RecordAudio("117081076", var_315_30)
						arg_312_1:RecordAudio("117081076", var_315_30)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_117081", "117081076", "story_v_out_117081.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_117081", "117081076", "story_v_out_117081.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_31 = math.max(var_315_22, arg_312_1.talkMaxDuration)

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_31 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_21) / var_315_31

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_21 + var_315_31 and arg_312_1.time_ < var_315_21 + var_315_31 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play117081077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 117081077
		arg_316_1.duration_ = 2.23

		local var_316_0 = {
			zh = 2.233,
			ja = 1.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play117081078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10034"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps10034 == nil then
				arg_316_1.var_.actorSpriteComps10034 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps10034 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 1, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps10034 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps10034 = nil
			end

			local var_319_8 = arg_316_1.actors_["10034"].transform
			local var_319_9 = 0

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 then
				arg_316_1.var_.moveOldPos10034 = var_319_8.localPosition
				var_319_8.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10034", 4)

				local var_319_10 = var_319_8.childCount

				for iter_319_4 = 0, var_319_10 - 1 do
					local var_319_11 = var_319_8:GetChild(iter_319_4)

					if var_319_11.name == "split_2" or not string.find(var_319_11.name, "split") then
						var_319_11.gameObject:SetActive(true)
					else
						var_319_11.gameObject:SetActive(false)
					end
				end
			end

			local var_319_12 = 0.001

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_12 then
				local var_319_13 = (arg_316_1.time_ - var_319_9) / var_319_12
				local var_319_14 = Vector3.New(390, -413, -185)

				var_319_8.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10034, var_319_14, var_319_13)
			end

			if arg_316_1.time_ >= var_319_9 + var_319_12 and arg_316_1.time_ < var_319_9 + var_319_12 + arg_319_0 then
				var_319_8.localPosition = Vector3.New(390, -413, -185)
			end

			local var_319_15 = arg_316_1.actors_["10034"]
			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				local var_319_17 = var_319_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_319_17 then
					arg_316_1.var_.alphaOldValue10034 = var_319_17.alpha
					arg_316_1.var_.characterEffect10034 = var_319_17
				end

				arg_316_1.var_.alphaOldValue10034 = 0
			end

			local var_319_18 = 0.5

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_18 then
				local var_319_19 = (arg_316_1.time_ - var_319_16) / var_319_18
				local var_319_20 = Mathf.Lerp(arg_316_1.var_.alphaOldValue10034, 1, var_319_19)

				if arg_316_1.var_.characterEffect10034 then
					arg_316_1.var_.characterEffect10034.alpha = var_319_20
				end
			end

			if arg_316_1.time_ >= var_319_16 + var_319_18 and arg_316_1.time_ < var_319_16 + var_319_18 + arg_319_0 and arg_316_1.var_.characterEffect10034 then
				arg_316_1.var_.characterEffect10034.alpha = 1
			end

			local var_319_21 = arg_316_1.actors_["1132"]
			local var_319_22 = 0

			if var_319_22 < arg_316_1.time_ and arg_316_1.time_ <= var_319_22 + arg_319_0 and not isNil(var_319_21) and arg_316_1.var_.actorSpriteComps1132 == nil then
				arg_316_1.var_.actorSpriteComps1132 = var_319_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_23 = 0.2

			if var_319_22 <= arg_316_1.time_ and arg_316_1.time_ < var_319_22 + var_319_23 and not isNil(var_319_21) then
				local var_319_24 = (arg_316_1.time_ - var_319_22) / var_319_23

				if arg_316_1.var_.actorSpriteComps1132 then
					for iter_319_5, iter_319_6 in pairs(arg_316_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_319_6 then
							if arg_316_1.isInRecall_ then
								local var_319_25 = Mathf.Lerp(iter_319_6.color.r, arg_316_1.hightColor2.r, var_319_24)
								local var_319_26 = Mathf.Lerp(iter_319_6.color.g, arg_316_1.hightColor2.g, var_319_24)
								local var_319_27 = Mathf.Lerp(iter_319_6.color.b, arg_316_1.hightColor2.b, var_319_24)

								iter_319_6.color = Color.New(var_319_25, var_319_26, var_319_27)
							else
								local var_319_28 = Mathf.Lerp(iter_319_6.color.r, 0.5, var_319_24)

								iter_319_6.color = Color.New(var_319_28, var_319_28, var_319_28)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_22 + var_319_23 and arg_316_1.time_ < var_319_22 + var_319_23 + arg_319_0 and not isNil(var_319_21) and arg_316_1.var_.actorSpriteComps1132 then
				for iter_319_7, iter_319_8 in pairs(arg_316_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_319_8 then
						if arg_316_1.isInRecall_ then
							iter_319_8.color = arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_319_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1132 = nil
			end

			local var_319_29 = 0
			local var_319_30 = 0.15

			if var_319_29 < arg_316_1.time_ and arg_316_1.time_ <= var_319_29 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_31 = arg_316_1:FormatText(StoryNameCfg[367].name)

				arg_316_1.leftNameTxt_.text = var_319_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_32 = arg_316_1:GetWordFromCfg(117081077)
				local var_319_33 = arg_316_1:FormatText(var_319_32.content)

				arg_316_1.text_.text = var_319_33

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_34 = 6
				local var_319_35 = utf8.len(var_319_33)
				local var_319_36 = var_319_34 <= 0 and var_319_30 or var_319_30 * (var_319_35 / var_319_34)

				if var_319_36 > 0 and var_319_30 < var_319_36 then
					arg_316_1.talkMaxDuration = var_319_36

					if var_319_36 + var_319_29 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_36 + var_319_29
					end
				end

				arg_316_1.text_.text = var_319_33
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081077", "story_v_out_117081.awb") ~= 0 then
					local var_319_37 = manager.audio:GetVoiceLength("story_v_out_117081", "117081077", "story_v_out_117081.awb") / 1000

					if var_319_37 + var_319_29 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_37 + var_319_29
					end

					if var_319_32.prefab_name ~= "" and arg_316_1.actors_[var_319_32.prefab_name] ~= nil then
						local var_319_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_32.prefab_name].transform, "story_v_out_117081", "117081077", "story_v_out_117081.awb")

						arg_316_1:RecordAudio("117081077", var_319_38)
						arg_316_1:RecordAudio("117081077", var_319_38)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_117081", "117081077", "story_v_out_117081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_117081", "117081077", "story_v_out_117081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_39 = math.max(var_319_30, arg_316_1.talkMaxDuration)

			if var_319_29 <= arg_316_1.time_ and arg_316_1.time_ < var_319_29 + var_319_39 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_29) / var_319_39

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_29 + var_319_39 and arg_316_1.time_ < var_319_29 + var_319_39 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play117081078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 117081078
		arg_320_1.duration_ = 9

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play117081079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = "ST03a"

			if arg_320_1.bgs_[var_323_0] == nil then
				local var_323_1 = Object.Instantiate(arg_320_1.paintGo_)

				var_323_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_323_0)
				var_323_1.name = var_323_0
				var_323_1.transform.parent = arg_320_1.stage_.transform
				var_323_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_320_1.bgs_[var_323_0] = var_323_1
			end

			local var_323_2 = 2

			if var_323_2 < arg_320_1.time_ and arg_320_1.time_ <= var_323_2 + arg_323_0 then
				local var_323_3 = manager.ui.mainCamera.transform.localPosition
				local var_323_4 = Vector3.New(0, 0, 10) + Vector3.New(var_323_3.x, var_323_3.y, 0)
				local var_323_5 = arg_320_1.bgs_.ST03a

				var_323_5.transform.localPosition = var_323_4
				var_323_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_323_6 = var_323_5:GetComponent("SpriteRenderer")

				if var_323_6 and var_323_6.sprite then
					local var_323_7 = (var_323_5.transform.localPosition - var_323_3).z
					local var_323_8 = manager.ui.mainCameraCom_
					local var_323_9 = 2 * var_323_7 * Mathf.Tan(var_323_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_323_10 = var_323_9 * var_323_8.aspect
					local var_323_11 = var_323_6.sprite.bounds.size.x
					local var_323_12 = var_323_6.sprite.bounds.size.y
					local var_323_13 = var_323_10 / var_323_11
					local var_323_14 = var_323_9 / var_323_12
					local var_323_15 = var_323_14 < var_323_13 and var_323_13 or var_323_14

					var_323_5.transform.localScale = Vector3.New(var_323_15, var_323_15, 0)
				end

				for iter_323_0, iter_323_1 in pairs(arg_320_1.bgs_) do
					if iter_323_0 ~= "ST03a" then
						iter_323_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_323_16 = 0

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_17 = 2

			if var_323_16 <= arg_320_1.time_ and arg_320_1.time_ < var_323_16 + var_323_17 then
				local var_323_18 = (arg_320_1.time_ - var_323_16) / var_323_17
				local var_323_19 = Color.New(0, 0, 0)

				var_323_19.a = Mathf.Lerp(0, 1, var_323_18)
				arg_320_1.mask_.color = var_323_19
			end

			if arg_320_1.time_ >= var_323_16 + var_323_17 and arg_320_1.time_ < var_323_16 + var_323_17 + arg_323_0 then
				local var_323_20 = Color.New(0, 0, 0)

				var_323_20.a = 1
				arg_320_1.mask_.color = var_323_20
			end

			local var_323_21 = 2

			if var_323_21 < arg_320_1.time_ and arg_320_1.time_ <= var_323_21 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_22 = 2

			if var_323_21 <= arg_320_1.time_ and arg_320_1.time_ < var_323_21 + var_323_22 then
				local var_323_23 = (arg_320_1.time_ - var_323_21) / var_323_22
				local var_323_24 = Color.New(0, 0, 0)

				var_323_24.a = Mathf.Lerp(1, 0, var_323_23)
				arg_320_1.mask_.color = var_323_24
			end

			if arg_320_1.time_ >= var_323_21 + var_323_22 and arg_320_1.time_ < var_323_21 + var_323_22 + arg_323_0 then
				local var_323_25 = Color.New(0, 0, 0)
				local var_323_26 = 0

				arg_320_1.mask_.enabled = false
				var_323_25.a = var_323_26
				arg_320_1.mask_.color = var_323_25
			end

			local var_323_27 = arg_320_1.actors_["10034"].transform
			local var_323_28 = 1.966

			if var_323_28 < arg_320_1.time_ and arg_320_1.time_ <= var_323_28 + arg_323_0 then
				arg_320_1.var_.moveOldPos10034 = var_323_27.localPosition
				var_323_27.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10034", 7)

				local var_323_29 = var_323_27.childCount

				for iter_323_2 = 0, var_323_29 - 1 do
					local var_323_30 = var_323_27:GetChild(iter_323_2)

					if var_323_30.name == "split_2" or not string.find(var_323_30.name, "split") then
						var_323_30.gameObject:SetActive(true)
					else
						var_323_30.gameObject:SetActive(false)
					end
				end
			end

			local var_323_31 = 0.001

			if var_323_28 <= arg_320_1.time_ and arg_320_1.time_ < var_323_28 + var_323_31 then
				local var_323_32 = (arg_320_1.time_ - var_323_28) / var_323_31
				local var_323_33 = Vector3.New(0, -2000, -185)

				var_323_27.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10034, var_323_33, var_323_32)
			end

			if arg_320_1.time_ >= var_323_28 + var_323_31 and arg_320_1.time_ < var_323_28 + var_323_31 + arg_323_0 then
				var_323_27.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_323_34 = arg_320_1.actors_["1132"].transform
			local var_323_35 = 1.966

			if var_323_35 < arg_320_1.time_ and arg_320_1.time_ <= var_323_35 + arg_323_0 then
				arg_320_1.var_.moveOldPos1132 = var_323_34.localPosition
				var_323_34.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("1132", 7)

				local var_323_36 = var_323_34.childCount

				for iter_323_3 = 0, var_323_36 - 1 do
					local var_323_37 = var_323_34:GetChild(iter_323_3)

					if var_323_37.name == "split_6" or not string.find(var_323_37.name, "split") then
						var_323_37.gameObject:SetActive(true)
					else
						var_323_37.gameObject:SetActive(false)
					end
				end
			end

			local var_323_38 = 0.001

			if var_323_35 <= arg_320_1.time_ and arg_320_1.time_ < var_323_35 + var_323_38 then
				local var_323_39 = (arg_320_1.time_ - var_323_35) / var_323_38
				local var_323_40 = Vector3.New(0, -2000, -185)

				var_323_34.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1132, var_323_40, var_323_39)
			end

			if arg_320_1.time_ >= var_323_35 + var_323_38 and arg_320_1.time_ < var_323_35 + var_323_38 + arg_323_0 then
				var_323_34.localPosition = Vector3.New(0, -2000, -185)
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_41 = 4
			local var_323_42 = 1

			if var_323_41 < arg_320_1.time_ and arg_320_1.time_ <= var_323_41 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_43 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_43:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_44 = arg_320_1:GetWordFromCfg(117081078)
				local var_323_45 = arg_320_1:FormatText(var_323_44.content)

				arg_320_1.text_.text = var_323_45

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_46 = 40
				local var_323_47 = utf8.len(var_323_45)
				local var_323_48 = var_323_46 <= 0 and var_323_42 or var_323_42 * (var_323_47 / var_323_46)

				if var_323_48 > 0 and var_323_42 < var_323_48 then
					arg_320_1.talkMaxDuration = var_323_48
					var_323_41 = var_323_41 + 0.3

					if var_323_48 + var_323_41 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_48 + var_323_41
					end
				end

				arg_320_1.text_.text = var_323_45
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_49 = var_323_41 + 0.3
			local var_323_50 = math.max(var_323_42, arg_320_1.talkMaxDuration)

			if var_323_49 <= arg_320_1.time_ and arg_320_1.time_ < var_323_49 + var_323_50 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_49) / var_323_50

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_49 + var_323_50 and arg_320_1.time_ < var_323_49 + var_323_50 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play117081079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 117081079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play117081080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.35

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(117081079)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 14
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play117081080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 117081080
		arg_330_1.duration_ = 6.27

		local var_330_0 = {
			zh = 5.333,
			ja = 6.266
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play117081081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1132"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos1132 = var_333_0.localPosition
				var_333_0.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("1132", 3)

				local var_333_2 = var_333_0.childCount

				for iter_333_0 = 0, var_333_2 - 1 do
					local var_333_3 = var_333_0:GetChild(iter_333_0)

					if var_333_3.name == "split_6" or not string.find(var_333_3.name, "split") then
						var_333_3.gameObject:SetActive(true)
					else
						var_333_3.gameObject:SetActive(false)
					end
				end
			end

			local var_333_4 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_4 then
				local var_333_5 = (arg_330_1.time_ - var_333_1) / var_333_4
				local var_333_6 = Vector3.New(0, -413, -185)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1132, var_333_6, var_333_5)
			end

			if arg_330_1.time_ >= var_333_1 + var_333_4 and arg_330_1.time_ < var_333_1 + var_333_4 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, -413, -185)
			end

			local var_333_7 = arg_330_1.actors_["1132"]
			local var_333_8 = 0

			if var_333_8 < arg_330_1.time_ and arg_330_1.time_ <= var_333_8 + arg_333_0 then
				local var_333_9 = var_333_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_333_9 then
					arg_330_1.var_.alphaOldValue1132 = var_333_9.alpha
					arg_330_1.var_.characterEffect1132 = var_333_9
				end

				arg_330_1.var_.alphaOldValue1132 = 0
			end

			local var_333_10 = 0.333333333333333

			if var_333_8 <= arg_330_1.time_ and arg_330_1.time_ < var_333_8 + var_333_10 then
				local var_333_11 = (arg_330_1.time_ - var_333_8) / var_333_10
				local var_333_12 = Mathf.Lerp(arg_330_1.var_.alphaOldValue1132, 1, var_333_11)

				if arg_330_1.var_.characterEffect1132 then
					arg_330_1.var_.characterEffect1132.alpha = var_333_12
				end
			end

			if arg_330_1.time_ >= var_333_8 + var_333_10 and arg_330_1.time_ < var_333_8 + var_333_10 + arg_333_0 and arg_330_1.var_.characterEffect1132 then
				arg_330_1.var_.characterEffect1132.alpha = 1
			end

			local var_333_13 = arg_330_1.actors_["1132"]
			local var_333_14 = 0

			if var_333_14 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 and not isNil(var_333_13) and arg_330_1.var_.actorSpriteComps1132 == nil then
				arg_330_1.var_.actorSpriteComps1132 = var_333_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_15 = 0.2

			if var_333_14 <= arg_330_1.time_ and arg_330_1.time_ < var_333_14 + var_333_15 and not isNil(var_333_13) then
				local var_333_16 = (arg_330_1.time_ - var_333_14) / var_333_15

				if arg_330_1.var_.actorSpriteComps1132 then
					for iter_333_1, iter_333_2 in pairs(arg_330_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_333_2 then
							if arg_330_1.isInRecall_ then
								local var_333_17 = Mathf.Lerp(iter_333_2.color.r, arg_330_1.hightColor1.r, var_333_16)
								local var_333_18 = Mathf.Lerp(iter_333_2.color.g, arg_330_1.hightColor1.g, var_333_16)
								local var_333_19 = Mathf.Lerp(iter_333_2.color.b, arg_330_1.hightColor1.b, var_333_16)

								iter_333_2.color = Color.New(var_333_17, var_333_18, var_333_19)
							else
								local var_333_20 = Mathf.Lerp(iter_333_2.color.r, 1, var_333_16)

								iter_333_2.color = Color.New(var_333_20, var_333_20, var_333_20)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_14 + var_333_15 and arg_330_1.time_ < var_333_14 + var_333_15 + arg_333_0 and not isNil(var_333_13) and arg_330_1.var_.actorSpriteComps1132 then
				for iter_333_3, iter_333_4 in pairs(arg_330_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_333_4 then
						if arg_330_1.isInRecall_ then
							iter_333_4.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps1132 = nil
			end

			local var_333_21 = 0
			local var_333_22 = 0.525

			if var_333_21 < arg_330_1.time_ and arg_330_1.time_ <= var_333_21 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_23 = arg_330_1:FormatText(StoryNameCfg[61].name)

				arg_330_1.leftNameTxt_.text = var_333_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_24 = arg_330_1:GetWordFromCfg(117081080)
				local var_333_25 = arg_330_1:FormatText(var_333_24.content)

				arg_330_1.text_.text = var_333_25

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_26 = 21
				local var_333_27 = utf8.len(var_333_25)
				local var_333_28 = var_333_26 <= 0 and var_333_22 or var_333_22 * (var_333_27 / var_333_26)

				if var_333_28 > 0 and var_333_22 < var_333_28 then
					arg_330_1.talkMaxDuration = var_333_28

					if var_333_28 + var_333_21 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_28 + var_333_21
					end
				end

				arg_330_1.text_.text = var_333_25
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081080", "story_v_out_117081.awb") ~= 0 then
					local var_333_29 = manager.audio:GetVoiceLength("story_v_out_117081", "117081080", "story_v_out_117081.awb") / 1000

					if var_333_29 + var_333_21 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_29 + var_333_21
					end

					if var_333_24.prefab_name ~= "" and arg_330_1.actors_[var_333_24.prefab_name] ~= nil then
						local var_333_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_24.prefab_name].transform, "story_v_out_117081", "117081080", "story_v_out_117081.awb")

						arg_330_1:RecordAudio("117081080", var_333_30)
						arg_330_1:RecordAudio("117081080", var_333_30)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_117081", "117081080", "story_v_out_117081.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_117081", "117081080", "story_v_out_117081.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_31 = math.max(var_333_22, arg_330_1.talkMaxDuration)

			if var_333_21 <= arg_330_1.time_ and arg_330_1.time_ < var_333_21 + var_333_31 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_21) / var_333_31

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_21 + var_333_31 and arg_330_1.time_ < var_333_21 + var_333_31 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play117081081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 117081081
		arg_334_1.duration_ = 3.33

		local var_334_0 = {
			zh = 3.333,
			ja = 2.733
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
			arg_334_1.auto_ = false
		end

		function arg_334_1.playNext_(arg_336_0)
			arg_334_1.onStoryFinished_()
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1132"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps1132 == nil then
				arg_334_1.var_.actorSpriteComps1132 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps1132 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 0.5, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps1132 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps1132 = nil
			end

			local var_337_8 = 0
			local var_337_9 = 0.25

			if var_337_8 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_10 = arg_334_1:FormatText(StoryNameCfg[370].name)

				arg_334_1.leftNameTxt_.text = var_337_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10036_split_1")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_11 = arg_334_1:GetWordFromCfg(117081081)
				local var_337_12 = arg_334_1:FormatText(var_337_11.content)

				arg_334_1.text_.text = var_337_12

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_13 = 10
				local var_337_14 = utf8.len(var_337_12)
				local var_337_15 = var_337_13 <= 0 and var_337_9 or var_337_9 * (var_337_14 / var_337_13)

				if var_337_15 > 0 and var_337_9 < var_337_15 then
					arg_334_1.talkMaxDuration = var_337_15

					if var_337_15 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_15 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_12
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117081", "117081081", "story_v_out_117081.awb") ~= 0 then
					local var_337_16 = manager.audio:GetVoiceLength("story_v_out_117081", "117081081", "story_v_out_117081.awb") / 1000

					if var_337_16 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_16 + var_337_8
					end

					if var_337_11.prefab_name ~= "" and arg_334_1.actors_[var_337_11.prefab_name] ~= nil then
						local var_337_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_11.prefab_name].transform, "story_v_out_117081", "117081081", "story_v_out_117081.awb")

						arg_334_1:RecordAudio("117081081", var_337_17)
						arg_334_1:RecordAudio("117081081", var_337_17)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_117081", "117081081", "story_v_out_117081.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_117081", "117081081", "story_v_out_117081.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_18 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_18 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_18

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_18 and arg_334_1.time_ < var_337_8 + var_337_18 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST24a",
		"TextureConfig/Background/TI0105",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_117081.awb"
	}
}
