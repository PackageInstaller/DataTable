return {
	Play304081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304081001
		arg_1_1.duration_ = 6.9

		local var_1_0 = {
			zh = 6.23333333333333,
			ja = 6.89933333333333
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
				arg_1_0:Play304081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B03b"

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
				local var_4_5 = arg_1_1.bgs_.B03b

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
					if iter_4_0 ~= "B03b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = arg_1_1.actors_["10001ui_story"]
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect10001ui_story == nil then
				arg_1_1.var_.characterEffect10001ui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffect10001ui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffect10001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect10001ui_story then
				arg_1_1.var_.characterEffect10001ui_story.fillFlat = false
			end

			local var_4_28 = 0.2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_142", "se_story_142_amb_command room", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 0
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_42 = 1.53333333333333
			local var_4_43 = 0.575

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_45 = arg_1_1:FormatText(StoryNameCfg[24].name)

				arg_1_1.leftNameTxt_.text = var_4_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_46 = arg_1_1:GetWordFromCfg(304081001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 23
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_43 or var_4_43 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_43 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_42 = var_4_42 + 0.3

					if var_4_50 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081001", "story_v_out_304081.awb") ~= 0 then
					local var_4_51 = manager.audio:GetVoiceLength("story_v_out_304081", "304081001", "story_v_out_304081.awb") / 1000

					if var_4_51 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_42
					end

					if var_4_46.prefab_name ~= "" and arg_1_1.actors_[var_4_46.prefab_name] ~= nil then
						local var_4_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_46.prefab_name].transform, "story_v_out_304081", "304081001", "story_v_out_304081.awb")

						arg_1_1:RecordAudio("304081001", var_4_52)
						arg_1_1:RecordAudio("304081001", var_4_52)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304081", "304081001", "story_v_out_304081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304081", "304081001", "story_v_out_304081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_53 = var_4_42 + 0.3
			local var_4_54 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_53) / var_4_54

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304081002
		arg_8_1.duration_ = 3.8

		local var_8_0 = {
			zh = 2.8,
			ja = 3.8
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
				arg_8_0:Play304081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.35

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[24].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(304081002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081002", "story_v_out_304081.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081002", "story_v_out_304081.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_304081", "304081002", "story_v_out_304081.awb")

						arg_8_1:RecordAudio("304081002", var_11_9)
						arg_8_1:RecordAudio("304081002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304081", "304081002", "story_v_out_304081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304081", "304081002", "story_v_out_304081.awb")
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
	Play304081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10001ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10001ui_story == nil then
				arg_12_1.var_.characterEffect10001ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect10001ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect10001ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10001ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10001ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect10001ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10001ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0.5
			local var_15_7 = 1

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				local var_15_8 = "play"
				local var_15_9 = "effect"

				arg_12_1:AudioAction(var_15_8, var_15_9, "se_story_152", "se_story_152_keyboard", "")
			end

			local var_15_10 = 0
			local var_15_11 = 1.075

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(304081003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_14 = 42
				local var_15_15 = utf8.len(var_15_13)
				local var_15_16 = var_15_14 <= 0 and var_15_11 or var_15_11 * (var_15_15 / var_15_14)

				if var_15_16 > 0 and var_15_11 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_17 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_17

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_17 and arg_12_1.time_ < var_15_10 + var_15_17 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304081004
		arg_16_1.duration_ = 4.8

		local var_16_0 = {
			zh = 4.133,
			ja = 4.8
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
				arg_16_0:Play304081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.45

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[44].name)

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

				local var_19_3 = arg_16_1:GetWordFromCfg(304081004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081004", "story_v_out_304081.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081004", "story_v_out_304081.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_304081", "304081004", "story_v_out_304081.awb")

						arg_16_1:RecordAudio("304081004", var_19_9)
						arg_16_1:RecordAudio("304081004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304081", "304081004", "story_v_out_304081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304081", "304081004", "story_v_out_304081.awb")
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
	Play304081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304081005
		arg_20_1.duration_ = 11.03

		local var_20_0 = {
			zh = 10.7996666666667,
			ja = 11.0326666666667
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
				arg_20_0:Play304081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = manager.ui.mainCamera.transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				local var_23_2 = arg_20_1.var_.effect12313aa
				local var_23_3
				local var_23_4 = var_23_0

				if not var_23_2 then
					var_23_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_black"), var_23_4)
					var_23_2.name = "12313aa"
					arg_20_1.var_.effect12313aa = var_23_2
				else
					var_23_2.transform:SetParent(var_23_4)
				end

				var_23_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_23_5 = 1.7777777777777777
				local var_23_6 = Screen.width / Screen.height
				local var_23_7 = var_23_6 / var_23_5
				local var_23_8 = Mathf.Max(var_23_5 / var_23_6, 1)

				var_23_2.transform.localScale = Vector3.New(var_23_2.transform.localScale.x * var_23_7, var_23_2.transform.localScale.y * var_23_8, var_23_2.transform.localScale.z)
			end

			local var_23_9 = manager.ui.mainCamera.transform
			local var_23_10 = 3.83333333333333

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				local var_23_11 = arg_20_1.var_.effect12313aa

				if var_23_11 then
					Object.Destroy(var_23_11)

					arg_20_1.var_.effect12313aa = nil
				end
			end

			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_13 = 3.16666666666667

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_14 = 2.66666666666667
			local var_23_15 = 0.85

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_16 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_16:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[44].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_18 = arg_20_1:GetWordFromCfg(304081005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 34
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_15 or var_23_15 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_15 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22
					var_23_14 = var_23_14 + 0.3

					if var_23_22 + var_23_14 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_14
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081005", "story_v_out_304081.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_304081", "304081005", "story_v_out_304081.awb") / 1000

					if var_23_23 + var_23_14 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_14
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_304081", "304081005", "story_v_out_304081.awb")

						arg_20_1:RecordAudio("304081005", var_23_24)
						arg_20_1:RecordAudio("304081005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304081", "304081005", "story_v_out_304081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304081", "304081005", "story_v_out_304081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = var_23_14 + 0.3
			local var_23_26 = math.max(var_23_15, arg_20_1.talkMaxDuration)

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_25) / var_23_26

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304081006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 304081006
		arg_26_1.duration_ = 10.9

		local var_26_0 = {
			zh = 10.6,
			ja = 10.9
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
				arg_26_0:Play304081007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10001ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10001ui_story == nil then
				arg_26_1.var_.characterEffect10001ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect10001ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect10001ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect10001ui_story then
				arg_26_1.var_.characterEffect10001ui_story.fillFlat = false
			end

			local var_29_4 = 0
			local var_29_5 = 0.875

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_6 = arg_26_1:FormatText(StoryNameCfg[24].name)

				arg_26_1.leftNameTxt_.text = var_29_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_7 = arg_26_1:GetWordFromCfg(304081006)
				local var_29_8 = arg_26_1:FormatText(var_29_7.content)

				arg_26_1.text_.text = var_29_8

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 35
				local var_29_10 = utf8.len(var_29_8)
				local var_29_11 = var_29_9 <= 0 and var_29_5 or var_29_5 * (var_29_10 / var_29_9)

				if var_29_11 > 0 and var_29_5 < var_29_11 then
					arg_26_1.talkMaxDuration = var_29_11

					if var_29_11 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_8
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081006", "story_v_out_304081.awb") ~= 0 then
					local var_29_12 = manager.audio:GetVoiceLength("story_v_out_304081", "304081006", "story_v_out_304081.awb") / 1000

					if var_29_12 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_4
					end

					if var_29_7.prefab_name ~= "" and arg_26_1.actors_[var_29_7.prefab_name] ~= nil then
						local var_29_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_7.prefab_name].transform, "story_v_out_304081", "304081006", "story_v_out_304081.awb")

						arg_26_1:RecordAudio("304081006", var_29_13)
						arg_26_1:RecordAudio("304081006", var_29_13)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_304081", "304081006", "story_v_out_304081.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_304081", "304081006", "story_v_out_304081.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_14 and arg_26_1.time_ < var_29_4 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play304081007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 304081007
		arg_30_1.duration_ = 8.93

		local var_30_0 = {
			zh = 6.466,
			ja = 8.933
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
				arg_30_0:Play304081008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.65

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[24].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(304081007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 26
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081007", "story_v_out_304081.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081007", "story_v_out_304081.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_304081", "304081007", "story_v_out_304081.awb")

						arg_30_1:RecordAudio("304081007", var_33_9)
						arg_30_1:RecordAudio("304081007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_304081", "304081007", "story_v_out_304081.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_304081", "304081007", "story_v_out_304081.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play304081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 304081008
		arg_34_1.duration_ = 3.67

		local var_34_0 = {
			zh = 2.9,
			ja = 3.666
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play304081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10001ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10001ui_story == nil then
				arg_34_1.var_.characterEffect10001ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect10001ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect10001ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10001ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10001ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect10001ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10001ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.275

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[44].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(304081008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 11
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081008", "story_v_out_304081.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_304081", "304081008", "story_v_out_304081.awb") / 1000

					if var_37_14 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_6
					end

					if var_37_9.prefab_name ~= "" and arg_34_1.actors_[var_37_9.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_9.prefab_name].transform, "story_v_out_304081", "304081008", "story_v_out_304081.awb")

						arg_34_1:RecordAudio("304081008", var_37_15)
						arg_34_1:RecordAudio("304081008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_304081", "304081008", "story_v_out_304081.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_304081", "304081008", "story_v_out_304081.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_16 and arg_34_1.time_ < var_37_6 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play304081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 304081009
		arg_38_1.duration_ = 9.5

		local var_38_0 = {
			zh = 8.533,
			ja = 9.5
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play304081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "10045ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_38_1.stage_.transform)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentInChildren(typeof(CharacterEffect))

					var_41_3.enabled = true

					local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_2, typeof(DynamicBoneHelper))

					if var_41_4 then
						var_41_4:EnableDynamicBone(false)
					end

					arg_38_1:ShowWeapon(var_41_3.transform, false)

					arg_38_1.var_[var_41_0 .. "Animator"] = var_41_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_38_1.var_[var_41_0 .. "Animator"].applyRootMotion = true
					arg_38_1.var_[var_41_0 .. "LipSync"] = var_41_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_41_5 = arg_38_1.actors_["10045ui_story"]
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect10045ui_story == nil then
				arg_38_1.var_.characterEffect10045ui_story = var_41_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_7 = 0.200000002980232

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_7 and not isNil(var_41_5) then
				local var_41_8 = (arg_38_1.time_ - var_41_6) / var_41_7

				if arg_38_1.var_.characterEffect10045ui_story and not isNil(var_41_5) then
					arg_38_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_6 + var_41_7 and arg_38_1.time_ < var_41_6 + var_41_7 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect10045ui_story then
				arg_38_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_41_9 = 0
			local var_41_10 = 0.7

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_11 = arg_38_1:FormatText(StoryNameCfg[36].name)

				arg_38_1.leftNameTxt_.text = var_41_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_12 = arg_38_1:GetWordFromCfg(304081009)
				local var_41_13 = arg_38_1:FormatText(var_41_12.content)

				arg_38_1.text_.text = var_41_13

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_14 = 28
				local var_41_15 = utf8.len(var_41_13)
				local var_41_16 = var_41_14 <= 0 and var_41_10 or var_41_10 * (var_41_15 / var_41_14)

				if var_41_16 > 0 and var_41_10 < var_41_16 then
					arg_38_1.talkMaxDuration = var_41_16

					if var_41_16 + var_41_9 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_9
					end
				end

				arg_38_1.text_.text = var_41_13
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081009", "story_v_out_304081.awb") ~= 0 then
					local var_41_17 = manager.audio:GetVoiceLength("story_v_out_304081", "304081009", "story_v_out_304081.awb") / 1000

					if var_41_17 + var_41_9 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_9
					end

					if var_41_12.prefab_name ~= "" and arg_38_1.actors_[var_41_12.prefab_name] ~= nil then
						local var_41_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_12.prefab_name].transform, "story_v_out_304081", "304081009", "story_v_out_304081.awb")

						arg_38_1:RecordAudio("304081009", var_41_18)
						arg_38_1:RecordAudio("304081009", var_41_18)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_304081", "304081009", "story_v_out_304081.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_304081", "304081009", "story_v_out_304081.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_19 = math.max(var_41_10, arg_38_1.talkMaxDuration)

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_9) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_9 + var_41_19 and arg_38_1.time_ < var_41_9 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play304081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 304081010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play304081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10045ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10045ui_story == nil then
				arg_42_1.var_.characterEffect10045ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10045ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10045ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10045ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10045ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 1.1

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_8 = arg_42_1:GetWordFromCfg(304081010)
				local var_45_9 = arg_42_1:FormatText(var_45_8.content)

				arg_42_1.text_.text = var_45_9

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 44
				local var_45_11 = utf8.len(var_45_9)
				local var_45_12 = var_45_10 <= 0 and var_45_7 or var_45_7 * (var_45_11 / var_45_10)

				if var_45_12 > 0 and var_45_7 < var_45_12 then
					arg_42_1.talkMaxDuration = var_45_12

					if var_45_12 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_9
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_13 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_13 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_13

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_13 and arg_42_1.time_ < var_45_6 + var_45_13 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play304081011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 304081011
		arg_46_1.duration_ = 5.03

		local var_46_0 = {
			zh = 4.133,
			ja = 5.033
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play304081012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "10001_tpose"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_46_1.stage_.transform)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentInChildren(typeof(CharacterEffect))

					var_49_3.enabled = true

					local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_2, typeof(DynamicBoneHelper))

					if var_49_4 then
						var_49_4:EnableDynamicBone(false)
					end

					arg_46_1:ShowWeapon(var_49_3.transform, false)

					arg_46_1.var_[var_49_0 .. "Animator"] = var_49_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_46_1.var_[var_49_0 .. "Animator"].applyRootMotion = true
					arg_46_1.var_[var_49_0 .. "LipSync"] = var_49_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_49_5 = arg_46_1.actors_["10001_tpose"].transform
			local var_49_6 = 0

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.var_.moveOldPos10001_tpose = var_49_5.localPosition

				local var_49_7 = GameObjectTools.GetOrAddComponent(var_49_5.gameObject, typeof(DynamicBoneHelper))

				if var_49_7 then
					var_49_7:EnableDynamicBone(false)
				end
			end

			local var_49_8 = 0.001

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_8 then
				local var_49_9 = (arg_46_1.time_ - var_49_6) / var_49_8
				local var_49_10 = Vector3.New(0, -1.23, -5.8)

				var_49_5.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10001_tpose, var_49_10, var_49_9)

				local var_49_11 = manager.ui.mainCamera.transform.position - var_49_5.position

				var_49_5.forward = Vector3.New(var_49_11.x, var_49_11.y, var_49_11.z)

				local var_49_12 = var_49_5.localEulerAngles

				var_49_12.z = 0
				var_49_12.x = 0
				var_49_5.localEulerAngles = var_49_12
			end

			if arg_46_1.time_ >= var_49_6 + var_49_8 and arg_46_1.time_ < var_49_6 + var_49_8 + arg_49_0 then
				var_49_5.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_49_13 = manager.ui.mainCamera.transform.position - var_49_5.position

				var_49_5.forward = Vector3.New(var_49_13.x, var_49_13.y, var_49_13.z)

				local var_49_14 = var_49_5.localEulerAngles

				var_49_14.z = 0
				var_49_14.x = 0
				var_49_5.localEulerAngles = var_49_14

				local var_49_15 = GameObjectTools.GetOrAddComponent(var_49_5.gameObject, typeof(DynamicBoneHelper))

				if var_49_15 then
					var_49_15:EnableDynamicBone(true)
				end
			end

			local var_49_16 = arg_46_1.actors_["10001_tpose"]
			local var_49_17 = 0

			if var_49_17 < arg_46_1.time_ and arg_46_1.time_ <= var_49_17 + arg_49_0 and not isNil(var_49_16) and arg_46_1.var_.characterEffect10001_tpose == nil then
				arg_46_1.var_.characterEffect10001_tpose = var_49_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_18 = 0.200000002980232

			if var_49_17 <= arg_46_1.time_ and arg_46_1.time_ < var_49_17 + var_49_18 and not isNil(var_49_16) then
				local var_49_19 = (arg_46_1.time_ - var_49_17) / var_49_18

				if arg_46_1.var_.characterEffect10001_tpose and not isNil(var_49_16) then
					arg_46_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_17 + var_49_18 and arg_46_1.time_ < var_49_17 + var_49_18 + arg_49_0 and not isNil(var_49_16) and arg_46_1.var_.characterEffect10001_tpose then
				arg_46_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_49_20 = 0

			if var_49_20 < arg_46_1.time_ and arg_46_1.time_ <= var_49_20 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_49_22 = 0
			local var_49_23 = 0.275

			if var_49_22 < arg_46_1.time_ and arg_46_1.time_ <= var_49_22 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_24 = arg_46_1:FormatText(StoryNameCfg[24].name)

				arg_46_1.leftNameTxt_.text = var_49_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_25 = arg_46_1:GetWordFromCfg(304081011)
				local var_49_26 = arg_46_1:FormatText(var_49_25.content)

				arg_46_1.text_.text = var_49_26

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_27 = 11
				local var_49_28 = utf8.len(var_49_26)
				local var_49_29 = var_49_27 <= 0 and var_49_23 or var_49_23 * (var_49_28 / var_49_27)

				if var_49_29 > 0 and var_49_23 < var_49_29 then
					arg_46_1.talkMaxDuration = var_49_29

					if var_49_29 + var_49_22 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_29 + var_49_22
					end
				end

				arg_46_1.text_.text = var_49_26
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081011", "story_v_out_304081.awb") ~= 0 then
					local var_49_30 = manager.audio:GetVoiceLength("story_v_out_304081", "304081011", "story_v_out_304081.awb") / 1000

					if var_49_30 + var_49_22 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_30 + var_49_22
					end

					if var_49_25.prefab_name ~= "" and arg_46_1.actors_[var_49_25.prefab_name] ~= nil then
						local var_49_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_25.prefab_name].transform, "story_v_out_304081", "304081011", "story_v_out_304081.awb")

						arg_46_1:RecordAudio("304081011", var_49_31)
						arg_46_1:RecordAudio("304081011", var_49_31)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_304081", "304081011", "story_v_out_304081.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_304081", "304081011", "story_v_out_304081.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_32 = math.max(var_49_23, arg_46_1.talkMaxDuration)

			if var_49_22 <= arg_46_1.time_ and arg_46_1.time_ < var_49_22 + var_49_32 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_22) / var_49_32

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_22 + var_49_32 and arg_46_1.time_ < var_49_22 + var_49_32 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play304081012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 304081012
		arg_50_1.duration_ = 7.13

		local var_50_0 = {
			zh = 5.8,
			ja = 7.133
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play304081013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10045ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos10045ui_story = var_53_0.localPosition
			end

			local var_53_2 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2
				local var_53_4 = Vector3.New(-0.7, -1.18, -6.05)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10045ui_story, var_53_4, var_53_3)

				local var_53_5 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_5.x, var_53_5.y, var_53_5.z)

				local var_53_6 = var_53_0.localEulerAngles

				var_53_6.z = 0
				var_53_6.x = 0
				var_53_0.localEulerAngles = var_53_6
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_53_7 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_7.x, var_53_7.y, var_53_7.z)

				local var_53_8 = var_53_0.localEulerAngles

				var_53_8.z = 0
				var_53_8.x = 0
				var_53_0.localEulerAngles = var_53_8
			end

			local var_53_9 = arg_50_1.actors_["10001_tpose"].transform
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_9.localPosition

				local var_53_11 = GameObjectTools.GetOrAddComponent(var_53_9.gameObject, typeof(DynamicBoneHelper))

				if var_53_11 then
					var_53_11:EnableDynamicBone(false)
				end
			end

			local var_53_12 = 0.001

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_10) / var_53_12
				local var_53_14 = Vector3.New(0.7, -1.23, -5.8)

				var_53_9.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, var_53_14, var_53_13)

				local var_53_15 = manager.ui.mainCamera.transform.position - var_53_9.position

				var_53_9.forward = Vector3.New(var_53_15.x, var_53_15.y, var_53_15.z)

				local var_53_16 = var_53_9.localEulerAngles

				var_53_16.z = 0
				var_53_16.x = 0
				var_53_9.localEulerAngles = var_53_16
			end

			if arg_50_1.time_ >= var_53_10 + var_53_12 and arg_50_1.time_ < var_53_10 + var_53_12 + arg_53_0 then
				var_53_9.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_53_17 = manager.ui.mainCamera.transform.position - var_53_9.position

				var_53_9.forward = Vector3.New(var_53_17.x, var_53_17.y, var_53_17.z)

				local var_53_18 = var_53_9.localEulerAngles

				var_53_18.z = 0
				var_53_18.x = 0
				var_53_9.localEulerAngles = var_53_18

				local var_53_19 = GameObjectTools.GetOrAddComponent(var_53_9.gameObject, typeof(DynamicBoneHelper))

				if var_53_19 then
					var_53_19:EnableDynamicBone(true)
				end
			end

			local var_53_20 = arg_50_1.actors_["10045ui_story"]
			local var_53_21 = 0

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 and not isNil(var_53_20) and arg_50_1.var_.characterEffect10045ui_story == nil then
				arg_50_1.var_.characterEffect10045ui_story = var_53_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_22 = 0.200000002980232

			if var_53_21 <= arg_50_1.time_ and arg_50_1.time_ < var_53_21 + var_53_22 and not isNil(var_53_20) then
				local var_53_23 = (arg_50_1.time_ - var_53_21) / var_53_22

				if arg_50_1.var_.characterEffect10045ui_story and not isNil(var_53_20) then
					arg_50_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_21 + var_53_22 and arg_50_1.time_ < var_53_21 + var_53_22 + arg_53_0 and not isNil(var_53_20) and arg_50_1.var_.characterEffect10045ui_story then
				arg_50_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_53_24 = arg_50_1.actors_["10001_tpose"]
			local var_53_25 = 0

			if var_53_25 < arg_50_1.time_ and arg_50_1.time_ <= var_53_25 + arg_53_0 and not isNil(var_53_24) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_26 = 0.200000002980232

			if var_53_25 <= arg_50_1.time_ and arg_50_1.time_ < var_53_25 + var_53_26 and not isNil(var_53_24) then
				local var_53_27 = (arg_50_1.time_ - var_53_25) / var_53_26

				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_24) then
					local var_53_28 = Mathf.Lerp(0, 0.5, var_53_27)

					arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_50_1.var_.characterEffect10001_tpose.fillRatio = var_53_28
				end
			end

			if arg_50_1.time_ >= var_53_25 + var_53_26 and arg_50_1.time_ < var_53_25 + var_53_26 + arg_53_0 and not isNil(var_53_24) and arg_50_1.var_.characterEffect10001_tpose then
				local var_53_29 = 0.5

				arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_50_1.var_.characterEffect10001_tpose.fillRatio = var_53_29
			end

			local var_53_30 = 0

			if var_53_30 < arg_50_1.time_ and arg_50_1.time_ <= var_53_30 + arg_53_0 then
				arg_50_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action3_1")
			end

			local var_53_31 = 0

			if var_53_31 < arg_50_1.time_ and arg_50_1.time_ <= var_53_31 + arg_53_0 then
				arg_50_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_32 = 0
			local var_53_33 = 0.6

			if var_53_32 < arg_50_1.time_ and arg_50_1.time_ <= var_53_32 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_34 = arg_50_1:FormatText(StoryNameCfg[45].name)

				arg_50_1.leftNameTxt_.text = var_53_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_35 = arg_50_1:GetWordFromCfg(304081012)
				local var_53_36 = arg_50_1:FormatText(var_53_35.content)

				arg_50_1.text_.text = var_53_36

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_37 = 24
				local var_53_38 = utf8.len(var_53_36)
				local var_53_39 = var_53_37 <= 0 and var_53_33 or var_53_33 * (var_53_38 / var_53_37)

				if var_53_39 > 0 and var_53_33 < var_53_39 then
					arg_50_1.talkMaxDuration = var_53_39

					if var_53_39 + var_53_32 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_39 + var_53_32
					end
				end

				arg_50_1.text_.text = var_53_36
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081012", "story_v_out_304081.awb") ~= 0 then
					local var_53_40 = manager.audio:GetVoiceLength("story_v_out_304081", "304081012", "story_v_out_304081.awb") / 1000

					if var_53_40 + var_53_32 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_40 + var_53_32
					end

					if var_53_35.prefab_name ~= "" and arg_50_1.actors_[var_53_35.prefab_name] ~= nil then
						local var_53_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_35.prefab_name].transform, "story_v_out_304081", "304081012", "story_v_out_304081.awb")

						arg_50_1:RecordAudio("304081012", var_53_41)
						arg_50_1:RecordAudio("304081012", var_53_41)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_304081", "304081012", "story_v_out_304081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_304081", "304081012", "story_v_out_304081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_42 = math.max(var_53_33, arg_50_1.talkMaxDuration)

			if var_53_32 <= arg_50_1.time_ and arg_50_1.time_ < var_53_32 + var_53_42 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_32) / var_53_42

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_32 + var_53_42 and arg_50_1.time_ < var_53_32 + var_53_42 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play304081013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 304081013
		arg_54_1.duration_ = 9.03

		local var_54_0 = {
			zh = 7.4,
			ja = 9.033
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play304081014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10001_tpose"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10001_tpose == nil then
				arg_54_1.var_.characterEffect10001_tpose = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect10001_tpose and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect10001_tpose then
				arg_54_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["10045ui_story"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10045ui_story == nil then
				arg_54_1.var_.characterEffect10045ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect10045ui_story and not isNil(var_57_4) then
					local var_57_8 = Mathf.Lerp(0, 0.5, var_57_7)

					arg_54_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10045ui_story.fillRatio = var_57_8
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10045ui_story then
				local var_57_9 = 0.5

				arg_54_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10045ui_story.fillRatio = var_57_9
			end

			local var_57_10 = 0
			local var_57_11 = 0.675

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_12 = arg_54_1:FormatText(StoryNameCfg[24].name)

				arg_54_1.leftNameTxt_.text = var_57_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_13 = arg_54_1:GetWordFromCfg(304081013)
				local var_57_14 = arg_54_1:FormatText(var_57_13.content)

				arg_54_1.text_.text = var_57_14

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 27
				local var_57_16 = utf8.len(var_57_14)
				local var_57_17 = var_57_15 <= 0 and var_57_11 or var_57_11 * (var_57_16 / var_57_15)

				if var_57_17 > 0 and var_57_11 < var_57_17 then
					arg_54_1.talkMaxDuration = var_57_17

					if var_57_17 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_17 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_14
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081013", "story_v_out_304081.awb") ~= 0 then
					local var_57_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081013", "story_v_out_304081.awb") / 1000

					if var_57_18 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_10
					end

					if var_57_13.prefab_name ~= "" and arg_54_1.actors_[var_57_13.prefab_name] ~= nil then
						local var_57_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_13.prefab_name].transform, "story_v_out_304081", "304081013", "story_v_out_304081.awb")

						arg_54_1:RecordAudio("304081013", var_57_19)
						arg_54_1:RecordAudio("304081013", var_57_19)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_304081", "304081013", "story_v_out_304081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_304081", "304081013", "story_v_out_304081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_20 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_20 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_20

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_20 and arg_54_1.time_ < var_57_10 + var_57_20 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play304081014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 304081014
		arg_58_1.duration_ = 6.47

		local var_58_0 = {
			zh = 4.966,
			ja = 6.466
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
				arg_58_0:Play304081015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_2")
			end

			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_61_2 = 0
			local var_61_3 = 0.5

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_4 = arg_58_1:FormatText(StoryNameCfg[24].name)

				arg_58_1.leftNameTxt_.text = var_61_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(304081014)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 20
				local var_61_8 = utf8.len(var_61_6)
				local var_61_9 = var_61_7 <= 0 and var_61_3 or var_61_3 * (var_61_8 / var_61_7)

				if var_61_9 > 0 and var_61_3 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081014", "story_v_out_304081.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081014", "story_v_out_304081.awb") / 1000

					if var_61_10 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_2
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_304081", "304081014", "story_v_out_304081.awb")

						arg_58_1:RecordAudio("304081014", var_61_11)
						arg_58_1:RecordAudio("304081014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_304081", "304081014", "story_v_out_304081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_304081", "304081014", "story_v_out_304081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_12 and arg_58_1.time_ < var_61_2 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play304081015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 304081015
		arg_62_1.duration_ = 10.87

		local var_62_0 = {
			zh = 8.6,
			ja = 10.866
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play304081016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10045ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10045ui_story == nil then
				arg_62_1.var_.characterEffect10045ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect10045ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect10045ui_story then
				arg_62_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["10001_tpose"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect10001_tpose == nil then
				arg_62_1.var_.characterEffect10001_tpose = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.200000002980232

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect10001_tpose and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_62_1.var_.characterEffect10001_tpose.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect10001_tpose then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_62_1.var_.characterEffect10001_tpose.fillRatio = var_65_9
			end

			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action3_2")
			end

			local var_65_11 = 0
			local var_65_12 = 0.65

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_13 = arg_62_1:FormatText(StoryNameCfg[45].name)

				arg_62_1.leftNameTxt_.text = var_65_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(304081015)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_16 = 26
				local var_65_17 = utf8.len(var_65_15)
				local var_65_18 = var_65_16 <= 0 and var_65_12 or var_65_12 * (var_65_17 / var_65_16)

				if var_65_18 > 0 and var_65_12 < var_65_18 then
					arg_62_1.talkMaxDuration = var_65_18

					if var_65_18 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081015", "story_v_out_304081.awb") ~= 0 then
					local var_65_19 = manager.audio:GetVoiceLength("story_v_out_304081", "304081015", "story_v_out_304081.awb") / 1000

					if var_65_19 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_19 + var_65_11
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_out_304081", "304081015", "story_v_out_304081.awb")

						arg_62_1:RecordAudio("304081015", var_65_20)
						arg_62_1:RecordAudio("304081015", var_65_20)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_304081", "304081015", "story_v_out_304081.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_304081", "304081015", "story_v_out_304081.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_21 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_21 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_11) / var_65_21

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_11 + var_65_21 and arg_62_1.time_ < var_65_11 + var_65_21 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play304081016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 304081016
		arg_66_1.duration_ = 6.6

		local var_66_0 = {
			zh = 5.133,
			ja = 6.6
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play304081017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_1 = 0
			local var_69_2 = 0.4

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_3 = arg_66_1:FormatText(StoryNameCfg[45].name)

				arg_66_1.leftNameTxt_.text = var_69_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(304081016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 16
				local var_69_7 = utf8.len(var_69_5)
				local var_69_8 = var_69_6 <= 0 and var_69_2 or var_69_2 * (var_69_7 / var_69_6)

				if var_69_8 > 0 and var_69_2 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081016", "story_v_out_304081.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081016", "story_v_out_304081.awb") / 1000

					if var_69_9 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_1
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_304081", "304081016", "story_v_out_304081.awb")

						arg_66_1:RecordAudio("304081016", var_69_10)
						arg_66_1:RecordAudio("304081016", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_304081", "304081016", "story_v_out_304081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_304081", "304081016", "story_v_out_304081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_11 and arg_66_1.time_ < var_69_1 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play304081017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304081017
		arg_70_1.duration_ = 11.47

		local var_70_0 = {
			zh = 8.1,
			ja = 11.466
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304081018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10001_tpose"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10001_tpose == nil then
				arg_70_1.var_.characterEffect10001_tpose = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10001_tpose and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10001_tpose then
				arg_70_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["10045ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect10045ui_story == nil then
				arg_70_1.var_.characterEffect10045ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect10045ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10045ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect10045ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10045ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0
			local var_73_11 = 0.9

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_12 = arg_70_1:FormatText(StoryNameCfg[24].name)

				arg_70_1.leftNameTxt_.text = var_73_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_13 = arg_70_1:GetWordFromCfg(304081017)
				local var_73_14 = arg_70_1:FormatText(var_73_13.content)

				arg_70_1.text_.text = var_73_14

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 36
				local var_73_16 = utf8.len(var_73_14)
				local var_73_17 = var_73_15 <= 0 and var_73_11 or var_73_11 * (var_73_16 / var_73_15)

				if var_73_17 > 0 and var_73_11 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17

					if var_73_17 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_14
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081017", "story_v_out_304081.awb") ~= 0 then
					local var_73_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081017", "story_v_out_304081.awb") / 1000

					if var_73_18 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_10
					end

					if var_73_13.prefab_name ~= "" and arg_70_1.actors_[var_73_13.prefab_name] ~= nil then
						local var_73_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_13.prefab_name].transform, "story_v_out_304081", "304081017", "story_v_out_304081.awb")

						arg_70_1:RecordAudio("304081017", var_73_19)
						arg_70_1:RecordAudio("304081017", var_73_19)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_304081", "304081017", "story_v_out_304081.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_304081", "304081017", "story_v_out_304081.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_20 and arg_70_1.time_ < var_73_10 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304081018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304081018
		arg_74_1.duration_ = 7.7

		local var_74_0 = {
			zh = 4.7,
			ja = 7.7
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
				arg_74_0:Play304081019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_77_2 = 0
			local var_77_3 = 0.4

			if var_77_2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_4 = arg_74_1:FormatText(StoryNameCfg[24].name)

				arg_74_1.leftNameTxt_.text = var_77_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_5 = arg_74_1:GetWordFromCfg(304081018)
				local var_77_6 = arg_74_1:FormatText(var_77_5.content)

				arg_74_1.text_.text = var_77_6

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 16
				local var_77_8 = utf8.len(var_77_6)
				local var_77_9 = var_77_7 <= 0 and var_77_3 or var_77_3 * (var_77_8 / var_77_7)

				if var_77_9 > 0 and var_77_3 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_6
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081018", "story_v_out_304081.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081018", "story_v_out_304081.awb") / 1000

					if var_77_10 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_2
					end

					if var_77_5.prefab_name ~= "" and arg_74_1.actors_[var_77_5.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_5.prefab_name].transform, "story_v_out_304081", "304081018", "story_v_out_304081.awb")

						arg_74_1:RecordAudio("304081018", var_77_11)
						arg_74_1:RecordAudio("304081018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304081", "304081018", "story_v_out_304081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304081", "304081018", "story_v_out_304081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_12 and arg_74_1.time_ < var_77_2 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304081019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304081019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play304081020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10045ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos10045ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10045ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["10001_tpose"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos10001_tpose = var_81_9.localPosition

				local var_81_11 = GameObjectTools.GetOrAddComponent(var_81_9.gameObject, typeof(DynamicBoneHelper))

				if var_81_11 then
					var_81_11:EnableDynamicBone(false)
				end
			end

			local var_81_12 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_10) / var_81_12
				local var_81_14 = Vector3.New(0, 100, 0)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10001_tpose, var_81_14, var_81_13)

				local var_81_15 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_15.x, var_81_15.y, var_81_15.z)

				local var_81_16 = var_81_9.localEulerAngles

				var_81_16.z = 0
				var_81_16.x = 0
				var_81_9.localEulerAngles = var_81_16
			end

			if arg_78_1.time_ >= var_81_10 + var_81_12 and arg_78_1.time_ < var_81_10 + var_81_12 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, 100, 0)

				local var_81_17 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_17.x, var_81_17.y, var_81_17.z)

				local var_81_18 = var_81_9.localEulerAngles

				var_81_18.z = 0
				var_81_18.x = 0
				var_81_9.localEulerAngles = var_81_18

				local var_81_19 = GameObjectTools.GetOrAddComponent(var_81_9.gameObject, typeof(DynamicBoneHelper))

				if var_81_19 then
					var_81_19:EnableDynamicBone(true)
				end
			end

			local var_81_20 = arg_78_1.actors_["10001_tpose"]
			local var_81_21 = 0

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 and not isNil(var_81_20) and arg_78_1.var_.characterEffect10001_tpose == nil then
				arg_78_1.var_.characterEffect10001_tpose = var_81_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_22 = 0.200000002980232

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_22 and not isNil(var_81_20) then
				local var_81_23 = (arg_78_1.time_ - var_81_21) / var_81_22

				if arg_78_1.var_.characterEffect10001_tpose and not isNil(var_81_20) then
					local var_81_24 = Mathf.Lerp(0, 0.5, var_81_23)

					arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_78_1.var_.characterEffect10001_tpose.fillRatio = var_81_24
				end
			end

			if arg_78_1.time_ >= var_81_21 + var_81_22 and arg_78_1.time_ < var_81_21 + var_81_22 + arg_81_0 and not isNil(var_81_20) and arg_78_1.var_.characterEffect10001_tpose then
				local var_81_25 = 0.5

				arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_78_1.var_.characterEffect10001_tpose.fillRatio = var_81_25
			end

			local var_81_26 = 0
			local var_81_27 = 1.05

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_28 = arg_78_1:GetWordFromCfg(304081019)
				local var_81_29 = arg_78_1:FormatText(var_81_28.content)

				arg_78_1.text_.text = var_81_29

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_30 = 42
				local var_81_31 = utf8.len(var_81_29)
				local var_81_32 = var_81_30 <= 0 and var_81_27 or var_81_27 * (var_81_31 / var_81_30)

				if var_81_32 > 0 and var_81_27 < var_81_32 then
					arg_78_1.talkMaxDuration = var_81_32

					if var_81_32 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_32 + var_81_26
					end
				end

				arg_78_1.text_.text = var_81_29
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_33 = math.max(var_81_27, arg_78_1.talkMaxDuration)

			if var_81_26 <= arg_78_1.time_ and arg_78_1.time_ < var_81_26 + var_81_33 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_26) / var_81_33

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_26 + var_81_33 and arg_78_1.time_ < var_81_26 + var_81_33 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play304081020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304081020
		arg_82_1.duration_ = 13.9

		local var_82_0 = {
			zh = 9.633,
			ja = 13.9
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play304081021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10001_tpose"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos10001_tpose = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0.7, -1.23, -5.8)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10001_tpose, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["10001_tpose"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10001_tpose == nil then
				arg_82_1.var_.characterEffect10001_tpose = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect10001_tpose and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect10001_tpose then
				arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action445")
			end

			local var_85_16 = 0

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_85_17 = 0
			local var_85_18 = 0.975

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_19 = arg_82_1:FormatText(StoryNameCfg[24].name)

				arg_82_1.leftNameTxt_.text = var_85_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_20 = arg_82_1:GetWordFromCfg(304081020)
				local var_85_21 = arg_82_1:FormatText(var_85_20.content)

				arg_82_1.text_.text = var_85_21

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_22 = 39
				local var_85_23 = utf8.len(var_85_21)
				local var_85_24 = var_85_22 <= 0 and var_85_18 or var_85_18 * (var_85_23 / var_85_22)

				if var_85_24 > 0 and var_85_18 < var_85_24 then
					arg_82_1.talkMaxDuration = var_85_24

					if var_85_24 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_17
					end
				end

				arg_82_1.text_.text = var_85_21
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081020", "story_v_out_304081.awb") ~= 0 then
					local var_85_25 = manager.audio:GetVoiceLength("story_v_out_304081", "304081020", "story_v_out_304081.awb") / 1000

					if var_85_25 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_25 + var_85_17
					end

					if var_85_20.prefab_name ~= "" and arg_82_1.actors_[var_85_20.prefab_name] ~= nil then
						local var_85_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_20.prefab_name].transform, "story_v_out_304081", "304081020", "story_v_out_304081.awb")

						arg_82_1:RecordAudio("304081020", var_85_26)
						arg_82_1:RecordAudio("304081020", var_85_26)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_304081", "304081020", "story_v_out_304081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_304081", "304081020", "story_v_out_304081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_27 = math.max(var_85_18, arg_82_1.talkMaxDuration)

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_27 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_17) / var_85_27

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_17 + var_85_27 and arg_82_1.time_ < var_85_17 + var_85_27 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play304081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304081021
		arg_86_1.duration_ = 7.7

		local var_86_0 = {
			zh = 7.333,
			ja = 7.7
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
				arg_86_0:Play304081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10045ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos10045ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(-0.7, -1.18, -6.05)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10045ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["10045ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect10045ui_story == nil then
				arg_86_1.var_.characterEffect10045ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect10045ui_story and not isNil(var_89_9) then
					arg_86_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect10045ui_story then
				arg_86_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_89_13 = arg_86_1.actors_["10001_tpose"]
			local var_89_14 = 0

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 and not isNil(var_89_13) and arg_86_1.var_.characterEffect10001_tpose == nil then
				arg_86_1.var_.characterEffect10001_tpose = var_89_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_15 = 0.200000002980232

			if var_89_14 <= arg_86_1.time_ and arg_86_1.time_ < var_89_14 + var_89_15 and not isNil(var_89_13) then
				local var_89_16 = (arg_86_1.time_ - var_89_14) / var_89_15

				if arg_86_1.var_.characterEffect10001_tpose and not isNil(var_89_13) then
					local var_89_17 = Mathf.Lerp(0, 0.5, var_89_16)

					arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_86_1.var_.characterEffect10001_tpose.fillRatio = var_89_17
				end
			end

			if arg_86_1.time_ >= var_89_14 + var_89_15 and arg_86_1.time_ < var_89_14 + var_89_15 + arg_89_0 and not isNil(var_89_13) and arg_86_1.var_.characterEffect10001_tpose then
				local var_89_18 = 0.5

				arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_86_1.var_.characterEffect10001_tpose.fillRatio = var_89_18
			end

			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 then
				arg_86_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action4_1")
			end

			local var_89_20 = 0

			if var_89_20 < arg_86_1.time_ and arg_86_1.time_ <= var_89_20 + arg_89_0 then
				arg_86_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_21 = 0
			local var_89_22 = 0.65

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_23 = arg_86_1:FormatText(StoryNameCfg[45].name)

				arg_86_1.leftNameTxt_.text = var_89_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_24 = arg_86_1:GetWordFromCfg(304081021)
				local var_89_25 = arg_86_1:FormatText(var_89_24.content)

				arg_86_1.text_.text = var_89_25

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_26 = 26
				local var_89_27 = utf8.len(var_89_25)
				local var_89_28 = var_89_26 <= 0 and var_89_22 or var_89_22 * (var_89_27 / var_89_26)

				if var_89_28 > 0 and var_89_22 < var_89_28 then
					arg_86_1.talkMaxDuration = var_89_28

					if var_89_28 + var_89_21 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_28 + var_89_21
					end
				end

				arg_86_1.text_.text = var_89_25
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081021", "story_v_out_304081.awb") ~= 0 then
					local var_89_29 = manager.audio:GetVoiceLength("story_v_out_304081", "304081021", "story_v_out_304081.awb") / 1000

					if var_89_29 + var_89_21 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_29 + var_89_21
					end

					if var_89_24.prefab_name ~= "" and arg_86_1.actors_[var_89_24.prefab_name] ~= nil then
						local var_89_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_24.prefab_name].transform, "story_v_out_304081", "304081021", "story_v_out_304081.awb")

						arg_86_1:RecordAudio("304081021", var_89_30)
						arg_86_1:RecordAudio("304081021", var_89_30)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304081", "304081021", "story_v_out_304081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304081", "304081021", "story_v_out_304081.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_31 = math.max(var_89_22, arg_86_1.talkMaxDuration)

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_31 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_21) / var_89_31

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_21 + var_89_31 and arg_86_1.time_ < var_89_21 + var_89_31 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play304081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304081022
		arg_90_1.duration_ = 8.6

		local var_90_0 = {
			zh = 5.7,
			ja = 8.6
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
				arg_90_0:Play304081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10001_tpose"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10001_tpose == nil then
				arg_90_1.var_.characterEffect10001_tpose = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect10001_tpose and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10001_tpose then
				arg_90_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["10045ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect10045ui_story == nil then
				arg_90_1.var_.characterEffect10045ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect10045ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10045ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect10045ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10045ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0
			local var_93_11 = 0.575

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_12 = arg_90_1:FormatText(StoryNameCfg[24].name)

				arg_90_1.leftNameTxt_.text = var_93_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_13 = arg_90_1:GetWordFromCfg(304081022)
				local var_93_14 = arg_90_1:FormatText(var_93_13.content)

				arg_90_1.text_.text = var_93_14

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_15 = 23
				local var_93_16 = utf8.len(var_93_14)
				local var_93_17 = var_93_15 <= 0 and var_93_11 or var_93_11 * (var_93_16 / var_93_15)

				if var_93_17 > 0 and var_93_11 < var_93_17 then
					arg_90_1.talkMaxDuration = var_93_17

					if var_93_17 + var_93_10 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_17 + var_93_10
					end
				end

				arg_90_1.text_.text = var_93_14
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081022", "story_v_out_304081.awb") ~= 0 then
					local var_93_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081022", "story_v_out_304081.awb") / 1000

					if var_93_18 + var_93_10 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_18 + var_93_10
					end

					if var_93_13.prefab_name ~= "" and arg_90_1.actors_[var_93_13.prefab_name] ~= nil then
						local var_93_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_13.prefab_name].transform, "story_v_out_304081", "304081022", "story_v_out_304081.awb")

						arg_90_1:RecordAudio("304081022", var_93_19)
						arg_90_1:RecordAudio("304081022", var_93_19)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_304081", "304081022", "story_v_out_304081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_304081", "304081022", "story_v_out_304081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_20 = math.max(var_93_11, arg_90_1.talkMaxDuration)

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_20 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_10) / var_93_20

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_10 + var_93_20 and arg_90_1.time_ < var_93_10 + var_93_20 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304081023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304081023
		arg_94_1.duration_ = 11.7

		local var_94_0 = {
			zh = 9.066,
			ja = 11.7
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
				arg_94_0:Play304081024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = 0
			local var_97_3 = 0.8

			if var_97_2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_4 = arg_94_1:FormatText(StoryNameCfg[24].name)

				arg_94_1.leftNameTxt_.text = var_97_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:GetWordFromCfg(304081023)
				local var_97_6 = arg_94_1:FormatText(var_97_5.content)

				arg_94_1.text_.text = var_97_6

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 32
				local var_97_8 = utf8.len(var_97_6)
				local var_97_9 = var_97_7 <= 0 and var_97_3 or var_97_3 * (var_97_8 / var_97_7)

				if var_97_9 > 0 and var_97_3 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_6
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081023", "story_v_out_304081.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081023", "story_v_out_304081.awb") / 1000

					if var_97_10 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_2
					end

					if var_97_5.prefab_name ~= "" and arg_94_1.actors_[var_97_5.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_5.prefab_name].transform, "story_v_out_304081", "304081023", "story_v_out_304081.awb")

						arg_94_1:RecordAudio("304081023", var_97_11)
						arg_94_1:RecordAudio("304081023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304081", "304081023", "story_v_out_304081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304081", "304081023", "story_v_out_304081.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_12 and arg_94_1.time_ < var_97_2 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304081024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304081024
		arg_98_1.duration_ = 3.4

		local var_98_0 = {
			zh = 2.966,
			ja = 3.4
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
				arg_98_0:Play304081025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10045ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10045ui_story == nil then
				arg_98_1.var_.characterEffect10045ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10045ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10045ui_story then
				arg_98_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["10001_tpose"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10001_tpose == nil then
				arg_98_1.var_.characterEffect10001_tpose = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect10001_tpose and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_98_1.var_.characterEffect10001_tpose.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10001_tpose then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_98_1.var_.characterEffect10001_tpose.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045actionlink/10045action442")
			end

			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_101_12 = 0
			local var_101_13 = 0.125

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_14 = arg_98_1:FormatText(StoryNameCfg[45].name)

				arg_98_1.leftNameTxt_.text = var_101_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_15 = arg_98_1:GetWordFromCfg(304081024)
				local var_101_16 = arg_98_1:FormatText(var_101_15.content)

				arg_98_1.text_.text = var_101_16

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 5
				local var_101_18 = utf8.len(var_101_16)
				local var_101_19 = var_101_17 <= 0 and var_101_13 or var_101_13 * (var_101_18 / var_101_17)

				if var_101_19 > 0 and var_101_13 < var_101_19 then
					arg_98_1.talkMaxDuration = var_101_19

					if var_101_19 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_16
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081024", "story_v_out_304081.awb") ~= 0 then
					local var_101_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081024", "story_v_out_304081.awb") / 1000

					if var_101_20 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_12
					end

					if var_101_15.prefab_name ~= "" and arg_98_1.actors_[var_101_15.prefab_name] ~= nil then
						local var_101_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_15.prefab_name].transform, "story_v_out_304081", "304081024", "story_v_out_304081.awb")

						arg_98_1:RecordAudio("304081024", var_101_21)
						arg_98_1:RecordAudio("304081024", var_101_21)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304081", "304081024", "story_v_out_304081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304081", "304081024", "story_v_out_304081.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_22 and arg_98_1.time_ < var_101_12 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play304081025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304081025
		arg_102_1.duration_ = 8.97

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play304081026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = "S0102"

			if arg_102_1.bgs_[var_105_0] == nil then
				local var_105_1 = Object.Instantiate(arg_102_1.paintGo_)

				var_105_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_105_0)
				var_105_1.name = var_105_0
				var_105_1.transform.parent = arg_102_1.stage_.transform
				var_105_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.bgs_[var_105_0] = var_105_1
			end

			local var_105_2 = 1.63333333333333

			if var_105_2 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				local var_105_3 = manager.ui.mainCamera.transform.localPosition
				local var_105_4 = Vector3.New(0, 0, 10) + Vector3.New(var_105_3.x, var_105_3.y, 0)
				local var_105_5 = arg_102_1.bgs_.S0102

				var_105_5.transform.localPosition = var_105_4
				var_105_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_6 = var_105_5:GetComponent("SpriteRenderer")

				if var_105_6 and var_105_6.sprite then
					local var_105_7 = (var_105_5.transform.localPosition - var_105_3).z
					local var_105_8 = manager.ui.mainCameraCom_
					local var_105_9 = 2 * var_105_7 * Mathf.Tan(var_105_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_105_10 = var_105_9 * var_105_8.aspect
					local var_105_11 = var_105_6.sprite.bounds.size.x
					local var_105_12 = var_105_6.sprite.bounds.size.y
					local var_105_13 = var_105_10 / var_105_11
					local var_105_14 = var_105_9 / var_105_12
					local var_105_15 = var_105_14 < var_105_13 and var_105_13 or var_105_14

					var_105_5.transform.localScale = Vector3.New(var_105_15, var_105_15, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "S0102" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_16 = 1.66666666666667

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			local var_105_17 = 0.3

			if arg_102_1.time_ >= var_105_16 + var_105_17 and arg_102_1.time_ < var_105_16 + var_105_17 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			local var_105_18 = 2.33333333333333

			if var_105_18 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_19 = 0.233333333333333

			if var_105_18 <= arg_102_1.time_ and arg_102_1.time_ < var_105_18 + var_105_19 then
				local var_105_20 = (arg_102_1.time_ - var_105_18) / var_105_19
				local var_105_21 = Color.New(1, 1, 1)

				var_105_21.a = Mathf.Lerp(1, 0, var_105_20)
				arg_102_1.mask_.color = var_105_21
			end

			if arg_102_1.time_ >= var_105_18 + var_105_19 and arg_102_1.time_ < var_105_18 + var_105_19 + arg_105_0 then
				local var_105_22 = Color.New(1, 1, 1)
				local var_105_23 = 0

				arg_102_1.mask_.enabled = false
				var_105_22.a = var_105_23
				arg_102_1.mask_.color = var_105_22
			end

			local var_105_24 = 2.73333333333333

			if var_105_24 < arg_102_1.time_ and arg_102_1.time_ <= var_105_24 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_25 = 0.233333333333333

			if var_105_24 <= arg_102_1.time_ and arg_102_1.time_ < var_105_24 + var_105_25 then
				local var_105_26 = (arg_102_1.time_ - var_105_24) / var_105_25
				local var_105_27 = Color.New(1, 1, 1)

				var_105_27.a = Mathf.Lerp(1, 0, var_105_26)
				arg_102_1.mask_.color = var_105_27
			end

			if arg_102_1.time_ >= var_105_24 + var_105_25 and arg_102_1.time_ < var_105_24 + var_105_25 + arg_105_0 then
				local var_105_28 = Color.New(1, 1, 1)
				local var_105_29 = 0

				arg_102_1.mask_.enabled = false
				var_105_28.a = var_105_29
				arg_102_1.mask_.color = var_105_28
			end

			local var_105_30 = 0

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_31 = 1.66666666666667

			if var_105_30 <= arg_102_1.time_ and arg_102_1.time_ < var_105_30 + var_105_31 then
				local var_105_32 = (arg_102_1.time_ - var_105_30) / var_105_31
				local var_105_33 = Color.New(0, 0, 0)

				var_105_33.a = Mathf.Lerp(0, 1, var_105_32)
				arg_102_1.mask_.color = var_105_33
			end

			if arg_102_1.time_ >= var_105_30 + var_105_31 and arg_102_1.time_ < var_105_30 + var_105_31 + arg_105_0 then
				local var_105_34 = Color.New(0, 0, 0)

				var_105_34.a = 1
				arg_102_1.mask_.color = var_105_34
			end

			local var_105_35 = 1.66666666666667

			if var_105_35 < arg_102_1.time_ and arg_102_1.time_ <= var_105_35 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = true

				arg_102_1:SetGaussion(false)
			end

			local var_105_36 = 0.666666666666667

			if var_105_35 <= arg_102_1.time_ and arg_102_1.time_ < var_105_35 + var_105_36 then
				local var_105_37 = (arg_102_1.time_ - var_105_35) / var_105_36
				local var_105_38 = Color.New(0, 0, 0)

				var_105_38.a = Mathf.Lerp(1, 0, var_105_37)
				arg_102_1.mask_.color = var_105_38
			end

			if arg_102_1.time_ >= var_105_35 + var_105_36 and arg_102_1.time_ < var_105_35 + var_105_36 + arg_105_0 then
				local var_105_39 = Color.New(0, 0, 0)
				local var_105_40 = 0

				arg_102_1.mask_.enabled = false
				var_105_39.a = var_105_40
				arg_102_1.mask_.color = var_105_39
			end

			local var_105_41 = arg_102_1.actors_["10045ui_story"].transform
			local var_105_42 = 1.66666666666667

			if var_105_42 < arg_102_1.time_ and arg_102_1.time_ <= var_105_42 + arg_105_0 then
				arg_102_1.var_.moveOldPos10045ui_story = var_105_41.localPosition
			end

			local var_105_43 = 0.001

			if var_105_42 <= arg_102_1.time_ and arg_102_1.time_ < var_105_42 + var_105_43 then
				local var_105_44 = (arg_102_1.time_ - var_105_42) / var_105_43
				local var_105_45 = Vector3.New(0, 100, 0)

				var_105_41.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10045ui_story, var_105_45, var_105_44)

				local var_105_46 = manager.ui.mainCamera.transform.position - var_105_41.position

				var_105_41.forward = Vector3.New(var_105_46.x, var_105_46.y, var_105_46.z)

				local var_105_47 = var_105_41.localEulerAngles

				var_105_47.z = 0
				var_105_47.x = 0
				var_105_41.localEulerAngles = var_105_47
			end

			if arg_102_1.time_ >= var_105_42 + var_105_43 and arg_102_1.time_ < var_105_42 + var_105_43 + arg_105_0 then
				var_105_41.localPosition = Vector3.New(0, 100, 0)

				local var_105_48 = manager.ui.mainCamera.transform.position - var_105_41.position

				var_105_41.forward = Vector3.New(var_105_48.x, var_105_48.y, var_105_48.z)

				local var_105_49 = var_105_41.localEulerAngles

				var_105_49.z = 0
				var_105_49.x = 0
				var_105_41.localEulerAngles = var_105_49
			end

			local var_105_50 = arg_102_1.actors_["10001_tpose"].transform
			local var_105_51 = 1.66666666666667

			if var_105_51 < arg_102_1.time_ and arg_102_1.time_ <= var_105_51 + arg_105_0 then
				arg_102_1.var_.moveOldPos10001_tpose = var_105_50.localPosition

				local var_105_52 = GameObjectTools.GetOrAddComponent(var_105_50.gameObject, typeof(DynamicBoneHelper))

				if var_105_52 then
					var_105_52:EnableDynamicBone(false)
				end
			end

			local var_105_53 = 0.001

			if var_105_51 <= arg_102_1.time_ and arg_102_1.time_ < var_105_51 + var_105_53 then
				local var_105_54 = (arg_102_1.time_ - var_105_51) / var_105_53
				local var_105_55 = Vector3.New(0, 100, 0)

				var_105_50.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10001_tpose, var_105_55, var_105_54)

				local var_105_56 = manager.ui.mainCamera.transform.position - var_105_50.position

				var_105_50.forward = Vector3.New(var_105_56.x, var_105_56.y, var_105_56.z)

				local var_105_57 = var_105_50.localEulerAngles

				var_105_57.z = 0
				var_105_57.x = 0
				var_105_50.localEulerAngles = var_105_57
			end

			if arg_102_1.time_ >= var_105_51 + var_105_53 and arg_102_1.time_ < var_105_51 + var_105_53 + arg_105_0 then
				var_105_50.localPosition = Vector3.New(0, 100, 0)

				local var_105_58 = manager.ui.mainCamera.transform.position - var_105_50.position

				var_105_50.forward = Vector3.New(var_105_58.x, var_105_58.y, var_105_58.z)

				local var_105_59 = var_105_50.localEulerAngles

				var_105_59.z = 0
				var_105_59.x = 0
				var_105_50.localEulerAngles = var_105_59

				local var_105_60 = GameObjectTools.GetOrAddComponent(var_105_50.gameObject, typeof(DynamicBoneHelper))

				if var_105_60 then
					var_105_60:EnableDynamicBone(true)
				end
			end

			local var_105_61 = arg_102_1.actors_["10045ui_story"]
			local var_105_62 = 1.66666666666667

			if var_105_62 < arg_102_1.time_ and arg_102_1.time_ <= var_105_62 + arg_105_0 and not isNil(var_105_61) and arg_102_1.var_.characterEffect10045ui_story == nil then
				arg_102_1.var_.characterEffect10045ui_story = var_105_61:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_63 = 0.200000002980232

			if var_105_62 <= arg_102_1.time_ and arg_102_1.time_ < var_105_62 + var_105_63 and not isNil(var_105_61) then
				local var_105_64 = (arg_102_1.time_ - var_105_62) / var_105_63

				if arg_102_1.var_.characterEffect10045ui_story and not isNil(var_105_61) then
					local var_105_65 = Mathf.Lerp(0, 0.5, var_105_64)

					arg_102_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10045ui_story.fillRatio = var_105_65
				end
			end

			if arg_102_1.time_ >= var_105_62 + var_105_63 and arg_102_1.time_ < var_105_62 + var_105_63 + arg_105_0 and not isNil(var_105_61) and arg_102_1.var_.characterEffect10045ui_story then
				local var_105_66 = 0.5

				arg_102_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10045ui_story.fillRatio = var_105_66
			end

			local var_105_67 = arg_102_1.bgs_.S0102.transform
			local var_105_68 = 1.66666666666667

			if var_105_68 < arg_102_1.time_ and arg_102_1.time_ <= var_105_68 + arg_105_0 then
				arg_102_1.var_.moveOldPosS0102 = var_105_67.localPosition
			end

			local var_105_69 = 2.3

			if var_105_68 <= arg_102_1.time_ and arg_102_1.time_ < var_105_68 + var_105_69 then
				local var_105_70 = (arg_102_1.time_ - var_105_68) / var_105_69
				local var_105_71 = Vector3.New(0, 1.09, 9)

				var_105_67.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPosS0102, var_105_71, var_105_70)
			end

			if arg_102_1.time_ >= var_105_68 + var_105_69 and arg_102_1.time_ < var_105_68 + var_105_69 + arg_105_0 then
				var_105_67.localPosition = Vector3.New(0, 1.09, 9)
			end

			local var_105_72 = manager.ui.mainCamera.transform
			local var_105_73 = 2.96666666666667

			if var_105_73 < arg_102_1.time_ and arg_102_1.time_ <= var_105_73 + arg_105_0 then
				local var_105_74 = arg_102_1.var_.effectqweer
				local var_105_75
				local var_105_76 = var_105_72

				if not var_105_74 then
					var_105_74 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_105_76)
					var_105_74.name = "qweer"
					arg_102_1.var_.effectqweer = var_105_74
				else
					var_105_74.transform:SetParent(var_105_76)
				end

				var_105_74.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_74.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_105_77 = 1.7777777777777777
				local var_105_78 = Screen.width / Screen.height
				local var_105_79 = var_105_78 / var_105_77
				local var_105_80 = Mathf.Max(var_105_77 / var_105_78, 1)

				var_105_74.transform.localScale = Vector3.New(var_105_74.transform.localScale.x * var_105_79, var_105_74.transform.localScale.y * var_105_80, var_105_74.transform.localScale.z)
			end

			local var_105_81 = manager.ui.mainCamera.transform
			local var_105_82 = 4.86489579901099

			if var_105_82 < arg_102_1.time_ and arg_102_1.time_ <= var_105_82 + arg_105_0 then
				local var_105_83 = arg_102_1.var_.effect43344
				local var_105_84
				local var_105_85 = var_105_81

				if not var_105_83 then
					var_105_83 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao2_end"), var_105_85)
					var_105_83.name = "43344"
					arg_102_1.var_.effect43344 = var_105_83
				else
					var_105_83.transform:SetParent(var_105_85)
				end

				var_105_83.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_83.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_105_86 = manager.ui.mainCamera.transform
			local var_105_87 = 6.46666666666667

			if var_105_87 < arg_102_1.time_ and arg_102_1.time_ <= var_105_87 + arg_105_0 then
				local var_105_88 = arg_102_1.var_.effect43344

				if var_105_88 then
					Object.Destroy(var_105_88)

					arg_102_1.var_.effect43344 = nil
				end
			end

			local var_105_89 = manager.ui.mainCamera.transform
			local var_105_90 = 2.09822913234433

			if var_105_90 < arg_102_1.time_ and arg_102_1.time_ <= var_105_90 + arg_105_0 then
				local var_105_91 = arg_102_1.var_.effect43344111
				local var_105_92
				local var_105_93 = var_105_89

				if not var_105_91 then
					var_105_91 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao2_start"), var_105_93)
					var_105_91.name = "43344111"
					arg_102_1.var_.effect43344111 = var_105_91
				else
					var_105_91.transform:SetParent(var_105_93)
				end

				var_105_91.transform.localPosition = Vector3.New(0, 0, 0)
				var_105_91.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_105_94 = manager.ui.mainCamera.transform
			local var_105_95 = 4.86489579901099

			if var_105_95 < arg_102_1.time_ and arg_102_1.time_ <= var_105_95 + arg_105_0 then
				local var_105_96 = arg_102_1.var_.effect43344111

				if var_105_96 then
					Object.Destroy(var_105_96)

					arg_102_1.var_.effect43344111 = nil
				end
			end

			local var_105_97 = 0.4
			local var_105_98 = 1

			if var_105_97 < arg_102_1.time_ and arg_102_1.time_ <= var_105_97 + arg_105_0 then
				local var_105_99 = "play"
				local var_105_100 = "effect"

				arg_102_1:AudioAction(var_105_99, var_105_100, "se_story_152", "se_story_152_clap", "")
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_101 = 3.96666666666667
			local var_105_102 = 1.125

			if var_105_101 < arg_102_1.time_ and arg_102_1.time_ <= var_105_101 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_103 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_103:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_103:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_103:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_104 = arg_102_1:GetWordFromCfg(304081025)
				local var_105_105 = arg_102_1:FormatText(var_105_104.content)

				arg_102_1.text_.text = var_105_105

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_106 = 45
				local var_105_107 = utf8.len(var_105_105)
				local var_105_108 = var_105_106 <= 0 and var_105_102 or var_105_102 * (var_105_107 / var_105_106)

				if var_105_108 > 0 and var_105_102 < var_105_108 then
					arg_102_1.talkMaxDuration = var_105_108
					var_105_101 = var_105_101 + 0.3

					if var_105_108 + var_105_101 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_108 + var_105_101
					end
				end

				arg_102_1.text_.text = var_105_105
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_109 = var_105_101 + 0.3
			local var_105_110 = math.max(var_105_102, arg_102_1.talkMaxDuration)

			if var_105_109 <= arg_102_1.time_ and arg_102_1.time_ < var_105_109 + var_105_110 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_109) / var_105_110

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_109 + var_105_110 and arg_102_1.time_ < var_105_109 + var_105_110 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0102",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.3,
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play304081026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304081026
		arg_108_1.duration_ = 6.63

		local var_108_0 = {
			zh = 5,
			ja = 6.633
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
				arg_108_0:Play304081027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.425

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[24].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(304081026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 17
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081026", "story_v_out_304081.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081026", "story_v_out_304081.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_304081", "304081026", "story_v_out_304081.awb")

						arg_108_1:RecordAudio("304081026", var_111_9)
						arg_108_1:RecordAudio("304081026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304081", "304081026", "story_v_out_304081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304081", "304081026", "story_v_out_304081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play304081027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304081027
		arg_112_1.duration_ = 10.9

		local var_112_0 = {
			zh = 5.933,
			ja = 10.9
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
				arg_112_0:Play304081028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.65

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[45].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(304081027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081027", "story_v_out_304081.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081027", "story_v_out_304081.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_304081", "304081027", "story_v_out_304081.awb")

						arg_112_1:RecordAudio("304081027", var_115_9)
						arg_112_1:RecordAudio("304081027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_304081", "304081027", "story_v_out_304081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_304081", "304081027", "story_v_out_304081.awb")
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
	Play304081028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 304081028
		arg_116_1.duration_ = 9.5

		local var_116_0 = {
			zh = 9.5,
			ja = 7.733
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play304081029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.825

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[45].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(304081028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 33
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081028", "story_v_out_304081.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081028", "story_v_out_304081.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_304081", "304081028", "story_v_out_304081.awb")

						arg_116_1:RecordAudio("304081028", var_119_9)
						arg_116_1:RecordAudio("304081028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_304081", "304081028", "story_v_out_304081.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_304081", "304081028", "story_v_out_304081.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play304081029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304081029
		arg_120_1.duration_ = 5.7

		local var_120_0 = {
			zh = 5.366,
			ja = 5.7
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
				arg_120_0:Play304081030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.4

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[45].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(304081029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 16
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081029", "story_v_out_304081.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081029", "story_v_out_304081.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_304081", "304081029", "story_v_out_304081.awb")

						arg_120_1:RecordAudio("304081029", var_123_9)
						arg_120_1:RecordAudio("304081029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304081", "304081029", "story_v_out_304081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304081", "304081029", "story_v_out_304081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play304081030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304081030
		arg_124_1.duration_ = 13.2

		local var_124_0 = {
			zh = 9.466,
			ja = 13.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play304081031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.2

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[24].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(304081030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081030", "story_v_out_304081.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081030", "story_v_out_304081.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_304081", "304081030", "story_v_out_304081.awb")

						arg_124_1:RecordAudio("304081030", var_127_9)
						arg_124_1:RecordAudio("304081030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304081", "304081030", "story_v_out_304081.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304081", "304081030", "story_v_out_304081.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play304081031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304081031
		arg_128_1.duration_ = 9.17

		local var_128_0 = {
			zh = 5.8,
			ja = 9.166
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
				arg_128_0:Play304081032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.9

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[24].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(304081031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 36
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081031", "story_v_out_304081.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081031", "story_v_out_304081.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_304081", "304081031", "story_v_out_304081.awb")

						arg_128_1:RecordAudio("304081031", var_131_9)
						arg_128_1:RecordAudio("304081031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304081", "304081031", "story_v_out_304081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304081", "304081031", "story_v_out_304081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304081032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304081032
		arg_132_1.duration_ = 10.93

		local var_132_0 = {
			zh = 7.2,
			ja = 10.933
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
				arg_132_0:Play304081033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.7

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[45].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(304081032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 28
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081032", "story_v_out_304081.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081032", "story_v_out_304081.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_304081", "304081032", "story_v_out_304081.awb")

						arg_132_1:RecordAudio("304081032", var_135_9)
						arg_132_1:RecordAudio("304081032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304081", "304081032", "story_v_out_304081.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304081", "304081032", "story_v_out_304081.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play304081033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 304081033
		arg_136_1.duration_ = 10.1

		local var_136_0 = {
			zh = 8.9,
			ja = 10.1
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
				arg_136_0:Play304081034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.725

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[45].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(304081033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081033", "story_v_out_304081.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081033", "story_v_out_304081.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_304081", "304081033", "story_v_out_304081.awb")

						arg_136_1:RecordAudio("304081033", var_139_9)
						arg_136_1:RecordAudio("304081033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_304081", "304081033", "story_v_out_304081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_304081", "304081033", "story_v_out_304081.awb")
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
	Play304081034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 304081034
		arg_140_1.duration_ = 3.67

		local var_140_0 = {
			zh = 3.666,
			ja = 1.333
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
				arg_140_0:Play304081035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["2018ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect2018ui_story == nil then
				arg_140_1.var_.characterEffect2018ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect2018ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect2018ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect2018ui_story then
				arg_140_1.var_.characterEffect2018ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["10045ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect10045ui_story == nil then
				arg_140_1.var_.characterEffect10045ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.200000002980232

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect10045ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10045ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect10045ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10045ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0
			local var_143_11 = 0.35

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_12 = arg_140_1:FormatText(StoryNameCfg[29].name)

				arg_140_1.leftNameTxt_.text = var_143_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_13 = arg_140_1:GetWordFromCfg(304081034)
				local var_143_14 = arg_140_1:FormatText(var_143_13.content)

				arg_140_1.text_.text = var_143_14

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_15 = 14
				local var_143_16 = utf8.len(var_143_14)
				local var_143_17 = var_143_15 <= 0 and var_143_11 or var_143_11 * (var_143_16 / var_143_15)

				if var_143_17 > 0 and var_143_11 < var_143_17 then
					arg_140_1.talkMaxDuration = var_143_17

					if var_143_17 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_17 + var_143_10
					end
				end

				arg_140_1.text_.text = var_143_14
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081034", "story_v_out_304081.awb") ~= 0 then
					local var_143_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081034", "story_v_out_304081.awb") / 1000

					if var_143_18 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_10
					end

					if var_143_13.prefab_name ~= "" and arg_140_1.actors_[var_143_13.prefab_name] ~= nil then
						local var_143_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_13.prefab_name].transform, "story_v_out_304081", "304081034", "story_v_out_304081.awb")

						arg_140_1:RecordAudio("304081034", var_143_19)
						arg_140_1:RecordAudio("304081034", var_143_19)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_304081", "304081034", "story_v_out_304081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_304081", "304081034", "story_v_out_304081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = math.max(var_143_11, arg_140_1.talkMaxDuration)

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_20 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_10) / var_143_20

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_10 + var_143_20 and arg_140_1.time_ < var_143_10 + var_143_20 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play304081035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 304081035
		arg_144_1.duration_ = 8.8

		local var_144_0 = {
			zh = 7.666,
			ja = 8.8
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
				arg_144_0:Play304081036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.bgs_.S0102.transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPosS0102 = var_147_0.localPosition
			end

			local var_147_2 = 2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 2.11, 4.58)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPosS0102, var_147_4, var_147_3)
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 2.11, 4.58)
			end

			local var_147_5 = manager.ui.mainCamera.transform
			local var_147_6 = 0

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				local var_147_7 = arg_144_1.var_.effect32131111
				local var_147_8
				local var_147_9 = var_147_5

				if not var_147_7 then
					var_147_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_147_9)
					var_147_7.name = "32131111"
					arg_144_1.var_.effect32131111 = var_147_7
				else
					var_147_7.transform:SetParent(var_147_9)
				end

				var_147_7.transform.localPosition = Vector3.New(0, 0, -2.91)
				var_147_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_147_10 = 1.7777777777777777
				local var_147_11 = Screen.width / Screen.height
				local var_147_12 = var_147_11 / var_147_10
				local var_147_13 = Mathf.Max(var_147_10 / var_147_11, 1)

				var_147_7.transform.localScale = Vector3.New(var_147_7.transform.localScale.x * var_147_12, var_147_7.transform.localScale.y * var_147_13, var_147_7.transform.localScale.z)
			end

			local var_147_14 = manager.ui.mainCamera.transform
			local var_147_15 = 0

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				local var_147_16 = arg_144_1.var_.effectqweer

				if var_147_16 then
					Object.Destroy(var_147_16)

					arg_144_1.var_.effectqweer = nil
				end
			end

			local var_147_17 = 0

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = false

				arg_144_1:SetGaussion(false)
			end

			local var_147_18 = 0.333333333333333

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_18 then
				local var_147_19 = (arg_144_1.time_ - var_147_17) / var_147_18
				local var_147_20 = Color.New(1, 1, 1)

				var_147_20.a = Mathf.Lerp(1, 0, var_147_19)
				arg_144_1.mask_.color = var_147_20
			end

			if arg_144_1.time_ >= var_147_17 + var_147_18 and arg_144_1.time_ < var_147_17 + var_147_18 + arg_147_0 then
				local var_147_21 = Color.New(1, 1, 1)
				local var_147_22 = 0

				arg_144_1.mask_.enabled = false
				var_147_21.a = var_147_22
				arg_144_1.mask_.color = var_147_21
			end

			local var_147_23 = 0

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			local var_147_24 = 2.25

			if arg_144_1.time_ >= var_147_23 + var_147_24 and arg_144_1.time_ < var_147_23 + var_147_24 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_25 = 1.7
			local var_147_26 = 0.55

			if var_147_25 < arg_144_1.time_ and arg_144_1.time_ <= var_147_25 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_27 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_27:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_28 = arg_144_1:FormatText(StoryNameCfg[24].name)

				arg_144_1.leftNameTxt_.text = var_147_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_29 = arg_144_1:GetWordFromCfg(304081035)
				local var_147_30 = arg_144_1:FormatText(var_147_29.content)

				arg_144_1.text_.text = var_147_30

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_31 = 22
				local var_147_32 = utf8.len(var_147_30)
				local var_147_33 = var_147_31 <= 0 and var_147_26 or var_147_26 * (var_147_32 / var_147_31)

				if var_147_33 > 0 and var_147_26 < var_147_33 then
					arg_144_1.talkMaxDuration = var_147_33
					var_147_25 = var_147_25 + 0.3

					if var_147_33 + var_147_25 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_33 + var_147_25
					end
				end

				arg_144_1.text_.text = var_147_30
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081035", "story_v_out_304081.awb") ~= 0 then
					local var_147_34 = manager.audio:GetVoiceLength("story_v_out_304081", "304081035", "story_v_out_304081.awb") / 1000

					if var_147_34 + var_147_25 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_34 + var_147_25
					end

					if var_147_29.prefab_name ~= "" and arg_144_1.actors_[var_147_29.prefab_name] ~= nil then
						local var_147_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_29.prefab_name].transform, "story_v_out_304081", "304081035", "story_v_out_304081.awb")

						arg_144_1:RecordAudio("304081035", var_147_35)
						arg_144_1:RecordAudio("304081035", var_147_35)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_304081", "304081035", "story_v_out_304081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_304081", "304081035", "story_v_out_304081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_36 = var_147_25 + 0.3
			local var_147_37 = math.max(var_147_26, arg_144_1.talkMaxDuration)

			if var_147_36 <= arg_144_1.time_ and arg_144_1.time_ < var_147_36 + var_147_37 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_36) / var_147_37

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_36 + var_147_37 and arg_144_1.time_ < var_147_36 + var_147_37 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0102",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.09, 9),
					endPos = Vector3.New(0, 2.11, 4.58),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play304081036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 304081036
		arg_150_1.duration_ = 7.4

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play304081037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10045ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos10045ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10045ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["10001_tpose"].transform
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.var_.moveOldPos10001_tpose = var_153_9.localPosition

				local var_153_11 = GameObjectTools.GetOrAddComponent(var_153_9.gameObject, typeof(DynamicBoneHelper))

				if var_153_11 then
					var_153_11:EnableDynamicBone(false)
				end
			end

			local var_153_12 = 0.001

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_10) / var_153_12
				local var_153_14 = Vector3.New(0, 100, 0)

				var_153_9.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10001_tpose, var_153_14, var_153_13)

				local var_153_15 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_15.x, var_153_15.y, var_153_15.z)

				local var_153_16 = var_153_9.localEulerAngles

				var_153_16.z = 0
				var_153_16.x = 0
				var_153_9.localEulerAngles = var_153_16
			end

			if arg_150_1.time_ >= var_153_10 + var_153_12 and arg_150_1.time_ < var_153_10 + var_153_12 + arg_153_0 then
				var_153_9.localPosition = Vector3.New(0, 100, 0)

				local var_153_17 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_17.x, var_153_17.y, var_153_17.z)

				local var_153_18 = var_153_9.localEulerAngles

				var_153_18.z = 0
				var_153_18.x = 0
				var_153_9.localEulerAngles = var_153_18

				local var_153_19 = GameObjectTools.GetOrAddComponent(var_153_9.gameObject, typeof(DynamicBoneHelper))

				if var_153_19 then
					var_153_19:EnableDynamicBone(true)
				end
			end

			local var_153_20 = arg_150_1.actors_["10001_tpose"]
			local var_153_21 = 0

			if var_153_21 < arg_150_1.time_ and arg_150_1.time_ <= var_153_21 + arg_153_0 and not isNil(var_153_20) and arg_150_1.var_.characterEffect10001_tpose == nil then
				arg_150_1.var_.characterEffect10001_tpose = var_153_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_22 = 0.200000002980232

			if var_153_21 <= arg_150_1.time_ and arg_150_1.time_ < var_153_21 + var_153_22 and not isNil(var_153_20) then
				local var_153_23 = (arg_150_1.time_ - var_153_21) / var_153_22

				if arg_150_1.var_.characterEffect10001_tpose and not isNil(var_153_20) then
					local var_153_24 = Mathf.Lerp(0, 0.5, var_153_23)

					arg_150_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_150_1.var_.characterEffect10001_tpose.fillRatio = var_153_24
				end
			end

			if arg_150_1.time_ >= var_153_21 + var_153_22 and arg_150_1.time_ < var_153_21 + var_153_22 + arg_153_0 and not isNil(var_153_20) and arg_150_1.var_.characterEffect10001_tpose then
				local var_153_25 = 0.5

				arg_150_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_150_1.var_.characterEffect10001_tpose.fillRatio = var_153_25
			end

			local var_153_26 = manager.ui.mainCamera.transform
			local var_153_27 = 1.26666666666667

			if var_153_27 < arg_150_1.time_ and arg_150_1.time_ <= var_153_27 + arg_153_0 then
				local var_153_28 = arg_150_1.var_.effect32131111

				if var_153_28 then
					Object.Destroy(var_153_28)

					arg_150_1.var_.effect32131111 = nil
				end
			end

			local var_153_29 = manager.ui.mainCamera.transform
			local var_153_30 = 0

			if var_153_30 < arg_150_1.time_ and arg_150_1.time_ <= var_153_30 + arg_153_0 then
				local var_153_31 = arg_150_1.var_.effectdddff
				local var_153_32
				local var_153_33 = var_153_29

				if not var_153_31 then
					var_153_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmaskline_black"), var_153_33)
					var_153_31.name = "dddff"
					arg_150_1.var_.effectdddff = var_153_31
				else
					var_153_31.transform:SetParent(var_153_33)
				end

				var_153_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_153_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_153_34 = 1.7777777777777777
				local var_153_35 = Screen.width / Screen.height
				local var_153_36 = var_153_35 / var_153_34
				local var_153_37 = Mathf.Max(var_153_34 / var_153_35, 1)

				var_153_31.transform.localScale = Vector3.New(var_153_31.transform.localScale.x * var_153_36, var_153_31.transform.localScale.y * var_153_37, var_153_31.transform.localScale.z)
			end

			local var_153_38 = "STblack"

			if arg_150_1.bgs_[var_153_38] == nil then
				local var_153_39 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_39:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_153_38)
				var_153_39.name = var_153_38
				var_153_39.transform.parent = arg_150_1.stage_.transform
				var_153_39.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_[var_153_38] = var_153_39
			end

			local var_153_40 = 1.61386819602922

			if var_153_40 < arg_150_1.time_ and arg_150_1.time_ <= var_153_40 + arg_153_0 then
				local var_153_41 = manager.ui.mainCamera.transform.localPosition
				local var_153_42 = Vector3.New(0, 0, 10) + Vector3.New(var_153_41.x, var_153_41.y, 0)
				local var_153_43 = arg_150_1.bgs_.STblack

				var_153_43.transform.localPosition = var_153_42
				var_153_43.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_44 = var_153_43:GetComponent("SpriteRenderer")

				if var_153_44 and var_153_44.sprite then
					local var_153_45 = (var_153_43.transform.localPosition - var_153_41).z
					local var_153_46 = manager.ui.mainCameraCom_
					local var_153_47 = 2 * var_153_45 * Mathf.Tan(var_153_46.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_153_48 = var_153_47 * var_153_46.aspect
					local var_153_49 = var_153_44.sprite.bounds.size.x
					local var_153_50 = var_153_44.sprite.bounds.size.y
					local var_153_51 = var_153_48 / var_153_49
					local var_153_52 = var_153_47 / var_153_50
					local var_153_53 = var_153_52 < var_153_51 and var_153_51 or var_153_52

					var_153_43.transform.localScale = Vector3.New(var_153_53, var_153_53, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "STblack" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_54 = 0

			if var_153_54 < arg_150_1.time_ and arg_150_1.time_ <= var_153_54 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			local var_153_55 = 2.66666666666667

			if arg_150_1.time_ >= var_153_54 + var_153_55 and arg_150_1.time_ < var_153_54 + var_153_55 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_56 = 2.4
			local var_153_57 = 0.95

			if var_153_56 < arg_150_1.time_ and arg_150_1.time_ <= var_153_56 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_58 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_58:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_59 = arg_150_1:GetWordFromCfg(304081036)
				local var_153_60 = arg_150_1:FormatText(var_153_59.content)

				arg_150_1.text_.text = var_153_60

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_61 = 38
				local var_153_62 = utf8.len(var_153_60)
				local var_153_63 = var_153_61 <= 0 and var_153_57 or var_153_57 * (var_153_62 / var_153_61)

				if var_153_63 > 0 and var_153_57 < var_153_63 then
					arg_150_1.talkMaxDuration = var_153_63
					var_153_56 = var_153_56 + 0.3

					if var_153_63 + var_153_56 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_63 + var_153_56
					end
				end

				arg_150_1.text_.text = var_153_60
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_64 = var_153_56 + 0.3
			local var_153_65 = math.max(var_153_57, arg_150_1.talkMaxDuration)

			if var_153_64 <= arg_150_1.time_ and arg_150_1.time_ < var_153_64 + var_153_65 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_64) / var_153_65

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_64 + var_153_65 and arg_150_1.time_ < var_153_64 + var_153_65 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play304081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 304081037
		arg_156_1.duration_ = 19.3

		local var_156_0 = {
			zh = 19.3,
			ja = 19.066
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play304081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10045ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos10045ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, -1.18, -6.05)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10045ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["10045ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10045ui_story == nil then
				arg_156_1.var_.characterEffect10045ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect10045ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10045ui_story then
				arg_156_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_159_15 = 0
			local var_159_16 = 1.65

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[45].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(304081037)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 66
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081037", "story_v_out_304081.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_out_304081", "304081037", "story_v_out_304081.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_out_304081", "304081037", "story_v_out_304081.awb")

						arg_156_1:RecordAudio("304081037", var_159_24)
						arg_156_1:RecordAudio("304081037", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_304081", "304081037", "story_v_out_304081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_304081", "304081037", "story_v_out_304081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play304081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 304081038
		arg_160_1.duration_ = 9.4

		local var_160_0 = {
			zh = 9.4,
			ja = 7.833
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
				arg_160_0:Play304081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.65

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[45].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(304081038)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 26
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081038", "story_v_out_304081.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081038", "story_v_out_304081.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_304081", "304081038", "story_v_out_304081.awb")

						arg_160_1:RecordAudio("304081038", var_163_9)
						arg_160_1:RecordAudio("304081038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_304081", "304081038", "story_v_out_304081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_304081", "304081038", "story_v_out_304081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play304081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 304081039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play304081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10045ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10045ui_story == nil then
				arg_164_1.var_.characterEffect10045ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect10045ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10045ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10045ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10045ui_story.fillRatio = var_167_5
			end

			local var_167_6 = arg_164_1.actors_["10045ui_story"].transform
			local var_167_7 = 0

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1.var_.moveOldPos10045ui_story = var_167_6.localPosition
			end

			local var_167_8 = 0.001

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_8 then
				local var_167_9 = (arg_164_1.time_ - var_167_7) / var_167_8
				local var_167_10 = Vector3.New(0, 100, 0)

				var_167_6.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10045ui_story, var_167_10, var_167_9)

				local var_167_11 = manager.ui.mainCamera.transform.position - var_167_6.position

				var_167_6.forward = Vector3.New(var_167_11.x, var_167_11.y, var_167_11.z)

				local var_167_12 = var_167_6.localEulerAngles

				var_167_12.z = 0
				var_167_12.x = 0
				var_167_6.localEulerAngles = var_167_12
			end

			if arg_164_1.time_ >= var_167_7 + var_167_8 and arg_164_1.time_ < var_167_7 + var_167_8 + arg_167_0 then
				var_167_6.localPosition = Vector3.New(0, 100, 0)

				local var_167_13 = manager.ui.mainCamera.transform.position - var_167_6.position

				var_167_6.forward = Vector3.New(var_167_13.x, var_167_13.y, var_167_13.z)

				local var_167_14 = var_167_6.localEulerAngles

				var_167_14.z = 0
				var_167_14.x = 0
				var_167_6.localEulerAngles = var_167_14
			end

			local var_167_15 = 0
			local var_167_16 = 1.4

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_17 = arg_164_1:GetWordFromCfg(304081039)
				local var_167_18 = arg_164_1:FormatText(var_167_17.content)

				arg_164_1.text_.text = var_167_18

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_19 = 56
				local var_167_20 = utf8.len(var_167_18)
				local var_167_21 = var_167_19 <= 0 and var_167_16 or var_167_16 * (var_167_20 / var_167_19)

				if var_167_21 > 0 and var_167_16 < var_167_21 then
					arg_164_1.talkMaxDuration = var_167_21

					if var_167_21 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_21 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_18
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_22 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_22 and arg_164_1.time_ < var_167_15 + var_167_22 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play304081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 304081040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play304081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.45

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(304081040)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 58
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play304081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 304081041
		arg_172_1.duration_ = 6.7

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play304081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.45

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[45].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(304081041)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 18
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081041", "story_v_out_304081.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081041", "story_v_out_304081.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_304081", "304081041", "story_v_out_304081.awb")

						arg_172_1:RecordAudio("304081041", var_175_9)
						arg_172_1:RecordAudio("304081041", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_304081", "304081041", "story_v_out_304081.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_304081", "304081041", "story_v_out_304081.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play304081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304081042
		arg_176_1.duration_ = 8.33

		local var_176_0 = {
			zh = 8.16633333333333,
			ja = 8.33333333333333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play304081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = "B02f"

			if arg_176_1.bgs_[var_179_0] == nil then
				local var_179_1 = Object.Instantiate(arg_176_1.paintGo_)

				var_179_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_179_0)
				var_179_1.name = var_179_0
				var_179_1.transform.parent = arg_176_1.stage_.transform
				var_179_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.bgs_[var_179_0] = var_179_1
			end

			local var_179_2 = 1.73333333333333

			if var_179_2 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				local var_179_3 = manager.ui.mainCamera.transform.localPosition
				local var_179_4 = Vector3.New(0, 0, 10) + Vector3.New(var_179_3.x, var_179_3.y, 0)
				local var_179_5 = arg_176_1.bgs_.B02f

				var_179_5.transform.localPosition = var_179_4
				var_179_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_6 = var_179_5:GetComponent("SpriteRenderer")

				if var_179_6 and var_179_6.sprite then
					local var_179_7 = (var_179_5.transform.localPosition - var_179_3).z
					local var_179_8 = manager.ui.mainCameraCom_
					local var_179_9 = 2 * var_179_7 * Mathf.Tan(var_179_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_179_10 = var_179_9 * var_179_8.aspect
					local var_179_11 = var_179_6.sprite.bounds.size.x
					local var_179_12 = var_179_6.sprite.bounds.size.y
					local var_179_13 = var_179_10 / var_179_11
					local var_179_14 = var_179_9 / var_179_12
					local var_179_15 = var_179_14 < var_179_13 and var_179_13 or var_179_14

					var_179_5.transform.localScale = Vector3.New(var_179_15, var_179_15, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "B02f" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_16 = 1.73333333333333

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_17 = 0.3

			if arg_176_1.time_ >= var_179_16 + var_179_17 and arg_176_1.time_ < var_179_16 + var_179_17 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_18 = 0

			if var_179_18 < arg_176_1.time_ and arg_176_1.time_ <= var_179_18 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_19 = 1.73333333333333

			if var_179_18 <= arg_176_1.time_ and arg_176_1.time_ < var_179_18 + var_179_19 then
				local var_179_20 = (arg_176_1.time_ - var_179_18) / var_179_19
				local var_179_21 = Color.New(0, 0, 0)

				var_179_21.a = Mathf.Lerp(0, 1, var_179_20)
				arg_176_1.mask_.color = var_179_21
			end

			if arg_176_1.time_ >= var_179_18 + var_179_19 and arg_176_1.time_ < var_179_18 + var_179_19 + arg_179_0 then
				local var_179_22 = Color.New(0, 0, 0)

				var_179_22.a = 1
				arg_176_1.mask_.color = var_179_22
			end

			local var_179_23 = 1.73333333333333

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_24 = 2

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_24 then
				local var_179_25 = (arg_176_1.time_ - var_179_23) / var_179_24
				local var_179_26 = Color.New(0, 0, 0)

				var_179_26.a = Mathf.Lerp(1, 0, var_179_25)
				arg_176_1.mask_.color = var_179_26
			end

			if arg_176_1.time_ >= var_179_23 + var_179_24 and arg_176_1.time_ < var_179_23 + var_179_24 + arg_179_0 then
				local var_179_27 = Color.New(0, 0, 0)
				local var_179_28 = 0

				arg_176_1.mask_.enabled = false
				var_179_27.a = var_179_28
				arg_176_1.mask_.color = var_179_27
			end

			local var_179_29 = "1019ui_story"

			if arg_176_1.actors_[var_179_29] == nil then
				local var_179_30 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_179_30) then
					local var_179_31 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_176_1.stage_.transform)

					var_179_31.name = var_179_29
					var_179_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_176_1.actors_[var_179_29] = var_179_31

					local var_179_32 = var_179_31:GetComponentInChildren(typeof(CharacterEffect))

					var_179_32.enabled = true

					local var_179_33 = GameObjectTools.GetOrAddComponent(var_179_31, typeof(DynamicBoneHelper))

					if var_179_33 then
						var_179_33:EnableDynamicBone(false)
					end

					arg_176_1:ShowWeapon(var_179_32.transform, false)

					arg_176_1.var_[var_179_29 .. "Animator"] = var_179_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_176_1.var_[var_179_29 .. "Animator"].applyRootMotion = true
					arg_176_1.var_[var_179_29 .. "LipSync"] = var_179_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_179_34 = arg_176_1.actors_["1019ui_story"].transform
			local var_179_35 = 3.36666666666667

			if var_179_35 < arg_176_1.time_ and arg_176_1.time_ <= var_179_35 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = var_179_34.localPosition
			end

			local var_179_36 = 0.001

			if var_179_35 <= arg_176_1.time_ and arg_176_1.time_ < var_179_35 + var_179_36 then
				local var_179_37 = (arg_176_1.time_ - var_179_35) / var_179_36
				local var_179_38 = Vector3.New(-0.2, -1.08, -5.9)

				var_179_34.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, var_179_38, var_179_37)

				local var_179_39 = manager.ui.mainCamera.transform.position - var_179_34.position

				var_179_34.forward = Vector3.New(var_179_39.x, var_179_39.y, var_179_39.z)

				local var_179_40 = var_179_34.localEulerAngles

				var_179_40.z = 0
				var_179_40.x = 0
				var_179_34.localEulerAngles = var_179_40
			end

			if arg_176_1.time_ >= var_179_35 + var_179_36 and arg_176_1.time_ < var_179_35 + var_179_36 + arg_179_0 then
				var_179_34.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_179_41 = manager.ui.mainCamera.transform.position - var_179_34.position

				var_179_34.forward = Vector3.New(var_179_41.x, var_179_41.y, var_179_41.z)

				local var_179_42 = var_179_34.localEulerAngles

				var_179_42.z = 0
				var_179_42.x = 0
				var_179_34.localEulerAngles = var_179_42
			end

			local var_179_43 = arg_176_1.actors_["1019ui_story"]
			local var_179_44 = 3.36666666666667

			if var_179_44 < arg_176_1.time_ and arg_176_1.time_ <= var_179_44 + arg_179_0 and not isNil(var_179_43) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = var_179_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_45 = 0.200000002980232

			if var_179_44 <= arg_176_1.time_ and arg_176_1.time_ < var_179_44 + var_179_45 and not isNil(var_179_43) then
				local var_179_46 = (arg_176_1.time_ - var_179_44) / var_179_45

				if arg_176_1.var_.characterEffect1019ui_story and not isNil(var_179_43) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_44 + var_179_45 and arg_176_1.time_ < var_179_44 + var_179_45 + arg_179_0 and not isNil(var_179_43) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_179_47 = 3.36666666666667

			if var_179_47 < arg_176_1.time_ and arg_176_1.time_ <= var_179_47 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_179_48 = 3.36666666666667

			if var_179_48 < arg_176_1.time_ and arg_176_1.time_ <= var_179_48 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_49 = 1.2
			local var_179_50 = 1

			if var_179_49 < arg_176_1.time_ and arg_176_1.time_ <= var_179_49 + arg_179_0 then
				local var_179_51 = "play"
				local var_179_52 = "effect"

				arg_176_1:AudioAction(var_179_51, var_179_52, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_179_53 = 0.2
			local var_179_54 = 1

			if var_179_53 < arg_176_1.time_ and arg_176_1.time_ <= var_179_53 + arg_179_0 then
				local var_179_55 = "stop"
				local var_179_56 = "effect"

				arg_176_1:AudioAction(var_179_55, var_179_56, "se_story_142", "se_story_142_amb_command room", "")
			end

			local var_179_57 = 1
			local var_179_58 = 1

			if var_179_57 < arg_176_1.time_ and arg_176_1.time_ <= var_179_57 + arg_179_0 then
				local var_179_59 = "play"
				local var_179_60 = "music"

				arg_176_1:AudioAction(var_179_59, var_179_60, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_179_61 = ""
				local var_179_62 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_179_62 ~= "" then
					if arg_176_1.bgmTxt_.text ~= var_179_62 and arg_176_1.bgmTxt_.text ~= "" then
						if arg_176_1.bgmTxt2_.text ~= "" then
							arg_176_1.bgmTxt_.text = arg_176_1.bgmTxt2_.text
						end

						arg_176_1.bgmTxt2_.text = var_179_62

						arg_176_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_176_1.bgmTxt_.text = var_179_62
						arg_176_1.bgmTxt2_.text = var_179_62
					end

					if arg_176_1.bgmTimer then
						arg_176_1.bgmTimer:Stop()

						arg_176_1.bgmTimer = nil
					end

					if arg_176_1.settingData.show_music_name == 1 then
						arg_176_1.musicController:SetSelectedState("show")
						arg_176_1.musicAnimator_:Play("open", 0, 0)

						if arg_176_1.settingData.music_time ~= 0 then
							arg_176_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_176_1.settingData.music_time), function()
								if arg_176_1 == nil or isNil(arg_176_1.bgmTxt_) then
									return
								end

								arg_176_1.musicController:SetSelectedState("hide")
								arg_176_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_179_63 = 0
			local var_179_64 = 1

			if var_179_63 < arg_176_1.time_ and arg_176_1.time_ <= var_179_63 + arg_179_0 then
				local var_179_65 = "play"
				local var_179_66 = "effect"

				arg_176_1:AudioAction(var_179_65, var_179_66, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_67 = 3.73333333333333
			local var_179_68 = 0.475

			if var_179_67 < arg_176_1.time_ and arg_176_1.time_ <= var_179_67 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_69 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_69:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_176_1.dialogCg_.alpha = arg_181_0
				end))
				var_179_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_70 = arg_176_1:FormatText(StoryNameCfg[13].name)

				arg_176_1.leftNameTxt_.text = var_179_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_71 = arg_176_1:GetWordFromCfg(304081042)
				local var_179_72 = arg_176_1:FormatText(var_179_71.content)

				arg_176_1.text_.text = var_179_72

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_73 = 19
				local var_179_74 = utf8.len(var_179_72)
				local var_179_75 = var_179_73 <= 0 and var_179_68 or var_179_68 * (var_179_74 / var_179_73)

				if var_179_75 > 0 and var_179_68 < var_179_75 then
					arg_176_1.talkMaxDuration = var_179_75
					var_179_67 = var_179_67 + 0.3

					if var_179_75 + var_179_67 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_75 + var_179_67
					end
				end

				arg_176_1.text_.text = var_179_72
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081042", "story_v_out_304081.awb") ~= 0 then
					local var_179_76 = manager.audio:GetVoiceLength("story_v_out_304081", "304081042", "story_v_out_304081.awb") / 1000

					if var_179_76 + var_179_67 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_76 + var_179_67
					end

					if var_179_71.prefab_name ~= "" and arg_176_1.actors_[var_179_71.prefab_name] ~= nil then
						local var_179_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_71.prefab_name].transform, "story_v_out_304081", "304081042", "story_v_out_304081.awb")

						arg_176_1:RecordAudio("304081042", var_179_77)
						arg_176_1:RecordAudio("304081042", var_179_77)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_304081", "304081042", "story_v_out_304081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_304081", "304081042", "story_v_out_304081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_78 = var_179_67 + 0.3
			local var_179_79 = math.max(var_179_68, arg_176_1.talkMaxDuration)

			if var_179_78 <= arg_176_1.time_ and arg_176_1.time_ < var_179_78 + var_179_79 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_78) / var_179_79

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_78 + var_179_79 and arg_176_1.time_ < var_179_78 + var_179_79 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play304081043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 304081043
		arg_183_1.duration_ = 5.6

		local var_183_0 = {
			zh = 3.933,
			ja = 5.6
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
				arg_183_0:Play304081044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.475

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[13].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(304081043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 19
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081043", "story_v_out_304081.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081043", "story_v_out_304081.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_304081", "304081043", "story_v_out_304081.awb")

						arg_183_1:RecordAudio("304081043", var_186_9)
						arg_183_1:RecordAudio("304081043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_304081", "304081043", "story_v_out_304081.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_304081", "304081043", "story_v_out_304081.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play304081044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 304081044
		arg_187_1.duration_ = 9.6

		local var_187_0 = {
			zh = 7.633,
			ja = 9.6
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
				arg_187_0:Play304081045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = "10002ui_story"

			if arg_187_1.actors_[var_190_0] == nil then
				local var_190_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_190_1) then
					local var_190_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_187_1.stage_.transform)

					var_190_2.name = var_190_0
					var_190_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_187_1.actors_[var_190_0] = var_190_2

					local var_190_3 = var_190_2:GetComponentInChildren(typeof(CharacterEffect))

					var_190_3.enabled = true

					local var_190_4 = GameObjectTools.GetOrAddComponent(var_190_2, typeof(DynamicBoneHelper))

					if var_190_4 then
						var_190_4:EnableDynamicBone(false)
					end

					arg_187_1:ShowWeapon(var_190_3.transform, false)

					arg_187_1.var_[var_190_0 .. "Animator"] = var_190_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_187_1.var_[var_190_0 .. "Animator"].applyRootMotion = true
					arg_187_1.var_[var_190_0 .. "LipSync"] = var_190_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_190_5 = arg_187_1.actors_["10002ui_story"].transform
			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.var_.moveOldPos10002ui_story = var_190_5.localPosition
			end

			local var_190_7 = 0.001

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_7 then
				local var_190_8 = (arg_187_1.time_ - var_190_6) / var_190_7
				local var_190_9 = Vector3.New(-0.7, -1.2, -5.8)

				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10002ui_story, var_190_9, var_190_8)

				local var_190_10 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_10.x, var_190_10.y, var_190_10.z)

				local var_190_11 = var_190_5.localEulerAngles

				var_190_11.z = 0
				var_190_11.x = 0
				var_190_5.localEulerAngles = var_190_11
			end

			if arg_187_1.time_ >= var_190_6 + var_190_7 and arg_187_1.time_ < var_190_6 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_190_12 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_12.x, var_190_12.y, var_190_12.z)

				local var_190_13 = var_190_5.localEulerAngles

				var_190_13.z = 0
				var_190_13.x = 0
				var_190_5.localEulerAngles = var_190_13
			end

			local var_190_14 = arg_187_1.actors_["1019ui_story"].transform
			local var_190_15 = 0

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.var_.moveOldPos1019ui_story = var_190_14.localPosition
			end

			local var_190_16 = 0.001

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_16 then
				local var_190_17 = (arg_187_1.time_ - var_190_15) / var_190_16
				local var_190_18 = Vector3.New(0.7, -1.08, -5.9)

				var_190_14.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1019ui_story, var_190_18, var_190_17)

				local var_190_19 = manager.ui.mainCamera.transform.position - var_190_14.position

				var_190_14.forward = Vector3.New(var_190_19.x, var_190_19.y, var_190_19.z)

				local var_190_20 = var_190_14.localEulerAngles

				var_190_20.z = 0
				var_190_20.x = 0
				var_190_14.localEulerAngles = var_190_20
			end

			if arg_187_1.time_ >= var_190_15 + var_190_16 and arg_187_1.time_ < var_190_15 + var_190_16 + arg_190_0 then
				var_190_14.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_190_21 = manager.ui.mainCamera.transform.position - var_190_14.position

				var_190_14.forward = Vector3.New(var_190_21.x, var_190_21.y, var_190_21.z)

				local var_190_22 = var_190_14.localEulerAngles

				var_190_22.z = 0
				var_190_22.x = 0
				var_190_14.localEulerAngles = var_190_22
			end

			local var_190_23 = arg_187_1.actors_["10002ui_story"]
			local var_190_24 = 0

			if var_190_24 < arg_187_1.time_ and arg_187_1.time_ <= var_190_24 + arg_190_0 and not isNil(var_190_23) and arg_187_1.var_.characterEffect10002ui_story == nil then
				arg_187_1.var_.characterEffect10002ui_story = var_190_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_25 = 0.200000002980232

			if var_190_24 <= arg_187_1.time_ and arg_187_1.time_ < var_190_24 + var_190_25 and not isNil(var_190_23) then
				local var_190_26 = (arg_187_1.time_ - var_190_24) / var_190_25

				if arg_187_1.var_.characterEffect10002ui_story and not isNil(var_190_23) then
					arg_187_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_24 + var_190_25 and arg_187_1.time_ < var_190_24 + var_190_25 + arg_190_0 and not isNil(var_190_23) and arg_187_1.var_.characterEffect10002ui_story then
				arg_187_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_190_27 = arg_187_1.actors_["1019ui_story"]
			local var_190_28 = 0

			if var_190_28 < arg_187_1.time_ and arg_187_1.time_ <= var_190_28 + arg_190_0 and not isNil(var_190_27) and arg_187_1.var_.characterEffect1019ui_story == nil then
				arg_187_1.var_.characterEffect1019ui_story = var_190_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_29 = 0.200000002980232

			if var_190_28 <= arg_187_1.time_ and arg_187_1.time_ < var_190_28 + var_190_29 and not isNil(var_190_27) then
				local var_190_30 = (arg_187_1.time_ - var_190_28) / var_190_29

				if arg_187_1.var_.characterEffect1019ui_story and not isNil(var_190_27) then
					local var_190_31 = Mathf.Lerp(0, 0.5, var_190_30)

					arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_31
				end
			end

			if arg_187_1.time_ >= var_190_28 + var_190_29 and arg_187_1.time_ < var_190_28 + var_190_29 + arg_190_0 and not isNil(var_190_27) and arg_187_1.var_.characterEffect1019ui_story then
				local var_190_32 = 0.5

				arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_32
			end

			local var_190_33 = 0

			if var_190_33 < arg_187_1.time_ and arg_187_1.time_ <= var_190_33 + arg_190_0 then
				arg_187_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_190_34 = 0

			if var_190_34 < arg_187_1.time_ and arg_187_1.time_ <= var_190_34 + arg_190_0 then
				arg_187_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_35 = 0
			local var_190_36 = 0.75

			if var_190_35 < arg_187_1.time_ and arg_187_1.time_ <= var_190_35 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_37 = arg_187_1:FormatText(StoryNameCfg[39].name)

				arg_187_1.leftNameTxt_.text = var_190_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_38 = arg_187_1:GetWordFromCfg(304081044)
				local var_190_39 = arg_187_1:FormatText(var_190_38.content)

				arg_187_1.text_.text = var_190_39

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_40 = 30
				local var_190_41 = utf8.len(var_190_39)
				local var_190_42 = var_190_40 <= 0 and var_190_36 or var_190_36 * (var_190_41 / var_190_40)

				if var_190_42 > 0 and var_190_36 < var_190_42 then
					arg_187_1.talkMaxDuration = var_190_42

					if var_190_42 + var_190_35 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_42 + var_190_35
					end
				end

				arg_187_1.text_.text = var_190_39
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081044", "story_v_out_304081.awb") ~= 0 then
					local var_190_43 = manager.audio:GetVoiceLength("story_v_out_304081", "304081044", "story_v_out_304081.awb") / 1000

					if var_190_43 + var_190_35 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_43 + var_190_35
					end

					if var_190_38.prefab_name ~= "" and arg_187_1.actors_[var_190_38.prefab_name] ~= nil then
						local var_190_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_38.prefab_name].transform, "story_v_out_304081", "304081044", "story_v_out_304081.awb")

						arg_187_1:RecordAudio("304081044", var_190_44)
						arg_187_1:RecordAudio("304081044", var_190_44)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_304081", "304081044", "story_v_out_304081.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_304081", "304081044", "story_v_out_304081.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_45 = math.max(var_190_36, arg_187_1.talkMaxDuration)

			if var_190_35 <= arg_187_1.time_ and arg_187_1.time_ < var_190_35 + var_190_45 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_35) / var_190_45

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_35 + var_190_45 and arg_187_1.time_ < var_190_35 + var_190_45 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play304081045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 304081045
		arg_191_1.duration_ = 6.77

		local var_191_0 = {
			zh = 6.766,
			ja = 6.5
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
				arg_191_0:Play304081046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.725

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[39].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(304081045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 29
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081045", "story_v_out_304081.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081045", "story_v_out_304081.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_304081", "304081045", "story_v_out_304081.awb")

						arg_191_1:RecordAudio("304081045", var_194_9)
						arg_191_1:RecordAudio("304081045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_304081", "304081045", "story_v_out_304081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_304081", "304081045", "story_v_out_304081.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play304081046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 304081046
		arg_195_1.duration_ = 6.3

		local var_195_0 = {
			zh = 3.833,
			ja = 6.3
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
				arg_195_0:Play304081047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1019ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1019ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_198_4 = arg_195_1.actors_["10002ui_story"]
			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10002ui_story == nil then
				arg_195_1.var_.characterEffect10002ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_6 and not isNil(var_198_4) then
				local var_198_7 = (arg_195_1.time_ - var_198_5) / var_198_6

				if arg_195_1.var_.characterEffect10002ui_story and not isNil(var_198_4) then
					local var_198_8 = Mathf.Lerp(0, 0.5, var_198_7)

					arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10002ui_story.fillRatio = var_198_8
				end
			end

			if arg_195_1.time_ >= var_198_5 + var_198_6 and arg_195_1.time_ < var_198_5 + var_198_6 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10002ui_story then
				local var_198_9 = 0.5

				arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10002ui_story.fillRatio = var_198_9
			end

			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_198_11 = 0

			if var_198_11 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_198_12 = 0
			local var_198_13 = 0.5

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_14 = arg_195_1:FormatText(StoryNameCfg[13].name)

				arg_195_1.leftNameTxt_.text = var_198_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_15 = arg_195_1:GetWordFromCfg(304081046)
				local var_198_16 = arg_195_1:FormatText(var_198_15.content)

				arg_195_1.text_.text = var_198_16

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_17 = 20
				local var_198_18 = utf8.len(var_198_16)
				local var_198_19 = var_198_17 <= 0 and var_198_13 or var_198_13 * (var_198_18 / var_198_17)

				if var_198_19 > 0 and var_198_13 < var_198_19 then
					arg_195_1.talkMaxDuration = var_198_19

					if var_198_19 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_19 + var_198_12
					end
				end

				arg_195_1.text_.text = var_198_16
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081046", "story_v_out_304081.awb") ~= 0 then
					local var_198_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081046", "story_v_out_304081.awb") / 1000

					if var_198_20 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_20 + var_198_12
					end

					if var_198_15.prefab_name ~= "" and arg_195_1.actors_[var_198_15.prefab_name] ~= nil then
						local var_198_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_15.prefab_name].transform, "story_v_out_304081", "304081046", "story_v_out_304081.awb")

						arg_195_1:RecordAudio("304081046", var_198_21)
						arg_195_1:RecordAudio("304081046", var_198_21)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_304081", "304081046", "story_v_out_304081.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_304081", "304081046", "story_v_out_304081.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_22 = math.max(var_198_13, arg_195_1.talkMaxDuration)

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_22 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_12) / var_198_22

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_12 + var_198_22 and arg_195_1.time_ < var_198_12 + var_198_22 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play304081047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 304081047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play304081048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1019ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1019ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1019ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1019ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1019ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.9

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(304081047)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 36
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_7 or var_202_7 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_7 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_13 and arg_199_1.time_ < var_202_6 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play304081048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304081048
		arg_203_1.duration_ = 6.8

		local var_203_0 = {
			zh = 6.8,
			ja = 4.866
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
				arg_203_0:Play304081049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10002ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10002ui_story == nil then
				arg_203_1.var_.characterEffect10002ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect10002ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10002ui_story then
				arg_203_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.35

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[39].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(304081048)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 14
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081048", "story_v_out_304081.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_304081", "304081048", "story_v_out_304081.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_out_304081", "304081048", "story_v_out_304081.awb")

						arg_203_1:RecordAudio("304081048", var_206_15)
						arg_203_1:RecordAudio("304081048", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304081", "304081048", "story_v_out_304081.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304081", "304081048", "story_v_out_304081.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play304081049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 304081049
		arg_207_1.duration_ = 2.67

		local var_207_0 = {
			zh = 1.999999999999,
			ja = 2.666
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
				arg_207_0:Play304081050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1019ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1019ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["10002ui_story"]
			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect10002ui_story == nil then
				arg_207_1.var_.characterEffect10002ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 and not isNil(var_210_4) then
				local var_210_7 = (arg_207_1.time_ - var_210_5) / var_210_6

				if arg_207_1.var_.characterEffect10002ui_story and not isNil(var_210_4) then
					local var_210_8 = Mathf.Lerp(0, 0.5, var_210_7)

					arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10002ui_story.fillRatio = var_210_8
				end
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect10002ui_story then
				local var_210_9 = 0.5

				arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10002ui_story.fillRatio = var_210_9
			end

			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			local var_210_11 = 0

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_12 = 0
			local var_210_13 = 0.15

			if var_210_12 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_14 = arg_207_1:FormatText(StoryNameCfg[13].name)

				arg_207_1.leftNameTxt_.text = var_210_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_15 = arg_207_1:GetWordFromCfg(304081049)
				local var_210_16 = arg_207_1:FormatText(var_210_15.content)

				arg_207_1.text_.text = var_210_16

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_17 = 6
				local var_210_18 = utf8.len(var_210_16)
				local var_210_19 = var_210_17 <= 0 and var_210_13 or var_210_13 * (var_210_18 / var_210_17)

				if var_210_19 > 0 and var_210_13 < var_210_19 then
					arg_207_1.talkMaxDuration = var_210_19

					if var_210_19 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_16
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081049", "story_v_out_304081.awb") ~= 0 then
					local var_210_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081049", "story_v_out_304081.awb") / 1000

					if var_210_20 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_20 + var_210_12
					end

					if var_210_15.prefab_name ~= "" and arg_207_1.actors_[var_210_15.prefab_name] ~= nil then
						local var_210_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_15.prefab_name].transform, "story_v_out_304081", "304081049", "story_v_out_304081.awb")

						arg_207_1:RecordAudio("304081049", var_210_21)
						arg_207_1:RecordAudio("304081049", var_210_21)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_304081", "304081049", "story_v_out_304081.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_304081", "304081049", "story_v_out_304081.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_12) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_12 + var_210_22 and arg_207_1.time_ < var_210_12 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play304081050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 304081050
		arg_211_1.duration_ = 2.1

		local var_211_0 = {
			zh = 2.1,
			ja = 0.999999999999
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
				arg_211_0:Play304081051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10002ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10002ui_story == nil then
				arg_211_1.var_.characterEffect10002ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10002ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10002ui_story then
				arg_211_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_214_4 = arg_211_1.actors_["1019ui_story"]
			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1019ui_story == nil then
				arg_211_1.var_.characterEffect1019ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_6 and not isNil(var_214_4) then
				local var_214_7 = (arg_211_1.time_ - var_214_5) / var_214_6

				if arg_211_1.var_.characterEffect1019ui_story and not isNil(var_214_4) then
					local var_214_8 = Mathf.Lerp(0, 0.5, var_214_7)

					arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1019ui_story.fillRatio = var_214_8
				end
			end

			if arg_211_1.time_ >= var_214_5 + var_214_6 and arg_211_1.time_ < var_214_5 + var_214_6 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1019ui_story then
				local var_214_9 = 0.5

				arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1019ui_story.fillRatio = var_214_9
			end

			local var_214_10 = 0
			local var_214_11 = 0.05

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_12 = arg_211_1:FormatText(StoryNameCfg[39].name)

				arg_211_1.leftNameTxt_.text = var_214_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_13 = arg_211_1:GetWordFromCfg(304081050)
				local var_214_14 = arg_211_1:FormatText(var_214_13.content)

				arg_211_1.text_.text = var_214_14

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_15 = 2
				local var_214_16 = utf8.len(var_214_14)
				local var_214_17 = var_214_15 <= 0 and var_214_11 or var_214_11 * (var_214_16 / var_214_15)

				if var_214_17 > 0 and var_214_11 < var_214_17 then
					arg_211_1.talkMaxDuration = var_214_17

					if var_214_17 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_17 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_14
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081050", "story_v_out_304081.awb") ~= 0 then
					local var_214_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081050", "story_v_out_304081.awb") / 1000

					if var_214_18 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_18 + var_214_10
					end

					if var_214_13.prefab_name ~= "" and arg_211_1.actors_[var_214_13.prefab_name] ~= nil then
						local var_214_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_13.prefab_name].transform, "story_v_out_304081", "304081050", "story_v_out_304081.awb")

						arg_211_1:RecordAudio("304081050", var_214_19)
						arg_211_1:RecordAudio("304081050", var_214_19)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_304081", "304081050", "story_v_out_304081.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_304081", "304081050", "story_v_out_304081.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_20 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_20

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_20 and arg_211_1.time_ < var_214_10 + var_214_20 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play304081051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 304081051
		arg_215_1.duration_ = 12.8

		local var_215_0 = {
			zh = 12.8,
			ja = 10.7
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
				arg_215_0:Play304081052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_218_1 = 0
			local var_218_2 = 1.275

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_3 = arg_215_1:FormatText(StoryNameCfg[39].name)

				arg_215_1.leftNameTxt_.text = var_218_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(304081051)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 51
				local var_218_7 = utf8.len(var_218_5)
				local var_218_8 = var_218_6 <= 0 and var_218_2 or var_218_2 * (var_218_7 / var_218_6)

				if var_218_8 > 0 and var_218_2 < var_218_8 then
					arg_215_1.talkMaxDuration = var_218_8

					if var_218_8 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081051", "story_v_out_304081.awb") ~= 0 then
					local var_218_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081051", "story_v_out_304081.awb") / 1000

					if var_218_9 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_1
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_out_304081", "304081051", "story_v_out_304081.awb")

						arg_215_1:RecordAudio("304081051", var_218_10)
						arg_215_1:RecordAudio("304081051", var_218_10)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_304081", "304081051", "story_v_out_304081.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_304081", "304081051", "story_v_out_304081.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_11 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_11 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_11

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_11 and arg_215_1.time_ < var_218_1 + var_218_11 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play304081052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 304081052
		arg_219_1.duration_ = 2.13

		local var_219_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_219_0:Play304081053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1019ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = "1084ui_story"

			if arg_219_1.actors_[var_222_9] == nil then
				local var_222_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_222_10) then
					local var_222_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_219_1.stage_.transform)

					var_222_11.name = var_222_9
					var_222_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_219_1.actors_[var_222_9] = var_222_11

					local var_222_12 = var_222_11:GetComponentInChildren(typeof(CharacterEffect))

					var_222_12.enabled = true

					local var_222_13 = GameObjectTools.GetOrAddComponent(var_222_11, typeof(DynamicBoneHelper))

					if var_222_13 then
						var_222_13:EnableDynamicBone(false)
					end

					arg_219_1:ShowWeapon(var_222_12.transform, false)

					arg_219_1.var_[var_222_9 .. "Animator"] = var_222_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_219_1.var_[var_222_9 .. "Animator"].applyRootMotion = true
					arg_219_1.var_[var_222_9 .. "LipSync"] = var_222_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_222_14 = arg_219_1.actors_["1084ui_story"].transform
			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_14.localPosition
			end

			local var_222_16 = 0.001

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16
				local var_222_18 = Vector3.New(0.7, -0.97, -6)

				var_222_14.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, var_222_18, var_222_17)

				local var_222_19 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_19.x, var_222_19.y, var_222_19.z)

				local var_222_20 = var_222_14.localEulerAngles

				var_222_20.z = 0
				var_222_20.x = 0
				var_222_14.localEulerAngles = var_222_20
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				var_222_14.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_222_21 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_21.x, var_222_21.y, var_222_21.z)

				local var_222_22 = var_222_14.localEulerAngles

				var_222_22.z = 0
				var_222_22.x = 0
				var_222_14.localEulerAngles = var_222_22
			end

			local var_222_23 = arg_219_1.actors_["1084ui_story"]
			local var_222_24 = 0

			if var_222_24 < arg_219_1.time_ and arg_219_1.time_ <= var_222_24 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_25 = 0.200000002980232

			if var_222_24 <= arg_219_1.time_ and arg_219_1.time_ < var_222_24 + var_222_25 and not isNil(var_222_23) then
				local var_222_26 = (arg_219_1.time_ - var_222_24) / var_222_25

				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_23) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_24 + var_222_25 and arg_219_1.time_ < var_222_24 + var_222_25 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_27 = arg_219_1.actors_["10002ui_story"]
			local var_222_28 = 0

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 and not isNil(var_222_27) and arg_219_1.var_.characterEffect10002ui_story == nil then
				arg_219_1.var_.characterEffect10002ui_story = var_222_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_29 = 0.200000002980232

			if var_222_28 <= arg_219_1.time_ and arg_219_1.time_ < var_222_28 + var_222_29 and not isNil(var_222_27) then
				local var_222_30 = (arg_219_1.time_ - var_222_28) / var_222_29

				if arg_219_1.var_.characterEffect10002ui_story and not isNil(var_222_27) then
					local var_222_31 = Mathf.Lerp(0, 0.5, var_222_30)

					arg_219_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10002ui_story.fillRatio = var_222_31
				end
			end

			if arg_219_1.time_ >= var_222_28 + var_222_29 and arg_219_1.time_ < var_222_28 + var_222_29 + arg_222_0 and not isNil(var_222_27) and arg_219_1.var_.characterEffect10002ui_story then
				local var_222_32 = 0.5

				arg_219_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10002ui_story.fillRatio = var_222_32
			end

			local var_222_33 = 0

			if var_222_33 < arg_219_1.time_ and arg_219_1.time_ <= var_222_33 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_222_34 = 0

			if var_222_34 < arg_219_1.time_ and arg_219_1.time_ <= var_222_34 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_35 = 0
			local var_222_36 = 0.125

			if var_222_35 < arg_219_1.time_ and arg_219_1.time_ <= var_222_35 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_37 = arg_219_1:FormatText(StoryNameCfg[6].name)

				arg_219_1.leftNameTxt_.text = var_222_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_38 = arg_219_1:GetWordFromCfg(304081052)
				local var_222_39 = arg_219_1:FormatText(var_222_38.content)

				arg_219_1.text_.text = var_222_39

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_40 = 5
				local var_222_41 = utf8.len(var_222_39)
				local var_222_42 = var_222_40 <= 0 and var_222_36 or var_222_36 * (var_222_41 / var_222_40)

				if var_222_42 > 0 and var_222_36 < var_222_42 then
					arg_219_1.talkMaxDuration = var_222_42

					if var_222_42 + var_222_35 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_42 + var_222_35
					end
				end

				arg_219_1.text_.text = var_222_39
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081052", "story_v_out_304081.awb") ~= 0 then
					local var_222_43 = manager.audio:GetVoiceLength("story_v_out_304081", "304081052", "story_v_out_304081.awb") / 1000

					if var_222_43 + var_222_35 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_43 + var_222_35
					end

					if var_222_38.prefab_name ~= "" and arg_219_1.actors_[var_222_38.prefab_name] ~= nil then
						local var_222_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_38.prefab_name].transform, "story_v_out_304081", "304081052", "story_v_out_304081.awb")

						arg_219_1:RecordAudio("304081052", var_222_44)
						arg_219_1:RecordAudio("304081052", var_222_44)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_304081", "304081052", "story_v_out_304081.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_304081", "304081052", "story_v_out_304081.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_45 = math.max(var_222_36, arg_219_1.talkMaxDuration)

			if var_222_35 <= arg_219_1.time_ and arg_219_1.time_ < var_222_35 + var_222_45 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_35) / var_222_45

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_35 + var_222_45 and arg_219_1.time_ < var_222_35 + var_222_45 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play304081053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 304081053
		arg_223_1.duration_ = 11.93

		local var_223_0 = {
			zh = 10.866,
			ja = 11.933
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
				arg_223_0:Play304081054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10002ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10002ui_story == nil then
				arg_223_1.var_.characterEffect10002ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect10002ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10002ui_story then
				arg_223_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["1084ui_story"]
			local var_226_5 = 0

			if var_226_5 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_6 = 0.200000002980232

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_6 and not isNil(var_226_4) then
				local var_226_7 = (arg_223_1.time_ - var_226_5) / var_226_6

				if arg_223_1.var_.characterEffect1084ui_story and not isNil(var_226_4) then
					local var_226_8 = Mathf.Lerp(0, 0.5, var_226_7)

					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = var_226_8
				end
			end

			if arg_223_1.time_ >= var_226_5 + var_226_6 and arg_223_1.time_ < var_226_5 + var_226_6 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1084ui_story then
				local var_226_9 = 0.5

				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = var_226_9
			end

			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_226_11 = 0
			local var_226_12 = 1.05

			if var_226_11 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_13 = arg_223_1:FormatText(StoryNameCfg[39].name)

				arg_223_1.leftNameTxt_.text = var_226_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_14 = arg_223_1:GetWordFromCfg(304081053)
				local var_226_15 = arg_223_1:FormatText(var_226_14.content)

				arg_223_1.text_.text = var_226_15

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 42
				local var_226_17 = utf8.len(var_226_15)
				local var_226_18 = var_226_16 <= 0 and var_226_12 or var_226_12 * (var_226_17 / var_226_16)

				if var_226_18 > 0 and var_226_12 < var_226_18 then
					arg_223_1.talkMaxDuration = var_226_18

					if var_226_18 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_15
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081053", "story_v_out_304081.awb") ~= 0 then
					local var_226_19 = manager.audio:GetVoiceLength("story_v_out_304081", "304081053", "story_v_out_304081.awb") / 1000

					if var_226_19 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_19 + var_226_11
					end

					if var_226_14.prefab_name ~= "" and arg_223_1.actors_[var_226_14.prefab_name] ~= nil then
						local var_226_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_14.prefab_name].transform, "story_v_out_304081", "304081053", "story_v_out_304081.awb")

						arg_223_1:RecordAudio("304081053", var_226_20)
						arg_223_1:RecordAudio("304081053", var_226_20)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_304081", "304081053", "story_v_out_304081.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_304081", "304081053", "story_v_out_304081.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_21 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_21 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_21

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_21 and arg_223_1.time_ < var_226_11 + var_226_21 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play304081054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 304081054
		arg_227_1.duration_ = 10.17

		local var_227_0 = {
			zh = 10.166,
			ja = 10.033
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
				arg_227_0:Play304081055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_1 = 0
			local var_230_2 = 0.875

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_3 = arg_227_1:FormatText(StoryNameCfg[39].name)

				arg_227_1.leftNameTxt_.text = var_230_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(304081054)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 35
				local var_230_7 = utf8.len(var_230_5)
				local var_230_8 = var_230_6 <= 0 and var_230_2 or var_230_2 * (var_230_7 / var_230_6)

				if var_230_8 > 0 and var_230_2 < var_230_8 then
					arg_227_1.talkMaxDuration = var_230_8

					if var_230_8 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081054", "story_v_out_304081.awb") ~= 0 then
					local var_230_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081054", "story_v_out_304081.awb") / 1000

					if var_230_9 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_1
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_304081", "304081054", "story_v_out_304081.awb")

						arg_227_1:RecordAudio("304081054", var_230_10)
						arg_227_1:RecordAudio("304081054", var_230_10)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_304081", "304081054", "story_v_out_304081.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_304081", "304081054", "story_v_out_304081.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_11 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_11 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_11

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_11 and arg_227_1.time_ < var_230_1 + var_230_11 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play304081055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 304081055
		arg_231_1.duration_ = 2.3

		local var_231_0 = {
			zh = 2.3,
			ja = 1.999999999999
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
				arg_231_0:Play304081056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1084ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["10002ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect10002ui_story == nil then
				arg_231_1.var_.characterEffect10002ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect10002ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10002ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect10002ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10002ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_234_11 = 0

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_12 = 0
			local var_234_13 = 0.25

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(304081055)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 10
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081055", "story_v_out_304081.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081055", "story_v_out_304081.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_304081", "304081055", "story_v_out_304081.awb")

						arg_231_1:RecordAudio("304081055", var_234_21)
						arg_231_1:RecordAudio("304081055", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_304081", "304081055", "story_v_out_304081.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_304081", "304081055", "story_v_out_304081.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play304081056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 304081056
		arg_235_1.duration_ = 16.37

		local var_235_0 = {
			zh = 16.366,
			ja = 13.333
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
				arg_235_0:Play304081057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10002ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10002ui_story == nil then
				arg_235_1.var_.characterEffect10002ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect10002ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10002ui_story then
				arg_235_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1084ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1084ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0
			local var_238_11 = 1.625

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_12 = arg_235_1:FormatText(StoryNameCfg[39].name)

				arg_235_1.leftNameTxt_.text = var_238_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:GetWordFromCfg(304081056)
				local var_238_14 = arg_235_1:FormatText(var_238_13.content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_15 = 65
				local var_238_16 = utf8.len(var_238_14)
				local var_238_17 = var_238_15 <= 0 and var_238_11 or var_238_11 * (var_238_16 / var_238_15)

				if var_238_17 > 0 and var_238_11 < var_238_17 then
					arg_235_1.talkMaxDuration = var_238_17

					if var_238_17 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_10
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081056", "story_v_out_304081.awb") ~= 0 then
					local var_238_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081056", "story_v_out_304081.awb") / 1000

					if var_238_18 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_10
					end

					if var_238_13.prefab_name ~= "" and arg_235_1.actors_[var_238_13.prefab_name] ~= nil then
						local var_238_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_13.prefab_name].transform, "story_v_out_304081", "304081056", "story_v_out_304081.awb")

						arg_235_1:RecordAudio("304081056", var_238_19)
						arg_235_1:RecordAudio("304081056", var_238_19)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_304081", "304081056", "story_v_out_304081.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_304081", "304081056", "story_v_out_304081.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_20 = math.max(var_238_11, arg_235_1.talkMaxDuration)

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_20 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_10) / var_238_20

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_10 + var_238_20 and arg_235_1.time_ < var_238_10 + var_238_20 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play304081057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 304081057
		arg_239_1.duration_ = 16.03

		local var_239_0 = {
			zh = 12.2,
			ja = 16.033
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
				arg_239_0:Play304081058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_2")
			end

			local var_242_1 = 0
			local var_242_2 = 1.175

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_3 = arg_239_1:FormatText(StoryNameCfg[39].name)

				arg_239_1.leftNameTxt_.text = var_242_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(304081057)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 47
				local var_242_7 = utf8.len(var_242_5)
				local var_242_8 = var_242_6 <= 0 and var_242_2 or var_242_2 * (var_242_7 / var_242_6)

				if var_242_8 > 0 and var_242_2 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8

					if var_242_8 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081057", "story_v_out_304081.awb") ~= 0 then
					local var_242_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081057", "story_v_out_304081.awb") / 1000

					if var_242_9 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_1
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_304081", "304081057", "story_v_out_304081.awb")

						arg_239_1:RecordAudio("304081057", var_242_10)
						arg_239_1:RecordAudio("304081057", var_242_10)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_304081", "304081057", "story_v_out_304081.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_304081", "304081057", "story_v_out_304081.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_11 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_11 and arg_239_1.time_ < var_242_1 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play304081058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 304081058
		arg_243_1.duration_ = 3.87

		local var_243_0 = {
			zh = 3.866,
			ja = 3.033
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
				arg_243_0:Play304081059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = "1011ui_story"

			if arg_243_1.actors_[var_246_0] == nil then
				local var_246_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_246_1) then
					local var_246_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_243_1.stage_.transform)

					var_246_2.name = var_246_0
					var_246_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_243_1.actors_[var_246_0] = var_246_2

					local var_246_3 = var_246_2:GetComponentInChildren(typeof(CharacterEffect))

					var_246_3.enabled = true

					local var_246_4 = GameObjectTools.GetOrAddComponent(var_246_2, typeof(DynamicBoneHelper))

					if var_246_4 then
						var_246_4:EnableDynamicBone(false)
					end

					arg_243_1:ShowWeapon(var_246_3.transform, false)

					arg_243_1.var_[var_246_0 .. "Animator"] = var_246_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_243_1.var_[var_246_0 .. "Animator"].applyRootMotion = true
					arg_243_1.var_[var_246_0 .. "LipSync"] = var_246_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_246_5 = arg_243_1.actors_["1011ui_story"].transform
			local var_246_6 = 0

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.var_.moveOldPos1011ui_story = var_246_5.localPosition
			end

			local var_246_7 = 0.001

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_7 then
				local var_246_8 = (arg_243_1.time_ - var_246_6) / var_246_7
				local var_246_9 = Vector3.New(0.7, -0.71, -6)

				var_246_5.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1011ui_story, var_246_9, var_246_8)

				local var_246_10 = manager.ui.mainCamera.transform.position - var_246_5.position

				var_246_5.forward = Vector3.New(var_246_10.x, var_246_10.y, var_246_10.z)

				local var_246_11 = var_246_5.localEulerAngles

				var_246_11.z = 0
				var_246_11.x = 0
				var_246_5.localEulerAngles = var_246_11
			end

			if arg_243_1.time_ >= var_246_6 + var_246_7 and arg_243_1.time_ < var_246_6 + var_246_7 + arg_246_0 then
				var_246_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_246_12 = manager.ui.mainCamera.transform.position - var_246_5.position

				var_246_5.forward = Vector3.New(var_246_12.x, var_246_12.y, var_246_12.z)

				local var_246_13 = var_246_5.localEulerAngles

				var_246_13.z = 0
				var_246_13.x = 0
				var_246_5.localEulerAngles = var_246_13
			end

			local var_246_14 = arg_243_1.actors_["1084ui_story"].transform
			local var_246_15 = 0

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.var_.moveOldPos1084ui_story = var_246_14.localPosition
			end

			local var_246_16 = 0.001

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_16 then
				local var_246_17 = (arg_243_1.time_ - var_246_15) / var_246_16
				local var_246_18 = Vector3.New(0, 100, 0)

				var_246_14.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1084ui_story, var_246_18, var_246_17)

				local var_246_19 = manager.ui.mainCamera.transform.position - var_246_14.position

				var_246_14.forward = Vector3.New(var_246_19.x, var_246_19.y, var_246_19.z)

				local var_246_20 = var_246_14.localEulerAngles

				var_246_20.z = 0
				var_246_20.x = 0
				var_246_14.localEulerAngles = var_246_20
			end

			if arg_243_1.time_ >= var_246_15 + var_246_16 and arg_243_1.time_ < var_246_15 + var_246_16 + arg_246_0 then
				var_246_14.localPosition = Vector3.New(0, 100, 0)

				local var_246_21 = manager.ui.mainCamera.transform.position - var_246_14.position

				var_246_14.forward = Vector3.New(var_246_21.x, var_246_21.y, var_246_21.z)

				local var_246_22 = var_246_14.localEulerAngles

				var_246_22.z = 0
				var_246_22.x = 0
				var_246_14.localEulerAngles = var_246_22
			end

			local var_246_23 = arg_243_1.actors_["1011ui_story"]
			local var_246_24 = 0

			if var_246_24 < arg_243_1.time_ and arg_243_1.time_ <= var_246_24 + arg_246_0 and not isNil(var_246_23) and arg_243_1.var_.characterEffect1011ui_story == nil then
				arg_243_1.var_.characterEffect1011ui_story = var_246_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_25 = 0.200000002980232

			if var_246_24 <= arg_243_1.time_ and arg_243_1.time_ < var_246_24 + var_246_25 and not isNil(var_246_23) then
				local var_246_26 = (arg_243_1.time_ - var_246_24) / var_246_25

				if arg_243_1.var_.characterEffect1011ui_story and not isNil(var_246_23) then
					arg_243_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_24 + var_246_25 and arg_243_1.time_ < var_246_24 + var_246_25 + arg_246_0 and not isNil(var_246_23) and arg_243_1.var_.characterEffect1011ui_story then
				arg_243_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_246_27 = arg_243_1.actors_["10002ui_story"]
			local var_246_28 = 0

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 and not isNil(var_246_27) and arg_243_1.var_.characterEffect10002ui_story == nil then
				arg_243_1.var_.characterEffect10002ui_story = var_246_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_29 = 0.200000002980232

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_29 and not isNil(var_246_27) then
				local var_246_30 = (arg_243_1.time_ - var_246_28) / var_246_29

				if arg_243_1.var_.characterEffect10002ui_story and not isNil(var_246_27) then
					local var_246_31 = Mathf.Lerp(0, 0.5, var_246_30)

					arg_243_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10002ui_story.fillRatio = var_246_31
				end
			end

			if arg_243_1.time_ >= var_246_28 + var_246_29 and arg_243_1.time_ < var_246_28 + var_246_29 + arg_246_0 and not isNil(var_246_27) and arg_243_1.var_.characterEffect10002ui_story then
				local var_246_32 = 0.5

				arg_243_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10002ui_story.fillRatio = var_246_32
			end

			local var_246_33 = 0

			if var_246_33 < arg_243_1.time_ and arg_243_1.time_ <= var_246_33 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_246_34 = 0

			if var_246_34 < arg_243_1.time_ and arg_243_1.time_ <= var_246_34 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_35 = 0
			local var_246_36 = 0.35

			if var_246_35 < arg_243_1.time_ and arg_243_1.time_ <= var_246_35 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_37 = arg_243_1:FormatText(StoryNameCfg[37].name)

				arg_243_1.leftNameTxt_.text = var_246_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_38 = arg_243_1:GetWordFromCfg(304081058)
				local var_246_39 = arg_243_1:FormatText(var_246_38.content)

				arg_243_1.text_.text = var_246_39

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_40 = 14
				local var_246_41 = utf8.len(var_246_39)
				local var_246_42 = var_246_40 <= 0 and var_246_36 or var_246_36 * (var_246_41 / var_246_40)

				if var_246_42 > 0 and var_246_36 < var_246_42 then
					arg_243_1.talkMaxDuration = var_246_42

					if var_246_42 + var_246_35 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_42 + var_246_35
					end
				end

				arg_243_1.text_.text = var_246_39
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081058", "story_v_out_304081.awb") ~= 0 then
					local var_246_43 = manager.audio:GetVoiceLength("story_v_out_304081", "304081058", "story_v_out_304081.awb") / 1000

					if var_246_43 + var_246_35 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_43 + var_246_35
					end

					if var_246_38.prefab_name ~= "" and arg_243_1.actors_[var_246_38.prefab_name] ~= nil then
						local var_246_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_38.prefab_name].transform, "story_v_out_304081", "304081058", "story_v_out_304081.awb")

						arg_243_1:RecordAudio("304081058", var_246_44)
						arg_243_1:RecordAudio("304081058", var_246_44)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_304081", "304081058", "story_v_out_304081.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_304081", "304081058", "story_v_out_304081.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_45 = math.max(var_246_36, arg_243_1.talkMaxDuration)

			if var_246_35 <= arg_243_1.time_ and arg_243_1.time_ < var_246_35 + var_246_45 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_35) / var_246_45

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_35 + var_246_45 and arg_243_1.time_ < var_246_35 + var_246_45 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play304081059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 304081059
		arg_247_1.duration_ = 9.23

		local var_247_0 = {
			zh = 9.233,
			ja = 9
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
				arg_247_0:Play304081060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10002ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect10002ui_story == nil then
				arg_247_1.var_.characterEffect10002ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect10002ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect10002ui_story then
				arg_247_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["1011ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1011ui_story == nil then
				arg_247_1.var_.characterEffect1011ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect1011ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1011ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1011ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1011ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0
			local var_250_11 = 1.075

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_12 = arg_247_1:FormatText(StoryNameCfg[39].name)

				arg_247_1.leftNameTxt_.text = var_250_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_13 = arg_247_1:GetWordFromCfg(304081059)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 42
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_11 or var_250_11 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_11 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081059", "story_v_out_304081.awb") ~= 0 then
					local var_250_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081059", "story_v_out_304081.awb") / 1000

					if var_250_18 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_10
					end

					if var_250_13.prefab_name ~= "" and arg_247_1.actors_[var_250_13.prefab_name] ~= nil then
						local var_250_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_13.prefab_name].transform, "story_v_out_304081", "304081059", "story_v_out_304081.awb")

						arg_247_1:RecordAudio("304081059", var_250_19)
						arg_247_1:RecordAudio("304081059", var_250_19)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_304081", "304081059", "story_v_out_304081.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_304081", "304081059", "story_v_out_304081.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_20 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_20

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_20 and arg_247_1.time_ < var_250_10 + var_250_20 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play304081060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 304081060
		arg_251_1.duration_ = 14.07

		local var_251_0 = {
			zh = 11.6,
			ja = 14.066
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play304081061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_1")
			end

			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_254_2 = 0
			local var_254_3 = 1.1

			if var_254_2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_4 = arg_251_1:FormatText(StoryNameCfg[39].name)

				arg_251_1.leftNameTxt_.text = var_254_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_5 = arg_251_1:GetWordFromCfg(304081060)
				local var_254_6 = arg_251_1:FormatText(var_254_5.content)

				arg_251_1.text_.text = var_254_6

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 44
				local var_254_8 = utf8.len(var_254_6)
				local var_254_9 = var_254_7 <= 0 and var_254_3 or var_254_3 * (var_254_8 / var_254_7)

				if var_254_9 > 0 and var_254_3 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_6
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081060", "story_v_out_304081.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081060", "story_v_out_304081.awb") / 1000

					if var_254_10 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_2
					end

					if var_254_5.prefab_name ~= "" and arg_251_1.actors_[var_254_5.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_5.prefab_name].transform, "story_v_out_304081", "304081060", "story_v_out_304081.awb")

						arg_251_1:RecordAudio("304081060", var_254_11)
						arg_251_1:RecordAudio("304081060", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_304081", "304081060", "story_v_out_304081.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_304081", "304081060", "story_v_out_304081.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_12 and arg_251_1.time_ < var_254_2 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play304081061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 304081061
		arg_255_1.duration_ = 9.2

		local var_255_0 = {
			zh = 9.2,
			ja = 1.333
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
				arg_255_0:Play304081062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1084ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1084ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0.7, -0.97, -6)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1084ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["1011ui_story"].transform
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.var_.moveOldPos1011ui_story = var_258_9.localPosition
			end

			local var_258_11 = 0.001

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11
				local var_258_13 = Vector3.New(0, 100, 0)

				var_258_9.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1011ui_story, var_258_13, var_258_12)

				local var_258_14 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_14.x, var_258_14.y, var_258_14.z)

				local var_258_15 = var_258_9.localEulerAngles

				var_258_15.z = 0
				var_258_15.x = 0
				var_258_9.localEulerAngles = var_258_15
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 then
				var_258_9.localPosition = Vector3.New(0, 100, 0)

				local var_258_16 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_16.x, var_258_16.y, var_258_16.z)

				local var_258_17 = var_258_9.localEulerAngles

				var_258_17.z = 0
				var_258_17.x = 0
				var_258_9.localEulerAngles = var_258_17
			end

			local var_258_18 = arg_255_1.actors_["1084ui_story"]
			local var_258_19 = 0

			if var_258_19 < arg_255_1.time_ and arg_255_1.time_ <= var_258_19 + arg_258_0 and not isNil(var_258_18) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_20 = 0.200000002980232

			if var_258_19 <= arg_255_1.time_ and arg_255_1.time_ < var_258_19 + var_258_20 and not isNil(var_258_18) then
				local var_258_21 = (arg_255_1.time_ - var_258_19) / var_258_20

				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_18) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_19 + var_258_20 and arg_255_1.time_ < var_258_19 + var_258_20 + arg_258_0 and not isNil(var_258_18) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_22 = arg_255_1.actors_["10002ui_story"]
			local var_258_23 = 0

			if var_258_23 < arg_255_1.time_ and arg_255_1.time_ <= var_258_23 + arg_258_0 and not isNil(var_258_22) and arg_255_1.var_.characterEffect10002ui_story == nil then
				arg_255_1.var_.characterEffect10002ui_story = var_258_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_24 = 0.200000002980232

			if var_258_23 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_24 and not isNil(var_258_22) then
				local var_258_25 = (arg_255_1.time_ - var_258_23) / var_258_24

				if arg_255_1.var_.characterEffect10002ui_story and not isNil(var_258_22) then
					local var_258_26 = Mathf.Lerp(0, 0.5, var_258_25)

					arg_255_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10002ui_story.fillRatio = var_258_26
				end
			end

			if arg_255_1.time_ >= var_258_23 + var_258_24 and arg_255_1.time_ < var_258_23 + var_258_24 + arg_258_0 and not isNil(var_258_22) and arg_255_1.var_.characterEffect10002ui_story then
				local var_258_27 = 0.5

				arg_255_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10002ui_story.fillRatio = var_258_27
			end

			local var_258_28 = 0

			if var_258_28 < arg_255_1.time_ and arg_255_1.time_ <= var_258_28 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_258_29 = 0

			if var_258_29 < arg_255_1.time_ and arg_255_1.time_ <= var_258_29 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_30 = 0
			local var_258_31 = 1.025

			if var_258_30 < arg_255_1.time_ and arg_255_1.time_ <= var_258_30 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_32 = arg_255_1:FormatText(StoryNameCfg[6].name)

				arg_255_1.leftNameTxt_.text = var_258_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_33 = arg_255_1:GetWordFromCfg(304081061)
				local var_258_34 = arg_255_1:FormatText(var_258_33.content)

				arg_255_1.text_.text = var_258_34

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_35 = 41
				local var_258_36 = utf8.len(var_258_34)
				local var_258_37 = var_258_35 <= 0 and var_258_31 or var_258_31 * (var_258_36 / var_258_35)

				if var_258_37 > 0 and var_258_31 < var_258_37 then
					arg_255_1.talkMaxDuration = var_258_37

					if var_258_37 + var_258_30 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_37 + var_258_30
					end
				end

				arg_255_1.text_.text = var_258_34
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081061", "story_v_out_304081.awb") ~= 0 then
					local var_258_38 = manager.audio:GetVoiceLength("story_v_out_304081", "304081061", "story_v_out_304081.awb") / 1000

					if var_258_38 + var_258_30 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_38 + var_258_30
					end

					if var_258_33.prefab_name ~= "" and arg_255_1.actors_[var_258_33.prefab_name] ~= nil then
						local var_258_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_33.prefab_name].transform, "story_v_out_304081", "304081061", "story_v_out_304081.awb")

						arg_255_1:RecordAudio("304081061", var_258_39)
						arg_255_1:RecordAudio("304081061", var_258_39)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_304081", "304081061", "story_v_out_304081.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_304081", "304081061", "story_v_out_304081.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_40 = math.max(var_258_31, arg_255_1.talkMaxDuration)

			if var_258_30 <= arg_255_1.time_ and arg_255_1.time_ < var_258_30 + var_258_40 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_30) / var_258_40

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_30 + var_258_40 and arg_255_1.time_ < var_258_30 + var_258_40 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play304081062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 304081062
		arg_259_1.duration_ = 4.67

		local var_259_0 = {
			zh = 4.666,
			ja = 2.9
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
				arg_259_0:Play304081063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10002ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10002ui_story == nil then
				arg_259_1.var_.characterEffect10002ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect10002ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10002ui_story then
				arg_259_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_262_4 = arg_259_1.actors_["1084ui_story"]
			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_6 = 0.200000002980232

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_6 and not isNil(var_262_4) then
				local var_262_7 = (arg_259_1.time_ - var_262_5) / var_262_6

				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_4) then
					local var_262_8 = Mathf.Lerp(0, 0.5, var_262_7)

					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_8
				end
			end

			if arg_259_1.time_ >= var_262_5 + var_262_6 and arg_259_1.time_ < var_262_5 + var_262_6 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect1084ui_story then
				local var_262_9 = 0.5

				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_9
			end

			local var_262_10 = 0
			local var_262_11 = 0.4

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_12 = arg_259_1:FormatText(StoryNameCfg[39].name)

				arg_259_1.leftNameTxt_.text = var_262_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_13 = arg_259_1:GetWordFromCfg(304081062)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 16
				local var_262_16 = utf8.len(var_262_14)
				local var_262_17 = var_262_15 <= 0 and var_262_11 or var_262_11 * (var_262_16 / var_262_15)

				if var_262_17 > 0 and var_262_11 < var_262_17 then
					arg_259_1.talkMaxDuration = var_262_17

					if var_262_17 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081062", "story_v_out_304081.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_304081", "304081062", "story_v_out_304081.awb") / 1000

					if var_262_18 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_10
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_304081", "304081062", "story_v_out_304081.awb")

						arg_259_1:RecordAudio("304081062", var_262_19)
						arg_259_1:RecordAudio("304081062", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_304081", "304081062", "story_v_out_304081.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_304081", "304081062", "story_v_out_304081.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_20 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_20 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_20

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_20 and arg_259_1.time_ < var_262_10 + var_262_20 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play304081063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 304081063
		arg_263_1.duration_ = 10.87

		local var_263_0 = {
			zh = 7.933,
			ja = 10.866
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
				arg_263_0:Play304081064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			local var_266_1 = 0
			local var_266_2 = 0.925

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_3 = arg_263_1:FormatText(StoryNameCfg[39].name)

				arg_263_1.leftNameTxt_.text = var_266_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(304081063)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 37
				local var_266_7 = utf8.len(var_266_5)
				local var_266_8 = var_266_6 <= 0 and var_266_2 or var_266_2 * (var_266_7 / var_266_6)

				if var_266_8 > 0 and var_266_2 < var_266_8 then
					arg_263_1.talkMaxDuration = var_266_8

					if var_266_8 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081063", "story_v_out_304081.awb") ~= 0 then
					local var_266_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081063", "story_v_out_304081.awb") / 1000

					if var_266_9 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_1
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_304081", "304081063", "story_v_out_304081.awb")

						arg_263_1:RecordAudio("304081063", var_266_10)
						arg_263_1:RecordAudio("304081063", var_266_10)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_304081", "304081063", "story_v_out_304081.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_304081", "304081063", "story_v_out_304081.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_11 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_11 and arg_263_1.time_ < var_266_1 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play304081064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 304081064
		arg_267_1.duration_ = 5.13

		local var_267_0 = {
			zh = 5.133,
			ja = 5.1
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
				arg_267_0:Play304081065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.65

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[39].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(304081064)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 26
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081064", "story_v_out_304081.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081064", "story_v_out_304081.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_304081", "304081064", "story_v_out_304081.awb")

						arg_267_1:RecordAudio("304081064", var_270_9)
						arg_267_1:RecordAudio("304081064", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_304081", "304081064", "story_v_out_304081.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_304081", "304081064", "story_v_out_304081.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play304081065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 304081065
		arg_271_1.duration_ = 6.07

		local var_271_0 = {
			zh = 5.033,
			ja = 6.066
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
				arg_271_0:Play304081066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1019ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1019ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(0.7, -1.08, -5.9)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1019ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["1084ui_story"].transform
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1.var_.moveOldPos1084ui_story = var_274_9.localPosition
			end

			local var_274_11 = 0.001

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11
				local var_274_13 = Vector3.New(0, 100, 0)

				var_274_9.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1084ui_story, var_274_13, var_274_12)

				local var_274_14 = manager.ui.mainCamera.transform.position - var_274_9.position

				var_274_9.forward = Vector3.New(var_274_14.x, var_274_14.y, var_274_14.z)

				local var_274_15 = var_274_9.localEulerAngles

				var_274_15.z = 0
				var_274_15.x = 0
				var_274_9.localEulerAngles = var_274_15
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 then
				var_274_9.localPosition = Vector3.New(0, 100, 0)

				local var_274_16 = manager.ui.mainCamera.transform.position - var_274_9.position

				var_274_9.forward = Vector3.New(var_274_16.x, var_274_16.y, var_274_16.z)

				local var_274_17 = var_274_9.localEulerAngles

				var_274_17.z = 0
				var_274_17.x = 0
				var_274_9.localEulerAngles = var_274_17
			end

			local var_274_18 = arg_271_1.actors_["1019ui_story"]
			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 and not isNil(var_274_18) and arg_271_1.var_.characterEffect1019ui_story == nil then
				arg_271_1.var_.characterEffect1019ui_story = var_274_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_20 = 0.200000002980232

			if var_274_19 <= arg_271_1.time_ and arg_271_1.time_ < var_274_19 + var_274_20 and not isNil(var_274_18) then
				local var_274_21 = (arg_271_1.time_ - var_274_19) / var_274_20

				if arg_271_1.var_.characterEffect1019ui_story and not isNil(var_274_18) then
					arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_19 + var_274_20 and arg_271_1.time_ < var_274_19 + var_274_20 + arg_274_0 and not isNil(var_274_18) and arg_271_1.var_.characterEffect1019ui_story then
				arg_271_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_274_22 = arg_271_1.actors_["10002ui_story"]
			local var_274_23 = 0

			if var_274_23 < arg_271_1.time_ and arg_271_1.time_ <= var_274_23 + arg_274_0 and not isNil(var_274_22) and arg_271_1.var_.characterEffect10002ui_story == nil then
				arg_271_1.var_.characterEffect10002ui_story = var_274_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_24 = 0.200000002980232

			if var_274_23 <= arg_271_1.time_ and arg_271_1.time_ < var_274_23 + var_274_24 and not isNil(var_274_22) then
				local var_274_25 = (arg_271_1.time_ - var_274_23) / var_274_24

				if arg_271_1.var_.characterEffect10002ui_story and not isNil(var_274_22) then
					local var_274_26 = Mathf.Lerp(0, 0.5, var_274_25)

					arg_271_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10002ui_story.fillRatio = var_274_26
				end
			end

			if arg_271_1.time_ >= var_274_23 + var_274_24 and arg_271_1.time_ < var_274_23 + var_274_24 + arg_274_0 and not isNil(var_274_22) and arg_271_1.var_.characterEffect10002ui_story then
				local var_274_27 = 0.5

				arg_271_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10002ui_story.fillRatio = var_274_27
			end

			local var_274_28 = 0

			if var_274_28 < arg_271_1.time_ and arg_271_1.time_ <= var_274_28 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action457")
			end

			local var_274_29 = 0

			if var_274_29 < arg_271_1.time_ and arg_271_1.time_ <= var_274_29 + arg_274_0 then
				arg_271_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_30 = 0
			local var_274_31 = 0.625

			if var_274_30 < arg_271_1.time_ and arg_271_1.time_ <= var_274_30 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_32 = arg_271_1:FormatText(StoryNameCfg[13].name)

				arg_271_1.leftNameTxt_.text = var_274_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_33 = arg_271_1:GetWordFromCfg(304081065)
				local var_274_34 = arg_271_1:FormatText(var_274_33.content)

				arg_271_1.text_.text = var_274_34

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_35 = 25
				local var_274_36 = utf8.len(var_274_34)
				local var_274_37 = var_274_35 <= 0 and var_274_31 or var_274_31 * (var_274_36 / var_274_35)

				if var_274_37 > 0 and var_274_31 < var_274_37 then
					arg_271_1.talkMaxDuration = var_274_37

					if var_274_37 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_37 + var_274_30
					end
				end

				arg_271_1.text_.text = var_274_34
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081065", "story_v_out_304081.awb") ~= 0 then
					local var_274_38 = manager.audio:GetVoiceLength("story_v_out_304081", "304081065", "story_v_out_304081.awb") / 1000

					if var_274_38 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_38 + var_274_30
					end

					if var_274_33.prefab_name ~= "" and arg_271_1.actors_[var_274_33.prefab_name] ~= nil then
						local var_274_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_33.prefab_name].transform, "story_v_out_304081", "304081065", "story_v_out_304081.awb")

						arg_271_1:RecordAudio("304081065", var_274_39)
						arg_271_1:RecordAudio("304081065", var_274_39)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_304081", "304081065", "story_v_out_304081.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_304081", "304081065", "story_v_out_304081.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_40 = math.max(var_274_31, arg_271_1.talkMaxDuration)

			if var_274_30 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_40 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_30) / var_274_40

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_30 + var_274_40 and arg_271_1.time_ < var_274_30 + var_274_40 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play304081066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 304081066
		arg_275_1.duration_ = 10.2

		local var_275_0 = {
			zh = 8.5,
			ja = 10.2
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
				arg_275_0:Play304081067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 1.125

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[13].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:GetWordFromCfg(304081066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 45
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081066", "story_v_out_304081.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081066", "story_v_out_304081.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_304081", "304081066", "story_v_out_304081.awb")

						arg_275_1:RecordAudio("304081066", var_278_9)
						arg_275_1:RecordAudio("304081066", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_304081", "304081066", "story_v_out_304081.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_304081", "304081066", "story_v_out_304081.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play304081067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 304081067
		arg_279_1.duration_ = 2.13

		local var_279_0 = {
			zh = 2.133,
			ja = 1.033
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
				arg_279_0:Play304081068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10002ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10002ui_story == nil then
				arg_279_1.var_.characterEffect10002ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect10002ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10002ui_story then
				arg_279_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["1019ui_story"]
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1019ui_story == nil then
				arg_279_1.var_.characterEffect1019ui_story = var_282_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_6 = 0.200000002980232

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 and not isNil(var_282_4) then
				local var_282_7 = (arg_279_1.time_ - var_282_5) / var_282_6

				if arg_279_1.var_.characterEffect1019ui_story and not isNil(var_282_4) then
					local var_282_8 = Mathf.Lerp(0, 0.5, var_282_7)

					arg_279_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1019ui_story.fillRatio = var_282_8
				end
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1019ui_story then
				local var_282_9 = 0.5

				arg_279_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1019ui_story.fillRatio = var_282_9
			end

			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_282_11 = 0

			if var_282_11 < arg_279_1.time_ and arg_279_1.time_ <= var_282_11 + arg_282_0 then
				arg_279_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_12 = 0
			local var_282_13 = 0.2

			if var_282_12 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_14 = arg_279_1:FormatText(StoryNameCfg[39].name)

				arg_279_1.leftNameTxt_.text = var_282_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_15 = arg_279_1:GetWordFromCfg(304081067)
				local var_282_16 = arg_279_1:FormatText(var_282_15.content)

				arg_279_1.text_.text = var_282_16

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_17 = 8
				local var_282_18 = utf8.len(var_282_16)
				local var_282_19 = var_282_17 <= 0 and var_282_13 or var_282_13 * (var_282_18 / var_282_17)

				if var_282_19 > 0 and var_282_13 < var_282_19 then
					arg_279_1.talkMaxDuration = var_282_19

					if var_282_19 + var_282_12 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_19 + var_282_12
					end
				end

				arg_279_1.text_.text = var_282_16
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081067", "story_v_out_304081.awb") ~= 0 then
					local var_282_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081067", "story_v_out_304081.awb") / 1000

					if var_282_20 + var_282_12 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_20 + var_282_12
					end

					if var_282_15.prefab_name ~= "" and arg_279_1.actors_[var_282_15.prefab_name] ~= nil then
						local var_282_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_15.prefab_name].transform, "story_v_out_304081", "304081067", "story_v_out_304081.awb")

						arg_279_1:RecordAudio("304081067", var_282_21)
						arg_279_1:RecordAudio("304081067", var_282_21)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_304081", "304081067", "story_v_out_304081.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_304081", "304081067", "story_v_out_304081.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_22 = math.max(var_282_13, arg_279_1.talkMaxDuration)

			if var_282_12 <= arg_279_1.time_ and arg_279_1.time_ < var_282_12 + var_282_22 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_12) / var_282_22

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_12 + var_282_22 and arg_279_1.time_ < var_282_12 + var_282_22 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play304081068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 304081068
		arg_283_1.duration_ = 8.53

		local var_283_0 = {
			zh = 6.6,
			ja = 8.533
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
				arg_283_0:Play304081069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1019ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1019ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1019ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = "1013ui_story"

			if arg_283_1.actors_[var_286_9] == nil then
				local var_286_10 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_286_10) then
					local var_286_11 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_283_1.stage_.transform)

					var_286_11.name = var_286_9
					var_286_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_283_1.actors_[var_286_9] = var_286_11

					local var_286_12 = var_286_11:GetComponentInChildren(typeof(CharacterEffect))

					var_286_12.enabled = true

					local var_286_13 = GameObjectTools.GetOrAddComponent(var_286_11, typeof(DynamicBoneHelper))

					if var_286_13 then
						var_286_13:EnableDynamicBone(false)
					end

					arg_283_1:ShowWeapon(var_286_12.transform, false)

					arg_283_1.var_[var_286_9 .. "Animator"] = var_286_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_283_1.var_[var_286_9 .. "Animator"].applyRootMotion = true
					arg_283_1.var_[var_286_9 .. "LipSync"] = var_286_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_286_14 = arg_283_1.actors_["1013ui_story"].transform
			local var_286_15 = 0

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.var_.moveOldPos1013ui_story = var_286_14.localPosition
			end

			local var_286_16 = 0.001

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_16 then
				local var_286_17 = (arg_283_1.time_ - var_286_15) / var_286_16
				local var_286_18 = Vector3.New(0.7, -0.66, -6.15)

				var_286_14.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1013ui_story, var_286_18, var_286_17)

				local var_286_19 = manager.ui.mainCamera.transform.position - var_286_14.position

				var_286_14.forward = Vector3.New(var_286_19.x, var_286_19.y, var_286_19.z)

				local var_286_20 = var_286_14.localEulerAngles

				var_286_20.z = 0
				var_286_20.x = 0
				var_286_14.localEulerAngles = var_286_20
			end

			if arg_283_1.time_ >= var_286_15 + var_286_16 and arg_283_1.time_ < var_286_15 + var_286_16 + arg_286_0 then
				var_286_14.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_286_21 = manager.ui.mainCamera.transform.position - var_286_14.position

				var_286_14.forward = Vector3.New(var_286_21.x, var_286_21.y, var_286_21.z)

				local var_286_22 = var_286_14.localEulerAngles

				var_286_22.z = 0
				var_286_22.x = 0
				var_286_14.localEulerAngles = var_286_22
			end

			local var_286_23 = arg_283_1.actors_["1013ui_story"]
			local var_286_24 = 0

			if var_286_24 < arg_283_1.time_ and arg_283_1.time_ <= var_286_24 + arg_286_0 and not isNil(var_286_23) and arg_283_1.var_.characterEffect1013ui_story == nil then
				arg_283_1.var_.characterEffect1013ui_story = var_286_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_25 = 0.200000002980232

			if var_286_24 <= arg_283_1.time_ and arg_283_1.time_ < var_286_24 + var_286_25 and not isNil(var_286_23) then
				local var_286_26 = (arg_283_1.time_ - var_286_24) / var_286_25

				if arg_283_1.var_.characterEffect1013ui_story and not isNil(var_286_23) then
					arg_283_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_24 + var_286_25 and arg_283_1.time_ < var_286_24 + var_286_25 + arg_286_0 and not isNil(var_286_23) and arg_283_1.var_.characterEffect1013ui_story then
				arg_283_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_286_27 = arg_283_1.actors_["10002ui_story"]
			local var_286_28 = 0

			if var_286_28 < arg_283_1.time_ and arg_283_1.time_ <= var_286_28 + arg_286_0 and not isNil(var_286_27) and arg_283_1.var_.characterEffect10002ui_story == nil then
				arg_283_1.var_.characterEffect10002ui_story = var_286_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_29 = 0.200000002980232

			if var_286_28 <= arg_283_1.time_ and arg_283_1.time_ < var_286_28 + var_286_29 and not isNil(var_286_27) then
				local var_286_30 = (arg_283_1.time_ - var_286_28) / var_286_29

				if arg_283_1.var_.characterEffect10002ui_story and not isNil(var_286_27) then
					local var_286_31 = Mathf.Lerp(0, 0.5, var_286_30)

					arg_283_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10002ui_story.fillRatio = var_286_31
				end
			end

			if arg_283_1.time_ >= var_286_28 + var_286_29 and arg_283_1.time_ < var_286_28 + var_286_29 + arg_286_0 and not isNil(var_286_27) and arg_283_1.var_.characterEffect10002ui_story then
				local var_286_32 = 0.5

				arg_283_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10002ui_story.fillRatio = var_286_32
			end

			local var_286_33 = 0

			if var_286_33 < arg_283_1.time_ and arg_283_1.time_ <= var_286_33 + arg_286_0 then
				arg_283_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action5_1")
			end

			local var_286_34 = 0

			if var_286_34 < arg_283_1.time_ and arg_283_1.time_ <= var_286_34 + arg_286_0 then
				arg_283_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_286_35 = 0
			local var_286_36 = 0.875

			if var_286_35 < arg_283_1.time_ and arg_283_1.time_ <= var_286_35 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_37 = arg_283_1:FormatText(StoryNameCfg[35].name)

				arg_283_1.leftNameTxt_.text = var_286_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_38 = arg_283_1:GetWordFromCfg(304081068)
				local var_286_39 = arg_283_1:FormatText(var_286_38.content)

				arg_283_1.text_.text = var_286_39

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_40 = 35
				local var_286_41 = utf8.len(var_286_39)
				local var_286_42 = var_286_40 <= 0 and var_286_36 or var_286_36 * (var_286_41 / var_286_40)

				if var_286_42 > 0 and var_286_36 < var_286_42 then
					arg_283_1.talkMaxDuration = var_286_42

					if var_286_42 + var_286_35 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_42 + var_286_35
					end
				end

				arg_283_1.text_.text = var_286_39
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081068", "story_v_out_304081.awb") ~= 0 then
					local var_286_43 = manager.audio:GetVoiceLength("story_v_out_304081", "304081068", "story_v_out_304081.awb") / 1000

					if var_286_43 + var_286_35 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_43 + var_286_35
					end

					if var_286_38.prefab_name ~= "" and arg_283_1.actors_[var_286_38.prefab_name] ~= nil then
						local var_286_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_38.prefab_name].transform, "story_v_out_304081", "304081068", "story_v_out_304081.awb")

						arg_283_1:RecordAudio("304081068", var_286_44)
						arg_283_1:RecordAudio("304081068", var_286_44)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_304081", "304081068", "story_v_out_304081.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_304081", "304081068", "story_v_out_304081.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_45 = math.max(var_286_36, arg_283_1.talkMaxDuration)

			if var_286_35 <= arg_283_1.time_ and arg_283_1.time_ < var_286_35 + var_286_45 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_35) / var_286_45

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_35 + var_286_45 and arg_283_1.time_ < var_286_35 + var_286_45 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play304081069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 304081069
		arg_287_1.duration_ = 5.33

		local var_287_0 = {
			zh = 3.666,
			ja = 5.333
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
				arg_287_0:Play304081070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = "3008ui_story"

			if arg_287_1.actors_[var_290_0] == nil then
				local var_290_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_290_1) then
					local var_290_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_287_1.stage_.transform)

					var_290_2.name = var_290_0
					var_290_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_287_1.actors_[var_290_0] = var_290_2

					local var_290_3 = var_290_2:GetComponentInChildren(typeof(CharacterEffect))

					var_290_3.enabled = true

					local var_290_4 = GameObjectTools.GetOrAddComponent(var_290_2, typeof(DynamicBoneHelper))

					if var_290_4 then
						var_290_4:EnableDynamicBone(false)
					end

					arg_287_1:ShowWeapon(var_290_3.transform, false)

					arg_287_1.var_[var_290_0 .. "Animator"] = var_290_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_287_1.var_[var_290_0 .. "Animator"].applyRootMotion = true
					arg_287_1.var_[var_290_0 .. "LipSync"] = var_290_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_290_5 = arg_287_1.actors_["3008ui_story"]
			local var_290_6 = 0

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect3008ui_story == nil then
				arg_287_1.var_.characterEffect3008ui_story = var_290_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_7 and not isNil(var_290_5) then
				local var_290_8 = (arg_287_1.time_ - var_290_6) / var_290_7

				if arg_287_1.var_.characterEffect3008ui_story and not isNil(var_290_5) then
					arg_287_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_6 + var_290_7 and arg_287_1.time_ < var_290_6 + var_290_7 + arg_290_0 and not isNil(var_290_5) and arg_287_1.var_.characterEffect3008ui_story then
				arg_287_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_290_9 = arg_287_1.actors_["1013ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1013ui_story == nil then
				arg_287_1.var_.characterEffect1013ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1013ui_story and not isNil(var_290_9) then
					local var_290_13 = Mathf.Lerp(0, 0.5, var_290_12)

					arg_287_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1013ui_story.fillRatio = var_290_13
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1013ui_story then
				local var_290_14 = 0.5

				arg_287_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1013ui_story.fillRatio = var_290_14
			end

			local var_290_15 = 1
			local var_290_16 = 1

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				local var_290_17 = "play"
				local var_290_18 = "music"

				arg_287_1:AudioAction(var_290_17, var_290_18, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_290_19 = ""
				local var_290_20 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_290_20 ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_20 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_20

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_20
						arg_287_1.bgmTxt2_.text = var_290_20
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_290_21 = 0
			local var_290_22 = 0.325

			if var_290_21 < arg_287_1.time_ and arg_287_1.time_ <= var_290_21 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_23 = arg_287_1:FormatText(StoryNameCfg[20].name)

				arg_287_1.leftNameTxt_.text = var_290_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_24 = arg_287_1:GetWordFromCfg(304081069)
				local var_290_25 = arg_287_1:FormatText(var_290_24.content)

				arg_287_1.text_.text = var_290_25

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_26 = 13
				local var_290_27 = utf8.len(var_290_25)
				local var_290_28 = var_290_26 <= 0 and var_290_22 or var_290_22 * (var_290_27 / var_290_26)

				if var_290_28 > 0 and var_290_22 < var_290_28 then
					arg_287_1.talkMaxDuration = var_290_28

					if var_290_28 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_28 + var_290_21
					end
				end

				arg_287_1.text_.text = var_290_25
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081069", "story_v_out_304081.awb") ~= 0 then
					local var_290_29 = manager.audio:GetVoiceLength("story_v_out_304081", "304081069", "story_v_out_304081.awb") / 1000

					if var_290_29 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_29 + var_290_21
					end

					if var_290_24.prefab_name ~= "" and arg_287_1.actors_[var_290_24.prefab_name] ~= nil then
						local var_290_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_24.prefab_name].transform, "story_v_out_304081", "304081069", "story_v_out_304081.awb")

						arg_287_1:RecordAudio("304081069", var_290_30)
						arg_287_1:RecordAudio("304081069", var_290_30)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_304081", "304081069", "story_v_out_304081.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_304081", "304081069", "story_v_out_304081.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_31 = math.max(var_290_22, arg_287_1.talkMaxDuration)

			if var_290_21 <= arg_287_1.time_ and arg_287_1.time_ < var_290_21 + var_290_31 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_21) / var_290_31

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_21 + var_290_31 and arg_287_1.time_ < var_290_21 + var_290_31 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play304081070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 304081070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play304081071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1013ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1013ui_story = var_295_0.localPosition
			end

			local var_295_2 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2
				local var_295_4 = Vector3.New(0, 100, 0)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1013ui_story, var_295_4, var_295_3)

				local var_295_5 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_5.x, var_295_5.y, var_295_5.z)

				local var_295_6 = var_295_0.localEulerAngles

				var_295_6.z = 0
				var_295_6.x = 0
				var_295_0.localEulerAngles = var_295_6
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, 100, 0)

				local var_295_7 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_7.x, var_295_7.y, var_295_7.z)

				local var_295_8 = var_295_0.localEulerAngles

				var_295_8.z = 0
				var_295_8.x = 0
				var_295_0.localEulerAngles = var_295_8
			end

			local var_295_9 = arg_292_1.actors_["10002ui_story"].transform
			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 then
				arg_292_1.var_.moveOldPos10002ui_story = var_295_9.localPosition
			end

			local var_295_11 = 0.001

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_11 then
				local var_295_12 = (arg_292_1.time_ - var_295_10) / var_295_11
				local var_295_13 = Vector3.New(0, 100, 0)

				var_295_9.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10002ui_story, var_295_13, var_295_12)

				local var_295_14 = manager.ui.mainCamera.transform.position - var_295_9.position

				var_295_9.forward = Vector3.New(var_295_14.x, var_295_14.y, var_295_14.z)

				local var_295_15 = var_295_9.localEulerAngles

				var_295_15.z = 0
				var_295_15.x = 0
				var_295_9.localEulerAngles = var_295_15
			end

			if arg_292_1.time_ >= var_295_10 + var_295_11 and arg_292_1.time_ < var_295_10 + var_295_11 + arg_295_0 then
				var_295_9.localPosition = Vector3.New(0, 100, 0)

				local var_295_16 = manager.ui.mainCamera.transform.position - var_295_9.position

				var_295_9.forward = Vector3.New(var_295_16.x, var_295_16.y, var_295_16.z)

				local var_295_17 = var_295_9.localEulerAngles

				var_295_17.z = 0
				var_295_17.x = 0
				var_295_9.localEulerAngles = var_295_17
			end

			local var_295_18 = arg_292_1.actors_["3008ui_story"]
			local var_295_19 = 0

			if var_295_19 < arg_292_1.time_ and arg_292_1.time_ <= var_295_19 + arg_295_0 and not isNil(var_295_18) and arg_292_1.var_.characterEffect3008ui_story == nil then
				arg_292_1.var_.characterEffect3008ui_story = var_295_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_20 = 0.200000002980232

			if var_295_19 <= arg_292_1.time_ and arg_292_1.time_ < var_295_19 + var_295_20 and not isNil(var_295_18) then
				local var_295_21 = (arg_292_1.time_ - var_295_19) / var_295_20

				if arg_292_1.var_.characterEffect3008ui_story and not isNil(var_295_18) then
					local var_295_22 = Mathf.Lerp(0, 0.5, var_295_21)

					arg_292_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_292_1.var_.characterEffect3008ui_story.fillRatio = var_295_22
				end
			end

			if arg_292_1.time_ >= var_295_19 + var_295_20 and arg_292_1.time_ < var_295_19 + var_295_20 + arg_295_0 and not isNil(var_295_18) and arg_292_1.var_.characterEffect3008ui_story then
				local var_295_23 = 0.5

				arg_292_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_292_1.var_.characterEffect3008ui_story.fillRatio = var_295_23
			end

			local var_295_24 = 0
			local var_295_25 = 1.675

			if var_295_24 < arg_292_1.time_ and arg_292_1.time_ <= var_295_24 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_26 = arg_292_1:GetWordFromCfg(304081070)
				local var_295_27 = arg_292_1:FormatText(var_295_26.content)

				arg_292_1.text_.text = var_295_27

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_28 = 67
				local var_295_29 = utf8.len(var_295_27)
				local var_295_30 = var_295_28 <= 0 and var_295_25 or var_295_25 * (var_295_29 / var_295_28)

				if var_295_30 > 0 and var_295_25 < var_295_30 then
					arg_292_1.talkMaxDuration = var_295_30

					if var_295_30 + var_295_24 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_30 + var_295_24
					end
				end

				arg_292_1.text_.text = var_295_27
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_31 = math.max(var_295_25, arg_292_1.talkMaxDuration)

			if var_295_24 <= arg_292_1.time_ and arg_292_1.time_ < var_295_24 + var_295_31 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_24) / var_295_31

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_24 + var_295_31 and arg_292_1.time_ < var_295_24 + var_295_31 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play304081071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 304081071
		arg_296_1.duration_ = 5.63

		local var_296_0 = {
			zh = 5.633,
			ja = 1.999999999999
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
				arg_296_0:Play304081072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1084ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1084ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(-0.7, -0.97, -6)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1084ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = arg_296_1.actors_["1084ui_story"]
			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1084ui_story == nil then
				arg_296_1.var_.characterEffect1084ui_story = var_299_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_11 = 0.200000002980232

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_11 and not isNil(var_299_9) then
				local var_299_12 = (arg_296_1.time_ - var_299_10) / var_299_11

				if arg_296_1.var_.characterEffect1084ui_story and not isNil(var_299_9) then
					arg_296_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_10 + var_299_11 and arg_296_1.time_ < var_299_10 + var_299_11 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1084ui_story then
				arg_296_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_299_13 = 0

			if var_299_13 < arg_296_1.time_ and arg_296_1.time_ <= var_299_13 + arg_299_0 then
				arg_296_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_299_14 = 0

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_299_15 = 0
			local var_299_16 = 0.65

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_17 = arg_296_1:FormatText(StoryNameCfg[6].name)

				arg_296_1.leftNameTxt_.text = var_299_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:GetWordFromCfg(304081071)
				local var_299_19 = arg_296_1:FormatText(var_299_18.content)

				arg_296_1.text_.text = var_299_19

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_20 = 26
				local var_299_21 = utf8.len(var_299_19)
				local var_299_22 = var_299_20 <= 0 and var_299_16 or var_299_16 * (var_299_21 / var_299_20)

				if var_299_22 > 0 and var_299_16 < var_299_22 then
					arg_296_1.talkMaxDuration = var_299_22

					if var_299_22 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_22 + var_299_15
					end
				end

				arg_296_1.text_.text = var_299_19
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081071", "story_v_out_304081.awb") ~= 0 then
					local var_299_23 = manager.audio:GetVoiceLength("story_v_out_304081", "304081071", "story_v_out_304081.awb") / 1000

					if var_299_23 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_23 + var_299_15
					end

					if var_299_18.prefab_name ~= "" and arg_296_1.actors_[var_299_18.prefab_name] ~= nil then
						local var_299_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_18.prefab_name].transform, "story_v_out_304081", "304081071", "story_v_out_304081.awb")

						arg_296_1:RecordAudio("304081071", var_299_24)
						arg_296_1:RecordAudio("304081071", var_299_24)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_304081", "304081071", "story_v_out_304081.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_304081", "304081071", "story_v_out_304081.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_25 = math.max(var_299_16, arg_296_1.talkMaxDuration)

			if var_299_15 <= arg_296_1.time_ and arg_296_1.time_ < var_299_15 + var_299_25 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_15) / var_299_25

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_15 + var_299_25 and arg_296_1.time_ < var_299_15 + var_299_25 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play304081072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 304081072
		arg_300_1.duration_ = 6

		local var_300_0 = {
			zh = 4.866,
			ja = 6
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
				arg_300_0:Play304081073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["3008ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos3008ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0.7, -1.51, -4.3)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos3008ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["3008ui_story"]
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect3008ui_story == nil then
				arg_300_1.var_.characterEffect3008ui_story = var_303_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_11 = 0.200000002980232

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_11 and not isNil(var_303_9) then
				local var_303_12 = (arg_300_1.time_ - var_303_10) / var_303_11

				if arg_300_1.var_.characterEffect3008ui_story and not isNil(var_303_9) then
					arg_300_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_10 + var_303_11 and arg_300_1.time_ < var_303_10 + var_303_11 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect3008ui_story then
				arg_300_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_303_13 = arg_300_1.actors_["1084ui_story"]
			local var_303_14 = 0

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1084ui_story == nil then
				arg_300_1.var_.characterEffect1084ui_story = var_303_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_15 = 0.200000002980232

			if var_303_14 <= arg_300_1.time_ and arg_300_1.time_ < var_303_14 + var_303_15 and not isNil(var_303_13) then
				local var_303_16 = (arg_300_1.time_ - var_303_14) / var_303_15

				if arg_300_1.var_.characterEffect1084ui_story and not isNil(var_303_13) then
					local var_303_17 = Mathf.Lerp(0, 0.5, var_303_16)

					arg_300_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1084ui_story.fillRatio = var_303_17
				end
			end

			if arg_300_1.time_ >= var_303_14 + var_303_15 and arg_300_1.time_ < var_303_14 + var_303_15 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1084ui_story then
				local var_303_18 = 0.5

				arg_300_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1084ui_story.fillRatio = var_303_18
			end

			local var_303_19 = 0

			if var_303_19 < arg_300_1.time_ and arg_300_1.time_ <= var_303_19 + arg_303_0 then
				arg_300_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_303_20 = 0

			if var_303_20 < arg_300_1.time_ and arg_300_1.time_ <= var_303_20 + arg_303_0 then
				arg_300_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_303_21 = 0
			local var_303_22 = 0.475

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_23 = arg_300_1:FormatText(StoryNameCfg[20].name)

				arg_300_1.leftNameTxt_.text = var_303_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_24 = arg_300_1:GetWordFromCfg(304081072)
				local var_303_25 = arg_300_1:FormatText(var_303_24.content)

				arg_300_1.text_.text = var_303_25

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_26 = 19
				local var_303_27 = utf8.len(var_303_25)
				local var_303_28 = var_303_26 <= 0 and var_303_22 or var_303_22 * (var_303_27 / var_303_26)

				if var_303_28 > 0 and var_303_22 < var_303_28 then
					arg_300_1.talkMaxDuration = var_303_28

					if var_303_28 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_21
					end
				end

				arg_300_1.text_.text = var_303_25
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081072", "story_v_out_304081.awb") ~= 0 then
					local var_303_29 = manager.audio:GetVoiceLength("story_v_out_304081", "304081072", "story_v_out_304081.awb") / 1000

					if var_303_29 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_29 + var_303_21
					end

					if var_303_24.prefab_name ~= "" and arg_300_1.actors_[var_303_24.prefab_name] ~= nil then
						local var_303_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_24.prefab_name].transform, "story_v_out_304081", "304081072", "story_v_out_304081.awb")

						arg_300_1:RecordAudio("304081072", var_303_30)
						arg_300_1:RecordAudio("304081072", var_303_30)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_304081", "304081072", "story_v_out_304081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_304081", "304081072", "story_v_out_304081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_31 = math.max(var_303_22, arg_300_1.talkMaxDuration)

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_31 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_21) / var_303_31

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_21 + var_303_31 and arg_300_1.time_ < var_303_21 + var_303_31 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play304081073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 304081073
		arg_304_1.duration_ = 6.43

		local var_304_0 = {
			zh = 5.633,
			ja = 6.433
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play304081074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.7

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[20].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(304081073)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 28
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081073", "story_v_out_304081.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081073", "story_v_out_304081.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_304081", "304081073", "story_v_out_304081.awb")

						arg_304_1:RecordAudio("304081073", var_307_9)
						arg_304_1:RecordAudio("304081073", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_304081", "304081073", "story_v_out_304081.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_304081", "304081073", "story_v_out_304081.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play304081074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 304081074
		arg_308_1.duration_ = 5.27

		local var_308_0 = {
			zh = 5.266,
			ja = 1.999999999999
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play304081075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1084ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_0) then
					arg_308_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1084ui_story then
				arg_308_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_311_4 = arg_308_1.actors_["3008ui_story"]
			local var_311_5 = 0

			if var_311_5 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 and not isNil(var_311_4) and arg_308_1.var_.characterEffect3008ui_story == nil then
				arg_308_1.var_.characterEffect3008ui_story = var_311_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_6 and not isNil(var_311_4) then
				local var_311_7 = (arg_308_1.time_ - var_311_5) / var_311_6

				if arg_308_1.var_.characterEffect3008ui_story and not isNil(var_311_4) then
					local var_311_8 = Mathf.Lerp(0, 0.5, var_311_7)

					arg_308_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_308_1.var_.characterEffect3008ui_story.fillRatio = var_311_8
				end
			end

			if arg_308_1.time_ >= var_311_5 + var_311_6 and arg_308_1.time_ < var_311_5 + var_311_6 + arg_311_0 and not isNil(var_311_4) and arg_308_1.var_.characterEffect3008ui_story then
				local var_311_9 = 0.5

				arg_308_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_308_1.var_.characterEffect3008ui_story.fillRatio = var_311_9
			end

			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 then
				arg_308_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action498")
			end

			local var_311_11 = 0

			if var_311_11 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
				arg_308_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_311_12 = 0
			local var_311_13 = 0.6

			if var_311_12 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_14 = arg_308_1:FormatText(StoryNameCfg[6].name)

				arg_308_1.leftNameTxt_.text = var_311_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_15 = arg_308_1:GetWordFromCfg(304081074)
				local var_311_16 = arg_308_1:FormatText(var_311_15.content)

				arg_308_1.text_.text = var_311_16

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_17 = 24
				local var_311_18 = utf8.len(var_311_16)
				local var_311_19 = var_311_17 <= 0 and var_311_13 or var_311_13 * (var_311_18 / var_311_17)

				if var_311_19 > 0 and var_311_13 < var_311_19 then
					arg_308_1.talkMaxDuration = var_311_19

					if var_311_19 + var_311_12 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_19 + var_311_12
					end
				end

				arg_308_1.text_.text = var_311_16
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081074", "story_v_out_304081.awb") ~= 0 then
					local var_311_20 = manager.audio:GetVoiceLength("story_v_out_304081", "304081074", "story_v_out_304081.awb") / 1000

					if var_311_20 + var_311_12 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_20 + var_311_12
					end

					if var_311_15.prefab_name ~= "" and arg_308_1.actors_[var_311_15.prefab_name] ~= nil then
						local var_311_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_15.prefab_name].transform, "story_v_out_304081", "304081074", "story_v_out_304081.awb")

						arg_308_1:RecordAudio("304081074", var_311_21)
						arg_308_1:RecordAudio("304081074", var_311_21)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_304081", "304081074", "story_v_out_304081.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_304081", "304081074", "story_v_out_304081.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_22 = math.max(var_311_13, arg_308_1.talkMaxDuration)

			if var_311_12 <= arg_308_1.time_ and arg_308_1.time_ < var_311_12 + var_311_22 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_12) / var_311_22

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_12 + var_311_22 and arg_308_1.time_ < var_311_12 + var_311_22 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play304081075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 304081075
		arg_312_1.duration_ = 7.53

		local var_312_0 = {
			zh = 4.6,
			ja = 7.533
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
				arg_312_0:Play304081076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["3008ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect3008ui_story == nil then
				arg_312_1.var_.characterEffect3008ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect3008ui_story and not isNil(var_315_0) then
					arg_312_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect3008ui_story then
				arg_312_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_315_4 = arg_312_1.actors_["1084ui_story"]
			local var_315_5 = 0

			if var_315_5 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 and not isNil(var_315_4) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = var_315_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_6 = 0.200000002980232

			if var_315_5 <= arg_312_1.time_ and arg_312_1.time_ < var_315_5 + var_315_6 and not isNil(var_315_4) then
				local var_315_7 = (arg_312_1.time_ - var_315_5) / var_315_6

				if arg_312_1.var_.characterEffect1084ui_story and not isNil(var_315_4) then
					local var_315_8 = Mathf.Lerp(0, 0.5, var_315_7)

					arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1084ui_story.fillRatio = var_315_8
				end
			end

			if arg_312_1.time_ >= var_315_5 + var_315_6 and arg_312_1.time_ < var_315_5 + var_315_6 + arg_315_0 and not isNil(var_315_4) and arg_312_1.var_.characterEffect1084ui_story then
				local var_315_9 = 0.5

				arg_312_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1084ui_story.fillRatio = var_315_9
			end

			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 then
				arg_312_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_315_11 = 0
			local var_315_12 = 0.575

			if var_315_11 < arg_312_1.time_ and arg_312_1.time_ <= var_315_11 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_13 = arg_312_1:FormatText(StoryNameCfg[20].name)

				arg_312_1.leftNameTxt_.text = var_315_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_14 = arg_312_1:GetWordFromCfg(304081075)
				local var_315_15 = arg_312_1:FormatText(var_315_14.content)

				arg_312_1.text_.text = var_315_15

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_16 = 23
				local var_315_17 = utf8.len(var_315_15)
				local var_315_18 = var_315_16 <= 0 and var_315_12 or var_315_12 * (var_315_17 / var_315_16)

				if var_315_18 > 0 and var_315_12 < var_315_18 then
					arg_312_1.talkMaxDuration = var_315_18

					if var_315_18 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_18 + var_315_11
					end
				end

				arg_312_1.text_.text = var_315_15
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081075", "story_v_out_304081.awb") ~= 0 then
					local var_315_19 = manager.audio:GetVoiceLength("story_v_out_304081", "304081075", "story_v_out_304081.awb") / 1000

					if var_315_19 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_19 + var_315_11
					end

					if var_315_14.prefab_name ~= "" and arg_312_1.actors_[var_315_14.prefab_name] ~= nil then
						local var_315_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_14.prefab_name].transform, "story_v_out_304081", "304081075", "story_v_out_304081.awb")

						arg_312_1:RecordAudio("304081075", var_315_20)
						arg_312_1:RecordAudio("304081075", var_315_20)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_304081", "304081075", "story_v_out_304081.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_304081", "304081075", "story_v_out_304081.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_21 = math.max(var_315_12, arg_312_1.talkMaxDuration)

			if var_315_11 <= arg_312_1.time_ and arg_312_1.time_ < var_315_11 + var_315_21 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_11) / var_315_21

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_11 + var_315_21 and arg_312_1.time_ < var_315_11 + var_315_21 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play304081076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 304081076
		arg_316_1.duration_ = 9.2

		local var_316_0 = {
			zh = 5.666,
			ja = 9.2
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
				arg_316_0:Play304081077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_319_2 = 0
			local var_319_3 = 0.625

			if var_319_2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_4 = arg_316_1:FormatText(StoryNameCfg[20].name)

				arg_316_1.leftNameTxt_.text = var_319_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_5 = arg_316_1:GetWordFromCfg(304081076)
				local var_319_6 = arg_316_1:FormatText(var_319_5.content)

				arg_316_1.text_.text = var_319_6

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_7 = 25
				local var_319_8 = utf8.len(var_319_6)
				local var_319_9 = var_319_7 <= 0 and var_319_3 or var_319_3 * (var_319_8 / var_319_7)

				if var_319_9 > 0 and var_319_3 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_2
					end
				end

				arg_316_1.text_.text = var_319_6
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081076", "story_v_out_304081.awb") ~= 0 then
					local var_319_10 = manager.audio:GetVoiceLength("story_v_out_304081", "304081076", "story_v_out_304081.awb") / 1000

					if var_319_10 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_2
					end

					if var_319_5.prefab_name ~= "" and arg_316_1.actors_[var_319_5.prefab_name] ~= nil then
						local var_319_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_5.prefab_name].transform, "story_v_out_304081", "304081076", "story_v_out_304081.awb")

						arg_316_1:RecordAudio("304081076", var_319_11)
						arg_316_1:RecordAudio("304081076", var_319_11)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_304081", "304081076", "story_v_out_304081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_304081", "304081076", "story_v_out_304081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_3, arg_316_1.talkMaxDuration)

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_2) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_2 + var_319_12 and arg_316_1.time_ < var_319_2 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play304081077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 304081077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play304081078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["3008ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos3008ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(0, 100, 0)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos3008ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, 100, 0)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = arg_320_1.actors_["1084ui_story"].transform
			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 then
				arg_320_1.var_.moveOldPos1084ui_story = var_323_9.localPosition
			end

			local var_323_11 = 0.001

			if var_323_10 <= arg_320_1.time_ and arg_320_1.time_ < var_323_10 + var_323_11 then
				local var_323_12 = (arg_320_1.time_ - var_323_10) / var_323_11
				local var_323_13 = Vector3.New(0, 100, 0)

				var_323_9.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1084ui_story, var_323_13, var_323_12)

				local var_323_14 = manager.ui.mainCamera.transform.position - var_323_9.position

				var_323_9.forward = Vector3.New(var_323_14.x, var_323_14.y, var_323_14.z)

				local var_323_15 = var_323_9.localEulerAngles

				var_323_15.z = 0
				var_323_15.x = 0
				var_323_9.localEulerAngles = var_323_15
			end

			if arg_320_1.time_ >= var_323_10 + var_323_11 and arg_320_1.time_ < var_323_10 + var_323_11 + arg_323_0 then
				var_323_9.localPosition = Vector3.New(0, 100, 0)

				local var_323_16 = manager.ui.mainCamera.transform.position - var_323_9.position

				var_323_9.forward = Vector3.New(var_323_16.x, var_323_16.y, var_323_16.z)

				local var_323_17 = var_323_9.localEulerAngles

				var_323_17.z = 0
				var_323_17.x = 0
				var_323_9.localEulerAngles = var_323_17
			end

			local var_323_18 = arg_320_1.actors_["3008ui_story"]
			local var_323_19 = 0

			if var_323_19 < arg_320_1.time_ and arg_320_1.time_ <= var_323_19 + arg_323_0 and not isNil(var_323_18) and arg_320_1.var_.characterEffect3008ui_story == nil then
				arg_320_1.var_.characterEffect3008ui_story = var_323_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_20 = 0.200000002980232

			if var_323_19 <= arg_320_1.time_ and arg_320_1.time_ < var_323_19 + var_323_20 and not isNil(var_323_18) then
				local var_323_21 = (arg_320_1.time_ - var_323_19) / var_323_20

				if arg_320_1.var_.characterEffect3008ui_story and not isNil(var_323_18) then
					local var_323_22 = Mathf.Lerp(0, 0.5, var_323_21)

					arg_320_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_320_1.var_.characterEffect3008ui_story.fillRatio = var_323_22
				end
			end

			if arg_320_1.time_ >= var_323_19 + var_323_20 and arg_320_1.time_ < var_323_19 + var_323_20 + arg_323_0 and not isNil(var_323_18) and arg_320_1.var_.characterEffect3008ui_story then
				local var_323_23 = 0.5

				arg_320_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_320_1.var_.characterEffect3008ui_story.fillRatio = var_323_23
			end

			local var_323_24 = 0
			local var_323_25 = 0.85

			if var_323_24 < arg_320_1.time_ and arg_320_1.time_ <= var_323_24 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_26 = arg_320_1:GetWordFromCfg(304081077)
				local var_323_27 = arg_320_1:FormatText(var_323_26.content)

				arg_320_1.text_.text = var_323_27

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_28 = 34
				local var_323_29 = utf8.len(var_323_27)
				local var_323_30 = var_323_28 <= 0 and var_323_25 or var_323_25 * (var_323_29 / var_323_28)

				if var_323_30 > 0 and var_323_25 < var_323_30 then
					arg_320_1.talkMaxDuration = var_323_30

					if var_323_30 + var_323_24 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_30 + var_323_24
					end
				end

				arg_320_1.text_.text = var_323_27
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_31 = math.max(var_323_25, arg_320_1.talkMaxDuration)

			if var_323_24 <= arg_320_1.time_ and arg_320_1.time_ < var_323_24 + var_323_31 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_24) / var_323_31

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_24 + var_323_31 and arg_320_1.time_ < var_323_24 + var_323_31 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play304081078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 304081078
		arg_324_1.duration_ = 8.2

		local var_324_0 = {
			zh = 6.533,
			ja = 8.2
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play304081079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["3008ui_story"].transform
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.var_.moveOldPos3008ui_story = var_327_0.localPosition
			end

			local var_327_2 = 0.001

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2
				local var_327_4 = Vector3.New(0, -1.51, -4.3)

				var_327_0.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos3008ui_story, var_327_4, var_327_3)

				local var_327_5 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_5.x, var_327_5.y, var_327_5.z)

				local var_327_6 = var_327_0.localEulerAngles

				var_327_6.z = 0
				var_327_6.x = 0
				var_327_0.localEulerAngles = var_327_6
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 then
				var_327_0.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_327_7 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_7.x, var_327_7.y, var_327_7.z)

				local var_327_8 = var_327_0.localEulerAngles

				var_327_8.z = 0
				var_327_8.x = 0
				var_327_0.localEulerAngles = var_327_8
			end

			local var_327_9 = arg_324_1.actors_["3008ui_story"]
			local var_327_10 = 0

			if var_327_10 < arg_324_1.time_ and arg_324_1.time_ <= var_327_10 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect3008ui_story == nil then
				arg_324_1.var_.characterEffect3008ui_story = var_327_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_11 = 0.200000002980232

			if var_327_10 <= arg_324_1.time_ and arg_324_1.time_ < var_327_10 + var_327_11 and not isNil(var_327_9) then
				local var_327_12 = (arg_324_1.time_ - var_327_10) / var_327_11

				if arg_324_1.var_.characterEffect3008ui_story and not isNil(var_327_9) then
					arg_324_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_10 + var_327_11 and arg_324_1.time_ < var_327_10 + var_327_11 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect3008ui_story then
				arg_324_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_327_13 = 0

			if var_327_13 < arg_324_1.time_ and arg_324_1.time_ <= var_327_13 + arg_327_0 then
				arg_324_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			local var_327_14 = 0

			if var_327_14 < arg_324_1.time_ and arg_324_1.time_ <= var_327_14 + arg_327_0 then
				arg_324_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_15 = 0
			local var_327_16 = 0.75

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_17 = arg_324_1:FormatText(StoryNameCfg[20].name)

				arg_324_1.leftNameTxt_.text = var_327_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_18 = arg_324_1:GetWordFromCfg(304081078)
				local var_327_19 = arg_324_1:FormatText(var_327_18.content)

				arg_324_1.text_.text = var_327_19

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_20 = 30
				local var_327_21 = utf8.len(var_327_19)
				local var_327_22 = var_327_20 <= 0 and var_327_16 or var_327_16 * (var_327_21 / var_327_20)

				if var_327_22 > 0 and var_327_16 < var_327_22 then
					arg_324_1.talkMaxDuration = var_327_22

					if var_327_22 + var_327_15 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_22 + var_327_15
					end
				end

				arg_324_1.text_.text = var_327_19
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081078", "story_v_out_304081.awb") ~= 0 then
					local var_327_23 = manager.audio:GetVoiceLength("story_v_out_304081", "304081078", "story_v_out_304081.awb") / 1000

					if var_327_23 + var_327_15 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_23 + var_327_15
					end

					if var_327_18.prefab_name ~= "" and arg_324_1.actors_[var_327_18.prefab_name] ~= nil then
						local var_327_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_18.prefab_name].transform, "story_v_out_304081", "304081078", "story_v_out_304081.awb")

						arg_324_1:RecordAudio("304081078", var_327_24)
						arg_324_1:RecordAudio("304081078", var_327_24)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_304081", "304081078", "story_v_out_304081.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_304081", "304081078", "story_v_out_304081.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_25 = math.max(var_327_16, arg_324_1.talkMaxDuration)

			if var_327_15 <= arg_324_1.time_ and arg_324_1.time_ < var_327_15 + var_327_25 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_15) / var_327_25

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_15 + var_327_25 and arg_324_1.time_ < var_327_15 + var_327_25 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play304081079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 304081079
		arg_328_1.duration_ = 6.83

		local var_328_0 = {
			zh = 6.7,
			ja = 6.833
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play304081080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1013ui_story"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos1013ui_story = var_331_0.localPosition
			end

			local var_331_2 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2
				local var_331_4 = Vector3.New(0, -0.66, -6.15)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1013ui_story, var_331_4, var_331_3)

				local var_331_5 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_5.x, var_331_5.y, var_331_5.z)

				local var_331_6 = var_331_0.localEulerAngles

				var_331_6.z = 0
				var_331_6.x = 0
				var_331_0.localEulerAngles = var_331_6
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_331_7 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_7.x, var_331_7.y, var_331_7.z)

				local var_331_8 = var_331_0.localEulerAngles

				var_331_8.z = 0
				var_331_8.x = 0
				var_331_0.localEulerAngles = var_331_8
			end

			local var_331_9 = arg_328_1.actors_["1013ui_story"]
			local var_331_10 = 0

			if var_331_10 < arg_328_1.time_ and arg_328_1.time_ <= var_331_10 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect1013ui_story == nil then
				arg_328_1.var_.characterEffect1013ui_story = var_331_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_11 = 0.200000002980232

			if var_331_10 <= arg_328_1.time_ and arg_328_1.time_ < var_331_10 + var_331_11 and not isNil(var_331_9) then
				local var_331_12 = (arg_328_1.time_ - var_331_10) / var_331_11

				if arg_328_1.var_.characterEffect1013ui_story and not isNil(var_331_9) then
					arg_328_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_10 + var_331_11 and arg_328_1.time_ < var_331_10 + var_331_11 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect1013ui_story then
				arg_328_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_331_13 = arg_328_1.actors_["3008ui_story"]
			local var_331_14 = 0

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 and not isNil(var_331_13) and arg_328_1.var_.characterEffect3008ui_story == nil then
				arg_328_1.var_.characterEffect3008ui_story = var_331_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_15 = 0.200000002980232

			if var_331_14 <= arg_328_1.time_ and arg_328_1.time_ < var_331_14 + var_331_15 and not isNil(var_331_13) then
				local var_331_16 = (arg_328_1.time_ - var_331_14) / var_331_15

				if arg_328_1.var_.characterEffect3008ui_story and not isNil(var_331_13) then
					local var_331_17 = Mathf.Lerp(0, 0.5, var_331_16)

					arg_328_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_328_1.var_.characterEffect3008ui_story.fillRatio = var_331_17
				end
			end

			if arg_328_1.time_ >= var_331_14 + var_331_15 and arg_328_1.time_ < var_331_14 + var_331_15 + arg_331_0 and not isNil(var_331_13) and arg_328_1.var_.characterEffect3008ui_story then
				local var_331_18 = 0.5

				arg_328_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_328_1.var_.characterEffect3008ui_story.fillRatio = var_331_18
			end

			local var_331_19 = 0

			if var_331_19 < arg_328_1.time_ and arg_328_1.time_ <= var_331_19 + arg_331_0 then
				arg_328_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action452")
			end

			local var_331_20 = 0

			if var_331_20 < arg_328_1.time_ and arg_328_1.time_ <= var_331_20 + arg_331_0 then
				arg_328_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_331_21 = arg_328_1.actors_["3008ui_story"].transform
			local var_331_22 = 0

			if var_331_22 < arg_328_1.time_ and arg_328_1.time_ <= var_331_22 + arg_331_0 then
				arg_328_1.var_.moveOldPos3008ui_story = var_331_21.localPosition
			end

			local var_331_23 = 0.001

			if var_331_22 <= arg_328_1.time_ and arg_328_1.time_ < var_331_22 + var_331_23 then
				local var_331_24 = (arg_328_1.time_ - var_331_22) / var_331_23
				local var_331_25 = Vector3.New(0, 100, 0)

				var_331_21.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos3008ui_story, var_331_25, var_331_24)

				local var_331_26 = manager.ui.mainCamera.transform.position - var_331_21.position

				var_331_21.forward = Vector3.New(var_331_26.x, var_331_26.y, var_331_26.z)

				local var_331_27 = var_331_21.localEulerAngles

				var_331_27.z = 0
				var_331_27.x = 0
				var_331_21.localEulerAngles = var_331_27
			end

			if arg_328_1.time_ >= var_331_22 + var_331_23 and arg_328_1.time_ < var_331_22 + var_331_23 + arg_331_0 then
				var_331_21.localPosition = Vector3.New(0, 100, 0)

				local var_331_28 = manager.ui.mainCamera.transform.position - var_331_21.position

				var_331_21.forward = Vector3.New(var_331_28.x, var_331_28.y, var_331_28.z)

				local var_331_29 = var_331_21.localEulerAngles

				var_331_29.z = 0
				var_331_29.x = 0
				var_331_21.localEulerAngles = var_331_29
			end

			local var_331_30 = 0
			local var_331_31 = 0.8

			if var_331_30 < arg_328_1.time_ and arg_328_1.time_ <= var_331_30 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_32 = arg_328_1:FormatText(StoryNameCfg[35].name)

				arg_328_1.leftNameTxt_.text = var_331_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_33 = arg_328_1:GetWordFromCfg(304081079)
				local var_331_34 = arg_328_1:FormatText(var_331_33.content)

				arg_328_1.text_.text = var_331_34

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_35 = 32
				local var_331_36 = utf8.len(var_331_34)
				local var_331_37 = var_331_35 <= 0 and var_331_31 or var_331_31 * (var_331_36 / var_331_35)

				if var_331_37 > 0 and var_331_31 < var_331_37 then
					arg_328_1.talkMaxDuration = var_331_37

					if var_331_37 + var_331_30 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_37 + var_331_30
					end
				end

				arg_328_1.text_.text = var_331_34
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081079", "story_v_out_304081.awb") ~= 0 then
					local var_331_38 = manager.audio:GetVoiceLength("story_v_out_304081", "304081079", "story_v_out_304081.awb") / 1000

					if var_331_38 + var_331_30 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_38 + var_331_30
					end

					if var_331_33.prefab_name ~= "" and arg_328_1.actors_[var_331_33.prefab_name] ~= nil then
						local var_331_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_33.prefab_name].transform, "story_v_out_304081", "304081079", "story_v_out_304081.awb")

						arg_328_1:RecordAudio("304081079", var_331_39)
						arg_328_1:RecordAudio("304081079", var_331_39)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_304081", "304081079", "story_v_out_304081.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_304081", "304081079", "story_v_out_304081.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_40 = math.max(var_331_31, arg_328_1.talkMaxDuration)

			if var_331_30 <= arg_328_1.time_ and arg_328_1.time_ < var_331_30 + var_331_40 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_30) / var_331_40

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_30 + var_331_40 and arg_328_1.time_ < var_331_30 + var_331_40 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play304081080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 304081080
		arg_332_1.duration_ = 4.83

		local var_332_0 = {
			zh = 4.833,
			ja = 4.7
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play304081081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.625

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[35].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:GetWordFromCfg(304081080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 25
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081080", "story_v_out_304081.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_304081", "304081080", "story_v_out_304081.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_304081", "304081080", "story_v_out_304081.awb")

						arg_332_1:RecordAudio("304081080", var_335_9)
						arg_332_1:RecordAudio("304081080", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_304081", "304081080", "story_v_out_304081.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_304081", "304081080", "story_v_out_304081.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play304081081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 304081081
		arg_336_1.duration_ = 4.1

		local var_336_0 = {
			zh = 3.3,
			ja = 4.1
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play304081082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1019ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1019ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0.7, -1.08, -5.9)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1019ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1019ui_story"]
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1019ui_story == nil then
				arg_336_1.var_.characterEffect1019ui_story = var_339_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.200000002980232

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 and not isNil(var_339_9) then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11

				if arg_336_1.var_.characterEffect1019ui_story and not isNil(var_339_9) then
					arg_336_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1019ui_story then
				arg_336_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_339_13 = arg_336_1.actors_["1013ui_story"]
			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 and not isNil(var_339_13) and arg_336_1.var_.characterEffect1013ui_story == nil then
				arg_336_1.var_.characterEffect1013ui_story = var_339_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_15 = 0.200000002980232

			if var_339_14 <= arg_336_1.time_ and arg_336_1.time_ < var_339_14 + var_339_15 and not isNil(var_339_13) then
				local var_339_16 = (arg_336_1.time_ - var_339_14) / var_339_15

				if arg_336_1.var_.characterEffect1013ui_story and not isNil(var_339_13) then
					local var_339_17 = Mathf.Lerp(0, 0.5, var_339_16)

					arg_336_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1013ui_story.fillRatio = var_339_17
				end
			end

			if arg_336_1.time_ >= var_339_14 + var_339_15 and arg_336_1.time_ < var_339_14 + var_339_15 + arg_339_0 and not isNil(var_339_13) and arg_336_1.var_.characterEffect1013ui_story then
				local var_339_18 = 0.5

				arg_336_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1013ui_story.fillRatio = var_339_18
			end

			local var_339_19 = 0

			if var_339_19 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_339_20 = 0

			if var_339_20 < arg_336_1.time_ and arg_336_1.time_ <= var_339_20 + arg_339_0 then
				arg_336_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_21 = arg_336_1.actors_["3008ui_story"].transform
			local var_339_22 = 0

			if var_339_22 < arg_336_1.time_ and arg_336_1.time_ <= var_339_22 + arg_339_0 then
				arg_336_1.var_.moveOldPos3008ui_story = var_339_21.localPosition
			end

			local var_339_23 = 0.001

			if var_339_22 <= arg_336_1.time_ and arg_336_1.time_ < var_339_22 + var_339_23 then
				local var_339_24 = (arg_336_1.time_ - var_339_22) / var_339_23
				local var_339_25 = Vector3.New(0, 100, 0)

				var_339_21.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos3008ui_story, var_339_25, var_339_24)

				local var_339_26 = manager.ui.mainCamera.transform.position - var_339_21.position

				var_339_21.forward = Vector3.New(var_339_26.x, var_339_26.y, var_339_26.z)

				local var_339_27 = var_339_21.localEulerAngles

				var_339_27.z = 0
				var_339_27.x = 0
				var_339_21.localEulerAngles = var_339_27
			end

			if arg_336_1.time_ >= var_339_22 + var_339_23 and arg_336_1.time_ < var_339_22 + var_339_23 + arg_339_0 then
				var_339_21.localPosition = Vector3.New(0, 100, 0)

				local var_339_28 = manager.ui.mainCamera.transform.position - var_339_21.position

				var_339_21.forward = Vector3.New(var_339_28.x, var_339_28.y, var_339_28.z)

				local var_339_29 = var_339_21.localEulerAngles

				var_339_29.z = 0
				var_339_29.x = 0
				var_339_21.localEulerAngles = var_339_29
			end

			local var_339_30 = arg_336_1.actors_["1013ui_story"].transform
			local var_339_31 = 0

			if var_339_31 < arg_336_1.time_ and arg_336_1.time_ <= var_339_31 + arg_339_0 then
				arg_336_1.var_.moveOldPos1013ui_story = var_339_30.localPosition
			end

			local var_339_32 = 0.001

			if var_339_31 <= arg_336_1.time_ and arg_336_1.time_ < var_339_31 + var_339_32 then
				local var_339_33 = (arg_336_1.time_ - var_339_31) / var_339_32
				local var_339_34 = Vector3.New(-0.7, -0.66, -6.15)

				var_339_30.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1013ui_story, var_339_34, var_339_33)

				local var_339_35 = manager.ui.mainCamera.transform.position - var_339_30.position

				var_339_30.forward = Vector3.New(var_339_35.x, var_339_35.y, var_339_35.z)

				local var_339_36 = var_339_30.localEulerAngles

				var_339_36.z = 0
				var_339_36.x = 0
				var_339_30.localEulerAngles = var_339_36
			end

			if arg_336_1.time_ >= var_339_31 + var_339_32 and arg_336_1.time_ < var_339_31 + var_339_32 + arg_339_0 then
				var_339_30.localPosition = Vector3.New(-0.7, -0.66, -6.15)

				local var_339_37 = manager.ui.mainCamera.transform.position - var_339_30.position

				var_339_30.forward = Vector3.New(var_339_37.x, var_339_37.y, var_339_37.z)

				local var_339_38 = var_339_30.localEulerAngles

				var_339_38.z = 0
				var_339_38.x = 0
				var_339_30.localEulerAngles = var_339_38
			end

			local var_339_39 = 0
			local var_339_40 = 0.4

			if var_339_39 < arg_336_1.time_ and arg_336_1.time_ <= var_339_39 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_41 = arg_336_1:FormatText(StoryNameCfg[13].name)

				arg_336_1.leftNameTxt_.text = var_339_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_42 = arg_336_1:GetWordFromCfg(304081081)
				local var_339_43 = arg_336_1:FormatText(var_339_42.content)

				arg_336_1.text_.text = var_339_43

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_44 = 16
				local var_339_45 = utf8.len(var_339_43)
				local var_339_46 = var_339_44 <= 0 and var_339_40 or var_339_40 * (var_339_45 / var_339_44)

				if var_339_46 > 0 and var_339_40 < var_339_46 then
					arg_336_1.talkMaxDuration = var_339_46

					if var_339_46 + var_339_39 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_46 + var_339_39
					end
				end

				arg_336_1.text_.text = var_339_43
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081081", "story_v_out_304081.awb") ~= 0 then
					local var_339_47 = manager.audio:GetVoiceLength("story_v_out_304081", "304081081", "story_v_out_304081.awb") / 1000

					if var_339_47 + var_339_39 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_47 + var_339_39
					end

					if var_339_42.prefab_name ~= "" and arg_336_1.actors_[var_339_42.prefab_name] ~= nil then
						local var_339_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_42.prefab_name].transform, "story_v_out_304081", "304081081", "story_v_out_304081.awb")

						arg_336_1:RecordAudio("304081081", var_339_48)
						arg_336_1:RecordAudio("304081081", var_339_48)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_304081", "304081081", "story_v_out_304081.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_304081", "304081081", "story_v_out_304081.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_49 = math.max(var_339_40, arg_336_1.talkMaxDuration)

			if var_339_39 <= arg_336_1.time_ and arg_336_1.time_ < var_339_39 + var_339_49 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_39) / var_339_49

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_39 + var_339_49 and arg_336_1.time_ < var_339_39 + var_339_49 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play304081082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 304081082
		arg_340_1.duration_ = 8.23

		local var_340_0 = {
			zh = 4.666,
			ja = 8.233
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play304081083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["3008ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos3008ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(0, -1.51, -4.3)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos3008ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["1013ui_story"].transform
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 then
				arg_340_1.var_.moveOldPos1013ui_story = var_343_9.localPosition
			end

			local var_343_11 = 0.001

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11
				local var_343_13 = Vector3.New(0, 100, 0)

				var_343_9.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1013ui_story, var_343_13, var_343_12)

				local var_343_14 = manager.ui.mainCamera.transform.position - var_343_9.position

				var_343_9.forward = Vector3.New(var_343_14.x, var_343_14.y, var_343_14.z)

				local var_343_15 = var_343_9.localEulerAngles

				var_343_15.z = 0
				var_343_15.x = 0
				var_343_9.localEulerAngles = var_343_15
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 then
				var_343_9.localPosition = Vector3.New(0, 100, 0)

				local var_343_16 = manager.ui.mainCamera.transform.position - var_343_9.position

				var_343_9.forward = Vector3.New(var_343_16.x, var_343_16.y, var_343_16.z)

				local var_343_17 = var_343_9.localEulerAngles

				var_343_17.z = 0
				var_343_17.x = 0
				var_343_9.localEulerAngles = var_343_17
			end

			local var_343_18 = arg_340_1.actors_["1019ui_story"].transform
			local var_343_19 = 0

			if var_343_19 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1.var_.moveOldPos1019ui_story = var_343_18.localPosition
			end

			local var_343_20 = 0.001

			if var_343_19 <= arg_340_1.time_ and arg_340_1.time_ < var_343_19 + var_343_20 then
				local var_343_21 = (arg_340_1.time_ - var_343_19) / var_343_20
				local var_343_22 = Vector3.New(0, 100, 0)

				var_343_18.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1019ui_story, var_343_22, var_343_21)

				local var_343_23 = manager.ui.mainCamera.transform.position - var_343_18.position

				var_343_18.forward = Vector3.New(var_343_23.x, var_343_23.y, var_343_23.z)

				local var_343_24 = var_343_18.localEulerAngles

				var_343_24.z = 0
				var_343_24.x = 0
				var_343_18.localEulerAngles = var_343_24
			end

			if arg_340_1.time_ >= var_343_19 + var_343_20 and arg_340_1.time_ < var_343_19 + var_343_20 + arg_343_0 then
				var_343_18.localPosition = Vector3.New(0, 100, 0)

				local var_343_25 = manager.ui.mainCamera.transform.position - var_343_18.position

				var_343_18.forward = Vector3.New(var_343_25.x, var_343_25.y, var_343_25.z)

				local var_343_26 = var_343_18.localEulerAngles

				var_343_26.z = 0
				var_343_26.x = 0
				var_343_18.localEulerAngles = var_343_26
			end

			local var_343_27 = arg_340_1.actors_["3008ui_story"]
			local var_343_28 = 0

			if var_343_28 < arg_340_1.time_ and arg_340_1.time_ <= var_343_28 + arg_343_0 and not isNil(var_343_27) and arg_340_1.var_.characterEffect3008ui_story == nil then
				arg_340_1.var_.characterEffect3008ui_story = var_343_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_29 = 0.200000002980232

			if var_343_28 <= arg_340_1.time_ and arg_340_1.time_ < var_343_28 + var_343_29 and not isNil(var_343_27) then
				local var_343_30 = (arg_340_1.time_ - var_343_28) / var_343_29

				if arg_340_1.var_.characterEffect3008ui_story and not isNil(var_343_27) then
					arg_340_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_28 + var_343_29 and arg_340_1.time_ < var_343_28 + var_343_29 + arg_343_0 and not isNil(var_343_27) and arg_340_1.var_.characterEffect3008ui_story then
				arg_340_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_343_31 = arg_340_1.actors_["1019ui_story"]
			local var_343_32 = 0

			if var_343_32 < arg_340_1.time_ and arg_340_1.time_ <= var_343_32 + arg_343_0 and not isNil(var_343_31) and arg_340_1.var_.characterEffect1019ui_story == nil then
				arg_340_1.var_.characterEffect1019ui_story = var_343_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_33 = 0.200000002980232

			if var_343_32 <= arg_340_1.time_ and arg_340_1.time_ < var_343_32 + var_343_33 and not isNil(var_343_31) then
				local var_343_34 = (arg_340_1.time_ - var_343_32) / var_343_33

				if arg_340_1.var_.characterEffect1019ui_story and not isNil(var_343_31) then
					local var_343_35 = Mathf.Lerp(0, 0.5, var_343_34)

					arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1019ui_story.fillRatio = var_343_35
				end
			end

			if arg_340_1.time_ >= var_343_32 + var_343_33 and arg_340_1.time_ < var_343_32 + var_343_33 + arg_343_0 and not isNil(var_343_31) and arg_340_1.var_.characterEffect1019ui_story then
				local var_343_36 = 0.5

				arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1019ui_story.fillRatio = var_343_36
			end

			local var_343_37 = 0

			if var_343_37 < arg_340_1.time_ and arg_340_1.time_ <= var_343_37 + arg_343_0 then
				arg_340_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			local var_343_38 = 0

			if var_343_38 < arg_340_1.time_ and arg_340_1.time_ <= var_343_38 + arg_343_0 then
				arg_340_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_343_39 = 0
			local var_343_40 = 0.625

			if var_343_39 < arg_340_1.time_ and arg_340_1.time_ <= var_343_39 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_41 = arg_340_1:FormatText(StoryNameCfg[20].name)

				arg_340_1.leftNameTxt_.text = var_343_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_42 = arg_340_1:GetWordFromCfg(304081082)
				local var_343_43 = arg_340_1:FormatText(var_343_42.content)

				arg_340_1.text_.text = var_343_43

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_44 = 25
				local var_343_45 = utf8.len(var_343_43)
				local var_343_46 = var_343_44 <= 0 and var_343_40 or var_343_40 * (var_343_45 / var_343_44)

				if var_343_46 > 0 and var_343_40 < var_343_46 then
					arg_340_1.talkMaxDuration = var_343_46

					if var_343_46 + var_343_39 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_46 + var_343_39
					end
				end

				arg_340_1.text_.text = var_343_43
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081082", "story_v_out_304081.awb") ~= 0 then
					local var_343_47 = manager.audio:GetVoiceLength("story_v_out_304081", "304081082", "story_v_out_304081.awb") / 1000

					if var_343_47 + var_343_39 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_47 + var_343_39
					end

					if var_343_42.prefab_name ~= "" and arg_340_1.actors_[var_343_42.prefab_name] ~= nil then
						local var_343_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_42.prefab_name].transform, "story_v_out_304081", "304081082", "story_v_out_304081.awb")

						arg_340_1:RecordAudio("304081082", var_343_48)
						arg_340_1:RecordAudio("304081082", var_343_48)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_304081", "304081082", "story_v_out_304081.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_304081", "304081082", "story_v_out_304081.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_49 = math.max(var_343_40, arg_340_1.talkMaxDuration)

			if var_343_39 <= arg_340_1.time_ and arg_340_1.time_ < var_343_39 + var_343_49 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_39) / var_343_49

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_39 + var_343_49 and arg_340_1.time_ < var_343_39 + var_343_49 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play304081083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 304081083
		arg_344_1.duration_ = 4

		local var_344_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
			arg_344_1.auto_ = false
		end

		function arg_344_1.playNext_(arg_346_0)
			arg_344_1.onStoryFinished_()
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_347_1 = 0
			local var_347_2 = 0.425

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_3 = arg_344_1:FormatText(StoryNameCfg[20].name)

				arg_344_1.leftNameTxt_.text = var_347_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(304081083)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_6 = 17
				local var_347_7 = utf8.len(var_347_5)
				local var_347_8 = var_347_6 <= 0 and var_347_2 or var_347_2 * (var_347_7 / var_347_6)

				if var_347_8 > 0 and var_347_2 < var_347_8 then
					arg_344_1.talkMaxDuration = var_347_8

					if var_347_8 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304081", "304081083", "story_v_out_304081.awb") ~= 0 then
					local var_347_9 = manager.audio:GetVoiceLength("story_v_out_304081", "304081083", "story_v_out_304081.awb") / 1000

					if var_347_9 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_9 + var_347_1
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_out_304081", "304081083", "story_v_out_304081.awb")

						arg_344_1:RecordAudio("304081083", var_347_10)
						arg_344_1:RecordAudio("304081083", var_347_10)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_304081", "304081083", "story_v_out_304081.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_304081", "304081083", "story_v_out_304081.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_11 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_11 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_11

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_11 and arg_344_1.time_ < var_347_1 + var_347_11 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03b",
		"TextureConfig/Background/S0102",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B02f"
	},
	voices = {
		"story_v_out_304081.awb"
	}
}
