return {
	Play117041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117041001
		arg_1_1.duration_ = 13.57

		local var_1_0 = {
			zh = 13.566,
			ja = 8.966
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
				arg_1_0:Play117041002(arg_1_1)
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
			local var_4_29 = 1.425

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

				local var_4_32 = arg_1_1:GetWordFromCfg(117041001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041001", "story_v_out_117041.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_117041", "117041001", "story_v_out_117041.awb") / 1000

					if var_4_37 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_28
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_117041", "117041001", "story_v_out_117041.awb")

						arg_1_1:RecordAudio("117041001", var_4_38)
						arg_1_1:RecordAudio("117041001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_117041", "117041001", "story_v_out_117041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_117041", "117041001", "story_v_out_117041.awb")
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
	Play117041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 117041002
		arg_8_1.duration_ = 13.03

		local var_8_0 = {
			zh = 13.033,
			ja = 9.133
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
				arg_8_0:Play117041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.625

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

				local var_11_3 = arg_8_1:GetWordFromCfg(117041002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 65
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041002", "story_v_out_117041.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041002", "story_v_out_117041.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_117041", "117041002", "story_v_out_117041.awb")

						arg_8_1:RecordAudio("117041002", var_11_9)
						arg_8_1:RecordAudio("117041002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_117041", "117041002", "story_v_out_117041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_117041", "117041002", "story_v_out_117041.awb")
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
	Play117041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 117041003
		arg_12_1.duration_ = 11.2

		local var_12_0 = {
			zh = 11.2,
			ja = 10.266
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
				arg_12_0:Play117041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.325

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

				local var_15_3 = arg_12_1:GetWordFromCfg(117041003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041003", "story_v_out_117041.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041003", "story_v_out_117041.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_117041", "117041003", "story_v_out_117041.awb")

						arg_12_1:RecordAudio("117041003", var_15_9)
						arg_12_1:RecordAudio("117041003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_117041", "117041003", "story_v_out_117041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_117041", "117041003", "story_v_out_117041.awb")
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
	Play117041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 117041004
		arg_16_1.duration_ = 9

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play117041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "ST12"

			if arg_16_1.bgs_[var_19_0] == nil then
				local var_19_1 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_0)
				var_19_1.name = var_19_0
				var_19_1.transform.parent = arg_16_1.stage_.transform
				var_19_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_0] = var_19_1
			end

			local var_19_2 = 2

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_3 = manager.ui.mainCamera.transform.localPosition
				local var_19_4 = Vector3.New(0, 0, 10) + Vector3.New(var_19_3.x, var_19_3.y, 0)
				local var_19_5 = arg_16_1.bgs_.ST12

				var_19_5.transform.localPosition = var_19_4
				var_19_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_6 = var_19_5:GetComponent("SpriteRenderer")

				if var_19_6 and var_19_6.sprite then
					local var_19_7 = (var_19_5.transform.localPosition - var_19_3).z
					local var_19_8 = manager.ui.mainCameraCom_
					local var_19_9 = 2 * var_19_7 * Mathf.Tan(var_19_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_10 = var_19_9 * var_19_8.aspect
					local var_19_11 = var_19_6.sprite.bounds.size.x
					local var_19_12 = var_19_6.sprite.bounds.size.y
					local var_19_13 = var_19_10 / var_19_11
					local var_19_14 = var_19_9 / var_19_12
					local var_19_15 = var_19_14 < var_19_13 and var_19_13 or var_19_14

					var_19_5.transform.localScale = Vector3.New(var_19_15, var_19_15, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST12" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_17 = 2

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Color.New(0, 0, 0)

				var_19_19.a = Mathf.Lerp(0, 1, var_19_18)
				arg_16_1.mask_.color = var_19_19
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				local var_19_20 = Color.New(0, 0, 0)

				var_19_20.a = 1
				arg_16_1.mask_.color = var_19_20
			end

			local var_19_21 = 2

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_22 = 2

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_22 then
				local var_19_23 = (arg_16_1.time_ - var_19_21) / var_19_22
				local var_19_24 = Color.New(0, 0, 0)

				var_19_24.a = Mathf.Lerp(1, 0, var_19_23)
				arg_16_1.mask_.color = var_19_24
			end

			if arg_16_1.time_ >= var_19_21 + var_19_22 and arg_16_1.time_ < var_19_21 + var_19_22 + arg_19_0 then
				local var_19_25 = Color.New(0, 0, 0)
				local var_19_26 = 0

				arg_16_1.mask_.enabled = false
				var_19_25.a = var_19_26
				arg_16_1.mask_.color = var_19_25
			end

			local var_19_27 = 0
			local var_19_28 = 1

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				local var_19_29 = "play"
				local var_19_30 = "music"

				arg_16_1:AudioAction(var_19_29, var_19_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_19_31 = ""
				local var_19_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_19_32 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_32 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_32

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_32
						arg_16_1.bgmTxt2_.text = var_19_32
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_33 = 4
			local var_19_34 = 0.45

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				local var_19_35 = "play"
				local var_19_36 = "music"

				arg_16_1:AudioAction(var_19_35, var_19_36, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_19_37 = ""
				local var_19_38 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_19_38 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_38 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_38

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_38
						arg_16_1.bgmTxt2_.text = var_19_38
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_39 = 4
			local var_19_40 = 0.45

			if var_19_39 < arg_16_1.time_ and arg_16_1.time_ <= var_19_39 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_41 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_41:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_42 = arg_16_1:GetWordFromCfg(117041004)
				local var_19_43 = arg_16_1:FormatText(var_19_42.content)

				arg_16_1.text_.text = var_19_43

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_44 = 18
				local var_19_45 = utf8.len(var_19_43)
				local var_19_46 = var_19_44 <= 0 and var_19_40 or var_19_40 * (var_19_45 / var_19_44)

				if var_19_46 > 0 and var_19_40 < var_19_46 then
					arg_16_1.talkMaxDuration = var_19_46
					var_19_39 = var_19_39 + 0.3

					if var_19_46 + var_19_39 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_46 + var_19_39
					end
				end

				arg_16_1.text_.text = var_19_43
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_47 = var_19_39 + 0.3
			local var_19_48 = math.max(var_19_40, arg_16_1.talkMaxDuration)

			if var_19_47 <= arg_16_1.time_ and arg_16_1.time_ < var_19_47 + var_19_48 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_47) / var_19_48

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_47 + var_19_48 and arg_16_1.time_ < var_19_47 + var_19_48 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play117041005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 117041005
		arg_24_1.duration_ = 4.9

		local var_24_0 = {
			zh = 4.9,
			ja = 4.333
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play117041006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1029"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(var_27_1, arg_24_1.canvasGo_.transform)

					var_27_2.transform:SetSiblingIndex(1)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs(var_27_3) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_4 = arg_24_1.actors_["1029"].transform
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.var_.moveOldPos1029 = var_27_4.localPosition
				var_27_4.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1029", 2)

				local var_27_6 = var_27_4.childCount

				for iter_27_2 = 0, var_27_6 - 1 do
					local var_27_7 = var_27_4:GetChild(iter_27_2)

					if var_27_7.name == "split_1" or not string.find(var_27_7.name, "split") then
						var_27_7.gameObject:SetActive(true)
					else
						var_27_7.gameObject:SetActive(false)
					end
				end
			end

			local var_27_8 = 0.001

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_5) / var_27_8
				local var_27_10 = Vector3.New(-390, -355, -140)

				var_27_4.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1029, var_27_10, var_27_9)
			end

			if arg_24_1.time_ >= var_27_5 + var_27_8 and arg_24_1.time_ < var_27_5 + var_27_8 + arg_27_0 then
				var_27_4.localPosition = Vector3.New(-390, -355, -140)
			end

			local var_27_11 = arg_24_1.actors_["1029"]
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				local var_27_13 = var_27_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_27_13 then
					arg_24_1.var_.alphaOldValue1029 = var_27_13.alpha
					arg_24_1.var_.characterEffect1029 = var_27_13
				end

				arg_24_1.var_.alphaOldValue1029 = 0
			end

			local var_27_14 = 0.333333333333333

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Mathf.Lerp(arg_24_1.var_.alphaOldValue1029, 1, var_27_15)

				if arg_24_1.var_.characterEffect1029 then
					arg_24_1.var_.characterEffect1029.alpha = var_27_16
				end
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 and arg_24_1.var_.characterEffect1029 then
				arg_24_1.var_.characterEffect1029.alpha = 1
			end

			local var_27_17 = arg_24_1.actors_["1029"]
			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 and not isNil(var_27_17) and arg_24_1.var_.actorSpriteComps1029 == nil then
				arg_24_1.var_.actorSpriteComps1029 = var_27_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_19 = 0.2

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 and not isNil(var_27_17) then
				local var_27_20 = (arg_24_1.time_ - var_27_18) / var_27_19

				if arg_24_1.var_.actorSpriteComps1029 then
					for iter_27_3, iter_27_4 in pairs(arg_24_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_27_4 then
							if arg_24_1.isInRecall_ then
								local var_27_21 = Mathf.Lerp(iter_27_4.color.r, arg_24_1.hightColor1.r, var_27_20)
								local var_27_22 = Mathf.Lerp(iter_27_4.color.g, arg_24_1.hightColor1.g, var_27_20)
								local var_27_23 = Mathf.Lerp(iter_27_4.color.b, arg_24_1.hightColor1.b, var_27_20)

								iter_27_4.color = Color.New(var_27_21, var_27_22, var_27_23)
							else
								local var_27_24 = Mathf.Lerp(iter_27_4.color.r, 1, var_27_20)

								iter_27_4.color = Color.New(var_27_24, var_27_24, var_27_24)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 and not isNil(var_27_17) and arg_24_1.var_.actorSpriteComps1029 then
				for iter_27_5, iter_27_6 in pairs(arg_24_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_27_6 then
						if arg_24_1.isInRecall_ then
							iter_27_6.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1029 = nil
			end

			local var_27_25 = 0
			local var_27_26 = 0.625

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_27 = arg_24_1:FormatText(StoryNameCfg[319].name)

				arg_24_1.leftNameTxt_.text = var_27_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_28 = arg_24_1:GetWordFromCfg(117041005)
				local var_27_29 = arg_24_1:FormatText(var_27_28.content)

				arg_24_1.text_.text = var_27_29

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_30 = 25
				local var_27_31 = utf8.len(var_27_29)
				local var_27_32 = var_27_30 <= 0 and var_27_26 or var_27_26 * (var_27_31 / var_27_30)

				if var_27_32 > 0 and var_27_26 < var_27_32 then
					arg_24_1.talkMaxDuration = var_27_32

					if var_27_32 + var_27_25 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_32 + var_27_25
					end
				end

				arg_24_1.text_.text = var_27_29
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041005", "story_v_out_117041.awb") ~= 0 then
					local var_27_33 = manager.audio:GetVoiceLength("story_v_out_117041", "117041005", "story_v_out_117041.awb") / 1000

					if var_27_33 + var_27_25 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_25
					end

					if var_27_28.prefab_name ~= "" and arg_24_1.actors_[var_27_28.prefab_name] ~= nil then
						local var_27_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_28.prefab_name].transform, "story_v_out_117041", "117041005", "story_v_out_117041.awb")

						arg_24_1:RecordAudio("117041005", var_27_34)
						arg_24_1:RecordAudio("117041005", var_27_34)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_117041", "117041005", "story_v_out_117041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_117041", "117041005", "story_v_out_117041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_26, arg_24_1.talkMaxDuration)

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_25) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_25 + var_27_35 and arg_24_1.time_ < var_27_25 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play117041006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 117041006
		arg_28_1.duration_ = 9.4

		local var_28_0 = {
			zh = 3.933,
			ja = 9.4
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
				arg_28_0:Play117041007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1033"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

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

			local var_31_4 = arg_28_1.actors_["1033"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos1033 = var_31_4.localPosition
				var_31_4.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1033", 4)

				local var_31_6 = var_31_4.childCount

				for iter_31_2 = 0, var_31_6 - 1 do
					local var_31_7 = var_31_4:GetChild(iter_31_2)

					if var_31_7.name == "split_6" or not string.find(var_31_7.name, "split") then
						var_31_7.gameObject:SetActive(true)
					else
						var_31_7.gameObject:SetActive(false)
					end
				end
			end

			local var_31_8 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_5) / var_31_8
				local var_31_10 = Vector3.New(390, -420, 0)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1033, var_31_10, var_31_9)
			end

			if arg_28_1.time_ >= var_31_5 + var_31_8 and arg_28_1.time_ < var_31_5 + var_31_8 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(390, -420, 0)
			end

			local var_31_11 = arg_28_1.actors_["1029"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.actorSpriteComps1029 == nil then
				arg_28_1.var_.actorSpriteComps1029 = var_31_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_13 = 0.2

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.actorSpriteComps1029 then
					for iter_31_3, iter_31_4 in pairs(arg_28_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_31_4 then
							if arg_28_1.isInRecall_ then
								local var_31_15 = Mathf.Lerp(iter_31_4.color.r, arg_28_1.hightColor2.r, var_31_14)
								local var_31_16 = Mathf.Lerp(iter_31_4.color.g, arg_28_1.hightColor2.g, var_31_14)
								local var_31_17 = Mathf.Lerp(iter_31_4.color.b, arg_28_1.hightColor2.b, var_31_14)

								iter_31_4.color = Color.New(var_31_15, var_31_16, var_31_17)
							else
								local var_31_18 = Mathf.Lerp(iter_31_4.color.r, 0.5, var_31_14)

								iter_31_4.color = Color.New(var_31_18, var_31_18, var_31_18)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.actorSpriteComps1029 then
				for iter_31_5, iter_31_6 in pairs(arg_28_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_31_6 then
						if arg_28_1.isInRecall_ then
							iter_31_6.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1029 = nil
			end

			local var_31_19 = arg_28_1.actors_["1033"]
			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				local var_31_21 = var_31_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_31_21 then
					arg_28_1.var_.alphaOldValue1033 = var_31_21.alpha
					arg_28_1.var_.characterEffect1033 = var_31_21
				end

				arg_28_1.var_.alphaOldValue1033 = 0
			end

			local var_31_22 = 0.2

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_22 then
				local var_31_23 = (arg_28_1.time_ - var_31_20) / var_31_22
				local var_31_24 = Mathf.Lerp(arg_28_1.var_.alphaOldValue1033, 1, var_31_23)

				if arg_28_1.var_.characterEffect1033 then
					arg_28_1.var_.characterEffect1033.alpha = var_31_24
				end
			end

			if arg_28_1.time_ >= var_31_20 + var_31_22 and arg_28_1.time_ < var_31_20 + var_31_22 + arg_31_0 and arg_28_1.var_.characterEffect1033 then
				arg_28_1.var_.characterEffect1033.alpha = 1
			end

			local var_31_25 = 0
			local var_31_26 = 0.45

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_27 = arg_28_1:FormatText(StoryNameCfg[236].name)

				arg_28_1.leftNameTxt_.text = var_31_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_28 = arg_28_1:GetWordFromCfg(117041006)
				local var_31_29 = arg_28_1:FormatText(var_31_28.content)

				arg_28_1.text_.text = var_31_29

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_30 = 18
				local var_31_31 = utf8.len(var_31_29)
				local var_31_32 = var_31_30 <= 0 and var_31_26 or var_31_26 * (var_31_31 / var_31_30)

				if var_31_32 > 0 and var_31_26 < var_31_32 then
					arg_28_1.talkMaxDuration = var_31_32

					if var_31_32 + var_31_25 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_32 + var_31_25
					end
				end

				arg_28_1.text_.text = var_31_29
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041006", "story_v_out_117041.awb") ~= 0 then
					local var_31_33 = manager.audio:GetVoiceLength("story_v_out_117041", "117041006", "story_v_out_117041.awb") / 1000

					if var_31_33 + var_31_25 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_25
					end

					if var_31_28.prefab_name ~= "" and arg_28_1.actors_[var_31_28.prefab_name] ~= nil then
						local var_31_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_28.prefab_name].transform, "story_v_out_117041", "117041006", "story_v_out_117041.awb")

						arg_28_1:RecordAudio("117041006", var_31_34)
						arg_28_1:RecordAudio("117041006", var_31_34)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_117041", "117041006", "story_v_out_117041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_117041", "117041006", "story_v_out_117041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_35 = math.max(var_31_26, arg_28_1.talkMaxDuration)

			if var_31_25 <= arg_28_1.time_ and arg_28_1.time_ < var_31_25 + var_31_35 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_25) / var_31_35

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_25 + var_31_35 and arg_28_1.time_ < var_31_25 + var_31_35 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play117041007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 117041007
		arg_32_1.duration_ = 2.83

		local var_32_0 = {
			zh = 1.233,
			ja = 2.833
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
				arg_32_0:Play117041008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1033"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1033 == nil then
				arg_32_1.var_.actorSpriteComps1033 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps1033 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 0.5, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1033 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1033 = nil
			end

			local var_35_8 = arg_32_1.actors_["1029"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1029 == nil then
				arg_32_1.var_.actorSpriteComps1029 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps1029 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor1.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor1.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor1.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 1, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1029 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1029 = nil
			end

			local var_35_16 = 0
			local var_35_17 = 0.075

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[319].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(117041007)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041007", "story_v_out_117041.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041007", "story_v_out_117041.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_out_117041", "117041007", "story_v_out_117041.awb")

						arg_32_1:RecordAudio("117041007", var_35_25)
						arg_32_1:RecordAudio("117041007", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_117041", "117041007", "story_v_out_117041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_117041", "117041007", "story_v_out_117041.awb")
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
	Play117041008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 117041008
		arg_36_1.duration_ = 1.6

		local var_36_0 = {
			zh = 1.566,
			ja = 1.6
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
				arg_36_0:Play117041009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1033"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1033 == nil then
				arg_36_1.var_.actorSpriteComps1033 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps1033 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 1, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1033 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1033 = nil
			end

			local var_39_8 = arg_36_1.actors_["1029"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1029 == nil then
				arg_36_1.var_.actorSpriteComps1029 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps1029 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_12 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, var_39_11)
								local var_39_13 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, var_39_11)
								local var_39_14 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, var_39_11)

								iter_39_5.color = Color.New(var_39_12, var_39_13, var_39_14)
							else
								local var_39_15 = Mathf.Lerp(iter_39_5.color.r, 0.5, var_39_11)

								iter_39_5.color = Color.New(var_39_15, var_39_15, var_39_15)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1029 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1029 = nil
			end

			local var_39_16 = 0
			local var_39_17 = 0.075

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_18 = arg_36_1:FormatText(StoryNameCfg[236].name)

				arg_36_1.leftNameTxt_.text = var_39_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(117041008)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 3
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_17 or var_39_17 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_17 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041008", "story_v_out_117041.awb") ~= 0 then
					local var_39_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041008", "story_v_out_117041.awb") / 1000

					if var_39_24 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_16
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_out_117041", "117041008", "story_v_out_117041.awb")

						arg_36_1:RecordAudio("117041008", var_39_25)
						arg_36_1:RecordAudio("117041008", var_39_25)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_117041", "117041008", "story_v_out_117041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_117041", "117041008", "story_v_out_117041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_26 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_26 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_26

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_26 and arg_36_1.time_ < var_39_16 + var_39_26 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play117041009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 117041009
		arg_40_1.duration_ = 2.63

		local var_40_0 = {
			zh = 1.6,
			ja = 2.633
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
				arg_40_0:Play117041010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1033"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1033 == nil then
				arg_40_1.var_.actorSpriteComps1033 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps1033 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1033 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1033 = nil
			end

			local var_43_8 = arg_40_1.actors_["1029"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1029 == nil then
				arg_40_1.var_.actorSpriteComps1029 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps1029 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1029:ToTable()) do
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

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1029 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1029 = nil
			end

			local var_43_16 = 0
			local var_43_17 = 0.2

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_18 = arg_40_1:FormatText(StoryNameCfg[319].name)

				arg_40_1.leftNameTxt_.text = var_43_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_19 = arg_40_1:GetWordFromCfg(117041009)
				local var_43_20 = arg_40_1:FormatText(var_43_19.content)

				arg_40_1.text_.text = var_43_20

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_21 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041009", "story_v_out_117041.awb") ~= 0 then
					local var_43_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041009", "story_v_out_117041.awb") / 1000

					if var_43_24 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_24 + var_43_16
					end

					if var_43_19.prefab_name ~= "" and arg_40_1.actors_[var_43_19.prefab_name] ~= nil then
						local var_43_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_19.prefab_name].transform, "story_v_out_117041", "117041009", "story_v_out_117041.awb")

						arg_40_1:RecordAudio("117041009", var_43_25)
						arg_40_1:RecordAudio("117041009", var_43_25)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_117041", "117041009", "story_v_out_117041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_117041", "117041009", "story_v_out_117041.awb")
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
	Play117041010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 117041010
		arg_44_1.duration_ = 4.47

		local var_44_0 = {
			zh = 3.966,
			ja = 4.466
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
				arg_44_0:Play117041011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1033"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1033 == nil then
				arg_44_1.var_.actorSpriteComps1033 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps1033 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 1, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1033 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1033 = nil
			end

			local var_47_8 = arg_44_1.actors_["1029"]
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1029 == nil then
				arg_44_1.var_.actorSpriteComps1029 = var_47_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_10 = 0.2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 and not isNil(var_47_8) then
				local var_47_11 = (arg_44_1.time_ - var_47_9) / var_47_10

				if arg_44_1.var_.actorSpriteComps1029 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								local var_47_12 = Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, var_47_11)
								local var_47_13 = Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, var_47_11)
								local var_47_14 = Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, var_47_11)

								iter_47_5.color = Color.New(var_47_12, var_47_13, var_47_14)
							else
								local var_47_15 = Mathf.Lerp(iter_47_5.color.r, 0.5, var_47_11)

								iter_47_5.color = Color.New(var_47_15, var_47_15, var_47_15)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1029 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_47_7 then
						if arg_44_1.isInRecall_ then
							iter_47_7.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1029 = nil
			end

			local var_47_16 = 0
			local var_47_17 = 0.5

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_18 = arg_44_1:FormatText(StoryNameCfg[236].name)

				arg_44_1.leftNameTxt_.text = var_47_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_19 = arg_44_1:GetWordFromCfg(117041010)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_21 = 20
				local var_47_22 = utf8.len(var_47_20)
				local var_47_23 = var_47_21 <= 0 and var_47_17 or var_47_17 * (var_47_22 / var_47_21)

				if var_47_23 > 0 and var_47_17 < var_47_23 then
					arg_44_1.talkMaxDuration = var_47_23

					if var_47_23 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_16
					end
				end

				arg_44_1.text_.text = var_47_20
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041010", "story_v_out_117041.awb") ~= 0 then
					local var_47_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041010", "story_v_out_117041.awb") / 1000

					if var_47_24 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_out_117041", "117041010", "story_v_out_117041.awb")

						arg_44_1:RecordAudio("117041010", var_47_25)
						arg_44_1:RecordAudio("117041010", var_47_25)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_117041", "117041010", "story_v_out_117041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_117041", "117041010", "story_v_out_117041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = math.max(var_47_17, arg_44_1.talkMaxDuration)

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_26 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_16) / var_47_26

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_16 + var_47_26 and arg_44_1.time_ < var_47_16 + var_47_26 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play117041011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 117041011
		arg_48_1.duration_ = 11.03

		local var_48_0 = {
			zh = 11.033,
			ja = 7.766
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
				arg_48_0:Play117041012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1033"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1033 == nil then
				arg_48_1.var_.actorSpriteComps1033 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1033 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 0.5, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1033 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1033 = nil
			end

			local var_51_8 = arg_48_1.actors_["1029"]
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1029 == nil then
				arg_48_1.var_.actorSpriteComps1029 = var_51_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_10 = 0.2

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_10 and not isNil(var_51_8) then
				local var_51_11 = (arg_48_1.time_ - var_51_9) / var_51_10

				if arg_48_1.var_.actorSpriteComps1029 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								local var_51_12 = Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor1.r, var_51_11)
								local var_51_13 = Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor1.g, var_51_11)
								local var_51_14 = Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor1.b, var_51_11)

								iter_51_5.color = Color.New(var_51_12, var_51_13, var_51_14)
							else
								local var_51_15 = Mathf.Lerp(iter_51_5.color.r, 1, var_51_11)

								iter_51_5.color = Color.New(var_51_15, var_51_15, var_51_15)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_9 + var_51_10 and arg_48_1.time_ < var_51_9 + var_51_10 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1029 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_51_7 then
						if arg_48_1.isInRecall_ then
							iter_51_7.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1029 = nil
			end

			local var_51_16 = 0
			local var_51_17 = 0.825

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_18 = arg_48_1:FormatText(StoryNameCfg[319].name)

				arg_48_1.leftNameTxt_.text = var_51_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(117041011)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 33
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_17 or var_51_17 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_17 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_16
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041011", "story_v_out_117041.awb") ~= 0 then
					local var_51_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041011", "story_v_out_117041.awb") / 1000

					if var_51_24 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_16
					end

					if var_51_19.prefab_name ~= "" and arg_48_1.actors_[var_51_19.prefab_name] ~= nil then
						local var_51_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_19.prefab_name].transform, "story_v_out_117041", "117041011", "story_v_out_117041.awb")

						arg_48_1:RecordAudio("117041011", var_51_25)
						arg_48_1:RecordAudio("117041011", var_51_25)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_117041", "117041011", "story_v_out_117041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_117041", "117041011", "story_v_out_117041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_26 = math.max(var_51_17, arg_48_1.talkMaxDuration)

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_26 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_16) / var_51_26

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_16 + var_51_26 and arg_48_1.time_ < var_51_16 + var_51_26 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play117041012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 117041012
		arg_52_1.duration_ = 9.7

		local var_52_0 = {
			zh = 9.066,
			ja = 9.7
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
				arg_52_0:Play117041013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1033"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps1033 == nil then
				arg_52_1.var_.actorSpriteComps1033 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps1033 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 1, var_55_3)

								iter_55_1.color = Color.New(var_55_7, var_55_7, var_55_7)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps1033 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1033 = nil
			end

			local var_55_8 = arg_52_1.actors_["1029"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1029 == nil then
				arg_52_1.var_.actorSpriteComps1029 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps1029 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								local var_55_12 = Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, var_55_11)
								local var_55_13 = Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, var_55_11)
								local var_55_14 = Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, var_55_11)

								iter_55_5.color = Color.New(var_55_12, var_55_13, var_55_14)
							else
								local var_55_15 = Mathf.Lerp(iter_55_5.color.r, 0.5, var_55_11)

								iter_55_5.color = Color.New(var_55_15, var_55_15, var_55_15)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps1029 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps1029 = nil
			end

			local var_55_16 = 0
			local var_55_17 = 1.1

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_18 = arg_52_1:FormatText(StoryNameCfg[236].name)

				arg_52_1.leftNameTxt_.text = var_55_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_19 = arg_52_1:GetWordFromCfg(117041012)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 44
				local var_55_22 = utf8.len(var_55_20)
				local var_55_23 = var_55_21 <= 0 and var_55_17 or var_55_17 * (var_55_22 / var_55_21)

				if var_55_23 > 0 and var_55_17 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23

					if var_55_23 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_16
					end
				end

				arg_52_1.text_.text = var_55_20
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041012", "story_v_out_117041.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041012", "story_v_out_117041.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_out_117041", "117041012", "story_v_out_117041.awb")

						arg_52_1:RecordAudio("117041012", var_55_25)
						arg_52_1:RecordAudio("117041012", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_117041", "117041012", "story_v_out_117041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_117041", "117041012", "story_v_out_117041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_17, arg_52_1.talkMaxDuration)

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_16) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_16 + var_55_26 and arg_52_1.time_ < var_55_16 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play117041013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 117041013
		arg_56_1.duration_ = 9.5

		local var_56_0 = {
			zh = 7.066,
			ja = 9.5
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
				arg_56_0:Play117041014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1033"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1033 == nil then
				arg_56_1.var_.actorSpriteComps1033 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1033 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 0.5, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1033 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1033 = nil
			end

			local var_59_8 = arg_56_1.actors_["1029"]
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps1029 == nil then
				arg_56_1.var_.actorSpriteComps1029 = var_59_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_10 = 0.2

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 and not isNil(var_59_8) then
				local var_59_11 = (arg_56_1.time_ - var_59_9) / var_59_10

				if arg_56_1.var_.actorSpriteComps1029 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								local var_59_12 = Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor1.r, var_59_11)
								local var_59_13 = Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor1.g, var_59_11)
								local var_59_14 = Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor1.b, var_59_11)

								iter_59_5.color = Color.New(var_59_12, var_59_13, var_59_14)
							else
								local var_59_15 = Mathf.Lerp(iter_59_5.color.r, 1, var_59_11)

								iter_59_5.color = Color.New(var_59_15, var_59_15, var_59_15)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.actorSpriteComps1029 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_59_7 then
						if arg_56_1.isInRecall_ then
							iter_59_7.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1029 = nil
			end

			local var_59_16 = 0
			local var_59_17 = 0.775

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_18 = arg_56_1:FormatText(StoryNameCfg[319].name)

				arg_56_1.leftNameTxt_.text = var_59_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_19 = arg_56_1:GetWordFromCfg(117041013)
				local var_59_20 = arg_56_1:FormatText(var_59_19.content)

				arg_56_1.text_.text = var_59_20

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 32
				local var_59_22 = utf8.len(var_59_20)
				local var_59_23 = var_59_21 <= 0 and var_59_17 or var_59_17 * (var_59_22 / var_59_21)

				if var_59_23 > 0 and var_59_17 < var_59_23 then
					arg_56_1.talkMaxDuration = var_59_23

					if var_59_23 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_20
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041013", "story_v_out_117041.awb") ~= 0 then
					local var_59_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041013", "story_v_out_117041.awb") / 1000

					if var_59_24 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_24 + var_59_16
					end

					if var_59_19.prefab_name ~= "" and arg_56_1.actors_[var_59_19.prefab_name] ~= nil then
						local var_59_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_19.prefab_name].transform, "story_v_out_117041", "117041013", "story_v_out_117041.awb")

						arg_56_1:RecordAudio("117041013", var_59_25)
						arg_56_1:RecordAudio("117041013", var_59_25)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_117041", "117041013", "story_v_out_117041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_117041", "117041013", "story_v_out_117041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_26 = math.max(var_59_17, arg_56_1.talkMaxDuration)

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_26 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_26

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_26 and arg_56_1.time_ < var_59_16 + var_59_26 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play117041014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 117041014
		arg_60_1.duration_ = 2.13

		local var_60_0 = {
			zh = 1.166,
			ja = 2.133
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
				arg_60_0:Play117041015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1033"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1033 == nil then
				arg_60_1.var_.actorSpriteComps1033 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps1033 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps1033 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1033 = nil
			end

			local var_63_8 = arg_60_1.actors_["1029"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1029 == nil then
				arg_60_1.var_.actorSpriteComps1029 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 0.2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps1029 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								local var_63_12 = Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, var_63_11)
								local var_63_13 = Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, var_63_11)
								local var_63_14 = Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, var_63_11)

								iter_63_5.color = Color.New(var_63_12, var_63_13, var_63_14)
							else
								local var_63_15 = Mathf.Lerp(iter_63_5.color.r, 0.5, var_63_11)

								iter_63_5.color = Color.New(var_63_15, var_63_15, var_63_15)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps1029 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps1029 = nil
			end

			local var_63_16 = 0
			local var_63_17 = 0.1

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_18 = arg_60_1:FormatText(StoryNameCfg[236].name)

				arg_60_1.leftNameTxt_.text = var_63_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:GetWordFromCfg(117041014)
				local var_63_20 = arg_60_1:FormatText(var_63_19.content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 4
				local var_63_22 = utf8.len(var_63_20)
				local var_63_23 = var_63_21 <= 0 and var_63_17 or var_63_17 * (var_63_22 / var_63_21)

				if var_63_23 > 0 and var_63_17 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23

					if var_63_23 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041014", "story_v_out_117041.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041014", "story_v_out_117041.awb") / 1000

					if var_63_24 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_16
					end

					if var_63_19.prefab_name ~= "" and arg_60_1.actors_[var_63_19.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_19.prefab_name].transform, "story_v_out_117041", "117041014", "story_v_out_117041.awb")

						arg_60_1:RecordAudio("117041014", var_63_25)
						arg_60_1:RecordAudio("117041014", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_117041", "117041014", "story_v_out_117041.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_117041", "117041014", "story_v_out_117041.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_26 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_26

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_26 and arg_60_1.time_ < var_63_16 + var_63_26 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play117041015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 117041015
		arg_64_1.duration_ = 11.87

		local var_64_0 = {
			zh = 11.4,
			ja = 11.866
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
				arg_64_0:Play117041016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1033"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1033 == nil then
				arg_64_1.var_.actorSpriteComps1033 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1033 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								local var_67_4 = Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, var_67_3)
								local var_67_5 = Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, var_67_3)
								local var_67_6 = Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, var_67_3)

								iter_67_1.color = Color.New(var_67_4, var_67_5, var_67_6)
							else
								local var_67_7 = Mathf.Lerp(iter_67_1.color.r, 0.5, var_67_3)

								iter_67_1.color = Color.New(var_67_7, var_67_7, var_67_7)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1033 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1033 = nil
			end

			local var_67_8 = arg_64_1.actors_["1029"]
			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1029 == nil then
				arg_64_1.var_.actorSpriteComps1029 = var_67_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_10 = 0.2

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_10 and not isNil(var_67_8) then
				local var_67_11 = (arg_64_1.time_ - var_67_9) / var_67_10

				if arg_64_1.var_.actorSpriteComps1029 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								local var_67_12 = Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor1.r, var_67_11)
								local var_67_13 = Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor1.g, var_67_11)
								local var_67_14 = Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor1.b, var_67_11)

								iter_67_5.color = Color.New(var_67_12, var_67_13, var_67_14)
							else
								local var_67_15 = Mathf.Lerp(iter_67_5.color.r, 1, var_67_11)

								iter_67_5.color = Color.New(var_67_15, var_67_15, var_67_15)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_9 + var_67_10 and arg_64_1.time_ < var_67_9 + var_67_10 + arg_67_0 and not isNil(var_67_8) and arg_64_1.var_.actorSpriteComps1029 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_67_7 then
						if arg_64_1.isInRecall_ then
							iter_67_7.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1029 = nil
			end

			local var_67_16 = 0
			local var_67_17 = 1.525

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_18 = arg_64_1:FormatText(StoryNameCfg[319].name)

				arg_64_1.leftNameTxt_.text = var_67_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_19 = arg_64_1:GetWordFromCfg(117041015)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 61
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_17 or var_67_17 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_17 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_16
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041015", "story_v_out_117041.awb") ~= 0 then
					local var_67_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041015", "story_v_out_117041.awb") / 1000

					if var_67_24 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_16
					end

					if var_67_19.prefab_name ~= "" and arg_64_1.actors_[var_67_19.prefab_name] ~= nil then
						local var_67_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_19.prefab_name].transform, "story_v_out_117041", "117041015", "story_v_out_117041.awb")

						arg_64_1:RecordAudio("117041015", var_67_25)
						arg_64_1:RecordAudio("117041015", var_67_25)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_117041", "117041015", "story_v_out_117041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_117041", "117041015", "story_v_out_117041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = math.max(var_67_17, arg_64_1.talkMaxDuration)

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_16) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_16 + var_67_26 and arg_64_1.time_ < var_67_16 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play117041016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 117041016
		arg_68_1.duration_ = 12.27

		local var_68_0 = {
			zh = 8.3,
			ja = 12.266
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
				arg_68_0:Play117041017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.85

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[319].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(117041016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 34
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041016", "story_v_out_117041.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041016", "story_v_out_117041.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_117041", "117041016", "story_v_out_117041.awb")

						arg_68_1:RecordAudio("117041016", var_71_9)
						arg_68_1:RecordAudio("117041016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_117041", "117041016", "story_v_out_117041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_117041", "117041016", "story_v_out_117041.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play117041017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 117041017
		arg_72_1.duration_ = 7.77

		local var_72_0 = {
			zh = 7.766,
			ja = 5.2
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
				arg_72_0:Play117041018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1033"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1033 == nil then
				arg_72_1.var_.actorSpriteComps1033 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps1033 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 1, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps1033 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1033 = nil
			end

			local var_75_8 = arg_72_1.actors_["1029"]
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps1029 == nil then
				arg_72_1.var_.actorSpriteComps1029 = var_75_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_10 = 0.2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 and not isNil(var_75_8) then
				local var_75_11 = (arg_72_1.time_ - var_75_9) / var_75_10

				if arg_72_1.var_.actorSpriteComps1029 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								local var_75_12 = Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, var_75_11)
								local var_75_13 = Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, var_75_11)
								local var_75_14 = Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, var_75_11)

								iter_75_5.color = Color.New(var_75_12, var_75_13, var_75_14)
							else
								local var_75_15 = Mathf.Lerp(iter_75_5.color.r, 0.5, var_75_11)

								iter_75_5.color = Color.New(var_75_15, var_75_15, var_75_15)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps1029 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_75_7 then
						if arg_72_1.isInRecall_ then
							iter_75_7.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps1029 = nil
			end

			local var_75_16 = 0
			local var_75_17 = 0.875

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_18 = arg_72_1:FormatText(StoryNameCfg[236].name)

				arg_72_1.leftNameTxt_.text = var_75_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_19 = arg_72_1:GetWordFromCfg(117041017)
				local var_75_20 = arg_72_1:FormatText(var_75_19.content)

				arg_72_1.text_.text = var_75_20

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_21 = 35
				local var_75_22 = utf8.len(var_75_20)
				local var_75_23 = var_75_21 <= 0 and var_75_17 or var_75_17 * (var_75_22 / var_75_21)

				if var_75_23 > 0 and var_75_17 < var_75_23 then
					arg_72_1.talkMaxDuration = var_75_23

					if var_75_23 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_16
					end
				end

				arg_72_1.text_.text = var_75_20
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041017", "story_v_out_117041.awb") ~= 0 then
					local var_75_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041017", "story_v_out_117041.awb") / 1000

					if var_75_24 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_24 + var_75_16
					end

					if var_75_19.prefab_name ~= "" and arg_72_1.actors_[var_75_19.prefab_name] ~= nil then
						local var_75_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_19.prefab_name].transform, "story_v_out_117041", "117041017", "story_v_out_117041.awb")

						arg_72_1:RecordAudio("117041017", var_75_25)
						arg_72_1:RecordAudio("117041017", var_75_25)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_117041", "117041017", "story_v_out_117041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_117041", "117041017", "story_v_out_117041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_26 = math.max(var_75_17, arg_72_1.talkMaxDuration)

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_26 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_16) / var_75_26

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_16 + var_75_26 and arg_72_1.time_ < var_75_16 + var_75_26 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play117041018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 117041018
		arg_76_1.duration_ = 7.87

		local var_76_0 = {
			zh = 7.866,
			ja = 7.066
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
				arg_76_0:Play117041019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1033"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1033 == nil then
				arg_76_1.var_.actorSpriteComps1033 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps1033 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 0.5, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1033 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1033 = nil
			end

			local var_79_8 = arg_76_1.actors_["1029"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1029 == nil then
				arg_76_1.var_.actorSpriteComps1029 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps1029 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								local var_79_12 = Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor1.r, var_79_11)
								local var_79_13 = Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor1.g, var_79_11)
								local var_79_14 = Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor1.b, var_79_11)

								iter_79_5.color = Color.New(var_79_12, var_79_13, var_79_14)
							else
								local var_79_15 = Mathf.Lerp(iter_79_5.color.r, 1, var_79_11)

								iter_79_5.color = Color.New(var_79_15, var_79_15, var_79_15)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1029 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1029 = nil
			end

			local var_79_16 = 0
			local var_79_17 = 0.8

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_18 = arg_76_1:FormatText(StoryNameCfg[319].name)

				arg_76_1.leftNameTxt_.text = var_79_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_19 = arg_76_1:GetWordFromCfg(117041018)
				local var_79_20 = arg_76_1:FormatText(var_79_19.content)

				arg_76_1.text_.text = var_79_20

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_21 = 32
				local var_79_22 = utf8.len(var_79_20)
				local var_79_23 = var_79_21 <= 0 and var_79_17 or var_79_17 * (var_79_22 / var_79_21)

				if var_79_23 > 0 and var_79_17 < var_79_23 then
					arg_76_1.talkMaxDuration = var_79_23

					if var_79_23 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_16
					end
				end

				arg_76_1.text_.text = var_79_20
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041018", "story_v_out_117041.awb") ~= 0 then
					local var_79_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041018", "story_v_out_117041.awb") / 1000

					if var_79_24 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_24 + var_79_16
					end

					if var_79_19.prefab_name ~= "" and arg_76_1.actors_[var_79_19.prefab_name] ~= nil then
						local var_79_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_19.prefab_name].transform, "story_v_out_117041", "117041018", "story_v_out_117041.awb")

						arg_76_1:RecordAudio("117041018", var_79_25)
						arg_76_1:RecordAudio("117041018", var_79_25)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_117041", "117041018", "story_v_out_117041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_117041", "117041018", "story_v_out_117041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_26 = math.max(var_79_17, arg_76_1.talkMaxDuration)

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_26 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_16) / var_79_26

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_16 + var_79_26 and arg_76_1.time_ < var_79_16 + var_79_26 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play117041019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 117041019
		arg_80_1.duration_ = 8.27

		local var_80_0 = {
			zh = 3.666,
			ja = 8.266
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
				arg_80_0:Play117041020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1033"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1033 == nil then
				arg_80_1.var_.actorSpriteComps1033 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps1033 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								local var_83_4 = Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, var_83_3)
								local var_83_5 = Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, var_83_3)
								local var_83_6 = Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, var_83_3)

								iter_83_1.color = Color.New(var_83_4, var_83_5, var_83_6)
							else
								local var_83_7 = Mathf.Lerp(iter_83_1.color.r, 1, var_83_3)

								iter_83_1.color = Color.New(var_83_7, var_83_7, var_83_7)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1033 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1033 = nil
			end

			local var_83_8 = arg_80_1.actors_["1029"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1029 == nil then
				arg_80_1.var_.actorSpriteComps1029 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps1029 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								local var_83_12 = Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, var_83_11)
								local var_83_13 = Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, var_83_11)
								local var_83_14 = Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, var_83_11)

								iter_83_5.color = Color.New(var_83_12, var_83_13, var_83_14)
							else
								local var_83_15 = Mathf.Lerp(iter_83_5.color.r, 0.5, var_83_11)

								iter_83_5.color = Color.New(var_83_15, var_83_15, var_83_15)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1029 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1029 = nil
			end

			local var_83_16 = 0
			local var_83_17 = 0.325

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_18 = arg_80_1:FormatText(StoryNameCfg[236].name)

				arg_80_1.leftNameTxt_.text = var_83_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_19 = arg_80_1:GetWordFromCfg(117041019)
				local var_83_20 = arg_80_1:FormatText(var_83_19.content)

				arg_80_1.text_.text = var_83_20

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_21 = 13
				local var_83_22 = utf8.len(var_83_20)
				local var_83_23 = var_83_21 <= 0 and var_83_17 or var_83_17 * (var_83_22 / var_83_21)

				if var_83_23 > 0 and var_83_17 < var_83_23 then
					arg_80_1.talkMaxDuration = var_83_23

					if var_83_23 + var_83_16 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_16
					end
				end

				arg_80_1.text_.text = var_83_20
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041019", "story_v_out_117041.awb") ~= 0 then
					local var_83_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041019", "story_v_out_117041.awb") / 1000

					if var_83_24 + var_83_16 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_24 + var_83_16
					end

					if var_83_19.prefab_name ~= "" and arg_80_1.actors_[var_83_19.prefab_name] ~= nil then
						local var_83_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_19.prefab_name].transform, "story_v_out_117041", "117041019", "story_v_out_117041.awb")

						arg_80_1:RecordAudio("117041019", var_83_25)
						arg_80_1:RecordAudio("117041019", var_83_25)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_117041", "117041019", "story_v_out_117041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_117041", "117041019", "story_v_out_117041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_26 = math.max(var_83_17, arg_80_1.talkMaxDuration)

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_26 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_16) / var_83_26

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_16 + var_83_26 and arg_80_1.time_ < var_83_16 + var_83_26 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play117041020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 117041020
		arg_84_1.duration_ = 5.9

		local var_84_0 = {
			zh = 2.566,
			ja = 5.9
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
				arg_84_0:Play117041021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1033"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1033 == nil then
				arg_84_1.var_.actorSpriteComps1033 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps1033 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 0.5, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1033 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1033 = nil
			end

			local var_87_8 = arg_84_1.actors_["1029"]
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps1029 == nil then
				arg_84_1.var_.actorSpriteComps1029 = var_87_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_10 = 0.2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 and not isNil(var_87_8) then
				local var_87_11 = (arg_84_1.time_ - var_87_9) / var_87_10

				if arg_84_1.var_.actorSpriteComps1029 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								local var_87_12 = Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor1.r, var_87_11)
								local var_87_13 = Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor1.g, var_87_11)
								local var_87_14 = Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor1.b, var_87_11)

								iter_87_5.color = Color.New(var_87_12, var_87_13, var_87_14)
							else
								local var_87_15 = Mathf.Lerp(iter_87_5.color.r, 1, var_87_11)

								iter_87_5.color = Color.New(var_87_15, var_87_15, var_87_15)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps1029 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_87_7 then
						if arg_84_1.isInRecall_ then
							iter_87_7.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1029 = nil
			end

			local var_87_16 = 0
			local var_87_17 = 0.25

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_18 = arg_84_1:FormatText(StoryNameCfg[319].name)

				arg_84_1.leftNameTxt_.text = var_87_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(117041020)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 10
				local var_87_22 = utf8.len(var_87_20)
				local var_87_23 = var_87_21 <= 0 and var_87_17 or var_87_17 * (var_87_22 / var_87_21)

				if var_87_23 > 0 and var_87_17 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_16
					end
				end

				arg_84_1.text_.text = var_87_20
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041020", "story_v_out_117041.awb") ~= 0 then
					local var_87_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041020", "story_v_out_117041.awb") / 1000

					if var_87_24 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_16
					end

					if var_87_19.prefab_name ~= "" and arg_84_1.actors_[var_87_19.prefab_name] ~= nil then
						local var_87_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_19.prefab_name].transform, "story_v_out_117041", "117041020", "story_v_out_117041.awb")

						arg_84_1:RecordAudio("117041020", var_87_25)
						arg_84_1:RecordAudio("117041020", var_87_25)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_117041", "117041020", "story_v_out_117041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_117041", "117041020", "story_v_out_117041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_26 = math.max(var_87_17, arg_84_1.talkMaxDuration)

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_26 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_16) / var_87_26

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_16 + var_87_26 and arg_84_1.time_ < var_87_16 + var_87_26 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play117041021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 117041021
		arg_88_1.duration_ = 1.57

		local var_88_0 = {
			zh = 1,
			ja = 1.566
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
				arg_88_0:Play117041022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1033"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1033 == nil then
				arg_88_1.var_.actorSpriteComps1033 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps1033 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1033 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1033 = nil
			end

			local var_91_8 = arg_88_1.actors_["1029"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1029 == nil then
				arg_88_1.var_.actorSpriteComps1029 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps1029 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps1029:ToTable()) do
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

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1029 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1029 = nil
			end

			local var_91_16 = 0
			local var_91_17 = 0.075

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_18 = arg_88_1:FormatText(StoryNameCfg[236].name)

				arg_88_1.leftNameTxt_.text = var_91_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(117041021)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041021", "story_v_out_117041.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041021", "story_v_out_117041.awb") / 1000

					if var_91_24 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_16
					end

					if var_91_19.prefab_name ~= "" and arg_88_1.actors_[var_91_19.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_19.prefab_name].transform, "story_v_out_117041", "117041021", "story_v_out_117041.awb")

						arg_88_1:RecordAudio("117041021", var_91_25)
						arg_88_1:RecordAudio("117041021", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_117041", "117041021", "story_v_out_117041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_117041", "117041021", "story_v_out_117041.awb")
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
	Play117041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 117041022
		arg_92_1.duration_ = 10.23

		local var_92_0 = {
			zh = 10.233,
			ja = 9.633
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
				arg_92_0:Play117041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "ST03"

			if arg_92_1.bgs_[var_95_0] == nil then
				local var_95_1 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_0)
				var_95_1.name = var_95_0
				var_95_1.transform.parent = arg_92_1.stage_.transform
				var_95_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_0] = var_95_1
			end

			local var_95_2 = 2

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				local var_95_3 = manager.ui.mainCamera.transform.localPosition
				local var_95_4 = Vector3.New(0, 0, 10) + Vector3.New(var_95_3.x, var_95_3.y, 0)
				local var_95_5 = arg_92_1.bgs_.ST03

				var_95_5.transform.localPosition = var_95_4
				var_95_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_6 = var_95_5:GetComponent("SpriteRenderer")

				if var_95_6 and var_95_6.sprite then
					local var_95_7 = (var_95_5.transform.localPosition - var_95_3).z
					local var_95_8 = manager.ui.mainCameraCom_
					local var_95_9 = 2 * var_95_7 * Mathf.Tan(var_95_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_95_10 = var_95_9 * var_95_8.aspect
					local var_95_11 = var_95_6.sprite.bounds.size.x
					local var_95_12 = var_95_6.sprite.bounds.size.y
					local var_95_13 = var_95_10 / var_95_11
					local var_95_14 = var_95_9 / var_95_12
					local var_95_15 = var_95_14 < var_95_13 and var_95_13 or var_95_14

					var_95_5.transform.localScale = Vector3.New(var_95_15, var_95_15, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "ST03" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_17 = 2

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_17 then
				local var_95_18 = (arg_92_1.time_ - var_95_16) / var_95_17
				local var_95_19 = Color.New(0, 0, 0)

				var_95_19.a = Mathf.Lerp(0, 1, var_95_18)
				arg_92_1.mask_.color = var_95_19
			end

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 then
				local var_95_20 = Color.New(0, 0, 0)

				var_95_20.a = 1
				arg_92_1.mask_.color = var_95_20
			end

			local var_95_21 = 2

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_22 = 2

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_22 then
				local var_95_23 = (arg_92_1.time_ - var_95_21) / var_95_22
				local var_95_24 = Color.New(0, 0, 0)

				var_95_24.a = Mathf.Lerp(1, 0, var_95_23)
				arg_92_1.mask_.color = var_95_24
			end

			if arg_92_1.time_ >= var_95_21 + var_95_22 and arg_92_1.time_ < var_95_21 + var_95_22 + arg_95_0 then
				local var_95_25 = Color.New(0, 0, 0)
				local var_95_26 = 0

				arg_92_1.mask_.enabled = false
				var_95_25.a = var_95_26
				arg_92_1.mask_.color = var_95_25
			end

			local var_95_27 = arg_92_1.actors_["1033"].transform
			local var_95_28 = 2

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1.var_.moveOldPos1033 = var_95_27.localPosition
				var_95_27.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1033", 7)

				local var_95_29 = var_95_27.childCount

				for iter_95_2 = 0, var_95_29 - 1 do
					local var_95_30 = var_95_27:GetChild(iter_95_2)

					if var_95_30.name == "split_6" or not string.find(var_95_30.name, "split") then
						var_95_30.gameObject:SetActive(true)
					else
						var_95_30.gameObject:SetActive(false)
					end
				end
			end

			local var_95_31 = 0.001

			if var_95_28 <= arg_92_1.time_ and arg_92_1.time_ < var_95_28 + var_95_31 then
				local var_95_32 = (arg_92_1.time_ - var_95_28) / var_95_31
				local var_95_33 = Vector3.New(0, -2000, 0)

				var_95_27.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1033, var_95_33, var_95_32)
			end

			if arg_92_1.time_ >= var_95_28 + var_95_31 and arg_92_1.time_ < var_95_28 + var_95_31 + arg_95_0 then
				var_95_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_34 = arg_92_1.actors_["1029"].transform
			local var_95_35 = 2

			if var_95_35 < arg_92_1.time_ and arg_92_1.time_ <= var_95_35 + arg_95_0 then
				arg_92_1.var_.moveOldPos1029 = var_95_34.localPosition
				var_95_34.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1029", 7)

				local var_95_36 = var_95_34.childCount

				for iter_95_3 = 0, var_95_36 - 1 do
					local var_95_37 = var_95_34:GetChild(iter_95_3)

					if var_95_37.name == "split_1" or not string.find(var_95_37.name, "split") then
						var_95_37.gameObject:SetActive(true)
					else
						var_95_37.gameObject:SetActive(false)
					end
				end
			end

			local var_95_38 = 0.001

			if var_95_35 <= arg_92_1.time_ and arg_92_1.time_ < var_95_35 + var_95_38 then
				local var_95_39 = (arg_92_1.time_ - var_95_35) / var_95_38
				local var_95_40 = Vector3.New(0, -2000, -140)

				var_95_34.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1029, var_95_40, var_95_39)
			end

			if arg_92_1.time_ >= var_95_35 + var_95_38 and arg_92_1.time_ < var_95_35 + var_95_38 + arg_95_0 then
				var_95_34.localPosition = Vector3.New(0, -2000, -140)
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_41 = 4
			local var_95_42 = 0.8

			if var_95_41 < arg_92_1.time_ and arg_92_1.time_ <= var_95_41 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_43 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_43:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_44 = arg_92_1:FormatText(StoryNameCfg[144].name)

				arg_92_1.leftNameTxt_.text = var_95_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_45 = arg_92_1:GetWordFromCfg(117041022)
				local var_95_46 = arg_92_1:FormatText(var_95_45.content)

				arg_92_1.text_.text = var_95_46

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_47 = 32
				local var_95_48 = utf8.len(var_95_46)
				local var_95_49 = var_95_47 <= 0 and var_95_42 or var_95_42 * (var_95_48 / var_95_47)

				if var_95_49 > 0 and var_95_42 < var_95_49 then
					arg_92_1.talkMaxDuration = var_95_49
					var_95_41 = var_95_41 + 0.3

					if var_95_49 + var_95_41 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_49 + var_95_41
					end
				end

				arg_92_1.text_.text = var_95_46
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041022", "story_v_out_117041.awb") ~= 0 then
					local var_95_50 = manager.audio:GetVoiceLength("story_v_out_117041", "117041022", "story_v_out_117041.awb") / 1000

					if var_95_50 + var_95_41 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_50 + var_95_41
					end

					if var_95_45.prefab_name ~= "" and arg_92_1.actors_[var_95_45.prefab_name] ~= nil then
						local var_95_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_45.prefab_name].transform, "story_v_out_117041", "117041022", "story_v_out_117041.awb")

						arg_92_1:RecordAudio("117041022", var_95_51)
						arg_92_1:RecordAudio("117041022", var_95_51)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_117041", "117041022", "story_v_out_117041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_117041", "117041022", "story_v_out_117041.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_52 = var_95_41 + 0.3
			local var_95_53 = math.max(var_95_42, arg_92_1.talkMaxDuration)

			if var_95_52 <= arg_92_1.time_ and arg_92_1.time_ < var_95_52 + var_95_53 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_52) / var_95_53

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_52 + var_95_53 and arg_92_1.time_ < var_95_52 + var_95_53 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play117041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 117041023
		arg_98_1.duration_ = 4.33

		local var_98_0 = {
			zh = 4.333,
			ja = 2.966
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
				arg_98_0:Play117041024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "10036"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10036")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(var_101_1, arg_98_1.canvasGo_.transform)

					var_101_2.transform:SetSiblingIndex(1)

					var_101_2.name = var_101_0
					var_101_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_98_1.actors_[var_101_0] = var_101_2

					local var_101_3 = var_101_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_98_1.isInRecall_ then
						for iter_101_0, iter_101_1 in ipairs(var_101_3) do
							iter_101_1.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_101_4 = arg_98_1.actors_["10036"].transform
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.var_.moveOldPos10036 = var_101_4.localPosition
				var_101_4.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("10036", 3)

				local var_101_6 = var_101_4.childCount

				for iter_101_2 = 0, var_101_6 - 1 do
					local var_101_7 = var_101_4:GetChild(iter_101_2)

					if var_101_7.name == "split_1" or not string.find(var_101_7.name, "split") then
						var_101_7.gameObject:SetActive(true)
					else
						var_101_7.gameObject:SetActive(false)
					end
				end
			end

			local var_101_8 = 0.001

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_8 then
				local var_101_9 = (arg_98_1.time_ - var_101_5) / var_101_8
				local var_101_10 = Vector3.New(0, -445, -290)

				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10036, var_101_10, var_101_9)
			end

			if arg_98_1.time_ >= var_101_5 + var_101_8 and arg_98_1.time_ < var_101_5 + var_101_8 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, -445, -290)
			end

			local var_101_11 = arg_98_1.actors_["10036"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				local var_101_13 = var_101_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_101_13 then
					arg_98_1.var_.alphaOldValue10036 = var_101_13.alpha
					arg_98_1.var_.characterEffect10036 = var_101_13
				end

				arg_98_1.var_.alphaOldValue10036 = 0
			end

			local var_101_14 = 0.333333333333333

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_14 then
				local var_101_15 = (arg_98_1.time_ - var_101_12) / var_101_14
				local var_101_16 = Mathf.Lerp(arg_98_1.var_.alphaOldValue10036, 1, var_101_15)

				if arg_98_1.var_.characterEffect10036 then
					arg_98_1.var_.characterEffect10036.alpha = var_101_16
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_14 and arg_98_1.time_ < var_101_12 + var_101_14 + arg_101_0 and arg_98_1.var_.characterEffect10036 then
				arg_98_1.var_.characterEffect10036.alpha = 1
			end

			local var_101_17 = 0
			local var_101_18 = 0.525

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_19 = arg_98_1:FormatText(StoryNameCfg[370].name)

				arg_98_1.leftNameTxt_.text = var_101_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_20 = arg_98_1:GetWordFromCfg(117041023)
				local var_101_21 = arg_98_1:FormatText(var_101_20.content)

				arg_98_1.text_.text = var_101_21

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_22 = 21
				local var_101_23 = utf8.len(var_101_21)
				local var_101_24 = var_101_22 <= 0 and var_101_18 or var_101_18 * (var_101_23 / var_101_22)

				if var_101_24 > 0 and var_101_18 < var_101_24 then
					arg_98_1.talkMaxDuration = var_101_24

					if var_101_24 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_17
					end
				end

				arg_98_1.text_.text = var_101_21
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041023", "story_v_out_117041.awb") ~= 0 then
					local var_101_25 = manager.audio:GetVoiceLength("story_v_out_117041", "117041023", "story_v_out_117041.awb") / 1000

					if var_101_25 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_25 + var_101_17
					end

					if var_101_20.prefab_name ~= "" and arg_98_1.actors_[var_101_20.prefab_name] ~= nil then
						local var_101_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_20.prefab_name].transform, "story_v_out_117041", "117041023", "story_v_out_117041.awb")

						arg_98_1:RecordAudio("117041023", var_101_26)
						arg_98_1:RecordAudio("117041023", var_101_26)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_117041", "117041023", "story_v_out_117041.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_117041", "117041023", "story_v_out_117041.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_27 = math.max(var_101_18, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_27 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_17) / var_101_27

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_27 and arg_98_1.time_ < var_101_17 + var_101_27 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play117041024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 117041024
		arg_102_1.duration_ = 5.43

		local var_102_0 = {
			zh = 5.433,
			ja = 5.233
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play117041025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10036"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10036 == nil then
				arg_102_1.var_.actorSpriteComps10036 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps10036 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 0.5, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10036 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps10036 = nil
			end

			local var_105_8 = 0
			local var_105_9 = 0.75

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[144].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_11 = arg_102_1:GetWordFromCfg(117041024)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 30
				local var_105_14 = utf8.len(var_105_12)
				local var_105_15 = var_105_13 <= 0 and var_105_9 or var_105_9 * (var_105_14 / var_105_13)

				if var_105_15 > 0 and var_105_9 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_12
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041024", "story_v_out_117041.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041024", "story_v_out_117041.awb") / 1000

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end

					if var_105_11.prefab_name ~= "" and arg_102_1.actors_[var_105_11.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_11.prefab_name].transform, "story_v_out_117041", "117041024", "story_v_out_117041.awb")

						arg_102_1:RecordAudio("117041024", var_105_17)
						arg_102_1:RecordAudio("117041024", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_117041", "117041024", "story_v_out_117041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_117041", "117041024", "story_v_out_117041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_18 and arg_102_1.time_ < var_105_8 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play117041025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 117041025
		arg_106_1.duration_ = 5.2

		local var_106_0 = {
			zh = 5.2,
			ja = 5.066
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
				arg_106_0:Play117041026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10036"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10036 == nil then
				arg_106_1.var_.actorSpriteComps10036 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps10036 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10036 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10036 = nil
			end

			local var_109_8 = 0
			local var_109_9 = 0.675

			if var_109_8 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_10 = arg_106_1:FormatText(StoryNameCfg[370].name)

				arg_106_1.leftNameTxt_.text = var_109_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_11 = arg_106_1:GetWordFromCfg(117041025)
				local var_109_12 = arg_106_1:FormatText(var_109_11.content)

				arg_106_1.text_.text = var_109_12

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 27
				local var_109_14 = utf8.len(var_109_12)
				local var_109_15 = var_109_13 <= 0 and var_109_9 or var_109_9 * (var_109_14 / var_109_13)

				if var_109_15 > 0 and var_109_9 < var_109_15 then
					arg_106_1.talkMaxDuration = var_109_15

					if var_109_15 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_12
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041025", "story_v_out_117041.awb") ~= 0 then
					local var_109_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041025", "story_v_out_117041.awb") / 1000

					if var_109_16 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_8
					end

					if var_109_11.prefab_name ~= "" and arg_106_1.actors_[var_109_11.prefab_name] ~= nil then
						local var_109_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_11.prefab_name].transform, "story_v_out_117041", "117041025", "story_v_out_117041.awb")

						arg_106_1:RecordAudio("117041025", var_109_17)
						arg_106_1:RecordAudio("117041025", var_109_17)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_117041", "117041025", "story_v_out_117041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_117041", "117041025", "story_v_out_117041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_18 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_18

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_18 and arg_106_1.time_ < var_109_8 + var_109_18 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play117041026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 117041026
		arg_110_1.duration_ = 9.67

		local var_110_0 = {
			zh = 7.766,
			ja = 9.666
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
				arg_110_0:Play117041027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.95

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[370].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(117041026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041026", "story_v_out_117041.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041026", "story_v_out_117041.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_117041", "117041026", "story_v_out_117041.awb")

						arg_110_1:RecordAudio("117041026", var_113_9)
						arg_110_1:RecordAudio("117041026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_117041", "117041026", "story_v_out_117041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_117041", "117041026", "story_v_out_117041.awb")
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
	Play117041027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 117041027
		arg_114_1.duration_ = 5.17

		local var_114_0 = {
			zh = 3.166,
			ja = 5.166
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
				arg_114_0:Play117041028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10036"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps10036 == nil then
				arg_114_1.var_.actorSpriteComps10036 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps10036 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 0.5, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps10036 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps10036 = nil
			end

			local var_117_8 = 0
			local var_117_9 = 0.4

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_10 = arg_114_1:FormatText(StoryNameCfg[144].name)

				arg_114_1.leftNameTxt_.text = var_117_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_11 = arg_114_1:GetWordFromCfg(117041027)
				local var_117_12 = arg_114_1:FormatText(var_117_11.content)

				arg_114_1.text_.text = var_117_12

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 16
				local var_117_14 = utf8.len(var_117_12)
				local var_117_15 = var_117_13 <= 0 and var_117_9 or var_117_9 * (var_117_14 / var_117_13)

				if var_117_15 > 0 and var_117_9 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_12
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041027", "story_v_out_117041.awb") ~= 0 then
					local var_117_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041027", "story_v_out_117041.awb") / 1000

					if var_117_16 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_16 + var_117_8
					end

					if var_117_11.prefab_name ~= "" and arg_114_1.actors_[var_117_11.prefab_name] ~= nil then
						local var_117_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_11.prefab_name].transform, "story_v_out_117041", "117041027", "story_v_out_117041.awb")

						arg_114_1:RecordAudio("117041027", var_117_17)
						arg_114_1:RecordAudio("117041027", var_117_17)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_117041", "117041027", "story_v_out_117041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_117041", "117041027", "story_v_out_117041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_18 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_18

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_18 and arg_114_1.time_ < var_117_8 + var_117_18 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play117041028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 117041028
		arg_118_1.duration_ = 11.3

		local var_118_0 = {
			zh = 10.666,
			ja = 11.3
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
				arg_118_0:Play117041029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10036"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10036 == nil then
				arg_118_1.var_.actorSpriteComps10036 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps10036 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10036 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps10036 = nil
			end

			local var_121_8 = 0
			local var_121_9 = 1.325

			if var_121_8 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[370].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_11 = arg_118_1:GetWordFromCfg(117041028)
				local var_121_12 = arg_118_1:FormatText(var_121_11.content)

				arg_118_1.text_.text = var_121_12

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 53
				local var_121_14 = utf8.len(var_121_12)
				local var_121_15 = var_121_13 <= 0 and var_121_9 or var_121_9 * (var_121_14 / var_121_13)

				if var_121_15 > 0 and var_121_9 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_12
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041028", "story_v_out_117041.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041028", "story_v_out_117041.awb") / 1000

					if var_121_16 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_8
					end

					if var_121_11.prefab_name ~= "" and arg_118_1.actors_[var_121_11.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_11.prefab_name].transform, "story_v_out_117041", "117041028", "story_v_out_117041.awb")

						arg_118_1:RecordAudio("117041028", var_121_17)
						arg_118_1:RecordAudio("117041028", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_117041", "117041028", "story_v_out_117041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_117041", "117041028", "story_v_out_117041.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_18 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_18 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_18

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_18 and arg_118_1.time_ < var_121_8 + var_121_18 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play117041029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 117041029
		arg_122_1.duration_ = 9

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play117041030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = "ST24a"

			if arg_122_1.bgs_[var_125_0] == nil then
				local var_125_1 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_125_0)
				var_125_1.name = var_125_0
				var_125_1.transform.parent = arg_122_1.stage_.transform
				var_125_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_[var_125_0] = var_125_1
			end

			local var_125_2 = 2

			if var_125_2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				local var_125_3 = manager.ui.mainCamera.transform.localPosition
				local var_125_4 = Vector3.New(0, 0, 10) + Vector3.New(var_125_3.x, var_125_3.y, 0)
				local var_125_5 = arg_122_1.bgs_.ST24a

				var_125_5.transform.localPosition = var_125_4
				var_125_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_6 = var_125_5:GetComponent("SpriteRenderer")

				if var_125_6 and var_125_6.sprite then
					local var_125_7 = (var_125_5.transform.localPosition - var_125_3).z
					local var_125_8 = manager.ui.mainCameraCom_
					local var_125_9 = 2 * var_125_7 * Mathf.Tan(var_125_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_10 = var_125_9 * var_125_8.aspect
					local var_125_11 = var_125_6.sprite.bounds.size.x
					local var_125_12 = var_125_6.sprite.bounds.size.y
					local var_125_13 = var_125_10 / var_125_11
					local var_125_14 = var_125_9 / var_125_12
					local var_125_15 = var_125_14 < var_125_13 and var_125_13 or var_125_14

					var_125_5.transform.localScale = Vector3.New(var_125_15, var_125_15, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "ST24a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_17 = 2

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17
				local var_125_19 = Color.New(0, 0, 0)

				var_125_19.a = Mathf.Lerp(0, 1, var_125_18)
				arg_122_1.mask_.color = var_125_19
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				local var_125_20 = Color.New(0, 0, 0)

				var_125_20.a = 1
				arg_122_1.mask_.color = var_125_20
			end

			local var_125_21 = 2

			if var_125_21 < arg_122_1.time_ and arg_122_1.time_ <= var_125_21 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_22 = 2

			if var_125_21 <= arg_122_1.time_ and arg_122_1.time_ < var_125_21 + var_125_22 then
				local var_125_23 = (arg_122_1.time_ - var_125_21) / var_125_22
				local var_125_24 = Color.New(0, 0, 0)

				var_125_24.a = Mathf.Lerp(1, 0, var_125_23)
				arg_122_1.mask_.color = var_125_24
			end

			if arg_122_1.time_ >= var_125_21 + var_125_22 and arg_122_1.time_ < var_125_21 + var_125_22 + arg_125_0 then
				local var_125_25 = Color.New(0, 0, 0)
				local var_125_26 = 0

				arg_122_1.mask_.enabled = false
				var_125_25.a = var_125_26
				arg_122_1.mask_.color = var_125_25
			end

			local var_125_27 = arg_122_1.actors_["10036"].transform
			local var_125_28 = 2

			if var_125_28 < arg_122_1.time_ and arg_122_1.time_ <= var_125_28 + arg_125_0 then
				arg_122_1.var_.moveOldPos10036 = var_125_27.localPosition
				var_125_27.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("10036", 7)

				local var_125_29 = var_125_27.childCount

				for iter_125_2 = 0, var_125_29 - 1 do
					local var_125_30 = var_125_27:GetChild(iter_125_2)

					if var_125_30.name == "split_1" or not string.find(var_125_30.name, "split") then
						var_125_30.gameObject:SetActive(true)
					else
						var_125_30.gameObject:SetActive(false)
					end
				end
			end

			local var_125_31 = 0.001

			if var_125_28 <= arg_122_1.time_ and arg_122_1.time_ < var_125_28 + var_125_31 then
				local var_125_32 = (arg_122_1.time_ - var_125_28) / var_125_31
				local var_125_33 = Vector3.New(0, -2000, -290)

				var_125_27.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10036, var_125_33, var_125_32)
			end

			if arg_122_1.time_ >= var_125_28 + var_125_31 and arg_122_1.time_ < var_125_28 + var_125_31 + arg_125_0 then
				var_125_27.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_125_34 = 0
			local var_125_35 = 1

			if var_125_34 < arg_122_1.time_ and arg_122_1.time_ <= var_125_34 + arg_125_0 then
				local var_125_36 = "play"
				local var_125_37 = "music"

				arg_122_1:AudioAction(var_125_36, var_125_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_125_38 = ""
				local var_125_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_125_39 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_39 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_39

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_39
						arg_122_1.bgmTxt2_.text = var_125_39
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_40 = 4
			local var_125_41 = 1.425

			if var_125_40 < arg_122_1.time_ and arg_122_1.time_ <= var_125_40 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_42 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_42:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_122_1.dialogCg_.alpha = arg_127_0
				end))
				var_125_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_43 = arg_122_1:GetWordFromCfg(117041029)
				local var_125_44 = arg_122_1:FormatText(var_125_43.content)

				arg_122_1.text_.text = var_125_44

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_45 = 57
				local var_125_46 = utf8.len(var_125_44)
				local var_125_47 = var_125_45 <= 0 and var_125_41 or var_125_41 * (var_125_46 / var_125_45)

				if var_125_47 > 0 and var_125_41 < var_125_47 then
					arg_122_1.talkMaxDuration = var_125_47
					var_125_40 = var_125_40 + 0.3

					if var_125_47 + var_125_40 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_47 + var_125_40
					end
				end

				arg_122_1.text_.text = var_125_44
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_48 = var_125_40 + 0.3
			local var_125_49 = math.max(var_125_41, arg_122_1.talkMaxDuration)

			if var_125_48 <= arg_122_1.time_ and arg_122_1.time_ < var_125_48 + var_125_49 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_48) / var_125_49

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_48 + var_125_49 and arg_122_1.time_ < var_125_48 + var_125_49 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play117041030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 117041030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play117041031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.166666666666667

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				local var_132_2 = "play"
				local var_132_3 = "music"

				arg_129_1:AudioAction(var_132_2, var_132_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_132_4 = ""
				local var_132_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_132_5 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_5 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_5

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_5
						arg_129_1.bgmTxt2_.text = var_132_5
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_6 = 0.3
			local var_132_7 = 0.7

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				local var_132_8 = "play"
				local var_132_9 = "music"

				arg_129_1:AudioAction(var_132_8, var_132_9, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_132_10 = ""
				local var_132_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_132_11 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_11 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_11

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_11
						arg_129_1.bgmTxt2_.text = var_132_11
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_12 = 0
			local var_132_13 = 0.625

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(117041030)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 25
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_13 or var_132_13 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_13 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_19 and arg_129_1.time_ < var_132_12 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play117041031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 117041031
		arg_135_1.duration_ = 9.07

		local var_135_0 = {
			zh = 7.8,
			ja = 9.066
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
				arg_135_0:Play117041032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "10034"

			if arg_135_1.actors_[var_138_0] == nil then
				local var_138_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10034")

				if not isNil(var_138_1) then
					local var_138_2 = Object.Instantiate(var_138_1, arg_135_1.canvasGo_.transform)

					var_138_2.transform:SetSiblingIndex(1)

					var_138_2.name = var_138_0
					var_138_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_135_1.actors_[var_138_0] = var_138_2

					local var_138_3 = var_138_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_135_1.isInRecall_ then
						for iter_138_0, iter_138_1 in ipairs(var_138_3) do
							iter_138_1.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_138_4 = arg_135_1.actors_["10034"].transform
			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.var_.moveOldPos10034 = var_138_4.localPosition
				var_138_4.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10034", 3)

				local var_138_6 = var_138_4.childCount

				for iter_138_2 = 0, var_138_6 - 1 do
					local var_138_7 = var_138_4:GetChild(iter_138_2)

					if var_138_7.name == "split_3" or not string.find(var_138_7.name, "split") then
						var_138_7.gameObject:SetActive(true)
					else
						var_138_7.gameObject:SetActive(false)
					end
				end
			end

			local var_138_8 = 0.001

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_8 then
				local var_138_9 = (arg_135_1.time_ - var_138_5) / var_138_8
				local var_138_10 = Vector3.New(0, -415, -290)

				var_138_4.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10034, var_138_10, var_138_9)
			end

			if arg_135_1.time_ >= var_138_5 + var_138_8 and arg_135_1.time_ < var_138_5 + var_138_8 + arg_138_0 then
				var_138_4.localPosition = Vector3.New(0, -415, -290)
			end

			local var_138_11 = arg_135_1.actors_["10034"]
			local var_138_12 = 0

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				local var_138_13 = var_138_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_13 then
					arg_135_1.var_.alphaOldValue10034 = var_138_13.alpha
					arg_135_1.var_.characterEffect10034 = var_138_13
				end

				arg_135_1.var_.alphaOldValue10034 = 0
			end

			local var_138_14 = 0.333333333333333

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_14 then
				local var_138_15 = (arg_135_1.time_ - var_138_12) / var_138_14
				local var_138_16 = Mathf.Lerp(arg_135_1.var_.alphaOldValue10034, 1, var_138_15)

				if arg_135_1.var_.characterEffect10034 then
					arg_135_1.var_.characterEffect10034.alpha = var_138_16
				end
			end

			if arg_135_1.time_ >= var_138_12 + var_138_14 and arg_135_1.time_ < var_138_12 + var_138_14 + arg_138_0 and arg_135_1.var_.characterEffect10034 then
				arg_135_1.var_.characterEffect10034.alpha = 1
			end

			local var_138_17 = arg_135_1.actors_["10034"]
			local var_138_18 = 0

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 and not isNil(var_138_17) and arg_135_1.var_.actorSpriteComps10034 == nil then
				arg_135_1.var_.actorSpriteComps10034 = var_138_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_19 = 0.2

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_19 and not isNil(var_138_17) then
				local var_138_20 = (arg_135_1.time_ - var_138_18) / var_138_19

				if arg_135_1.var_.actorSpriteComps10034 then
					for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_138_4 then
							if arg_135_1.isInRecall_ then
								local var_138_21 = Mathf.Lerp(iter_138_4.color.r, arg_135_1.hightColor1.r, var_138_20)
								local var_138_22 = Mathf.Lerp(iter_138_4.color.g, arg_135_1.hightColor1.g, var_138_20)
								local var_138_23 = Mathf.Lerp(iter_138_4.color.b, arg_135_1.hightColor1.b, var_138_20)

								iter_138_4.color = Color.New(var_138_21, var_138_22, var_138_23)
							else
								local var_138_24 = Mathf.Lerp(iter_138_4.color.r, 1, var_138_20)

								iter_138_4.color = Color.New(var_138_24, var_138_24, var_138_24)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_18 + var_138_19 and arg_135_1.time_ < var_138_18 + var_138_19 + arg_138_0 and not isNil(var_138_17) and arg_135_1.var_.actorSpriteComps10034 then
				for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_138_6 then
						if arg_135_1.isInRecall_ then
							iter_138_6.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10034 = nil
			end

			local var_138_25 = 0
			local var_138_26 = 0.775

			if var_138_25 < arg_135_1.time_ and arg_135_1.time_ <= var_138_25 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_27 = arg_135_1:FormatText(StoryNameCfg[367].name)

				arg_135_1.leftNameTxt_.text = var_138_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_28 = arg_135_1:GetWordFromCfg(117041031)
				local var_138_29 = arg_135_1:FormatText(var_138_28.content)

				arg_135_1.text_.text = var_138_29

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_30 = 31
				local var_138_31 = utf8.len(var_138_29)
				local var_138_32 = var_138_30 <= 0 and var_138_26 or var_138_26 * (var_138_31 / var_138_30)

				if var_138_32 > 0 and var_138_26 < var_138_32 then
					arg_135_1.talkMaxDuration = var_138_32

					if var_138_32 + var_138_25 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_32 + var_138_25
					end
				end

				arg_135_1.text_.text = var_138_29
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041031", "story_v_out_117041.awb") ~= 0 then
					local var_138_33 = manager.audio:GetVoiceLength("story_v_out_117041", "117041031", "story_v_out_117041.awb") / 1000

					if var_138_33 + var_138_25 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_33 + var_138_25
					end

					if var_138_28.prefab_name ~= "" and arg_135_1.actors_[var_138_28.prefab_name] ~= nil then
						local var_138_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_28.prefab_name].transform, "story_v_out_117041", "117041031", "story_v_out_117041.awb")

						arg_135_1:RecordAudio("117041031", var_138_34)
						arg_135_1:RecordAudio("117041031", var_138_34)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_117041", "117041031", "story_v_out_117041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_117041", "117041031", "story_v_out_117041.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_35 = math.max(var_138_26, arg_135_1.talkMaxDuration)

			if var_138_25 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_35 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_25) / var_138_35

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_25 + var_138_35 and arg_135_1.time_ < var_138_25 + var_138_35 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play117041032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 117041032
		arg_139_1.duration_ = 12.27

		local var_139_0 = {
			zh = 12.266,
			ja = 12
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
				arg_139_0:Play117041033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.325

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[367].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(117041032)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041032", "story_v_out_117041.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041032", "story_v_out_117041.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_117041", "117041032", "story_v_out_117041.awb")

						arg_139_1:RecordAudio("117041032", var_142_9)
						arg_139_1:RecordAudio("117041032", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_117041", "117041032", "story_v_out_117041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_117041", "117041032", "story_v_out_117041.awb")
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
	Play117041033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 117041033
		arg_143_1.duration_ = 4.97

		local var_143_0 = {
			zh = 4.333,
			ja = 4.966
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
				arg_143_0:Play117041034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.35

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[367].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(117041033)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 14
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041033", "story_v_out_117041.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041033", "story_v_out_117041.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_117041", "117041033", "story_v_out_117041.awb")

						arg_143_1:RecordAudio("117041033", var_146_9)
						arg_143_1:RecordAudio("117041033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_117041", "117041033", "story_v_out_117041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_117041", "117041033", "story_v_out_117041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play117041034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 117041034
		arg_147_1.duration_ = 7.17

		local var_147_0 = {
			zh = 4.833,
			ja = 7.166
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
				arg_147_0:Play117041035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10034"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10034 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10034", 2)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "split_3" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(-390, -415, -290)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10034, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_150_7 = "10035"

			if arg_147_1.actors_[var_150_7] == nil then
				local var_150_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_150_8) then
					local var_150_9 = Object.Instantiate(var_150_8, arg_147_1.canvasGo_.transform)

					var_150_9.transform:SetSiblingIndex(1)

					var_150_9.name = var_150_7
					var_150_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_147_1.actors_[var_150_7] = var_150_9

					local var_150_10 = var_150_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_147_1.isInRecall_ then
						for iter_150_1, iter_150_2 in ipairs(var_150_10) do
							iter_150_2.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_150_11 = arg_147_1.actors_["10035"].transform
			local var_150_12 = 0

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.var_.moveOldPos10035 = var_150_11.localPosition
				var_150_11.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10035", 4)

				local var_150_13 = var_150_11.childCount

				for iter_150_3 = 0, var_150_13 - 1 do
					local var_150_14 = var_150_11:GetChild(iter_150_3)

					if var_150_14.name == "split_1" or not string.find(var_150_14.name, "split") then
						var_150_14.gameObject:SetActive(true)
					else
						var_150_14.gameObject:SetActive(false)
					end
				end
			end

			local var_150_15 = 0.001

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_15 then
				local var_150_16 = (arg_147_1.time_ - var_150_12) / var_150_15
				local var_150_17 = Vector3.New(390, -410, -235)

				var_150_11.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10035, var_150_17, var_150_16)
			end

			if arg_147_1.time_ >= var_150_12 + var_150_15 and arg_147_1.time_ < var_150_12 + var_150_15 + arg_150_0 then
				var_150_11.localPosition = Vector3.New(390, -410, -235)
			end

			local var_150_18 = arg_147_1.actors_["10035"]
			local var_150_19 = 0

			if var_150_19 < arg_147_1.time_ and arg_147_1.time_ <= var_150_19 + arg_150_0 then
				local var_150_20 = var_150_18:GetComponentInChildren(typeof(CanvasGroup))

				if var_150_20 then
					arg_147_1.var_.alphaOldValue10035 = var_150_20.alpha
					arg_147_1.var_.characterEffect10035 = var_150_20
				end

				arg_147_1.var_.alphaOldValue10035 = 0
			end

			local var_150_21 = 0.2

			if var_150_19 <= arg_147_1.time_ and arg_147_1.time_ < var_150_19 + var_150_21 then
				local var_150_22 = (arg_147_1.time_ - var_150_19) / var_150_21
				local var_150_23 = Mathf.Lerp(arg_147_1.var_.alphaOldValue10035, 1, var_150_22)

				if arg_147_1.var_.characterEffect10035 then
					arg_147_1.var_.characterEffect10035.alpha = var_150_23
				end
			end

			if arg_147_1.time_ >= var_150_19 + var_150_21 and arg_147_1.time_ < var_150_19 + var_150_21 + arg_150_0 and arg_147_1.var_.characterEffect10035 then
				arg_147_1.var_.characterEffect10035.alpha = 1
			end

			local var_150_24 = arg_147_1.actors_["10034"]
			local var_150_25 = 0

			if var_150_25 < arg_147_1.time_ and arg_147_1.time_ <= var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.actorSpriteComps10034 == nil then
				arg_147_1.var_.actorSpriteComps10034 = var_150_24:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_26 = 0.2

			if var_150_25 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 and not isNil(var_150_24) then
				local var_150_27 = (arg_147_1.time_ - var_150_25) / var_150_26

				if arg_147_1.var_.actorSpriteComps10034 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								local var_150_28 = Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, var_150_27)
								local var_150_29 = Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, var_150_27)
								local var_150_30 = Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, var_150_27)

								iter_150_5.color = Color.New(var_150_28, var_150_29, var_150_30)
							else
								local var_150_31 = Mathf.Lerp(iter_150_5.color.r, 0.5, var_150_27)

								iter_150_5.color = Color.New(var_150_31, var_150_31, var_150_31)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.actorSpriteComps10034 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10034 = nil
			end

			local var_150_32 = arg_147_1.actors_["10035"]
			local var_150_33 = 0

			if var_150_33 < arg_147_1.time_ and arg_147_1.time_ <= var_150_33 + arg_150_0 and not isNil(var_150_32) and arg_147_1.var_.actorSpriteComps10035 == nil then
				arg_147_1.var_.actorSpriteComps10035 = var_150_32:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_34 = 0.2

			if var_150_33 <= arg_147_1.time_ and arg_147_1.time_ < var_150_33 + var_150_34 and not isNil(var_150_32) then
				local var_150_35 = (arg_147_1.time_ - var_150_33) / var_150_34

				if arg_147_1.var_.actorSpriteComps10035 then
					for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_150_9 then
							if arg_147_1.isInRecall_ then
								local var_150_36 = Mathf.Lerp(iter_150_9.color.r, arg_147_1.hightColor1.r, var_150_35)
								local var_150_37 = Mathf.Lerp(iter_150_9.color.g, arg_147_1.hightColor1.g, var_150_35)
								local var_150_38 = Mathf.Lerp(iter_150_9.color.b, arg_147_1.hightColor1.b, var_150_35)

								iter_150_9.color = Color.New(var_150_36, var_150_37, var_150_38)
							else
								local var_150_39 = Mathf.Lerp(iter_150_9.color.r, 1, var_150_35)

								iter_150_9.color = Color.New(var_150_39, var_150_39, var_150_39)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_33 + var_150_34 and arg_147_1.time_ < var_150_33 + var_150_34 + arg_150_0 and not isNil(var_150_32) and arg_147_1.var_.actorSpriteComps10035 then
				for iter_150_10, iter_150_11 in pairs(arg_147_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_150_11 then
						if arg_147_1.isInRecall_ then
							iter_150_11.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10035 = nil
			end

			local var_150_40 = 0
			local var_150_41 = 0.4

			if var_150_40 < arg_147_1.time_ and arg_147_1.time_ <= var_150_40 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_42 = arg_147_1:FormatText(StoryNameCfg[369].name)

				arg_147_1.leftNameTxt_.text = var_150_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_43 = arg_147_1:GetWordFromCfg(117041034)
				local var_150_44 = arg_147_1:FormatText(var_150_43.content)

				arg_147_1.text_.text = var_150_44

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_45 = 16
				local var_150_46 = utf8.len(var_150_44)
				local var_150_47 = var_150_45 <= 0 and var_150_41 or var_150_41 * (var_150_46 / var_150_45)

				if var_150_47 > 0 and var_150_41 < var_150_47 then
					arg_147_1.talkMaxDuration = var_150_47

					if var_150_47 + var_150_40 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_47 + var_150_40
					end
				end

				arg_147_1.text_.text = var_150_44
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041034", "story_v_out_117041.awb") ~= 0 then
					local var_150_48 = manager.audio:GetVoiceLength("story_v_out_117041", "117041034", "story_v_out_117041.awb") / 1000

					if var_150_48 + var_150_40 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_48 + var_150_40
					end

					if var_150_43.prefab_name ~= "" and arg_147_1.actors_[var_150_43.prefab_name] ~= nil then
						local var_150_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_43.prefab_name].transform, "story_v_out_117041", "117041034", "story_v_out_117041.awb")

						arg_147_1:RecordAudio("117041034", var_150_49)
						arg_147_1:RecordAudio("117041034", var_150_49)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_117041", "117041034", "story_v_out_117041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_117041", "117041034", "story_v_out_117041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_50 = math.max(var_150_41, arg_147_1.talkMaxDuration)

			if var_150_40 <= arg_147_1.time_ and arg_147_1.time_ < var_150_40 + var_150_50 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_40) / var_150_50

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_40 + var_150_50 and arg_147_1.time_ < var_150_40 + var_150_50 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play117041035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 117041035
		arg_151_1.duration_ = 14.3

		local var_151_0 = {
			zh = 10.7,
			ja = 14.3
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
				arg_151_0:Play117041036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10034"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10034 == nil then
				arg_151_1.var_.actorSpriteComps10034 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10034 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10034 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10034 = nil
			end

			local var_154_8 = arg_151_1.actors_["10035"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps10035 == nil then
				arg_151_1.var_.actorSpriteComps10035 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_10 = 0.2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 and not isNil(var_154_8) then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10

				if arg_151_1.var_.actorSpriteComps10035 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps10035 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_154_7 then
						if arg_151_1.isInRecall_ then
							iter_154_7.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10035 = nil
			end

			local var_154_16 = 0
			local var_154_17 = 0.925

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_18 = arg_151_1:FormatText(StoryNameCfg[367].name)

				arg_151_1.leftNameTxt_.text = var_154_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_19 = arg_151_1:GetWordFromCfg(117041035)
				local var_154_20 = arg_151_1:FormatText(var_154_19.content)

				arg_151_1.text_.text = var_154_20

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_21 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041035", "story_v_out_117041.awb") ~= 0 then
					local var_154_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041035", "story_v_out_117041.awb") / 1000

					if var_154_24 + var_154_16 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_24 + var_154_16
					end

					if var_154_19.prefab_name ~= "" and arg_151_1.actors_[var_154_19.prefab_name] ~= nil then
						local var_154_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_19.prefab_name].transform, "story_v_out_117041", "117041035", "story_v_out_117041.awb")

						arg_151_1:RecordAudio("117041035", var_154_25)
						arg_151_1:RecordAudio("117041035", var_154_25)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_117041", "117041035", "story_v_out_117041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_117041", "117041035", "story_v_out_117041.awb")
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
	Play117041036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 117041036
		arg_155_1.duration_ = 3.2

		local var_155_0 = {
			zh = 3.2,
			ja = 2.266
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
				arg_155_0:Play117041037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10034"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10034 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10034", 2)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_3" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(-390, -415, -290)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10034, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_158_7 = arg_155_1.actors_["10035"].transform
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.var_.moveOldPos10035 = var_158_7.localPosition
				var_158_7.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10035", 4)

				local var_158_9 = var_158_7.childCount

				for iter_158_1 = 0, var_158_9 - 1 do
					local var_158_10 = var_158_7:GetChild(iter_158_1)

					if var_158_10.name == "split_1" or not string.find(var_158_10.name, "split") then
						var_158_10.gameObject:SetActive(true)
					else
						var_158_10.gameObject:SetActive(false)
					end
				end
			end

			local var_158_11 = 0.001

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_11 then
				local var_158_12 = (arg_155_1.time_ - var_158_8) / var_158_11
				local var_158_13 = Vector3.New(390, -410, -235)

				var_158_7.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10035, var_158_13, var_158_12)
			end

			if arg_155_1.time_ >= var_158_8 + var_158_11 and arg_155_1.time_ < var_158_8 + var_158_11 + arg_158_0 then
				var_158_7.localPosition = Vector3.New(390, -410, -235)
			end

			local var_158_14 = arg_155_1.actors_["10034"]
			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 and not isNil(var_158_14) and arg_155_1.var_.actorSpriteComps10034 == nil then
				arg_155_1.var_.actorSpriteComps10034 = var_158_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_16 = 0.2

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_16 and not isNil(var_158_14) then
				local var_158_17 = (arg_155_1.time_ - var_158_15) / var_158_16

				if arg_155_1.var_.actorSpriteComps10034 then
					for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_158_3 then
							if arg_155_1.isInRecall_ then
								local var_158_18 = Mathf.Lerp(iter_158_3.color.r, arg_155_1.hightColor2.r, var_158_17)
								local var_158_19 = Mathf.Lerp(iter_158_3.color.g, arg_155_1.hightColor2.g, var_158_17)
								local var_158_20 = Mathf.Lerp(iter_158_3.color.b, arg_155_1.hightColor2.b, var_158_17)

								iter_158_3.color = Color.New(var_158_18, var_158_19, var_158_20)
							else
								local var_158_21 = Mathf.Lerp(iter_158_3.color.r, 0.5, var_158_17)

								iter_158_3.color = Color.New(var_158_21, var_158_21, var_158_21)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_15 + var_158_16 and arg_155_1.time_ < var_158_15 + var_158_16 + arg_158_0 and not isNil(var_158_14) and arg_155_1.var_.actorSpriteComps10034 then
				for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_158_5 then
						if arg_155_1.isInRecall_ then
							iter_158_5.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10034 = nil
			end

			local var_158_22 = arg_155_1.actors_["10035"]
			local var_158_23 = 0

			if var_158_23 < arg_155_1.time_ and arg_155_1.time_ <= var_158_23 + arg_158_0 and not isNil(var_158_22) and arg_155_1.var_.actorSpriteComps10035 == nil then
				arg_155_1.var_.actorSpriteComps10035 = var_158_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_24 = 0.2

			if var_158_23 <= arg_155_1.time_ and arg_155_1.time_ < var_158_23 + var_158_24 and not isNil(var_158_22) then
				local var_158_25 = (arg_155_1.time_ - var_158_23) / var_158_24

				if arg_155_1.var_.actorSpriteComps10035 then
					for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_158_7 then
							if arg_155_1.isInRecall_ then
								local var_158_26 = Mathf.Lerp(iter_158_7.color.r, arg_155_1.hightColor1.r, var_158_25)
								local var_158_27 = Mathf.Lerp(iter_158_7.color.g, arg_155_1.hightColor1.g, var_158_25)
								local var_158_28 = Mathf.Lerp(iter_158_7.color.b, arg_155_1.hightColor1.b, var_158_25)

								iter_158_7.color = Color.New(var_158_26, var_158_27, var_158_28)
							else
								local var_158_29 = Mathf.Lerp(iter_158_7.color.r, 1, var_158_25)

								iter_158_7.color = Color.New(var_158_29, var_158_29, var_158_29)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_23 + var_158_24 and arg_155_1.time_ < var_158_23 + var_158_24 + arg_158_0 and not isNil(var_158_22) and arg_155_1.var_.actorSpriteComps10035 then
				for iter_158_8, iter_158_9 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_158_9 then
						if arg_155_1.isInRecall_ then
							iter_158_9.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10035 = nil
			end

			local var_158_30 = 0
			local var_158_31 = 0.325

			if var_158_30 < arg_155_1.time_ and arg_155_1.time_ <= var_158_30 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_32 = arg_155_1:FormatText(StoryNameCfg[369].name)

				arg_155_1.leftNameTxt_.text = var_158_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_33 = arg_155_1:GetWordFromCfg(117041036)
				local var_158_34 = arg_155_1:FormatText(var_158_33.content)

				arg_155_1.text_.text = var_158_34

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_35 = 13
				local var_158_36 = utf8.len(var_158_34)
				local var_158_37 = var_158_35 <= 0 and var_158_31 or var_158_31 * (var_158_36 / var_158_35)

				if var_158_37 > 0 and var_158_31 < var_158_37 then
					arg_155_1.talkMaxDuration = var_158_37

					if var_158_37 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_37 + var_158_30
					end
				end

				arg_155_1.text_.text = var_158_34
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041036", "story_v_out_117041.awb") ~= 0 then
					local var_158_38 = manager.audio:GetVoiceLength("story_v_out_117041", "117041036", "story_v_out_117041.awb") / 1000

					if var_158_38 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_38 + var_158_30
					end

					if var_158_33.prefab_name ~= "" and arg_155_1.actors_[var_158_33.prefab_name] ~= nil then
						local var_158_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_33.prefab_name].transform, "story_v_out_117041", "117041036", "story_v_out_117041.awb")

						arg_155_1:RecordAudio("117041036", var_158_39)
						arg_155_1:RecordAudio("117041036", var_158_39)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_117041", "117041036", "story_v_out_117041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_117041", "117041036", "story_v_out_117041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_40 = math.max(var_158_31, arg_155_1.talkMaxDuration)

			if var_158_30 <= arg_155_1.time_ and arg_155_1.time_ < var_158_30 + var_158_40 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_30) / var_158_40

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_30 + var_158_40 and arg_155_1.time_ < var_158_30 + var_158_40 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play117041037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 117041037
		arg_159_1.duration_ = 7.73

		local var_159_0 = {
			zh = 6.133,
			ja = 7.733
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
				arg_159_0:Play117041038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.725

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[369].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(117041037)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041037", "story_v_out_117041.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041037", "story_v_out_117041.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_117041", "117041037", "story_v_out_117041.awb")

						arg_159_1:RecordAudio("117041037", var_162_9)
						arg_159_1:RecordAudio("117041037", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_117041", "117041037", "story_v_out_117041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_117041", "117041037", "story_v_out_117041.awb")
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
	Play117041038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 117041038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play117041039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10035"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10035 == nil then
				arg_163_1.var_.actorSpriteComps10035 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10035 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 0.5, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10035 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10035 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.45

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(117041038)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 18
				local var_166_13 = utf8.len(var_166_11)
				local var_166_14 = var_166_12 <= 0 and var_166_9 or var_166_9 * (var_166_13 / var_166_12)

				if var_166_14 > 0 and var_166_9 < var_166_14 then
					arg_163_1.talkMaxDuration = var_166_14

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_15 and arg_163_1.time_ < var_166_8 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play117041039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 117041039
		arg_167_1.duration_ = 6.23

		local var_167_0 = {
			zh = 6.1,
			ja = 6.233
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
				arg_167_0:Play117041040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10034"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10034 == nil then
				arg_167_1.var_.actorSpriteComps10034 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10034 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 1, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10034 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10034 = nil
			end

			local var_170_8 = arg_167_1.actors_["10034"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos10034 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10034", 2)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "split_2" or not string.find(var_170_11.name, "split") then
						var_170_11.gameObject:SetActive(true)
					else
						var_170_11.gameObject:SetActive(false)
					end
				end
			end

			local var_170_12 = 0.001

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(-390, -415, -290)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10034, var_170_14, var_170_13)
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_170_15 = 0
			local var_170_16 = 0.675

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[367].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(117041039)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 27
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041039", "story_v_out_117041.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_117041", "117041039", "story_v_out_117041.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_117041", "117041039", "story_v_out_117041.awb")

						arg_167_1:RecordAudio("117041039", var_170_24)
						arg_167_1:RecordAudio("117041039", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_117041", "117041039", "story_v_out_117041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_117041", "117041039", "story_v_out_117041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play117041040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 117041040
		arg_171_1.duration_ = 4.7

		local var_171_0 = {
			zh = 4.7,
			ja = 2.166
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
				arg_171_0:Play117041041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10034"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10034 == nil then
				arg_171_1.var_.actorSpriteComps10034 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps10034 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10034 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10034 = nil
			end

			local var_174_8 = arg_171_1.actors_["10035"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10035 == nil then
				arg_171_1.var_.actorSpriteComps10035 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_10 = 0.2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 and not isNil(var_174_8) then
				local var_174_11 = (arg_171_1.time_ - var_174_9) / var_174_10

				if arg_171_1.var_.actorSpriteComps10035 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10035 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10035 = nil
			end

			local var_174_16 = 0
			local var_174_17 = 0.475

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_18 = arg_171_1:FormatText(StoryNameCfg[369].name)

				arg_171_1.leftNameTxt_.text = var_174_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_19 = arg_171_1:GetWordFromCfg(117041040)
				local var_174_20 = arg_171_1:FormatText(var_174_19.content)

				arg_171_1.text_.text = var_174_20

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041040", "story_v_out_117041.awb") ~= 0 then
					local var_174_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041040", "story_v_out_117041.awb") / 1000

					if var_174_24 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_16
					end

					if var_174_19.prefab_name ~= "" and arg_171_1.actors_[var_174_19.prefab_name] ~= nil then
						local var_174_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_19.prefab_name].transform, "story_v_out_117041", "117041040", "story_v_out_117041.awb")

						arg_171_1:RecordAudio("117041040", var_174_25)
						arg_171_1:RecordAudio("117041040", var_174_25)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_117041", "117041040", "story_v_out_117041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_117041", "117041040", "story_v_out_117041.awb")
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
	Play117041041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 117041041
		arg_175_1.duration_ = 5.87

		local var_175_0 = {
			zh = 5.866,
			ja = 5.466
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
				arg_175_0:Play117041042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10034"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10034 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10034", 2)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "split_2" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(-390, -415, -290)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10034, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_178_7 = arg_175_1.actors_["10035"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10035 == nil then
				arg_175_1.var_.actorSpriteComps10035 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 0.2

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps10035 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 0.5, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10035 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10035 = nil
			end

			local var_178_15 = arg_175_1.actors_["10034"]
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.actorSpriteComps10034 == nil then
				arg_175_1.var_.actorSpriteComps10034 = var_178_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_17 = 0.2

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 and not isNil(var_178_15) then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17

				if arg_175_1.var_.actorSpriteComps10034 then
					for iter_178_5, iter_178_6 in pairs(arg_175_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_178_6 then
							if arg_175_1.isInRecall_ then
								local var_178_19 = Mathf.Lerp(iter_178_6.color.r, arg_175_1.hightColor1.r, var_178_18)
								local var_178_20 = Mathf.Lerp(iter_178_6.color.g, arg_175_1.hightColor1.g, var_178_18)
								local var_178_21 = Mathf.Lerp(iter_178_6.color.b, arg_175_1.hightColor1.b, var_178_18)

								iter_178_6.color = Color.New(var_178_19, var_178_20, var_178_21)
							else
								local var_178_22 = Mathf.Lerp(iter_178_6.color.r, 1, var_178_18)

								iter_178_6.color = Color.New(var_178_22, var_178_22, var_178_22)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.actorSpriteComps10034 then
				for iter_178_7, iter_178_8 in pairs(arg_175_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_178_8 then
						if arg_175_1.isInRecall_ then
							iter_178_8.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10034 = nil
			end

			local var_178_23 = 0
			local var_178_24 = 0.6

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_25 = arg_175_1:FormatText(StoryNameCfg[367].name)

				arg_175_1.leftNameTxt_.text = var_178_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_26 = arg_175_1:GetWordFromCfg(117041041)
				local var_178_27 = arg_175_1:FormatText(var_178_26.content)

				arg_175_1.text_.text = var_178_27

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_28 = 24
				local var_178_29 = utf8.len(var_178_27)
				local var_178_30 = var_178_28 <= 0 and var_178_24 or var_178_24 * (var_178_29 / var_178_28)

				if var_178_30 > 0 and var_178_24 < var_178_30 then
					arg_175_1.talkMaxDuration = var_178_30

					if var_178_30 + var_178_23 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_30 + var_178_23
					end
				end

				arg_175_1.text_.text = var_178_27
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041041", "story_v_out_117041.awb") ~= 0 then
					local var_178_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041041", "story_v_out_117041.awb") / 1000

					if var_178_31 + var_178_23 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_31 + var_178_23
					end

					if var_178_26.prefab_name ~= "" and arg_175_1.actors_[var_178_26.prefab_name] ~= nil then
						local var_178_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_26.prefab_name].transform, "story_v_out_117041", "117041041", "story_v_out_117041.awb")

						arg_175_1:RecordAudio("117041041", var_178_32)
						arg_175_1:RecordAudio("117041041", var_178_32)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_117041", "117041041", "story_v_out_117041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_117041", "117041041", "story_v_out_117041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_33 = math.max(var_178_24, arg_175_1.talkMaxDuration)

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_33 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_23) / var_178_33

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_23 + var_178_33 and arg_175_1.time_ < var_178_23 + var_178_33 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play117041042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 117041042
		arg_179_1.duration_ = 11.5

		local var_179_0 = {
			zh = 11.5,
			ja = 4.2
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
				arg_179_0:Play117041043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10034"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10034 == nil then
				arg_179_1.var_.actorSpriteComps10034 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps10034 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10034 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10034 = nil
			end

			local var_182_8 = arg_179_1.actors_["10035"].transform
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1.var_.moveOldPos10035 = var_182_8.localPosition
				var_182_8.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10035", 4)

				local var_182_10 = var_182_8.childCount

				for iter_182_4 = 0, var_182_10 - 1 do
					local var_182_11 = var_182_8:GetChild(iter_182_4)

					if var_182_11.name == "split_4" or not string.find(var_182_11.name, "split") then
						var_182_11.gameObject:SetActive(true)
					else
						var_182_11.gameObject:SetActive(false)
					end
				end
			end

			local var_182_12 = 0.001

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_12 then
				local var_182_13 = (arg_179_1.time_ - var_182_9) / var_182_12
				local var_182_14 = Vector3.New(390, -410, -235)

				var_182_8.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10035, var_182_14, var_182_13)
			end

			if arg_179_1.time_ >= var_182_9 + var_182_12 and arg_179_1.time_ < var_182_9 + var_182_12 + arg_182_0 then
				var_182_8.localPosition = Vector3.New(390, -410, -235)
			end

			local var_182_15 = arg_179_1.actors_["10035"]
			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.actorSpriteComps10035 == nil then
				arg_179_1.var_.actorSpriteComps10035 = var_182_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_17 = 0.2

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 and not isNil(var_182_15) then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17

				if arg_179_1.var_.actorSpriteComps10035 then
					for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_182_6 then
							if arg_179_1.isInRecall_ then
								local var_182_19 = Mathf.Lerp(iter_182_6.color.r, arg_179_1.hightColor1.r, var_182_18)
								local var_182_20 = Mathf.Lerp(iter_182_6.color.g, arg_179_1.hightColor1.g, var_182_18)
								local var_182_21 = Mathf.Lerp(iter_182_6.color.b, arg_179_1.hightColor1.b, var_182_18)

								iter_182_6.color = Color.New(var_182_19, var_182_20, var_182_21)
							else
								local var_182_22 = Mathf.Lerp(iter_182_6.color.r, 1, var_182_18)

								iter_182_6.color = Color.New(var_182_22, var_182_22, var_182_22)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.actorSpriteComps10035 then
				for iter_182_7, iter_182_8 in pairs(arg_179_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_182_8 then
						if arg_179_1.isInRecall_ then
							iter_182_8.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10035 = nil
			end

			local var_182_23 = 0
			local var_182_24 = 1.075

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[369].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(117041042)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 42
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041042", "story_v_out_117041.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041042", "story_v_out_117041.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_117041", "117041042", "story_v_out_117041.awb")

						arg_179_1:RecordAudio("117041042", var_182_32)
						arg_179_1:RecordAudio("117041042", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_117041", "117041042", "story_v_out_117041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_117041", "117041042", "story_v_out_117041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play117041043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 117041043
		arg_183_1.duration_ = 5

		local var_183_0 = {
			zh = 5,
			ja = 4.7
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
				arg_183_0:Play117041044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10034"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10034 == nil then
				arg_183_1.var_.actorSpriteComps10034 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps10034 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10034 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10034 = nil
			end

			local var_186_8 = 0
			local var_186_9 = 0.575

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_10 = arg_183_1:FormatText(StoryNameCfg[369].name)

				arg_183_1.leftNameTxt_.text = var_186_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_11 = arg_183_1:GetWordFromCfg(117041043)
				local var_186_12 = arg_183_1:FormatText(var_186_11.content)

				arg_183_1.text_.text = var_186_12

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 23
				local var_186_14 = utf8.len(var_186_12)
				local var_186_15 = var_186_13 <= 0 and var_186_9 or var_186_9 * (var_186_14 / var_186_13)

				if var_186_15 > 0 and var_186_9 < var_186_15 then
					arg_183_1.talkMaxDuration = var_186_15

					if var_186_15 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_15 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_12
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041043", "story_v_out_117041.awb") ~= 0 then
					local var_186_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041043", "story_v_out_117041.awb") / 1000

					if var_186_16 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_16 + var_186_8
					end

					if var_186_11.prefab_name ~= "" and arg_183_1.actors_[var_186_11.prefab_name] ~= nil then
						local var_186_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_11.prefab_name].transform, "story_v_out_117041", "117041043", "story_v_out_117041.awb")

						arg_183_1:RecordAudio("117041043", var_186_17)
						arg_183_1:RecordAudio("117041043", var_186_17)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_117041", "117041043", "story_v_out_117041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_117041", "117041043", "story_v_out_117041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_18 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_18 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_18

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_18 and arg_183_1.time_ < var_186_8 + var_186_18 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play117041044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 117041044
		arg_187_1.duration_ = 7.07

		local var_187_0 = {
			zh = 4.8,
			ja = 7.066
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
				arg_187_0:Play117041045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10034"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10034 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10034", 2)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "split_5" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(-390, -415, -290)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10034, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_190_7 = arg_187_1.actors_["10035"]
			local var_190_8 = 0

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10035 == nil then
				arg_187_1.var_.actorSpriteComps10035 = var_190_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 0.2

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 and not isNil(var_190_7) then
				local var_190_10 = (arg_187_1.time_ - var_190_8) / var_190_9

				if arg_187_1.var_.actorSpriteComps10035 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								local var_190_11 = Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor2.r, var_190_10)
								local var_190_12 = Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor2.g, var_190_10)
								local var_190_13 = Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor2.b, var_190_10)

								iter_190_2.color = Color.New(var_190_11, var_190_12, var_190_13)
							else
								local var_190_14 = Mathf.Lerp(iter_190_2.color.r, 0.5, var_190_10)

								iter_190_2.color = Color.New(var_190_14, var_190_14, var_190_14)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10035 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_190_4 then
						if arg_187_1.isInRecall_ then
							iter_190_4.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10035 = nil
			end

			local var_190_15 = arg_187_1.actors_["10034"]
			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 and not isNil(var_190_15) and arg_187_1.var_.actorSpriteComps10034 == nil then
				arg_187_1.var_.actorSpriteComps10034 = var_190_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_17 = 0.2

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 and not isNil(var_190_15) then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17

				if arg_187_1.var_.actorSpriteComps10034 then
					for iter_190_5, iter_190_6 in pairs(arg_187_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_190_6 then
							if arg_187_1.isInRecall_ then
								local var_190_19 = Mathf.Lerp(iter_190_6.color.r, arg_187_1.hightColor1.r, var_190_18)
								local var_190_20 = Mathf.Lerp(iter_190_6.color.g, arg_187_1.hightColor1.g, var_190_18)
								local var_190_21 = Mathf.Lerp(iter_190_6.color.b, arg_187_1.hightColor1.b, var_190_18)

								iter_190_6.color = Color.New(var_190_19, var_190_20, var_190_21)
							else
								local var_190_22 = Mathf.Lerp(iter_190_6.color.r, 1, var_190_18)

								iter_190_6.color = Color.New(var_190_22, var_190_22, var_190_22)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 and not isNil(var_190_15) and arg_187_1.var_.actorSpriteComps10034 then
				for iter_190_7, iter_190_8 in pairs(arg_187_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_190_8 then
						if arg_187_1.isInRecall_ then
							iter_190_8.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10034 = nil
			end

			local var_190_23 = 0
			local var_190_24 = 0.525

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_25 = arg_187_1:FormatText(StoryNameCfg[367].name)

				arg_187_1.leftNameTxt_.text = var_190_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_26 = arg_187_1:GetWordFromCfg(117041044)
				local var_190_27 = arg_187_1:FormatText(var_190_26.content)

				arg_187_1.text_.text = var_190_27

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_28 = 21
				local var_190_29 = utf8.len(var_190_27)
				local var_190_30 = var_190_28 <= 0 and var_190_24 or var_190_24 * (var_190_29 / var_190_28)

				if var_190_30 > 0 and var_190_24 < var_190_30 then
					arg_187_1.talkMaxDuration = var_190_30

					if var_190_30 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_30 + var_190_23
					end
				end

				arg_187_1.text_.text = var_190_27
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041044", "story_v_out_117041.awb") ~= 0 then
					local var_190_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041044", "story_v_out_117041.awb") / 1000

					if var_190_31 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_31 + var_190_23
					end

					if var_190_26.prefab_name ~= "" and arg_187_1.actors_[var_190_26.prefab_name] ~= nil then
						local var_190_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_26.prefab_name].transform, "story_v_out_117041", "117041044", "story_v_out_117041.awb")

						arg_187_1:RecordAudio("117041044", var_190_32)
						arg_187_1:RecordAudio("117041044", var_190_32)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_117041", "117041044", "story_v_out_117041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_117041", "117041044", "story_v_out_117041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_33 = math.max(var_190_24, arg_187_1.talkMaxDuration)

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_33 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_23) / var_190_33

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_23 + var_190_33 and arg_187_1.time_ < var_190_23 + var_190_33 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play117041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 117041045
		arg_191_1.duration_ = 6.23

		local var_191_0 = {
			zh = 6.233,
			ja = 5.3
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
				arg_191_0:Play117041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10034"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10034 == nil then
				arg_191_1.var_.actorSpriteComps10034 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps10034 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10034 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10034 = nil
			end

			local var_194_8 = arg_191_1.actors_["10035"]
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10035 == nil then
				arg_191_1.var_.actorSpriteComps10035 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_10 = 0.2

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 and not isNil(var_194_8) then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10

				if arg_191_1.var_.actorSpriteComps10035 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10035 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_194_7 then
						if arg_191_1.isInRecall_ then
							iter_194_7.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10035 = nil
			end

			local var_194_16 = 0
			local var_194_17 = 0.7

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_18 = arg_191_1:FormatText(StoryNameCfg[369].name)

				arg_191_1.leftNameTxt_.text = var_194_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_19 = arg_191_1:GetWordFromCfg(117041045)
				local var_194_20 = arg_191_1:FormatText(var_194_19.content)

				arg_191_1.text_.text = var_194_20

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_21 = 28
				local var_194_22 = utf8.len(var_194_20)
				local var_194_23 = var_194_21 <= 0 and var_194_17 or var_194_17 * (var_194_22 / var_194_21)

				if var_194_23 > 0 and var_194_17 < var_194_23 then
					arg_191_1.talkMaxDuration = var_194_23

					if var_194_23 + var_194_16 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_16
					end
				end

				arg_191_1.text_.text = var_194_20
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041045", "story_v_out_117041.awb") ~= 0 then
					local var_194_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041045", "story_v_out_117041.awb") / 1000

					if var_194_24 + var_194_16 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_24 + var_194_16
					end

					if var_194_19.prefab_name ~= "" and arg_191_1.actors_[var_194_19.prefab_name] ~= nil then
						local var_194_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_19.prefab_name].transform, "story_v_out_117041", "117041045", "story_v_out_117041.awb")

						arg_191_1:RecordAudio("117041045", var_194_25)
						arg_191_1:RecordAudio("117041045", var_194_25)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_117041", "117041045", "story_v_out_117041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_117041", "117041045", "story_v_out_117041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_26 = math.max(var_194_17, arg_191_1.talkMaxDuration)

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_26 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_16) / var_194_26

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_16 + var_194_26 and arg_191_1.time_ < var_194_16 + var_194_26 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play117041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 117041046
		arg_195_1.duration_ = 13.67

		local var_195_0 = {
			zh = 9.8,
			ja = 13.666
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
				arg_195_0:Play117041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10034"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10034 == nil then
				arg_195_1.var_.actorSpriteComps10034 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10034 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 1, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10034 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10034 = nil
			end

			local var_198_8 = arg_195_1.actors_["10035"]
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps10035 == nil then
				arg_195_1.var_.actorSpriteComps10035 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_10 = 0.2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 and not isNil(var_198_8) then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10

				if arg_195_1.var_.actorSpriteComps10035 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								local var_198_12 = Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, var_198_11)
								local var_198_13 = Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, var_198_11)
								local var_198_14 = Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, var_198_11)

								iter_198_5.color = Color.New(var_198_12, var_198_13, var_198_14)
							else
								local var_198_15 = Mathf.Lerp(iter_198_5.color.r, 0.5, var_198_11)

								iter_198_5.color = Color.New(var_198_15, var_198_15, var_198_15)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps10035 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_198_7 then
						if arg_195_1.isInRecall_ then
							iter_198_7.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10035 = nil
			end

			local var_198_16 = arg_195_1.actors_["10034"].transform
			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.var_.moveOldPos10034 = var_198_16.localPosition
				var_198_16.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10034", 2)

				local var_198_18 = var_198_16.childCount

				for iter_198_8 = 0, var_198_18 - 1 do
					local var_198_19 = var_198_16:GetChild(iter_198_8)

					if var_198_19.name == "split_2" or not string.find(var_198_19.name, "split") then
						var_198_19.gameObject:SetActive(true)
					else
						var_198_19.gameObject:SetActive(false)
					end
				end
			end

			local var_198_20 = 0.001

			if var_198_17 <= arg_195_1.time_ and arg_195_1.time_ < var_198_17 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_17) / var_198_20
				local var_198_22 = Vector3.New(-390, -415, -290)

				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10034, var_198_22, var_198_21)
			end

			if arg_195_1.time_ >= var_198_17 + var_198_20 and arg_195_1.time_ < var_198_17 + var_198_20 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_198_23 = 0
			local var_198_24 = 0.95

			if var_198_23 < arg_195_1.time_ and arg_195_1.time_ <= var_198_23 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_25 = arg_195_1:FormatText(StoryNameCfg[367].name)

				arg_195_1.leftNameTxt_.text = var_198_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_26 = arg_195_1:GetWordFromCfg(117041046)
				local var_198_27 = arg_195_1:FormatText(var_198_26.content)

				arg_195_1.text_.text = var_198_27

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_28 = 38
				local var_198_29 = utf8.len(var_198_27)
				local var_198_30 = var_198_28 <= 0 and var_198_24 or var_198_24 * (var_198_29 / var_198_28)

				if var_198_30 > 0 and var_198_24 < var_198_30 then
					arg_195_1.talkMaxDuration = var_198_30

					if var_198_30 + var_198_23 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_30 + var_198_23
					end
				end

				arg_195_1.text_.text = var_198_27
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041046", "story_v_out_117041.awb") ~= 0 then
					local var_198_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041046", "story_v_out_117041.awb") / 1000

					if var_198_31 + var_198_23 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_31 + var_198_23
					end

					if var_198_26.prefab_name ~= "" and arg_195_1.actors_[var_198_26.prefab_name] ~= nil then
						local var_198_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_26.prefab_name].transform, "story_v_out_117041", "117041046", "story_v_out_117041.awb")

						arg_195_1:RecordAudio("117041046", var_198_32)
						arg_195_1:RecordAudio("117041046", var_198_32)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_117041", "117041046", "story_v_out_117041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_117041", "117041046", "story_v_out_117041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_33 = math.max(var_198_24, arg_195_1.talkMaxDuration)

			if var_198_23 <= arg_195_1.time_ and arg_195_1.time_ < var_198_23 + var_198_33 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_23) / var_198_33

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_23 + var_198_33 and arg_195_1.time_ < var_198_23 + var_198_33 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play117041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 117041047
		arg_199_1.duration_ = 2.27

		local var_199_0 = {
			zh = 2,
			ja = 2.266
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
				arg_199_0:Play117041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10034"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10034 == nil then
				arg_199_1.var_.actorSpriteComps10034 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10034 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 0.5, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10034 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10034 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.275

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[61].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_2")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(117041047)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 11
				local var_202_14 = utf8.len(var_202_12)
				local var_202_15 = var_202_13 <= 0 and var_202_9 or var_202_9 * (var_202_14 / var_202_13)

				if var_202_15 > 0 and var_202_9 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_12
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041047", "story_v_out_117041.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041047", "story_v_out_117041.awb") / 1000

					if var_202_16 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_8
					end

					if var_202_11.prefab_name ~= "" and arg_199_1.actors_[var_202_11.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_11.prefab_name].transform, "story_v_out_117041", "117041047", "story_v_out_117041.awb")

						arg_199_1:RecordAudio("117041047", var_202_17)
						arg_199_1:RecordAudio("117041047", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_117041", "117041047", "story_v_out_117041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_117041", "117041047", "story_v_out_117041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_18 and arg_199_1.time_ < var_202_8 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play117041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 117041048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play117041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.8

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(117041048)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 32
				local var_206_5 = utf8.len(var_206_3)
				local var_206_6 = var_206_4 <= 0 and var_206_1 or var_206_1 * (var_206_5 / var_206_4)

				if var_206_6 > 0 and var_206_1 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_7 and arg_203_1.time_ < var_206_0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play117041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 117041049
		arg_207_1.duration_ = 4.97

		local var_207_0 = {
			zh = 1.533,
			ja = 4.966
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
				arg_207_0:Play117041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10034"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10034 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10034", 2)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "split_1" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(-390, -415, -290)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10034, var_210_6, var_210_5)
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_210_7 = arg_207_1.actors_["10034"]
			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10034 == nil then
				arg_207_1.var_.actorSpriteComps10034 = var_210_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_9 = 0.2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 and not isNil(var_210_7) then
				local var_210_10 = (arg_207_1.time_ - var_210_8) / var_210_9

				if arg_207_1.var_.actorSpriteComps10034 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								local var_210_11 = Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, var_210_10)
								local var_210_12 = Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, var_210_10)
								local var_210_13 = Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, var_210_10)

								iter_210_2.color = Color.New(var_210_11, var_210_12, var_210_13)
							else
								local var_210_14 = Mathf.Lerp(iter_210_2.color.r, 1, var_210_10)

								iter_210_2.color = Color.New(var_210_14, var_210_14, var_210_14)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10034 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_210_4 then
						if arg_207_1.isInRecall_ then
							iter_210_4.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10034 = nil
			end

			local var_210_15 = 0
			local var_210_16 = 0.15

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[367].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(117041049)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 6
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041049", "story_v_out_117041.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_117041", "117041049", "story_v_out_117041.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_117041", "117041049", "story_v_out_117041.awb")

						arg_207_1:RecordAudio("117041049", var_210_24)
						arg_207_1:RecordAudio("117041049", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_117041", "117041049", "story_v_out_117041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_117041", "117041049", "story_v_out_117041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play117041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 117041050
		arg_211_1.duration_ = 1.83

		local var_211_0 = {
			zh = 1.833,
			ja = 1.3
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
				arg_211_0:Play117041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10034"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10034 == nil then
				arg_211_1.var_.actorSpriteComps10034 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps10034 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10034:ToTable()) do
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

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10034 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10034 = nil
			end

			local var_214_8 = arg_211_1.actors_["10035"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos10035 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10035", 4)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "split_5" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(390, -410, -235)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10035, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(390, -410, -235)
			end

			local var_214_15 = arg_211_1.actors_["10035"]
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.actorSpriteComps10035 == nil then
				arg_211_1.var_.actorSpriteComps10035 = var_214_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_17 = 0.2

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 and not isNil(var_214_15) then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17

				if arg_211_1.var_.actorSpriteComps10035 then
					for iter_214_5, iter_214_6 in pairs(arg_211_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_214_6 then
							if arg_211_1.isInRecall_ then
								local var_214_19 = Mathf.Lerp(iter_214_6.color.r, arg_211_1.hightColor1.r, var_214_18)
								local var_214_20 = Mathf.Lerp(iter_214_6.color.g, arg_211_1.hightColor1.g, var_214_18)
								local var_214_21 = Mathf.Lerp(iter_214_6.color.b, arg_211_1.hightColor1.b, var_214_18)

								iter_214_6.color = Color.New(var_214_19, var_214_20, var_214_21)
							else
								local var_214_22 = Mathf.Lerp(iter_214_6.color.r, 1, var_214_18)

								iter_214_6.color = Color.New(var_214_22, var_214_22, var_214_22)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.actorSpriteComps10035 then
				for iter_214_7, iter_214_8 in pairs(arg_211_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_214_8 then
						if arg_211_1.isInRecall_ then
							iter_214_8.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10035 = nil
			end

			local var_214_23 = 0
			local var_214_24 = 0.15

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_25 = arg_211_1:FormatText(StoryNameCfg[369].name)

				arg_211_1.leftNameTxt_.text = var_214_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_26 = arg_211_1:GetWordFromCfg(117041050)
				local var_214_27 = arg_211_1:FormatText(var_214_26.content)

				arg_211_1.text_.text = var_214_27

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_28 = 6
				local var_214_29 = utf8.len(var_214_27)
				local var_214_30 = var_214_28 <= 0 and var_214_24 or var_214_24 * (var_214_29 / var_214_28)

				if var_214_30 > 0 and var_214_24 < var_214_30 then
					arg_211_1.talkMaxDuration = var_214_30

					if var_214_30 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_30 + var_214_23
					end
				end

				arg_211_1.text_.text = var_214_27
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041050", "story_v_out_117041.awb") ~= 0 then
					local var_214_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041050", "story_v_out_117041.awb") / 1000

					if var_214_31 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_31 + var_214_23
					end

					if var_214_26.prefab_name ~= "" and arg_211_1.actors_[var_214_26.prefab_name] ~= nil then
						local var_214_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_26.prefab_name].transform, "story_v_out_117041", "117041050", "story_v_out_117041.awb")

						arg_211_1:RecordAudio("117041050", var_214_32)
						arg_211_1:RecordAudio("117041050", var_214_32)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_117041", "117041050", "story_v_out_117041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_117041", "117041050", "story_v_out_117041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_33 = math.max(var_214_24, arg_211_1.talkMaxDuration)

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_33 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_23) / var_214_33

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_23 + var_214_33 and arg_211_1.time_ < var_214_23 + var_214_33 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play117041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 117041051
		arg_215_1.duration_ = 5.5

		local var_215_0 = {
			zh = 5.5,
			ja = 4.466
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
				arg_215_0:Play117041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = "1132"

			if arg_215_1.actors_[var_218_0] == nil then
				local var_218_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_218_1) then
					local var_218_2 = Object.Instantiate(var_218_1, arg_215_1.canvasGo_.transform)

					var_218_2.transform:SetSiblingIndex(1)

					var_218_2.name = var_218_0
					var_218_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_215_1.actors_[var_218_0] = var_218_2

					local var_218_3 = var_218_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_215_1.isInRecall_ then
						for iter_218_0, iter_218_1 in ipairs(var_218_3) do
							iter_218_1.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_218_4 = arg_215_1.actors_["1132"].transform
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.var_.moveOldPos1132 = var_218_4.localPosition
				var_218_4.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1132", 3)

				local var_218_6 = var_218_4.childCount

				for iter_218_2 = 0, var_218_6 - 1 do
					local var_218_7 = var_218_4:GetChild(iter_218_2)

					if var_218_7.name == "split_2" or not string.find(var_218_7.name, "split") then
						var_218_7.gameObject:SetActive(true)
					else
						var_218_7.gameObject:SetActive(false)
					end
				end
			end

			local var_218_8 = 0.001

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_8 then
				local var_218_9 = (arg_215_1.time_ - var_218_5) / var_218_8
				local var_218_10 = Vector3.New(0, -413, -185)

				var_218_4.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1132, var_218_10, var_218_9)
			end

			if arg_215_1.time_ >= var_218_5 + var_218_8 and arg_215_1.time_ < var_218_5 + var_218_8 + arg_218_0 then
				var_218_4.localPosition = Vector3.New(0, -413, -185)
			end

			local var_218_11 = arg_215_1.actors_["1132"]
			local var_218_12 = 0

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				local var_218_13 = var_218_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_13 then
					arg_215_1.var_.alphaOldValue1132 = var_218_13.alpha
					arg_215_1.var_.characterEffect1132 = var_218_13
				end

				arg_215_1.var_.alphaOldValue1132 = 0
			end

			local var_218_14 = 0.333333333333333

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_14 then
				local var_218_15 = (arg_215_1.time_ - var_218_12) / var_218_14
				local var_218_16 = Mathf.Lerp(arg_215_1.var_.alphaOldValue1132, 1, var_218_15)

				if arg_215_1.var_.characterEffect1132 then
					arg_215_1.var_.characterEffect1132.alpha = var_218_16
				end
			end

			if arg_215_1.time_ >= var_218_12 + var_218_14 and arg_215_1.time_ < var_218_12 + var_218_14 + arg_218_0 and arg_215_1.var_.characterEffect1132 then
				arg_215_1.var_.characterEffect1132.alpha = 1
			end

			local var_218_17 = arg_215_1.actors_["10035"]
			local var_218_18 = 0

			if var_218_18 < arg_215_1.time_ and arg_215_1.time_ <= var_218_18 + arg_218_0 then
				local var_218_19 = var_218_17:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_19 then
					arg_215_1.var_.alphaOldValue10035 = var_218_19.alpha
					arg_215_1.var_.characterEffect10035 = var_218_19
				end

				arg_215_1.var_.alphaOldValue10035 = 1
			end

			local var_218_20 = 0.333333333333333

			if var_218_18 <= arg_215_1.time_ and arg_215_1.time_ < var_218_18 + var_218_20 then
				local var_218_21 = (arg_215_1.time_ - var_218_18) / var_218_20
				local var_218_22 = Mathf.Lerp(arg_215_1.var_.alphaOldValue10035, 0, var_218_21)

				if arg_215_1.var_.characterEffect10035 then
					arg_215_1.var_.characterEffect10035.alpha = var_218_22
				end
			end

			if arg_215_1.time_ >= var_218_18 + var_218_20 and arg_215_1.time_ < var_218_18 + var_218_20 + arg_218_0 and arg_215_1.var_.characterEffect10035 then
				arg_215_1.var_.characterEffect10035.alpha = 0
			end

			local var_218_23 = arg_215_1.actors_["10034"]
			local var_218_24 = 0

			if var_218_24 < arg_215_1.time_ and arg_215_1.time_ <= var_218_24 + arg_218_0 then
				local var_218_25 = var_218_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_25 then
					arg_215_1.var_.alphaOldValue10034 = var_218_25.alpha
					arg_215_1.var_.characterEffect10034 = var_218_25
				end

				arg_215_1.var_.alphaOldValue10034 = 1
			end

			local var_218_26 = 0.333333333333333

			if var_218_24 <= arg_215_1.time_ and arg_215_1.time_ < var_218_24 + var_218_26 then
				local var_218_27 = (arg_215_1.time_ - var_218_24) / var_218_26
				local var_218_28 = Mathf.Lerp(arg_215_1.var_.alphaOldValue10034, 0, var_218_27)

				if arg_215_1.var_.characterEffect10034 then
					arg_215_1.var_.characterEffect10034.alpha = var_218_28
				end
			end

			if arg_215_1.time_ >= var_218_24 + var_218_26 and arg_215_1.time_ < var_218_24 + var_218_26 + arg_218_0 and arg_215_1.var_.characterEffect10034 then
				arg_215_1.var_.characterEffect10034.alpha = 0
			end

			local var_218_29 = arg_215_1.actors_["1132"]
			local var_218_30 = 0

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 and not isNil(var_218_29) and arg_215_1.var_.actorSpriteComps1132 == nil then
				arg_215_1.var_.actorSpriteComps1132 = var_218_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_31 = 0.2

			if var_218_30 <= arg_215_1.time_ and arg_215_1.time_ < var_218_30 + var_218_31 and not isNil(var_218_29) then
				local var_218_32 = (arg_215_1.time_ - var_218_30) / var_218_31

				if arg_215_1.var_.actorSpriteComps1132 then
					for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_218_4 then
							if arg_215_1.isInRecall_ then
								local var_218_33 = Mathf.Lerp(iter_218_4.color.r, arg_215_1.hightColor1.r, var_218_32)
								local var_218_34 = Mathf.Lerp(iter_218_4.color.g, arg_215_1.hightColor1.g, var_218_32)
								local var_218_35 = Mathf.Lerp(iter_218_4.color.b, arg_215_1.hightColor1.b, var_218_32)

								iter_218_4.color = Color.New(var_218_33, var_218_34, var_218_35)
							else
								local var_218_36 = Mathf.Lerp(iter_218_4.color.r, 1, var_218_32)

								iter_218_4.color = Color.New(var_218_36, var_218_36, var_218_36)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_30 + var_218_31 and arg_215_1.time_ < var_218_30 + var_218_31 + arg_218_0 and not isNil(var_218_29) and arg_215_1.var_.actorSpriteComps1132 then
				for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_218_6 then
						if arg_215_1.isInRecall_ then
							iter_218_6.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1132 = nil
			end

			local var_218_37 = 0
			local var_218_38 = 0.65

			if var_218_37 < arg_215_1.time_ and arg_215_1.time_ <= var_218_37 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_39 = arg_215_1:FormatText(StoryNameCfg[61].name)

				arg_215_1.leftNameTxt_.text = var_218_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_40 = arg_215_1:GetWordFromCfg(117041051)
				local var_218_41 = arg_215_1:FormatText(var_218_40.content)

				arg_215_1.text_.text = var_218_41

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_42 = 26
				local var_218_43 = utf8.len(var_218_41)
				local var_218_44 = var_218_42 <= 0 and var_218_38 or var_218_38 * (var_218_43 / var_218_42)

				if var_218_44 > 0 and var_218_38 < var_218_44 then
					arg_215_1.talkMaxDuration = var_218_44

					if var_218_44 + var_218_37 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_44 + var_218_37
					end
				end

				arg_215_1.text_.text = var_218_41
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041051", "story_v_out_117041.awb") ~= 0 then
					local var_218_45 = manager.audio:GetVoiceLength("story_v_out_117041", "117041051", "story_v_out_117041.awb") / 1000

					if var_218_45 + var_218_37 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_45 + var_218_37
					end

					if var_218_40.prefab_name ~= "" and arg_215_1.actors_[var_218_40.prefab_name] ~= nil then
						local var_218_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_40.prefab_name].transform, "story_v_out_117041", "117041051", "story_v_out_117041.awb")

						arg_215_1:RecordAudio("117041051", var_218_46)
						arg_215_1:RecordAudio("117041051", var_218_46)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_117041", "117041051", "story_v_out_117041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_117041", "117041051", "story_v_out_117041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_47 = math.max(var_218_38, arg_215_1.talkMaxDuration)

			if var_218_37 <= arg_215_1.time_ and arg_215_1.time_ < var_218_37 + var_218_47 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_37) / var_218_47

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_37 + var_218_47 and arg_215_1.time_ < var_218_37 + var_218_47 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play117041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 117041052
		arg_219_1.duration_ = 2.2

		local var_219_0 = {
			zh = 2.2,
			ja = 1.9
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
				arg_219_0:Play117041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1132"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1132 == nil then
				arg_219_1.var_.actorSpriteComps1132 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps1132 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 0.5, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1132 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1132 = nil
			end

			local var_222_8 = 0
			local var_222_9 = 0.2

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_10 = arg_219_1:FormatText(StoryNameCfg[369].name)

				arg_219_1.leftNameTxt_.text = var_222_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_4")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_11 = arg_219_1:GetWordFromCfg(117041052)
				local var_222_12 = arg_219_1:FormatText(var_222_11.content)

				arg_219_1.text_.text = var_222_12

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 8
				local var_222_14 = utf8.len(var_222_12)
				local var_222_15 = var_222_13 <= 0 and var_222_9 or var_222_9 * (var_222_14 / var_222_13)

				if var_222_15 > 0 and var_222_9 < var_222_15 then
					arg_219_1.talkMaxDuration = var_222_15

					if var_222_15 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_15 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_12
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041052", "story_v_out_117041.awb") ~= 0 then
					local var_222_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041052", "story_v_out_117041.awb") / 1000

					if var_222_16 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_16 + var_222_8
					end

					if var_222_11.prefab_name ~= "" and arg_219_1.actors_[var_222_11.prefab_name] ~= nil then
						local var_222_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_11.prefab_name].transform, "story_v_out_117041", "117041052", "story_v_out_117041.awb")

						arg_219_1:RecordAudio("117041052", var_222_17)
						arg_219_1:RecordAudio("117041052", var_222_17)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_117041", "117041052", "story_v_out_117041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_117041", "117041052", "story_v_out_117041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_18 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_18 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_18

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_18 and arg_219_1.time_ < var_222_8 + var_222_18 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play117041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 117041053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play117041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1132"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				local var_226_2 = var_226_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_226_2 then
					arg_223_1.var_.alphaOldValue1132 = var_226_2.alpha
					arg_223_1.var_.characterEffect1132 = var_226_2
				end

				arg_223_1.var_.alphaOldValue1132 = 1
			end

			local var_226_3 = 0.333333333333333

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_3 then
				local var_226_4 = (arg_223_1.time_ - var_226_1) / var_226_3
				local var_226_5 = Mathf.Lerp(arg_223_1.var_.alphaOldValue1132, 0, var_226_4)

				if arg_223_1.var_.characterEffect1132 then
					arg_223_1.var_.characterEffect1132.alpha = var_226_5
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_3 and arg_223_1.time_ < var_226_1 + var_226_3 + arg_226_0 and arg_223_1.var_.characterEffect1132 then
				arg_223_1.var_.characterEffect1132.alpha = 0
			end

			local var_226_6 = 0
			local var_226_7 = 0.675

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(117041053)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 27
				local var_226_11 = utf8.len(var_226_9)
				local var_226_12 = var_226_10 <= 0 and var_226_7 or var_226_7 * (var_226_11 / var_226_10)

				if var_226_12 > 0 and var_226_7 < var_226_12 then
					arg_223_1.talkMaxDuration = var_226_12

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_13 and arg_223_1.time_ < var_226_6 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play117041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 117041054
		arg_227_1.duration_ = 13.6

		local var_227_0 = {
			zh = 12.1,
			ja = 13.6
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play117041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10034"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				local var_230_2 = var_230_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_2 then
					arg_227_1.var_.alphaOldValue10034 = var_230_2.alpha
					arg_227_1.var_.characterEffect10034 = var_230_2
				end

				arg_227_1.var_.alphaOldValue10034 = 0
			end

			local var_230_3 = 0.333333333333333

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_3 then
				local var_230_4 = (arg_227_1.time_ - var_230_1) / var_230_3
				local var_230_5 = Mathf.Lerp(arg_227_1.var_.alphaOldValue10034, 1, var_230_4)

				if arg_227_1.var_.characterEffect10034 then
					arg_227_1.var_.characterEffect10034.alpha = var_230_5
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_3 and arg_227_1.time_ < var_230_1 + var_230_3 + arg_230_0 and arg_227_1.var_.characterEffect10034 then
				arg_227_1.var_.characterEffect10034.alpha = 1
			end

			local var_230_6 = arg_227_1.actors_["10035"]
			local var_230_7 = 0

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				local var_230_8 = var_230_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_8 then
					arg_227_1.var_.alphaOldValue10035 = var_230_8.alpha
					arg_227_1.var_.characterEffect10035 = var_230_8
				end

				arg_227_1.var_.alphaOldValue10035 = 0
			end

			local var_230_9 = 0.333333333333333

			if var_230_7 <= arg_227_1.time_ and arg_227_1.time_ < var_230_7 + var_230_9 then
				local var_230_10 = (arg_227_1.time_ - var_230_7) / var_230_9
				local var_230_11 = Mathf.Lerp(arg_227_1.var_.alphaOldValue10035, 1, var_230_10)

				if arg_227_1.var_.characterEffect10035 then
					arg_227_1.var_.characterEffect10035.alpha = var_230_11
				end
			end

			if arg_227_1.time_ >= var_230_7 + var_230_9 and arg_227_1.time_ < var_230_7 + var_230_9 + arg_230_0 and arg_227_1.var_.characterEffect10035 then
				arg_227_1.var_.characterEffect10035.alpha = 1
			end

			local var_230_12 = arg_227_1.actors_["10035"].transform
			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1.var_.moveOldPos10035 = var_230_12.localPosition
				var_230_12.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10035", 4)

				local var_230_14 = var_230_12.childCount

				for iter_230_0 = 0, var_230_14 - 1 do
					local var_230_15 = var_230_12:GetChild(iter_230_0)

					if var_230_15.name == "split_1" or not string.find(var_230_15.name, "split") then
						var_230_15.gameObject:SetActive(true)
					else
						var_230_15.gameObject:SetActive(false)
					end
				end
			end

			local var_230_16 = 0.001

			if var_230_13 <= arg_227_1.time_ and arg_227_1.time_ < var_230_13 + var_230_16 then
				local var_230_17 = (arg_227_1.time_ - var_230_13) / var_230_16
				local var_230_18 = Vector3.New(390, -410, -235)

				var_230_12.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10035, var_230_18, var_230_17)
			end

			if arg_227_1.time_ >= var_230_13 + var_230_16 and arg_227_1.time_ < var_230_13 + var_230_16 + arg_230_0 then
				var_230_12.localPosition = Vector3.New(390, -410, -235)
			end

			local var_230_19 = arg_227_1.actors_["10034"]
			local var_230_20 = 0

			if var_230_20 < arg_227_1.time_ and arg_227_1.time_ <= var_230_20 + arg_230_0 and not isNil(var_230_19) and arg_227_1.var_.actorSpriteComps10034 == nil then
				arg_227_1.var_.actorSpriteComps10034 = var_230_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_21 = 0.2

			if var_230_20 <= arg_227_1.time_ and arg_227_1.time_ < var_230_20 + var_230_21 and not isNil(var_230_19) then
				local var_230_22 = (arg_227_1.time_ - var_230_20) / var_230_21

				if arg_227_1.var_.actorSpriteComps10034 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_23 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, var_230_22)
								local var_230_24 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, var_230_22)
								local var_230_25 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, var_230_22)

								iter_230_2.color = Color.New(var_230_23, var_230_24, var_230_25)
							else
								local var_230_26 = Mathf.Lerp(iter_230_2.color.r, 1, var_230_22)

								iter_230_2.color = Color.New(var_230_26, var_230_26, var_230_26)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_20 + var_230_21 and arg_227_1.time_ < var_230_20 + var_230_21 + arg_230_0 and not isNil(var_230_19) and arg_227_1.var_.actorSpriteComps10034 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10034 = nil
			end

			local var_230_27 = 0
			local var_230_28 = 1.125

			if var_230_27 < arg_227_1.time_ and arg_227_1.time_ <= var_230_27 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_29 = arg_227_1:FormatText(StoryNameCfg[367].name)

				arg_227_1.leftNameTxt_.text = var_230_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_30 = arg_227_1:GetWordFromCfg(117041054)
				local var_230_31 = arg_227_1:FormatText(var_230_30.content)

				arg_227_1.text_.text = var_230_31

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_32 = 45
				local var_230_33 = utf8.len(var_230_31)
				local var_230_34 = var_230_32 <= 0 and var_230_28 or var_230_28 * (var_230_33 / var_230_32)

				if var_230_34 > 0 and var_230_28 < var_230_34 then
					arg_227_1.talkMaxDuration = var_230_34

					if var_230_34 + var_230_27 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_34 + var_230_27
					end
				end

				arg_227_1.text_.text = var_230_31
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041054", "story_v_out_117041.awb") ~= 0 then
					local var_230_35 = manager.audio:GetVoiceLength("story_v_out_117041", "117041054", "story_v_out_117041.awb") / 1000

					if var_230_35 + var_230_27 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_35 + var_230_27
					end

					if var_230_30.prefab_name ~= "" and arg_227_1.actors_[var_230_30.prefab_name] ~= nil then
						local var_230_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_30.prefab_name].transform, "story_v_out_117041", "117041054", "story_v_out_117041.awb")

						arg_227_1:RecordAudio("117041054", var_230_36)
						arg_227_1:RecordAudio("117041054", var_230_36)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_117041", "117041054", "story_v_out_117041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_117041", "117041054", "story_v_out_117041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_37 = math.max(var_230_28, arg_227_1.talkMaxDuration)

			if var_230_27 <= arg_227_1.time_ and arg_227_1.time_ < var_230_27 + var_230_37 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_27) / var_230_37

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_27 + var_230_37 and arg_227_1.time_ < var_230_27 + var_230_37 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play117041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 117041055
		arg_231_1.duration_ = 6.97

		local var_231_0 = {
			zh = 6.766,
			ja = 6.966
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play117041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10035"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10035 == nil then
				arg_231_1.var_.actorSpriteComps10035 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10035 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 1, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10035 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10035 = nil
			end

			local var_234_8 = arg_231_1.actors_["10034"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps10034 == nil then
				arg_231_1.var_.actorSpriteComps10034 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps10034 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								local var_234_12 = Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, var_234_11)
								local var_234_13 = Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, var_234_11)
								local var_234_14 = Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, var_234_11)

								iter_234_5.color = Color.New(var_234_12, var_234_13, var_234_14)
							else
								local var_234_15 = Mathf.Lerp(iter_234_5.color.r, 0.5, var_234_11)

								iter_234_5.color = Color.New(var_234_15, var_234_15, var_234_15)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps10034 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10034 = nil
			end

			local var_234_16 = 0
			local var_234_17 = 0.775

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_18 = arg_231_1:FormatText(StoryNameCfg[369].name)

				arg_231_1.leftNameTxt_.text = var_234_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_19 = arg_231_1:GetWordFromCfg(117041055)
				local var_234_20 = arg_231_1:FormatText(var_234_19.content)

				arg_231_1.text_.text = var_234_20

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_21 = 31
				local var_234_22 = utf8.len(var_234_20)
				local var_234_23 = var_234_21 <= 0 and var_234_17 or var_234_17 * (var_234_22 / var_234_21)

				if var_234_23 > 0 and var_234_17 < var_234_23 then
					arg_231_1.talkMaxDuration = var_234_23

					if var_234_23 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_16
					end
				end

				arg_231_1.text_.text = var_234_20
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041055", "story_v_out_117041.awb") ~= 0 then
					local var_234_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041055", "story_v_out_117041.awb") / 1000

					if var_234_24 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_24 + var_234_16
					end

					if var_234_19.prefab_name ~= "" and arg_231_1.actors_[var_234_19.prefab_name] ~= nil then
						local var_234_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_19.prefab_name].transform, "story_v_out_117041", "117041055", "story_v_out_117041.awb")

						arg_231_1:RecordAudio("117041055", var_234_25)
						arg_231_1:RecordAudio("117041055", var_234_25)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_117041", "117041055", "story_v_out_117041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_117041", "117041055", "story_v_out_117041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_26 = math.max(var_234_17, arg_231_1.talkMaxDuration)

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_26 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_16) / var_234_26

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_16 + var_234_26 and arg_231_1.time_ < var_234_16 + var_234_26 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play117041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 117041056
		arg_235_1.duration_ = 7.17

		local var_235_0 = {
			zh = 7.166,
			ja = 6.266
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
				arg_235_0:Play117041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10035"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10035 == nil then
				arg_235_1.var_.actorSpriteComps10035 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10035 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10035 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10035 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 0.95

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_10 = arg_235_1:FormatText(StoryNameCfg[61].name)

				arg_235_1.leftNameTxt_.text = var_238_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_6")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_11 = arg_235_1:GetWordFromCfg(117041056)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 38
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_9 or var_238_9 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_9 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041056", "story_v_out_117041.awb") ~= 0 then
					local var_238_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041056", "story_v_out_117041.awb") / 1000

					if var_238_16 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_8
					end

					if var_238_11.prefab_name ~= "" and arg_235_1.actors_[var_238_11.prefab_name] ~= nil then
						local var_238_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_11.prefab_name].transform, "story_v_out_117041", "117041056", "story_v_out_117041.awb")

						arg_235_1:RecordAudio("117041056", var_238_17)
						arg_235_1:RecordAudio("117041056", var_238_17)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_117041", "117041056", "story_v_out_117041.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_117041", "117041056", "story_v_out_117041.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_18 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_18 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_18

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_18 and arg_235_1.time_ < var_238_8 + var_238_18 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play117041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 117041057
		arg_239_1.duration_ = 3.4

		local var_239_0 = {
			zh = 3.066,
			ja = 3.4
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
				arg_239_0:Play117041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10035"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos10035 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10035", 4)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "split_4" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(390, -410, -235)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10035, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_242_7 = arg_239_1.actors_["10035"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10035 == nil then
				arg_239_1.var_.actorSpriteComps10035 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 0.2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps10035 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10035 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10035 = nil
			end

			local var_242_15 = 0
			local var_242_16 = 0.4

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[369].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(117041057)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 16
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041057", "story_v_out_117041.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_117041", "117041057", "story_v_out_117041.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_117041", "117041057", "story_v_out_117041.awb")

						arg_239_1:RecordAudio("117041057", var_242_24)
						arg_239_1:RecordAudio("117041057", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_117041", "117041057", "story_v_out_117041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_117041", "117041057", "story_v_out_117041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play117041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 117041058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play117041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10035"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10035 == nil then
				arg_243_1.var_.actorSpriteComps10035 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10035 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10035 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10035 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.775

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(117041058)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_12 = 31
				local var_246_13 = utf8.len(var_246_11)
				local var_246_14 = var_246_12 <= 0 and var_246_9 or var_246_9 * (var_246_13 / var_246_12)

				if var_246_14 > 0 and var_246_9 < var_246_14 then
					arg_243_1.talkMaxDuration = var_246_14

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_15 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_15 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_15

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_15 and arg_243_1.time_ < var_246_8 + var_246_15 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play117041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 117041059
		arg_247_1.duration_ = 9.8

		local var_247_0 = {
			zh = 9.8,
			ja = 7.4
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
				arg_247_0:Play117041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10034"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10034 == nil then
				arg_247_1.var_.actorSpriteComps10034 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10034 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 1, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10034 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10034 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.85

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_10 = arg_247_1:FormatText(StoryNameCfg[367].name)

				arg_247_1.leftNameTxt_.text = var_250_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_11 = arg_247_1:GetWordFromCfg(117041059)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 34
				local var_250_14 = utf8.len(var_250_12)
				local var_250_15 = var_250_13 <= 0 and var_250_9 or var_250_9 * (var_250_14 / var_250_13)

				if var_250_15 > 0 and var_250_9 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_12
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041059", "story_v_out_117041.awb") ~= 0 then
					local var_250_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041059", "story_v_out_117041.awb") / 1000

					if var_250_16 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_16 + var_250_8
					end

					if var_250_11.prefab_name ~= "" and arg_247_1.actors_[var_250_11.prefab_name] ~= nil then
						local var_250_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_11.prefab_name].transform, "story_v_out_117041", "117041059", "story_v_out_117041.awb")

						arg_247_1:RecordAudio("117041059", var_250_17)
						arg_247_1:RecordAudio("117041059", var_250_17)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_117041", "117041059", "story_v_out_117041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_117041", "117041059", "story_v_out_117041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_18 and arg_247_1.time_ < var_250_8 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play117041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 117041060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play117041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10035"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				local var_254_2 = var_254_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_2 then
					arg_251_1.var_.alphaOldValue10035 = var_254_2.alpha
					arg_251_1.var_.characterEffect10035 = var_254_2
				end

				arg_251_1.var_.alphaOldValue10035 = 1
			end

			local var_254_3 = 0.333333333333333

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Mathf.Lerp(arg_251_1.var_.alphaOldValue10035, 0, var_254_4)

				if arg_251_1.var_.characterEffect10035 then
					arg_251_1.var_.characterEffect10035.alpha = var_254_5
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 and arg_251_1.var_.characterEffect10035 then
				arg_251_1.var_.characterEffect10035.alpha = 0
			end

			local var_254_6 = arg_251_1.actors_["10034"]
			local var_254_7 = 0

			if var_254_7 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				local var_254_8 = var_254_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_8 then
					arg_251_1.var_.alphaOldValue10034 = var_254_8.alpha
					arg_251_1.var_.characterEffect10034 = var_254_8
				end

				arg_251_1.var_.alphaOldValue10034 = 1
			end

			local var_254_9 = 0.333333333333333

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_9 then
				local var_254_10 = (arg_251_1.time_ - var_254_7) / var_254_9
				local var_254_11 = Mathf.Lerp(arg_251_1.var_.alphaOldValue10034, 0, var_254_10)

				if arg_251_1.var_.characterEffect10034 then
					arg_251_1.var_.characterEffect10034.alpha = var_254_11
				end
			end

			if arg_251_1.time_ >= var_254_7 + var_254_9 and arg_251_1.time_ < var_254_7 + var_254_9 + arg_254_0 and arg_251_1.var_.characterEffect10034 then
				arg_251_1.var_.characterEffect10034.alpha = 0
			end

			local var_254_12 = 0
			local var_254_13 = 0.975

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_14 = arg_251_1:GetWordFromCfg(117041060)
				local var_254_15 = arg_251_1:FormatText(var_254_14.content)

				arg_251_1.text_.text = var_254_15

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_16 = 39
				local var_254_17 = utf8.len(var_254_15)
				local var_254_18 = var_254_16 <= 0 and var_254_13 or var_254_13 * (var_254_17 / var_254_16)

				if var_254_18 > 0 and var_254_13 < var_254_18 then
					arg_251_1.talkMaxDuration = var_254_18

					if var_254_18 + var_254_12 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_12
					end
				end

				arg_251_1.text_.text = var_254_15
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_19 = math.max(var_254_13, arg_251_1.talkMaxDuration)

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_19 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_12) / var_254_19

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_12 + var_254_19 and arg_251_1.time_ < var_254_12 + var_254_19 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play117041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 117041061
		arg_255_1.duration_ = 6.7

		local var_255_0 = {
			zh = 3.966,
			ja = 6.7
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
				arg_255_0:Play117041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1132"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				local var_258_2 = var_258_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_258_2 then
					arg_255_1.var_.alphaOldValue1132 = var_258_2.alpha
					arg_255_1.var_.characterEffect1132 = var_258_2
				end

				arg_255_1.var_.alphaOldValue1132 = 0
			end

			local var_258_3 = 0.333333333333333

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_3 then
				local var_258_4 = (arg_255_1.time_ - var_258_1) / var_258_3
				local var_258_5 = Mathf.Lerp(arg_255_1.var_.alphaOldValue1132, 1, var_258_4)

				if arg_255_1.var_.characterEffect1132 then
					arg_255_1.var_.characterEffect1132.alpha = var_258_5
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_3 and arg_255_1.time_ < var_258_1 + var_258_3 + arg_258_0 and arg_255_1.var_.characterEffect1132 then
				arg_255_1.var_.characterEffect1132.alpha = 1
			end

			local var_258_6 = arg_255_1.actors_["1132"]
			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.actorSpriteComps1132 == nil then
				arg_255_1.var_.actorSpriteComps1132 = var_258_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_8 = 0.2

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 and not isNil(var_258_6) then
				local var_258_9 = (arg_255_1.time_ - var_258_7) / var_258_8

				if arg_255_1.var_.actorSpriteComps1132 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_10 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_9)
								local var_258_11 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_9)
								local var_258_12 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_9)

								iter_258_1.color = Color.New(var_258_10, var_258_11, var_258_12)
							else
								local var_258_13 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_9)

								iter_258_1.color = Color.New(var_258_13, var_258_13, var_258_13)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.actorSpriteComps1132 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1132 = nil
			end

			local var_258_14 = 0
			local var_258_15 = 0.4

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_16 = arg_255_1:FormatText(StoryNameCfg[61].name)

				arg_255_1.leftNameTxt_.text = var_258_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_17 = arg_255_1:GetWordFromCfg(117041061)
				local var_258_18 = arg_255_1:FormatText(var_258_17.content)

				arg_255_1.text_.text = var_258_18

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_19 = 16
				local var_258_20 = utf8.len(var_258_18)
				local var_258_21 = var_258_19 <= 0 and var_258_15 or var_258_15 * (var_258_20 / var_258_19)

				if var_258_21 > 0 and var_258_15 < var_258_21 then
					arg_255_1.talkMaxDuration = var_258_21

					if var_258_21 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_21 + var_258_14
					end
				end

				arg_255_1.text_.text = var_258_18
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041061", "story_v_out_117041.awb") ~= 0 then
					local var_258_22 = manager.audio:GetVoiceLength("story_v_out_117041", "117041061", "story_v_out_117041.awb") / 1000

					if var_258_22 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_14
					end

					if var_258_17.prefab_name ~= "" and arg_255_1.actors_[var_258_17.prefab_name] ~= nil then
						local var_258_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_17.prefab_name].transform, "story_v_out_117041", "117041061", "story_v_out_117041.awb")

						arg_255_1:RecordAudio("117041061", var_258_23)
						arg_255_1:RecordAudio("117041061", var_258_23)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_117041", "117041061", "story_v_out_117041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_117041", "117041061", "story_v_out_117041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_24 = math.max(var_258_15, arg_255_1.talkMaxDuration)

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_24 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_14) / var_258_24

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_14 + var_258_24 and arg_255_1.time_ < var_258_14 + var_258_24 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play117041062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 117041062
		arg_259_1.duration_ = 5.97

		local var_259_0 = {
			zh = 5.2,
			ja = 5.966
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
				arg_259_0:Play117041063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1132"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1132 = var_262_0.localPosition
				var_262_0.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1132", 2)

				local var_262_2 = var_262_0.childCount

				for iter_262_0 = 0, var_262_2 - 1 do
					local var_262_3 = var_262_0:GetChild(iter_262_0)

					if var_262_3.name == "split_2" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_4 then
				local var_262_5 = (arg_259_1.time_ - var_262_1) / var_262_4
				local var_262_6 = Vector3.New(-390, -413, -185)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1132, var_262_6, var_262_5)
			end

			if arg_259_1.time_ >= var_262_1 + var_262_4 and arg_259_1.time_ < var_262_1 + var_262_4 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_262_7 = arg_259_1.actors_["10035"].transform
			local var_262_8 = 0

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.var_.moveOldPos10035 = var_262_7.localPosition
				var_262_7.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10035", 4)

				local var_262_9 = var_262_7.childCount

				for iter_262_1 = 0, var_262_9 - 1 do
					local var_262_10 = var_262_7:GetChild(iter_262_1)

					if var_262_10.name == "split_2" or not string.find(var_262_10.name, "split") then
						var_262_10.gameObject:SetActive(true)
					else
						var_262_10.gameObject:SetActive(false)
					end
				end
			end

			local var_262_11 = 0.001

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_11 then
				local var_262_12 = (arg_259_1.time_ - var_262_8) / var_262_11
				local var_262_13 = Vector3.New(390, -410, -235)

				var_262_7.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10035, var_262_13, var_262_12)
			end

			if arg_259_1.time_ >= var_262_8 + var_262_11 and arg_259_1.time_ < var_262_8 + var_262_11 + arg_262_0 then
				var_262_7.localPosition = Vector3.New(390, -410, -235)
			end

			local var_262_14 = arg_259_1.actors_["1132"]
			local var_262_15 = 0

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 and not isNil(var_262_14) and arg_259_1.var_.actorSpriteComps1132 == nil then
				arg_259_1.var_.actorSpriteComps1132 = var_262_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_16 = 0.2

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_16 and not isNil(var_262_14) then
				local var_262_17 = (arg_259_1.time_ - var_262_15) / var_262_16

				if arg_259_1.var_.actorSpriteComps1132 then
					for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_262_3 then
							if arg_259_1.isInRecall_ then
								local var_262_18 = Mathf.Lerp(iter_262_3.color.r, arg_259_1.hightColor2.r, var_262_17)
								local var_262_19 = Mathf.Lerp(iter_262_3.color.g, arg_259_1.hightColor2.g, var_262_17)
								local var_262_20 = Mathf.Lerp(iter_262_3.color.b, arg_259_1.hightColor2.b, var_262_17)

								iter_262_3.color = Color.New(var_262_18, var_262_19, var_262_20)
							else
								local var_262_21 = Mathf.Lerp(iter_262_3.color.r, 0.5, var_262_17)

								iter_262_3.color = Color.New(var_262_21, var_262_21, var_262_21)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_15 + var_262_16 and arg_259_1.time_ < var_262_15 + var_262_16 + arg_262_0 and not isNil(var_262_14) and arg_259_1.var_.actorSpriteComps1132 then
				for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_262_5 then
						if arg_259_1.isInRecall_ then
							iter_262_5.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1132 = nil
			end

			local var_262_22 = arg_259_1.actors_["10035"]
			local var_262_23 = 0

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 and not isNil(var_262_22) and arg_259_1.var_.actorSpriteComps10035 == nil then
				arg_259_1.var_.actorSpriteComps10035 = var_262_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_24 = 0.2

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_24 and not isNil(var_262_22) then
				local var_262_25 = (arg_259_1.time_ - var_262_23) / var_262_24

				if arg_259_1.var_.actorSpriteComps10035 then
					for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_262_7 then
							if arg_259_1.isInRecall_ then
								local var_262_26 = Mathf.Lerp(iter_262_7.color.r, arg_259_1.hightColor1.r, var_262_25)
								local var_262_27 = Mathf.Lerp(iter_262_7.color.g, arg_259_1.hightColor1.g, var_262_25)
								local var_262_28 = Mathf.Lerp(iter_262_7.color.b, arg_259_1.hightColor1.b, var_262_25)

								iter_262_7.color = Color.New(var_262_26, var_262_27, var_262_28)
							else
								local var_262_29 = Mathf.Lerp(iter_262_7.color.r, 1, var_262_25)

								iter_262_7.color = Color.New(var_262_29, var_262_29, var_262_29)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_23 + var_262_24 and arg_259_1.time_ < var_262_23 + var_262_24 + arg_262_0 and not isNil(var_262_22) and arg_259_1.var_.actorSpriteComps10035 then
				for iter_262_8, iter_262_9 in pairs(arg_259_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_262_9 then
						if arg_259_1.isInRecall_ then
							iter_262_9.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10035 = nil
			end

			local var_262_30 = arg_259_1.actors_["10035"]
			local var_262_31 = 0

			if var_262_31 < arg_259_1.time_ and arg_259_1.time_ <= var_262_31 + arg_262_0 then
				local var_262_32 = var_262_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_262_32 then
					arg_259_1.var_.alphaOldValue10035 = var_262_32.alpha
					arg_259_1.var_.characterEffect10035 = var_262_32
				end

				arg_259_1.var_.alphaOldValue10035 = 0
			end

			local var_262_33 = 0.333333333333333

			if var_262_31 <= arg_259_1.time_ and arg_259_1.time_ < var_262_31 + var_262_33 then
				local var_262_34 = (arg_259_1.time_ - var_262_31) / var_262_33
				local var_262_35 = Mathf.Lerp(arg_259_1.var_.alphaOldValue10035, 1, var_262_34)

				if arg_259_1.var_.characterEffect10035 then
					arg_259_1.var_.characterEffect10035.alpha = var_262_35
				end
			end

			if arg_259_1.time_ >= var_262_31 + var_262_33 and arg_259_1.time_ < var_262_31 + var_262_33 + arg_262_0 and arg_259_1.var_.characterEffect10035 then
				arg_259_1.var_.characterEffect10035.alpha = 1
			end

			local var_262_36 = 0
			local var_262_37 = 0.625

			if var_262_36 < arg_259_1.time_ and arg_259_1.time_ <= var_262_36 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_38 = arg_259_1:FormatText(StoryNameCfg[369].name)

				arg_259_1.leftNameTxt_.text = var_262_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_39 = arg_259_1:GetWordFromCfg(117041062)
				local var_262_40 = arg_259_1:FormatText(var_262_39.content)

				arg_259_1.text_.text = var_262_40

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_41 = 25
				local var_262_42 = utf8.len(var_262_40)
				local var_262_43 = var_262_41 <= 0 and var_262_37 or var_262_37 * (var_262_42 / var_262_41)

				if var_262_43 > 0 and var_262_37 < var_262_43 then
					arg_259_1.talkMaxDuration = var_262_43

					if var_262_43 + var_262_36 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_43 + var_262_36
					end
				end

				arg_259_1.text_.text = var_262_40
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041062", "story_v_out_117041.awb") ~= 0 then
					local var_262_44 = manager.audio:GetVoiceLength("story_v_out_117041", "117041062", "story_v_out_117041.awb") / 1000

					if var_262_44 + var_262_36 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_44 + var_262_36
					end

					if var_262_39.prefab_name ~= "" and arg_259_1.actors_[var_262_39.prefab_name] ~= nil then
						local var_262_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_39.prefab_name].transform, "story_v_out_117041", "117041062", "story_v_out_117041.awb")

						arg_259_1:RecordAudio("117041062", var_262_45)
						arg_259_1:RecordAudio("117041062", var_262_45)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_117041", "117041062", "story_v_out_117041.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_117041", "117041062", "story_v_out_117041.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_46 = math.max(var_262_37, arg_259_1.talkMaxDuration)

			if var_262_36 <= arg_259_1.time_ and arg_259_1.time_ < var_262_36 + var_262_46 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_36) / var_262_46

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_36 + var_262_46 and arg_259_1.time_ < var_262_36 + var_262_46 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
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

		arg_259_1:InitPlayNodeList()
	end,
	Play117041063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 117041063
		arg_263_1.duration_ = 5.13

		local var_263_0 = {
			zh = 5.1,
			ja = 5.133
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
				arg_263_0:Play117041064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.6

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[369].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(117041063)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 24
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041063", "story_v_out_117041.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041063", "story_v_out_117041.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_117041", "117041063", "story_v_out_117041.awb")

						arg_263_1:RecordAudio("117041063", var_266_9)
						arg_263_1:RecordAudio("117041063", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_117041", "117041063", "story_v_out_117041.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_117041", "117041063", "story_v_out_117041.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_10 and arg_263_1.time_ < var_266_0 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play117041064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 117041064
		arg_267_1.duration_ = 4.07

		local var_267_0 = {
			zh = 3.8,
			ja = 4.066
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
				arg_267_0:Play117041065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1132"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1132 = var_270_0.localPosition
				var_270_0.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1132", 2)

				local var_270_2 = var_270_0.childCount

				for iter_270_0 = 0, var_270_2 - 1 do
					local var_270_3 = var_270_0:GetChild(iter_270_0)

					if var_270_3.name == "split_6" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_4 then
				local var_270_5 = (arg_267_1.time_ - var_270_1) / var_270_4
				local var_270_6 = Vector3.New(-390, -413, -185)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1132, var_270_6, var_270_5)
			end

			if arg_267_1.time_ >= var_270_1 + var_270_4 and arg_267_1.time_ < var_270_1 + var_270_4 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_270_7 = arg_267_1.actors_["1132"]
			local var_270_8 = 0

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1132 == nil then
				arg_267_1.var_.actorSpriteComps1132 = var_270_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_9 = 0.2

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_9 and not isNil(var_270_7) then
				local var_270_10 = (arg_267_1.time_ - var_270_8) / var_270_9

				if arg_267_1.var_.actorSpriteComps1132 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_267_1.time_ >= var_270_8 + var_270_9 and arg_267_1.time_ < var_270_8 + var_270_9 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1132 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_270_4 then
						if arg_267_1.isInRecall_ then
							iter_270_4.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1132 = nil
			end

			local var_270_15 = arg_267_1.actors_["10035"]
			local var_270_16 = 0

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 and not isNil(var_270_15) and arg_267_1.var_.actorSpriteComps10035 == nil then
				arg_267_1.var_.actorSpriteComps10035 = var_270_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_17 = 0.2

			if var_270_16 <= arg_267_1.time_ and arg_267_1.time_ < var_270_16 + var_270_17 and not isNil(var_270_15) then
				local var_270_18 = (arg_267_1.time_ - var_270_16) / var_270_17

				if arg_267_1.var_.actorSpriteComps10035 then
					for iter_270_5, iter_270_6 in pairs(arg_267_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_270_6 then
							if arg_267_1.isInRecall_ then
								local var_270_19 = Mathf.Lerp(iter_270_6.color.r, arg_267_1.hightColor2.r, var_270_18)
								local var_270_20 = Mathf.Lerp(iter_270_6.color.g, arg_267_1.hightColor2.g, var_270_18)
								local var_270_21 = Mathf.Lerp(iter_270_6.color.b, arg_267_1.hightColor2.b, var_270_18)

								iter_270_6.color = Color.New(var_270_19, var_270_20, var_270_21)
							else
								local var_270_22 = Mathf.Lerp(iter_270_6.color.r, 0.5, var_270_18)

								iter_270_6.color = Color.New(var_270_22, var_270_22, var_270_22)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_16 + var_270_17 and arg_267_1.time_ < var_270_16 + var_270_17 + arg_270_0 and not isNil(var_270_15) and arg_267_1.var_.actorSpriteComps10035 then
				for iter_270_7, iter_270_8 in pairs(arg_267_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_270_8 then
						if arg_267_1.isInRecall_ then
							iter_270_8.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10035 = nil
			end

			local var_270_23 = arg_267_1.actors_["10035"]
			local var_270_24 = 0

			if var_270_24 < arg_267_1.time_ and arg_267_1.time_ <= var_270_24 + arg_270_0 then
				local var_270_25 = var_270_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_270_25 then
					arg_267_1.var_.alphaOldValue10035 = var_270_25.alpha
					arg_267_1.var_.characterEffect10035 = var_270_25
				end

				arg_267_1.var_.alphaOldValue10035 = 0
			end

			local var_270_26 = 0.0166666666666667

			if var_270_24 <= arg_267_1.time_ and arg_267_1.time_ < var_270_24 + var_270_26 then
				local var_270_27 = (arg_267_1.time_ - var_270_24) / var_270_26
				local var_270_28 = Mathf.Lerp(arg_267_1.var_.alphaOldValue10035, 1, var_270_27)

				if arg_267_1.var_.characterEffect10035 then
					arg_267_1.var_.characterEffect10035.alpha = var_270_28
				end
			end

			if arg_267_1.time_ >= var_270_24 + var_270_26 and arg_267_1.time_ < var_270_24 + var_270_26 + arg_270_0 and arg_267_1.var_.characterEffect10035 then
				arg_267_1.var_.characterEffect10035.alpha = 1
			end

			local var_270_29 = 0
			local var_270_30 = 0.5

			if var_270_29 < arg_267_1.time_ and arg_267_1.time_ <= var_270_29 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_31 = arg_267_1:FormatText(StoryNameCfg[61].name)

				arg_267_1.leftNameTxt_.text = var_270_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_32 = arg_267_1:GetWordFromCfg(117041064)
				local var_270_33 = arg_267_1:FormatText(var_270_32.content)

				arg_267_1.text_.text = var_270_33

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_34 = 20
				local var_270_35 = utf8.len(var_270_33)
				local var_270_36 = var_270_34 <= 0 and var_270_30 or var_270_30 * (var_270_35 / var_270_34)

				if var_270_36 > 0 and var_270_30 < var_270_36 then
					arg_267_1.talkMaxDuration = var_270_36

					if var_270_36 + var_270_29 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_36 + var_270_29
					end
				end

				arg_267_1.text_.text = var_270_33
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041064", "story_v_out_117041.awb") ~= 0 then
					local var_270_37 = manager.audio:GetVoiceLength("story_v_out_117041", "117041064", "story_v_out_117041.awb") / 1000

					if var_270_37 + var_270_29 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_37 + var_270_29
					end

					if var_270_32.prefab_name ~= "" and arg_267_1.actors_[var_270_32.prefab_name] ~= nil then
						local var_270_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_32.prefab_name].transform, "story_v_out_117041", "117041064", "story_v_out_117041.awb")

						arg_267_1:RecordAudio("117041064", var_270_38)
						arg_267_1:RecordAudio("117041064", var_270_38)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_117041", "117041064", "story_v_out_117041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_117041", "117041064", "story_v_out_117041.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_39 = math.max(var_270_30, arg_267_1.talkMaxDuration)

			if var_270_29 <= arg_267_1.time_ and arg_267_1.time_ < var_270_29 + var_270_39 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_29) / var_270_39

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_29 + var_270_39 and arg_267_1.time_ < var_270_29 + var_270_39 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play117041065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 117041065
		arg_271_1.duration_ = 2.83

		local var_271_0 = {
			zh = 1.466,
			ja = 2.833
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
				arg_271_0:Play117041066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10035"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos10035 = var_274_0.localPosition
				var_274_0.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10035", 4)

				local var_274_2 = var_274_0.childCount

				for iter_274_0 = 0, var_274_2 - 1 do
					local var_274_3 = var_274_0:GetChild(iter_274_0)

					if var_274_3.name == "split_4" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_4 then
				local var_274_5 = (arg_271_1.time_ - var_274_1) / var_274_4
				local var_274_6 = Vector3.New(390, -410, -235)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10035, var_274_6, var_274_5)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_4 and arg_271_1.time_ < var_274_1 + var_274_4 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_274_7 = arg_271_1.actors_["1132"]
			local var_274_8 = 0

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1132 == nil then
				arg_271_1.var_.actorSpriteComps1132 = var_274_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_9 = 0.2

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 and not isNil(var_274_7) then
				local var_274_10 = (arg_271_1.time_ - var_274_8) / var_274_9

				if arg_271_1.var_.actorSpriteComps1132 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								local var_274_11 = Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor2.r, var_274_10)
								local var_274_12 = Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor2.g, var_274_10)
								local var_274_13 = Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor2.b, var_274_10)

								iter_274_2.color = Color.New(var_274_11, var_274_12, var_274_13)
							else
								local var_274_14 = Mathf.Lerp(iter_274_2.color.r, 0.5, var_274_10)

								iter_274_2.color = Color.New(var_274_14, var_274_14, var_274_14)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1132 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_274_4 then
						if arg_271_1.isInRecall_ then
							iter_274_4.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1132 = nil
			end

			local var_274_15 = arg_271_1.actors_["10035"]
			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 and not isNil(var_274_15) and arg_271_1.var_.actorSpriteComps10035 == nil then
				arg_271_1.var_.actorSpriteComps10035 = var_274_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_17 = 0.2

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_17 and not isNil(var_274_15) then
				local var_274_18 = (arg_271_1.time_ - var_274_16) / var_274_17

				if arg_271_1.var_.actorSpriteComps10035 then
					for iter_274_5, iter_274_6 in pairs(arg_271_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_274_6 then
							if arg_271_1.isInRecall_ then
								local var_274_19 = Mathf.Lerp(iter_274_6.color.r, arg_271_1.hightColor1.r, var_274_18)
								local var_274_20 = Mathf.Lerp(iter_274_6.color.g, arg_271_1.hightColor1.g, var_274_18)
								local var_274_21 = Mathf.Lerp(iter_274_6.color.b, arg_271_1.hightColor1.b, var_274_18)

								iter_274_6.color = Color.New(var_274_19, var_274_20, var_274_21)
							else
								local var_274_22 = Mathf.Lerp(iter_274_6.color.r, 1, var_274_18)

								iter_274_6.color = Color.New(var_274_22, var_274_22, var_274_22)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 and not isNil(var_274_15) and arg_271_1.var_.actorSpriteComps10035 then
				for iter_274_7, iter_274_8 in pairs(arg_271_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_274_8 then
						if arg_271_1.isInRecall_ then
							iter_274_8.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10035 = nil
			end

			local var_274_23 = 0
			local var_274_24 = 0.075

			if var_274_23 < arg_271_1.time_ and arg_271_1.time_ <= var_274_23 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_25 = arg_271_1:FormatText(StoryNameCfg[369].name)

				arg_271_1.leftNameTxt_.text = var_274_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_26 = arg_271_1:GetWordFromCfg(117041065)
				local var_274_27 = arg_271_1:FormatText(var_274_26.content)

				arg_271_1.text_.text = var_274_27

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_28 = 3
				local var_274_29 = utf8.len(var_274_27)
				local var_274_30 = var_274_28 <= 0 and var_274_24 or var_274_24 * (var_274_29 / var_274_28)

				if var_274_30 > 0 and var_274_24 < var_274_30 then
					arg_271_1.talkMaxDuration = var_274_30

					if var_274_30 + var_274_23 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_30 + var_274_23
					end
				end

				arg_271_1.text_.text = var_274_27
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041065", "story_v_out_117041.awb") ~= 0 then
					local var_274_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041065", "story_v_out_117041.awb") / 1000

					if var_274_31 + var_274_23 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_31 + var_274_23
					end

					if var_274_26.prefab_name ~= "" and arg_271_1.actors_[var_274_26.prefab_name] ~= nil then
						local var_274_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_26.prefab_name].transform, "story_v_out_117041", "117041065", "story_v_out_117041.awb")

						arg_271_1:RecordAudio("117041065", var_274_32)
						arg_271_1:RecordAudio("117041065", var_274_32)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_117041", "117041065", "story_v_out_117041.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_117041", "117041065", "story_v_out_117041.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_33 = math.max(var_274_24, arg_271_1.talkMaxDuration)

			if var_274_23 <= arg_271_1.time_ and arg_271_1.time_ < var_274_23 + var_274_33 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_23) / var_274_33

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_23 + var_274_33 and arg_271_1.time_ < var_274_23 + var_274_33 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play117041066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 117041066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play117041067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10035"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10035 == nil then
				arg_275_1.var_.actorSpriteComps10035 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10035 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10035 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10035 = nil
			end

			local var_278_8 = 0
			local var_278_9 = 0.975

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(117041066)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 39
				local var_278_13 = utf8.len(var_278_11)
				local var_278_14 = var_278_12 <= 0 and var_278_9 or var_278_9 * (var_278_13 / var_278_12)

				if var_278_14 > 0 and var_278_9 < var_278_14 then
					arg_275_1.talkMaxDuration = var_278_14

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_15 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_15 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_15

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_15 and arg_275_1.time_ < var_278_8 + var_278_15 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play117041067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 117041067
		arg_279_1.duration_ = 7.8

		local var_279_0 = {
			zh = 6.9,
			ja = 7.8
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
				arg_279_0:Play117041068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10035"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10035 == nil then
				arg_279_1.var_.actorSpriteComps10035 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10035 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10035 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10035 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.725

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_10 = arg_279_1:FormatText(StoryNameCfg[369].name)

				arg_279_1.leftNameTxt_.text = var_282_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_11 = arg_279_1:GetWordFromCfg(117041067)
				local var_282_12 = arg_279_1:FormatText(var_282_11.content)

				arg_279_1.text_.text = var_282_12

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 29
				local var_282_14 = utf8.len(var_282_12)
				local var_282_15 = var_282_13 <= 0 and var_282_9 or var_282_9 * (var_282_14 / var_282_13)

				if var_282_15 > 0 and var_282_9 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15

					if var_282_15 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_12
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041067", "story_v_out_117041.awb") ~= 0 then
					local var_282_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041067", "story_v_out_117041.awb") / 1000

					if var_282_16 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_16 + var_282_8
					end

					if var_282_11.prefab_name ~= "" and arg_279_1.actors_[var_282_11.prefab_name] ~= nil then
						local var_282_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_11.prefab_name].transform, "story_v_out_117041", "117041067", "story_v_out_117041.awb")

						arg_279_1:RecordAudio("117041067", var_282_17)
						arg_279_1:RecordAudio("117041067", var_282_17)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_117041", "117041067", "story_v_out_117041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_117041", "117041067", "story_v_out_117041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_18 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_18 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_18

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_18 and arg_279_1.time_ < var_282_8 + var_282_18 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play117041068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 117041068
		arg_283_1.duration_ = 6.3

		local var_283_0 = {
			zh = 6.3,
			ja = 1.6
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
				arg_283_0:Play117041069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.625

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[369].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(117041068)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041068", "story_v_out_117041.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041068", "story_v_out_117041.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_117041", "117041068", "story_v_out_117041.awb")

						arg_283_1:RecordAudio("117041068", var_286_9)
						arg_283_1:RecordAudio("117041068", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_117041", "117041068", "story_v_out_117041.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_117041", "117041068", "story_v_out_117041.awb")
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
	Play117041069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 117041069
		arg_287_1.duration_ = 6.23

		local var_287_0 = {
			zh = 4.5,
			ja = 6.233
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
				arg_287_0:Play117041070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1132"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1132 == nil then
				arg_287_1.var_.actorSpriteComps1132 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1132 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1132 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1132 = nil
			end

			local var_290_8 = arg_287_1.actors_["10035"]
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10035 == nil then
				arg_287_1.var_.actorSpriteComps10035 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_10 = 0.2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 and not isNil(var_290_8) then
				local var_290_11 = (arg_287_1.time_ - var_290_9) / var_290_10

				if arg_287_1.var_.actorSpriteComps10035 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								local var_290_12 = Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, var_290_11)
								local var_290_13 = Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, var_290_11)
								local var_290_14 = Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, var_290_11)

								iter_290_5.color = Color.New(var_290_12, var_290_13, var_290_14)
							else
								local var_290_15 = Mathf.Lerp(iter_290_5.color.r, 0.5, var_290_11)

								iter_290_5.color = Color.New(var_290_15, var_290_15, var_290_15)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10035 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_290_7 then
						if arg_287_1.isInRecall_ then
							iter_290_7.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10035 = nil
			end

			local var_290_16 = arg_287_1.actors_["10035"]
			local var_290_17 = 0

			if var_290_17 < arg_287_1.time_ and arg_287_1.time_ <= var_290_17 + arg_290_0 then
				local var_290_18 = var_290_16:GetComponentInChildren(typeof(CanvasGroup))

				if var_290_18 then
					arg_287_1.var_.alphaOldValue10035 = var_290_18.alpha
					arg_287_1.var_.characterEffect10035 = var_290_18
				end

				arg_287_1.var_.alphaOldValue10035 = 0
			end

			local var_290_19 = 0.0166666666666667

			if var_290_17 <= arg_287_1.time_ and arg_287_1.time_ < var_290_17 + var_290_19 then
				local var_290_20 = (arg_287_1.time_ - var_290_17) / var_290_19
				local var_290_21 = Mathf.Lerp(arg_287_1.var_.alphaOldValue10035, 1, var_290_20)

				if arg_287_1.var_.characterEffect10035 then
					arg_287_1.var_.characterEffect10035.alpha = var_290_21
				end
			end

			if arg_287_1.time_ >= var_290_17 + var_290_19 and arg_287_1.time_ < var_290_17 + var_290_19 + arg_290_0 and arg_287_1.var_.characterEffect10035 then
				arg_287_1.var_.characterEffect10035.alpha = 1
			end

			local var_290_22 = 0
			local var_290_23 = 0.575

			if var_290_22 < arg_287_1.time_ and arg_287_1.time_ <= var_290_22 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_24 = arg_287_1:FormatText(StoryNameCfg[61].name)

				arg_287_1.leftNameTxt_.text = var_290_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_25 = arg_287_1:GetWordFromCfg(117041069)
				local var_290_26 = arg_287_1:FormatText(var_290_25.content)

				arg_287_1.text_.text = var_290_26

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_27 = 23
				local var_290_28 = utf8.len(var_290_26)
				local var_290_29 = var_290_27 <= 0 and var_290_23 or var_290_23 * (var_290_28 / var_290_27)

				if var_290_29 > 0 and var_290_23 < var_290_29 then
					arg_287_1.talkMaxDuration = var_290_29

					if var_290_29 + var_290_22 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_29 + var_290_22
					end
				end

				arg_287_1.text_.text = var_290_26
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041069", "story_v_out_117041.awb") ~= 0 then
					local var_290_30 = manager.audio:GetVoiceLength("story_v_out_117041", "117041069", "story_v_out_117041.awb") / 1000

					if var_290_30 + var_290_22 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_30 + var_290_22
					end

					if var_290_25.prefab_name ~= "" and arg_287_1.actors_[var_290_25.prefab_name] ~= nil then
						local var_290_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_25.prefab_name].transform, "story_v_out_117041", "117041069", "story_v_out_117041.awb")

						arg_287_1:RecordAudio("117041069", var_290_31)
						arg_287_1:RecordAudio("117041069", var_290_31)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_117041", "117041069", "story_v_out_117041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_117041", "117041069", "story_v_out_117041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_32 = math.max(var_290_23, arg_287_1.talkMaxDuration)

			if var_290_22 <= arg_287_1.time_ and arg_287_1.time_ < var_290_22 + var_290_32 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_22) / var_290_32

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_22 + var_290_32 and arg_287_1.time_ < var_290_22 + var_290_32 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play117041070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 117041070
		arg_291_1.duration_ = 5.33

		local var_291_0 = {
			zh = 3.266,
			ja = 5.333
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
				arg_291_0:Play117041071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1132"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1132 == nil then
				arg_291_1.var_.actorSpriteComps1132 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1132 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1132 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1132 = nil
			end

			local var_294_8 = arg_291_1.actors_["10035"].transform
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.var_.moveOldPos10035 = var_294_8.localPosition
				var_294_8.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10035", 4)

				local var_294_10 = var_294_8.childCount

				for iter_294_4 = 0, var_294_10 - 1 do
					local var_294_11 = var_294_8:GetChild(iter_294_4)

					if var_294_11.name == "split_5" or not string.find(var_294_11.name, "split") then
						var_294_11.gameObject:SetActive(true)
					else
						var_294_11.gameObject:SetActive(false)
					end
				end
			end

			local var_294_12 = 0.001

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_9) / var_294_12
				local var_294_14 = Vector3.New(390, -410, -235)

				var_294_8.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10035, var_294_14, var_294_13)
			end

			if arg_291_1.time_ >= var_294_9 + var_294_12 and arg_291_1.time_ < var_294_9 + var_294_12 + arg_294_0 then
				var_294_8.localPosition = Vector3.New(390, -410, -235)
			end

			local var_294_15 = arg_291_1.actors_["10035"]
			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 and not isNil(var_294_15) and arg_291_1.var_.actorSpriteComps10035 == nil then
				arg_291_1.var_.actorSpriteComps10035 = var_294_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_17 = 0.2

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_17 and not isNil(var_294_15) then
				local var_294_18 = (arg_291_1.time_ - var_294_16) / var_294_17

				if arg_291_1.var_.actorSpriteComps10035 then
					for iter_294_5, iter_294_6 in pairs(arg_291_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_294_6 then
							if arg_291_1.isInRecall_ then
								local var_294_19 = Mathf.Lerp(iter_294_6.color.r, arg_291_1.hightColor1.r, var_294_18)
								local var_294_20 = Mathf.Lerp(iter_294_6.color.g, arg_291_1.hightColor1.g, var_294_18)
								local var_294_21 = Mathf.Lerp(iter_294_6.color.b, arg_291_1.hightColor1.b, var_294_18)

								iter_294_6.color = Color.New(var_294_19, var_294_20, var_294_21)
							else
								local var_294_22 = Mathf.Lerp(iter_294_6.color.r, 1, var_294_18)

								iter_294_6.color = Color.New(var_294_22, var_294_22, var_294_22)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 and not isNil(var_294_15) and arg_291_1.var_.actorSpriteComps10035 then
				for iter_294_7, iter_294_8 in pairs(arg_291_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_294_8 then
						if arg_291_1.isInRecall_ then
							iter_294_8.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10035 = nil
			end

			local var_294_23 = 0
			local var_294_24 = 0.35

			if var_294_23 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_25 = arg_291_1:FormatText(StoryNameCfg[369].name)

				arg_291_1.leftNameTxt_.text = var_294_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_26 = arg_291_1:GetWordFromCfg(117041070)
				local var_294_27 = arg_291_1:FormatText(var_294_26.content)

				arg_291_1.text_.text = var_294_27

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_28 = 14
				local var_294_29 = utf8.len(var_294_27)
				local var_294_30 = var_294_28 <= 0 and var_294_24 or var_294_24 * (var_294_29 / var_294_28)

				if var_294_30 > 0 and var_294_24 < var_294_30 then
					arg_291_1.talkMaxDuration = var_294_30

					if var_294_30 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_30 + var_294_23
					end
				end

				arg_291_1.text_.text = var_294_27
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041070", "story_v_out_117041.awb") ~= 0 then
					local var_294_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041070", "story_v_out_117041.awb") / 1000

					if var_294_31 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_31 + var_294_23
					end

					if var_294_26.prefab_name ~= "" and arg_291_1.actors_[var_294_26.prefab_name] ~= nil then
						local var_294_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_26.prefab_name].transform, "story_v_out_117041", "117041070", "story_v_out_117041.awb")

						arg_291_1:RecordAudio("117041070", var_294_32)
						arg_291_1:RecordAudio("117041070", var_294_32)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_117041", "117041070", "story_v_out_117041.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_117041", "117041070", "story_v_out_117041.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_33 = math.max(var_294_24, arg_291_1.talkMaxDuration)

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_33 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_23) / var_294_33

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_23 + var_294_33 and arg_291_1.time_ < var_294_23 + var_294_33 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play117041071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 117041071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play117041072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10035"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10035 = var_298_0.localPosition
				var_298_0.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10035", 4)

				local var_298_2 = var_298_0.childCount

				for iter_298_0 = 0, var_298_2 - 1 do
					local var_298_3 = var_298_0:GetChild(iter_298_0)

					if var_298_3.name == "split_4" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_4 then
				local var_298_5 = (arg_295_1.time_ - var_298_1) / var_298_4
				local var_298_6 = Vector3.New(390, -410, -235)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10035, var_298_6, var_298_5)
			end

			if arg_295_1.time_ >= var_298_1 + var_298_4 and arg_295_1.time_ < var_298_1 + var_298_4 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(390, -410, -235)
			end

			local var_298_7 = 0
			local var_298_8 = 0.75

			if var_298_7 < arg_295_1.time_ and arg_295_1.time_ <= var_298_7 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_9 = arg_295_1:GetWordFromCfg(117041071)
				local var_298_10 = arg_295_1:FormatText(var_298_9.content)

				arg_295_1.text_.text = var_298_10

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_11 = 30
				local var_298_12 = utf8.len(var_298_10)
				local var_298_13 = var_298_11 <= 0 and var_298_8 or var_298_8 * (var_298_12 / var_298_11)

				if var_298_13 > 0 and var_298_8 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_7 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_7
					end
				end

				arg_295_1.text_.text = var_298_10
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_14 = math.max(var_298_8, arg_295_1.talkMaxDuration)

			if var_298_7 <= arg_295_1.time_ and arg_295_1.time_ < var_298_7 + var_298_14 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_7) / var_298_14

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_7 + var_298_14 and arg_295_1.time_ < var_298_7 + var_298_14 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play117041072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 117041072
		arg_299_1.duration_ = 4.2

		local var_299_0 = {
			zh = 2.5,
			ja = 4.2
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
				arg_299_0:Play117041073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.325

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[367].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(117041072)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041072", "story_v_out_117041.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041072", "story_v_out_117041.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_117041", "117041072", "story_v_out_117041.awb")

						arg_299_1:RecordAudio("117041072", var_302_9)
						arg_299_1:RecordAudio("117041072", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_117041", "117041072", "story_v_out_117041.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_117041", "117041072", "story_v_out_117041.awb")
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
	Play117041073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 117041073
		arg_303_1.duration_ = 3.07

		local var_303_0 = {
			zh = 3.066,
			ja = 0.999999999999
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
				arg_303_0:Play117041074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1132"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1132 == nil then
				arg_303_1.var_.actorSpriteComps1132 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1132 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 1, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1132 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1132 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 0.05

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_10 = arg_303_1:FormatText(StoryNameCfg[61].name)

				arg_303_1.leftNameTxt_.text = var_306_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_11 = arg_303_1:GetWordFromCfg(117041073)
				local var_306_12 = arg_303_1:FormatText(var_306_11.content)

				arg_303_1.text_.text = var_306_12

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041073", "story_v_out_117041.awb") ~= 0 then
					local var_306_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041073", "story_v_out_117041.awb") / 1000

					if var_306_16 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_16 + var_306_8
					end

					if var_306_11.prefab_name ~= "" and arg_303_1.actors_[var_306_11.prefab_name] ~= nil then
						local var_306_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_11.prefab_name].transform, "story_v_out_117041", "117041073", "story_v_out_117041.awb")

						arg_303_1:RecordAudio("117041073", var_306_17)
						arg_303_1:RecordAudio("117041073", var_306_17)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_117041", "117041073", "story_v_out_117041.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_117041", "117041073", "story_v_out_117041.awb")
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
	Play117041074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 117041074
		arg_307_1.duration_ = 1.9

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play117041075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.25

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[61].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:GetWordFromCfg(117041074)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 10
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041074", "story_v_out_117041.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041074", "story_v_out_117041.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_117041", "117041074", "story_v_out_117041.awb")

						arg_307_1:RecordAudio("117041074", var_310_9)
						arg_307_1:RecordAudio("117041074", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_117041", "117041074", "story_v_out_117041.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_117041", "117041074", "story_v_out_117041.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play117041075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 117041075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play117041076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1132"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1132 == nil then
				arg_311_1.var_.actorSpriteComps1132 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1132 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 0.5, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1132 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1132 = nil
			end

			local var_314_8 = 0
			local var_314_9 = 0.625

			if var_314_8 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_10 = arg_311_1:GetWordFromCfg(117041075)
				local var_314_11 = arg_311_1:FormatText(var_314_10.content)

				arg_311_1.text_.text = var_314_11

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_12 = 25
				local var_314_13 = utf8.len(var_314_11)
				local var_314_14 = var_314_12 <= 0 and var_314_9 or var_314_9 * (var_314_13 / var_314_12)

				if var_314_14 > 0 and var_314_9 < var_314_14 then
					arg_311_1.talkMaxDuration = var_314_14

					if var_314_14 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_11
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_15 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_15 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_15

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_15 and arg_311_1.time_ < var_314_8 + var_314_15 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play117041076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 117041076
		arg_315_1.duration_ = 2.73

		local var_315_0 = {
			zh = 1.366,
			ja = 2.733
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
				arg_315_0:Play117041077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1132"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				local var_318_2 = var_318_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_318_2 then
					arg_315_1.var_.alphaOldValue1132 = var_318_2.alpha
					arg_315_1.var_.characterEffect1132 = var_318_2
				end

				arg_315_1.var_.alphaOldValue1132 = 1
			end

			local var_318_3 = 0.333333333333333

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3
				local var_318_5 = Mathf.Lerp(arg_315_1.var_.alphaOldValue1132, 0, var_318_4)

				if arg_315_1.var_.characterEffect1132 then
					arg_315_1.var_.characterEffect1132.alpha = var_318_5
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 and arg_315_1.var_.characterEffect1132 then
				arg_315_1.var_.characterEffect1132.alpha = 0
			end

			local var_318_6 = arg_315_1.actors_["10034"]
			local var_318_7 = 0

			if var_318_7 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 then
				local var_318_8 = var_318_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_318_8 then
					arg_315_1.var_.alphaOldValue10034 = var_318_8.alpha
					arg_315_1.var_.characterEffect10034 = var_318_8
				end

				arg_315_1.var_.alphaOldValue10034 = 0
			end

			local var_318_9 = 0.333333333333333

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_9 then
				local var_318_10 = (arg_315_1.time_ - var_318_7) / var_318_9
				local var_318_11 = Mathf.Lerp(arg_315_1.var_.alphaOldValue10034, 1, var_318_10)

				if arg_315_1.var_.characterEffect10034 then
					arg_315_1.var_.characterEffect10034.alpha = var_318_11
				end
			end

			if arg_315_1.time_ >= var_318_7 + var_318_9 and arg_315_1.time_ < var_318_7 + var_318_9 + arg_318_0 and arg_315_1.var_.characterEffect10034 then
				arg_315_1.var_.characterEffect10034.alpha = 1
			end

			local var_318_12 = arg_315_1.actors_["10034"].transform
			local var_318_13 = 0

			if var_318_13 < arg_315_1.time_ and arg_315_1.time_ <= var_318_13 + arg_318_0 then
				arg_315_1.var_.moveOldPos10034 = var_318_12.localPosition
				var_318_12.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10034", 2)

				local var_318_14 = var_318_12.childCount

				for iter_318_0 = 0, var_318_14 - 1 do
					local var_318_15 = var_318_12:GetChild(iter_318_0)

					if var_318_15.name == "split_2" or not string.find(var_318_15.name, "split") then
						var_318_15.gameObject:SetActive(true)
					else
						var_318_15.gameObject:SetActive(false)
					end
				end
			end

			local var_318_16 = 0.001

			if var_318_13 <= arg_315_1.time_ and arg_315_1.time_ < var_318_13 + var_318_16 then
				local var_318_17 = (arg_315_1.time_ - var_318_13) / var_318_16
				local var_318_18 = Vector3.New(-390, -415, -290)

				var_318_12.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10034, var_318_18, var_318_17)
			end

			if arg_315_1.time_ >= var_318_13 + var_318_16 and arg_315_1.time_ < var_318_13 + var_318_16 + arg_318_0 then
				var_318_12.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_318_19 = arg_315_1.actors_["10034"]
			local var_318_20 = 0

			if var_318_20 < arg_315_1.time_ and arg_315_1.time_ <= var_318_20 + arg_318_0 and not isNil(var_318_19) and arg_315_1.var_.actorSpriteComps10034 == nil then
				arg_315_1.var_.actorSpriteComps10034 = var_318_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_21 = 0.2

			if var_318_20 <= arg_315_1.time_ and arg_315_1.time_ < var_318_20 + var_318_21 and not isNil(var_318_19) then
				local var_318_22 = (arg_315_1.time_ - var_318_20) / var_318_21

				if arg_315_1.var_.actorSpriteComps10034 then
					for iter_318_1, iter_318_2 in pairs(arg_315_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_318_2 then
							if arg_315_1.isInRecall_ then
								local var_318_23 = Mathf.Lerp(iter_318_2.color.r, arg_315_1.hightColor1.r, var_318_22)
								local var_318_24 = Mathf.Lerp(iter_318_2.color.g, arg_315_1.hightColor1.g, var_318_22)
								local var_318_25 = Mathf.Lerp(iter_318_2.color.b, arg_315_1.hightColor1.b, var_318_22)

								iter_318_2.color = Color.New(var_318_23, var_318_24, var_318_25)
							else
								local var_318_26 = Mathf.Lerp(iter_318_2.color.r, 1, var_318_22)

								iter_318_2.color = Color.New(var_318_26, var_318_26, var_318_26)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_20 + var_318_21 and arg_315_1.time_ < var_318_20 + var_318_21 + arg_318_0 and not isNil(var_318_19) and arg_315_1.var_.actorSpriteComps10034 then
				for iter_318_3, iter_318_4 in pairs(arg_315_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_318_4 then
						if arg_315_1.isInRecall_ then
							iter_318_4.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10034 = nil
			end

			local var_318_27 = 0
			local var_318_28 = 0.1

			if var_318_27 < arg_315_1.time_ and arg_315_1.time_ <= var_318_27 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_29 = arg_315_1:FormatText(StoryNameCfg[367].name)

				arg_315_1.leftNameTxt_.text = var_318_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_30 = arg_315_1:GetWordFromCfg(117041076)
				local var_318_31 = arg_315_1:FormatText(var_318_30.content)

				arg_315_1.text_.text = var_318_31

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_32 = 4
				local var_318_33 = utf8.len(var_318_31)
				local var_318_34 = var_318_32 <= 0 and var_318_28 or var_318_28 * (var_318_33 / var_318_32)

				if var_318_34 > 0 and var_318_28 < var_318_34 then
					arg_315_1.talkMaxDuration = var_318_34

					if var_318_34 + var_318_27 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_34 + var_318_27
					end
				end

				arg_315_1.text_.text = var_318_31
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041076", "story_v_out_117041.awb") ~= 0 then
					local var_318_35 = manager.audio:GetVoiceLength("story_v_out_117041", "117041076", "story_v_out_117041.awb") / 1000

					if var_318_35 + var_318_27 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_35 + var_318_27
					end

					if var_318_30.prefab_name ~= "" and arg_315_1.actors_[var_318_30.prefab_name] ~= nil then
						local var_318_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_30.prefab_name].transform, "story_v_out_117041", "117041076", "story_v_out_117041.awb")

						arg_315_1:RecordAudio("117041076", var_318_36)
						arg_315_1:RecordAudio("117041076", var_318_36)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_117041", "117041076", "story_v_out_117041.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_117041", "117041076", "story_v_out_117041.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_37 = math.max(var_318_28, arg_315_1.talkMaxDuration)

			if var_318_27 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_37 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_27) / var_318_37

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_27 + var_318_37 and arg_315_1.time_ < var_318_27 + var_318_37 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play117041077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 117041077
		arg_319_1.duration_ = 4.97

		local var_319_0 = {
			zh = 2.066,
			ja = 4.966
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
				arg_319_0:Play117041078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10034"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10034 == nil then
				arg_319_1.var_.actorSpriteComps10034 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10034 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 0.5, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10034 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10034 = nil
			end

			local var_322_8 = arg_319_1.actors_["10035"]
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10035 == nil then
				arg_319_1.var_.actorSpriteComps10035 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_10 = 0.2

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_10 and not isNil(var_322_8) then
				local var_322_11 = (arg_319_1.time_ - var_322_9) / var_322_10

				if arg_319_1.var_.actorSpriteComps10035 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								local var_322_12 = Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor1.r, var_322_11)
								local var_322_13 = Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor1.g, var_322_11)
								local var_322_14 = Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor1.b, var_322_11)

								iter_322_5.color = Color.New(var_322_12, var_322_13, var_322_14)
							else
								local var_322_15 = Mathf.Lerp(iter_322_5.color.r, 1, var_322_11)

								iter_322_5.color = Color.New(var_322_15, var_322_15, var_322_15)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_10 and arg_319_1.time_ < var_322_9 + var_322_10 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps10035 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_322_7 then
						if arg_319_1.isInRecall_ then
							iter_322_7.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10035 = nil
			end

			local var_322_16 = 0
			local var_322_17 = 0.3

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_18 = arg_319_1:FormatText(StoryNameCfg[369].name)

				arg_319_1.leftNameTxt_.text = var_322_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_19 = arg_319_1:GetWordFromCfg(117041077)
				local var_322_20 = arg_319_1:FormatText(var_322_19.content)

				arg_319_1.text_.text = var_322_20

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_21 = 12
				local var_322_22 = utf8.len(var_322_20)
				local var_322_23 = var_322_21 <= 0 and var_322_17 or var_322_17 * (var_322_22 / var_322_21)

				if var_322_23 > 0 and var_322_17 < var_322_23 then
					arg_319_1.talkMaxDuration = var_322_23

					if var_322_23 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_16
					end
				end

				arg_319_1.text_.text = var_322_20
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041077", "story_v_out_117041.awb") ~= 0 then
					local var_322_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041077", "story_v_out_117041.awb") / 1000

					if var_322_24 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_16
					end

					if var_322_19.prefab_name ~= "" and arg_319_1.actors_[var_322_19.prefab_name] ~= nil then
						local var_322_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_19.prefab_name].transform, "story_v_out_117041", "117041077", "story_v_out_117041.awb")

						arg_319_1:RecordAudio("117041077", var_322_25)
						arg_319_1:RecordAudio("117041077", var_322_25)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_117041", "117041077", "story_v_out_117041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_117041", "117041077", "story_v_out_117041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_26 = math.max(var_322_17, arg_319_1.talkMaxDuration)

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_26 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_16) / var_322_26

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_16 + var_322_26 and arg_319_1.time_ < var_322_16 + var_322_26 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play117041078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 117041078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play117041079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10035"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				local var_326_2 = var_326_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_2 then
					arg_323_1.var_.alphaOldValue10035 = var_326_2.alpha
					arg_323_1.var_.characterEffect10035 = var_326_2
				end

				arg_323_1.var_.alphaOldValue10035 = 1
			end

			local var_326_3 = 0.333333333333333

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Mathf.Lerp(arg_323_1.var_.alphaOldValue10035, 0, var_326_4)

				if arg_323_1.var_.characterEffect10035 then
					arg_323_1.var_.characterEffect10035.alpha = var_326_5
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 and arg_323_1.var_.characterEffect10035 then
				arg_323_1.var_.characterEffect10035.alpha = 0
			end

			local var_326_6 = arg_323_1.actors_["10034"]
			local var_326_7 = 0

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				local var_326_8 = var_326_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_8 then
					arg_323_1.var_.alphaOldValue10034 = var_326_8.alpha
					arg_323_1.var_.characterEffect10034 = var_326_8
				end

				arg_323_1.var_.alphaOldValue10034 = 1
			end

			local var_326_9 = 0.333333333333333

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_9 then
				local var_326_10 = (arg_323_1.time_ - var_326_7) / var_326_9
				local var_326_11 = Mathf.Lerp(arg_323_1.var_.alphaOldValue10034, 0, var_326_10)

				if arg_323_1.var_.characterEffect10034 then
					arg_323_1.var_.characterEffect10034.alpha = var_326_11
				end
			end

			if arg_323_1.time_ >= var_326_7 + var_326_9 and arg_323_1.time_ < var_326_7 + var_326_9 + arg_326_0 and arg_323_1.var_.characterEffect10034 then
				arg_323_1.var_.characterEffect10034.alpha = 0
			end

			local var_326_12 = 0
			local var_326_13 = 0.575

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

				local var_326_14 = arg_323_1:GetWordFromCfg(117041078)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_16 = 23
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
	Play117041079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 117041079
		arg_327_1.duration_ = 9

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play117041080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_1 = 2

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_1 then
				local var_330_2 = (arg_327_1.time_ - var_330_0) / var_330_1
				local var_330_3 = Color.New(0, 0, 0)

				var_330_3.a = Mathf.Lerp(0, 1, var_330_2)
				arg_327_1.mask_.color = var_330_3
			end

			if arg_327_1.time_ >= var_330_0 + var_330_1 and arg_327_1.time_ < var_330_0 + var_330_1 + arg_330_0 then
				local var_330_4 = Color.New(0, 0, 0)

				var_330_4.a = 1
				arg_327_1.mask_.color = var_330_4
			end

			local var_330_5 = 2

			if var_330_5 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_6 = 2

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_6 then
				local var_330_7 = (arg_327_1.time_ - var_330_5) / var_330_6
				local var_330_8 = Color.New(0, 0, 0)

				var_330_8.a = Mathf.Lerp(1, 0, var_330_7)
				arg_327_1.mask_.color = var_330_8
			end

			if arg_327_1.time_ >= var_330_5 + var_330_6 and arg_327_1.time_ < var_330_5 + var_330_6 + arg_330_0 then
				local var_330_9 = Color.New(0, 0, 0)
				local var_330_10 = 0

				arg_327_1.mask_.enabled = false
				var_330_9.a = var_330_10
				arg_327_1.mask_.color = var_330_9
			end

			local var_330_11 = 4
			local var_330_12 = 1

			if var_330_11 < arg_327_1.time_ and arg_327_1.time_ <= var_330_11 + arg_330_0 then
				local var_330_13 = "play"
				local var_330_14 = "effect"

				arg_327_1:AudioAction(var_330_13, var_330_14, "se_story_17", "se_story_17_door_close", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_15 = 4
			local var_330_16 = 0.775

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_17 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_17:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_18 = arg_327_1:GetWordFromCfg(117041079)
				local var_330_19 = arg_327_1:FormatText(var_330_18.content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_20 = 31
				local var_330_21 = utf8.len(var_330_19)
				local var_330_22 = var_330_20 <= 0 and var_330_16 or var_330_16 * (var_330_21 / var_330_20)

				if var_330_22 > 0 and var_330_16 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22
					var_330_15 = var_330_15 + 0.3

					if var_330_22 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_23 = var_330_15 + 0.3
			local var_330_24 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_24 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_23) / var_330_24

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_23 + var_330_24 and arg_327_1.time_ < var_330_23 + var_330_24 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play117041080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 117041080
		arg_333_1.duration_ = 10.17

		local var_333_0 = {
			zh = 10.166,
			ja = 5.133
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
				arg_333_0:Play117041081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10034"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				local var_336_2 = var_336_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_336_2 then
					arg_333_1.var_.alphaOldValue10034 = var_336_2.alpha
					arg_333_1.var_.characterEffect10034 = var_336_2
				end

				arg_333_1.var_.alphaOldValue10034 = 0
			end

			local var_336_3 = 0.333333333333333

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_3 then
				local var_336_4 = (arg_333_1.time_ - var_336_1) / var_336_3
				local var_336_5 = Mathf.Lerp(arg_333_1.var_.alphaOldValue10034, 1, var_336_4)

				if arg_333_1.var_.characterEffect10034 then
					arg_333_1.var_.characterEffect10034.alpha = var_336_5
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_3 and arg_333_1.time_ < var_336_1 + var_336_3 + arg_336_0 and arg_333_1.var_.characterEffect10034 then
				arg_333_1.var_.characterEffect10034.alpha = 1
			end

			local var_336_6 = arg_333_1.actors_["1132"]
			local var_336_7 = 0

			if var_336_7 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				local var_336_8 = var_336_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_336_8 then
					arg_333_1.var_.alphaOldValue1132 = var_336_8.alpha
					arg_333_1.var_.characterEffect1132 = var_336_8
				end

				arg_333_1.var_.alphaOldValue1132 = 0
			end

			local var_336_9 = 0.333333333333333

			if var_336_7 <= arg_333_1.time_ and arg_333_1.time_ < var_336_7 + var_336_9 then
				local var_336_10 = (arg_333_1.time_ - var_336_7) / var_336_9
				local var_336_11 = Mathf.Lerp(arg_333_1.var_.alphaOldValue1132, 1, var_336_10)

				if arg_333_1.var_.characterEffect1132 then
					arg_333_1.var_.characterEffect1132.alpha = var_336_11
				end
			end

			if arg_333_1.time_ >= var_336_7 + var_336_9 and arg_333_1.time_ < var_336_7 + var_336_9 + arg_336_0 and arg_333_1.var_.characterEffect1132 then
				arg_333_1.var_.characterEffect1132.alpha = 1
			end

			local var_336_12 = arg_333_1.actors_["10034"].transform
			local var_336_13 = 0

			if var_336_13 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1.var_.moveOldPos10034 = var_336_12.localPosition
				var_336_12.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10034", 4)

				local var_336_14 = var_336_12.childCount

				for iter_336_0 = 0, var_336_14 - 1 do
					local var_336_15 = var_336_12:GetChild(iter_336_0)

					if var_336_15.name == "split_2" or not string.find(var_336_15.name, "split") then
						var_336_15.gameObject:SetActive(true)
					else
						var_336_15.gameObject:SetActive(false)
					end
				end
			end

			local var_336_16 = 0.001

			if var_336_13 <= arg_333_1.time_ and arg_333_1.time_ < var_336_13 + var_336_16 then
				local var_336_17 = (arg_333_1.time_ - var_336_13) / var_336_16
				local var_336_18 = Vector3.New(390, -415, -290)

				var_336_12.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10034, var_336_18, var_336_17)
			end

			if arg_333_1.time_ >= var_336_13 + var_336_16 and arg_333_1.time_ < var_336_13 + var_336_16 + arg_336_0 then
				var_336_12.localPosition = Vector3.New(390, -415, -290)
			end

			local var_336_19 = arg_333_1.actors_["1132"].transform
			local var_336_20 = 0

			if var_336_20 < arg_333_1.time_ and arg_333_1.time_ <= var_336_20 + arg_336_0 then
				arg_333_1.var_.moveOldPos1132 = var_336_19.localPosition
				var_336_19.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1132", 2)

				local var_336_21 = var_336_19.childCount

				for iter_336_1 = 0, var_336_21 - 1 do
					local var_336_22 = var_336_19:GetChild(iter_336_1)

					if var_336_22.name == "split_6" or not string.find(var_336_22.name, "split") then
						var_336_22.gameObject:SetActive(true)
					else
						var_336_22.gameObject:SetActive(false)
					end
				end
			end

			local var_336_23 = 0.001

			if var_336_20 <= arg_333_1.time_ and arg_333_1.time_ < var_336_20 + var_336_23 then
				local var_336_24 = (arg_333_1.time_ - var_336_20) / var_336_23
				local var_336_25 = Vector3.New(-390, -413, -185)

				var_336_19.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1132, var_336_25, var_336_24)
			end

			if arg_333_1.time_ >= var_336_20 + var_336_23 and arg_333_1.time_ < var_336_20 + var_336_23 + arg_336_0 then
				var_336_19.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_336_26 = arg_333_1.actors_["10034"]
			local var_336_27 = 0

			if var_336_27 < arg_333_1.time_ and arg_333_1.time_ <= var_336_27 + arg_336_0 and not isNil(var_336_26) and arg_333_1.var_.actorSpriteComps10034 == nil then
				arg_333_1.var_.actorSpriteComps10034 = var_336_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_28 = 0.2

			if var_336_27 <= arg_333_1.time_ and arg_333_1.time_ < var_336_27 + var_336_28 and not isNil(var_336_26) then
				local var_336_29 = (arg_333_1.time_ - var_336_27) / var_336_28

				if arg_333_1.var_.actorSpriteComps10034 then
					for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_336_3 then
							if arg_333_1.isInRecall_ then
								local var_336_30 = Mathf.Lerp(iter_336_3.color.r, arg_333_1.hightColor1.r, var_336_29)
								local var_336_31 = Mathf.Lerp(iter_336_3.color.g, arg_333_1.hightColor1.g, var_336_29)
								local var_336_32 = Mathf.Lerp(iter_336_3.color.b, arg_333_1.hightColor1.b, var_336_29)

								iter_336_3.color = Color.New(var_336_30, var_336_31, var_336_32)
							else
								local var_336_33 = Mathf.Lerp(iter_336_3.color.r, 1, var_336_29)

								iter_336_3.color = Color.New(var_336_33, var_336_33, var_336_33)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_27 + var_336_28 and arg_333_1.time_ < var_336_27 + var_336_28 + arg_336_0 and not isNil(var_336_26) and arg_333_1.var_.actorSpriteComps10034 then
				for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_336_5 then
						if arg_333_1.isInRecall_ then
							iter_336_5.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10034 = nil
			end

			local var_336_34 = 0
			local var_336_35 = 1.05

			if var_336_34 < arg_333_1.time_ and arg_333_1.time_ <= var_336_34 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_36 = arg_333_1:FormatText(StoryNameCfg[367].name)

				arg_333_1.leftNameTxt_.text = var_336_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_37 = arg_333_1:GetWordFromCfg(117041080)
				local var_336_38 = arg_333_1:FormatText(var_336_37.content)

				arg_333_1.text_.text = var_336_38

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_39 = 42
				local var_336_40 = utf8.len(var_336_38)
				local var_336_41 = var_336_39 <= 0 and var_336_35 or var_336_35 * (var_336_40 / var_336_39)

				if var_336_41 > 0 and var_336_35 < var_336_41 then
					arg_333_1.talkMaxDuration = var_336_41

					if var_336_41 + var_336_34 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_41 + var_336_34
					end
				end

				arg_333_1.text_.text = var_336_38
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041080", "story_v_out_117041.awb") ~= 0 then
					local var_336_42 = manager.audio:GetVoiceLength("story_v_out_117041", "117041080", "story_v_out_117041.awb") / 1000

					if var_336_42 + var_336_34 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_42 + var_336_34
					end

					if var_336_37.prefab_name ~= "" and arg_333_1.actors_[var_336_37.prefab_name] ~= nil then
						local var_336_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_37.prefab_name].transform, "story_v_out_117041", "117041080", "story_v_out_117041.awb")

						arg_333_1:RecordAudio("117041080", var_336_43)
						arg_333_1:RecordAudio("117041080", var_336_43)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_117041", "117041080", "story_v_out_117041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_117041", "117041080", "story_v_out_117041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_44 = math.max(var_336_35, arg_333_1.talkMaxDuration)

			if var_336_34 <= arg_333_1.time_ and arg_333_1.time_ < var_336_34 + var_336_44 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_34) / var_336_44

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_34 + var_336_44 and arg_333_1.time_ < var_336_34 + var_336_44 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play117041081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 117041081
		arg_337_1.duration_ = 5.37

		local var_337_0 = {
			zh = 5.366,
			ja = 4.633
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
				arg_337_0:Play117041082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10034"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10034 == nil then
				arg_337_1.var_.actorSpriteComps10034 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps10034 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_4 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, var_340_3)
								local var_340_5 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, var_340_3)
								local var_340_6 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, var_340_3)

								iter_340_1.color = Color.New(var_340_4, var_340_5, var_340_6)
							else
								local var_340_7 = Mathf.Lerp(iter_340_1.color.r, 0.5, var_340_3)

								iter_340_1.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10034 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10034 = nil
			end

			local var_340_8 = arg_337_1.actors_["1132"]
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1132 == nil then
				arg_337_1.var_.actorSpriteComps1132 = var_340_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_10 = 0.2

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_10 and not isNil(var_340_8) then
				local var_340_11 = (arg_337_1.time_ - var_340_9) / var_340_10

				if arg_337_1.var_.actorSpriteComps1132 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								local var_340_12 = Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor1.r, var_340_11)
								local var_340_13 = Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor1.g, var_340_11)
								local var_340_14 = Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor1.b, var_340_11)

								iter_340_5.color = Color.New(var_340_12, var_340_13, var_340_14)
							else
								local var_340_15 = Mathf.Lerp(iter_340_5.color.r, 1, var_340_11)

								iter_340_5.color = Color.New(var_340_15, var_340_15, var_340_15)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_9 + var_340_10 and arg_337_1.time_ < var_340_9 + var_340_10 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1132 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_340_7 then
						if arg_337_1.isInRecall_ then
							iter_340_7.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1132 = nil
			end

			local var_340_16 = 0
			local var_340_17 = 0.725

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_18 = arg_337_1:FormatText(StoryNameCfg[61].name)

				arg_337_1.leftNameTxt_.text = var_340_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_19 = arg_337_1:GetWordFromCfg(117041081)
				local var_340_20 = arg_337_1:FormatText(var_340_19.content)

				arg_337_1.text_.text = var_340_20

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_21 = 29
				local var_340_22 = utf8.len(var_340_20)
				local var_340_23 = var_340_21 <= 0 and var_340_17 or var_340_17 * (var_340_22 / var_340_21)

				if var_340_23 > 0 and var_340_17 < var_340_23 then
					arg_337_1.talkMaxDuration = var_340_23

					if var_340_23 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_16
					end
				end

				arg_337_1.text_.text = var_340_20
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041081", "story_v_out_117041.awb") ~= 0 then
					local var_340_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041081", "story_v_out_117041.awb") / 1000

					if var_340_24 + var_340_16 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_24 + var_340_16
					end

					if var_340_19.prefab_name ~= "" and arg_337_1.actors_[var_340_19.prefab_name] ~= nil then
						local var_340_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_19.prefab_name].transform, "story_v_out_117041", "117041081", "story_v_out_117041.awb")

						arg_337_1:RecordAudio("117041081", var_340_25)
						arg_337_1:RecordAudio("117041081", var_340_25)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_117041", "117041081", "story_v_out_117041.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_117041", "117041081", "story_v_out_117041.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_26 = math.max(var_340_17, arg_337_1.talkMaxDuration)

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_26 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_16) / var_340_26

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_16 + var_340_26 and arg_337_1.time_ < var_340_16 + var_340_26 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play117041082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 117041082
		arg_341_1.duration_ = 8.93

		local var_341_0 = {
			zh = 3.366,
			ja = 8.933
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
				arg_341_0:Play117041083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10034"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10034 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10034", 4)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "split_2" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(390, -415, -290)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10034, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_344_7 = arg_341_1.actors_["1132"]
			local var_344_8 = 0

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps1132 == nil then
				arg_341_1.var_.actorSpriteComps1132 = var_344_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_9 = 0.2

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_9 and not isNil(var_344_7) then
				local var_344_10 = (arg_341_1.time_ - var_344_8) / var_344_9

				if arg_341_1.var_.actorSpriteComps1132 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								local var_344_11 = Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor2.r, var_344_10)
								local var_344_12 = Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor2.g, var_344_10)
								local var_344_13 = Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor2.b, var_344_10)

								iter_344_2.color = Color.New(var_344_11, var_344_12, var_344_13)
							else
								local var_344_14 = Mathf.Lerp(iter_344_2.color.r, 0.5, var_344_10)

								iter_344_2.color = Color.New(var_344_14, var_344_14, var_344_14)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_8 + var_344_9 and arg_341_1.time_ < var_344_8 + var_344_9 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps1132 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_344_4 then
						if arg_341_1.isInRecall_ then
							iter_344_4.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1132 = nil
			end

			local var_344_15 = arg_341_1.actors_["10034"]
			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps10034 == nil then
				arg_341_1.var_.actorSpriteComps10034 = var_344_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_17 = 0.2

			if var_344_16 <= arg_341_1.time_ and arg_341_1.time_ < var_344_16 + var_344_17 and not isNil(var_344_15) then
				local var_344_18 = (arg_341_1.time_ - var_344_16) / var_344_17

				if arg_341_1.var_.actorSpriteComps10034 then
					for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_344_6 then
							if arg_341_1.isInRecall_ then
								local var_344_19 = Mathf.Lerp(iter_344_6.color.r, arg_341_1.hightColor1.r, var_344_18)
								local var_344_20 = Mathf.Lerp(iter_344_6.color.g, arg_341_1.hightColor1.g, var_344_18)
								local var_344_21 = Mathf.Lerp(iter_344_6.color.b, arg_341_1.hightColor1.b, var_344_18)

								iter_344_6.color = Color.New(var_344_19, var_344_20, var_344_21)
							else
								local var_344_22 = Mathf.Lerp(iter_344_6.color.r, 1, var_344_18)

								iter_344_6.color = Color.New(var_344_22, var_344_22, var_344_22)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps10034 then
				for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_344_8 then
						if arg_341_1.isInRecall_ then
							iter_344_8.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps10034 = nil
			end

			local var_344_23 = 0
			local var_344_24 = 0.325

			if var_344_23 < arg_341_1.time_ and arg_341_1.time_ <= var_344_23 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_25 = arg_341_1:FormatText(StoryNameCfg[367].name)

				arg_341_1.leftNameTxt_.text = var_344_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_26 = arg_341_1:GetWordFromCfg(117041082)
				local var_344_27 = arg_341_1:FormatText(var_344_26.content)

				arg_341_1.text_.text = var_344_27

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_28 = 13
				local var_344_29 = utf8.len(var_344_27)
				local var_344_30 = var_344_28 <= 0 and var_344_24 or var_344_24 * (var_344_29 / var_344_28)

				if var_344_30 > 0 and var_344_24 < var_344_30 then
					arg_341_1.talkMaxDuration = var_344_30

					if var_344_30 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_30 + var_344_23
					end
				end

				arg_341_1.text_.text = var_344_27
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041082", "story_v_out_117041.awb") ~= 0 then
					local var_344_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041082", "story_v_out_117041.awb") / 1000

					if var_344_31 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_31 + var_344_23
					end

					if var_344_26.prefab_name ~= "" and arg_341_1.actors_[var_344_26.prefab_name] ~= nil then
						local var_344_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_26.prefab_name].transform, "story_v_out_117041", "117041082", "story_v_out_117041.awb")

						arg_341_1:RecordAudio("117041082", var_344_32)
						arg_341_1:RecordAudio("117041082", var_344_32)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_117041", "117041082", "story_v_out_117041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_117041", "117041082", "story_v_out_117041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_33 = math.max(var_344_24, arg_341_1.talkMaxDuration)

			if var_344_23 <= arg_341_1.time_ and arg_341_1.time_ < var_344_23 + var_344_33 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_23) / var_344_33

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_23 + var_344_33 and arg_341_1.time_ < var_344_23 + var_344_33 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play117041083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 117041083
		arg_345_1.duration_ = 3.2

		local var_345_0 = {
			zh = 3.2,
			ja = 3.133
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
				arg_345_0:Play117041084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.25

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[367].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:GetWordFromCfg(117041083)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041083", "story_v_out_117041.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041083", "story_v_out_117041.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_117041", "117041083", "story_v_out_117041.awb")

						arg_345_1:RecordAudio("117041083", var_348_9)
						arg_345_1:RecordAudio("117041083", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_117041", "117041083", "story_v_out_117041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_117041", "117041083", "story_v_out_117041.awb")
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
	Play117041084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 117041084
		arg_349_1.duration_ = 6

		local var_349_0 = {
			zh = 2,
			ja = 6
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
				arg_349_0:Play117041085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1132"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps1132 == nil then
				arg_349_1.var_.actorSpriteComps1132 = var_352_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_2 = 0.2

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.actorSpriteComps1132 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								local var_352_4 = Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor1.r, var_352_3)
								local var_352_5 = Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor1.g, var_352_3)
								local var_352_6 = Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor1.b, var_352_3)

								iter_352_1.color = Color.New(var_352_4, var_352_5, var_352_6)
							else
								local var_352_7 = Mathf.Lerp(iter_352_1.color.r, 1, var_352_3)

								iter_352_1.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps1132 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_352_3 then
						if arg_349_1.isInRecall_ then
							iter_352_3.color = arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_352_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps1132 = nil
			end

			local var_352_8 = arg_349_1.actors_["10034"]
			local var_352_9 = 0

			if var_352_9 < arg_349_1.time_ and arg_349_1.time_ <= var_352_9 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.actorSpriteComps10034 == nil then
				arg_349_1.var_.actorSpriteComps10034 = var_352_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_10 = 0.2

			if var_352_9 <= arg_349_1.time_ and arg_349_1.time_ < var_352_9 + var_352_10 and not isNil(var_352_8) then
				local var_352_11 = (arg_349_1.time_ - var_352_9) / var_352_10

				if arg_349_1.var_.actorSpriteComps10034 then
					for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_352_5 then
							if arg_349_1.isInRecall_ then
								local var_352_12 = Mathf.Lerp(iter_352_5.color.r, arg_349_1.hightColor2.r, var_352_11)
								local var_352_13 = Mathf.Lerp(iter_352_5.color.g, arg_349_1.hightColor2.g, var_352_11)
								local var_352_14 = Mathf.Lerp(iter_352_5.color.b, arg_349_1.hightColor2.b, var_352_11)

								iter_352_5.color = Color.New(var_352_12, var_352_13, var_352_14)
							else
								local var_352_15 = Mathf.Lerp(iter_352_5.color.r, 0.5, var_352_11)

								iter_352_5.color = Color.New(var_352_15, var_352_15, var_352_15)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_9 + var_352_10 and arg_349_1.time_ < var_352_9 + var_352_10 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.actorSpriteComps10034 then
				for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_352_7 then
						if arg_349_1.isInRecall_ then
							iter_352_7.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10034 = nil
			end

			local var_352_16 = 0
			local var_352_17 = 0.275

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_18 = arg_349_1:FormatText(StoryNameCfg[61].name)

				arg_349_1.leftNameTxt_.text = var_352_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_19 = arg_349_1:GetWordFromCfg(117041084)
				local var_352_20 = arg_349_1:FormatText(var_352_19.content)

				arg_349_1.text_.text = var_352_20

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_21 = 11
				local var_352_22 = utf8.len(var_352_20)
				local var_352_23 = var_352_21 <= 0 and var_352_17 or var_352_17 * (var_352_22 / var_352_21)

				if var_352_23 > 0 and var_352_17 < var_352_23 then
					arg_349_1.talkMaxDuration = var_352_23

					if var_352_23 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_23 + var_352_16
					end
				end

				arg_349_1.text_.text = var_352_20
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041084", "story_v_out_117041.awb") ~= 0 then
					local var_352_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041084", "story_v_out_117041.awb") / 1000

					if var_352_24 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_24 + var_352_16
					end

					if var_352_19.prefab_name ~= "" and arg_349_1.actors_[var_352_19.prefab_name] ~= nil then
						local var_352_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_19.prefab_name].transform, "story_v_out_117041", "117041084", "story_v_out_117041.awb")

						arg_349_1:RecordAudio("117041084", var_352_25)
						arg_349_1:RecordAudio("117041084", var_352_25)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_117041", "117041084", "story_v_out_117041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_117041", "117041084", "story_v_out_117041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_26 = math.max(var_352_17, arg_349_1.talkMaxDuration)

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_26 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_16) / var_352_26

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_16 + var_352_26 and arg_349_1.time_ < var_352_16 + var_352_26 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play117041085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 117041085
		arg_353_1.duration_ = 7.5

		local var_353_0 = {
			zh = 7.5,
			ja = 3.766
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
				arg_353_0:Play117041086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10034"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps10034 == nil then
				arg_353_1.var_.actorSpriteComps10034 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps10034 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 1, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps10034 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10034 = nil
			end

			local var_356_8 = arg_353_1.actors_["1132"]
			local var_356_9 = 0

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps1132 == nil then
				arg_353_1.var_.actorSpriteComps1132 = var_356_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_10 = 0.2

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_10 and not isNil(var_356_8) then
				local var_356_11 = (arg_353_1.time_ - var_356_9) / var_356_10

				if arg_353_1.var_.actorSpriteComps1132 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								local var_356_12 = Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, var_356_11)
								local var_356_13 = Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, var_356_11)
								local var_356_14 = Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, var_356_11)

								iter_356_5.color = Color.New(var_356_12, var_356_13, var_356_14)
							else
								local var_356_15 = Mathf.Lerp(iter_356_5.color.r, 0.5, var_356_11)

								iter_356_5.color = Color.New(var_356_15, var_356_15, var_356_15)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_9 + var_356_10 and arg_353_1.time_ < var_356_9 + var_356_10 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps1132 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_356_7 then
						if arg_353_1.isInRecall_ then
							iter_356_7.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1132 = nil
			end

			local var_356_16 = 0
			local var_356_17 = 0.675

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_18 = arg_353_1:FormatText(StoryNameCfg[367].name)

				arg_353_1.leftNameTxt_.text = var_356_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_19 = arg_353_1:GetWordFromCfg(117041085)
				local var_356_20 = arg_353_1:FormatText(var_356_19.content)

				arg_353_1.text_.text = var_356_20

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_21 = 27
				local var_356_22 = utf8.len(var_356_20)
				local var_356_23 = var_356_21 <= 0 and var_356_17 or var_356_17 * (var_356_22 / var_356_21)

				if var_356_23 > 0 and var_356_17 < var_356_23 then
					arg_353_1.talkMaxDuration = var_356_23

					if var_356_23 + var_356_16 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_16
					end
				end

				arg_353_1.text_.text = var_356_20
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041085", "story_v_out_117041.awb") ~= 0 then
					local var_356_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041085", "story_v_out_117041.awb") / 1000

					if var_356_24 + var_356_16 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_24 + var_356_16
					end

					if var_356_19.prefab_name ~= "" and arg_353_1.actors_[var_356_19.prefab_name] ~= nil then
						local var_356_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_19.prefab_name].transform, "story_v_out_117041", "117041085", "story_v_out_117041.awb")

						arg_353_1:RecordAudio("117041085", var_356_25)
						arg_353_1:RecordAudio("117041085", var_356_25)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_117041", "117041085", "story_v_out_117041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_117041", "117041085", "story_v_out_117041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_26 = math.max(var_356_17, arg_353_1.talkMaxDuration)

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_26 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_16) / var_356_26

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_16 + var_356_26 and arg_353_1.time_ < var_356_16 + var_356_26 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play117041086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 117041086
		arg_357_1.duration_ = 8.9

		local var_357_0 = {
			zh = 8.533,
			ja = 8.9
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
				arg_357_0:Play117041087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1132"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1132 == nil then
				arg_357_1.var_.actorSpriteComps1132 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps1132 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1132 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1132 = nil
			end

			local var_360_8 = arg_357_1.actors_["10034"]
			local var_360_9 = 0

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps10034 == nil then
				arg_357_1.var_.actorSpriteComps10034 = var_360_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_10 = 0.2

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_10 and not isNil(var_360_8) then
				local var_360_11 = (arg_357_1.time_ - var_360_9) / var_360_10

				if arg_357_1.var_.actorSpriteComps10034 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								local var_360_12 = Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, var_360_11)
								local var_360_13 = Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, var_360_11)
								local var_360_14 = Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, var_360_11)

								iter_360_5.color = Color.New(var_360_12, var_360_13, var_360_14)
							else
								local var_360_15 = Mathf.Lerp(iter_360_5.color.r, 0.5, var_360_11)

								iter_360_5.color = Color.New(var_360_15, var_360_15, var_360_15)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_9 + var_360_10 and arg_357_1.time_ < var_360_9 + var_360_10 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps10034 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_360_7 then
						if arg_357_1.isInRecall_ then
							iter_360_7.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10034 = nil
			end

			local var_360_16 = 0
			local var_360_17 = 1.2

			if var_360_16 < arg_357_1.time_ and arg_357_1.time_ <= var_360_16 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_18 = arg_357_1:FormatText(StoryNameCfg[61].name)

				arg_357_1.leftNameTxt_.text = var_360_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_19 = arg_357_1:GetWordFromCfg(117041086)
				local var_360_20 = arg_357_1:FormatText(var_360_19.content)

				arg_357_1.text_.text = var_360_20

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_21 = 48
				local var_360_22 = utf8.len(var_360_20)
				local var_360_23 = var_360_21 <= 0 and var_360_17 or var_360_17 * (var_360_22 / var_360_21)

				if var_360_23 > 0 and var_360_17 < var_360_23 then
					arg_357_1.talkMaxDuration = var_360_23

					if var_360_23 + var_360_16 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_16
					end
				end

				arg_357_1.text_.text = var_360_20
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041086", "story_v_out_117041.awb") ~= 0 then
					local var_360_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041086", "story_v_out_117041.awb") / 1000

					if var_360_24 + var_360_16 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_24 + var_360_16
					end

					if var_360_19.prefab_name ~= "" and arg_357_1.actors_[var_360_19.prefab_name] ~= nil then
						local var_360_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_19.prefab_name].transform, "story_v_out_117041", "117041086", "story_v_out_117041.awb")

						arg_357_1:RecordAudio("117041086", var_360_25)
						arg_357_1:RecordAudio("117041086", var_360_25)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_117041", "117041086", "story_v_out_117041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_117041", "117041086", "story_v_out_117041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_26 = math.max(var_360_17, arg_357_1.talkMaxDuration)

			if var_360_16 <= arg_357_1.time_ and arg_357_1.time_ < var_360_16 + var_360_26 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_16) / var_360_26

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_16 + var_360_26 and arg_357_1.time_ < var_360_16 + var_360_26 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play117041087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 117041087
		arg_361_1.duration_ = 1.73

		local var_361_0 = {
			zh = 1.733,
			ja = 1.4
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
				arg_361_0:Play117041088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10034"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos10034 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10034", 4)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "split_2" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(390, -415, -290)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10034, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_364_7 = arg_361_1.actors_["1132"]
			local var_364_8 = 0

			if var_364_8 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps1132 == nil then
				arg_361_1.var_.actorSpriteComps1132 = var_364_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_9 = 0.2

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_9 and not isNil(var_364_7) then
				local var_364_10 = (arg_361_1.time_ - var_364_8) / var_364_9

				if arg_361_1.var_.actorSpriteComps1132 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								local var_364_11 = Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor2.r, var_364_10)
								local var_364_12 = Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor2.g, var_364_10)
								local var_364_13 = Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor2.b, var_364_10)

								iter_364_2.color = Color.New(var_364_11, var_364_12, var_364_13)
							else
								local var_364_14 = Mathf.Lerp(iter_364_2.color.r, 0.5, var_364_10)

								iter_364_2.color = Color.New(var_364_14, var_364_14, var_364_14)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_8 + var_364_9 and arg_361_1.time_ < var_364_8 + var_364_9 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps1132 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_364_4 then
						if arg_361_1.isInRecall_ then
							iter_364_4.color = arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_364_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps1132 = nil
			end

			local var_364_15 = arg_361_1.actors_["10034"]
			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 and not isNil(var_364_15) and arg_361_1.var_.actorSpriteComps10034 == nil then
				arg_361_1.var_.actorSpriteComps10034 = var_364_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_17 = 0.2

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_17 and not isNil(var_364_15) then
				local var_364_18 = (arg_361_1.time_ - var_364_16) / var_364_17

				if arg_361_1.var_.actorSpriteComps10034 then
					for iter_364_5, iter_364_6 in pairs(arg_361_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_364_6 then
							if arg_361_1.isInRecall_ then
								local var_364_19 = Mathf.Lerp(iter_364_6.color.r, arg_361_1.hightColor1.r, var_364_18)
								local var_364_20 = Mathf.Lerp(iter_364_6.color.g, arg_361_1.hightColor1.g, var_364_18)
								local var_364_21 = Mathf.Lerp(iter_364_6.color.b, arg_361_1.hightColor1.b, var_364_18)

								iter_364_6.color = Color.New(var_364_19, var_364_20, var_364_21)
							else
								local var_364_22 = Mathf.Lerp(iter_364_6.color.r, 1, var_364_18)

								iter_364_6.color = Color.New(var_364_22, var_364_22, var_364_22)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_16 + var_364_17 and arg_361_1.time_ < var_364_16 + var_364_17 + arg_364_0 and not isNil(var_364_15) and arg_361_1.var_.actorSpriteComps10034 then
				for iter_364_7, iter_364_8 in pairs(arg_361_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_364_8 then
						if arg_361_1.isInRecall_ then
							iter_364_8.color = arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_364_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps10034 = nil
			end

			local var_364_23 = 0
			local var_364_24 = 0.075

			if var_364_23 < arg_361_1.time_ and arg_361_1.time_ <= var_364_23 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_25 = arg_361_1:FormatText(StoryNameCfg[367].name)

				arg_361_1.leftNameTxt_.text = var_364_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_26 = arg_361_1:GetWordFromCfg(117041087)
				local var_364_27 = arg_361_1:FormatText(var_364_26.content)

				arg_361_1.text_.text = var_364_27

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_28 = 3
				local var_364_29 = utf8.len(var_364_27)
				local var_364_30 = var_364_28 <= 0 and var_364_24 or var_364_24 * (var_364_29 / var_364_28)

				if var_364_30 > 0 and var_364_24 < var_364_30 then
					arg_361_1.talkMaxDuration = var_364_30

					if var_364_30 + var_364_23 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_30 + var_364_23
					end
				end

				arg_361_1.text_.text = var_364_27
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041087", "story_v_out_117041.awb") ~= 0 then
					local var_364_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041087", "story_v_out_117041.awb") / 1000

					if var_364_31 + var_364_23 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_31 + var_364_23
					end

					if var_364_26.prefab_name ~= "" and arg_361_1.actors_[var_364_26.prefab_name] ~= nil then
						local var_364_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_26.prefab_name].transform, "story_v_out_117041", "117041087", "story_v_out_117041.awb")

						arg_361_1:RecordAudio("117041087", var_364_32)
						arg_361_1:RecordAudio("117041087", var_364_32)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_117041", "117041087", "story_v_out_117041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_117041", "117041087", "story_v_out_117041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_33 = math.max(var_364_24, arg_361_1.talkMaxDuration)

			if var_364_23 <= arg_361_1.time_ and arg_361_1.time_ < var_364_23 + var_364_33 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_23) / var_364_33

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_23 + var_364_33 and arg_361_1.time_ < var_364_23 + var_364_33 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play117041088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 117041088
		arg_365_1.duration_ = 12.5

		local var_365_0 = {
			zh = 12.5,
			ja = 8.7
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
				arg_365_0:Play117041089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 1.175

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[367].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(117041088)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041088", "story_v_out_117041.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041088", "story_v_out_117041.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_117041", "117041088", "story_v_out_117041.awb")

						arg_365_1:RecordAudio("117041088", var_368_9)
						arg_365_1:RecordAudio("117041088", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_117041", "117041088", "story_v_out_117041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_117041", "117041088", "story_v_out_117041.awb")
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
	Play117041089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 117041089
		arg_369_1.duration_ = 4.87

		local var_369_0 = {
			zh = 2.366,
			ja = 4.866
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
				arg_369_0:Play117041090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1132"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1132 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1132", 2)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "split_5" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(-390, -413, -185)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1132, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_372_7 = arg_369_1.actors_["1132"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1132 == nil then
				arg_369_1.var_.actorSpriteComps1132 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 0.2

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps1132 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								local var_372_11 = Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, var_372_10)
								local var_372_12 = Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, var_372_10)
								local var_372_13 = Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, var_372_10)

								iter_372_2.color = Color.New(var_372_11, var_372_12, var_372_13)
							else
								local var_372_14 = Mathf.Lerp(iter_372_2.color.r, 1, var_372_10)

								iter_372_2.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1132 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1132 = nil
			end

			local var_372_15 = arg_369_1.actors_["10034"]
			local var_372_16 = 0

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps10034 == nil then
				arg_369_1.var_.actorSpriteComps10034 = var_372_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_17 = 0.2

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_17 and not isNil(var_372_15) then
				local var_372_18 = (arg_369_1.time_ - var_372_16) / var_372_17

				if arg_369_1.var_.actorSpriteComps10034 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								local var_372_19 = Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, var_372_18)
								local var_372_20 = Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, var_372_18)
								local var_372_21 = Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, var_372_18)

								iter_372_6.color = Color.New(var_372_19, var_372_20, var_372_21)
							else
								local var_372_22 = Mathf.Lerp(iter_372_6.color.r, 0.5, var_372_18)

								iter_372_6.color = Color.New(var_372_22, var_372_22, var_372_22)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps10034 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_372_8 then
						if arg_369_1.isInRecall_ then
							iter_372_8.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10034 = nil
			end

			local var_372_23 = 0
			local var_372_24 = 0.3

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_25 = arg_369_1:FormatText(StoryNameCfg[61].name)

				arg_369_1.leftNameTxt_.text = var_372_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_26 = arg_369_1:GetWordFromCfg(117041089)
				local var_372_27 = arg_369_1:FormatText(var_372_26.content)

				arg_369_1.text_.text = var_372_27

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_28 = 12
				local var_372_29 = utf8.len(var_372_27)
				local var_372_30 = var_372_28 <= 0 and var_372_24 or var_372_24 * (var_372_29 / var_372_28)

				if var_372_30 > 0 and var_372_24 < var_372_30 then
					arg_369_1.talkMaxDuration = var_372_30

					if var_372_30 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_30 + var_372_23
					end
				end

				arg_369_1.text_.text = var_372_27
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041089", "story_v_out_117041.awb") ~= 0 then
					local var_372_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041089", "story_v_out_117041.awb") / 1000

					if var_372_31 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_31 + var_372_23
					end

					if var_372_26.prefab_name ~= "" and arg_369_1.actors_[var_372_26.prefab_name] ~= nil then
						local var_372_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_26.prefab_name].transform, "story_v_out_117041", "117041089", "story_v_out_117041.awb")

						arg_369_1:RecordAudio("117041089", var_372_32)
						arg_369_1:RecordAudio("117041089", var_372_32)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_117041", "117041089", "story_v_out_117041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_117041", "117041089", "story_v_out_117041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_33 = math.max(var_372_24, arg_369_1.talkMaxDuration)

			if var_372_23 <= arg_369_1.time_ and arg_369_1.time_ < var_372_23 + var_372_33 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_23) / var_372_33

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_23 + var_372_33 and arg_369_1.time_ < var_372_23 + var_372_33 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play117041090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 117041090
		arg_373_1.duration_ = 9.23

		local var_373_0 = {
			zh = 7.6,
			ja = 9.233
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
				arg_373_0:Play117041091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10034"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps10034 == nil then
				arg_373_1.var_.actorSpriteComps10034 = var_376_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_2 = 0.2

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.actorSpriteComps10034 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								local var_376_4 = Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, var_376_3)
								local var_376_5 = Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, var_376_3)
								local var_376_6 = Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, var_376_3)

								iter_376_1.color = Color.New(var_376_4, var_376_5, var_376_6)
							else
								local var_376_7 = Mathf.Lerp(iter_376_1.color.r, 1, var_376_3)

								iter_376_1.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps10034 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_376_3 then
						if arg_373_1.isInRecall_ then
							iter_376_3.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10034 = nil
			end

			local var_376_8 = arg_373_1.actors_["1132"]
			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps1132 == nil then
				arg_373_1.var_.actorSpriteComps1132 = var_376_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_10 = 0.2

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_10 and not isNil(var_376_8) then
				local var_376_11 = (arg_373_1.time_ - var_376_9) / var_376_10

				if arg_373_1.var_.actorSpriteComps1132 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								local var_376_12 = Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, var_376_11)
								local var_376_13 = Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, var_376_11)
								local var_376_14 = Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, var_376_11)

								iter_376_5.color = Color.New(var_376_12, var_376_13, var_376_14)
							else
								local var_376_15 = Mathf.Lerp(iter_376_5.color.r, 0.5, var_376_11)

								iter_376_5.color = Color.New(var_376_15, var_376_15, var_376_15)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_9 + var_376_10 and arg_373_1.time_ < var_376_9 + var_376_10 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps1132 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_376_7 then
						if arg_373_1.isInRecall_ then
							iter_376_7.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1132 = nil
			end

			local var_376_16 = 0
			local var_376_17 = 0.825

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_18 = arg_373_1:FormatText(StoryNameCfg[367].name)

				arg_373_1.leftNameTxt_.text = var_376_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_19 = arg_373_1:GetWordFromCfg(117041090)
				local var_376_20 = arg_373_1:FormatText(var_376_19.content)

				arg_373_1.text_.text = var_376_20

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_21 = 33
				local var_376_22 = utf8.len(var_376_20)
				local var_376_23 = var_376_21 <= 0 and var_376_17 or var_376_17 * (var_376_22 / var_376_21)

				if var_376_23 > 0 and var_376_17 < var_376_23 then
					arg_373_1.talkMaxDuration = var_376_23

					if var_376_23 + var_376_16 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_23 + var_376_16
					end
				end

				arg_373_1.text_.text = var_376_20
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041090", "story_v_out_117041.awb") ~= 0 then
					local var_376_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041090", "story_v_out_117041.awb") / 1000

					if var_376_24 + var_376_16 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_24 + var_376_16
					end

					if var_376_19.prefab_name ~= "" and arg_373_1.actors_[var_376_19.prefab_name] ~= nil then
						local var_376_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_19.prefab_name].transform, "story_v_out_117041", "117041090", "story_v_out_117041.awb")

						arg_373_1:RecordAudio("117041090", var_376_25)
						arg_373_1:RecordAudio("117041090", var_376_25)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_117041", "117041090", "story_v_out_117041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_117041", "117041090", "story_v_out_117041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_26 = math.max(var_376_17, arg_373_1.talkMaxDuration)

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_26 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_16) / var_376_26

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_16 + var_376_26 and arg_373_1.time_ < var_376_16 + var_376_26 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play117041091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 117041091
		arg_377_1.duration_ = 15

		local var_377_0 = {
			zh = 15,
			ja = 5.2
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
				arg_377_0:Play117041092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1132"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1132 = var_380_0.localPosition
				var_380_0.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1132", 2)

				local var_380_2 = var_380_0.childCount

				for iter_380_0 = 0, var_380_2 - 1 do
					local var_380_3 = var_380_0:GetChild(iter_380_0)

					if var_380_3.name == "split_6" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_4 then
				local var_380_5 = (arg_377_1.time_ - var_380_1) / var_380_4
				local var_380_6 = Vector3.New(-390, -413, -185)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1132, var_380_6, var_380_5)
			end

			if arg_377_1.time_ >= var_380_1 + var_380_4 and arg_377_1.time_ < var_380_1 + var_380_4 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_380_7 = arg_377_1.actors_["10034"]
			local var_380_8 = 0

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps10034 == nil then
				arg_377_1.var_.actorSpriteComps10034 = var_380_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_9 = 0.2

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_9 and not isNil(var_380_7) then
				local var_380_10 = (arg_377_1.time_ - var_380_8) / var_380_9

				if arg_377_1.var_.actorSpriteComps10034 then
					for iter_380_1, iter_380_2 in pairs(arg_377_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_380_2 then
							if arg_377_1.isInRecall_ then
								local var_380_11 = Mathf.Lerp(iter_380_2.color.r, arg_377_1.hightColor2.r, var_380_10)
								local var_380_12 = Mathf.Lerp(iter_380_2.color.g, arg_377_1.hightColor2.g, var_380_10)
								local var_380_13 = Mathf.Lerp(iter_380_2.color.b, arg_377_1.hightColor2.b, var_380_10)

								iter_380_2.color = Color.New(var_380_11, var_380_12, var_380_13)
							else
								local var_380_14 = Mathf.Lerp(iter_380_2.color.r, 0.5, var_380_10)

								iter_380_2.color = Color.New(var_380_14, var_380_14, var_380_14)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_8 + var_380_9 and arg_377_1.time_ < var_380_8 + var_380_9 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps10034 then
				for iter_380_3, iter_380_4 in pairs(arg_377_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_380_4 then
						if arg_377_1.isInRecall_ then
							iter_380_4.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10034 = nil
			end

			local var_380_15 = arg_377_1.actors_["1132"]
			local var_380_16 = 0

			if var_380_16 < arg_377_1.time_ and arg_377_1.time_ <= var_380_16 + arg_380_0 and not isNil(var_380_15) and arg_377_1.var_.actorSpriteComps1132 == nil then
				arg_377_1.var_.actorSpriteComps1132 = var_380_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_17 = 0.2

			if var_380_16 <= arg_377_1.time_ and arg_377_1.time_ < var_380_16 + var_380_17 and not isNil(var_380_15) then
				local var_380_18 = (arg_377_1.time_ - var_380_16) / var_380_17

				if arg_377_1.var_.actorSpriteComps1132 then
					for iter_380_5, iter_380_6 in pairs(arg_377_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_380_6 then
							if arg_377_1.isInRecall_ then
								local var_380_19 = Mathf.Lerp(iter_380_6.color.r, arg_377_1.hightColor1.r, var_380_18)
								local var_380_20 = Mathf.Lerp(iter_380_6.color.g, arg_377_1.hightColor1.g, var_380_18)
								local var_380_21 = Mathf.Lerp(iter_380_6.color.b, arg_377_1.hightColor1.b, var_380_18)

								iter_380_6.color = Color.New(var_380_19, var_380_20, var_380_21)
							else
								local var_380_22 = Mathf.Lerp(iter_380_6.color.r, 1, var_380_18)

								iter_380_6.color = Color.New(var_380_22, var_380_22, var_380_22)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_16 + var_380_17 and arg_377_1.time_ < var_380_16 + var_380_17 + arg_380_0 and not isNil(var_380_15) and arg_377_1.var_.actorSpriteComps1132 then
				for iter_380_7, iter_380_8 in pairs(arg_377_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_380_8 then
						if arg_377_1.isInRecall_ then
							iter_380_8.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps1132 = nil
			end

			local var_380_23 = 0
			local var_380_24 = 1.375

			if var_380_23 < arg_377_1.time_ and arg_377_1.time_ <= var_380_23 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_25 = arg_377_1:FormatText(StoryNameCfg[61].name)

				arg_377_1.leftNameTxt_.text = var_380_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_26 = arg_377_1:GetWordFromCfg(117041091)
				local var_380_27 = arg_377_1:FormatText(var_380_26.content)

				arg_377_1.text_.text = var_380_27

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_28 = 55
				local var_380_29 = utf8.len(var_380_27)
				local var_380_30 = var_380_28 <= 0 and var_380_24 or var_380_24 * (var_380_29 / var_380_28)

				if var_380_30 > 0 and var_380_24 < var_380_30 then
					arg_377_1.talkMaxDuration = var_380_30

					if var_380_30 + var_380_23 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_30 + var_380_23
					end
				end

				arg_377_1.text_.text = var_380_27
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041091", "story_v_out_117041.awb") ~= 0 then
					local var_380_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041091", "story_v_out_117041.awb") / 1000

					if var_380_31 + var_380_23 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_31 + var_380_23
					end

					if var_380_26.prefab_name ~= "" and arg_377_1.actors_[var_380_26.prefab_name] ~= nil then
						local var_380_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_26.prefab_name].transform, "story_v_out_117041", "117041091", "story_v_out_117041.awb")

						arg_377_1:RecordAudio("117041091", var_380_32)
						arg_377_1:RecordAudio("117041091", var_380_32)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_117041", "117041091", "story_v_out_117041.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_117041", "117041091", "story_v_out_117041.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_33 = math.max(var_380_24, arg_377_1.talkMaxDuration)

			if var_380_23 <= arg_377_1.time_ and arg_377_1.time_ < var_380_23 + var_380_33 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_23) / var_380_33

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_23 + var_380_33 and arg_377_1.time_ < var_380_23 + var_380_33 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play117041092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 117041092
		arg_381_1.duration_ = 3.8

		local var_381_0 = {
			zh = 3.8,
			ja = 1.833
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play117041093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10034"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos10034 = var_384_0.localPosition
				var_384_0.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10034", 4)

				local var_384_2 = var_384_0.childCount

				for iter_384_0 = 0, var_384_2 - 1 do
					local var_384_3 = var_384_0:GetChild(iter_384_0)

					if var_384_3.name == "split_2" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_4 then
				local var_384_5 = (arg_381_1.time_ - var_384_1) / var_384_4
				local var_384_6 = Vector3.New(390, -415, -290)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10034, var_384_6, var_384_5)
			end

			if arg_381_1.time_ >= var_384_1 + var_384_4 and arg_381_1.time_ < var_384_1 + var_384_4 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_384_7 = arg_381_1.actors_["10034"]
			local var_384_8 = 0

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 and not isNil(var_384_7) and arg_381_1.var_.actorSpriteComps10034 == nil then
				arg_381_1.var_.actorSpriteComps10034 = var_384_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_9 = 0.2

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_9 and not isNil(var_384_7) then
				local var_384_10 = (arg_381_1.time_ - var_384_8) / var_384_9

				if arg_381_1.var_.actorSpriteComps10034 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_384_2 then
							if arg_381_1.isInRecall_ then
								local var_384_11 = Mathf.Lerp(iter_384_2.color.r, arg_381_1.hightColor1.r, var_384_10)
								local var_384_12 = Mathf.Lerp(iter_384_2.color.g, arg_381_1.hightColor1.g, var_384_10)
								local var_384_13 = Mathf.Lerp(iter_384_2.color.b, arg_381_1.hightColor1.b, var_384_10)

								iter_384_2.color = Color.New(var_384_11, var_384_12, var_384_13)
							else
								local var_384_14 = Mathf.Lerp(iter_384_2.color.r, 1, var_384_10)

								iter_384_2.color = Color.New(var_384_14, var_384_14, var_384_14)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_8 + var_384_9 and arg_381_1.time_ < var_384_8 + var_384_9 + arg_384_0 and not isNil(var_384_7) and arg_381_1.var_.actorSpriteComps10034 then
				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_384_4 then
						if arg_381_1.isInRecall_ then
							iter_384_4.color = arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_384_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps10034 = nil
			end

			local var_384_15 = arg_381_1.actors_["1132"]
			local var_384_16 = 0

			if var_384_16 < arg_381_1.time_ and arg_381_1.time_ <= var_384_16 + arg_384_0 and not isNil(var_384_15) and arg_381_1.var_.actorSpriteComps1132 == nil then
				arg_381_1.var_.actorSpriteComps1132 = var_384_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_17 = 0.2

			if var_384_16 <= arg_381_1.time_ and arg_381_1.time_ < var_384_16 + var_384_17 and not isNil(var_384_15) then
				local var_384_18 = (arg_381_1.time_ - var_384_16) / var_384_17

				if arg_381_1.var_.actorSpriteComps1132 then
					for iter_384_5, iter_384_6 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_384_6 then
							if arg_381_1.isInRecall_ then
								local var_384_19 = Mathf.Lerp(iter_384_6.color.r, arg_381_1.hightColor2.r, var_384_18)
								local var_384_20 = Mathf.Lerp(iter_384_6.color.g, arg_381_1.hightColor2.g, var_384_18)
								local var_384_21 = Mathf.Lerp(iter_384_6.color.b, arg_381_1.hightColor2.b, var_384_18)

								iter_384_6.color = Color.New(var_384_19, var_384_20, var_384_21)
							else
								local var_384_22 = Mathf.Lerp(iter_384_6.color.r, 0.5, var_384_18)

								iter_384_6.color = Color.New(var_384_22, var_384_22, var_384_22)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_16 + var_384_17 and arg_381_1.time_ < var_384_16 + var_384_17 + arg_384_0 and not isNil(var_384_15) and arg_381_1.var_.actorSpriteComps1132 then
				for iter_384_7, iter_384_8 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_384_8 then
						if arg_381_1.isInRecall_ then
							iter_384_8.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1132 = nil
			end

			local var_384_23 = 0
			local var_384_24 = 0.325

			if var_384_23 < arg_381_1.time_ and arg_381_1.time_ <= var_384_23 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_25 = arg_381_1:FormatText(StoryNameCfg[367].name)

				arg_381_1.leftNameTxt_.text = var_384_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_26 = arg_381_1:GetWordFromCfg(117041092)
				local var_384_27 = arg_381_1:FormatText(var_384_26.content)

				arg_381_1.text_.text = var_384_27

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_28 = 13
				local var_384_29 = utf8.len(var_384_27)
				local var_384_30 = var_384_28 <= 0 and var_384_24 or var_384_24 * (var_384_29 / var_384_28)

				if var_384_30 > 0 and var_384_24 < var_384_30 then
					arg_381_1.talkMaxDuration = var_384_30

					if var_384_30 + var_384_23 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_30 + var_384_23
					end
				end

				arg_381_1.text_.text = var_384_27
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041092", "story_v_out_117041.awb") ~= 0 then
					local var_384_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041092", "story_v_out_117041.awb") / 1000

					if var_384_31 + var_384_23 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_31 + var_384_23
					end

					if var_384_26.prefab_name ~= "" and arg_381_1.actors_[var_384_26.prefab_name] ~= nil then
						local var_384_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_26.prefab_name].transform, "story_v_out_117041", "117041092", "story_v_out_117041.awb")

						arg_381_1:RecordAudio("117041092", var_384_32)
						arg_381_1:RecordAudio("117041092", var_384_32)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_117041", "117041092", "story_v_out_117041.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_117041", "117041092", "story_v_out_117041.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_33 = math.max(var_384_24, arg_381_1.talkMaxDuration)

			if var_384_23 <= arg_381_1.time_ and arg_381_1.time_ < var_384_23 + var_384_33 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_23) / var_384_33

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_23 + var_384_33 and arg_381_1.time_ < var_384_23 + var_384_33 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play117041093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 117041093
		arg_385_1.duration_ = 6.5

		local var_385_0 = {
			zh = 6.5,
			ja = 5.666
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
				arg_385_0:Play117041094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 0.675

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_2 = arg_385_1:FormatText(StoryNameCfg[367].name)

				arg_385_1.leftNameTxt_.text = var_388_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_3 = arg_385_1:GetWordFromCfg(117041093)
				local var_388_4 = arg_385_1:FormatText(var_388_3.content)

				arg_385_1.text_.text = var_388_4

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041093", "story_v_out_117041.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041093", "story_v_out_117041.awb") / 1000

					if var_388_8 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_0
					end

					if var_388_3.prefab_name ~= "" and arg_385_1.actors_[var_388_3.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_3.prefab_name].transform, "story_v_out_117041", "117041093", "story_v_out_117041.awb")

						arg_385_1:RecordAudio("117041093", var_388_9)
						arg_385_1:RecordAudio("117041093", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_117041", "117041093", "story_v_out_117041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_117041", "117041093", "story_v_out_117041.awb")
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
	Play117041094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 117041094
		arg_389_1.duration_ = 7.63

		local var_389_0 = {
			zh = 7.333,
			ja = 7.633
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
				arg_389_0:Play117041095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1132"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1132 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1132", 2)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "split_2" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(-390, -413, -185)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1132, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_392_7 = arg_389_1.actors_["10034"]
			local var_392_8 = 0

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps10034 == nil then
				arg_389_1.var_.actorSpriteComps10034 = var_392_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 0.2

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_9 and not isNil(var_392_7) then
				local var_392_10 = (arg_389_1.time_ - var_392_8) / var_392_9

				if arg_389_1.var_.actorSpriteComps10034 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								local var_392_11 = Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor2.r, var_392_10)
								local var_392_12 = Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor2.g, var_392_10)
								local var_392_13 = Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor2.b, var_392_10)

								iter_392_2.color = Color.New(var_392_11, var_392_12, var_392_13)
							else
								local var_392_14 = Mathf.Lerp(iter_392_2.color.r, 0.5, var_392_10)

								iter_392_2.color = Color.New(var_392_14, var_392_14, var_392_14)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_8 + var_392_9 and arg_389_1.time_ < var_392_8 + var_392_9 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps10034 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_392_4 then
						if arg_389_1.isInRecall_ then
							iter_392_4.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10034 = nil
			end

			local var_392_15 = arg_389_1.actors_["1132"]
			local var_392_16 = 0

			if var_392_16 < arg_389_1.time_ and arg_389_1.time_ <= var_392_16 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps1132 == nil then
				arg_389_1.var_.actorSpriteComps1132 = var_392_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_17 = 0.2

			if var_392_16 <= arg_389_1.time_ and arg_389_1.time_ < var_392_16 + var_392_17 and not isNil(var_392_15) then
				local var_392_18 = (arg_389_1.time_ - var_392_16) / var_392_17

				if arg_389_1.var_.actorSpriteComps1132 then
					for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_392_6 then
							if arg_389_1.isInRecall_ then
								local var_392_19 = Mathf.Lerp(iter_392_6.color.r, arg_389_1.hightColor1.r, var_392_18)
								local var_392_20 = Mathf.Lerp(iter_392_6.color.g, arg_389_1.hightColor1.g, var_392_18)
								local var_392_21 = Mathf.Lerp(iter_392_6.color.b, arg_389_1.hightColor1.b, var_392_18)

								iter_392_6.color = Color.New(var_392_19, var_392_20, var_392_21)
							else
								local var_392_22 = Mathf.Lerp(iter_392_6.color.r, 1, var_392_18)

								iter_392_6.color = Color.New(var_392_22, var_392_22, var_392_22)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_16 + var_392_17 and arg_389_1.time_ < var_392_16 + var_392_17 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps1132 then
				for iter_392_7, iter_392_8 in pairs(arg_389_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_392_8 then
						if arg_389_1.isInRecall_ then
							iter_392_8.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1132 = nil
			end

			local var_392_23 = 0
			local var_392_24 = 0.875

			if var_392_23 < arg_389_1.time_ and arg_389_1.time_ <= var_392_23 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_25 = arg_389_1:FormatText(StoryNameCfg[61].name)

				arg_389_1.leftNameTxt_.text = var_392_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_26 = arg_389_1:GetWordFromCfg(117041094)
				local var_392_27 = arg_389_1:FormatText(var_392_26.content)

				arg_389_1.text_.text = var_392_27

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_28 = 35
				local var_392_29 = utf8.len(var_392_27)
				local var_392_30 = var_392_28 <= 0 and var_392_24 or var_392_24 * (var_392_29 / var_392_28)

				if var_392_30 > 0 and var_392_24 < var_392_30 then
					arg_389_1.talkMaxDuration = var_392_30

					if var_392_30 + var_392_23 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_30 + var_392_23
					end
				end

				arg_389_1.text_.text = var_392_27
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041094", "story_v_out_117041.awb") ~= 0 then
					local var_392_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041094", "story_v_out_117041.awb") / 1000

					if var_392_31 + var_392_23 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_31 + var_392_23
					end

					if var_392_26.prefab_name ~= "" and arg_389_1.actors_[var_392_26.prefab_name] ~= nil then
						local var_392_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_26.prefab_name].transform, "story_v_out_117041", "117041094", "story_v_out_117041.awb")

						arg_389_1:RecordAudio("117041094", var_392_32)
						arg_389_1:RecordAudio("117041094", var_392_32)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_117041", "117041094", "story_v_out_117041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_117041", "117041094", "story_v_out_117041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_33 = math.max(var_392_24, arg_389_1.talkMaxDuration)

			if var_392_23 <= arg_389_1.time_ and arg_389_1.time_ < var_392_23 + var_392_33 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_23) / var_392_33

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_23 + var_392_33 and arg_389_1.time_ < var_392_23 + var_392_33 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play117041095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 117041095
		arg_393_1.duration_ = 8.67

		local var_393_0 = {
			zh = 7.5,
			ja = 8.666
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
				arg_393_0:Play117041096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.75

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[61].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:GetWordFromCfg(117041095)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041095", "story_v_out_117041.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041095", "story_v_out_117041.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_out_117041", "117041095", "story_v_out_117041.awb")

						arg_393_1:RecordAudio("117041095", var_396_9)
						arg_393_1:RecordAudio("117041095", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_117041", "117041095", "story_v_out_117041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_117041", "117041095", "story_v_out_117041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_10 and arg_393_1.time_ < var_396_0 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play117041096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 117041096
		arg_397_1.duration_ = 6.33

		local var_397_0 = {
			zh = 3.266,
			ja = 6.333
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
				arg_397_0:Play117041097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10034"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10034 == nil then
				arg_397_1.var_.actorSpriteComps10034 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps10034 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 1, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10034 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps10034 = nil
			end

			local var_400_8 = arg_397_1.actors_["1132"]
			local var_400_9 = 0

			if var_400_9 < arg_397_1.time_ and arg_397_1.time_ <= var_400_9 + arg_400_0 and not isNil(var_400_8) and arg_397_1.var_.actorSpriteComps1132 == nil then
				arg_397_1.var_.actorSpriteComps1132 = var_400_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_10 = 0.2

			if var_400_9 <= arg_397_1.time_ and arg_397_1.time_ < var_400_9 + var_400_10 and not isNil(var_400_8) then
				local var_400_11 = (arg_397_1.time_ - var_400_9) / var_400_10

				if arg_397_1.var_.actorSpriteComps1132 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_400_5 then
							if arg_397_1.isInRecall_ then
								local var_400_12 = Mathf.Lerp(iter_400_5.color.r, arg_397_1.hightColor2.r, var_400_11)
								local var_400_13 = Mathf.Lerp(iter_400_5.color.g, arg_397_1.hightColor2.g, var_400_11)
								local var_400_14 = Mathf.Lerp(iter_400_5.color.b, arg_397_1.hightColor2.b, var_400_11)

								iter_400_5.color = Color.New(var_400_12, var_400_13, var_400_14)
							else
								local var_400_15 = Mathf.Lerp(iter_400_5.color.r, 0.5, var_400_11)

								iter_400_5.color = Color.New(var_400_15, var_400_15, var_400_15)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_9 + var_400_10 and arg_397_1.time_ < var_400_9 + var_400_10 + arg_400_0 and not isNil(var_400_8) and arg_397_1.var_.actorSpriteComps1132 then
				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_400_7 then
						if arg_397_1.isInRecall_ then
							iter_400_7.color = arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_400_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps1132 = nil
			end

			local var_400_16 = 0
			local var_400_17 = 0.325

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_18 = arg_397_1:FormatText(StoryNameCfg[367].name)

				arg_397_1.leftNameTxt_.text = var_400_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_19 = arg_397_1:GetWordFromCfg(117041096)
				local var_400_20 = arg_397_1:FormatText(var_400_19.content)

				arg_397_1.text_.text = var_400_20

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_21 = 13
				local var_400_22 = utf8.len(var_400_20)
				local var_400_23 = var_400_21 <= 0 and var_400_17 or var_400_17 * (var_400_22 / var_400_21)

				if var_400_23 > 0 and var_400_17 < var_400_23 then
					arg_397_1.talkMaxDuration = var_400_23

					if var_400_23 + var_400_16 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_16
					end
				end

				arg_397_1.text_.text = var_400_20
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041096", "story_v_out_117041.awb") ~= 0 then
					local var_400_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041096", "story_v_out_117041.awb") / 1000

					if var_400_24 + var_400_16 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_24 + var_400_16
					end

					if var_400_19.prefab_name ~= "" and arg_397_1.actors_[var_400_19.prefab_name] ~= nil then
						local var_400_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_19.prefab_name].transform, "story_v_out_117041", "117041096", "story_v_out_117041.awb")

						arg_397_1:RecordAudio("117041096", var_400_25)
						arg_397_1:RecordAudio("117041096", var_400_25)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_117041", "117041096", "story_v_out_117041.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_117041", "117041096", "story_v_out_117041.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_26 = math.max(var_400_17, arg_397_1.talkMaxDuration)

			if var_400_16 <= arg_397_1.time_ and arg_397_1.time_ < var_400_16 + var_400_26 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_16) / var_400_26

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_16 + var_400_26 and arg_397_1.time_ < var_400_16 + var_400_26 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play117041097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 117041097
		arg_401_1.duration_ = 2.3

		local var_401_0 = {
			zh = 2.3,
			ja = 0.999999999999
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
				arg_401_0:Play117041098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1132"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1132 = var_404_0.localPosition
				var_404_0.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1132", 2)

				local var_404_2 = var_404_0.childCount

				for iter_404_0 = 0, var_404_2 - 1 do
					local var_404_3 = var_404_0:GetChild(iter_404_0)

					if var_404_3.name == "split_6" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_1) / var_404_4
				local var_404_6 = Vector3.New(-390, -413, -185)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1132, var_404_6, var_404_5)
			end

			if arg_401_1.time_ >= var_404_1 + var_404_4 and arg_401_1.time_ < var_404_1 + var_404_4 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_404_7 = arg_401_1.actors_["10034"]
			local var_404_8 = 0

			if var_404_8 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps10034 == nil then
				arg_401_1.var_.actorSpriteComps10034 = var_404_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_9 = 0.2

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_9 and not isNil(var_404_7) then
				local var_404_10 = (arg_401_1.time_ - var_404_8) / var_404_9

				if arg_401_1.var_.actorSpriteComps10034 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								local var_404_11 = Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor2.r, var_404_10)
								local var_404_12 = Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor2.g, var_404_10)
								local var_404_13 = Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor2.b, var_404_10)

								iter_404_2.color = Color.New(var_404_11, var_404_12, var_404_13)
							else
								local var_404_14 = Mathf.Lerp(iter_404_2.color.r, 0.5, var_404_10)

								iter_404_2.color = Color.New(var_404_14, var_404_14, var_404_14)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_8 + var_404_9 and arg_401_1.time_ < var_404_8 + var_404_9 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps10034 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_404_4 then
						if arg_401_1.isInRecall_ then
							iter_404_4.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10034 = nil
			end

			local var_404_15 = arg_401_1.actors_["1132"]
			local var_404_16 = 0

			if var_404_16 < arg_401_1.time_ and arg_401_1.time_ <= var_404_16 + arg_404_0 and not isNil(var_404_15) and arg_401_1.var_.actorSpriteComps1132 == nil then
				arg_401_1.var_.actorSpriteComps1132 = var_404_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_17 = 0.2

			if var_404_16 <= arg_401_1.time_ and arg_401_1.time_ < var_404_16 + var_404_17 and not isNil(var_404_15) then
				local var_404_18 = (arg_401_1.time_ - var_404_16) / var_404_17

				if arg_401_1.var_.actorSpriteComps1132 then
					for iter_404_5, iter_404_6 in pairs(arg_401_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_404_6 then
							if arg_401_1.isInRecall_ then
								local var_404_19 = Mathf.Lerp(iter_404_6.color.r, arg_401_1.hightColor1.r, var_404_18)
								local var_404_20 = Mathf.Lerp(iter_404_6.color.g, arg_401_1.hightColor1.g, var_404_18)
								local var_404_21 = Mathf.Lerp(iter_404_6.color.b, arg_401_1.hightColor1.b, var_404_18)

								iter_404_6.color = Color.New(var_404_19, var_404_20, var_404_21)
							else
								local var_404_22 = Mathf.Lerp(iter_404_6.color.r, 1, var_404_18)

								iter_404_6.color = Color.New(var_404_22, var_404_22, var_404_22)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_16 + var_404_17 and arg_401_1.time_ < var_404_16 + var_404_17 + arg_404_0 and not isNil(var_404_15) and arg_401_1.var_.actorSpriteComps1132 then
				for iter_404_7, iter_404_8 in pairs(arg_401_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_404_8 then
						if arg_401_1.isInRecall_ then
							iter_404_8.color = arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_404_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps1132 = nil
			end

			local var_404_23 = 0
			local var_404_24 = 0.275

			if var_404_23 < arg_401_1.time_ and arg_401_1.time_ <= var_404_23 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_25 = arg_401_1:FormatText(StoryNameCfg[61].name)

				arg_401_1.leftNameTxt_.text = var_404_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_26 = arg_401_1:GetWordFromCfg(117041097)
				local var_404_27 = arg_401_1:FormatText(var_404_26.content)

				arg_401_1.text_.text = var_404_27

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_28 = 11
				local var_404_29 = utf8.len(var_404_27)
				local var_404_30 = var_404_28 <= 0 and var_404_24 or var_404_24 * (var_404_29 / var_404_28)

				if var_404_30 > 0 and var_404_24 < var_404_30 then
					arg_401_1.talkMaxDuration = var_404_30

					if var_404_30 + var_404_23 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_30 + var_404_23
					end
				end

				arg_401_1.text_.text = var_404_27
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041097", "story_v_out_117041.awb") ~= 0 then
					local var_404_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041097", "story_v_out_117041.awb") / 1000

					if var_404_31 + var_404_23 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_31 + var_404_23
					end

					if var_404_26.prefab_name ~= "" and arg_401_1.actors_[var_404_26.prefab_name] ~= nil then
						local var_404_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_26.prefab_name].transform, "story_v_out_117041", "117041097", "story_v_out_117041.awb")

						arg_401_1:RecordAudio("117041097", var_404_32)
						arg_401_1:RecordAudio("117041097", var_404_32)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_117041", "117041097", "story_v_out_117041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_117041", "117041097", "story_v_out_117041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_33 = math.max(var_404_24, arg_401_1.talkMaxDuration)

			if var_404_23 <= arg_401_1.time_ and arg_401_1.time_ < var_404_23 + var_404_33 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_23) / var_404_33

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_23 + var_404_33 and arg_401_1.time_ < var_404_23 + var_404_33 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play117041098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 117041098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play117041099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1132"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps1132 == nil then
				arg_405_1.var_.actorSpriteComps1132 = var_408_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.actorSpriteComps1132 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								local var_408_4 = Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor2.r, var_408_3)
								local var_408_5 = Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor2.g, var_408_3)
								local var_408_6 = Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor2.b, var_408_3)

								iter_408_1.color = Color.New(var_408_4, var_408_5, var_408_6)
							else
								local var_408_7 = Mathf.Lerp(iter_408_1.color.r, 0.5, var_408_3)

								iter_408_1.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps1132 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_408_3 then
						if arg_405_1.isInRecall_ then
							iter_408_3.color = arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_408_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps1132 = nil
			end

			local var_408_8 = 0
			local var_408_9 = 0.45

			if var_408_8 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(117041098)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_12 = 18
				local var_408_13 = utf8.len(var_408_11)
				local var_408_14 = var_408_12 <= 0 and var_408_9 or var_408_9 * (var_408_13 / var_408_12)

				if var_408_14 > 0 and var_408_9 < var_408_14 then
					arg_405_1.talkMaxDuration = var_408_14

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_15 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_15 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_15

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_15 and arg_405_1.time_ < var_408_8 + var_408_15 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play117041099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 117041099
		arg_409_1.duration_ = 3.8

		local var_409_0 = {
			zh = 3.8,
			ja = 3
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
				arg_409_0:Play117041100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1132"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps1132 == nil then
				arg_409_1.var_.actorSpriteComps1132 = var_412_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.actorSpriteComps1132 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								local var_412_4 = Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, var_412_3)
								local var_412_5 = Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, var_412_3)
								local var_412_6 = Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, var_412_3)

								iter_412_1.color = Color.New(var_412_4, var_412_5, var_412_6)
							else
								local var_412_7 = Mathf.Lerp(iter_412_1.color.r, 1, var_412_3)

								iter_412_1.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps1132 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_412_3 then
						if arg_409_1.isInRecall_ then
							iter_412_3.color = arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_412_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps1132 = nil
			end

			local var_412_8 = 0
			local var_412_9 = 0.275

			if var_412_8 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_10 = arg_409_1:FormatText(StoryNameCfg[61].name)

				arg_409_1.leftNameTxt_.text = var_412_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_11 = arg_409_1:GetWordFromCfg(117041099)
				local var_412_12 = arg_409_1:FormatText(var_412_11.content)

				arg_409_1.text_.text = var_412_12

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 11
				local var_412_14 = utf8.len(var_412_12)
				local var_412_15 = var_412_13 <= 0 and var_412_9 or var_412_9 * (var_412_14 / var_412_13)

				if var_412_15 > 0 and var_412_9 < var_412_15 then
					arg_409_1.talkMaxDuration = var_412_15

					if var_412_15 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_8
					end
				end

				arg_409_1.text_.text = var_412_12
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041099", "story_v_out_117041.awb") ~= 0 then
					local var_412_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041099", "story_v_out_117041.awb") / 1000

					if var_412_16 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_16 + var_412_8
					end

					if var_412_11.prefab_name ~= "" and arg_409_1.actors_[var_412_11.prefab_name] ~= nil then
						local var_412_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_11.prefab_name].transform, "story_v_out_117041", "117041099", "story_v_out_117041.awb")

						arg_409_1:RecordAudio("117041099", var_412_17)
						arg_409_1:RecordAudio("117041099", var_412_17)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_117041", "117041099", "story_v_out_117041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_117041", "117041099", "story_v_out_117041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_18 = math.max(var_412_9, arg_409_1.talkMaxDuration)

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_18 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_8) / var_412_18

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_8 + var_412_18 and arg_409_1.time_ < var_412_8 + var_412_18 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play117041100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 117041100
		arg_413_1.duration_ = 7.7

		local var_413_0 = {
			zh = 7.7,
			ja = 4.666
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
				arg_413_0:Play117041101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.725

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[61].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:GetWordFromCfg(117041100)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041100", "story_v_out_117041.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041100", "story_v_out_117041.awb") / 1000

					if var_416_8 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_0
					end

					if var_416_3.prefab_name ~= "" and arg_413_1.actors_[var_416_3.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_3.prefab_name].transform, "story_v_out_117041", "117041100", "story_v_out_117041.awb")

						arg_413_1:RecordAudio("117041100", var_416_9)
						arg_413_1:RecordAudio("117041100", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_117041", "117041100", "story_v_out_117041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_117041", "117041100", "story_v_out_117041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_10 and arg_413_1.time_ < var_416_0 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play117041101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 117041101
		arg_417_1.duration_ = 4.63

		local var_417_0 = {
			zh = 3.366,
			ja = 4.633
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play117041102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1132"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps1132 == nil then
				arg_417_1.var_.actorSpriteComps1132 = var_420_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.actorSpriteComps1132 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								local var_420_4 = Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor2.r, var_420_3)
								local var_420_5 = Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor2.g, var_420_3)
								local var_420_6 = Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor2.b, var_420_3)

								iter_420_1.color = Color.New(var_420_4, var_420_5, var_420_6)
							else
								local var_420_7 = Mathf.Lerp(iter_420_1.color.r, 0.5, var_420_3)

								iter_420_1.color = Color.New(var_420_7, var_420_7, var_420_7)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps1132 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_420_3 then
						if arg_417_1.isInRecall_ then
							iter_420_3.color = arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_420_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps1132 = nil
			end

			local var_420_8 = arg_417_1.actors_["10034"]
			local var_420_9 = 0

			if var_420_9 < arg_417_1.time_ and arg_417_1.time_ <= var_420_9 + arg_420_0 and not isNil(var_420_8) and arg_417_1.var_.actorSpriteComps10034 == nil then
				arg_417_1.var_.actorSpriteComps10034 = var_420_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_10 = 0.2

			if var_420_9 <= arg_417_1.time_ and arg_417_1.time_ < var_420_9 + var_420_10 and not isNil(var_420_8) then
				local var_420_11 = (arg_417_1.time_ - var_420_9) / var_420_10

				if arg_417_1.var_.actorSpriteComps10034 then
					for iter_420_4, iter_420_5 in pairs(arg_417_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_420_5 then
							if arg_417_1.isInRecall_ then
								local var_420_12 = Mathf.Lerp(iter_420_5.color.r, arg_417_1.hightColor1.r, var_420_11)
								local var_420_13 = Mathf.Lerp(iter_420_5.color.g, arg_417_1.hightColor1.g, var_420_11)
								local var_420_14 = Mathf.Lerp(iter_420_5.color.b, arg_417_1.hightColor1.b, var_420_11)

								iter_420_5.color = Color.New(var_420_12, var_420_13, var_420_14)
							else
								local var_420_15 = Mathf.Lerp(iter_420_5.color.r, 1, var_420_11)

								iter_420_5.color = Color.New(var_420_15, var_420_15, var_420_15)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_9 + var_420_10 and arg_417_1.time_ < var_420_9 + var_420_10 + arg_420_0 and not isNil(var_420_8) and arg_417_1.var_.actorSpriteComps10034 then
				for iter_420_6, iter_420_7 in pairs(arg_417_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_420_7 then
						if arg_417_1.isInRecall_ then
							iter_420_7.color = arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_420_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps10034 = nil
			end

			local var_420_16 = 0
			local var_420_17 = 0.225

			if var_420_16 < arg_417_1.time_ and arg_417_1.time_ <= var_420_16 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_18 = arg_417_1:FormatText(StoryNameCfg[367].name)

				arg_417_1.leftNameTxt_.text = var_420_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_19 = arg_417_1:GetWordFromCfg(117041101)
				local var_420_20 = arg_417_1:FormatText(var_420_19.content)

				arg_417_1.text_.text = var_420_20

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_21 = 9
				local var_420_22 = utf8.len(var_420_20)
				local var_420_23 = var_420_21 <= 0 and var_420_17 or var_420_17 * (var_420_22 / var_420_21)

				if var_420_23 > 0 and var_420_17 < var_420_23 then
					arg_417_1.talkMaxDuration = var_420_23

					if var_420_23 + var_420_16 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_23 + var_420_16
					end
				end

				arg_417_1.text_.text = var_420_20
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041101", "story_v_out_117041.awb") ~= 0 then
					local var_420_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041101", "story_v_out_117041.awb") / 1000

					if var_420_24 + var_420_16 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_24 + var_420_16
					end

					if var_420_19.prefab_name ~= "" and arg_417_1.actors_[var_420_19.prefab_name] ~= nil then
						local var_420_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_19.prefab_name].transform, "story_v_out_117041", "117041101", "story_v_out_117041.awb")

						arg_417_1:RecordAudio("117041101", var_420_25)
						arg_417_1:RecordAudio("117041101", var_420_25)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_117041", "117041101", "story_v_out_117041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_117041", "117041101", "story_v_out_117041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_26 = math.max(var_420_17, arg_417_1.talkMaxDuration)

			if var_420_16 <= arg_417_1.time_ and arg_417_1.time_ < var_420_16 + var_420_26 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_16) / var_420_26

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_16 + var_420_26 and arg_417_1.time_ < var_420_16 + var_420_26 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play117041102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 117041102
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play117041103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = "TI0103"

			if arg_421_1.bgs_[var_424_0] == nil then
				local var_424_1 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_424_0)
				var_424_1.name = var_424_0
				var_424_1.transform.parent = arg_421_1.stage_.transform
				var_424_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_[var_424_0] = var_424_1
			end

			local var_424_2 = 2

			if var_424_2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				local var_424_3 = manager.ui.mainCamera.transform.localPosition
				local var_424_4 = Vector3.New(0, 0, 10) + Vector3.New(var_424_3.x, var_424_3.y, 0)
				local var_424_5 = arg_421_1.bgs_.TI0103

				var_424_5.transform.localPosition = var_424_4
				var_424_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_6 = var_424_5:GetComponent("SpriteRenderer")

				if var_424_6 and var_424_6.sprite then
					local var_424_7 = (var_424_5.transform.localPosition - var_424_3).z
					local var_424_8 = manager.ui.mainCameraCom_
					local var_424_9 = 2 * var_424_7 * Mathf.Tan(var_424_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_424_10 = var_424_9 * var_424_8.aspect
					local var_424_11 = var_424_6.sprite.bounds.size.x
					local var_424_12 = var_424_6.sprite.bounds.size.y
					local var_424_13 = var_424_10 / var_424_11
					local var_424_14 = var_424_9 / var_424_12
					local var_424_15 = var_424_14 < var_424_13 and var_424_13 or var_424_14

					var_424_5.transform.localScale = Vector3.New(var_424_15, var_424_15, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "TI0103" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_16 = 0

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_17 = 2

			if var_424_16 <= arg_421_1.time_ and arg_421_1.time_ < var_424_16 + var_424_17 then
				local var_424_18 = (arg_421_1.time_ - var_424_16) / var_424_17
				local var_424_19 = Color.New(0, 0, 0)

				var_424_19.a = Mathf.Lerp(0, 1, var_424_18)
				arg_421_1.mask_.color = var_424_19
			end

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 then
				local var_424_20 = Color.New(0, 0, 0)

				var_424_20.a = 1
				arg_421_1.mask_.color = var_424_20
			end

			local var_424_21 = 2

			if var_424_21 < arg_421_1.time_ and arg_421_1.time_ <= var_424_21 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_22 = 2

			if var_424_21 <= arg_421_1.time_ and arg_421_1.time_ < var_424_21 + var_424_22 then
				local var_424_23 = (arg_421_1.time_ - var_424_21) / var_424_22
				local var_424_24 = Color.New(0, 0, 0)

				var_424_24.a = Mathf.Lerp(1, 0, var_424_23)
				arg_421_1.mask_.color = var_424_24
			end

			if arg_421_1.time_ >= var_424_21 + var_424_22 and arg_421_1.time_ < var_424_21 + var_424_22 + arg_424_0 then
				local var_424_25 = Color.New(0, 0, 0)
				local var_424_26 = 0

				arg_421_1.mask_.enabled = false
				var_424_25.a = var_424_26
				arg_421_1.mask_.color = var_424_25
			end

			local var_424_27 = arg_421_1.actors_["1132"].transform
			local var_424_28 = 2

			if var_424_28 < arg_421_1.time_ and arg_421_1.time_ <= var_424_28 + arg_424_0 then
				arg_421_1.var_.moveOldPos1132 = var_424_27.localPosition
				var_424_27.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("1132", 7)

				local var_424_29 = var_424_27.childCount

				for iter_424_2 = 0, var_424_29 - 1 do
					local var_424_30 = var_424_27:GetChild(iter_424_2)

					if var_424_30.name == "split_6" or not string.find(var_424_30.name, "split") then
						var_424_30.gameObject:SetActive(true)
					else
						var_424_30.gameObject:SetActive(false)
					end
				end
			end

			local var_424_31 = 0.001

			if var_424_28 <= arg_421_1.time_ and arg_421_1.time_ < var_424_28 + var_424_31 then
				local var_424_32 = (arg_421_1.time_ - var_424_28) / var_424_31
				local var_424_33 = Vector3.New(0, -2000, -185)

				var_424_27.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1132, var_424_33, var_424_32)
			end

			if arg_421_1.time_ >= var_424_28 + var_424_31 and arg_421_1.time_ < var_424_28 + var_424_31 + arg_424_0 then
				var_424_27.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_424_34 = arg_421_1.actors_["10034"].transform
			local var_424_35 = 2

			if var_424_35 < arg_421_1.time_ and arg_421_1.time_ <= var_424_35 + arg_424_0 then
				arg_421_1.var_.moveOldPos10034 = var_424_34.localPosition
				var_424_34.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("10034", 7)

				local var_424_36 = var_424_34.childCount

				for iter_424_3 = 0, var_424_36 - 1 do
					local var_424_37 = var_424_34:GetChild(iter_424_3)

					if var_424_37.name == "split_2" or not string.find(var_424_37.name, "split") then
						var_424_37.gameObject:SetActive(true)
					else
						var_424_37.gameObject:SetActive(false)
					end
				end
			end

			local var_424_38 = 0.001

			if var_424_35 <= arg_421_1.time_ and arg_421_1.time_ < var_424_35 + var_424_38 then
				local var_424_39 = (arg_421_1.time_ - var_424_35) / var_424_38
				local var_424_40 = Vector3.New(0, -2000, -290)

				var_424_34.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10034, var_424_40, var_424_39)
			end

			if arg_421_1.time_ >= var_424_35 + var_424_38 and arg_421_1.time_ < var_424_35 + var_424_38 + arg_424_0 then
				var_424_34.localPosition = Vector3.New(0, -2000, -290)
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_41 = 4
			local var_424_42 = 0.65

			if var_424_41 < arg_421_1.time_ and arg_421_1.time_ <= var_424_41 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_43 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_43:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_44 = arg_421_1:GetWordFromCfg(117041102)
				local var_424_45 = arg_421_1:FormatText(var_424_44.content)

				arg_421_1.text_.text = var_424_45

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_46 = 26
				local var_424_47 = utf8.len(var_424_45)
				local var_424_48 = var_424_46 <= 0 and var_424_42 or var_424_42 * (var_424_47 / var_424_46)

				if var_424_48 > 0 and var_424_42 < var_424_48 then
					arg_421_1.talkMaxDuration = var_424_48
					var_424_41 = var_424_41 + 0.3

					if var_424_48 + var_424_41 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_48 + var_424_41
					end
				end

				arg_421_1.text_.text = var_424_45
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_49 = var_424_41 + 0.3
			local var_424_50 = math.max(var_424_42, arg_421_1.talkMaxDuration)

			if var_424_49 <= arg_421_1.time_ and arg_421_1.time_ < var_424_49 + var_424_50 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_49) / var_424_50

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_49 + var_424_50 and arg_421_1.time_ < var_424_49 + var_424_50 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play117041103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 117041103
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play117041104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 1.125

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_2 = arg_427_1:GetWordFromCfg(117041103)
				local var_430_3 = arg_427_1:FormatText(var_430_2.content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 45
				local var_430_5 = utf8.len(var_430_3)
				local var_430_6 = var_430_4 <= 0 and var_430_1 or var_430_1 * (var_430_5 / var_430_4)

				if var_430_6 > 0 and var_430_1 < var_430_6 then
					arg_427_1.talkMaxDuration = var_430_6

					if var_430_6 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_6 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_7 and arg_427_1.time_ < var_430_0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play117041104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 117041104
		arg_431_1.duration_ = 7.43

		local var_431_0 = {
			zh = 3.433,
			ja = 7.433
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
				arg_431_0:Play117041105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.35

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[367].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:GetWordFromCfg(117041104)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 14
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041104", "story_v_out_117041.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041104", "story_v_out_117041.awb") / 1000

					if var_434_8 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_0
					end

					if var_434_3.prefab_name ~= "" and arg_431_1.actors_[var_434_3.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_3.prefab_name].transform, "story_v_out_117041", "117041104", "story_v_out_117041.awb")

						arg_431_1:RecordAudio("117041104", var_434_9)
						arg_431_1:RecordAudio("117041104", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_117041", "117041104", "story_v_out_117041.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_117041", "117041104", "story_v_out_117041.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_10 and arg_431_1.time_ < var_434_0 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play117041105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 117041105
		arg_435_1.duration_ = 1.6

		local var_435_0 = {
			zh = 1.6,
			ja = 1.333
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play117041106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.125

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[61].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_3 = arg_435_1:GetWordFromCfg(117041105)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 5
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041105", "story_v_out_117041.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041105", "story_v_out_117041.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_out_117041", "117041105", "story_v_out_117041.awb")

						arg_435_1:RecordAudio("117041105", var_438_9)
						arg_435_1:RecordAudio("117041105", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_117041", "117041105", "story_v_out_117041.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_117041", "117041105", "story_v_out_117041.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play117041106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 117041106
		arg_439_1.duration_ = 15.4

		local var_439_0 = {
			zh = 13.3,
			ja = 15.4
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play117041107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.5

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[367].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(117041106)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 60
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041106", "story_v_out_117041.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041106", "story_v_out_117041.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_117041", "117041106", "story_v_out_117041.awb")

						arg_439_1:RecordAudio("117041106", var_442_9)
						arg_439_1:RecordAudio("117041106", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_117041", "117041106", "story_v_out_117041.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_117041", "117041106", "story_v_out_117041.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play117041107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 117041107
		arg_443_1.duration_ = 16.43

		local var_443_0 = {
			zh = 14.733,
			ja = 16.433
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
				arg_443_0:Play117041108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 1.55

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[367].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(117041107)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 62
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041107", "story_v_out_117041.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041107", "story_v_out_117041.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_117041", "117041107", "story_v_out_117041.awb")

						arg_443_1:RecordAudio("117041107", var_446_9)
						arg_443_1:RecordAudio("117041107", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_117041", "117041107", "story_v_out_117041.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_117041", "117041107", "story_v_out_117041.awb")
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
	Play117041108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 117041108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play117041109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.45

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_2 = arg_447_1:GetWordFromCfg(117041108)
				local var_450_3 = arg_447_1:FormatText(var_450_2.content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 18
				local var_450_5 = utf8.len(var_450_3)
				local var_450_6 = var_450_4 <= 0 and var_450_1 or var_450_1 * (var_450_5 / var_450_4)

				if var_450_6 > 0 and var_450_1 < var_450_6 then
					arg_447_1.talkMaxDuration = var_450_6

					if var_450_6 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_6 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_7 and arg_447_1.time_ < var_450_0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play117041109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 117041109
		arg_451_1.duration_ = 4.5

		local var_451_0 = {
			zh = 4.5,
			ja = 2.8
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
				arg_451_0:Play117041110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 0.525

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[61].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_3 = arg_451_1:GetWordFromCfg(117041109)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041109", "story_v_out_117041.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041109", "story_v_out_117041.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_117041", "117041109", "story_v_out_117041.awb")

						arg_451_1:RecordAudio("117041109", var_454_9)
						arg_451_1:RecordAudio("117041109", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_117041", "117041109", "story_v_out_117041.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_117041", "117041109", "story_v_out_117041.awb")
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
	Play117041110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 117041110
		arg_455_1.duration_ = 14.23

		local var_455_0 = {
			zh = 14.233,
			ja = 11.7
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
				arg_455_0:Play117041111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 1.5

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[367].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_1")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(117041110)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 60
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041110", "story_v_out_117041.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041110", "story_v_out_117041.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_117041", "117041110", "story_v_out_117041.awb")

						arg_455_1:RecordAudio("117041110", var_458_9)
						arg_455_1:RecordAudio("117041110", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_117041", "117041110", "story_v_out_117041.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_117041", "117041110", "story_v_out_117041.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play117041111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 117041111
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play117041112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 1.275

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_2 = arg_459_1:GetWordFromCfg(117041111)
				local var_462_3 = arg_459_1:FormatText(var_462_2.content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 51
				local var_462_5 = utf8.len(var_462_3)
				local var_462_6 = var_462_4 <= 0 and var_462_1 or var_462_1 * (var_462_5 / var_462_4)

				if var_462_6 > 0 and var_462_1 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_7 and arg_459_1.time_ < var_462_0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play117041112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 117041112
		arg_463_1.duration_ = 8.63

		local var_463_0 = {
			zh = 7,
			ja = 8.633
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
				arg_463_0:Play117041113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.775

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[367].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(117041112)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041112", "story_v_out_117041.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041112", "story_v_out_117041.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_117041", "117041112", "story_v_out_117041.awb")

						arg_463_1:RecordAudio("117041112", var_466_9)
						arg_463_1:RecordAudio("117041112", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_117041", "117041112", "story_v_out_117041.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_117041", "117041112", "story_v_out_117041.awb")
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
	Play117041113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 117041113
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play117041114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.9

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

				local var_470_2 = arg_467_1:GetWordFromCfg(117041113)
				local var_470_3 = arg_467_1:FormatText(var_470_2.content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 36
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
	Play117041114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 117041114
		arg_471_1.duration_ = 1

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play117041115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 0.05

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_2 = arg_471_1:FormatText(StoryNameCfg[61].name)

				arg_471_1.leftNameTxt_.text = var_474_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:GetWordFromCfg(117041114)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 2
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_1 or var_474_1 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_1 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041114", "story_v_out_117041.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041114", "story_v_out_117041.awb") / 1000

					if var_474_8 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_0
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_out_117041", "117041114", "story_v_out_117041.awb")

						arg_471_1:RecordAudio("117041114", var_474_9)
						arg_471_1:RecordAudio("117041114", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_117041", "117041114", "story_v_out_117041.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_117041", "117041114", "story_v_out_117041.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_10 and arg_471_1.time_ < var_474_0 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play117041115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 117041115
		arg_475_1.duration_ = 18.77

		local var_475_0 = {
			zh = 12.6,
			ja = 18.766
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
				arg_475_0:Play117041116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 1.025

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[367].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_3")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:GetWordFromCfg(117041115)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041115", "story_v_out_117041.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041115", "story_v_out_117041.awb") / 1000

					if var_478_8 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_0
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_117041", "117041115", "story_v_out_117041.awb")

						arg_475_1:RecordAudio("117041115", var_478_9)
						arg_475_1:RecordAudio("117041115", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_117041", "117041115", "story_v_out_117041.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_117041", "117041115", "story_v_out_117041.awb")
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
	Play117041116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 117041116
		arg_479_1.duration_ = 9.77

		local var_479_0 = {
			zh = 9.766,
			ja = 7.166
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
				arg_479_0:Play117041117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 1

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[367].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:GetWordFromCfg(117041116)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 40
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041116", "story_v_out_117041.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041116", "story_v_out_117041.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_117041", "117041116", "story_v_out_117041.awb")

						arg_479_1:RecordAudio("117041116", var_482_9)
						arg_479_1:RecordAudio("117041116", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_117041", "117041116", "story_v_out_117041.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_117041", "117041116", "story_v_out_117041.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play117041117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 117041117
		arg_483_1.duration_ = 5.6

		local var_483_0 = {
			zh = 5.066,
			ja = 5.6
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
				arg_483_0:Play117041118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.475

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[61].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_3 = arg_483_1:GetWordFromCfg(117041117)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041117", "story_v_out_117041.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041117", "story_v_out_117041.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_117041", "117041117", "story_v_out_117041.awb")

						arg_483_1:RecordAudio("117041117", var_486_9)
						arg_483_1:RecordAudio("117041117", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_117041", "117041117", "story_v_out_117041.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_117041", "117041117", "story_v_out_117041.awb")
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
	Play117041118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 117041118
		arg_487_1.duration_ = 2.13

		local var_487_0 = {
			zh = 1.166,
			ja = 2.133
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
				arg_487_0:Play117041119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.075

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[367].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(117041118)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041118", "story_v_out_117041.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041118", "story_v_out_117041.awb") / 1000

					if var_490_8 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_0
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_out_117041", "117041118", "story_v_out_117041.awb")

						arg_487_1:RecordAudio("117041118", var_490_9)
						arg_487_1:RecordAudio("117041118", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_117041", "117041118", "story_v_out_117041.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_117041", "117041118", "story_v_out_117041.awb")
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
	Play117041119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 117041119
		arg_491_1.duration_ = 1

		local var_491_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_491_0:Play117041120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.125

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[61].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:GetWordFromCfg(117041119)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041119", "story_v_out_117041.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041119", "story_v_out_117041.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_out_117041", "117041119", "story_v_out_117041.awb")

						arg_491_1:RecordAudio("117041119", var_494_9)
						arg_491_1:RecordAudio("117041119", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_117041", "117041119", "story_v_out_117041.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_117041", "117041119", "story_v_out_117041.awb")
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
	Play117041120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 117041120
		arg_495_1.duration_ = 6.13

		local var_495_0 = {
			zh = 3,
			ja = 6.133
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
				arg_495_0:Play117041121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.275

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[367].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(117041120)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 11
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041120", "story_v_out_117041.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041120", "story_v_out_117041.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_117041", "117041120", "story_v_out_117041.awb")

						arg_495_1:RecordAudio("117041120", var_498_9)
						arg_495_1:RecordAudio("117041120", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_117041", "117041120", "story_v_out_117041.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_117041", "117041120", "story_v_out_117041.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play117041121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 117041121
		arg_499_1.duration_ = 1.67

		local var_499_0 = {
			zh = 1.166,
			ja = 1.666
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
				arg_499_0:Play117041122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 0.1

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[61].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:GetWordFromCfg(117041121)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041121", "story_v_out_117041.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041121", "story_v_out_117041.awb") / 1000

					if var_502_8 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_0
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_out_117041", "117041121", "story_v_out_117041.awb")

						arg_499_1:RecordAudio("117041121", var_502_9)
						arg_499_1:RecordAudio("117041121", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_117041", "117041121", "story_v_out_117041.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_117041", "117041121", "story_v_out_117041.awb")
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
	Play117041122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 117041122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play117041123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.55

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(117041122)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 22
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play117041123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 117041123
		arg_507_1.duration_ = 9

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play117041124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 2

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				local var_510_1 = manager.ui.mainCamera.transform.localPosition
				local var_510_2 = Vector3.New(0, 0, 10) + Vector3.New(var_510_1.x, var_510_1.y, 0)
				local var_510_3 = arg_507_1.bgs_.ST24a

				var_510_3.transform.localPosition = var_510_2
				var_510_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_510_4 = var_510_3:GetComponent("SpriteRenderer")

				if var_510_4 and var_510_4.sprite then
					local var_510_5 = (var_510_3.transform.localPosition - var_510_1).z
					local var_510_6 = manager.ui.mainCameraCom_
					local var_510_7 = 2 * var_510_5 * Mathf.Tan(var_510_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_510_8 = var_510_7 * var_510_6.aspect
					local var_510_9 = var_510_4.sprite.bounds.size.x
					local var_510_10 = var_510_4.sprite.bounds.size.y
					local var_510_11 = var_510_8 / var_510_9
					local var_510_12 = var_510_7 / var_510_10
					local var_510_13 = var_510_12 < var_510_11 and var_510_11 or var_510_12

					var_510_3.transform.localScale = Vector3.New(var_510_13, var_510_13, 0)
				end

				for iter_510_0, iter_510_1 in pairs(arg_507_1.bgs_) do
					if iter_510_0 ~= "ST24a" then
						iter_510_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_510_14 = 0

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = false

				arg_507_1:SetGaussion(false)
			end

			local var_510_15 = 2

			if var_510_14 <= arg_507_1.time_ and arg_507_1.time_ < var_510_14 + var_510_15 then
				local var_510_16 = (arg_507_1.time_ - var_510_14) / var_510_15
				local var_510_17 = Color.New(0, 0, 0)

				var_510_17.a = Mathf.Lerp(0, 1, var_510_16)
				arg_507_1.mask_.color = var_510_17
			end

			if arg_507_1.time_ >= var_510_14 + var_510_15 and arg_507_1.time_ < var_510_14 + var_510_15 + arg_510_0 then
				local var_510_18 = Color.New(0, 0, 0)

				var_510_18.a = 1
				arg_507_1.mask_.color = var_510_18
			end

			local var_510_19 = 2

			if var_510_19 < arg_507_1.time_ and arg_507_1.time_ <= var_510_19 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = false

				arg_507_1:SetGaussion(false)
			end

			local var_510_20 = 2

			if var_510_19 <= arg_507_1.time_ and arg_507_1.time_ < var_510_19 + var_510_20 then
				local var_510_21 = (arg_507_1.time_ - var_510_19) / var_510_20
				local var_510_22 = Color.New(0, 0, 0)

				var_510_22.a = Mathf.Lerp(1, 0, var_510_21)
				arg_507_1.mask_.color = var_510_22
			end

			if arg_507_1.time_ >= var_510_19 + var_510_20 and arg_507_1.time_ < var_510_19 + var_510_20 + arg_510_0 then
				local var_510_23 = Color.New(0, 0, 0)
				local var_510_24 = 0

				arg_507_1.mask_.enabled = false
				var_510_23.a = var_510_24
				arg_507_1.mask_.color = var_510_23
			end

			local var_510_25 = 4
			local var_510_26 = 1

			if var_510_25 < arg_507_1.time_ and arg_507_1.time_ <= var_510_25 + arg_510_0 then
				local var_510_27 = "play"
				local var_510_28 = "effect"

				arg_507_1:AudioAction(var_510_27, var_510_28, "se_story_17", "se_story_17_ringing", "")
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_29 = 4
			local var_510_30 = 1.425

			if var_510_29 < arg_507_1.time_ and arg_507_1.time_ <= var_510_29 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_31 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_31:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_32 = arg_507_1:GetWordFromCfg(117041123)
				local var_510_33 = arg_507_1:FormatText(var_510_32.content)

				arg_507_1.text_.text = var_510_33

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_34 = 57
				local var_510_35 = utf8.len(var_510_33)
				local var_510_36 = var_510_34 <= 0 and var_510_30 or var_510_30 * (var_510_35 / var_510_34)

				if var_510_36 > 0 and var_510_30 < var_510_36 then
					arg_507_1.talkMaxDuration = var_510_36
					var_510_29 = var_510_29 + 0.3

					if var_510_36 + var_510_29 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_36 + var_510_29
					end
				end

				arg_507_1.text_.text = var_510_33
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_37 = var_510_29 + 0.3
			local var_510_38 = math.max(var_510_30, arg_507_1.talkMaxDuration)

			if var_510_37 <= arg_507_1.time_ and arg_507_1.time_ < var_510_37 + var_510_38 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_37) / var_510_38

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_37 + var_510_38 and arg_507_1.time_ < var_510_37 + var_510_38 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play117041124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 117041124
		arg_513_1.duration_ = 5.2

		local var_513_0 = {
			zh = 5.2,
			ja = 2
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play117041125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1132"].transform
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.var_.moveOldPos1132 = var_516_0.localPosition
				var_516_0.localScale = Vector3.New(1, 1, 1)

				arg_513_1:CheckSpriteTmpPos("1132", 2)

				local var_516_2 = var_516_0.childCount

				for iter_516_0 = 0, var_516_2 - 1 do
					local var_516_3 = var_516_0:GetChild(iter_516_0)

					if var_516_3.name == "split_6" or not string.find(var_516_3.name, "split") then
						var_516_3.gameObject:SetActive(true)
					else
						var_516_3.gameObject:SetActive(false)
					end
				end
			end

			local var_516_4 = 0.001

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_4 then
				local var_516_5 = (arg_513_1.time_ - var_516_1) / var_516_4
				local var_516_6 = Vector3.New(-390, -413, -185)

				var_516_0.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1132, var_516_6, var_516_5)
			end

			if arg_513_1.time_ >= var_516_1 + var_516_4 and arg_513_1.time_ < var_516_1 + var_516_4 + arg_516_0 then
				var_516_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_516_7 = arg_513_1.actors_["10034"].transform
			local var_516_8 = 0

			if var_516_8 < arg_513_1.time_ and arg_513_1.time_ <= var_516_8 + arg_516_0 then
				arg_513_1.var_.moveOldPos10034 = var_516_7.localPosition
				var_516_7.localScale = Vector3.New(1, 1, 1)

				arg_513_1:CheckSpriteTmpPos("10034", 4)

				local var_516_9 = var_516_7.childCount

				for iter_516_1 = 0, var_516_9 - 1 do
					local var_516_10 = var_516_7:GetChild(iter_516_1)

					if var_516_10.name == "split_2" or not string.find(var_516_10.name, "split") then
						var_516_10.gameObject:SetActive(true)
					else
						var_516_10.gameObject:SetActive(false)
					end
				end
			end

			local var_516_11 = 0.001

			if var_516_8 <= arg_513_1.time_ and arg_513_1.time_ < var_516_8 + var_516_11 then
				local var_516_12 = (arg_513_1.time_ - var_516_8) / var_516_11
				local var_516_13 = Vector3.New(390, -415, -290)

				var_516_7.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos10034, var_516_13, var_516_12)
			end

			if arg_513_1.time_ >= var_516_8 + var_516_11 and arg_513_1.time_ < var_516_8 + var_516_11 + arg_516_0 then
				var_516_7.localPosition = Vector3.New(390, -415, -290)
			end

			local var_516_14 = arg_513_1.actors_["1132"]
			local var_516_15 = 0

			if var_516_15 < arg_513_1.time_ and arg_513_1.time_ <= var_516_15 + arg_516_0 and not isNil(var_516_14) and arg_513_1.var_.actorSpriteComps1132 == nil then
				arg_513_1.var_.actorSpriteComps1132 = var_516_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_16 = 0.2

			if var_516_15 <= arg_513_1.time_ and arg_513_1.time_ < var_516_15 + var_516_16 and not isNil(var_516_14) then
				local var_516_17 = (arg_513_1.time_ - var_516_15) / var_516_16

				if arg_513_1.var_.actorSpriteComps1132 then
					for iter_516_2, iter_516_3 in pairs(arg_513_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_516_3 then
							if arg_513_1.isInRecall_ then
								local var_516_18 = Mathf.Lerp(iter_516_3.color.r, arg_513_1.hightColor1.r, var_516_17)
								local var_516_19 = Mathf.Lerp(iter_516_3.color.g, arg_513_1.hightColor1.g, var_516_17)
								local var_516_20 = Mathf.Lerp(iter_516_3.color.b, arg_513_1.hightColor1.b, var_516_17)

								iter_516_3.color = Color.New(var_516_18, var_516_19, var_516_20)
							else
								local var_516_21 = Mathf.Lerp(iter_516_3.color.r, 1, var_516_17)

								iter_516_3.color = Color.New(var_516_21, var_516_21, var_516_21)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= var_516_15 + var_516_16 and arg_513_1.time_ < var_516_15 + var_516_16 + arg_516_0 and not isNil(var_516_14) and arg_513_1.var_.actorSpriteComps1132 then
				for iter_516_4, iter_516_5 in pairs(arg_513_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_516_5 then
						if arg_513_1.isInRecall_ then
							iter_516_5.color = arg_513_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_516_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_513_1.var_.actorSpriteComps1132 = nil
			end

			local var_516_22 = arg_513_1.actors_["10034"]
			local var_516_23 = 0

			if var_516_23 < arg_513_1.time_ and arg_513_1.time_ <= var_516_23 + arg_516_0 and not isNil(var_516_22) and arg_513_1.var_.actorSpriteComps10034 == nil then
				arg_513_1.var_.actorSpriteComps10034 = var_516_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_24 = 0.034

			if var_516_23 <= arg_513_1.time_ and arg_513_1.time_ < var_516_23 + var_516_24 and not isNil(var_516_22) then
				local var_516_25 = (arg_513_1.time_ - var_516_23) / var_516_24

				if arg_513_1.var_.actorSpriteComps10034 then
					for iter_516_6, iter_516_7 in pairs(arg_513_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_516_7 then
							if arg_513_1.isInRecall_ then
								local var_516_26 = Mathf.Lerp(iter_516_7.color.r, arg_513_1.hightColor2.r, var_516_25)
								local var_516_27 = Mathf.Lerp(iter_516_7.color.g, arg_513_1.hightColor2.g, var_516_25)
								local var_516_28 = Mathf.Lerp(iter_516_7.color.b, arg_513_1.hightColor2.b, var_516_25)

								iter_516_7.color = Color.New(var_516_26, var_516_27, var_516_28)
							else
								local var_516_29 = Mathf.Lerp(iter_516_7.color.r, 0.5, var_516_25)

								iter_516_7.color = Color.New(var_516_29, var_516_29, var_516_29)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= var_516_23 + var_516_24 and arg_513_1.time_ < var_516_23 + var_516_24 + arg_516_0 and not isNil(var_516_22) and arg_513_1.var_.actorSpriteComps10034 then
				for iter_516_8, iter_516_9 in pairs(arg_513_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_516_9 then
						if arg_513_1.isInRecall_ then
							iter_516_9.color = arg_513_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_516_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_513_1.var_.actorSpriteComps10034 = nil
			end

			local var_516_30 = 0
			local var_516_31 = 0.225

			if var_516_30 < arg_513_1.time_ and arg_513_1.time_ <= var_516_30 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_32 = arg_513_1:FormatText(StoryNameCfg[61].name)

				arg_513_1.leftNameTxt_.text = var_516_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_33 = arg_513_1:GetWordFromCfg(117041124)
				local var_516_34 = arg_513_1:FormatText(var_516_33.content)

				arg_513_1.text_.text = var_516_34

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_35 = 9
				local var_516_36 = utf8.len(var_516_34)
				local var_516_37 = var_516_35 <= 0 and var_516_31 or var_516_31 * (var_516_36 / var_516_35)

				if var_516_37 > 0 and var_516_31 < var_516_37 then
					arg_513_1.talkMaxDuration = var_516_37

					if var_516_37 + var_516_30 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_37 + var_516_30
					end
				end

				arg_513_1.text_.text = var_516_34
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041124", "story_v_out_117041.awb") ~= 0 then
					local var_516_38 = manager.audio:GetVoiceLength("story_v_out_117041", "117041124", "story_v_out_117041.awb") / 1000

					if var_516_38 + var_516_30 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_38 + var_516_30
					end

					if var_516_33.prefab_name ~= "" and arg_513_1.actors_[var_516_33.prefab_name] ~= nil then
						local var_516_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_33.prefab_name].transform, "story_v_out_117041", "117041124", "story_v_out_117041.awb")

						arg_513_1:RecordAudio("117041124", var_516_39)
						arg_513_1:RecordAudio("117041124", var_516_39)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_117041", "117041124", "story_v_out_117041.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_117041", "117041124", "story_v_out_117041.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_40 = math.max(var_516_31, arg_513_1.talkMaxDuration)

			if var_516_30 <= arg_513_1.time_ and arg_513_1.time_ < var_516_30 + var_516_40 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_30) / var_516_40

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_30 + var_516_40 and arg_513_1.time_ < var_516_30 + var_516_40 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_513_1:InitPlayNodeList()
	end,
	Play117041125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 117041125
		arg_517_1.duration_ = 3.33

		local var_517_0 = {
			zh = 2.133,
			ja = 3.333
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play117041126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["1132"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps1132 == nil then
				arg_517_1.var_.actorSpriteComps1132 = var_520_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_2 = 0.2

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.actorSpriteComps1132 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								local var_520_4 = Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor2.r, var_520_3)
								local var_520_5 = Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor2.g, var_520_3)
								local var_520_6 = Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor2.b, var_520_3)

								iter_520_1.color = Color.New(var_520_4, var_520_5, var_520_6)
							else
								local var_520_7 = Mathf.Lerp(iter_520_1.color.r, 0.5, var_520_3)

								iter_520_1.color = Color.New(var_520_7, var_520_7, var_520_7)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps1132 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_520_3 then
						if arg_517_1.isInRecall_ then
							iter_520_3.color = arg_517_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_520_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_517_1.var_.actorSpriteComps1132 = nil
			end

			local var_520_8 = arg_517_1.actors_["10034"]
			local var_520_9 = 0

			if var_520_9 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 and not isNil(var_520_8) and arg_517_1.var_.actorSpriteComps10034 == nil then
				arg_517_1.var_.actorSpriteComps10034 = var_520_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_10 = 0.2

			if var_520_9 <= arg_517_1.time_ and arg_517_1.time_ < var_520_9 + var_520_10 and not isNil(var_520_8) then
				local var_520_11 = (arg_517_1.time_ - var_520_9) / var_520_10

				if arg_517_1.var_.actorSpriteComps10034 then
					for iter_520_4, iter_520_5 in pairs(arg_517_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_520_5 then
							if arg_517_1.isInRecall_ then
								local var_520_12 = Mathf.Lerp(iter_520_5.color.r, arg_517_1.hightColor1.r, var_520_11)
								local var_520_13 = Mathf.Lerp(iter_520_5.color.g, arg_517_1.hightColor1.g, var_520_11)
								local var_520_14 = Mathf.Lerp(iter_520_5.color.b, arg_517_1.hightColor1.b, var_520_11)

								iter_520_5.color = Color.New(var_520_12, var_520_13, var_520_14)
							else
								local var_520_15 = Mathf.Lerp(iter_520_5.color.r, 1, var_520_11)

								iter_520_5.color = Color.New(var_520_15, var_520_15, var_520_15)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= var_520_9 + var_520_10 and arg_517_1.time_ < var_520_9 + var_520_10 + arg_520_0 and not isNil(var_520_8) and arg_517_1.var_.actorSpriteComps10034 then
				for iter_520_6, iter_520_7 in pairs(arg_517_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_520_7 then
						if arg_517_1.isInRecall_ then
							iter_520_7.color = arg_517_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_520_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_517_1.var_.actorSpriteComps10034 = nil
			end

			local var_520_16 = 0
			local var_520_17 = 0.2

			if var_520_16 < arg_517_1.time_ and arg_517_1.time_ <= var_520_16 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_18 = arg_517_1:FormatText(StoryNameCfg[367].name)

				arg_517_1.leftNameTxt_.text = var_520_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_19 = arg_517_1:GetWordFromCfg(117041125)
				local var_520_20 = arg_517_1:FormatText(var_520_19.content)

				arg_517_1.text_.text = var_520_20

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_21 = 8
				local var_520_22 = utf8.len(var_520_20)
				local var_520_23 = var_520_21 <= 0 and var_520_17 or var_520_17 * (var_520_22 / var_520_21)

				if var_520_23 > 0 and var_520_17 < var_520_23 then
					arg_517_1.talkMaxDuration = var_520_23

					if var_520_23 + var_520_16 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_23 + var_520_16
					end
				end

				arg_517_1.text_.text = var_520_20
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041125", "story_v_out_117041.awb") ~= 0 then
					local var_520_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041125", "story_v_out_117041.awb") / 1000

					if var_520_24 + var_520_16 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_24 + var_520_16
					end

					if var_520_19.prefab_name ~= "" and arg_517_1.actors_[var_520_19.prefab_name] ~= nil then
						local var_520_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_19.prefab_name].transform, "story_v_out_117041", "117041125", "story_v_out_117041.awb")

						arg_517_1:RecordAudio("117041125", var_520_25)
						arg_517_1:RecordAudio("117041125", var_520_25)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_117041", "117041125", "story_v_out_117041.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_117041", "117041125", "story_v_out_117041.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_26 = math.max(var_520_17, arg_517_1.talkMaxDuration)

			if var_520_16 <= arg_517_1.time_ and arg_517_1.time_ < var_520_16 + var_520_26 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_16) / var_520_26

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_16 + var_520_26 and arg_517_1.time_ < var_520_16 + var_520_26 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play117041126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 117041126
		arg_521_1.duration_ = 10.4

		local var_521_0 = {
			zh = 10.4,
			ja = 9
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play117041127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1132"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps1132 == nil then
				arg_521_1.var_.actorSpriteComps1132 = var_524_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.actorSpriteComps1132 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								local var_524_4 = Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor1.r, var_524_3)
								local var_524_5 = Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor1.g, var_524_3)
								local var_524_6 = Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor1.b, var_524_3)

								iter_524_1.color = Color.New(var_524_4, var_524_5, var_524_6)
							else
								local var_524_7 = Mathf.Lerp(iter_524_1.color.r, 1, var_524_3)

								iter_524_1.color = Color.New(var_524_7, var_524_7, var_524_7)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps1132 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_524_3 then
						if arg_521_1.isInRecall_ then
							iter_524_3.color = arg_521_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_524_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_521_1.var_.actorSpriteComps1132 = nil
			end

			local var_524_8 = arg_521_1.actors_["10034"]
			local var_524_9 = 0

			if var_524_9 < arg_521_1.time_ and arg_521_1.time_ <= var_524_9 + arg_524_0 and not isNil(var_524_8) and arg_521_1.var_.actorSpriteComps10034 == nil then
				arg_521_1.var_.actorSpriteComps10034 = var_524_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_10 = 0.2

			if var_524_9 <= arg_521_1.time_ and arg_521_1.time_ < var_524_9 + var_524_10 and not isNil(var_524_8) then
				local var_524_11 = (arg_521_1.time_ - var_524_9) / var_524_10

				if arg_521_1.var_.actorSpriteComps10034 then
					for iter_524_4, iter_524_5 in pairs(arg_521_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_524_5 then
							if arg_521_1.isInRecall_ then
								local var_524_12 = Mathf.Lerp(iter_524_5.color.r, arg_521_1.hightColor2.r, var_524_11)
								local var_524_13 = Mathf.Lerp(iter_524_5.color.g, arg_521_1.hightColor2.g, var_524_11)
								local var_524_14 = Mathf.Lerp(iter_524_5.color.b, arg_521_1.hightColor2.b, var_524_11)

								iter_524_5.color = Color.New(var_524_12, var_524_13, var_524_14)
							else
								local var_524_15 = Mathf.Lerp(iter_524_5.color.r, 0.5, var_524_11)

								iter_524_5.color = Color.New(var_524_15, var_524_15, var_524_15)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= var_524_9 + var_524_10 and arg_521_1.time_ < var_524_9 + var_524_10 + arg_524_0 and not isNil(var_524_8) and arg_521_1.var_.actorSpriteComps10034 then
				for iter_524_6, iter_524_7 in pairs(arg_521_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_524_7 then
						if arg_521_1.isInRecall_ then
							iter_524_7.color = arg_521_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_524_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_521_1.var_.actorSpriteComps10034 = nil
			end

			local var_524_16 = 0
			local var_524_17 = 1.025

			if var_524_16 < arg_521_1.time_ and arg_521_1.time_ <= var_524_16 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_18 = arg_521_1:FormatText(StoryNameCfg[61].name)

				arg_521_1.leftNameTxt_.text = var_524_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_19 = arg_521_1:GetWordFromCfg(117041126)
				local var_524_20 = arg_521_1:FormatText(var_524_19.content)

				arg_521_1.text_.text = var_524_20

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_21 = 41
				local var_524_22 = utf8.len(var_524_20)
				local var_524_23 = var_524_21 <= 0 and var_524_17 or var_524_17 * (var_524_22 / var_524_21)

				if var_524_23 > 0 and var_524_17 < var_524_23 then
					arg_521_1.talkMaxDuration = var_524_23

					if var_524_23 + var_524_16 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_23 + var_524_16
					end
				end

				arg_521_1.text_.text = var_524_20
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041126", "story_v_out_117041.awb") ~= 0 then
					local var_524_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041126", "story_v_out_117041.awb") / 1000

					if var_524_24 + var_524_16 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_24 + var_524_16
					end

					if var_524_19.prefab_name ~= "" and arg_521_1.actors_[var_524_19.prefab_name] ~= nil then
						local var_524_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_19.prefab_name].transform, "story_v_out_117041", "117041126", "story_v_out_117041.awb")

						arg_521_1:RecordAudio("117041126", var_524_25)
						arg_521_1:RecordAudio("117041126", var_524_25)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_117041", "117041126", "story_v_out_117041.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_117041", "117041126", "story_v_out_117041.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_26 = math.max(var_524_17, arg_521_1.talkMaxDuration)

			if var_524_16 <= arg_521_1.time_ and arg_521_1.time_ < var_524_16 + var_524_26 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_16) / var_524_26

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_16 + var_524_26 and arg_521_1.time_ < var_524_16 + var_524_26 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play117041127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 117041127
		arg_525_1.duration_ = 10.87

		local var_525_0 = {
			zh = 10.8,
			ja = 10.866
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play117041128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["10034"].transform
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.var_.moveOldPos10034 = var_528_0.localPosition
				var_528_0.localScale = Vector3.New(1, 1, 1)

				arg_525_1:CheckSpriteTmpPos("10034", 4)

				local var_528_2 = var_528_0.childCount

				for iter_528_0 = 0, var_528_2 - 1 do
					local var_528_3 = var_528_0:GetChild(iter_528_0)

					if var_528_3.name == "split_5" or not string.find(var_528_3.name, "split") then
						var_528_3.gameObject:SetActive(true)
					else
						var_528_3.gameObject:SetActive(false)
					end
				end
			end

			local var_528_4 = 0.001

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_4 then
				local var_528_5 = (arg_525_1.time_ - var_528_1) / var_528_4
				local var_528_6 = Vector3.New(390, -415, -290)

				var_528_0.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10034, var_528_6, var_528_5)
			end

			if arg_525_1.time_ >= var_528_1 + var_528_4 and arg_525_1.time_ < var_528_1 + var_528_4 + arg_528_0 then
				var_528_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_528_7 = arg_525_1.actors_["1132"]
			local var_528_8 = 0

			if var_528_8 < arg_525_1.time_ and arg_525_1.time_ <= var_528_8 + arg_528_0 and not isNil(var_528_7) and arg_525_1.var_.actorSpriteComps1132 == nil then
				arg_525_1.var_.actorSpriteComps1132 = var_528_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_9 = 0.2

			if var_528_8 <= arg_525_1.time_ and arg_525_1.time_ < var_528_8 + var_528_9 and not isNil(var_528_7) then
				local var_528_10 = (arg_525_1.time_ - var_528_8) / var_528_9

				if arg_525_1.var_.actorSpriteComps1132 then
					for iter_528_1, iter_528_2 in pairs(arg_525_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_528_2 then
							if arg_525_1.isInRecall_ then
								local var_528_11 = Mathf.Lerp(iter_528_2.color.r, arg_525_1.hightColor2.r, var_528_10)
								local var_528_12 = Mathf.Lerp(iter_528_2.color.g, arg_525_1.hightColor2.g, var_528_10)
								local var_528_13 = Mathf.Lerp(iter_528_2.color.b, arg_525_1.hightColor2.b, var_528_10)

								iter_528_2.color = Color.New(var_528_11, var_528_12, var_528_13)
							else
								local var_528_14 = Mathf.Lerp(iter_528_2.color.r, 0.5, var_528_10)

								iter_528_2.color = Color.New(var_528_14, var_528_14, var_528_14)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_8 + var_528_9 and arg_525_1.time_ < var_528_8 + var_528_9 + arg_528_0 and not isNil(var_528_7) and arg_525_1.var_.actorSpriteComps1132 then
				for iter_528_3, iter_528_4 in pairs(arg_525_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_528_4 then
						if arg_525_1.isInRecall_ then
							iter_528_4.color = arg_525_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_528_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps1132 = nil
			end

			local var_528_15 = arg_525_1.actors_["10034"]
			local var_528_16 = 0

			if var_528_16 < arg_525_1.time_ and arg_525_1.time_ <= var_528_16 + arg_528_0 and not isNil(var_528_15) and arg_525_1.var_.actorSpriteComps10034 == nil then
				arg_525_1.var_.actorSpriteComps10034 = var_528_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_17 = 0.2

			if var_528_16 <= arg_525_1.time_ and arg_525_1.time_ < var_528_16 + var_528_17 and not isNil(var_528_15) then
				local var_528_18 = (arg_525_1.time_ - var_528_16) / var_528_17

				if arg_525_1.var_.actorSpriteComps10034 then
					for iter_528_5, iter_528_6 in pairs(arg_525_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_528_6 then
							if arg_525_1.isInRecall_ then
								local var_528_19 = Mathf.Lerp(iter_528_6.color.r, arg_525_1.hightColor1.r, var_528_18)
								local var_528_20 = Mathf.Lerp(iter_528_6.color.g, arg_525_1.hightColor1.g, var_528_18)
								local var_528_21 = Mathf.Lerp(iter_528_6.color.b, arg_525_1.hightColor1.b, var_528_18)

								iter_528_6.color = Color.New(var_528_19, var_528_20, var_528_21)
							else
								local var_528_22 = Mathf.Lerp(iter_528_6.color.r, 1, var_528_18)

								iter_528_6.color = Color.New(var_528_22, var_528_22, var_528_22)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_16 + var_528_17 and arg_525_1.time_ < var_528_16 + var_528_17 + arg_528_0 and not isNil(var_528_15) and arg_525_1.var_.actorSpriteComps10034 then
				for iter_528_7, iter_528_8 in pairs(arg_525_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_528_8 then
						if arg_525_1.isInRecall_ then
							iter_528_8.color = arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_528_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps10034 = nil
			end

			local var_528_23 = 0
			local var_528_24 = 1.025

			if var_528_23 < arg_525_1.time_ and arg_525_1.time_ <= var_528_23 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_25 = arg_525_1:FormatText(StoryNameCfg[367].name)

				arg_525_1.leftNameTxt_.text = var_528_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_26 = arg_525_1:GetWordFromCfg(117041127)
				local var_528_27 = arg_525_1:FormatText(var_528_26.content)

				arg_525_1.text_.text = var_528_27

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_28 = 41
				local var_528_29 = utf8.len(var_528_27)
				local var_528_30 = var_528_28 <= 0 and var_528_24 or var_528_24 * (var_528_29 / var_528_28)

				if var_528_30 > 0 and var_528_24 < var_528_30 then
					arg_525_1.talkMaxDuration = var_528_30

					if var_528_30 + var_528_23 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_30 + var_528_23
					end
				end

				arg_525_1.text_.text = var_528_27
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041127", "story_v_out_117041.awb") ~= 0 then
					local var_528_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041127", "story_v_out_117041.awb") / 1000

					if var_528_31 + var_528_23 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_31 + var_528_23
					end

					if var_528_26.prefab_name ~= "" and arg_525_1.actors_[var_528_26.prefab_name] ~= nil then
						local var_528_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_26.prefab_name].transform, "story_v_out_117041", "117041127", "story_v_out_117041.awb")

						arg_525_1:RecordAudio("117041127", var_528_32)
						arg_525_1:RecordAudio("117041127", var_528_32)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_117041", "117041127", "story_v_out_117041.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_117041", "117041127", "story_v_out_117041.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_33 = math.max(var_528_24, arg_525_1.talkMaxDuration)

			if var_528_23 <= arg_525_1.time_ and arg_525_1.time_ < var_528_23 + var_528_33 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_23) / var_528_33

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_23 + var_528_33 and arg_525_1.time_ < var_528_23 + var_528_33 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
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

		arg_525_1:InitPlayNodeList()
	end,
	Play117041128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 117041128
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play117041129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["10034"].transform
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.var_.moveOldPos10034 = var_532_0.localPosition
				var_532_0.localScale = Vector3.New(1, 1, 1)

				arg_529_1:CheckSpriteTmpPos("10034", 4)

				local var_532_2 = var_532_0.childCount

				for iter_532_0 = 0, var_532_2 - 1 do
					local var_532_3 = var_532_0:GetChild(iter_532_0)

					if var_532_3.name == "split_2" or not string.find(var_532_3.name, "split") then
						var_532_3.gameObject:SetActive(true)
					else
						var_532_3.gameObject:SetActive(false)
					end
				end
			end

			local var_532_4 = 0.001

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_4 then
				local var_532_5 = (arg_529_1.time_ - var_532_1) / var_532_4
				local var_532_6 = Vector3.New(390, -415, -290)

				var_532_0.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10034, var_532_6, var_532_5)
			end

			if arg_529_1.time_ >= var_532_1 + var_532_4 and arg_529_1.time_ < var_532_1 + var_532_4 + arg_532_0 then
				var_532_0.localPosition = Vector3.New(390, -415, -290)
			end

			local var_532_7 = arg_529_1.actors_["10034"]
			local var_532_8 = 0

			if var_532_8 < arg_529_1.time_ and arg_529_1.time_ <= var_532_8 + arg_532_0 and not isNil(var_532_7) and arg_529_1.var_.actorSpriteComps10034 == nil then
				arg_529_1.var_.actorSpriteComps10034 = var_532_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_9 = 0.2

			if var_532_8 <= arg_529_1.time_ and arg_529_1.time_ < var_532_8 + var_532_9 and not isNil(var_532_7) then
				local var_532_10 = (arg_529_1.time_ - var_532_8) / var_532_9

				if arg_529_1.var_.actorSpriteComps10034 then
					for iter_532_1, iter_532_2 in pairs(arg_529_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_532_2 then
							if arg_529_1.isInRecall_ then
								local var_532_11 = Mathf.Lerp(iter_532_2.color.r, arg_529_1.hightColor2.r, var_532_10)
								local var_532_12 = Mathf.Lerp(iter_532_2.color.g, arg_529_1.hightColor2.g, var_532_10)
								local var_532_13 = Mathf.Lerp(iter_532_2.color.b, arg_529_1.hightColor2.b, var_532_10)

								iter_532_2.color = Color.New(var_532_11, var_532_12, var_532_13)
							else
								local var_532_14 = Mathf.Lerp(iter_532_2.color.r, 0.5, var_532_10)

								iter_532_2.color = Color.New(var_532_14, var_532_14, var_532_14)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= var_532_8 + var_532_9 and arg_529_1.time_ < var_532_8 + var_532_9 + arg_532_0 and not isNil(var_532_7) and arg_529_1.var_.actorSpriteComps10034 then
				for iter_532_3, iter_532_4 in pairs(arg_529_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_532_4 then
						if arg_529_1.isInRecall_ then
							iter_532_4.color = arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_532_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_529_1.var_.actorSpriteComps10034 = nil
			end

			local var_532_15 = 0
			local var_532_16 = 0.925

			if var_532_15 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_17 = arg_529_1:GetWordFromCfg(117041128)
				local var_532_18 = arg_529_1:FormatText(var_532_17.content)

				arg_529_1.text_.text = var_532_18

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_19 = 37
				local var_532_20 = utf8.len(var_532_18)
				local var_532_21 = var_532_19 <= 0 and var_532_16 or var_532_16 * (var_532_20 / var_532_19)

				if var_532_21 > 0 and var_532_16 < var_532_21 then
					arg_529_1.talkMaxDuration = var_532_21

					if var_532_21 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_21 + var_532_15
					end
				end

				arg_529_1.text_.text = var_532_18
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_22 = math.max(var_532_16, arg_529_1.talkMaxDuration)

			if var_532_15 <= arg_529_1.time_ and arg_529_1.time_ < var_532_15 + var_532_22 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_15) / var_532_22

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_15 + var_532_22 and arg_529_1.time_ < var_532_15 + var_532_22 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
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

		arg_529_1:InitPlayNodeList()
	end,
	Play117041129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 117041129
		arg_533_1.duration_ = 4.5

		local var_533_0 = {
			zh = 3.3,
			ja = 4.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play117041130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1132"].transform
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.var_.moveOldPos1132 = var_536_0.localPosition
				var_536_0.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("1132", 2)

				local var_536_2 = var_536_0.childCount

				for iter_536_0 = 0, var_536_2 - 1 do
					local var_536_3 = var_536_0:GetChild(iter_536_0)

					if var_536_3.name == "split_1" or not string.find(var_536_3.name, "split") then
						var_536_3.gameObject:SetActive(true)
					else
						var_536_3.gameObject:SetActive(false)
					end
				end
			end

			local var_536_4 = 0.001

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_4 then
				local var_536_5 = (arg_533_1.time_ - var_536_1) / var_536_4
				local var_536_6 = Vector3.New(-390, -413, -185)

				var_536_0.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1132, var_536_6, var_536_5)
			end

			if arg_533_1.time_ >= var_536_1 + var_536_4 and arg_533_1.time_ < var_536_1 + var_536_4 + arg_536_0 then
				var_536_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_536_7 = arg_533_1.actors_["1132"]
			local var_536_8 = 0

			if var_536_8 < arg_533_1.time_ and arg_533_1.time_ <= var_536_8 + arg_536_0 and not isNil(var_536_7) and arg_533_1.var_.actorSpriteComps1132 == nil then
				arg_533_1.var_.actorSpriteComps1132 = var_536_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_9 = 0.2

			if var_536_8 <= arg_533_1.time_ and arg_533_1.time_ < var_536_8 + var_536_9 and not isNil(var_536_7) then
				local var_536_10 = (arg_533_1.time_ - var_536_8) / var_536_9

				if arg_533_1.var_.actorSpriteComps1132 then
					for iter_536_1, iter_536_2 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_536_2 then
							if arg_533_1.isInRecall_ then
								local var_536_11 = Mathf.Lerp(iter_536_2.color.r, arg_533_1.hightColor1.r, var_536_10)
								local var_536_12 = Mathf.Lerp(iter_536_2.color.g, arg_533_1.hightColor1.g, var_536_10)
								local var_536_13 = Mathf.Lerp(iter_536_2.color.b, arg_533_1.hightColor1.b, var_536_10)

								iter_536_2.color = Color.New(var_536_11, var_536_12, var_536_13)
							else
								local var_536_14 = Mathf.Lerp(iter_536_2.color.r, 1, var_536_10)

								iter_536_2.color = Color.New(var_536_14, var_536_14, var_536_14)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= var_536_8 + var_536_9 and arg_533_1.time_ < var_536_8 + var_536_9 + arg_536_0 and not isNil(var_536_7) and arg_533_1.var_.actorSpriteComps1132 then
				for iter_536_3, iter_536_4 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_536_4 then
						if arg_533_1.isInRecall_ then
							iter_536_4.color = arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_536_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_533_1.var_.actorSpriteComps1132 = nil
			end

			local var_536_15 = arg_533_1.actors_["1132"]
			local var_536_16 = 0

			if var_536_16 < arg_533_1.time_ and arg_533_1.time_ <= var_536_16 + arg_536_0 and not isNil(var_536_15) and arg_533_1.var_.actorSpriteComps1132 == nil then
				arg_533_1.var_.actorSpriteComps1132 = var_536_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_17 = 0.2

			if var_536_16 <= arg_533_1.time_ and arg_533_1.time_ < var_536_16 + var_536_17 and not isNil(var_536_15) then
				local var_536_18 = (arg_533_1.time_ - var_536_16) / var_536_17

				if arg_533_1.var_.actorSpriteComps1132 then
					for iter_536_5, iter_536_6 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_536_6 then
							if arg_533_1.isInRecall_ then
								local var_536_19 = Mathf.Lerp(iter_536_6.color.r, arg_533_1.hightColor1.r, var_536_18)
								local var_536_20 = Mathf.Lerp(iter_536_6.color.g, arg_533_1.hightColor1.g, var_536_18)
								local var_536_21 = Mathf.Lerp(iter_536_6.color.b, arg_533_1.hightColor1.b, var_536_18)

								iter_536_6.color = Color.New(var_536_19, var_536_20, var_536_21)
							else
								local var_536_22 = Mathf.Lerp(iter_536_6.color.r, 1, var_536_18)

								iter_536_6.color = Color.New(var_536_22, var_536_22, var_536_22)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= var_536_16 + var_536_17 and arg_533_1.time_ < var_536_16 + var_536_17 + arg_536_0 and not isNil(var_536_15) and arg_533_1.var_.actorSpriteComps1132 then
				for iter_536_7, iter_536_8 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_536_8 then
						if arg_533_1.isInRecall_ then
							iter_536_8.color = arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_536_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_533_1.var_.actorSpriteComps1132 = nil
			end

			local var_536_23 = 0
			local var_536_24 = 0.325

			if var_536_23 < arg_533_1.time_ and arg_533_1.time_ <= var_536_23 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_25 = arg_533_1:FormatText(StoryNameCfg[61].name)

				arg_533_1.leftNameTxt_.text = var_536_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_26 = arg_533_1:GetWordFromCfg(117041129)
				local var_536_27 = arg_533_1:FormatText(var_536_26.content)

				arg_533_1.text_.text = var_536_27

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_28 = 13
				local var_536_29 = utf8.len(var_536_27)
				local var_536_30 = var_536_28 <= 0 and var_536_24 or var_536_24 * (var_536_29 / var_536_28)

				if var_536_30 > 0 and var_536_24 < var_536_30 then
					arg_533_1.talkMaxDuration = var_536_30

					if var_536_30 + var_536_23 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_30 + var_536_23
					end
				end

				arg_533_1.text_.text = var_536_27
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041129", "story_v_out_117041.awb") ~= 0 then
					local var_536_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041129", "story_v_out_117041.awb") / 1000

					if var_536_31 + var_536_23 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_31 + var_536_23
					end

					if var_536_26.prefab_name ~= "" and arg_533_1.actors_[var_536_26.prefab_name] ~= nil then
						local var_536_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_26.prefab_name].transform, "story_v_out_117041", "117041129", "story_v_out_117041.awb")

						arg_533_1:RecordAudio("117041129", var_536_32)
						arg_533_1:RecordAudio("117041129", var_536_32)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_117041", "117041129", "story_v_out_117041.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_117041", "117041129", "story_v_out_117041.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_33 = math.max(var_536_24, arg_533_1.talkMaxDuration)

			if var_536_23 <= arg_533_1.time_ and arg_533_1.time_ < var_536_23 + var_536_33 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_23) / var_536_33

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_23 + var_536_33 and arg_533_1.time_ < var_536_23 + var_536_33 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
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

		arg_533_1:InitPlayNodeList()
	end,
	Play117041130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 117041130
		arg_537_1.duration_ = 5.07

		local var_537_0 = {
			zh = 4.066,
			ja = 5.066
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play117041131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1132"].transform
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.var_.moveOldPos1132 = var_540_0.localPosition
				var_540_0.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("1132", 2)

				local var_540_2 = var_540_0.childCount

				for iter_540_0 = 0, var_540_2 - 1 do
					local var_540_3 = var_540_0:GetChild(iter_540_0)

					if var_540_3.name == "split_6" or not string.find(var_540_3.name, "split") then
						var_540_3.gameObject:SetActive(true)
					else
						var_540_3.gameObject:SetActive(false)
					end
				end
			end

			local var_540_4 = 0.001

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_4 then
				local var_540_5 = (arg_537_1.time_ - var_540_1) / var_540_4
				local var_540_6 = Vector3.New(-390, -413, -185)

				var_540_0.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1132, var_540_6, var_540_5)
			end

			if arg_537_1.time_ >= var_540_1 + var_540_4 and arg_537_1.time_ < var_540_1 + var_540_4 + arg_540_0 then
				var_540_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_540_7 = 0
			local var_540_8 = 0.375

			if var_540_7 < arg_537_1.time_ and arg_537_1.time_ <= var_540_7 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_9 = arg_537_1:FormatText(StoryNameCfg[61].name)

				arg_537_1.leftNameTxt_.text = var_540_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_10 = arg_537_1:GetWordFromCfg(117041130)
				local var_540_11 = arg_537_1:FormatText(var_540_10.content)

				arg_537_1.text_.text = var_540_11

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_12 = 15
				local var_540_13 = utf8.len(var_540_11)
				local var_540_14 = var_540_12 <= 0 and var_540_8 or var_540_8 * (var_540_13 / var_540_12)

				if var_540_14 > 0 and var_540_8 < var_540_14 then
					arg_537_1.talkMaxDuration = var_540_14

					if var_540_14 + var_540_7 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_14 + var_540_7
					end
				end

				arg_537_1.text_.text = var_540_11
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041130", "story_v_out_117041.awb") ~= 0 then
					local var_540_15 = manager.audio:GetVoiceLength("story_v_out_117041", "117041130", "story_v_out_117041.awb") / 1000

					if var_540_15 + var_540_7 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_15 + var_540_7
					end

					if var_540_10.prefab_name ~= "" and arg_537_1.actors_[var_540_10.prefab_name] ~= nil then
						local var_540_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_10.prefab_name].transform, "story_v_out_117041", "117041130", "story_v_out_117041.awb")

						arg_537_1:RecordAudio("117041130", var_540_16)
						arg_537_1:RecordAudio("117041130", var_540_16)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_117041", "117041130", "story_v_out_117041.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_117041", "117041130", "story_v_out_117041.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_17 = math.max(var_540_8, arg_537_1.talkMaxDuration)

			if var_540_7 <= arg_537_1.time_ and arg_537_1.time_ < var_540_7 + var_540_17 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_7) / var_540_17

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_7 + var_540_17 and arg_537_1.time_ < var_540_7 + var_540_17 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play117041131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 117041131
		arg_541_1.duration_ = 6.63

		local var_541_0 = {
			zh = 6.633,
			ja = 5.3
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play117041132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1132"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps1132 == nil then
				arg_541_1.var_.actorSpriteComps1132 = var_544_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.actorSpriteComps1132 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								local var_544_4 = Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, var_544_3)
								local var_544_5 = Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, var_544_3)
								local var_544_6 = Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, var_544_3)

								iter_544_1.color = Color.New(var_544_4, var_544_5, var_544_6)
							else
								local var_544_7 = Mathf.Lerp(iter_544_1.color.r, 0.5, var_544_3)

								iter_544_1.color = Color.New(var_544_7, var_544_7, var_544_7)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps1132 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_544_3 then
						if arg_541_1.isInRecall_ then
							iter_544_3.color = arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_544_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps1132 = nil
			end

			local var_544_8 = arg_541_1.actors_["10034"]
			local var_544_9 = 0

			if var_544_9 < arg_541_1.time_ and arg_541_1.time_ <= var_544_9 + arg_544_0 and not isNil(var_544_8) and arg_541_1.var_.actorSpriteComps10034 == nil then
				arg_541_1.var_.actorSpriteComps10034 = var_544_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_10 = 0.2

			if var_544_9 <= arg_541_1.time_ and arg_541_1.time_ < var_544_9 + var_544_10 and not isNil(var_544_8) then
				local var_544_11 = (arg_541_1.time_ - var_544_9) / var_544_10

				if arg_541_1.var_.actorSpriteComps10034 then
					for iter_544_4, iter_544_5 in pairs(arg_541_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_544_5 then
							if arg_541_1.isInRecall_ then
								local var_544_12 = Mathf.Lerp(iter_544_5.color.r, arg_541_1.hightColor1.r, var_544_11)
								local var_544_13 = Mathf.Lerp(iter_544_5.color.g, arg_541_1.hightColor1.g, var_544_11)
								local var_544_14 = Mathf.Lerp(iter_544_5.color.b, arg_541_1.hightColor1.b, var_544_11)

								iter_544_5.color = Color.New(var_544_12, var_544_13, var_544_14)
							else
								local var_544_15 = Mathf.Lerp(iter_544_5.color.r, 1, var_544_11)

								iter_544_5.color = Color.New(var_544_15, var_544_15, var_544_15)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_9 + var_544_10 and arg_541_1.time_ < var_544_9 + var_544_10 + arg_544_0 and not isNil(var_544_8) and arg_541_1.var_.actorSpriteComps10034 then
				for iter_544_6, iter_544_7 in pairs(arg_541_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_544_7 then
						if arg_541_1.isInRecall_ then
							iter_544_7.color = arg_541_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_544_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps10034 = nil
			end

			local var_544_16 = arg_541_1.actors_["10034"].transform
			local var_544_17 = 0

			if var_544_17 < arg_541_1.time_ and arg_541_1.time_ <= var_544_17 + arg_544_0 then
				arg_541_1.var_.moveOldPos10034 = var_544_16.localPosition
				var_544_16.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10034", 4)

				local var_544_18 = var_544_16.childCount

				for iter_544_8 = 0, var_544_18 - 1 do
					local var_544_19 = var_544_16:GetChild(iter_544_8)

					if var_544_19.name == "split_2" or not string.find(var_544_19.name, "split") then
						var_544_19.gameObject:SetActive(true)
					else
						var_544_19.gameObject:SetActive(false)
					end
				end
			end

			local var_544_20 = 0.001

			if var_544_17 <= arg_541_1.time_ and arg_541_1.time_ < var_544_17 + var_544_20 then
				local var_544_21 = (arg_541_1.time_ - var_544_17) / var_544_20
				local var_544_22 = Vector3.New(390, -415, -290)

				var_544_16.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10034, var_544_22, var_544_21)
			end

			if arg_541_1.time_ >= var_544_17 + var_544_20 and arg_541_1.time_ < var_544_17 + var_544_20 + arg_544_0 then
				var_544_16.localPosition = Vector3.New(390, -415, -290)
			end

			local var_544_23 = 0
			local var_544_24 = 0.65

			if var_544_23 < arg_541_1.time_ and arg_541_1.time_ <= var_544_23 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_25 = arg_541_1:FormatText(StoryNameCfg[367].name)

				arg_541_1.leftNameTxt_.text = var_544_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_26 = arg_541_1:GetWordFromCfg(117041131)
				local var_544_27 = arg_541_1:FormatText(var_544_26.content)

				arg_541_1.text_.text = var_544_27

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_28 = 26
				local var_544_29 = utf8.len(var_544_27)
				local var_544_30 = var_544_28 <= 0 and var_544_24 or var_544_24 * (var_544_29 / var_544_28)

				if var_544_30 > 0 and var_544_24 < var_544_30 then
					arg_541_1.talkMaxDuration = var_544_30

					if var_544_30 + var_544_23 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_30 + var_544_23
					end
				end

				arg_541_1.text_.text = var_544_27
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041131", "story_v_out_117041.awb") ~= 0 then
					local var_544_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041131", "story_v_out_117041.awb") / 1000

					if var_544_31 + var_544_23 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_31 + var_544_23
					end

					if var_544_26.prefab_name ~= "" and arg_541_1.actors_[var_544_26.prefab_name] ~= nil then
						local var_544_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_26.prefab_name].transform, "story_v_out_117041", "117041131", "story_v_out_117041.awb")

						arg_541_1:RecordAudio("117041131", var_544_32)
						arg_541_1:RecordAudio("117041131", var_544_32)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_117041", "117041131", "story_v_out_117041.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_117041", "117041131", "story_v_out_117041.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_33 = math.max(var_544_24, arg_541_1.talkMaxDuration)

			if var_544_23 <= arg_541_1.time_ and arg_541_1.time_ < var_544_23 + var_544_33 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_23) / var_544_33

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_23 + var_544_33 and arg_541_1.time_ < var_544_23 + var_544_33 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
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

		arg_541_1:InitPlayNodeList()
	end,
	Play117041132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 117041132
		arg_545_1.duration_ = 13.2

		local var_545_0 = {
			zh = 10.6,
			ja = 13.2
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play117041133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 1.15

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[367].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_3 = arg_545_1:GetWordFromCfg(117041132)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 46
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041132", "story_v_out_117041.awb") ~= 0 then
					local var_548_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041132", "story_v_out_117041.awb") / 1000

					if var_548_8 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_8 + var_548_0
					end

					if var_548_3.prefab_name ~= "" and arg_545_1.actors_[var_548_3.prefab_name] ~= nil then
						local var_548_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_3.prefab_name].transform, "story_v_out_117041", "117041132", "story_v_out_117041.awb")

						arg_545_1:RecordAudio("117041132", var_548_9)
						arg_545_1:RecordAudio("117041132", var_548_9)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_117041", "117041132", "story_v_out_117041.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_117041", "117041132", "story_v_out_117041.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_10 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_10 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_10

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_10 and arg_545_1.time_ < var_548_0 + var_548_10 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play117041133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 117041133
		arg_549_1.duration_ = 5.83

		local var_549_0 = {
			zh = 5.833,
			ja = 4.933
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play117041134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["1132"].transform
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.var_.moveOldPos1132 = var_552_0.localPosition
				var_552_0.localScale = Vector3.New(1, 1, 1)

				arg_549_1:CheckSpriteTmpPos("1132", 2)

				local var_552_2 = var_552_0.childCount

				for iter_552_0 = 0, var_552_2 - 1 do
					local var_552_3 = var_552_0:GetChild(iter_552_0)

					if var_552_3.name == "split_2" or not string.find(var_552_3.name, "split") then
						var_552_3.gameObject:SetActive(true)
					else
						var_552_3.gameObject:SetActive(false)
					end
				end
			end

			local var_552_4 = 0.001

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_4 then
				local var_552_5 = (arg_549_1.time_ - var_552_1) / var_552_4
				local var_552_6 = Vector3.New(-390, -413, -185)

				var_552_0.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1132, var_552_6, var_552_5)
			end

			if arg_549_1.time_ >= var_552_1 + var_552_4 and arg_549_1.time_ < var_552_1 + var_552_4 + arg_552_0 then
				var_552_0.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_552_7 = arg_549_1.actors_["1132"]
			local var_552_8 = 0

			if var_552_8 < arg_549_1.time_ and arg_549_1.time_ <= var_552_8 + arg_552_0 and not isNil(var_552_7) and arg_549_1.var_.actorSpriteComps1132 == nil then
				arg_549_1.var_.actorSpriteComps1132 = var_552_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_9 = 0.2

			if var_552_8 <= arg_549_1.time_ and arg_549_1.time_ < var_552_8 + var_552_9 and not isNil(var_552_7) then
				local var_552_10 = (arg_549_1.time_ - var_552_8) / var_552_9

				if arg_549_1.var_.actorSpriteComps1132 then
					for iter_552_1, iter_552_2 in pairs(arg_549_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_552_2 then
							if arg_549_1.isInRecall_ then
								local var_552_11 = Mathf.Lerp(iter_552_2.color.r, arg_549_1.hightColor1.r, var_552_10)
								local var_552_12 = Mathf.Lerp(iter_552_2.color.g, arg_549_1.hightColor1.g, var_552_10)
								local var_552_13 = Mathf.Lerp(iter_552_2.color.b, arg_549_1.hightColor1.b, var_552_10)

								iter_552_2.color = Color.New(var_552_11, var_552_12, var_552_13)
							else
								local var_552_14 = Mathf.Lerp(iter_552_2.color.r, 1, var_552_10)

								iter_552_2.color = Color.New(var_552_14, var_552_14, var_552_14)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= var_552_8 + var_552_9 and arg_549_1.time_ < var_552_8 + var_552_9 + arg_552_0 and not isNil(var_552_7) and arg_549_1.var_.actorSpriteComps1132 then
				for iter_552_3, iter_552_4 in pairs(arg_549_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_552_4 then
						if arg_549_1.isInRecall_ then
							iter_552_4.color = arg_549_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_552_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_549_1.var_.actorSpriteComps1132 = nil
			end

			local var_552_15 = arg_549_1.actors_["10034"]
			local var_552_16 = 0

			if var_552_16 < arg_549_1.time_ and arg_549_1.time_ <= var_552_16 + arg_552_0 and not isNil(var_552_15) and arg_549_1.var_.actorSpriteComps10034 == nil then
				arg_549_1.var_.actorSpriteComps10034 = var_552_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_17 = 0.2

			if var_552_16 <= arg_549_1.time_ and arg_549_1.time_ < var_552_16 + var_552_17 and not isNil(var_552_15) then
				local var_552_18 = (arg_549_1.time_ - var_552_16) / var_552_17

				if arg_549_1.var_.actorSpriteComps10034 then
					for iter_552_5, iter_552_6 in pairs(arg_549_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_552_6 then
							if arg_549_1.isInRecall_ then
								local var_552_19 = Mathf.Lerp(iter_552_6.color.r, arg_549_1.hightColor2.r, var_552_18)
								local var_552_20 = Mathf.Lerp(iter_552_6.color.g, arg_549_1.hightColor2.g, var_552_18)
								local var_552_21 = Mathf.Lerp(iter_552_6.color.b, arg_549_1.hightColor2.b, var_552_18)

								iter_552_6.color = Color.New(var_552_19, var_552_20, var_552_21)
							else
								local var_552_22 = Mathf.Lerp(iter_552_6.color.r, 0.5, var_552_18)

								iter_552_6.color = Color.New(var_552_22, var_552_22, var_552_22)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= var_552_16 + var_552_17 and arg_549_1.time_ < var_552_16 + var_552_17 + arg_552_0 and not isNil(var_552_15) and arg_549_1.var_.actorSpriteComps10034 then
				for iter_552_7, iter_552_8 in pairs(arg_549_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_552_8 then
						if arg_549_1.isInRecall_ then
							iter_552_8.color = arg_549_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_552_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_549_1.var_.actorSpriteComps10034 = nil
			end

			local var_552_23 = 0
			local var_552_24 = 0.525

			if var_552_23 < arg_549_1.time_ and arg_549_1.time_ <= var_552_23 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_25 = arg_549_1:FormatText(StoryNameCfg[61].name)

				arg_549_1.leftNameTxt_.text = var_552_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_26 = arg_549_1:GetWordFromCfg(117041133)
				local var_552_27 = arg_549_1:FormatText(var_552_26.content)

				arg_549_1.text_.text = var_552_27

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_28 = 21
				local var_552_29 = utf8.len(var_552_27)
				local var_552_30 = var_552_28 <= 0 and var_552_24 or var_552_24 * (var_552_29 / var_552_28)

				if var_552_30 > 0 and var_552_24 < var_552_30 then
					arg_549_1.talkMaxDuration = var_552_30

					if var_552_30 + var_552_23 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_30 + var_552_23
					end
				end

				arg_549_1.text_.text = var_552_27
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041133", "story_v_out_117041.awb") ~= 0 then
					local var_552_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041133", "story_v_out_117041.awb") / 1000

					if var_552_31 + var_552_23 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_31 + var_552_23
					end

					if var_552_26.prefab_name ~= "" and arg_549_1.actors_[var_552_26.prefab_name] ~= nil then
						local var_552_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_26.prefab_name].transform, "story_v_out_117041", "117041133", "story_v_out_117041.awb")

						arg_549_1:RecordAudio("117041133", var_552_32)
						arg_549_1:RecordAudio("117041133", var_552_32)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_117041", "117041133", "story_v_out_117041.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_117041", "117041133", "story_v_out_117041.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_33 = math.max(var_552_24, arg_549_1.talkMaxDuration)

			if var_552_23 <= arg_549_1.time_ and arg_549_1.time_ < var_552_23 + var_552_33 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_23) / var_552_33

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_23 + var_552_33 and arg_549_1.time_ < var_552_23 + var_552_33 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
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

		arg_549_1:InitPlayNodeList()
	end,
	Play117041134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 117041134
		arg_553_1.duration_ = 3.33

		local var_553_0 = {
			zh = 3.333,
			ja = 2.6
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play117041135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1132"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps1132 == nil then
				arg_553_1.var_.actorSpriteComps1132 = var_556_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.actorSpriteComps1132 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								local var_556_4 = Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor2.r, var_556_3)
								local var_556_5 = Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor2.g, var_556_3)
								local var_556_6 = Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor2.b, var_556_3)

								iter_556_1.color = Color.New(var_556_4, var_556_5, var_556_6)
							else
								local var_556_7 = Mathf.Lerp(iter_556_1.color.r, 0.5, var_556_3)

								iter_556_1.color = Color.New(var_556_7, var_556_7, var_556_7)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps1132 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_556_3 then
						if arg_553_1.isInRecall_ then
							iter_556_3.color = arg_553_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_556_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps1132 = nil
			end

			local var_556_8 = arg_553_1.actors_["10034"]
			local var_556_9 = 0

			if var_556_9 < arg_553_1.time_ and arg_553_1.time_ <= var_556_9 + arg_556_0 and not isNil(var_556_8) and arg_553_1.var_.actorSpriteComps10034 == nil then
				arg_553_1.var_.actorSpriteComps10034 = var_556_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_10 = 0.2

			if var_556_9 <= arg_553_1.time_ and arg_553_1.time_ < var_556_9 + var_556_10 and not isNil(var_556_8) then
				local var_556_11 = (arg_553_1.time_ - var_556_9) / var_556_10

				if arg_553_1.var_.actorSpriteComps10034 then
					for iter_556_4, iter_556_5 in pairs(arg_553_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_556_5 then
							if arg_553_1.isInRecall_ then
								local var_556_12 = Mathf.Lerp(iter_556_5.color.r, arg_553_1.hightColor1.r, var_556_11)
								local var_556_13 = Mathf.Lerp(iter_556_5.color.g, arg_553_1.hightColor1.g, var_556_11)
								local var_556_14 = Mathf.Lerp(iter_556_5.color.b, arg_553_1.hightColor1.b, var_556_11)

								iter_556_5.color = Color.New(var_556_12, var_556_13, var_556_14)
							else
								local var_556_15 = Mathf.Lerp(iter_556_5.color.r, 1, var_556_11)

								iter_556_5.color = Color.New(var_556_15, var_556_15, var_556_15)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_9 + var_556_10 and arg_553_1.time_ < var_556_9 + var_556_10 + arg_556_0 and not isNil(var_556_8) and arg_553_1.var_.actorSpriteComps10034 then
				for iter_556_6, iter_556_7 in pairs(arg_553_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_556_7 then
						if arg_553_1.isInRecall_ then
							iter_556_7.color = arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_556_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps10034 = nil
			end

			local var_556_16 = 0
			local var_556_17 = 0.225

			if var_556_16 < arg_553_1.time_ and arg_553_1.time_ <= var_556_16 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_18 = arg_553_1:FormatText(StoryNameCfg[367].name)

				arg_553_1.leftNameTxt_.text = var_556_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_19 = arg_553_1:GetWordFromCfg(117041134)
				local var_556_20 = arg_553_1:FormatText(var_556_19.content)

				arg_553_1.text_.text = var_556_20

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_21 = 9
				local var_556_22 = utf8.len(var_556_20)
				local var_556_23 = var_556_21 <= 0 and var_556_17 or var_556_17 * (var_556_22 / var_556_21)

				if var_556_23 > 0 and var_556_17 < var_556_23 then
					arg_553_1.talkMaxDuration = var_556_23

					if var_556_23 + var_556_16 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_23 + var_556_16
					end
				end

				arg_553_1.text_.text = var_556_20
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041134", "story_v_out_117041.awb") ~= 0 then
					local var_556_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041134", "story_v_out_117041.awb") / 1000

					if var_556_24 + var_556_16 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_24 + var_556_16
					end

					if var_556_19.prefab_name ~= "" and arg_553_1.actors_[var_556_19.prefab_name] ~= nil then
						local var_556_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_19.prefab_name].transform, "story_v_out_117041", "117041134", "story_v_out_117041.awb")

						arg_553_1:RecordAudio("117041134", var_556_25)
						arg_553_1:RecordAudio("117041134", var_556_25)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_117041", "117041134", "story_v_out_117041.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_117041", "117041134", "story_v_out_117041.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_26 = math.max(var_556_17, arg_553_1.talkMaxDuration)

			if var_556_16 <= arg_553_1.time_ and arg_553_1.time_ < var_556_16 + var_556_26 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_16) / var_556_26

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_16 + var_556_26 and arg_553_1.time_ < var_556_16 + var_556_26 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play117041135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 117041135
		arg_557_1.duration_ = 1.63

		local var_557_0 = {
			zh = 1.133,
			ja = 1.633
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play117041136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1132"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps1132 == nil then
				arg_557_1.var_.actorSpriteComps1132 = var_560_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.actorSpriteComps1132 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								local var_560_4 = Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor1.r, var_560_3)
								local var_560_5 = Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor1.g, var_560_3)
								local var_560_6 = Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor1.b, var_560_3)

								iter_560_1.color = Color.New(var_560_4, var_560_5, var_560_6)
							else
								local var_560_7 = Mathf.Lerp(iter_560_1.color.r, 1, var_560_3)

								iter_560_1.color = Color.New(var_560_7, var_560_7, var_560_7)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.actorSpriteComps1132 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_560_3 then
						if arg_557_1.isInRecall_ then
							iter_560_3.color = arg_557_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_560_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_557_1.var_.actorSpriteComps1132 = nil
			end

			local var_560_8 = arg_557_1.actors_["10034"]
			local var_560_9 = 0

			if var_560_9 < arg_557_1.time_ and arg_557_1.time_ <= var_560_9 + arg_560_0 and not isNil(var_560_8) and arg_557_1.var_.actorSpriteComps10034 == nil then
				arg_557_1.var_.actorSpriteComps10034 = var_560_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_10 = 0.2

			if var_560_9 <= arg_557_1.time_ and arg_557_1.time_ < var_560_9 + var_560_10 and not isNil(var_560_8) then
				local var_560_11 = (arg_557_1.time_ - var_560_9) / var_560_10

				if arg_557_1.var_.actorSpriteComps10034 then
					for iter_560_4, iter_560_5 in pairs(arg_557_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_560_5 then
							if arg_557_1.isInRecall_ then
								local var_560_12 = Mathf.Lerp(iter_560_5.color.r, arg_557_1.hightColor2.r, var_560_11)
								local var_560_13 = Mathf.Lerp(iter_560_5.color.g, arg_557_1.hightColor2.g, var_560_11)
								local var_560_14 = Mathf.Lerp(iter_560_5.color.b, arg_557_1.hightColor2.b, var_560_11)

								iter_560_5.color = Color.New(var_560_12, var_560_13, var_560_14)
							else
								local var_560_15 = Mathf.Lerp(iter_560_5.color.r, 0.5, var_560_11)

								iter_560_5.color = Color.New(var_560_15, var_560_15, var_560_15)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= var_560_9 + var_560_10 and arg_557_1.time_ < var_560_9 + var_560_10 + arg_560_0 and not isNil(var_560_8) and arg_557_1.var_.actorSpriteComps10034 then
				for iter_560_6, iter_560_7 in pairs(arg_557_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_560_7 then
						if arg_557_1.isInRecall_ then
							iter_560_7.color = arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_560_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_557_1.var_.actorSpriteComps10034 = nil
			end

			local var_560_16 = 0
			local var_560_17 = 0.125

			if var_560_16 < arg_557_1.time_ and arg_557_1.time_ <= var_560_16 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_18 = arg_557_1:FormatText(StoryNameCfg[61].name)

				arg_557_1.leftNameTxt_.text = var_560_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_19 = arg_557_1:GetWordFromCfg(117041135)
				local var_560_20 = arg_557_1:FormatText(var_560_19.content)

				arg_557_1.text_.text = var_560_20

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_21 = 5
				local var_560_22 = utf8.len(var_560_20)
				local var_560_23 = var_560_21 <= 0 and var_560_17 or var_560_17 * (var_560_22 / var_560_21)

				if var_560_23 > 0 and var_560_17 < var_560_23 then
					arg_557_1.talkMaxDuration = var_560_23

					if var_560_23 + var_560_16 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_23 + var_560_16
					end
				end

				arg_557_1.text_.text = var_560_20
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041135", "story_v_out_117041.awb") ~= 0 then
					local var_560_24 = manager.audio:GetVoiceLength("story_v_out_117041", "117041135", "story_v_out_117041.awb") / 1000

					if var_560_24 + var_560_16 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_24 + var_560_16
					end

					if var_560_19.prefab_name ~= "" and arg_557_1.actors_[var_560_19.prefab_name] ~= nil then
						local var_560_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_19.prefab_name].transform, "story_v_out_117041", "117041135", "story_v_out_117041.awb")

						arg_557_1:RecordAudio("117041135", var_560_25)
						arg_557_1:RecordAudio("117041135", var_560_25)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_117041", "117041135", "story_v_out_117041.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_117041", "117041135", "story_v_out_117041.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_26 = math.max(var_560_17, arg_557_1.talkMaxDuration)

			if var_560_16 <= arg_557_1.time_ and arg_557_1.time_ < var_560_16 + var_560_26 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_16) / var_560_26

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_16 + var_560_26 and arg_557_1.time_ < var_560_16 + var_560_26 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play117041136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 117041136
		arg_561_1.duration_ = 5.17

		local var_561_0 = {
			zh = 5,
			ja = 5.166
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play117041137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1132"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps1132 == nil then
				arg_561_1.var_.actorSpriteComps1132 = var_564_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_2 = 0.2

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.actorSpriteComps1132 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								local var_564_4 = Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor2.r, var_564_3)
								local var_564_5 = Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor2.g, var_564_3)
								local var_564_6 = Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor2.b, var_564_3)

								iter_564_1.color = Color.New(var_564_4, var_564_5, var_564_6)
							else
								local var_564_7 = Mathf.Lerp(iter_564_1.color.r, 0.5, var_564_3)

								iter_564_1.color = Color.New(var_564_7, var_564_7, var_564_7)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.actorSpriteComps1132 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_564_3 then
						if arg_561_1.isInRecall_ then
							iter_564_3.color = arg_561_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_564_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_561_1.var_.actorSpriteComps1132 = nil
			end

			local var_564_8 = arg_561_1.actors_["10034"]
			local var_564_9 = 0

			if var_564_9 < arg_561_1.time_ and arg_561_1.time_ <= var_564_9 + arg_564_0 and not isNil(var_564_8) and arg_561_1.var_.actorSpriteComps10034 == nil then
				arg_561_1.var_.actorSpriteComps10034 = var_564_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_10 = 0.2

			if var_564_9 <= arg_561_1.time_ and arg_561_1.time_ < var_564_9 + var_564_10 and not isNil(var_564_8) then
				local var_564_11 = (arg_561_1.time_ - var_564_9) / var_564_10

				if arg_561_1.var_.actorSpriteComps10034 then
					for iter_564_4, iter_564_5 in pairs(arg_561_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_564_5 then
							if arg_561_1.isInRecall_ then
								local var_564_12 = Mathf.Lerp(iter_564_5.color.r, arg_561_1.hightColor1.r, var_564_11)
								local var_564_13 = Mathf.Lerp(iter_564_5.color.g, arg_561_1.hightColor1.g, var_564_11)
								local var_564_14 = Mathf.Lerp(iter_564_5.color.b, arg_561_1.hightColor1.b, var_564_11)

								iter_564_5.color = Color.New(var_564_12, var_564_13, var_564_14)
							else
								local var_564_15 = Mathf.Lerp(iter_564_5.color.r, 1, var_564_11)

								iter_564_5.color = Color.New(var_564_15, var_564_15, var_564_15)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= var_564_9 + var_564_10 and arg_561_1.time_ < var_564_9 + var_564_10 + arg_564_0 and not isNil(var_564_8) and arg_561_1.var_.actorSpriteComps10034 then
				for iter_564_6, iter_564_7 in pairs(arg_561_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_564_7 then
						if arg_561_1.isInRecall_ then
							iter_564_7.color = arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_564_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_561_1.var_.actorSpriteComps10034 = nil
			end

			local var_564_16 = arg_561_1.actors_["10034"].transform
			local var_564_17 = 0

			if var_564_17 < arg_561_1.time_ and arg_561_1.time_ <= var_564_17 + arg_564_0 then
				arg_561_1.var_.moveOldPos10034 = var_564_16.localPosition
				var_564_16.localScale = Vector3.New(1, 1, 1)

				arg_561_1:CheckSpriteTmpPos("10034", 4)

				local var_564_18 = var_564_16.childCount

				for iter_564_8 = 0, var_564_18 - 1 do
					local var_564_19 = var_564_16:GetChild(iter_564_8)

					if var_564_19.name == "split_5" or not string.find(var_564_19.name, "split") then
						var_564_19.gameObject:SetActive(true)
					else
						var_564_19.gameObject:SetActive(false)
					end
				end
			end

			local var_564_20 = 0.001

			if var_564_17 <= arg_561_1.time_ and arg_561_1.time_ < var_564_17 + var_564_20 then
				local var_564_21 = (arg_561_1.time_ - var_564_17) / var_564_20
				local var_564_22 = Vector3.New(390, -415, -290)

				var_564_16.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10034, var_564_22, var_564_21)
			end

			if arg_561_1.time_ >= var_564_17 + var_564_20 and arg_561_1.time_ < var_564_17 + var_564_20 + arg_564_0 then
				var_564_16.localPosition = Vector3.New(390, -415, -290)
			end

			local var_564_23 = 0
			local var_564_24 = 0.35

			if var_564_23 < arg_561_1.time_ and arg_561_1.time_ <= var_564_23 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_25 = arg_561_1:FormatText(StoryNameCfg[367].name)

				arg_561_1.leftNameTxt_.text = var_564_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_26 = arg_561_1:GetWordFromCfg(117041136)
				local var_564_27 = arg_561_1:FormatText(var_564_26.content)

				arg_561_1.text_.text = var_564_27

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_28 = 14
				local var_564_29 = utf8.len(var_564_27)
				local var_564_30 = var_564_28 <= 0 and var_564_24 or var_564_24 * (var_564_29 / var_564_28)

				if var_564_30 > 0 and var_564_24 < var_564_30 then
					arg_561_1.talkMaxDuration = var_564_30

					if var_564_30 + var_564_23 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_30 + var_564_23
					end
				end

				arg_561_1.text_.text = var_564_27
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041136", "story_v_out_117041.awb") ~= 0 then
					local var_564_31 = manager.audio:GetVoiceLength("story_v_out_117041", "117041136", "story_v_out_117041.awb") / 1000

					if var_564_31 + var_564_23 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_31 + var_564_23
					end

					if var_564_26.prefab_name ~= "" and arg_561_1.actors_[var_564_26.prefab_name] ~= nil then
						local var_564_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_26.prefab_name].transform, "story_v_out_117041", "117041136", "story_v_out_117041.awb")

						arg_561_1:RecordAudio("117041136", var_564_32)
						arg_561_1:RecordAudio("117041136", var_564_32)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_117041", "117041136", "story_v_out_117041.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_117041", "117041136", "story_v_out_117041.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_33 = math.max(var_564_24, arg_561_1.talkMaxDuration)

			if var_564_23 <= arg_561_1.time_ and arg_561_1.time_ < var_564_23 + var_564_33 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_23) / var_564_33

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_23 + var_564_33 and arg_561_1.time_ < var_564_23 + var_564_33 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
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

		arg_561_1:InitPlayNodeList()
	end,
	Play117041137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 117041137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play117041138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["10034"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				local var_568_2 = var_568_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_568_2 then
					arg_565_1.var_.alphaOldValue10034 = var_568_2.alpha
					arg_565_1.var_.characterEffect10034 = var_568_2
				end

				arg_565_1.var_.alphaOldValue10034 = 1
			end

			local var_568_3 = 0.333333333333333

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_3 then
				local var_568_4 = (arg_565_1.time_ - var_568_1) / var_568_3
				local var_568_5 = Mathf.Lerp(arg_565_1.var_.alphaOldValue10034, 0, var_568_4)

				if arg_565_1.var_.characterEffect10034 then
					arg_565_1.var_.characterEffect10034.alpha = var_568_5
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_3 and arg_565_1.time_ < var_568_1 + var_568_3 + arg_568_0 and arg_565_1.var_.characterEffect10034 then
				arg_565_1.var_.characterEffect10034.alpha = 0
			end

			local var_568_6 = arg_565_1.actors_["1132"]
			local var_568_7 = 0

			if var_568_7 < arg_565_1.time_ and arg_565_1.time_ <= var_568_7 + arg_568_0 then
				local var_568_8 = var_568_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_568_8 then
					arg_565_1.var_.alphaOldValue1132 = var_568_8.alpha
					arg_565_1.var_.characterEffect1132 = var_568_8
				end

				arg_565_1.var_.alphaOldValue1132 = 1
			end

			local var_568_9 = 0.333333333333333

			if var_568_7 <= arg_565_1.time_ and arg_565_1.time_ < var_568_7 + var_568_9 then
				local var_568_10 = (arg_565_1.time_ - var_568_7) / var_568_9
				local var_568_11 = Mathf.Lerp(arg_565_1.var_.alphaOldValue1132, 0, var_568_10)

				if arg_565_1.var_.characterEffect1132 then
					arg_565_1.var_.characterEffect1132.alpha = var_568_11
				end
			end

			if arg_565_1.time_ >= var_568_7 + var_568_9 and arg_565_1.time_ < var_568_7 + var_568_9 + arg_568_0 and arg_565_1.var_.characterEffect1132 then
				arg_565_1.var_.characterEffect1132.alpha = 0
			end

			local var_568_12 = 0
			local var_568_13 = 0.675

			if var_568_12 < arg_565_1.time_ and arg_565_1.time_ <= var_568_12 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_14 = arg_565_1:GetWordFromCfg(117041137)
				local var_568_15 = arg_565_1:FormatText(var_568_14.content)

				arg_565_1.text_.text = var_568_15

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_16 = 27
				local var_568_17 = utf8.len(var_568_15)
				local var_568_18 = var_568_16 <= 0 and var_568_13 or var_568_13 * (var_568_17 / var_568_16)

				if var_568_18 > 0 and var_568_13 < var_568_18 then
					arg_565_1.talkMaxDuration = var_568_18

					if var_568_18 + var_568_12 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_18 + var_568_12
					end
				end

				arg_565_1.text_.text = var_568_15
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_19 = math.max(var_568_13, arg_565_1.talkMaxDuration)

			if var_568_12 <= arg_565_1.time_ and arg_565_1.time_ < var_568_12 + var_568_19 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_12) / var_568_19

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_12 + var_568_19 and arg_565_1.time_ < var_568_12 + var_568_19 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play117041138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 117041138
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
			arg_569_1.auto_ = false
		end

		function arg_569_1.playNext_(arg_571_0)
			arg_569_1.onStoryFinished_()
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 1

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				local var_572_2 = "play"
				local var_572_3 = "effect"

				arg_569_1:AudioAction(var_572_2, var_572_3, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_572_4 = 0
			local var_572_5 = 0.425

			if var_572_4 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_6 = arg_569_1:GetWordFromCfg(117041138)
				local var_572_7 = arg_569_1:FormatText(var_572_6.content)

				arg_569_1.text_.text = var_572_7

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_8 = 17
				local var_572_9 = utf8.len(var_572_7)
				local var_572_10 = var_572_8 <= 0 and var_572_5 or var_572_5 * (var_572_9 / var_572_8)

				if var_572_10 > 0 and var_572_5 < var_572_10 then
					arg_569_1.talkMaxDuration = var_572_10

					if var_572_10 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_10 + var_572_4
					end
				end

				arg_569_1.text_.text = var_572_7
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_11 = math.max(var_572_5, arg_569_1.talkMaxDuration)

			if var_572_4 <= arg_569_1.time_ and arg_569_1.time_ < var_572_4 + var_572_11 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_4) / var_572_11

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_4 + var_572_11 and arg_569_1.time_ < var_572_4 + var_572_11 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST24a",
		"TextureConfig/Background/TI0103"
	},
	voices = {
		"story_v_out_117041.awb"
	}
}
