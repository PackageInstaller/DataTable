return {
	Play322241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322241001
		arg_1_1.duration_ = 8.3

		local var_1_0 = {
			zh = 7.066,
			ja = 8.3
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
				arg_1_0:Play322241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "STwhite"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.STwhite

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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
			local var_4_25 = 0.3

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

			local var_4_30 = 0.1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_145", "se_story_145_amb_information2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.525

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(322241001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241001", "story_v_out_322241.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_322241", "322241001", "story_v_out_322241.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_322241", "322241001", "story_v_out_322241.awb")

						arg_1_1:RecordAudio("322241001", var_4_44)
						arg_1_1:RecordAudio("322241001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322241", "322241001", "story_v_out_322241.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322241", "322241001", "story_v_out_322241.awb")
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
	Play322241002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 322241002
		arg_8_1.duration_ = 7.47

		local var_8_0 = {
			zh = 5.733,
			ja = 7.466
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
				arg_8_0:Play322241003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.6

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
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(322241002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241002", "story_v_out_322241.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241002", "story_v_out_322241.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_322241", "322241002", "story_v_out_322241.awb")

						arg_8_1:RecordAudio("322241002", var_11_9)
						arg_8_1:RecordAudio("322241002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_322241", "322241002", "story_v_out_322241.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_322241", "322241002", "story_v_out_322241.awb")
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
	Play322241003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 322241003
		arg_12_1.duration_ = 8.4

		local var_12_0 = {
			zh = 5.3,
			ja = 8.4
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
				arg_12_0:Play322241004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.575

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(322241003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241003", "story_v_out_322241.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241003", "story_v_out_322241.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_322241", "322241003", "story_v_out_322241.awb")

						arg_12_1:RecordAudio("322241003", var_15_9)
						arg_12_1:RecordAudio("322241003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_322241", "322241003", "story_v_out_322241.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_322241", "322241003", "story_v_out_322241.awb")
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
	Play322241004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 322241004
		arg_16_1.duration_ = 2.67

		local var_16_0 = {
			zh = 2.666,
			ja = 2.633
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
				arg_16_0:Play322241005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.25

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[36].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(322241004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241004", "story_v_out_322241.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241004", "story_v_out_322241.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_322241", "322241004", "story_v_out_322241.awb")

						arg_16_1:RecordAudio("322241004", var_19_9)
						arg_16_1:RecordAudio("322241004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_322241", "322241004", "story_v_out_322241.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_322241", "322241004", "story_v_out_322241.awb")
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
	Play322241005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 322241005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play322241006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 4

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_1 = 1.00553850177575

			if arg_20_1.time_ >= var_23_0 + var_23_1 and arg_20_1.time_ < var_23_0 + var_23_1 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_2 = "ST0513"

			if arg_20_1.bgs_[var_23_2] == nil then
				local var_23_3 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_2)
				var_23_3.name = var_23_2
				var_23_3.transform.parent = arg_20_1.stage_.transform
				var_23_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_2] = var_23_3
			end

			local var_23_4 = 2

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				local var_23_5 = manager.ui.mainCamera.transform.localPosition
				local var_23_6 = Vector3.New(0, 0, 10) + Vector3.New(var_23_5.x, var_23_5.y, 0)
				local var_23_7 = arg_20_1.bgs_.ST0513

				var_23_7.transform.localPosition = var_23_6
				var_23_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_8 = var_23_7:GetComponent("SpriteRenderer")

				if var_23_8 and var_23_8.sprite then
					local var_23_9 = (var_23_7.transform.localPosition - var_23_5).z
					local var_23_10 = manager.ui.mainCameraCom_
					local var_23_11 = 2 * var_23_9 * Mathf.Tan(var_23_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_12 = var_23_11 * var_23_10.aspect
					local var_23_13 = var_23_8.sprite.bounds.size.x
					local var_23_14 = var_23_8.sprite.bounds.size.y
					local var_23_15 = var_23_12 / var_23_13
					local var_23_16 = var_23_11 / var_23_14
					local var_23_17 = var_23_16 < var_23_15 and var_23_15 or var_23_16

					var_23_7.transform.localScale = Vector3.New(var_23_17, var_23_17, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST0513" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_19 = 2

			if var_23_18 <= arg_20_1.time_ and arg_20_1.time_ < var_23_18 + var_23_19 then
				local var_23_20 = (arg_20_1.time_ - var_23_18) / var_23_19
				local var_23_21 = Color.New(0, 0, 0)

				var_23_21.a = Mathf.Lerp(0, 1, var_23_20)
				arg_20_1.mask_.color = var_23_21
			end

			if arg_20_1.time_ >= var_23_18 + var_23_19 and arg_20_1.time_ < var_23_18 + var_23_19 + arg_23_0 then
				local var_23_22 = Color.New(0, 0, 0)

				var_23_22.a = 1
				arg_20_1.mask_.color = var_23_22
			end

			local var_23_23 = 2

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_24 = 2

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24
				local var_23_26 = Color.New(0, 0, 0)

				var_23_26.a = Mathf.Lerp(1, 0, var_23_25)
				arg_20_1.mask_.color = var_23_26
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 then
				local var_23_27 = Color.New(0, 0, 0)
				local var_23_28 = 0

				arg_20_1.mask_.enabled = false
				var_23_27.a = var_23_28
				arg_20_1.mask_.color = var_23_27
			end

			local var_23_29 = manager.ui.mainCamera.transform
			local var_23_30 = 2

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				local var_23_31 = arg_20_1.var_.effect1005
				local var_23_32
				local var_23_33 = var_23_29

				if not var_23_31 then
					var_23_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_23_33)
					var_23_31.name = "1005"
					arg_20_1.var_.effect1005 = var_23_31
				else
					var_23_31.transform:SetParent(var_23_33)
				end

				var_23_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_23_34 = 0
			local var_23_35 = 0.3

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				local var_23_36 = "play"
				local var_23_37 = "music"

				arg_20_1:AudioAction(var_23_36, var_23_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_23_38 = ""
				local var_23_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_23_39 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_39 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_39

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_39
						arg_20_1.bgmTxt2_.text = var_23_39
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

			local var_23_40 = 0.500666666666667
			local var_23_41 = 1

			if var_23_40 < arg_20_1.time_ and arg_20_1.time_ <= var_23_40 + arg_23_0 then
				local var_23_42 = "play"
				local var_23_43 = "music"

				arg_20_1:AudioAction(var_23_42, var_23_43, "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first.awb")

				local var_23_44 = ""
				local var_23_45 = manager.audio:GetAudioName("bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first")

				if var_23_45 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_45 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_45

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_45
						arg_20_1.bgmTxt2_.text = var_23_45
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

			local var_23_46 = 1.50066666666667
			local var_23_47 = 1

			if var_23_46 < arg_20_1.time_ and arg_20_1.time_ <= var_23_46 + arg_23_0 then
				local var_23_48 = "play"
				local var_23_49 = "effect"

				arg_20_1:AudioAction(var_23_48, var_23_49, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_23_50 = 0.1
			local var_23_51 = 1

			if var_23_50 < arg_20_1.time_ and arg_20_1.time_ <= var_23_50 + arg_23_0 then
				local var_23_52 = "play"
				local var_23_53 = "effect"

				arg_20_1:AudioAction(var_23_52, var_23_53, "se_story_145", "se_story_145_amb_information1", "")
			end

			local var_23_54 = 0.1
			local var_23_55 = 1

			if var_23_54 < arg_20_1.time_ and arg_20_1.time_ <= var_23_54 + arg_23_0 then
				local var_23_56 = "play"
				local var_23_57 = "effect"

				arg_20_1:AudioAction(var_23_56, var_23_57, "se_story_145", "se_story_145_amb_information2_action_down", "")
			end

			local var_23_58 = 4.23333333333333
			local var_23_59 = 1

			if var_23_58 < arg_20_1.time_ and arg_20_1.time_ <= var_23_58 + arg_23_0 then
				local var_23_60 = "play"
				local var_23_61 = "effect"

				arg_20_1:AudioAction(var_23_60, var_23_61, "se_story_121_04", "se_story_121_04_scan", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_62 = 4
			local var_23_63 = 1.4

			if var_23_62 < arg_20_1.time_ and arg_20_1.time_ <= var_23_62 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_64 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_64:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_20_1.dialogCg_.alpha = arg_26_0
				end))
				var_23_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_65 = arg_20_1:GetWordFromCfg(322241005)
				local var_23_66 = arg_20_1:FormatText(var_23_65.content)

				arg_20_1.text_.text = var_23_66

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_67 = 56
				local var_23_68 = utf8.len(var_23_66)
				local var_23_69 = var_23_67 <= 0 and var_23_63 or var_23_63 * (var_23_68 / var_23_67)

				if var_23_69 > 0 and var_23_63 < var_23_69 then
					arg_20_1.talkMaxDuration = var_23_69
					var_23_62 = var_23_62 + 0.3

					if var_23_69 + var_23_62 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_69 + var_23_62
					end
				end

				arg_20_1.text_.text = var_23_66
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_70 = var_23_62 + 0.3
			local var_23_71 = math.max(var_23_63, arg_20_1.talkMaxDuration)

			if var_23_70 <= arg_20_1.time_ and arg_20_1.time_ < var_23_70 + var_23_71 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_70) / var_23_71

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_70 + var_23_71 and arg_20_1.time_ < var_23_70 + var_23_71 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play322241006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322241006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322241007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = manager.ui.mainCamera.transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				local var_31_2 = arg_28_1.var_.effect1005

				if var_31_2 then
					Object.Destroy(var_31_2)

					arg_28_1.var_.effect1005 = nil
				end
			end

			local var_31_3 = 0
			local var_31_4 = 1.175

			if var_31_3 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:GetWordFromCfg(322241006)
				local var_31_6 = arg_28_1:FormatText(var_31_5.content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 47
				local var_31_8 = utf8.len(var_31_6)
				local var_31_9 = var_31_7 <= 0 and var_31_4 or var_31_4 * (var_31_8 / var_31_7)

				if var_31_9 > 0 and var_31_4 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_10 and arg_28_1.time_ < var_31_3 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322241007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322241007
		arg_32_1.duration_ = 9.67

		local var_32_0 = {
			zh = 5.9,
			ja = 9.666
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
				arg_32_0:Play322241008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1020ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1020ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1020ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0, -0.85, -6.25)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1020ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["1020ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1020ui_story == nil then
				arg_32_1.var_.characterEffect1020ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect1020ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1020ui_story then
				arg_32_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_20 = 0
			local var_35_21 = 0.725

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_22 = arg_32_1:FormatText(StoryNameCfg[613].name)

				arg_32_1.leftNameTxt_.text = var_35_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(322241007)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 29
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_21 or var_35_21 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_21 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_20
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241007", "story_v_out_322241.awb") ~= 0 then
					local var_35_28 = manager.audio:GetVoiceLength("story_v_out_322241", "322241007", "story_v_out_322241.awb") / 1000

					if var_35_28 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_28 + var_35_20
					end

					if var_35_23.prefab_name ~= "" and arg_32_1.actors_[var_35_23.prefab_name] ~= nil then
						local var_35_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_23.prefab_name].transform, "story_v_out_322241", "322241007", "story_v_out_322241.awb")

						arg_32_1:RecordAudio("322241007", var_35_29)
						arg_32_1:RecordAudio("322241007", var_35_29)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322241", "322241007", "story_v_out_322241.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322241", "322241007", "story_v_out_322241.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = math.max(var_35_21, arg_32_1.talkMaxDuration)

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_30 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_30

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_30 and arg_32_1.time_ < var_35_20 + var_35_30 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play322241008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322241008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play322241009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1020ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1020ui_story == nil then
				arg_36_1.var_.characterEffect1020ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1020ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1020ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1020ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1020ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.225

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(322241008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 9
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322241009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322241009
		arg_40_1.duration_ = 4.4

		local var_40_0 = {
			zh = 2.7,
			ja = 4.4
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
				arg_40_0:Play322241010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1020ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1020ui_story == nil then
				arg_40_1.var_.characterEffect1020ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1020ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1020ui_story then
				arg_40_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_43_6 = 0
			local var_43_7 = 0.35

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[613].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_9 = arg_40_1:GetWordFromCfg(322241009)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 14
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241009", "story_v_out_322241.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_322241", "322241009", "story_v_out_322241.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_322241", "322241009", "story_v_out_322241.awb")

						arg_40_1:RecordAudio("322241009", var_43_15)
						arg_40_1:RecordAudio("322241009", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_322241", "322241009", "story_v_out_322241.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_322241", "322241009", "story_v_out_322241.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322241010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322241010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play322241011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1020ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1020ui_story == nil then
				arg_44_1.var_.characterEffect1020ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1020ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1020ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1020ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1020ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 1.075

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(322241010)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 43
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_7 or var_47_7 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_7 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_13 and arg_44_1.time_ < var_47_6 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play322241011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322241011
		arg_48_1.duration_ = 16

		local var_48_0 = {
			zh = 10.933,
			ja = 16
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
				arg_48_0:Play322241012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1020ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1020ui_story == nil then
				arg_48_1.var_.characterEffect1020ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1020ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1020ui_story then
				arg_48_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_51_4 = 0

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_51_5 = 0
			local var_51_6 = 1.15

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_7 = arg_48_1:FormatText(StoryNameCfg[613].name)

				arg_48_1.leftNameTxt_.text = var_51_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(322241011)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 46
				local var_51_11 = utf8.len(var_51_9)
				local var_51_12 = var_51_10 <= 0 and var_51_6 or var_51_6 * (var_51_11 / var_51_10)

				if var_51_12 > 0 and var_51_6 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241011", "story_v_out_322241.awb") ~= 0 then
					local var_51_13 = manager.audio:GetVoiceLength("story_v_out_322241", "322241011", "story_v_out_322241.awb") / 1000

					if var_51_13 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_5
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_322241", "322241011", "story_v_out_322241.awb")

						arg_48_1:RecordAudio("322241011", var_51_14)
						arg_48_1:RecordAudio("322241011", var_51_14)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_322241", "322241011", "story_v_out_322241.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_322241", "322241011", "story_v_out_322241.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_15 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_15 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_15

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_15 and arg_48_1.time_ < var_51_5 + var_51_15 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322241012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322241012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play322241013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1020ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1020ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1020ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1020ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1020ui_story == nil then
				arg_52_1.var_.characterEffect1020ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1020ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1020ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1020ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1020ui_story.fillRatio = var_55_14
			end

			local var_55_15 = 0.4
			local var_55_16 = 1

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				local var_55_17 = "play"
				local var_55_18 = "effect"

				arg_52_1:AudioAction(var_55_17, var_55_18, "se_story_145", "se_story_145_button", "")
			end

			local var_55_19 = 0
			local var_55_20 = 0.775

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_21 = arg_52_1:GetWordFromCfg(322241012)
				local var_55_22 = arg_52_1:FormatText(var_55_21.content)

				arg_52_1.text_.text = var_55_22

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_23 = 31
				local var_55_24 = utf8.len(var_55_22)
				local var_55_25 = var_55_23 <= 0 and var_55_20 or var_55_20 * (var_55_24 / var_55_23)

				if var_55_25 > 0 and var_55_20 < var_55_25 then
					arg_52_1.talkMaxDuration = var_55_25

					if var_55_25 + var_55_19 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_19
					end
				end

				arg_52_1.text_.text = var_55_22
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_20, arg_52_1.talkMaxDuration)

			if var_55_19 <= arg_52_1.time_ and arg_52_1.time_ < var_55_19 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_19) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_19 + var_55_26 and arg_52_1.time_ < var_55_19 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play322241013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 322241013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play322241014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.65

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(322241013)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 26
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play322241014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322241014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play322241015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.675

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

				local var_63_2 = arg_60_1:GetWordFromCfg(322241014)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 67
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
	Play322241015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322241015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play322241016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.3

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(322241015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 12
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play322241016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322241016
		arg_68_1.duration_ = 3.3

		local var_68_0 = {
			zh = 3.1,
			ja = 3.3
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
				arg_68_0:Play322241017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1020ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1020ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -0.85, -6.25)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1020ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1020ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1020ui_story == nil then
				arg_68_1.var_.characterEffect1020ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1020ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1020ui_story then
				arg_68_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_15 = 0
			local var_71_16 = 0.25

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[613].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(322241016)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 10
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241016", "story_v_out_322241.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_322241", "322241016", "story_v_out_322241.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_322241", "322241016", "story_v_out_322241.awb")

						arg_68_1:RecordAudio("322241016", var_71_24)
						arg_68_1:RecordAudio("322241016", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_322241", "322241016", "story_v_out_322241.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_322241", "322241016", "story_v_out_322241.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play322241017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322241017
		arg_72_1.duration_ = 5.37

		local var_72_0 = {
			zh = 3.3,
			ja = 5.366
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
				arg_72_0:Play322241018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.425

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[613].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(322241017)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 17
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241017", "story_v_out_322241.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_322241", "322241017", "story_v_out_322241.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_322241", "322241017", "story_v_out_322241.awb")

						arg_72_1:RecordAudio("322241017", var_75_11)
						arg_72_1:RecordAudio("322241017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_322241", "322241017", "story_v_out_322241.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_322241", "322241017", "story_v_out_322241.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play322241018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 322241018
		arg_76_1.duration_ = 1

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"

			SetActive(arg_76_1.choicesGo_, true)

			for iter_77_0, iter_77_1 in ipairs(arg_76_1.choices_) do
				local var_77_0 = iter_77_0 <= 3

				SetActive(iter_77_1.go, var_77_0)
			end

			arg_76_1.choices_[1].txt.text = arg_76_1:FormatText(StoryChoiceCfg[1409].name)
			arg_76_1.choices_[2].txt.text = arg_76_1:FormatText(StoryChoiceCfg[1410].name)
			arg_76_1.choices_[3].txt.text = arg_76_1:FormatText(StoryChoiceCfg[1411].name)
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play322241019(arg_76_1)
			end

			if arg_78_0 == 2 then
				arg_76_0:Play322241019(arg_76_1)
			end

			if arg_78_0 == 3 then
				arg_76_0:Play322241019(arg_76_1)
			end

			arg_76_1:RecordChoiceLog(322241018, 1409, 1410, 1411)
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1020ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1020ui_story == nil then
				arg_76_1.var_.characterEffect1020ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1020ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1020ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1020ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1020ui_story.fillRatio = var_79_5
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play322241019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322241019
		arg_80_1.duration_ = 12.1

		local var_80_0 = {
			zh = 7.433,
			ja = 12.1
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
				arg_80_0:Play322241020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1020ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1020ui_story == nil then
				arg_80_1.var_.characterEffect1020ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1020ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1020ui_story then
				arg_80_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_83_4 = "1020ui_story"

			if arg_80_1.actors_[var_83_4] == nil then
				local var_83_5 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_83_5) then
					local var_83_6 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_80_1.stage_.transform)

					var_83_6.name = var_83_4
					var_83_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_80_1.actors_[var_83_4] = var_83_6

					local var_83_7 = var_83_6:GetComponentInChildren(typeof(CharacterEffect))

					var_83_7.enabled = true

					local var_83_8 = GameObjectTools.GetOrAddComponent(var_83_6, typeof(DynamicBoneHelper))

					if var_83_8 then
						var_83_8:EnableDynamicBone(false)
					end

					arg_80_1:ShowWeapon(var_83_7.transform, false)

					arg_80_1.var_[var_83_4 .. "Animator"] = var_83_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_80_1.var_[var_83_4 .. "Animator"].applyRootMotion = true
					arg_80_1.var_[var_83_4 .. "LipSync"] = var_83_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				arg_80_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_83_10 = 0
			local var_83_11 = 0.9

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[613].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(322241019)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 36
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_11 or var_83_11 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_11 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241019", "story_v_out_322241.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_322241", "322241019", "story_v_out_322241.awb") / 1000

					if var_83_18 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_10
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_322241", "322241019", "story_v_out_322241.awb")

						arg_80_1:RecordAudio("322241019", var_83_19)
						arg_80_1:RecordAudio("322241019", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322241", "322241019", "story_v_out_322241.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322241", "322241019", "story_v_out_322241.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_20 and arg_80_1.time_ < var_83_10 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322241020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322241020
		arg_84_1.duration_ = 20.33

		local var_84_0 = {
			zh = 12.433,
			ja = 20.333
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
				arg_84_0:Play322241021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1.325

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[613].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(322241020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 53
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241020", "story_v_out_322241.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241020", "story_v_out_322241.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_322241", "322241020", "story_v_out_322241.awb")

						arg_84_1:RecordAudio("322241020", var_87_9)
						arg_84_1:RecordAudio("322241020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_322241", "322241020", "story_v_out_322241.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_322241", "322241020", "story_v_out_322241.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322241021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322241021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play322241022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1020ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1020ui_story == nil then
				arg_88_1.var_.characterEffect1020ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1020ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1020ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1020ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1020ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.625

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(322241021)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 25
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play322241022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322241022
		arg_92_1.duration_ = 10.33

		local var_92_0 = {
			zh = 5.633,
			ja = 10.333
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
				arg_92_0:Play322241023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1020ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1020ui_story == nil then
				arg_92_1.var_.characterEffect1020ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1020ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1020ui_story then
				arg_92_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_95_4 = 0

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			local var_95_5 = 0
			local var_95_6 = 0.55

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_7 = arg_92_1:FormatText(StoryNameCfg[613].name)

				arg_92_1.leftNameTxt_.text = var_95_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(322241022)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 22
				local var_95_11 = utf8.len(var_95_9)
				local var_95_12 = var_95_10 <= 0 and var_95_6 or var_95_6 * (var_95_11 / var_95_10)

				if var_95_12 > 0 and var_95_6 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241022", "story_v_out_322241.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_322241", "322241022", "story_v_out_322241.awb") / 1000

					if var_95_13 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_5
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_322241", "322241022", "story_v_out_322241.awb")

						arg_92_1:RecordAudio("322241022", var_95_14)
						arg_92_1:RecordAudio("322241022", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322241", "322241022", "story_v_out_322241.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322241", "322241022", "story_v_out_322241.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_15 and arg_92_1.time_ < var_95_5 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play322241023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322241023
		arg_96_1.duration_ = 12

		local var_96_0 = {
			zh = 7.6,
			ja = 12
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322241024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.9

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[613].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(322241023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 36
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241023", "story_v_out_322241.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241023", "story_v_out_322241.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_322241", "322241023", "story_v_out_322241.awb")

						arg_96_1:RecordAudio("322241023", var_99_9)
						arg_96_1:RecordAudio("322241023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_322241", "322241023", "story_v_out_322241.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_322241", "322241023", "story_v_out_322241.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play322241024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322241024
		arg_100_1.duration_ = 19.8

		local var_100_0 = {
			zh = 13.833,
			ja = 19.8
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
				arg_100_0:Play322241025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.275

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[613].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(322241024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 51
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241024", "story_v_out_322241.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241024", "story_v_out_322241.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_322241", "322241024", "story_v_out_322241.awb")

						arg_100_1:RecordAudio("322241024", var_103_9)
						arg_100_1:RecordAudio("322241024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322241", "322241024", "story_v_out_322241.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322241", "322241024", "story_v_out_322241.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play322241025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322241025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322241026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1020ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1020ui_story == nil then
				arg_104_1.var_.characterEffect1020ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1020ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1020ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1020ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1020ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 0.825

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(322241025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 33
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play322241026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322241026
		arg_108_1.duration_ = 8.93

		local var_108_0 = {
			zh = 5.3,
			ja = 8.933
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
				arg_108_0:Play322241027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1020ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1020ui_story == nil then
				arg_108_1.var_.characterEffect1020ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1020ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1020ui_story then
				arg_108_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_2")
			end

			local var_111_5 = 0
			local var_111_6 = 0.675

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_7 = arg_108_1:FormatText(StoryNameCfg[613].name)

				arg_108_1.leftNameTxt_.text = var_111_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(322241026)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 27
				local var_111_11 = utf8.len(var_111_9)
				local var_111_12 = var_111_10 <= 0 and var_111_6 or var_111_6 * (var_111_11 / var_111_10)

				if var_111_12 > 0 and var_111_6 < var_111_12 then
					arg_108_1.talkMaxDuration = var_111_12

					if var_111_12 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241026", "story_v_out_322241.awb") ~= 0 then
					local var_111_13 = manager.audio:GetVoiceLength("story_v_out_322241", "322241026", "story_v_out_322241.awb") / 1000

					if var_111_13 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_5
					end

					if var_111_8.prefab_name ~= "" and arg_108_1.actors_[var_111_8.prefab_name] ~= nil then
						local var_111_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_8.prefab_name].transform, "story_v_out_322241", "322241026", "story_v_out_322241.awb")

						arg_108_1:RecordAudio("322241026", var_111_14)
						arg_108_1:RecordAudio("322241026", var_111_14)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322241", "322241026", "story_v_out_322241.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322241", "322241026", "story_v_out_322241.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_15 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_15 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_15

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_15 and arg_108_1.time_ < var_111_5 + var_111_15 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play322241027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322241027
		arg_112_1.duration_ = 12.1

		local var_112_0 = {
			zh = 9.1,
			ja = 12.1
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
				arg_112_0:Play322241028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.875

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[613].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(322241027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 35
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322241", "322241027", "story_v_out_322241.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_322241", "322241027", "story_v_out_322241.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_322241", "322241027", "story_v_out_322241.awb")

						arg_112_1:RecordAudio("322241027", var_115_9)
						arg_112_1:RecordAudio("322241027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322241", "322241027", "story_v_out_322241.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322241", "322241027", "story_v_out_322241.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play322241028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322241028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322241029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1020ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1020ui_story == nil then
				arg_116_1.var_.characterEffect1020ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1020ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1020ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1020ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1020ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_119_7 = 0
			local var_119_8 = 0.2

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_9 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_10 = arg_116_1:GetWordFromCfg(322241028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_12 = 8
				local var_119_13 = utf8.len(var_119_11)
				local var_119_14 = var_119_12 <= 0 and var_119_8 or var_119_8 * (var_119_13 / var_119_12)

				if var_119_14 > 0 and var_119_8 < var_119_14 then
					arg_116_1.talkMaxDuration = var_119_14

					if var_119_14 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_7
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_15 = math.max(var_119_8, arg_116_1.talkMaxDuration)

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_15 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_7) / var_119_15

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_7 + var_119_15 and arg_116_1.time_ < var_119_7 + var_119_15 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322241029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322241029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322241030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1020ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1020ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1020ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = 0.1
			local var_123_10 = 1

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				local var_123_11 = "play"
				local var_123_12 = "effect"

				arg_120_1:AudioAction(var_123_11, var_123_12, "se_story_120_00", "se_story_120_00_scan", "")
			end

			local var_123_13 = 0
			local var_123_14 = 1.45

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(322241029)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 58
				local var_123_18 = utf8.len(var_123_16)
				local var_123_19 = var_123_17 <= 0 and var_123_14 or var_123_14 * (var_123_18 / var_123_17)

				if var_123_19 > 0 and var_123_14 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_13 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_13
					end
				end

				arg_120_1.text_.text = var_123_16
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_20 = math.max(var_123_14, arg_120_1.talkMaxDuration)

			if var_123_13 <= arg_120_1.time_ and arg_120_1.time_ < var_123_13 + var_123_20 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_13) / var_123_20

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_13 + var_123_20 and arg_120_1.time_ < var_123_13 + var_123_20 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play322241030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322241030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322241031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.15

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(322241030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 6
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play322241031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322241031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1.3

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_2 = arg_128_1:GetWordFromCfg(322241031)
				local var_131_3 = arg_128_1:FormatText(var_131_2.content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 52
				local var_131_5 = utf8.len(var_131_3)
				local var_131_6 = var_131_4 <= 0 and var_131_1 or var_131_1 * (var_131_5 / var_131_4)

				if var_131_6 > 0 and var_131_1 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_7 and arg_128_1.time_ < var_131_0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST0513"
	},
	voices = {
		"story_v_out_322241.awb"
	}
}
