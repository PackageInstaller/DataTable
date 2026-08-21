return {
	Play116431001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116431001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			zh = 5.933,
			ja = 8.133
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
				arg_1_0:Play116431002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I02"

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
				local var_4_5 = arg_1_1.bgs_.I02

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
					if iter_4_0 ~= "I02" then
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
			local var_4_23 = 0.666666666666667

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

			local var_4_28 = 0.866666666666667
			local var_4_29 = 1.13333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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
			local var_4_35 = 0.375

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[348].name)

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

				local var_4_38 = arg_1_1:GetWordFromCfg(116431001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431001", "story_v_out_116431.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_116431", "116431001", "story_v_out_116431.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_116431", "116431001", "story_v_out_116431.awb")

						arg_1_1:RecordAudio("116431001", var_4_44)
						arg_1_1:RecordAudio("116431001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116431", "116431001", "story_v_out_116431.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116431", "116431001", "story_v_out_116431.awb")
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
	Play116431002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116431002
		arg_9_1.duration_ = 7.57

		local var_9_0 = {
			zh = 4.8,
			ja = 7.566
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
				arg_9_0:Play116431003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.475

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[52].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(116431002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431002", "story_v_out_116431.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431002", "story_v_out_116431.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_116431", "116431002", "story_v_out_116431.awb")

						arg_9_1:RecordAudio("116431002", var_12_9)
						arg_9_1:RecordAudio("116431002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116431", "116431002", "story_v_out_116431.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116431", "116431002", "story_v_out_116431.awb")
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
	Play116431003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116431003
		arg_13_1.duration_ = 0.02

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"

			SetActive(arg_13_1.choicesGo_, true)

			for iter_14_0, iter_14_1 in ipairs(arg_13_1.choices_) do
				local var_14_0 = iter_14_0 <= 1

				SetActive(iter_14_1.go, var_14_0)
			end

			arg_13_1.choices_[1].txt.text = arg_13_1:FormatText(StoryChoiceCfg[273].name)
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116431004(arg_13_1)
			end

			arg_13_1:RecordChoiceLog(116431003, 273)
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			return
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116431004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116431004
		arg_17_1.duration_ = 11.9

		local var_17_0 = {
			zh = 8.833,
			ja = 11.9
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116431005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.975

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[52].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(116431004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 39
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431004", "story_v_out_116431.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431004", "story_v_out_116431.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_116431", "116431004", "story_v_out_116431.awb")

						arg_17_1:RecordAudio("116431004", var_20_9)
						arg_17_1:RecordAudio("116431004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116431", "116431004", "story_v_out_116431.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116431", "116431004", "story_v_out_116431.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116431005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116431005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116431006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.275

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(116431005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 11
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
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play116431006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116431006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116431007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.375

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(116431006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 15
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116431007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116431007
		arg_29_1.duration_ = 12.97

		local var_29_0 = {
			zh = 8.6,
			ja = 12.966
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
				arg_29_0:Play116431008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.9

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[52].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(116431007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431007", "story_v_out_116431.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431007", "story_v_out_116431.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_116431", "116431007", "story_v_out_116431.awb")

						arg_29_1:RecordAudio("116431007", var_32_9)
						arg_29_1:RecordAudio("116431007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116431", "116431007", "story_v_out_116431.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116431", "116431007", "story_v_out_116431.awb")
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
	Play116431008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116431008
		arg_33_1.duration_ = 9.9

		local var_33_0 = {
			zh = 8.633,
			ja = 9.9
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
				arg_33_0:Play116431009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.825

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[52].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(116431008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431008", "story_v_out_116431.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431008", "story_v_out_116431.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_116431", "116431008", "story_v_out_116431.awb")

						arg_33_1:RecordAudio("116431008", var_36_9)
						arg_33_1:RecordAudio("116431008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116431", "116431008", "story_v_out_116431.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116431", "116431008", "story_v_out_116431.awb")
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
	Play116431009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116431009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116431010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.2

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(116431009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 8
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116431010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116431010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116431011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.5

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

				local var_44_2 = arg_41_1:GetWordFromCfg(116431010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 20
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
	Play116431011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116431011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116431012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.225

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(116431011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 9
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116431012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116431012
		arg_49_1.duration_ = 7.6

		local var_49_0 = {
			zh = 6.533,
			ja = 7.6
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
				arg_49_0:Play116431013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "1028ui_story"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_49_1.stage_.transform)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentInChildren(typeof(CharacterEffect))

					var_52_3.enabled = true

					local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_2, typeof(DynamicBoneHelper))

					if var_52_4 then
						var_52_4:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_3.transform, false)

					arg_49_1.var_[var_52_0 .. "Animator"] = var_52_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_0 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_0 .. "LipSync"] = var_52_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_5 = arg_49_1.actors_["1028ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos1028ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(0, -0.9, -5.9)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1028ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = arg_49_1.actors_["1028ui_story"]
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1028ui_story == nil then
				arg_49_1.var_.characterEffect1028ui_story = var_52_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_16 = 0.2

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 and not isNil(var_52_14) then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16

				if arg_49_1.var_.characterEffect1028ui_story and not isNil(var_52_14) then
					arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.characterEffect1028ui_story then
				arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_52_18 = 0

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_52_19 = 0

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_52_20 = 0
			local var_52_21 = 0.675

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_22 = arg_49_1:FormatText(StoryNameCfg[327].name)

				arg_49_1.leftNameTxt_.text = var_52_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_23 = arg_49_1:GetWordFromCfg(116431012)
				local var_52_24 = arg_49_1:FormatText(var_52_23.content)

				arg_49_1.text_.text = var_52_24

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_25 = 27
				local var_52_26 = utf8.len(var_52_24)
				local var_52_27 = var_52_25 <= 0 and var_52_21 or var_52_21 * (var_52_26 / var_52_25)

				if var_52_27 > 0 and var_52_21 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27

					if var_52_27 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_20
					end
				end

				arg_49_1.text_.text = var_52_24
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431012", "story_v_out_116431.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_116431", "116431012", "story_v_out_116431.awb") / 1000

					if var_52_28 + var_52_20 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_20
					end

					if var_52_23.prefab_name ~= "" and arg_49_1.actors_[var_52_23.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_23.prefab_name].transform, "story_v_out_116431", "116431012", "story_v_out_116431.awb")

						arg_49_1:RecordAudio("116431012", var_52_29)
						arg_49_1:RecordAudio("116431012", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116431", "116431012", "story_v_out_116431.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116431", "116431012", "story_v_out_116431.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = math.max(var_52_21, arg_49_1.talkMaxDuration)

			if var_52_20 <= arg_49_1.time_ and arg_49_1.time_ < var_52_20 + var_52_30 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_20) / var_52_30

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_20 + var_52_30 and arg_49_1.time_ < var_52_20 + var_52_30 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play116431013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116431013
		arg_53_1.duration_ = 7.5

		local var_53_0 = {
			zh = 4.133,
			ja = 7.5
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
				arg_53_0:Play116431014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1028ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1028ui_story == nil then
				arg_53_1.var_.characterEffect1028ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1028ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1028ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1028ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1028ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.475

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(116431013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 19
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431013", "story_v_out_116431.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_116431", "116431013", "story_v_out_116431.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_116431", "116431013", "story_v_out_116431.awb")

						arg_53_1:RecordAudio("116431013", var_56_15)
						arg_53_1:RecordAudio("116431013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116431", "116431013", "story_v_out_116431.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116431", "116431013", "story_v_out_116431.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116431014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116431014
		arg_57_1.duration_ = 8.47

		local var_57_0 = {
			zh = 8.466,
			ja = 7.833
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
				arg_57_0:Play116431015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1028ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1028ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, -0.9, -5.9)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1028ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1028ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1028ui_story == nil then
				arg_57_1.var_.characterEffect1028ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.2

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1028ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1028ui_story then
				arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action473")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_15 = 0
			local var_60_16 = 1.05

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[327].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(116431014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 42
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431014", "story_v_out_116431.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431014", "story_v_out_116431.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_116431", "116431014", "story_v_out_116431.awb")

						arg_57_1:RecordAudio("116431014", var_60_24)
						arg_57_1:RecordAudio("116431014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116431", "116431014", "story_v_out_116431.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116431", "116431014", "story_v_out_116431.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play116431015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116431015
		arg_61_1.duration_ = 5.77

		local var_61_0 = {
			zh = 4.766,
			ja = 5.766
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
				arg_61_0:Play116431016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1028ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1028ui_story == nil then
				arg_61_1.var_.characterEffect1028ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1028ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1028ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1028ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1028ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.475

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[28].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(116431015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 19
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431015", "story_v_out_116431.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_116431", "116431015", "story_v_out_116431.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_116431", "116431015", "story_v_out_116431.awb")

						arg_61_1:RecordAudio("116431015", var_64_15)
						arg_61_1:RecordAudio("116431015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116431", "116431015", "story_v_out_116431.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116431", "116431015", "story_v_out_116431.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play116431016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116431016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116431017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1028ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1028ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1028ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = 0
			local var_68_10 = 0.275

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_11 = arg_65_1:GetWordFromCfg(116431016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 11
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_10 or var_68_10 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_10 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_9 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_9
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_10, arg_65_1.talkMaxDuration)

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_9) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_9 + var_68_16 and arg_65_1.time_ < var_68_9 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play116431017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116431017
		arg_69_1.duration_ = 3.6

		local var_69_0 = {
			zh = 2.2,
			ja = 3.6
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
				arg_69_0:Play116431018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "1029ui_story"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_69_1.stage_.transform)

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

			local var_72_5 = arg_69_1.actors_["1029ui_story"].transform
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.var_.moveOldPos1029ui_story = var_72_5.localPosition
			end

			local var_72_7 = 0.001

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7
				local var_72_9 = Vector3.New(0, -1.09, -6.2)

				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1029ui_story, var_72_9, var_72_8)

				local var_72_10 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_10.x, var_72_10.y, var_72_10.z)

				local var_72_11 = var_72_5.localEulerAngles

				var_72_11.z = 0
				var_72_11.x = 0
				var_72_5.localEulerAngles = var_72_11
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_5.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_5.localEulerAngles = var_72_13
			end

			local var_72_14 = arg_69_1.actors_["1029ui_story"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_16 = 0.2

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.characterEffect1029ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1029ui_story then
				arg_69_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_72_20 = 0
			local var_72_21 = 0.225

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_22 = arg_69_1:FormatText(StoryNameCfg[319].name)

				arg_69_1.leftNameTxt_.text = var_72_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_23 = arg_69_1:GetWordFromCfg(116431017)
				local var_72_24 = arg_69_1:FormatText(var_72_23.content)

				arg_69_1.text_.text = var_72_24

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_25 = 9
				local var_72_26 = utf8.len(var_72_24)
				local var_72_27 = var_72_25 <= 0 and var_72_21 or var_72_21 * (var_72_26 / var_72_25)

				if var_72_27 > 0 and var_72_21 < var_72_27 then
					arg_69_1.talkMaxDuration = var_72_27

					if var_72_27 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_20
					end
				end

				arg_69_1.text_.text = var_72_24
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431017", "story_v_out_116431.awb") ~= 0 then
					local var_72_28 = manager.audio:GetVoiceLength("story_v_out_116431", "116431017", "story_v_out_116431.awb") / 1000

					if var_72_28 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_20
					end

					if var_72_23.prefab_name ~= "" and arg_69_1.actors_[var_72_23.prefab_name] ~= nil then
						local var_72_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_23.prefab_name].transform, "story_v_out_116431", "116431017", "story_v_out_116431.awb")

						arg_69_1:RecordAudio("116431017", var_72_29)
						arg_69_1:RecordAudio("116431017", var_72_29)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116431", "116431017", "story_v_out_116431.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116431", "116431017", "story_v_out_116431.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_30 = math.max(var_72_21, arg_69_1.talkMaxDuration)

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_30 and arg_69_1.time_ < var_72_20 + var_72_30 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play116431018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116431018
		arg_73_1.duration_ = 0.02

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"

			SetActive(arg_73_1.choicesGo_, true)

			for iter_74_0, iter_74_1 in ipairs(arg_73_1.choices_) do
				local var_74_0 = iter_74_0 <= 1

				SetActive(iter_74_1.go, var_74_0)
			end

			arg_73_1.choices_[1].txt.text = arg_73_1:FormatText(StoryChoiceCfg[274].name)
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play116431019(arg_73_1)
			end

			arg_73_1:RecordChoiceLog(116431018, 274)
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			return
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116431019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116431019
		arg_77_1.duration_ = 3.83

		local var_77_0 = {
			zh = 3.833,
			ja = 3.533
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
				arg_77_0:Play116431020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1029ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1029ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, -1.09, -6.2)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1029ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_80_11 = 0
			local var_80_12 = 0.475

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_13 = arg_77_1:FormatText(StoryNameCfg[319].name)

				arg_77_1.leftNameTxt_.text = var_80_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(116431019)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 19
				local var_80_17 = utf8.len(var_80_15)
				local var_80_18 = var_80_16 <= 0 and var_80_12 or var_80_12 * (var_80_17 / var_80_16)

				if var_80_18 > 0 and var_80_12 < var_80_18 then
					arg_77_1.talkMaxDuration = var_80_18

					if var_80_18 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431019", "story_v_out_116431.awb") ~= 0 then
					local var_80_19 = manager.audio:GetVoiceLength("story_v_out_116431", "116431019", "story_v_out_116431.awb") / 1000

					if var_80_19 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_11
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_116431", "116431019", "story_v_out_116431.awb")

						arg_77_1:RecordAudio("116431019", var_80_20)
						arg_77_1:RecordAudio("116431019", var_80_20)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_116431", "116431019", "story_v_out_116431.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_116431", "116431019", "story_v_out_116431.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_21 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_21 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_21

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_21 and arg_77_1.time_ < var_80_11 + var_80_21 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play116431020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116431020
		arg_81_1.duration_ = 8

		local var_81_0 = {
			zh = 6.066,
			ja = 8
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
				arg_81_0:Play116431021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1029ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1029ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -1.09, -6.2)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1029ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_84_11 = 0
			local var_84_12 = 0.675

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[319].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(116431020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 27
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431020", "story_v_out_116431.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_116431", "116431020", "story_v_out_116431.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_116431", "116431020", "story_v_out_116431.awb")

						arg_81_1:RecordAudio("116431020", var_84_20)
						arg_81_1:RecordAudio("116431020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116431", "116431020", "story_v_out_116431.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116431", "116431020", "story_v_out_116431.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play116431021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116431021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116431022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1029ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1029ui_story == nil then
				arg_85_1.var_.characterEffect1029ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1029ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1029ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.125

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(116431021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 5
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116431022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116431022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play116431023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.7

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(116431022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 28
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play116431023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116431023
		arg_93_1.duration_ = 6.97

		local var_93_0 = {
			zh = 6.633,
			ja = 6.966
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
				arg_93_0:Play116431024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1029ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1029ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.09, -6.2)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1029ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1029ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1029ui_story == nil then
				arg_93_1.var_.characterEffect1029ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.2

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1029ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1029ui_story then
				arg_93_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_96_14 = 0
			local var_96_15 = 0.625

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_16 = arg_93_1:FormatText(StoryNameCfg[319].name)

				arg_93_1.leftNameTxt_.text = var_96_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(116431023)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 25
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_15 or var_96_15 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_15 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_14
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431023", "story_v_out_116431.awb") ~= 0 then
					local var_96_22 = manager.audio:GetVoiceLength("story_v_out_116431", "116431023", "story_v_out_116431.awb") / 1000

					if var_96_22 + var_96_14 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_14
					end

					if var_96_17.prefab_name ~= "" and arg_93_1.actors_[var_96_17.prefab_name] ~= nil then
						local var_96_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_17.prefab_name].transform, "story_v_out_116431", "116431023", "story_v_out_116431.awb")

						arg_93_1:RecordAudio("116431023", var_96_23)
						arg_93_1:RecordAudio("116431023", var_96_23)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116431", "116431023", "story_v_out_116431.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116431", "116431023", "story_v_out_116431.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_24 = math.max(var_96_15, arg_93_1.talkMaxDuration)

			if var_96_14 <= arg_93_1.time_ and arg_93_1.time_ < var_96_14 + var_96_24 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_14) / var_96_24

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_14 + var_96_24 and arg_93_1.time_ < var_96_14 + var_96_24 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play116431024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116431024
		arg_97_1.duration_ = 9.47

		local var_97_0 = {
			zh = 8.5,
			ja = 9.466
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
				arg_97_0:Play116431025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1029ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1029ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1.09, -6.2)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1029ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1029ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1029ui_story == nil then
				arg_97_1.var_.characterEffect1029ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.2

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1029ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1029ui_story then
				arg_97_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_100_14 = 0
			local var_100_15 = 1.075

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_16 = arg_97_1:FormatText(StoryNameCfg[319].name)

				arg_97_1.leftNameTxt_.text = var_100_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_17 = arg_97_1:GetWordFromCfg(116431024)
				local var_100_18 = arg_97_1:FormatText(var_100_17.content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_19 = 43
				local var_100_20 = utf8.len(var_100_18)
				local var_100_21 = var_100_19 <= 0 and var_100_15 or var_100_15 * (var_100_20 / var_100_19)

				if var_100_21 > 0 and var_100_15 < var_100_21 then
					arg_97_1.talkMaxDuration = var_100_21

					if var_100_21 + var_100_14 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_21 + var_100_14
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431024", "story_v_out_116431.awb") ~= 0 then
					local var_100_22 = manager.audio:GetVoiceLength("story_v_out_116431", "116431024", "story_v_out_116431.awb") / 1000

					if var_100_22 + var_100_14 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_14
					end

					if var_100_17.prefab_name ~= "" and arg_97_1.actors_[var_100_17.prefab_name] ~= nil then
						local var_100_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_17.prefab_name].transform, "story_v_out_116431", "116431024", "story_v_out_116431.awb")

						arg_97_1:RecordAudio("116431024", var_100_23)
						arg_97_1:RecordAudio("116431024", var_100_23)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116431", "116431024", "story_v_out_116431.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116431", "116431024", "story_v_out_116431.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_24 = math.max(var_100_15, arg_97_1.talkMaxDuration)

			if var_100_14 <= arg_97_1.time_ and arg_97_1.time_ < var_100_14 + var_100_24 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_14) / var_100_24

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_14 + var_100_24 and arg_97_1.time_ < var_100_14 + var_100_24 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play116431025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116431025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play116431026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1029ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1029ui_story == nil then
				arg_101_1.var_.characterEffect1029ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1029ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1029ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1029ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1029ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.075

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(116431025)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 3
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116431026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116431026
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116431027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1029ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1029ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -1.09, -6.2)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1029ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["1029ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1029ui_story == nil then
				arg_105_1.var_.characterEffect1029ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.2

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect1029ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1029ui_story then
				arg_105_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_108_15 = 0
			local var_108_16 = 0.25

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[319].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(116431026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 10
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431026", "story_v_out_116431.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431026", "story_v_out_116431.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_116431", "116431026", "story_v_out_116431.awb")

						arg_105_1:RecordAudio("116431026", var_108_24)
						arg_105_1:RecordAudio("116431026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116431", "116431026", "story_v_out_116431.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116431", "116431026", "story_v_out_116431.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play116431027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116431027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116431028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1029ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1029ui_story == nil then
				arg_109_1.var_.characterEffect1029ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1029ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1029ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1029ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1029ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.85

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(116431027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 34
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116431028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116431028
		arg_113_1.duration_ = 7.07

		local var_113_0 = {
			zh = 5.2,
			ja = 7.066
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
				arg_113_0:Play116431029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1029ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1029ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -1.09, -6.2)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1029ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1029ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1029ui_story == nil then
				arg_113_1.var_.characterEffect1029ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.2

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1029ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1029ui_story then
				arg_113_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_116_14 = 0
			local var_116_15 = 0.525

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_16 = arg_113_1:FormatText(StoryNameCfg[319].name)

				arg_113_1.leftNameTxt_.text = var_116_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:GetWordFromCfg(116431028)
				local var_116_18 = arg_113_1:FormatText(var_116_17.content)

				arg_113_1.text_.text = var_116_18

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 21
				local var_116_20 = utf8.len(var_116_18)
				local var_116_21 = var_116_19 <= 0 and var_116_15 or var_116_15 * (var_116_20 / var_116_19)

				if var_116_21 > 0 and var_116_15 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21

					if var_116_21 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_18
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431028", "story_v_out_116431.awb") ~= 0 then
					local var_116_22 = manager.audio:GetVoiceLength("story_v_out_116431", "116431028", "story_v_out_116431.awb") / 1000

					if var_116_22 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_14
					end

					if var_116_17.prefab_name ~= "" and arg_113_1.actors_[var_116_17.prefab_name] ~= nil then
						local var_116_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_17.prefab_name].transform, "story_v_out_116431", "116431028", "story_v_out_116431.awb")

						arg_113_1:RecordAudio("116431028", var_116_23)
						arg_113_1:RecordAudio("116431028", var_116_23)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_116431", "116431028", "story_v_out_116431.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_116431", "116431028", "story_v_out_116431.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_24 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_24

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_24 and arg_113_1.time_ < var_116_14 + var_116_24 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play116431029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116431029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116431030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1029ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1029ui_story == nil then
				arg_117_1.var_.characterEffect1029ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1029ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1029ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1029ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1029ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.425

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(116431029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 17
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116431030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116431030
		arg_121_1.duration_ = 2.97

		local var_121_0 = {
			zh = 2.966,
			ja = 2.6
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
				arg_121_0:Play116431031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1029ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1029ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1.09, -6.2)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1029ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1029ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1029ui_story == nil then
				arg_121_1.var_.characterEffect1029ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.2

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1029ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1029ui_story then
				arg_121_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_124_15 = 0
			local var_124_16 = 0.25

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[319].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(116431030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 10
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431030", "story_v_out_116431.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431030", "story_v_out_116431.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_116431", "116431030", "story_v_out_116431.awb")

						arg_121_1:RecordAudio("116431030", var_124_24)
						arg_121_1:RecordAudio("116431030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116431", "116431030", "story_v_out_116431.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116431", "116431030", "story_v_out_116431.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play116431031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116431031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play116431032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1029ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1029ui_story == nil then
				arg_125_1.var_.characterEffect1029ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1029ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1029ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1029ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1029ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.675

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(116431031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 27
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play116431032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116431032
		arg_129_1.duration_ = 7.13

		local var_129_0 = {
			zh = 5.5,
			ja = 7.133
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
				arg_129_0:Play116431033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "ST02"

			if arg_129_1.bgs_[var_132_0] == nil then
				local var_132_1 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_0)
				var_132_1.name = var_132_0
				var_132_1.transform.parent = arg_129_1.stage_.transform
				var_132_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_0] = var_132_1
			end

			local var_132_2 = 2

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				local var_132_3 = manager.ui.mainCamera.transform.localPosition
				local var_132_4 = Vector3.New(0, 0, 10) + Vector3.New(var_132_3.x, var_132_3.y, 0)
				local var_132_5 = arg_129_1.bgs_.ST02

				var_132_5.transform.localPosition = var_132_4
				var_132_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_6 = var_132_5:GetComponent("SpriteRenderer")

				if var_132_6 and var_132_6.sprite then
					local var_132_7 = (var_132_5.transform.localPosition - var_132_3).z
					local var_132_8 = manager.ui.mainCameraCom_
					local var_132_9 = 2 * var_132_7 * Mathf.Tan(var_132_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_132_10 = var_132_9 * var_132_8.aspect
					local var_132_11 = var_132_6.sprite.bounds.size.x
					local var_132_12 = var_132_6.sprite.bounds.size.y
					local var_132_13 = var_132_10 / var_132_11
					local var_132_14 = var_132_9 / var_132_12
					local var_132_15 = var_132_14 < var_132_13 and var_132_13 or var_132_14

					var_132_5.transform.localScale = Vector3.New(var_132_15, var_132_15, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "ST02" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_17 = 2

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17
				local var_132_19 = Color.New(0, 0, 0)

				var_132_19.a = Mathf.Lerp(0, 1, var_132_18)
				arg_129_1.mask_.color = var_132_19
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				local var_132_20 = Color.New(0, 0, 0)

				var_132_20.a = 1
				arg_129_1.mask_.color = var_132_20
			end

			local var_132_21 = 2

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_22 = 2

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_22 then
				local var_132_23 = (arg_129_1.time_ - var_132_21) / var_132_22
				local var_132_24 = Color.New(0, 0, 0)

				var_132_24.a = Mathf.Lerp(1, 0, var_132_23)
				arg_129_1.mask_.color = var_132_24
			end

			if arg_129_1.time_ >= var_132_21 + var_132_22 and arg_129_1.time_ < var_132_21 + var_132_22 + arg_132_0 then
				local var_132_25 = Color.New(0, 0, 0)
				local var_132_26 = 0

				arg_129_1.mask_.enabled = false
				var_132_25.a = var_132_26
				arg_129_1.mask_.color = var_132_25
			end

			local var_132_27 = arg_129_1.actors_["1029ui_story"].transform
			local var_132_28 = 2

			if var_132_28 < arg_129_1.time_ and arg_129_1.time_ <= var_132_28 + arg_132_0 then
				arg_129_1.var_.moveOldPos1029ui_story = var_132_27.localPosition
			end

			local var_132_29 = 0.001

			if var_132_28 <= arg_129_1.time_ and arg_129_1.time_ < var_132_28 + var_132_29 then
				local var_132_30 = (arg_129_1.time_ - var_132_28) / var_132_29
				local var_132_31 = Vector3.New(0, 100, 0)

				var_132_27.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1029ui_story, var_132_31, var_132_30)

				local var_132_32 = manager.ui.mainCamera.transform.position - var_132_27.position

				var_132_27.forward = Vector3.New(var_132_32.x, var_132_32.y, var_132_32.z)

				local var_132_33 = var_132_27.localEulerAngles

				var_132_33.z = 0
				var_132_33.x = 0
				var_132_27.localEulerAngles = var_132_33
			end

			if arg_129_1.time_ >= var_132_28 + var_132_29 and arg_129_1.time_ < var_132_28 + var_132_29 + arg_132_0 then
				var_132_27.localPosition = Vector3.New(0, 100, 0)

				local var_132_34 = manager.ui.mainCamera.transform.position - var_132_27.position

				var_132_27.forward = Vector3.New(var_132_34.x, var_132_34.y, var_132_34.z)

				local var_132_35 = var_132_27.localEulerAngles

				var_132_35.z = 0
				var_132_35.x = 0
				var_132_27.localEulerAngles = var_132_35
			end

			local var_132_36 = 0
			local var_132_37 = 0.666666666666667

			if var_132_36 < arg_129_1.time_ and arg_129_1.time_ <= var_132_36 + arg_132_0 then
				local var_132_38 = "play"
				local var_132_39 = "music"

				arg_129_1:AudioAction(var_132_38, var_132_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_132_40 = ""
				local var_132_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_132_41 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_41 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_41

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_41
						arg_129_1.bgmTxt2_.text = var_132_41
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

			local var_132_42 = 0.866666666666667
			local var_132_43 = 1.13333333333333

			if var_132_42 < arg_129_1.time_ and arg_129_1.time_ <= var_132_42 + arg_132_0 then
				local var_132_44 = "play"
				local var_132_45 = "music"

				arg_129_1:AudioAction(var_132_44, var_132_45, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_132_46 = ""
				local var_132_47 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_132_47 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_47 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_47

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_47
						arg_129_1.bgmTxt2_.text = var_132_47
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

			local var_132_48 = 0

			if var_132_48 < arg_129_1.time_ and arg_129_1.time_ <= var_132_48 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_49 = 4.225

			if arg_129_1.time_ >= var_132_48 + var_132_49 and arg_129_1.time_ < var_132_48 + var_132_49 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_50 = 4
			local var_132_51 = 0.225

			if var_132_50 < arg_129_1.time_ and arg_129_1.time_ <= var_132_50 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_52 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_52:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_129_1.dialogCg_.alpha = arg_135_0
				end))
				var_132_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_53 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_54 = arg_129_1:GetWordFromCfg(116431032)
				local var_132_55 = arg_129_1:FormatText(var_132_54.content)

				arg_129_1.text_.text = var_132_55

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_56 = 9
				local var_132_57 = utf8.len(var_132_55)
				local var_132_58 = var_132_56 <= 0 and var_132_51 or var_132_51 * (var_132_57 / var_132_56)

				if var_132_58 > 0 and var_132_51 < var_132_58 then
					arg_129_1.talkMaxDuration = var_132_58
					var_132_50 = var_132_50 + 0.3

					if var_132_58 + var_132_50 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_58 + var_132_50
					end
				end

				arg_129_1.text_.text = var_132_55
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431032", "story_v_out_116431.awb") ~= 0 then
					local var_132_59 = manager.audio:GetVoiceLength("story_v_out_116431", "116431032", "story_v_out_116431.awb") / 1000

					if var_132_59 + var_132_50 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_59 + var_132_50
					end

					if var_132_54.prefab_name ~= "" and arg_129_1.actors_[var_132_54.prefab_name] ~= nil then
						local var_132_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_54.prefab_name].transform, "story_v_out_116431", "116431032", "story_v_out_116431.awb")

						arg_129_1:RecordAudio("116431032", var_132_60)
						arg_129_1:RecordAudio("116431032", var_132_60)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_116431", "116431032", "story_v_out_116431.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_116431", "116431032", "story_v_out_116431.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_61 = var_132_50 + 0.3
			local var_132_62 = math.max(var_132_51, arg_129_1.talkMaxDuration)

			if var_132_61 <= arg_129_1.time_ and arg_129_1.time_ < var_132_61 + var_132_62 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_61) / var_132_62

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_61 + var_132_62 and arg_129_1.time_ < var_132_61 + var_132_62 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play116431033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116431033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116431034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 1.025

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(116431033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 41
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116431034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116431034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116431035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.3

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(116431034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 52
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116431035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116431035
		arg_145_1.duration_ = 9.83

		local var_145_0 = {
			zh = 5.1,
			ja = 9.833
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
				arg_145_0:Play116431036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "1084ui_story"

			if arg_145_1.actors_[var_148_0] == nil then
				local var_148_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_148_1) then
					local var_148_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_145_1.stage_.transform)

					var_148_2.name = var_148_0
					var_148_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_0] = var_148_2

					local var_148_3 = var_148_2:GetComponentInChildren(typeof(CharacterEffect))

					var_148_3.enabled = true

					local var_148_4 = GameObjectTools.GetOrAddComponent(var_148_2, typeof(DynamicBoneHelper))

					if var_148_4 then
						var_148_4:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_3.transform, false)

					arg_145_1.var_[var_148_0 .. "Animator"] = var_148_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_0 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_0 .. "LipSync"] = var_148_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_5 = arg_145_1.actors_["1084ui_story"]
			local var_148_6 = 0

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_7 = 0.2

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_7 and not isNil(var_148_5) then
				local var_148_8 = (arg_145_1.time_ - var_148_6) / var_148_7

				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_6 + var_148_7 and arg_145_1.time_ < var_148_6 + var_148_7 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_148_9 = "1011ui_story"

			if arg_145_1.actors_[var_148_9] == nil then
				local var_148_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_148_10) then
					local var_148_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_145_1.stage_.transform)

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

			local var_148_14 = arg_145_1.actors_["1011ui_story"]
			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_16 = 0.0166666666666667

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_16 and not isNil(var_148_14) then
				local var_148_17 = (arg_145_1.time_ - var_148_15) / var_148_16

				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_14) then
					local var_148_18 = Mathf.Lerp(0, 0.5, var_148_17)

					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_18
				end
			end

			if arg_145_1.time_ >= var_148_15 + var_148_16 and arg_145_1.time_ < var_148_15 + var_148_16 + arg_148_0 and not isNil(var_148_14) and arg_145_1.var_.characterEffect1011ui_story then
				local var_148_19 = 0.5

				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_19
			end

			local var_148_20 = 0

			if var_148_20 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_148_21 = 0

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				arg_145_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_148_22 = arg_145_1.actors_["1011ui_story"].transform
			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.var_.moveOldPos1011ui_story = var_148_22.localPosition
			end

			local var_148_24 = 0.001

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24
				local var_148_26 = Vector3.New(0.7, -0.71, -6)

				var_148_22.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1011ui_story, var_148_26, var_148_25)

				local var_148_27 = manager.ui.mainCamera.transform.position - var_148_22.position

				var_148_22.forward = Vector3.New(var_148_27.x, var_148_27.y, var_148_27.z)

				local var_148_28 = var_148_22.localEulerAngles

				var_148_28.z = 0
				var_148_28.x = 0
				var_148_22.localEulerAngles = var_148_28
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 then
				var_148_22.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_148_29 = manager.ui.mainCamera.transform.position - var_148_22.position

				var_148_22.forward = Vector3.New(var_148_29.x, var_148_29.y, var_148_29.z)

				local var_148_30 = var_148_22.localEulerAngles

				var_148_30.z = 0
				var_148_30.x = 0
				var_148_22.localEulerAngles = var_148_30
			end

			local var_148_31 = arg_145_1.actors_["1084ui_story"].transform
			local var_148_32 = 0

			if var_148_32 < arg_145_1.time_ and arg_145_1.time_ <= var_148_32 + arg_148_0 then
				arg_145_1.var_.moveOldPos1084ui_story = var_148_31.localPosition
			end

			local var_148_33 = 0.001

			if var_148_32 <= arg_145_1.time_ and arg_145_1.time_ < var_148_32 + var_148_33 then
				local var_148_34 = (arg_145_1.time_ - var_148_32) / var_148_33
				local var_148_35 = Vector3.New(-0.7, -0.97, -6)

				var_148_31.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1084ui_story, var_148_35, var_148_34)

				local var_148_36 = manager.ui.mainCamera.transform.position - var_148_31.position

				var_148_31.forward = Vector3.New(var_148_36.x, var_148_36.y, var_148_36.z)

				local var_148_37 = var_148_31.localEulerAngles

				var_148_37.z = 0
				var_148_37.x = 0
				var_148_31.localEulerAngles = var_148_37
			end

			if arg_145_1.time_ >= var_148_32 + var_148_33 and arg_145_1.time_ < var_148_32 + var_148_33 + arg_148_0 then
				var_148_31.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_148_38 = manager.ui.mainCamera.transform.position - var_148_31.position

				var_148_31.forward = Vector3.New(var_148_38.x, var_148_38.y, var_148_38.z)

				local var_148_39 = var_148_31.localEulerAngles

				var_148_39.z = 0
				var_148_39.x = 0
				var_148_31.localEulerAngles = var_148_39
			end

			local var_148_40 = 0

			if var_148_40 < arg_145_1.time_ and arg_145_1.time_ <= var_148_40 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_148_41 = 0

			if var_148_41 < arg_145_1.time_ and arg_145_1.time_ <= var_148_41 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_148_42 = 0
			local var_148_43 = 0.65

			if var_148_42 < arg_145_1.time_ and arg_145_1.time_ <= var_148_42 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_44 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_45 = arg_145_1:GetWordFromCfg(116431035)
				local var_148_46 = arg_145_1:FormatText(var_148_45.content)

				arg_145_1.text_.text = var_148_46

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_47 = 26
				local var_148_48 = utf8.len(var_148_46)
				local var_148_49 = var_148_47 <= 0 and var_148_43 or var_148_43 * (var_148_48 / var_148_47)

				if var_148_49 > 0 and var_148_43 < var_148_49 then
					arg_145_1.talkMaxDuration = var_148_49

					if var_148_49 + var_148_42 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_49 + var_148_42
					end
				end

				arg_145_1.text_.text = var_148_46
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431035", "story_v_out_116431.awb") ~= 0 then
					local var_148_50 = manager.audio:GetVoiceLength("story_v_out_116431", "116431035", "story_v_out_116431.awb") / 1000

					if var_148_50 + var_148_42 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_50 + var_148_42
					end

					if var_148_45.prefab_name ~= "" and arg_145_1.actors_[var_148_45.prefab_name] ~= nil then
						local var_148_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_45.prefab_name].transform, "story_v_out_116431", "116431035", "story_v_out_116431.awb")

						arg_145_1:RecordAudio("116431035", var_148_51)
						arg_145_1:RecordAudio("116431035", var_148_51)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_116431", "116431035", "story_v_out_116431.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_116431", "116431035", "story_v_out_116431.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_52 = math.max(var_148_43, arg_145_1.talkMaxDuration)

			if var_148_42 <= arg_145_1.time_ and arg_145_1.time_ < var_148_42 + var_148_52 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_42) / var_148_52

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_42 + var_148_52 and arg_145_1.time_ < var_148_42 + var_148_52 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play116431036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116431036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116431037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1084ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1084ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1084ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1084ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.375

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_9 = arg_149_1:GetWordFromCfg(116431036)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 15
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116431037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116431037
		arg_153_1.duration_ = 6.9

		local var_153_0 = {
			zh = 6.5,
			ja = 6.9
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
				arg_153_0:Play116431038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1011ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0.7, -0.71, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1084ui_story"].transform
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.var_.moveOldPos1084ui_story = var_156_9.localPosition
			end

			local var_156_11 = 0.001

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11
				local var_156_13 = Vector3.New(-0.7, -0.97, -6)

				var_156_9.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1084ui_story, var_156_13, var_156_12)

				local var_156_14 = manager.ui.mainCamera.transform.position - var_156_9.position

				var_156_9.forward = Vector3.New(var_156_14.x, var_156_14.y, var_156_14.z)

				local var_156_15 = var_156_9.localEulerAngles

				var_156_15.z = 0
				var_156_15.x = 0
				var_156_9.localEulerAngles = var_156_15
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 then
				var_156_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_156_16 = manager.ui.mainCamera.transform.position - var_156_9.position

				var_156_9.forward = Vector3.New(var_156_16.x, var_156_16.y, var_156_16.z)

				local var_156_17 = var_156_9.localEulerAngles

				var_156_17.z = 0
				var_156_17.x = 0
				var_156_9.localEulerAngles = var_156_17
			end

			local var_156_18 = 0

			if var_156_18 < arg_153_1.time_ and arg_153_1.time_ <= var_156_18 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_156_19 = 0

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_156_20 = arg_153_1.actors_["1011ui_story"]
			local var_156_21 = 0

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 and not isNil(var_156_20) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_22 = 0.2

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_22 and not isNil(var_156_20) then
				local var_156_23 = (arg_153_1.time_ - var_156_21) / var_156_22

				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_20) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_21 + var_156_22 and arg_153_1.time_ < var_156_21 + var_156_22 + arg_156_0 and not isNil(var_156_20) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_156_24 = 0
			local var_156_25 = 0.65

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_26 = arg_153_1:FormatText(StoryNameCfg[37].name)

				arg_153_1.leftNameTxt_.text = var_156_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_27 = arg_153_1:GetWordFromCfg(116431037)
				local var_156_28 = arg_153_1:FormatText(var_156_27.content)

				arg_153_1.text_.text = var_156_28

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_29 = 26
				local var_156_30 = utf8.len(var_156_28)
				local var_156_31 = var_156_29 <= 0 and var_156_25 or var_156_25 * (var_156_30 / var_156_29)

				if var_156_31 > 0 and var_156_25 < var_156_31 then
					arg_153_1.talkMaxDuration = var_156_31

					if var_156_31 + var_156_24 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_31 + var_156_24
					end
				end

				arg_153_1.text_.text = var_156_28
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431037", "story_v_out_116431.awb") ~= 0 then
					local var_156_32 = manager.audio:GetVoiceLength("story_v_out_116431", "116431037", "story_v_out_116431.awb") / 1000

					if var_156_32 + var_156_24 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_32 + var_156_24
					end

					if var_156_27.prefab_name ~= "" and arg_153_1.actors_[var_156_27.prefab_name] ~= nil then
						local var_156_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_27.prefab_name].transform, "story_v_out_116431", "116431037", "story_v_out_116431.awb")

						arg_153_1:RecordAudio("116431037", var_156_33)
						arg_153_1:RecordAudio("116431037", var_156_33)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_116431", "116431037", "story_v_out_116431.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_116431", "116431037", "story_v_out_116431.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_34 = math.max(var_156_25, arg_153_1.talkMaxDuration)

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_34 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_24) / var_156_34

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_24 + var_156_34 and arg_153_1.time_ < var_156_24 + var_156_34 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play116431038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116431038
		arg_157_1.duration_ = 3.8

		local var_157_0 = {
			zh = 3.8,
			ja = 2.833
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
				arg_157_0:Play116431039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1084ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1084ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(-0.7, -0.97, -6)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1084ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1084ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1084ui_story == nil then
				arg_157_1.var_.characterEffect1084ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.2

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1084ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1084ui_story then
				arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_160_13 = arg_157_1.actors_["1011ui_story"]
			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = var_160_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_15 = 0.2

			if var_160_14 <= arg_157_1.time_ and arg_157_1.time_ < var_160_14 + var_160_15 and not isNil(var_160_13) then
				local var_160_16 = (arg_157_1.time_ - var_160_14) / var_160_15

				if arg_157_1.var_.characterEffect1011ui_story and not isNil(var_160_13) then
					local var_160_17 = Mathf.Lerp(0, 0.5, var_160_16)

					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_17
				end
			end

			if arg_157_1.time_ >= var_160_14 + var_160_15 and arg_157_1.time_ < var_160_14 + var_160_15 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect1011ui_story then
				local var_160_18 = 0.5

				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_18
			end

			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_160_20 = 0

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_160_21 = 0
			local var_160_22 = 0.425

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[6].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(116431038)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 17
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_22 or var_160_22 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_22 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_21
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431038", "story_v_out_116431.awb") ~= 0 then
					local var_160_29 = manager.audio:GetVoiceLength("story_v_out_116431", "116431038", "story_v_out_116431.awb") / 1000

					if var_160_29 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_21
					end

					if var_160_24.prefab_name ~= "" and arg_157_1.actors_[var_160_24.prefab_name] ~= nil then
						local var_160_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_24.prefab_name].transform, "story_v_out_116431", "116431038", "story_v_out_116431.awb")

						arg_157_1:RecordAudio("116431038", var_160_30)
						arg_157_1:RecordAudio("116431038", var_160_30)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_116431", "116431038", "story_v_out_116431.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_116431", "116431038", "story_v_out_116431.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_31 = math.max(var_160_22, arg_157_1.talkMaxDuration)

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_31 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_31

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_31 and arg_157_1.time_ < var_160_21 + var_160_31 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play116431039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116431039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116431040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1084ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1084ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.425

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(116431039)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 17
				local var_164_11 = utf8.len(var_164_9)
				local var_164_12 = var_164_10 <= 0 and var_164_7 or var_164_7 * (var_164_11 / var_164_10)

				if var_164_12 > 0 and var_164_7 < var_164_12 then
					arg_161_1.talkMaxDuration = var_164_12

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_13 and arg_161_1.time_ < var_164_6 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116431040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116431040
		arg_165_1.duration_ = 6.37

		local var_165_0 = {
			zh = 6.133,
			ja = 6.366
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
				arg_165_0:Play116431041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1084ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(-0.7, -0.97, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1084ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.2

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_168_15 = 0
			local var_168_16 = 0.55

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[6].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(116431040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 22
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431040", "story_v_out_116431.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431040", "story_v_out_116431.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_116431", "116431040", "story_v_out_116431.awb")

						arg_165_1:RecordAudio("116431040", var_168_24)
						arg_165_1:RecordAudio("116431040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_116431", "116431040", "story_v_out_116431.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_116431", "116431040", "story_v_out_116431.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play116431041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116431041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116431042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1084ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1084ui_story == nil then
				arg_169_1.var_.characterEffect1084ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1084ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1084ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1084ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1084ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.325

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(116431041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 13
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_7 or var_172_7 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_7 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_13 and arg_169_1.time_ < var_172_6 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116431042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116431042
		arg_173_1.duration_ = 11.53

		local var_173_0 = {
			zh = 8.166,
			ja = 11.533
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
				arg_173_0:Play116431043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1011ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1011ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0.7, -0.71, -6)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1011ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1084ui_story"].transform
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.var_.moveOldPos1084ui_story = var_176_9.localPosition
			end

			local var_176_11 = 0.001

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11
				local var_176_13 = Vector3.New(-0.7, -0.97, -6)

				var_176_9.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1084ui_story, var_176_13, var_176_12)

				local var_176_14 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_14.x, var_176_14.y, var_176_14.z)

				local var_176_15 = var_176_9.localEulerAngles

				var_176_15.z = 0
				var_176_15.x = 0
				var_176_9.localEulerAngles = var_176_15
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 then
				var_176_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_176_16 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_16.x, var_176_16.y, var_176_16.z)

				local var_176_17 = var_176_9.localEulerAngles

				var_176_17.z = 0
				var_176_17.x = 0
				var_176_9.localEulerAngles = var_176_17
			end

			local var_176_18 = 0

			if var_176_18 < arg_173_1.time_ and arg_173_1.time_ <= var_176_18 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action423")
			end

			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_176_20 = arg_173_1.actors_["1011ui_story"]
			local var_176_21 = 0

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 and not isNil(var_176_20) and arg_173_1.var_.characterEffect1011ui_story == nil then
				arg_173_1.var_.characterEffect1011ui_story = var_176_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_22 = 0.2

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 and not isNil(var_176_20) then
				local var_176_23 = (arg_173_1.time_ - var_176_21) / var_176_22

				if arg_173_1.var_.characterEffect1011ui_story and not isNil(var_176_20) then
					arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 and not isNil(var_176_20) and arg_173_1.var_.characterEffect1011ui_story then
				arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_176_24 = 0
			local var_176_25 = 0.875

			if var_176_24 < arg_173_1.time_ and arg_173_1.time_ <= var_176_24 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_26 = arg_173_1:FormatText(StoryNameCfg[37].name)

				arg_173_1.leftNameTxt_.text = var_176_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_27 = arg_173_1:GetWordFromCfg(116431042)
				local var_176_28 = arg_173_1:FormatText(var_176_27.content)

				arg_173_1.text_.text = var_176_28

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_29 = 35
				local var_176_30 = utf8.len(var_176_28)
				local var_176_31 = var_176_29 <= 0 and var_176_25 or var_176_25 * (var_176_30 / var_176_29)

				if var_176_31 > 0 and var_176_25 < var_176_31 then
					arg_173_1.talkMaxDuration = var_176_31

					if var_176_31 + var_176_24 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_31 + var_176_24
					end
				end

				arg_173_1.text_.text = var_176_28
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431042", "story_v_out_116431.awb") ~= 0 then
					local var_176_32 = manager.audio:GetVoiceLength("story_v_out_116431", "116431042", "story_v_out_116431.awb") / 1000

					if var_176_32 + var_176_24 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_32 + var_176_24
					end

					if var_176_27.prefab_name ~= "" and arg_173_1.actors_[var_176_27.prefab_name] ~= nil then
						local var_176_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_27.prefab_name].transform, "story_v_out_116431", "116431042", "story_v_out_116431.awb")

						arg_173_1:RecordAudio("116431042", var_176_33)
						arg_173_1:RecordAudio("116431042", var_176_33)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_116431", "116431042", "story_v_out_116431.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_116431", "116431042", "story_v_out_116431.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_34 = math.max(var_176_25, arg_173_1.talkMaxDuration)

			if var_176_24 <= arg_173_1.time_ and arg_173_1.time_ < var_176_24 + var_176_34 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_24) / var_176_34

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_24 + var_176_34 and arg_173_1.time_ < var_176_24 + var_176_34 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play116431043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116431043
		arg_177_1.duration_ = 3.6

		local var_177_0 = {
			zh = 2.8,
			ja = 3.6
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
				arg_177_0:Play116431044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1084ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(-0.7, -0.97, -6)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1084ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.2

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_180_13 = arg_177_1.actors_["1011ui_story"]
			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_15 = 0.2

			if var_180_14 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 and not isNil(var_180_13) then
				local var_180_16 = (arg_177_1.time_ - var_180_14) / var_180_15

				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_13) then
					local var_180_17 = Mathf.Lerp(0, 0.5, var_180_16)

					arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_17
				end
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1011ui_story then
				local var_180_18 = 0.5

				arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_18
			end

			local var_180_19 = 0

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_180_20 = 0

			if var_180_20 < arg_177_1.time_ and arg_177_1.time_ <= var_180_20 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_180_21 = 0
			local var_180_22 = 0.3

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_23 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_24 = arg_177_1:GetWordFromCfg(116431043)
				local var_180_25 = arg_177_1:FormatText(var_180_24.content)

				arg_177_1.text_.text = var_180_25

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_26 = 12
				local var_180_27 = utf8.len(var_180_25)
				local var_180_28 = var_180_26 <= 0 and var_180_22 or var_180_22 * (var_180_27 / var_180_26)

				if var_180_28 > 0 and var_180_22 < var_180_28 then
					arg_177_1.talkMaxDuration = var_180_28

					if var_180_28 + var_180_21 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_28 + var_180_21
					end
				end

				arg_177_1.text_.text = var_180_25
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431043", "story_v_out_116431.awb") ~= 0 then
					local var_180_29 = manager.audio:GetVoiceLength("story_v_out_116431", "116431043", "story_v_out_116431.awb") / 1000

					if var_180_29 + var_180_21 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_29 + var_180_21
					end

					if var_180_24.prefab_name ~= "" and arg_177_1.actors_[var_180_24.prefab_name] ~= nil then
						local var_180_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_24.prefab_name].transform, "story_v_out_116431", "116431043", "story_v_out_116431.awb")

						arg_177_1:RecordAudio("116431043", var_180_30)
						arg_177_1:RecordAudio("116431043", var_180_30)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116431", "116431043", "story_v_out_116431.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116431", "116431043", "story_v_out_116431.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_31 = math.max(var_180_22, arg_177_1.talkMaxDuration)

			if var_180_21 <= arg_177_1.time_ and arg_177_1.time_ < var_180_21 + var_180_31 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_21) / var_180_31

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_21 + var_180_31 and arg_177_1.time_ < var_180_21 + var_180_31 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play116431044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116431044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116431045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1011ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1011ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1011ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1084ui_story"].transform
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.var_.moveOldPos1084ui_story = var_184_9.localPosition
			end

			local var_184_11 = 0.001

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11
				local var_184_13 = Vector3.New(0, 100, 0)

				var_184_9.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1084ui_story, var_184_13, var_184_12)

				local var_184_14 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_14.x, var_184_14.y, var_184_14.z)

				local var_184_15 = var_184_9.localEulerAngles

				var_184_15.z = 0
				var_184_15.x = 0
				var_184_9.localEulerAngles = var_184_15
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 then
				var_184_9.localPosition = Vector3.New(0, 100, 0)

				local var_184_16 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_16.x, var_184_16.y, var_184_16.z)

				local var_184_17 = var_184_9.localEulerAngles

				var_184_17.z = 0
				var_184_17.x = 0
				var_184_9.localEulerAngles = var_184_17
			end

			local var_184_18 = 0
			local var_184_19 = 0.175

			if var_184_18 < arg_181_1.time_ and arg_181_1.time_ <= var_184_18 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_20 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_21 = arg_181_1:GetWordFromCfg(116431044)
				local var_184_22 = arg_181_1:FormatText(var_184_21.content)

				arg_181_1.text_.text = var_184_22

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_23 = 7
				local var_184_24 = utf8.len(var_184_22)
				local var_184_25 = var_184_23 <= 0 and var_184_19 or var_184_19 * (var_184_24 / var_184_23)

				if var_184_25 > 0 and var_184_19 < var_184_25 then
					arg_181_1.talkMaxDuration = var_184_25

					if var_184_25 + var_184_18 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_25 + var_184_18
					end
				end

				arg_181_1.text_.text = var_184_22
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_19, arg_181_1.talkMaxDuration)

			if var_184_18 <= arg_181_1.time_ and arg_181_1.time_ < var_184_18 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_18) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_18 + var_184_26 and arg_181_1.time_ < var_184_18 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play116431045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116431045
		arg_185_1.duration_ = 7

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116431046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = "SK0202"

			if arg_185_1.bgs_[var_188_0] == nil then
				local var_188_1 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_188_0)
				var_188_1.name = var_188_0
				var_188_1.transform.parent = arg_185_1.stage_.transform
				var_188_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_[var_188_0] = var_188_1
			end

			local var_188_2 = 0

			if var_188_2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				local var_188_3 = manager.ui.mainCamera.transform.localPosition
				local var_188_4 = Vector3.New(0, 0, 10) + Vector3.New(var_188_3.x, var_188_3.y, 0)
				local var_188_5 = arg_185_1.bgs_.SK0202

				var_188_5.transform.localPosition = var_188_4
				var_188_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_6 = var_188_5:GetComponent("SpriteRenderer")

				if var_188_6 and var_188_6.sprite then
					local var_188_7 = (var_188_5.transform.localPosition - var_188_3).z
					local var_188_8 = manager.ui.mainCameraCom_
					local var_188_9 = 2 * var_188_7 * Mathf.Tan(var_188_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_10 = var_188_9 * var_188_8.aspect
					local var_188_11 = var_188_6.sprite.bounds.size.x
					local var_188_12 = var_188_6.sprite.bounds.size.y
					local var_188_13 = var_188_10 / var_188_11
					local var_188_14 = var_188_9 / var_188_12
					local var_188_15 = var_188_14 < var_188_13 and var_188_13 or var_188_14

					var_188_5.transform.localScale = Vector3.New(var_188_15, var_188_15, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "SK0202" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_17 = 2

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Color.New(1, 1, 1)

				var_188_19.a = Mathf.Lerp(1, 0, var_188_18)
				arg_185_1.mask_.color = var_188_19
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				local var_188_20 = Color.New(1, 1, 1)
				local var_188_21 = 0

				arg_185_1.mask_.enabled = false
				var_188_20.a = var_188_21
				arg_185_1.mask_.color = var_188_20
			end

			local var_188_22 = "SK0202_blur"

			if arg_185_1.bgs_[var_188_22] == nil then
				local var_188_23 = Object.Instantiate(arg_185_1.blurPaintGo_)
				local var_188_24 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_188_22)

				var_188_23:GetComponent("SpriteRenderer").sprite = var_188_24
				var_188_23.name = var_188_22
				var_188_23.transform.parent = arg_185_1.stage_.transform
				var_188_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_[var_188_22] = var_188_23
			end

			local var_188_25 = 0
			local var_188_26 = arg_185_1.bgs_[var_188_22]

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 then
				local var_188_27 = manager.ui.mainCamera.transform.localPosition
				local var_188_28 = Vector3.New(0, 0, 10) + Vector3.New(var_188_27.x, var_188_27.y, 0)

				var_188_26.transform.localPosition = var_188_28
				var_188_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_29 = var_188_26:GetComponent("SpriteRenderer")

				if var_188_29 and var_188_29.sprite then
					local var_188_30 = (var_188_26.transform.localPosition - var_188_27).z
					local var_188_31 = manager.ui.mainCameraCom_
					local var_188_32 = 2 * var_188_30 * Mathf.Tan(var_188_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_33 = var_188_32 * var_188_31.aspect
					local var_188_34 = var_188_29.sprite.bounds.size.x
					local var_188_35 = var_188_29.sprite.bounds.size.y
					local var_188_36 = var_188_33 / var_188_34
					local var_188_37 = var_188_32 / var_188_35
					local var_188_38 = var_188_37 < var_188_36 and var_188_36 or var_188_37

					var_188_26.transform.localScale = Vector3.New(var_188_38, var_188_38, 0)
				end
			end

			local var_188_39 = 1

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_39 then
				local var_188_40 = (arg_185_1.time_ - var_188_25) / var_188_39
				local var_188_41 = Color.New(1, 1, 1)

				var_188_41.a = Mathf.Lerp(0, 1, var_188_40)

				var_188_26:GetComponent("SpriteRenderer").material:SetColor("_Color", var_188_41)
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_42 = 2
			local var_188_43 = 0.9

			if var_188_42 < arg_185_1.time_ and arg_185_1.time_ <= var_188_42 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_44 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_44:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_45 = arg_185_1:GetWordFromCfg(116431045)
				local var_188_46 = arg_185_1:FormatText(var_188_45.content)

				arg_185_1.text_.text = var_188_46

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_47 = 36
				local var_188_48 = utf8.len(var_188_46)
				local var_188_49 = var_188_47 <= 0 and var_188_43 or var_188_43 * (var_188_48 / var_188_47)

				if var_188_49 > 0 and var_188_43 < var_188_49 then
					arg_185_1.talkMaxDuration = var_188_49
					var_188_42 = var_188_42 + 0.3

					if var_188_49 + var_188_42 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_49 + var_188_42
					end
				end

				arg_185_1.text_.text = var_188_46
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_50 = var_188_42 + 0.3
			local var_188_51 = math.max(var_188_43, arg_185_1.talkMaxDuration)

			if var_188_50 <= arg_185_1.time_ and arg_185_1.time_ < var_188_50 + var_188_51 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_50) / var_188_51

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_50 + var_188_51 and arg_185_1.time_ < var_188_50 + var_188_51 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116431046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 116431046
		arg_191_1.duration_ = 7

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play116431047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "SK0205"

			if arg_191_1.bgs_[var_194_0] == nil then
				local var_194_1 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_0)
				var_194_1.name = var_194_0
				var_194_1.transform.parent = arg_191_1.stage_.transform
				var_194_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_0] = var_194_1
			end

			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_3 = manager.ui.mainCamera.transform.localPosition
				local var_194_4 = Vector3.New(0, 0, 10) + Vector3.New(var_194_3.x, var_194_3.y, 0)
				local var_194_5 = arg_191_1.bgs_.SK0205

				var_194_5.transform.localPosition = var_194_4
				var_194_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_6 = var_194_5:GetComponent("SpriteRenderer")

				if var_194_6 and var_194_6.sprite then
					local var_194_7 = (var_194_5.transform.localPosition - var_194_3).z
					local var_194_8 = manager.ui.mainCameraCom_
					local var_194_9 = 2 * var_194_7 * Mathf.Tan(var_194_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_10 = var_194_9 * var_194_8.aspect
					local var_194_11 = var_194_6.sprite.bounds.size.x
					local var_194_12 = var_194_6.sprite.bounds.size.y
					local var_194_13 = var_194_10 / var_194_11
					local var_194_14 = var_194_9 / var_194_12
					local var_194_15 = var_194_14 < var_194_13 and var_194_13 or var_194_14

					var_194_5.transform.localScale = Vector3.New(var_194_15, var_194_15, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "SK0205" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_17 = 2

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17
				local var_194_19 = Color.New(1, 1, 1)

				var_194_19.a = Mathf.Lerp(1, 0, var_194_18)
				arg_191_1.mask_.color = var_194_19
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				local var_194_20 = Color.New(1, 1, 1)
				local var_194_21 = 0

				arg_191_1.mask_.enabled = false
				var_194_20.a = var_194_21
				arg_191_1.mask_.color = var_194_20
			end

			local var_194_22 = "SK0205_blur"

			if arg_191_1.bgs_[var_194_22] == nil then
				local var_194_23 = Object.Instantiate(arg_191_1.blurPaintGo_)
				local var_194_24 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_22)

				var_194_23:GetComponent("SpriteRenderer").sprite = var_194_24
				var_194_23.name = var_194_22
				var_194_23.transform.parent = arg_191_1.stage_.transform
				var_194_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_22] = var_194_23
			end

			local var_194_25 = 0
			local var_194_26 = arg_191_1.bgs_[var_194_22]

			if var_194_25 < arg_191_1.time_ and arg_191_1.time_ <= var_194_25 + arg_194_0 then
				local var_194_27 = manager.ui.mainCamera.transform.localPosition
				local var_194_28 = Vector3.New(0, 0, 10) + Vector3.New(var_194_27.x, var_194_27.y, 0)

				var_194_26.transform.localPosition = var_194_28
				var_194_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_29 = var_194_26:GetComponent("SpriteRenderer")

				if var_194_29 and var_194_29.sprite then
					local var_194_30 = (var_194_26.transform.localPosition - var_194_27).z
					local var_194_31 = manager.ui.mainCameraCom_
					local var_194_32 = 2 * var_194_30 * Mathf.Tan(var_194_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_33 = var_194_32 * var_194_31.aspect
					local var_194_34 = var_194_29.sprite.bounds.size.x
					local var_194_35 = var_194_29.sprite.bounds.size.y
					local var_194_36 = var_194_33 / var_194_34
					local var_194_37 = var_194_32 / var_194_35
					local var_194_38 = var_194_37 < var_194_36 and var_194_36 or var_194_37

					var_194_26.transform.localScale = Vector3.New(var_194_38, var_194_38, 0)
				end
			end

			local var_194_39 = 1

			if var_194_25 <= arg_191_1.time_ and arg_191_1.time_ < var_194_25 + var_194_39 then
				local var_194_40 = (arg_191_1.time_ - var_194_25) / var_194_39
				local var_194_41 = Color.New(1, 1, 1)

				var_194_41.a = Mathf.Lerp(0, 1, var_194_40)

				var_194_26:GetComponent("SpriteRenderer").material:SetColor("_Color", var_194_41)
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_42 = 2
			local var_194_43 = 0.425

			if var_194_42 < arg_191_1.time_ and arg_191_1.time_ <= var_194_42 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_44 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_44:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_45 = arg_191_1:GetWordFromCfg(116431046)
				local var_194_46 = arg_191_1:FormatText(var_194_45.content)

				arg_191_1.text_.text = var_194_46

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_47 = 17
				local var_194_48 = utf8.len(var_194_46)
				local var_194_49 = var_194_47 <= 0 and var_194_43 or var_194_43 * (var_194_48 / var_194_47)

				if var_194_49 > 0 and var_194_43 < var_194_49 then
					arg_191_1.talkMaxDuration = var_194_49
					var_194_42 = var_194_42 + 0.3

					if var_194_49 + var_194_42 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_49 + var_194_42
					end
				end

				arg_191_1.text_.text = var_194_46
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_50 = var_194_42 + 0.3
			local var_194_51 = math.max(var_194_43, arg_191_1.talkMaxDuration)

			if var_194_50 <= arg_191_1.time_ and arg_191_1.time_ < var_194_50 + var_194_51 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_50) / var_194_51

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_50 + var_194_51 and arg_191_1.time_ < var_194_50 + var_194_51 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play116431047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116431047
		arg_197_1.duration_ = 7

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116431048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "SK0106"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 0

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.SK0106

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "SK0106" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_17 = 2

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Color.New(1, 1, 1)

				var_200_19.a = Mathf.Lerp(1, 0, var_200_18)
				arg_197_1.mask_.color = var_200_19
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				local var_200_20 = Color.New(1, 1, 1)
				local var_200_21 = 0

				arg_197_1.mask_.enabled = false
				var_200_20.a = var_200_21
				arg_197_1.mask_.color = var_200_20
			end

			local var_200_22 = "SK0106_blur"

			if arg_197_1.bgs_[var_200_22] == nil then
				local var_200_23 = Object.Instantiate(arg_197_1.blurPaintGo_)
				local var_200_24 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_22)

				var_200_23:GetComponent("SpriteRenderer").sprite = var_200_24
				var_200_23.name = var_200_22
				var_200_23.transform.parent = arg_197_1.stage_.transform
				var_200_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_22] = var_200_23
			end

			local var_200_25 = 0
			local var_200_26 = arg_197_1.bgs_[var_200_22]

			if var_200_25 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 then
				local var_200_27 = manager.ui.mainCamera.transform.localPosition
				local var_200_28 = Vector3.New(0, 0, 10) + Vector3.New(var_200_27.x, var_200_27.y, 0)

				var_200_26.transform.localPosition = var_200_28
				var_200_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_29 = var_200_26:GetComponent("SpriteRenderer")

				if var_200_29 and var_200_29.sprite then
					local var_200_30 = (var_200_26.transform.localPosition - var_200_27).z
					local var_200_31 = manager.ui.mainCameraCom_
					local var_200_32 = 2 * var_200_30 * Mathf.Tan(var_200_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_33 = var_200_32 * var_200_31.aspect
					local var_200_34 = var_200_29.sprite.bounds.size.x
					local var_200_35 = var_200_29.sprite.bounds.size.y
					local var_200_36 = var_200_33 / var_200_34
					local var_200_37 = var_200_32 / var_200_35
					local var_200_38 = var_200_37 < var_200_36 and var_200_36 or var_200_37

					var_200_26.transform.localScale = Vector3.New(var_200_38, var_200_38, 0)
				end
			end

			local var_200_39 = 1

			if var_200_25 <= arg_197_1.time_ and arg_197_1.time_ < var_200_25 + var_200_39 then
				local var_200_40 = (arg_197_1.time_ - var_200_25) / var_200_39
				local var_200_41 = Color.New(1, 1, 1)

				var_200_41.a = Mathf.Lerp(0, 1, var_200_40)

				var_200_26:GetComponent("SpriteRenderer").material:SetColor("_Color", var_200_41)
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_42 = 2
			local var_200_43 = 0.425

			if var_200_42 < arg_197_1.time_ and arg_197_1.time_ <= var_200_42 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_44 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_44:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_45 = arg_197_1:GetWordFromCfg(116431047)
				local var_200_46 = arg_197_1:FormatText(var_200_45.content)

				arg_197_1.text_.text = var_200_46

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_47 = 17
				local var_200_48 = utf8.len(var_200_46)
				local var_200_49 = var_200_47 <= 0 and var_200_43 or var_200_43 * (var_200_48 / var_200_47)

				if var_200_49 > 0 and var_200_43 < var_200_49 then
					arg_197_1.talkMaxDuration = var_200_49
					var_200_42 = var_200_42 + 0.3

					if var_200_49 + var_200_42 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_49 + var_200_42
					end
				end

				arg_197_1.text_.text = var_200_46
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_50 = var_200_42 + 0.3
			local var_200_51 = math.max(var_200_43, arg_197_1.talkMaxDuration)

			if var_200_50 <= arg_197_1.time_ and arg_197_1.time_ < var_200_50 + var_200_51 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_50) / var_200_51

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_50 + var_200_51 and arg_197_1.time_ < var_200_50 + var_200_51 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116431048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116431048
		arg_203_1.duration_ = 7

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116431049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "SK0206"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 0

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.SK0206

				var_206_5.transform.localPosition = var_206_4
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = (var_206_5.transform.localPosition - var_206_3).z
					local var_206_8 = manager.ui.mainCameraCom_
					local var_206_9 = 2 * var_206_7 * Mathf.Tan(var_206_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_10 = var_206_9 * var_206_8.aspect
					local var_206_11 = var_206_6.sprite.bounds.size.x
					local var_206_12 = var_206_6.sprite.bounds.size.y
					local var_206_13 = var_206_10 / var_206_11
					local var_206_14 = var_206_9 / var_206_12
					local var_206_15 = var_206_14 < var_206_13 and var_206_13 or var_206_14

					var_206_5.transform.localScale = Vector3.New(var_206_15, var_206_15, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "SK0206" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_17 = 2

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17
				local var_206_19 = Color.New(1, 1, 1)

				var_206_19.a = Mathf.Lerp(1, 0, var_206_18)
				arg_203_1.mask_.color = var_206_19
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				local var_206_20 = Color.New(1, 1, 1)
				local var_206_21 = 0

				arg_203_1.mask_.enabled = false
				var_206_20.a = var_206_21
				arg_203_1.mask_.color = var_206_20
			end

			local var_206_22 = "SK0206_blur"

			if arg_203_1.bgs_[var_206_22] == nil then
				local var_206_23 = Object.Instantiate(arg_203_1.blurPaintGo_)
				local var_206_24 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_22)

				var_206_23:GetComponent("SpriteRenderer").sprite = var_206_24
				var_206_23.name = var_206_22
				var_206_23.transform.parent = arg_203_1.stage_.transform
				var_206_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_22] = var_206_23
			end

			local var_206_25 = 0
			local var_206_26 = arg_203_1.bgs_[var_206_22]

			if var_206_25 < arg_203_1.time_ and arg_203_1.time_ <= var_206_25 + arg_206_0 then
				local var_206_27 = manager.ui.mainCamera.transform.localPosition
				local var_206_28 = Vector3.New(0, 0, 10) + Vector3.New(var_206_27.x, var_206_27.y, 0)

				var_206_26.transform.localPosition = var_206_28
				var_206_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_29 = var_206_26:GetComponent("SpriteRenderer")

				if var_206_29 and var_206_29.sprite then
					local var_206_30 = (var_206_26.transform.localPosition - var_206_27).z
					local var_206_31 = manager.ui.mainCameraCom_
					local var_206_32 = 2 * var_206_30 * Mathf.Tan(var_206_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_33 = var_206_32 * var_206_31.aspect
					local var_206_34 = var_206_29.sprite.bounds.size.x
					local var_206_35 = var_206_29.sprite.bounds.size.y
					local var_206_36 = var_206_33 / var_206_34
					local var_206_37 = var_206_32 / var_206_35
					local var_206_38 = var_206_37 < var_206_36 and var_206_36 or var_206_37

					var_206_26.transform.localScale = Vector3.New(var_206_38, var_206_38, 0)
				end
			end

			local var_206_39 = 1

			if var_206_25 <= arg_203_1.time_ and arg_203_1.time_ < var_206_25 + var_206_39 then
				local var_206_40 = (arg_203_1.time_ - var_206_25) / var_206_39
				local var_206_41 = Color.New(1, 1, 1)

				var_206_41.a = Mathf.Lerp(0, 1, var_206_40)

				var_206_26:GetComponent("SpriteRenderer").material:SetColor("_Color", var_206_41)
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_42 = 2
			local var_206_43 = 0.425

			if var_206_42 < arg_203_1.time_ and arg_203_1.time_ <= var_206_42 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_44 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_44:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_45 = arg_203_1:GetWordFromCfg(116431048)
				local var_206_46 = arg_203_1:FormatText(var_206_45.content)

				arg_203_1.text_.text = var_206_46

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_47 = 17
				local var_206_48 = utf8.len(var_206_46)
				local var_206_49 = var_206_47 <= 0 and var_206_43 or var_206_43 * (var_206_48 / var_206_47)

				if var_206_49 > 0 and var_206_43 < var_206_49 then
					arg_203_1.talkMaxDuration = var_206_49
					var_206_42 = var_206_42 + 0.3

					if var_206_49 + var_206_42 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_49 + var_206_42
					end
				end

				arg_203_1.text_.text = var_206_46
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_50 = var_206_42 + 0.3
			local var_206_51 = math.max(var_206_43, arg_203_1.talkMaxDuration)

			if var_206_50 <= arg_203_1.time_ and arg_203_1.time_ < var_206_50 + var_206_51 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_50) / var_206_51

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_50 + var_206_51 and arg_203_1.time_ < var_206_50 + var_206_51 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116431049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116431049
		arg_209_1.duration_ = 8.67

		local var_209_0 = {
			zh = 8.666,
			ja = 8.1
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play116431050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "I05e"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 0

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.I05e

				var_212_5.transform.localPosition = var_212_4
				var_212_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_6 = var_212_5:GetComponent("SpriteRenderer")

				if var_212_6 and var_212_6.sprite then
					local var_212_7 = (var_212_5.transform.localPosition - var_212_3).z
					local var_212_8 = manager.ui.mainCameraCom_
					local var_212_9 = 2 * var_212_7 * Mathf.Tan(var_212_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_10 = var_212_9 * var_212_8.aspect
					local var_212_11 = var_212_6.sprite.bounds.size.x
					local var_212_12 = var_212_6.sprite.bounds.size.y
					local var_212_13 = var_212_10 / var_212_11
					local var_212_14 = var_212_9 / var_212_12
					local var_212_15 = var_212_14 < var_212_13 and var_212_13 or var_212_14

					var_212_5.transform.localScale = Vector3.New(var_212_15, var_212_15, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "I05e" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_17 = 2

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Color.New(1, 1, 1)

				var_212_19.a = Mathf.Lerp(1, 0, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(1, 1, 1)
				local var_212_21 = 0

				arg_209_1.mask_.enabled = false
				var_212_20.a = var_212_21
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_22 = "10025ui_story"

			if arg_209_1.actors_[var_212_22] == nil then
				local var_212_23 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_212_23) then
					local var_212_24 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_209_1.stage_.transform)

					var_212_24.name = var_212_22
					var_212_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_209_1.actors_[var_212_22] = var_212_24

					local var_212_25 = var_212_24:GetComponentInChildren(typeof(CharacterEffect))

					var_212_25.enabled = true

					local var_212_26 = GameObjectTools.GetOrAddComponent(var_212_24, typeof(DynamicBoneHelper))

					if var_212_26 then
						var_212_26:EnableDynamicBone(false)
					end

					arg_209_1:ShowWeapon(var_212_25.transform, false)

					arg_209_1.var_[var_212_22 .. "Animator"] = var_212_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_209_1.var_[var_212_22 .. "Animator"].applyRootMotion = true
					arg_209_1.var_[var_212_22 .. "LipSync"] = var_212_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_212_27 = arg_209_1.actors_["10025ui_story"].transform
			local var_212_28 = 0.7

			if var_212_28 < arg_209_1.time_ and arg_209_1.time_ <= var_212_28 + arg_212_0 then
				arg_209_1.var_.moveOldPos10025ui_story = var_212_27.localPosition
			end

			local var_212_29 = 0.001

			if var_212_28 <= arg_209_1.time_ and arg_209_1.time_ < var_212_28 + var_212_29 then
				local var_212_30 = (arg_209_1.time_ - var_212_28) / var_212_29
				local var_212_31 = Vector3.New(0, -1.1, -5.9)

				var_212_27.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10025ui_story, var_212_31, var_212_30)

				local var_212_32 = manager.ui.mainCamera.transform.position - var_212_27.position

				var_212_27.forward = Vector3.New(var_212_32.x, var_212_32.y, var_212_32.z)

				local var_212_33 = var_212_27.localEulerAngles

				var_212_33.z = 0
				var_212_33.x = 0
				var_212_27.localEulerAngles = var_212_33
			end

			if arg_209_1.time_ >= var_212_28 + var_212_29 and arg_209_1.time_ < var_212_28 + var_212_29 + arg_212_0 then
				var_212_27.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_212_34 = manager.ui.mainCamera.transform.position - var_212_27.position

				var_212_27.forward = Vector3.New(var_212_34.x, var_212_34.y, var_212_34.z)

				local var_212_35 = var_212_27.localEulerAngles

				var_212_35.z = 0
				var_212_35.x = 0
				var_212_27.localEulerAngles = var_212_35
			end

			local var_212_36 = arg_209_1.actors_["10025ui_story"]
			local var_212_37 = 0.7

			if var_212_37 < arg_209_1.time_ and arg_209_1.time_ <= var_212_37 + arg_212_0 and not isNil(var_212_36) and arg_209_1.var_.characterEffect10025ui_story == nil then
				arg_209_1.var_.characterEffect10025ui_story = var_212_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_38 = 0.2

			if var_212_37 <= arg_209_1.time_ and arg_209_1.time_ < var_212_37 + var_212_38 and not isNil(var_212_36) then
				local var_212_39 = (arg_209_1.time_ - var_212_37) / var_212_38

				if arg_209_1.var_.characterEffect10025ui_story and not isNil(var_212_36) then
					arg_209_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_37 + var_212_38 and arg_209_1.time_ < var_212_37 + var_212_38 + arg_212_0 and not isNil(var_212_36) and arg_209_1.var_.characterEffect10025ui_story then
				arg_209_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_212_40 = 0.7

			if var_212_40 < arg_209_1.time_ and arg_209_1.time_ <= var_212_40 + arg_212_0 then
				arg_209_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_212_41 = 0.7

			if var_212_41 < arg_209_1.time_ and arg_209_1.time_ <= var_212_41 + arg_212_0 then
				arg_209_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_212_42 = "I05e_blur"

			if arg_209_1.bgs_[var_212_42] == nil then
				local var_212_43 = Object.Instantiate(arg_209_1.blurPaintGo_)
				local var_212_44 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_42)

				var_212_43:GetComponent("SpriteRenderer").sprite = var_212_44
				var_212_43.name = var_212_42
				var_212_43.transform.parent = arg_209_1.stage_.transform
				var_212_43.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_42] = var_212_43
			end

			local var_212_45 = 0.7
			local var_212_46 = arg_209_1.bgs_[var_212_42]

			if var_212_45 < arg_209_1.time_ and arg_209_1.time_ <= var_212_45 + arg_212_0 then
				local var_212_47 = manager.ui.mainCamera.transform.localPosition
				local var_212_48 = Vector3.New(0, 0, 10) + Vector3.New(var_212_47.x, var_212_47.y, 0)

				var_212_46.transform.localPosition = var_212_48
				var_212_46.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_49 = var_212_46:GetComponent("SpriteRenderer")

				if var_212_49 and var_212_49.sprite then
					local var_212_50 = (var_212_46.transform.localPosition - var_212_47).z
					local var_212_51 = manager.ui.mainCameraCom_
					local var_212_52 = 2 * var_212_50 * Mathf.Tan(var_212_51.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_53 = var_212_52 * var_212_51.aspect
					local var_212_54 = var_212_49.sprite.bounds.size.x
					local var_212_55 = var_212_49.sprite.bounds.size.y
					local var_212_56 = var_212_53 / var_212_54
					local var_212_57 = var_212_52 / var_212_55
					local var_212_58 = var_212_57 < var_212_56 and var_212_56 or var_212_57

					var_212_46.transform.localScale = Vector3.New(var_212_58, var_212_58, 0)
				end
			end

			local var_212_59 = 2

			if var_212_45 <= arg_209_1.time_ and arg_209_1.time_ < var_212_45 + var_212_59 then
				local var_212_60 = (arg_209_1.time_ - var_212_45) / var_212_59
				local var_212_61 = Color.New(1, 1, 1)

				var_212_61.a = Mathf.Lerp(0, 1, var_212_60)

				var_212_46:GetComponent("SpriteRenderer").material:SetColor("_Color", var_212_61)
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_62 = 2
			local var_212_63 = 0.35

			if var_212_62 < arg_209_1.time_ and arg_209_1.time_ <= var_212_62 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_64 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_64:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_65 = arg_209_1:FormatText(StoryNameCfg[36].name)

				arg_209_1.leftNameTxt_.text = var_212_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_66 = arg_209_1:GetWordFromCfg(116431049)
				local var_212_67 = arg_209_1:FormatText(var_212_66.content)

				arg_209_1.text_.text = var_212_67

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_68 = 14
				local var_212_69 = utf8.len(var_212_67)
				local var_212_70 = var_212_68 <= 0 and var_212_63 or var_212_63 * (var_212_69 / var_212_68)

				if var_212_70 > 0 and var_212_63 < var_212_70 then
					arg_209_1.talkMaxDuration = var_212_70
					var_212_62 = var_212_62 + 0.3

					if var_212_70 + var_212_62 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_70 + var_212_62
					end
				end

				arg_209_1.text_.text = var_212_67
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431049", "story_v_out_116431.awb") ~= 0 then
					local var_212_71 = manager.audio:GetVoiceLength("story_v_out_116431", "116431049", "story_v_out_116431.awb") / 1000

					if var_212_71 + var_212_62 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_71 + var_212_62
					end

					if var_212_66.prefab_name ~= "" and arg_209_1.actors_[var_212_66.prefab_name] ~= nil then
						local var_212_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_66.prefab_name].transform, "story_v_out_116431", "116431049", "story_v_out_116431.awb")

						arg_209_1:RecordAudio("116431049", var_212_72)
						arg_209_1:RecordAudio("116431049", var_212_72)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116431", "116431049", "story_v_out_116431.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116431", "116431049", "story_v_out_116431.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_73 = var_212_62 + 0.3
			local var_212_74 = math.max(var_212_63, arg_209_1.talkMaxDuration)

			if var_212_73 <= arg_209_1.time_ and arg_209_1.time_ < var_212_73 + var_212_74 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_73) / var_212_74

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_73 + var_212_74 and arg_209_1.time_ < var_212_73 + var_212_74 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play116431050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116431050
		arg_215_1.duration_ = 7

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116431051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = "SK0211"

			if arg_215_1.bgs_[var_218_0] == nil then
				local var_218_1 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_0)
				var_218_1.name = var_218_0
				var_218_1.transform.parent = arg_215_1.stage_.transform
				var_218_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_0] = var_218_1
			end

			local var_218_2 = 0

			if var_218_2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				local var_218_3 = manager.ui.mainCamera.transform.localPosition
				local var_218_4 = Vector3.New(0, 0, 10) + Vector3.New(var_218_3.x, var_218_3.y, 0)
				local var_218_5 = arg_215_1.bgs_.SK0211

				var_218_5.transform.localPosition = var_218_4
				var_218_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_6 = var_218_5:GetComponent("SpriteRenderer")

				if var_218_6 and var_218_6.sprite then
					local var_218_7 = (var_218_5.transform.localPosition - var_218_3).z
					local var_218_8 = manager.ui.mainCameraCom_
					local var_218_9 = 2 * var_218_7 * Mathf.Tan(var_218_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_10 = var_218_9 * var_218_8.aspect
					local var_218_11 = var_218_6.sprite.bounds.size.x
					local var_218_12 = var_218_6.sprite.bounds.size.y
					local var_218_13 = var_218_10 / var_218_11
					local var_218_14 = var_218_9 / var_218_12
					local var_218_15 = var_218_14 < var_218_13 and var_218_13 or var_218_14

					var_218_5.transform.localScale = Vector3.New(var_218_15, var_218_15, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "SK0211" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_17 = 2

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17
				local var_218_19 = Color.New(1, 1, 1)

				var_218_19.a = Mathf.Lerp(1, 0, var_218_18)
				arg_215_1.mask_.color = var_218_19
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 then
				local var_218_20 = Color.New(1, 1, 1)
				local var_218_21 = 0

				arg_215_1.mask_.enabled = false
				var_218_20.a = var_218_21
				arg_215_1.mask_.color = var_218_20
			end

			local var_218_22 = arg_215_1.actors_["10025ui_story"].transform
			local var_218_23 = 0

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.var_.moveOldPos10025ui_story = var_218_22.localPosition
			end

			local var_218_24 = 0.001

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_24 then
				local var_218_25 = (arg_215_1.time_ - var_218_23) / var_218_24
				local var_218_26 = Vector3.New(0, 100, 0)

				var_218_22.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10025ui_story, var_218_26, var_218_25)

				local var_218_27 = manager.ui.mainCamera.transform.position - var_218_22.position

				var_218_22.forward = Vector3.New(var_218_27.x, var_218_27.y, var_218_27.z)

				local var_218_28 = var_218_22.localEulerAngles

				var_218_28.z = 0
				var_218_28.x = 0
				var_218_22.localEulerAngles = var_218_28
			end

			if arg_215_1.time_ >= var_218_23 + var_218_24 and arg_215_1.time_ < var_218_23 + var_218_24 + arg_218_0 then
				var_218_22.localPosition = Vector3.New(0, 100, 0)

				local var_218_29 = manager.ui.mainCamera.transform.position - var_218_22.position

				var_218_22.forward = Vector3.New(var_218_29.x, var_218_29.y, var_218_29.z)

				local var_218_30 = var_218_22.localEulerAngles

				var_218_30.z = 0
				var_218_30.x = 0
				var_218_22.localEulerAngles = var_218_30
			end

			local var_218_31 = 0
			local var_218_32 = 0.666666666666667

			if var_218_31 < arg_215_1.time_ and arg_215_1.time_ <= var_218_31 + arg_218_0 then
				local var_218_33 = "play"
				local var_218_34 = "music"

				arg_215_1:AudioAction(var_218_33, var_218_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_218_35 = ""
				local var_218_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_218_36 ~= "" then
					if arg_215_1.bgmTxt_.text ~= var_218_36 and arg_215_1.bgmTxt_.text ~= "" then
						if arg_215_1.bgmTxt2_.text ~= "" then
							arg_215_1.bgmTxt_.text = arg_215_1.bgmTxt2_.text
						end

						arg_215_1.bgmTxt2_.text = var_218_36

						arg_215_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_215_1.bgmTxt_.text = var_218_36
						arg_215_1.bgmTxt2_.text = var_218_36
					end

					if arg_215_1.bgmTimer then
						arg_215_1.bgmTimer:Stop()

						arg_215_1.bgmTimer = nil
					end

					if arg_215_1.settingData.show_music_name == 1 then
						arg_215_1.musicController:SetSelectedState("show")
						arg_215_1.musicAnimator_:Play("open", 0, 0)

						if arg_215_1.settingData.music_time ~= 0 then
							arg_215_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_215_1.settingData.music_time), function()
								if arg_215_1 == nil or isNil(arg_215_1.bgmTxt_) then
									return
								end

								arg_215_1.musicController:SetSelectedState("hide")
								arg_215_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_37 = 2
			local var_218_38 = 0.375

			if var_218_37 < arg_215_1.time_ and arg_215_1.time_ <= var_218_37 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_39 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_39:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_215_1.dialogCg_.alpha = arg_220_0
				end))
				var_218_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_40 = arg_215_1:GetWordFromCfg(116431050)
				local var_218_41 = arg_215_1:FormatText(var_218_40.content)

				arg_215_1.text_.text = var_218_41

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_42 = 15
				local var_218_43 = utf8.len(var_218_41)
				local var_218_44 = var_218_42 <= 0 and var_218_38 or var_218_38 * (var_218_43 / var_218_42)

				if var_218_44 > 0 and var_218_38 < var_218_44 then
					arg_215_1.talkMaxDuration = var_218_44
					var_218_37 = var_218_37 + 0.3

					if var_218_44 + var_218_37 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_44 + var_218_37
					end
				end

				arg_215_1.text_.text = var_218_41
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_45 = var_218_37 + 0.3
			local var_218_46 = math.max(var_218_38, arg_215_1.talkMaxDuration)

			if var_218_45 <= arg_215_1.time_ and arg_215_1.time_ < var_218_45 + var_218_46 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_45) / var_218_46

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_45 + var_218_46 and arg_215_1.time_ < var_218_45 + var_218_46 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play116431051 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 116431051
		arg_222_1.duration_ = 5.3

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play116431052(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = "STblack"

			if arg_222_1.bgs_[var_225_0] == nil then
				local var_225_1 = Object.Instantiate(arg_222_1.paintGo_)

				var_225_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_225_0)
				var_225_1.name = var_225_0
				var_225_1.transform.parent = arg_222_1.stage_.transform
				var_225_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.bgs_[var_225_0] = var_225_1
			end

			local var_225_2 = 2

			if var_225_2 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				local var_225_3 = manager.ui.mainCamera.transform.localPosition
				local var_225_4 = Vector3.New(0, 0, 10) + Vector3.New(var_225_3.x, var_225_3.y, 0)
				local var_225_5 = arg_222_1.bgs_.STblack

				var_225_5.transform.localPosition = var_225_4
				var_225_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_6 = var_225_5:GetComponent("SpriteRenderer")

				if var_225_6 and var_225_6.sprite then
					local var_225_7 = (var_225_5.transform.localPosition - var_225_3).z
					local var_225_8 = manager.ui.mainCameraCom_
					local var_225_9 = 2 * var_225_7 * Mathf.Tan(var_225_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_225_10 = var_225_9 * var_225_8.aspect
					local var_225_11 = var_225_6.sprite.bounds.size.x
					local var_225_12 = var_225_6.sprite.bounds.size.y
					local var_225_13 = var_225_10 / var_225_11
					local var_225_14 = var_225_9 / var_225_12
					local var_225_15 = var_225_14 < var_225_13 and var_225_13 or var_225_14

					var_225_5.transform.localScale = Vector3.New(var_225_15, var_225_15, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "STblack" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_17 = 2

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_17 then
				local var_225_18 = (arg_222_1.time_ - var_225_16) / var_225_17
				local var_225_19 = Color.New(0, 0, 0)

				var_225_19.a = Mathf.Lerp(0, 1, var_225_18)
				arg_222_1.mask_.color = var_225_19
			end

			if arg_222_1.time_ >= var_225_16 + var_225_17 and arg_222_1.time_ < var_225_16 + var_225_17 + arg_225_0 then
				local var_225_20 = Color.New(0, 0, 0)

				var_225_20.a = 1
				arg_222_1.mask_.color = var_225_20
			end

			local var_225_21 = 2

			if var_225_21 < arg_222_1.time_ and arg_222_1.time_ <= var_225_21 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_22 = 2

			if var_225_21 <= arg_222_1.time_ and arg_222_1.time_ < var_225_21 + var_225_22 then
				local var_225_23 = (arg_222_1.time_ - var_225_21) / var_225_22
				local var_225_24 = Color.New(0, 0, 0)

				var_225_24.a = Mathf.Lerp(1, 0, var_225_23)
				arg_222_1.mask_.color = var_225_24
			end

			if arg_222_1.time_ >= var_225_21 + var_225_22 and arg_222_1.time_ < var_225_21 + var_225_22 + arg_225_0 then
				local var_225_25 = Color.New(0, 0, 0)
				local var_225_26 = 0

				arg_222_1.mask_.enabled = false
				var_225_25.a = var_225_26
				arg_222_1.mask_.color = var_225_25
			end

			local var_225_27 = 2

			if var_225_27 < arg_222_1.time_ and arg_222_1.time_ <= var_225_27 + arg_225_0 then
				arg_222_1.fswbg_:SetActive(true)
				arg_222_1.dialog_:SetActive(false)

				arg_222_1.fswtw_.percent = 0

				local var_225_28 = arg_222_1:GetWordFromCfg(116431051)
				local var_225_29 = arg_222_1:FormatText(var_225_28.content)

				arg_222_1.fswt_.text = var_225_29

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.fswt_)

				arg_222_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_222_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_222_1.fswtw_:SetDirty()

				arg_222_1.typewritterCharCountI18N = 0

				SetActive(arg_222_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_222_1:ShowNextGo(false)
			end

			local var_225_30 = 2.01666666666667

			if var_225_30 < arg_222_1.time_ and arg_222_1.time_ <= var_225_30 + arg_225_0 then
				arg_222_1.var_.oldValueTypewriter = arg_222_1.fswtw_.percent

				SetActive(arg_222_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_222_1:ShowNextGo(false)
			end

			local var_225_31 = 6
			local var_225_32 = 0.4
			local var_225_33 = arg_222_1:GetWordFromCfg(116431051)
			local var_225_34 = arg_222_1:FormatText(var_225_33.content)
			local var_225_35, var_225_36 = arg_222_1:GetPercentByPara(var_225_34, 1)

			if var_225_30 < arg_222_1.time_ and arg_222_1.time_ <= var_225_30 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				local var_225_37 = var_225_31 <= 0 and var_225_32 or var_225_32 * ((var_225_36 - arg_222_1.typewritterCharCountI18N) / var_225_31)

				if var_225_37 > 0 and var_225_32 < var_225_37 then
					arg_222_1.talkMaxDuration = var_225_37

					if var_225_37 + var_225_30 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_37 + var_225_30
					end
				end
			end

			local var_225_38 = 0.4
			local var_225_39 = math.max(var_225_38, arg_222_1.talkMaxDuration)

			if var_225_30 <= arg_222_1.time_ and arg_222_1.time_ < var_225_30 + var_225_39 then
				local var_225_40 = (arg_222_1.time_ - var_225_30) / var_225_39

				arg_222_1.fswtw_.percent = Mathf.Lerp(arg_222_1.var_.oldValueTypewriter, var_225_35, var_225_40)
				arg_222_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_222_1.fswtw_:SetDirty()
			end

			if arg_222_1.time_ >= var_225_30 + var_225_39 and arg_222_1.time_ < var_225_30 + var_225_39 + arg_225_0 then
				arg_222_1.fswtw_.percent = var_225_35

				arg_222_1.fswtw_:SetDirty()
				arg_222_1:ShowNextGo(true)

				arg_222_1.typewritterCharCountI18N = var_225_36
			end

			local var_225_41 = 2

			if var_225_41 < arg_222_1.time_ and arg_222_1.time_ <= var_225_41 + arg_225_0 then
				local var_225_42 = arg_222_1.fswbg_.transform:Find("textbox/adapt/content") or arg_222_1.fswbg_.transform:Find("textbox/content")
				local var_225_43 = arg_222_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_225_44 = var_225_42:GetComponent("Text")
				local var_225_45 = var_225_42:GetComponent("RectTransform")

				var_225_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_225_45.offsetMin = Vector2.New(0, 0)
				var_225_45.offsetMax = Vector2.New(0, 0)
			end

			local var_225_46 = 2
			local var_225_47 = 2.825
			local var_225_48 = manager.audio:GetVoiceLength("story_v_out_116431", "116431051", "story_v_out_116431.awb") / 1000

			if var_225_48 > 0 and var_225_47 < var_225_48 and var_225_48 + var_225_46 > arg_222_1.duration_ then
				local var_225_49 = var_225_48

				arg_222_1.duration_ = var_225_48 + var_225_46
			end

			if var_225_46 < arg_222_1.time_ and arg_222_1.time_ <= var_225_46 + arg_225_0 then
				local var_225_50 = "play"
				local var_225_51 = "voice"

				arg_222_1:AudioAction(var_225_50, var_225_51, "story_v_out_116431", "116431051", "story_v_out_116431.awb")
			end

			local var_225_52 = 2

			if var_225_52 < arg_222_1.time_ and arg_222_1.time_ <= var_225_52 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			local var_225_53 = 0.416666666666667

			if arg_222_1.time_ >= var_225_52 + var_225_53 and arg_222_1.time_ < var_225_52 + var_225_53 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play116431052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 116431052
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play116431053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.fswbg_:SetActive(false)
				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_226_1:ShowNextGo(false)
			end

			local var_229_1 = 0
			local var_229_2 = 0.075

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_3 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_3:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_4 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_5 = arg_226_1:GetWordFromCfg(116431052)
				local var_229_6 = arg_226_1:FormatText(var_229_5.content)

				arg_226_1.text_.text = var_229_6

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 3
				local var_229_8 = utf8.len(var_229_6)
				local var_229_9 = var_229_7 <= 0 and var_229_2 or var_229_2 * (var_229_8 / var_229_7)

				if var_229_9 > 0 and var_229_2 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9
					var_229_1 = var_229_1 + 0.3

					if var_229_9 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_6
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = var_229_1 + 0.3
			local var_229_11 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_10) / var_229_11

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play116431053 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116431053
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116431054(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.85

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_2 = arg_232_1:GetWordFromCfg(116431053)
				local var_235_3 = arg_232_1:FormatText(var_235_2.content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 34
				local var_235_5 = utf8.len(var_235_3)
				local var_235_6 = var_235_4 <= 0 and var_235_1 or var_235_1 * (var_235_5 / var_235_4)

				if var_235_6 > 0 and var_235_1 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_7 and arg_232_1.time_ < var_235_0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play116431054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116431054
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play116431055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.7

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(116431054)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 28
				local var_239_5 = utf8.len(var_239_3)
				local var_239_6 = var_239_4 <= 0 and var_239_1 or var_239_1 * (var_239_5 / var_239_4)

				if var_239_6 > 0 and var_239_1 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_7 and arg_236_1.time_ < var_239_0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play116431055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 116431055
		arg_240_1.duration_ = 10.01

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play116431056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.fswbg_:SetActive(true)
				arg_240_1.dialog_:SetActive(false)

				arg_240_1.fswtw_.percent = 0

				local var_243_1 = arg_240_1:GetWordFromCfg(116431055)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.fswt_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.fswt_)

				arg_240_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_240_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_240_1.fswtw_:SetDirty()

				arg_240_1.typewritterCharCountI18N = 0

				SetActive(arg_240_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_240_1:ShowNextGo(false)
			end

			local var_243_3 = 0.0166666666666667

			if var_243_3 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.var_.oldValueTypewriter = arg_240_1.fswtw_.percent

				SetActive(arg_240_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_240_1:ShowNextGo(false)
			end

			local var_243_4 = 49
			local var_243_5 = 3.53333333333333
			local var_243_6 = arg_240_1:GetWordFromCfg(116431055)
			local var_243_7 = arg_240_1:FormatText(var_243_6.content)
			local var_243_8, var_243_9 = arg_240_1:GetPercentByPara(var_243_7, 2)

			if var_243_3 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				local var_243_10 = var_243_4 <= 0 and var_243_5 or var_243_5 * ((var_243_9 - arg_240_1.typewritterCharCountI18N) / var_243_4)

				if var_243_10 > 0 and var_243_5 < var_243_10 then
					arg_240_1.talkMaxDuration = var_243_10

					if var_243_10 + var_243_3 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_3
					end
				end
			end

			local var_243_11 = 3.53333333333333
			local var_243_12 = math.max(var_243_11, arg_240_1.talkMaxDuration)

			if var_243_3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_3 + var_243_12 then
				local var_243_13 = (arg_240_1.time_ - var_243_3) / var_243_12

				arg_240_1.fswtw_.percent = Mathf.Lerp(arg_240_1.var_.oldValueTypewriter, var_243_8, var_243_13)
				arg_240_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_240_1.fswtw_:SetDirty()
			end

			if arg_240_1.time_ >= var_243_3 + var_243_12 and arg_240_1.time_ < var_243_3 + var_243_12 + arg_243_0 then
				arg_240_1.fswtw_.percent = var_243_8

				arg_240_1.fswtw_:SetDirty()
				arg_240_1:ShowNextGo(true)

				arg_240_1.typewritterCharCountI18N = var_243_9
			end

			local var_243_14 = 0
			local var_243_15 = 10.011
			local var_243_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431055", "story_v_out_116431.awb") / 1000

			if var_243_16 > 0 and var_243_15 < var_243_16 and var_243_16 + var_243_14 > arg_240_1.duration_ then
				local var_243_17 = var_243_16

				arg_240_1.duration_ = var_243_16 + var_243_14
			end

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				local var_243_18 = "play"
				local var_243_19 = "voice"

				arg_240_1:AudioAction(var_243_18, var_243_19, "story_v_out_116431", "116431055", "story_v_out_116431.awb")
			end

			local var_243_20 = 0

			if var_243_20 < arg_240_1.time_ and arg_240_1.time_ <= var_243_20 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			local var_243_21 = 3.55

			if arg_240_1.time_ >= var_243_20 + var_243_21 and arg_240_1.time_ < var_243_20 + var_243_21 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play116431056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 116431056
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play116431057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.fswbg_:SetActive(false)
				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_244_1:ShowNextGo(false)
			end

			local var_247_1 = 0
			local var_247_2 = 0.25

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_3 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_3:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_4 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_5 = arg_244_1:GetWordFromCfg(116431056)
				local var_247_6 = arg_244_1:FormatText(var_247_5.content)

				arg_244_1.text_.text = var_247_6

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 10
				local var_247_8 = utf8.len(var_247_6)
				local var_247_9 = var_247_7 <= 0 and var_247_2 or var_247_2 * (var_247_8 / var_247_7)

				if var_247_9 > 0 and var_247_2 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9
					var_247_1 = var_247_1 + 0.3

					if var_247_9 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_6
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = var_247_1 + 0.3
			local var_247_11 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_10) / var_247_11

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play116431057 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 116431057
		arg_250_1.duration_ = 9.46

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play116431058(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.fswbg_:SetActive(true)
				arg_250_1.dialog_:SetActive(false)

				arg_250_1.fswtw_.percent = 0

				local var_253_1 = arg_250_1:GetWordFromCfg(116431057)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.fswt_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.fswt_)

				arg_250_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_250_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_250_1.fswtw_:SetDirty()

				arg_250_1.typewritterCharCountI18N = 0

				SetActive(arg_250_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_250_1:ShowNextGo(false)
			end

			local var_253_3 = 0.0166666666666667

			if var_253_3 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.var_.oldValueTypewriter = arg_250_1.fswtw_.percent

				SetActive(arg_250_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_250_1:ShowNextGo(false)
			end

			local var_253_4 = 29
			local var_253_5 = 1.93333333333333
			local var_253_6 = arg_250_1:GetWordFromCfg(116431057)
			local var_253_7 = arg_250_1:FormatText(var_253_6.content)
			local var_253_8, var_253_9 = arg_250_1:GetPercentByPara(var_253_7, 1)

			if var_253_3 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				local var_253_10 = var_253_4 <= 0 and var_253_5 or var_253_5 * ((var_253_9 - arg_250_1.typewritterCharCountI18N) / var_253_4)

				if var_253_10 > 0 and var_253_5 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_3 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_3
					end
				end
			end

			local var_253_11 = 1.93333333333333
			local var_253_12 = math.max(var_253_11, arg_250_1.talkMaxDuration)

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_3) / var_253_12

				arg_250_1.fswtw_.percent = Mathf.Lerp(arg_250_1.var_.oldValueTypewriter, var_253_8, var_253_13)
				arg_250_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_250_1.fswtw_:SetDirty()
			end

			if arg_250_1.time_ >= var_253_3 + var_253_12 and arg_250_1.time_ < var_253_3 + var_253_12 + arg_253_0 then
				arg_250_1.fswtw_.percent = var_253_8

				arg_250_1.fswtw_:SetDirty()
				arg_250_1:ShowNextGo(true)

				arg_250_1.typewritterCharCountI18N = var_253_9
			end

			local var_253_14 = 0
			local var_253_15 = 9.46
			local var_253_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431057", "story_v_out_116431.awb") / 1000

			if var_253_16 > 0 and var_253_15 < var_253_16 and var_253_16 + var_253_14 > arg_250_1.duration_ then
				local var_253_17 = var_253_16

				arg_250_1.duration_ = var_253_16 + var_253_14
			end

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				local var_253_18 = "play"
				local var_253_19 = "voice"

				arg_250_1:AudioAction(var_253_18, var_253_19, "story_v_out_116431", "116431057", "story_v_out_116431.awb")
			end

			local var_253_20 = 0

			if var_253_20 < arg_250_1.time_ and arg_250_1.time_ <= var_253_20 + arg_253_0 then
				arg_250_1.allBtn_.enabled = false
			end

			local var_253_21 = 1.95

			if arg_250_1.time_ >= var_253_20 + var_253_21 and arg_250_1.time_ < var_253_20 + var_253_21 + arg_253_0 then
				arg_250_1.allBtn_.enabled = true
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play116431058 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 116431058
		arg_254_1.duration_ = 8.92

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play116431059(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.var_.oldValueTypewriter = arg_254_1.fswtw_.percent

				SetActive(arg_254_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_254_1:ShowNextGo(false)
			end

			local var_257_1 = 36
			local var_257_2 = 2.4
			local var_257_3 = arg_254_1:GetWordFromCfg(116431057)
			local var_257_4 = arg_254_1:FormatText(var_257_3.content)
			local var_257_5, var_257_6 = arg_254_1:GetPercentByPara(var_257_4, 2)

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0

				local var_257_7 = var_257_1 <= 0 and var_257_2 or var_257_2 * ((var_257_6 - arg_254_1.typewritterCharCountI18N) / var_257_1)

				if var_257_7 > 0 and var_257_2 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end
			end

			local var_257_8 = 2.4
			local var_257_9 = math.max(var_257_8, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_9 then
				local var_257_10 = (arg_254_1.time_ - var_257_0) / var_257_9

				arg_254_1.fswtw_.percent = Mathf.Lerp(arg_254_1.var_.oldValueTypewriter, var_257_5, var_257_10)
				arg_254_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_254_1.fswtw_:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_9 and arg_254_1.time_ < var_257_0 + var_257_9 + arg_257_0 then
				arg_254_1.fswtw_.percent = var_257_5

				arg_254_1.fswtw_:SetDirty()
				arg_254_1:ShowNextGo(true)

				arg_254_1.typewritterCharCountI18N = var_257_6
			end

			local var_257_11 = 0
			local var_257_12 = 8.918
			local var_257_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431058", "story_v_out_116431.awb") / 1000

			if var_257_13 > 0 and var_257_12 < var_257_13 and var_257_13 + var_257_11 > arg_254_1.duration_ then
				local var_257_14 = var_257_13

				arg_254_1.duration_ = var_257_13 + var_257_11
			end

			if var_257_11 < arg_254_1.time_ and arg_254_1.time_ <= var_257_11 + arg_257_0 then
				local var_257_15 = "play"
				local var_257_16 = "voice"

				arg_254_1:AudioAction(var_257_15, var_257_16, "story_v_out_116431", "116431058", "story_v_out_116431.awb")
			end

			local var_257_17 = 0

			if var_257_17 < arg_254_1.time_ and arg_254_1.time_ <= var_257_17 + arg_257_0 then
				arg_254_1.allBtn_.enabled = false
			end

			local var_257_18 = 2.4

			if arg_254_1.time_ >= var_257_17 + var_257_18 and arg_254_1.time_ < var_257_17 + var_257_18 + arg_257_0 then
				arg_254_1.allBtn_.enabled = true
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play116431059 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 116431059
		arg_258_1.duration_ = 9.93

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play116431060(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.var_.oldValueTypewriter = arg_258_1.fswtw_.percent

				SetActive(arg_258_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_258_1:ShowNextGo(false)
			end

			local var_261_1 = 41
			local var_261_2 = 2.73333333333333
			local var_261_3 = arg_258_1:GetWordFromCfg(116431057)
			local var_261_4 = arg_258_1:FormatText(var_261_3.content)
			local var_261_5, var_261_6 = arg_258_1:GetPercentByPara(var_261_4, 3)

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				local var_261_7 = var_261_1 <= 0 and var_261_2 or var_261_2 * ((var_261_6 - arg_258_1.typewritterCharCountI18N) / var_261_1)

				if var_261_7 > 0 and var_261_2 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end
			end

			local var_261_8 = 2.73333333333333
			local var_261_9 = math.max(var_261_8, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_9 then
				local var_261_10 = (arg_258_1.time_ - var_261_0) / var_261_9

				arg_258_1.fswtw_.percent = Mathf.Lerp(arg_258_1.var_.oldValueTypewriter, var_261_5, var_261_10)
				arg_258_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_258_1.fswtw_:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_9 and arg_258_1.time_ < var_261_0 + var_261_9 + arg_261_0 then
				arg_258_1.fswtw_.percent = var_261_5

				arg_258_1.fswtw_:SetDirty()
				arg_258_1:ShowNextGo(true)

				arg_258_1.typewritterCharCountI18N = var_261_6
			end

			local var_261_11 = 0
			local var_261_12 = 9.933
			local var_261_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431059", "story_v_out_116431.awb") / 1000

			if var_261_13 > 0 and var_261_12 < var_261_13 and var_261_13 + var_261_11 > arg_258_1.duration_ then
				local var_261_14 = var_261_13

				arg_258_1.duration_ = var_261_13 + var_261_11
			end

			if var_261_11 < arg_258_1.time_ and arg_258_1.time_ <= var_261_11 + arg_261_0 then
				local var_261_15 = "play"
				local var_261_16 = "voice"

				arg_258_1:AudioAction(var_261_15, var_261_16, "story_v_out_116431", "116431059", "story_v_out_116431.awb")
			end

			local var_261_17 = 0

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			local var_261_18 = 2.73333333333333

			if arg_258_1.time_ >= var_261_17 + var_261_18 and arg_258_1.time_ < var_261_17 + var_261_18 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play116431060 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 116431060
		arg_262_1.duration_ = 5.03

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play116431061(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.var_.oldValueTypewriter = arg_262_1.fswtw_.percent

				SetActive(arg_262_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_262_1:ShowNextGo(false)
			end

			local var_265_1 = 12
			local var_265_2 = 0.8
			local var_265_3 = arg_262_1:GetWordFromCfg(116431057)
			local var_265_4 = arg_262_1:FormatText(var_265_3.content)
			local var_265_5, var_265_6 = arg_262_1:GetPercentByPara(var_265_4, 4)

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				local var_265_7 = var_265_1 <= 0 and var_265_2 or var_265_2 * ((var_265_6 - arg_262_1.typewritterCharCountI18N) / var_265_1)

				if var_265_7 > 0 and var_265_2 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end
			end

			local var_265_8 = 0.8
			local var_265_9 = math.max(var_265_8, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_9 then
				local var_265_10 = (arg_262_1.time_ - var_265_0) / var_265_9

				arg_262_1.fswtw_.percent = Mathf.Lerp(arg_262_1.var_.oldValueTypewriter, var_265_5, var_265_10)
				arg_262_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_262_1.fswtw_:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_9 and arg_262_1.time_ < var_265_0 + var_265_9 + arg_265_0 then
				arg_262_1.fswtw_.percent = var_265_5

				arg_262_1.fswtw_:SetDirty()
				arg_262_1:ShowNextGo(true)

				arg_262_1.typewritterCharCountI18N = var_265_6
			end

			local var_265_11 = 0
			local var_265_12 = 5.029
			local var_265_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431060", "story_v_out_116431.awb") / 1000

			if var_265_13 > 0 and var_265_12 < var_265_13 and var_265_13 + var_265_11 > arg_262_1.duration_ then
				local var_265_14 = var_265_13

				arg_262_1.duration_ = var_265_13 + var_265_11
			end

			if var_265_11 < arg_262_1.time_ and arg_262_1.time_ <= var_265_11 + arg_265_0 then
				local var_265_15 = "play"
				local var_265_16 = "voice"

				arg_262_1:AudioAction(var_265_15, var_265_16, "story_v_out_116431", "116431060", "story_v_out_116431.awb")
			end

			local var_265_17 = 0

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			local var_265_18 = 0.8

			if arg_262_1.time_ >= var_265_17 + var_265_18 and arg_262_1.time_ < var_265_17 + var_265_18 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play116431061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 116431061
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play116431062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.fswbg_:SetActive(false)
				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_266_1:ShowNextGo(false)
			end

			local var_269_1 = 0
			local var_269_2 = 0.275

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0

				arg_266_1.dialog_:SetActive(true)

				arg_266_1.dialogCg_.alpha = 0

				local var_269_3 = LeanTween.value(arg_266_1.dialog_, 0, 1, 0.3)

				var_269_3:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_266_1.dialogCg_.alpha = arg_270_0
				end))
				var_269_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_266_1.dialog_)
					var_269_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_266_1.duration_ = arg_266_1.duration_ + 0.3

				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_4 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_5 = arg_266_1:GetWordFromCfg(116431061)
				local var_269_6 = arg_266_1:FormatText(var_269_5.content)

				arg_266_1.text_.text = var_269_6

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 11
				local var_269_8 = utf8.len(var_269_6)
				local var_269_9 = var_269_7 <= 0 and var_269_2 or var_269_2 * (var_269_8 / var_269_7)

				if var_269_9 > 0 and var_269_2 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9
					var_269_1 = var_269_1 + 0.3

					if var_269_9 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_6
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = var_269_1 + 0.3
			local var_269_11 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_10) / var_269_11

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play116431062 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 116431062
		arg_272_1.duration_ = 9.26

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play116431063(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.fswbg_:SetActive(true)
				arg_272_1.dialog_:SetActive(false)

				arg_272_1.fswtw_.percent = 0

				local var_275_1 = arg_272_1:GetWordFromCfg(116431062)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.fswt_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.fswt_)

				arg_272_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_272_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_272_1.fswtw_:SetDirty()

				arg_272_1.typewritterCharCountI18N = 0

				SetActive(arg_272_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_272_1:ShowNextGo(false)
			end

			local var_275_3 = 0.0166666666666667

			if var_275_3 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.var_.oldValueTypewriter = arg_272_1.fswtw_.percent

				SetActive(arg_272_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_272_1:ShowNextGo(false)
			end

			local var_275_4 = 36
			local var_275_5 = 2.4
			local var_275_6 = arg_272_1:GetWordFromCfg(116431062)
			local var_275_7 = arg_272_1:FormatText(var_275_6.content)
			local var_275_8, var_275_9 = arg_272_1:GetPercentByPara(var_275_7, 1)

			if var_275_3 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0

				local var_275_10 = var_275_4 <= 0 and var_275_5 or var_275_5 * ((var_275_9 - arg_272_1.typewritterCharCountI18N) / var_275_4)

				if var_275_10 > 0 and var_275_5 < var_275_10 then
					arg_272_1.talkMaxDuration = var_275_10

					if var_275_10 + var_275_3 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_3
					end
				end
			end

			local var_275_11 = 2.4
			local var_275_12 = math.max(var_275_11, arg_272_1.talkMaxDuration)

			if var_275_3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_3 + var_275_12 then
				local var_275_13 = (arg_272_1.time_ - var_275_3) / var_275_12

				arg_272_1.fswtw_.percent = Mathf.Lerp(arg_272_1.var_.oldValueTypewriter, var_275_8, var_275_13)
				arg_272_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_272_1.fswtw_:SetDirty()
			end

			if arg_272_1.time_ >= var_275_3 + var_275_12 and arg_272_1.time_ < var_275_3 + var_275_12 + arg_275_0 then
				arg_272_1.fswtw_.percent = var_275_8

				arg_272_1.fswtw_:SetDirty()
				arg_272_1:ShowNextGo(true)

				arg_272_1.typewritterCharCountI18N = var_275_9
			end

			local var_275_14 = 0
			local var_275_15 = 9.259
			local var_275_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431062", "story_v_out_116431.awb") / 1000

			if var_275_16 > 0 and var_275_15 < var_275_16 and var_275_16 + var_275_14 > arg_272_1.duration_ then
				local var_275_17 = var_275_16

				arg_272_1.duration_ = var_275_16 + var_275_14
			end

			if var_275_14 < arg_272_1.time_ and arg_272_1.time_ <= var_275_14 + arg_275_0 then
				local var_275_18 = "play"
				local var_275_19 = "voice"

				arg_272_1:AudioAction(var_275_18, var_275_19, "story_v_out_116431", "116431062", "story_v_out_116431.awb")
			end

			local var_275_20 = 0

			if var_275_20 < arg_272_1.time_ and arg_272_1.time_ <= var_275_20 + arg_275_0 then
				arg_272_1.allBtn_.enabled = false
			end

			local var_275_21 = 2.41666666666667

			if arg_272_1.time_ >= var_275_20 + var_275_21 and arg_272_1.time_ < var_275_20 + var_275_21 + arg_275_0 then
				arg_272_1.allBtn_.enabled = true
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play116431063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 116431063
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play116431064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.fswbg_:SetActive(false)
				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_276_1:ShowNextGo(false)
			end

			local var_279_1 = 0
			local var_279_2 = 0.325

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_3 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_3:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_4 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_5 = arg_276_1:GetWordFromCfg(116431063)
				local var_279_6 = arg_276_1:FormatText(var_279_5.content)

				arg_276_1.text_.text = var_279_6

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 13
				local var_279_8 = utf8.len(var_279_6)
				local var_279_9 = var_279_7 <= 0 and var_279_2 or var_279_2 * (var_279_8 / var_279_7)

				if var_279_9 > 0 and var_279_2 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9
					var_279_1 = var_279_1 + 0.3

					if var_279_9 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_6
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = var_279_1 + 0.3
			local var_279_11 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_10) / var_279_11

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play116431064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 116431064
		arg_282_1.duration_ = 1.57

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play116431065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(true)
				arg_282_1.dialog_:SetActive(false)

				arg_282_1.fswtw_.percent = 0

				local var_285_1 = arg_282_1:GetWordFromCfg(116431064)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.fswt_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.fswt_)

				arg_282_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_282_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_282_1.fswtw_:SetDirty()

				arg_282_1.typewritterCharCountI18N = 0

				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_3 = 0.0166666666666666

			if var_285_3 < arg_282_1.time_ and arg_282_1.time_ <= var_285_3 + arg_285_0 then
				arg_282_1.var_.oldValueTypewriter = arg_282_1.fswtw_.percent

				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_282_1:ShowNextGo(false)
			end

			local var_285_4 = 4
			local var_285_5 = 0.266666666666667
			local var_285_6 = arg_282_1:GetWordFromCfg(116431064)
			local var_285_7 = arg_282_1:FormatText(var_285_6.content)
			local var_285_8, var_285_9 = arg_282_1:GetPercentByPara(var_285_7, 1)

			if var_285_3 < arg_282_1.time_ and arg_282_1.time_ <= var_285_3 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				local var_285_10 = var_285_4 <= 0 and var_285_5 or var_285_5 * ((var_285_9 - arg_282_1.typewritterCharCountI18N) / var_285_4)

				if var_285_10 > 0 and var_285_5 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_3 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_3
					end
				end
			end

			local var_285_11 = 0.266666666666667
			local var_285_12 = math.max(var_285_11, arg_282_1.talkMaxDuration)

			if var_285_3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_3 + var_285_12 then
				local var_285_13 = (arg_282_1.time_ - var_285_3) / var_285_12

				arg_282_1.fswtw_.percent = Mathf.Lerp(arg_282_1.var_.oldValueTypewriter, var_285_8, var_285_13)
				arg_282_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_282_1.fswtw_:SetDirty()
			end

			if arg_282_1.time_ >= var_285_3 + var_285_12 and arg_282_1.time_ < var_285_3 + var_285_12 + arg_285_0 then
				arg_282_1.fswtw_.percent = var_285_8

				arg_282_1.fswtw_:SetDirty()
				arg_282_1:ShowNextGo(true)

				arg_282_1.typewritterCharCountI18N = var_285_9
			end

			local var_285_14 = 0
			local var_285_15 = 1.573
			local var_285_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431064", "story_v_out_116431.awb") / 1000

			if var_285_16 > 0 and var_285_15 < var_285_16 and var_285_16 + var_285_14 > arg_282_1.duration_ then
				local var_285_17 = var_285_16

				arg_282_1.duration_ = var_285_16 + var_285_14
			end

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 then
				local var_285_18 = "play"
				local var_285_19 = "voice"

				arg_282_1:AudioAction(var_285_18, var_285_19, "story_v_out_116431", "116431064", "story_v_out_116431.awb")
			end

			local var_285_20 = 0

			if var_285_20 < arg_282_1.time_ and arg_282_1.time_ <= var_285_20 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			local var_285_21 = 0.283333333333333

			if arg_282_1.time_ >= var_285_20 + var_285_21 and arg_282_1.time_ < var_285_20 + var_285_21 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play116431065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 116431065
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play116431066(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.fswbg_:SetActive(false)
				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_1 = 0
			local var_289_2 = 0.25

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_3 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_3:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_4 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_5 = arg_286_1:GetWordFromCfg(116431065)
				local var_289_6 = arg_286_1:FormatText(var_289_5.content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 10
				local var_289_8 = utf8.len(var_289_6)
				local var_289_9 = var_289_7 <= 0 and var_289_2 or var_289_2 * (var_289_8 / var_289_7)

				if var_289_9 > 0 and var_289_2 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9
					var_289_1 = var_289_1 + 0.3

					if var_289_9 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = var_289_1 + 0.3
			local var_289_11 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_10 <= arg_286_1.time_ and arg_286_1.time_ < var_289_10 + var_289_11 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_10) / var_289_11

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_10 + var_289_11 and arg_286_1.time_ < var_289_10 + var_289_11 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play116431066 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 116431066
		arg_292_1.duration_ = 15.53

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play116431067(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.fswbg_:SetActive(true)
				arg_292_1.dialog_:SetActive(false)

				arg_292_1.fswtw_.percent = 0

				local var_295_1 = arg_292_1:GetWordFromCfg(116431066)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.fswt_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.fswt_)

				arg_292_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_292_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_292_1.fswtw_:SetDirty()

				arg_292_1.typewritterCharCountI18N = 0

				SetActive(arg_292_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_292_1:ShowNextGo(false)
			end

			local var_295_3 = 0.0166666666666667

			if var_295_3 < arg_292_1.time_ and arg_292_1.time_ <= var_295_3 + arg_295_0 then
				arg_292_1.var_.oldValueTypewriter = arg_292_1.fswtw_.percent

				SetActive(arg_292_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_292_1:ShowNextGo(false)
			end

			local var_295_4 = 63
			local var_295_5 = 4.2
			local var_295_6 = arg_292_1:GetWordFromCfg(116431066)
			local var_295_7 = arg_292_1:FormatText(var_295_6.content)
			local var_295_8, var_295_9 = arg_292_1:GetPercentByPara(var_295_7, 2)

			if var_295_3 < arg_292_1.time_ and arg_292_1.time_ <= var_295_3 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				local var_295_10 = var_295_4 <= 0 and var_295_5 or var_295_5 * ((var_295_9 - arg_292_1.typewritterCharCountI18N) / var_295_4)

				if var_295_10 > 0 and var_295_5 < var_295_10 then
					arg_292_1.talkMaxDuration = var_295_10

					if var_295_10 + var_295_3 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_3
					end
				end
			end

			local var_295_11 = 4.2
			local var_295_12 = math.max(var_295_11, arg_292_1.talkMaxDuration)

			if var_295_3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_3 + var_295_12 then
				local var_295_13 = (arg_292_1.time_ - var_295_3) / var_295_12

				arg_292_1.fswtw_.percent = Mathf.Lerp(arg_292_1.var_.oldValueTypewriter, var_295_8, var_295_13)
				arg_292_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_292_1.fswtw_:SetDirty()
			end

			if arg_292_1.time_ >= var_295_3 + var_295_12 and arg_292_1.time_ < var_295_3 + var_295_12 + arg_295_0 then
				arg_292_1.fswtw_.percent = var_295_8

				arg_292_1.fswtw_:SetDirty()
				arg_292_1:ShowNextGo(true)

				arg_292_1.typewritterCharCountI18N = var_295_9
			end

			local var_295_14 = 0
			local var_295_15 = 15.533
			local var_295_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431066", "story_v_out_116431.awb") / 1000

			if var_295_16 > 0 and var_295_15 < var_295_16 and var_295_16 + var_295_14 > arg_292_1.duration_ then
				local var_295_17 = var_295_16

				arg_292_1.duration_ = var_295_16 + var_295_14
			end

			if var_295_14 < arg_292_1.time_ and arg_292_1.time_ <= var_295_14 + arg_295_0 then
				local var_295_18 = "play"
				local var_295_19 = "voice"

				arg_292_1:AudioAction(var_295_18, var_295_19, "story_v_out_116431", "116431066", "story_v_out_116431.awb")
			end

			local var_295_20 = 0

			if var_295_20 < arg_292_1.time_ and arg_292_1.time_ <= var_295_20 + arg_295_0 then
				arg_292_1.allBtn_.enabled = false
			end

			local var_295_21 = 4.21666666666667

			if arg_292_1.time_ >= var_295_20 + var_295_21 and arg_292_1.time_ < var_295_20 + var_295_21 + arg_295_0 then
				arg_292_1.allBtn_.enabled = true
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play116431067 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 116431067
		arg_296_1.duration_ = 5.78

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play116431068(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.var_.oldValueTypewriter = arg_296_1.fswtw_.percent

				SetActive(arg_296_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_296_1:ShowNextGo(false)
			end

			local var_299_1 = 22
			local var_299_2 = 1.46666666666667
			local var_299_3 = arg_296_1:GetWordFromCfg(116431066)
			local var_299_4 = arg_296_1:FormatText(var_299_3.content)
			local var_299_5, var_299_6 = arg_296_1:GetPercentByPara(var_299_4, 3)

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				local var_299_7 = var_299_1 <= 0 and var_299_2 or var_299_2 * ((var_299_6 - arg_296_1.typewritterCharCountI18N) / var_299_1)

				if var_299_7 > 0 and var_299_2 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end
			end

			local var_299_8 = 1.46666666666667
			local var_299_9 = math.max(var_299_8, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_9 then
				local var_299_10 = (arg_296_1.time_ - var_299_0) / var_299_9

				arg_296_1.fswtw_.percent = Mathf.Lerp(arg_296_1.var_.oldValueTypewriter, var_299_5, var_299_10)
				arg_296_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_296_1.fswtw_:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_9 and arg_296_1.time_ < var_299_0 + var_299_9 + arg_299_0 then
				arg_296_1.fswtw_.percent = var_299_5

				arg_296_1.fswtw_:SetDirty()
				arg_296_1:ShowNextGo(true)

				arg_296_1.typewritterCharCountI18N = var_299_6
			end

			local var_299_11 = 0
			local var_299_12 = 5.776
			local var_299_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431067", "story_v_out_116431.awb") / 1000

			if var_299_13 > 0 and var_299_12 < var_299_13 and var_299_13 + var_299_11 > arg_296_1.duration_ then
				local var_299_14 = var_299_13

				arg_296_1.duration_ = var_299_13 + var_299_11
			end

			if var_299_11 < arg_296_1.time_ and arg_296_1.time_ <= var_299_11 + arg_299_0 then
				local var_299_15 = "play"
				local var_299_16 = "voice"

				arg_296_1:AudioAction(var_299_15, var_299_16, "story_v_out_116431", "116431067", "story_v_out_116431.awb")
			end

			local var_299_17 = 0

			if var_299_17 < arg_296_1.time_ and arg_296_1.time_ <= var_299_17 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			local var_299_18 = 1.46666666666667

			if arg_296_1.time_ >= var_299_17 + var_299_18 and arg_296_1.time_ < var_299_17 + var_299_18 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play116431068 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 116431068
		arg_300_1.duration_ = 4.68

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play116431069(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.var_.oldValueTypewriter = arg_300_1.fswtw_.percent

				SetActive(arg_300_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_300_1:ShowNextGo(false)
			end

			local var_303_1 = 19
			local var_303_2 = 1.26666666666667
			local var_303_3 = arg_300_1:GetWordFromCfg(116431066)
			local var_303_4 = arg_300_1:FormatText(var_303_3.content)
			local var_303_5, var_303_6 = arg_300_1:GetPercentByPara(var_303_4, 4)

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				local var_303_7 = var_303_1 <= 0 and var_303_2 or var_303_2 * ((var_303_6 - arg_300_1.typewritterCharCountI18N) / var_303_1)

				if var_303_7 > 0 and var_303_2 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end
			end

			local var_303_8 = 1.26666666666667
			local var_303_9 = math.max(var_303_8, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_9 then
				local var_303_10 = (arg_300_1.time_ - var_303_0) / var_303_9

				arg_300_1.fswtw_.percent = Mathf.Lerp(arg_300_1.var_.oldValueTypewriter, var_303_5, var_303_10)
				arg_300_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_300_1.fswtw_:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_9 and arg_300_1.time_ < var_303_0 + var_303_9 + arg_303_0 then
				arg_300_1.fswtw_.percent = var_303_5

				arg_300_1.fswtw_:SetDirty()
				arg_300_1:ShowNextGo(true)

				arg_300_1.typewritterCharCountI18N = var_303_6
			end

			local var_303_11 = 0
			local var_303_12 = 4.677
			local var_303_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431068", "story_v_out_116431.awb") / 1000

			if var_303_13 > 0 and var_303_12 < var_303_13 and var_303_13 + var_303_11 > arg_300_1.duration_ then
				local var_303_14 = var_303_13

				arg_300_1.duration_ = var_303_13 + var_303_11
			end

			if var_303_11 < arg_300_1.time_ and arg_300_1.time_ <= var_303_11 + arg_303_0 then
				local var_303_15 = "play"
				local var_303_16 = "voice"

				arg_300_1:AudioAction(var_303_15, var_303_16, "story_v_out_116431", "116431068", "story_v_out_116431.awb")
			end

			local var_303_17 = 0

			if var_303_17 < arg_300_1.time_ and arg_300_1.time_ <= var_303_17 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			local var_303_18 = 1.26666666666667

			if arg_300_1.time_ >= var_303_17 + var_303_18 and arg_300_1.time_ < var_303_17 + var_303_18 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play116431069 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 116431069
		arg_304_1.duration_ = 10.62

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play116431070(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.var_.oldValueTypewriter = arg_304_1.fswtw_.percent

				SetActive(arg_304_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_304_1:ShowNextGo(false)
			end

			local var_307_1 = 45
			local var_307_2 = 3
			local var_307_3 = arg_304_1:GetWordFromCfg(116431066)
			local var_307_4 = arg_304_1:FormatText(var_307_3.content)
			local var_307_5, var_307_6 = arg_304_1:GetPercentByPara(var_307_4, 5)

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				local var_307_7 = var_307_1 <= 0 and var_307_2 or var_307_2 * ((var_307_6 - arg_304_1.typewritterCharCountI18N) / var_307_1)

				if var_307_7 > 0 and var_307_2 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end
			end

			local var_307_8 = 3
			local var_307_9 = math.max(var_307_8, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_9 then
				local var_307_10 = (arg_304_1.time_ - var_307_0) / var_307_9

				arg_304_1.fswtw_.percent = Mathf.Lerp(arg_304_1.var_.oldValueTypewriter, var_307_5, var_307_10)
				arg_304_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_304_1.fswtw_:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_9 and arg_304_1.time_ < var_307_0 + var_307_9 + arg_307_0 then
				arg_304_1.fswtw_.percent = var_307_5

				arg_304_1.fswtw_:SetDirty()
				arg_304_1:ShowNextGo(true)

				arg_304_1.typewritterCharCountI18N = var_307_6
			end

			local var_307_11 = 0
			local var_307_12 = 10.619
			local var_307_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431069", "story_v_out_116431.awb") / 1000

			if var_307_13 > 0 and var_307_12 < var_307_13 and var_307_13 + var_307_11 > arg_304_1.duration_ then
				local var_307_14 = var_307_13

				arg_304_1.duration_ = var_307_13 + var_307_11
			end

			if var_307_11 < arg_304_1.time_ and arg_304_1.time_ <= var_307_11 + arg_307_0 then
				local var_307_15 = "play"
				local var_307_16 = "voice"

				arg_304_1:AudioAction(var_307_15, var_307_16, "story_v_out_116431", "116431069", "story_v_out_116431.awb")
			end

			local var_307_17 = 0

			if var_307_17 < arg_304_1.time_ and arg_304_1.time_ <= var_307_17 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			local var_307_18 = 3

			if arg_304_1.time_ >= var_307_17 + var_307_18 and arg_304_1.time_ < var_307_17 + var_307_18 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play116431070 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 116431070
		arg_308_1.duration_ = 0.02

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"

			SetActive(arg_308_1.choicesGo_, true)

			for iter_309_0, iter_309_1 in ipairs(arg_308_1.choices_) do
				local var_309_0 = iter_309_0 <= 1

				SetActive(iter_309_1.go, var_309_0)
			end

			arg_308_1.choices_[1].txt.text = arg_308_1:FormatText(StoryChoiceCfg[275].name)
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play116431071(arg_308_1)
			end

			arg_308_1:RecordChoiceLog(116431070, 275)
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			return
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play116431071 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 116431071
		arg_312_1.duration_ = 5.76

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play116431072(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(true)
				arg_312_1.dialog_:SetActive(false)

				arg_312_1.fswtw_.percent = 0

				local var_315_1 = arg_312_1:GetWordFromCfg(116431071)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.fswt_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.fswt_)

				arg_312_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_312_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_312_1.fswtw_:SetDirty()

				arg_312_1.typewritterCharCountI18N = 0

				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_3 = 0.0166666666666667

			if var_315_3 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.var_.oldValueTypewriter = arg_312_1.fswtw_.percent

				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_4 = 17
			local var_315_5 = 1.13333333333333
			local var_315_6 = arg_312_1:GetWordFromCfg(116431071)
			local var_315_7 = arg_312_1:FormatText(var_315_6.content)
			local var_315_8, var_315_9 = arg_312_1:GetPercentByPara(var_315_7, 1)

			if var_315_3 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				local var_315_10 = var_315_4 <= 0 and var_315_5 or var_315_5 * ((var_315_9 - arg_312_1.typewritterCharCountI18N) / var_315_4)

				if var_315_10 > 0 and var_315_5 < var_315_10 then
					arg_312_1.talkMaxDuration = var_315_10

					if var_315_10 + var_315_3 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_3
					end
				end
			end

			local var_315_11 = 1.13333333333333
			local var_315_12 = math.max(var_315_11, arg_312_1.talkMaxDuration)

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_3) / var_315_12

				arg_312_1.fswtw_.percent = Mathf.Lerp(arg_312_1.var_.oldValueTypewriter, var_315_8, var_315_13)
				arg_312_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_312_1.fswtw_:SetDirty()
			end

			if arg_312_1.time_ >= var_315_3 + var_315_12 and arg_312_1.time_ < var_315_3 + var_315_12 + arg_315_0 then
				arg_312_1.fswtw_.percent = var_315_8

				arg_312_1.fswtw_:SetDirty()
				arg_312_1:ShowNextGo(true)

				arg_312_1.typewritterCharCountI18N = var_315_9
			end

			local var_315_14 = 0
			local var_315_15 = 5.756
			local var_315_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431071", "story_v_out_116431.awb") / 1000

			if var_315_16 > 0 and var_315_15 < var_315_16 and var_315_16 + var_315_14 > arg_312_1.duration_ then
				local var_315_17 = var_315_16

				arg_312_1.duration_ = var_315_16 + var_315_14
			end

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				local var_315_18 = "play"
				local var_315_19 = "voice"

				arg_312_1:AudioAction(var_315_18, var_315_19, "story_v_out_116431", "116431071", "story_v_out_116431.awb")
			end

			local var_315_20 = 0

			if var_315_20 < arg_312_1.time_ and arg_312_1.time_ <= var_315_20 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			local var_315_21 = 1.15

			if arg_312_1.time_ >= var_315_20 + var_315_21 and arg_312_1.time_ < var_315_20 + var_315_21 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play116431072 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 116431072
		arg_316_1.duration_ = 9

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play116431073(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = "A00"

			if arg_316_1.bgs_[var_319_0] == nil then
				local var_319_1 = Object.Instantiate(arg_316_1.paintGo_)

				var_319_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_319_0)
				var_319_1.name = var_319_0
				var_319_1.transform.parent = arg_316_1.stage_.transform
				var_319_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.bgs_[var_319_0] = var_319_1
			end

			local var_319_2 = 2

			if var_319_2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				local var_319_3 = manager.ui.mainCamera.transform.localPosition
				local var_319_4 = Vector3.New(0, 0, 10) + Vector3.New(var_319_3.x, var_319_3.y, 0)
				local var_319_5 = arg_316_1.bgs_.A00

				var_319_5.transform.localPosition = var_319_4
				var_319_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_6 = var_319_5:GetComponent("SpriteRenderer")

				if var_319_6 and var_319_6.sprite then
					local var_319_7 = (var_319_5.transform.localPosition - var_319_3).z
					local var_319_8 = manager.ui.mainCameraCom_
					local var_319_9 = 2 * var_319_7 * Mathf.Tan(var_319_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_319_10 = var_319_9 * var_319_8.aspect
					local var_319_11 = var_319_6.sprite.bounds.size.x
					local var_319_12 = var_319_6.sprite.bounds.size.y
					local var_319_13 = var_319_10 / var_319_11
					local var_319_14 = var_319_9 / var_319_12
					local var_319_15 = var_319_14 < var_319_13 and var_319_13 or var_319_14

					var_319_5.transform.localScale = Vector3.New(var_319_15, var_319_15, 0)
				end

				for iter_319_0, iter_319_1 in pairs(arg_316_1.bgs_) do
					if iter_319_0 ~= "A00" then
						iter_319_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_17 = 2

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 then
				local var_319_18 = (arg_316_1.time_ - var_319_16) / var_319_17
				local var_319_19 = Color.New(0, 0, 0)

				var_319_19.a = Mathf.Lerp(0, 1, var_319_18)
				arg_316_1.mask_.color = var_319_19
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				local var_319_20 = Color.New(0, 0, 0)

				var_319_20.a = 1
				arg_316_1.mask_.color = var_319_20
			end

			local var_319_21 = 2

			if var_319_21 < arg_316_1.time_ and arg_316_1.time_ <= var_319_21 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_22 = 2

			if var_319_21 <= arg_316_1.time_ and arg_316_1.time_ < var_319_21 + var_319_22 then
				local var_319_23 = (arg_316_1.time_ - var_319_21) / var_319_22
				local var_319_24 = Color.New(0, 0, 0)

				var_319_24.a = Mathf.Lerp(1, 0, var_319_23)
				arg_316_1.mask_.color = var_319_24
			end

			if arg_316_1.time_ >= var_319_21 + var_319_22 and arg_316_1.time_ < var_319_21 + var_319_22 + arg_319_0 then
				local var_319_25 = Color.New(0, 0, 0)
				local var_319_26 = 0

				arg_316_1.mask_.enabled = false
				var_319_25.a = var_319_26
				arg_316_1.mask_.color = var_319_25
			end

			local var_319_27 = 2

			if var_319_27 < arg_316_1.time_ and arg_316_1.time_ <= var_319_27 + arg_319_0 then
				arg_316_1.fswbg_:SetActive(false)
				arg_316_1.dialog_:SetActive(false)
				SetActive(arg_316_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_316_1:ShowNextGo(false)
			end

			local var_319_28 = 0
			local var_319_29 = 0.666666666666667

			if var_319_28 < arg_316_1.time_ and arg_316_1.time_ <= var_319_28 + arg_319_0 then
				local var_319_30 = "play"
				local var_319_31 = "music"

				arg_316_1:AudioAction(var_319_30, var_319_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_319_32 = ""
				local var_319_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_319_33 ~= "" then
					if arg_316_1.bgmTxt_.text ~= var_319_33 and arg_316_1.bgmTxt_.text ~= "" then
						if arg_316_1.bgmTxt2_.text ~= "" then
							arg_316_1.bgmTxt_.text = arg_316_1.bgmTxt2_.text
						end

						arg_316_1.bgmTxt2_.text = var_319_33

						arg_316_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_316_1.bgmTxt_.text = var_319_33
						arg_316_1.bgmTxt2_.text = var_319_33
					end

					if arg_316_1.bgmTimer then
						arg_316_1.bgmTimer:Stop()

						arg_316_1.bgmTimer = nil
					end

					if arg_316_1.settingData.show_music_name == 1 then
						arg_316_1.musicController:SetSelectedState("show")
						arg_316_1.musicAnimator_:Play("open", 0, 0)

						if arg_316_1.settingData.music_time ~= 0 then
							arg_316_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_316_1.settingData.music_time), function()
								if arg_316_1 == nil or isNil(arg_316_1.bgmTxt_) then
									return
								end

								arg_316_1.musicController:SetSelectedState("hide")
								arg_316_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_319_34 = 0.866666666666667
			local var_319_35 = 1.13333333333333

			if var_319_34 < arg_316_1.time_ and arg_316_1.time_ <= var_319_34 + arg_319_0 then
				local var_319_36 = "play"
				local var_319_37 = "music"

				arg_316_1:AudioAction(var_319_36, var_319_37, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_319_38 = ""
				local var_319_39 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_319_39 ~= "" then
					if arg_316_1.bgmTxt_.text ~= var_319_39 and arg_316_1.bgmTxt_.text ~= "" then
						if arg_316_1.bgmTxt2_.text ~= "" then
							arg_316_1.bgmTxt_.text = arg_316_1.bgmTxt2_.text
						end

						arg_316_1.bgmTxt2_.text = var_319_39

						arg_316_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_316_1.bgmTxt_.text = var_319_39
						arg_316_1.bgmTxt2_.text = var_319_39
					end

					if arg_316_1.bgmTimer then
						arg_316_1.bgmTimer:Stop()

						arg_316_1.bgmTimer = nil
					end

					if arg_316_1.settingData.show_music_name == 1 then
						arg_316_1.musicController:SetSelectedState("show")
						arg_316_1.musicAnimator_:Play("open", 0, 0)

						if arg_316_1.settingData.music_time ~= 0 then
							arg_316_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_316_1.settingData.music_time), function()
								if arg_316_1 == nil or isNil(arg_316_1.bgmTxt_) then
									return
								end

								arg_316_1.musicController:SetSelectedState("hide")
								arg_316_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_40 = 4
			local var_319_41 = 0.35

			if var_319_40 < arg_316_1.time_ and arg_316_1.time_ <= var_319_40 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_42 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_42:setOnUpdate(LuaHelper.FloatAction(function(arg_322_0)
					arg_316_1.dialogCg_.alpha = arg_322_0
				end))
				var_319_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_43 = arg_316_1:GetWordFromCfg(116431072)
				local var_319_44 = arg_316_1:FormatText(var_319_43.content)

				arg_316_1.text_.text = var_319_44

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_45 = 14
				local var_319_46 = utf8.len(var_319_44)
				local var_319_47 = var_319_45 <= 0 and var_319_41 or var_319_41 * (var_319_46 / var_319_45)

				if var_319_47 > 0 and var_319_41 < var_319_47 then
					arg_316_1.talkMaxDuration = var_319_47
					var_319_40 = var_319_40 + 0.3

					if var_319_47 + var_319_40 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_47 + var_319_40
					end
				end

				arg_316_1.text_.text = var_319_44
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_48 = var_319_40 + 0.3
			local var_319_49 = math.max(var_319_41, arg_316_1.talkMaxDuration)

			if var_319_48 <= arg_316_1.time_ and arg_316_1.time_ < var_319_48 + var_319_49 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_48) / var_319_49

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_48 + var_319_49 and arg_316_1.time_ < var_319_48 + var_319_49 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play116431073 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 116431073
		arg_324_1.duration_ = 3.97

		local var_324_0 = {
			zh = 3.933,
			ja = 3.966
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
				arg_324_0:Play116431074(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = "1019ui_story"

			if arg_324_1.actors_[var_327_0] == nil then
				local var_327_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_327_1) then
					local var_327_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_324_1.stage_.transform)

					var_327_2.name = var_327_0
					var_327_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_324_1.actors_[var_327_0] = var_327_2

					local var_327_3 = var_327_2:GetComponentInChildren(typeof(CharacterEffect))

					var_327_3.enabled = true

					local var_327_4 = GameObjectTools.GetOrAddComponent(var_327_2, typeof(DynamicBoneHelper))

					if var_327_4 then
						var_327_4:EnableDynamicBone(false)
					end

					arg_324_1:ShowWeapon(var_327_3.transform, false)

					arg_324_1.var_[var_327_0 .. "Animator"] = var_327_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_324_1.var_[var_327_0 .. "Animator"].applyRootMotion = true
					arg_324_1.var_[var_327_0 .. "LipSync"] = var_327_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_327_5 = arg_324_1.actors_["1019ui_story"]
			local var_327_6 = 0

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 and not isNil(var_327_5) and arg_324_1.var_.characterEffect1019ui_story == nil then
				arg_324_1.var_.characterEffect1019ui_story = var_327_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_7 = 0.2

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_7 and not isNil(var_327_5) then
				local var_327_8 = (arg_324_1.time_ - var_327_6) / var_327_7

				if arg_324_1.var_.characterEffect1019ui_story and not isNil(var_327_5) then
					arg_324_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_6 + var_327_7 and arg_324_1.time_ < var_327_6 + var_327_7 + arg_327_0 and not isNil(var_327_5) and arg_324_1.var_.characterEffect1019ui_story then
				arg_324_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_327_9 = arg_324_1.actors_["1029ui_story"]
			local var_327_10 = 0

			if var_327_10 < arg_324_1.time_ and arg_324_1.time_ <= var_327_10 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect1029ui_story == nil then
				arg_324_1.var_.characterEffect1029ui_story = var_327_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_11 = 0.0166666666666667

			if var_327_10 <= arg_324_1.time_ and arg_324_1.time_ < var_327_10 + var_327_11 and not isNil(var_327_9) then
				local var_327_12 = (arg_324_1.time_ - var_327_10) / var_327_11

				if arg_324_1.var_.characterEffect1029ui_story and not isNil(var_327_9) then
					local var_327_13 = Mathf.Lerp(0, 0.5, var_327_12)

					arg_324_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1029ui_story.fillRatio = var_327_13
				end
			end

			if arg_324_1.time_ >= var_327_10 + var_327_11 and arg_324_1.time_ < var_327_10 + var_327_11 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect1029ui_story then
				local var_327_14 = 0.5

				arg_324_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1029ui_story.fillRatio = var_327_14
			end

			local var_327_15 = 0

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_327_17 = arg_324_1.actors_["1019ui_story"].transform
			local var_327_18 = 0

			if var_327_18 < arg_324_1.time_ and arg_324_1.time_ <= var_327_18 + arg_327_0 then
				arg_324_1.var_.moveOldPos1019ui_story = var_327_17.localPosition
			end

			local var_327_19 = 0.001

			if var_327_18 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_19 then
				local var_327_20 = (arg_324_1.time_ - var_327_18) / var_327_19
				local var_327_21 = Vector3.New(-0.7, -1.08, -5.9)

				var_327_17.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1019ui_story, var_327_21, var_327_20)

				local var_327_22 = manager.ui.mainCamera.transform.position - var_327_17.position

				var_327_17.forward = Vector3.New(var_327_22.x, var_327_22.y, var_327_22.z)

				local var_327_23 = var_327_17.localEulerAngles

				var_327_23.z = 0
				var_327_23.x = 0
				var_327_17.localEulerAngles = var_327_23
			end

			if arg_324_1.time_ >= var_327_18 + var_327_19 and arg_324_1.time_ < var_327_18 + var_327_19 + arg_327_0 then
				var_327_17.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_327_24 = manager.ui.mainCamera.transform.position - var_327_17.position

				var_327_17.forward = Vector3.New(var_327_24.x, var_327_24.y, var_327_24.z)

				local var_327_25 = var_327_17.localEulerAngles

				var_327_25.z = 0
				var_327_25.x = 0
				var_327_17.localEulerAngles = var_327_25
			end

			local var_327_26 = arg_324_1.actors_["1029ui_story"].transform
			local var_327_27 = 0

			if var_327_27 < arg_324_1.time_ and arg_324_1.time_ <= var_327_27 + arg_327_0 then
				arg_324_1.var_.moveOldPos1029ui_story = var_327_26.localPosition
			end

			local var_327_28 = 0.001

			if var_327_27 <= arg_324_1.time_ and arg_324_1.time_ < var_327_27 + var_327_28 then
				local var_327_29 = (arg_324_1.time_ - var_327_27) / var_327_28
				local var_327_30 = Vector3.New(0.7, -1.09, -6.2)

				var_327_26.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1029ui_story, var_327_30, var_327_29)

				local var_327_31 = manager.ui.mainCamera.transform.position - var_327_26.position

				var_327_26.forward = Vector3.New(var_327_31.x, var_327_31.y, var_327_31.z)

				local var_327_32 = var_327_26.localEulerAngles

				var_327_32.z = 0
				var_327_32.x = 0
				var_327_26.localEulerAngles = var_327_32
			end

			if arg_324_1.time_ >= var_327_27 + var_327_28 and arg_324_1.time_ < var_327_27 + var_327_28 + arg_327_0 then
				var_327_26.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_327_33 = manager.ui.mainCamera.transform.position - var_327_26.position

				var_327_26.forward = Vector3.New(var_327_33.x, var_327_33.y, var_327_33.z)

				local var_327_34 = var_327_26.localEulerAngles

				var_327_34.z = 0
				var_327_34.x = 0
				var_327_26.localEulerAngles = var_327_34
			end

			local var_327_35 = 0

			if var_327_35 < arg_324_1.time_ and arg_324_1.time_ <= var_327_35 + arg_327_0 then
				arg_324_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_327_36 = 0
			local var_327_37 = 0.425

			if var_327_36 < arg_324_1.time_ and arg_324_1.time_ <= var_327_36 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_38 = arg_324_1:FormatText(StoryNameCfg[47].name)

				arg_324_1.leftNameTxt_.text = var_327_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_39 = arg_324_1:GetWordFromCfg(116431073)
				local var_327_40 = arg_324_1:FormatText(var_327_39.content)

				arg_324_1.text_.text = var_327_40

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_41 = 17
				local var_327_42 = utf8.len(var_327_40)
				local var_327_43 = var_327_41 <= 0 and var_327_37 or var_327_37 * (var_327_42 / var_327_41)

				if var_327_43 > 0 and var_327_37 < var_327_43 then
					arg_324_1.talkMaxDuration = var_327_43

					if var_327_43 + var_327_36 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_43 + var_327_36
					end
				end

				arg_324_1.text_.text = var_327_40
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431073", "story_v_out_116431.awb") ~= 0 then
					local var_327_44 = manager.audio:GetVoiceLength("story_v_out_116431", "116431073", "story_v_out_116431.awb") / 1000

					if var_327_44 + var_327_36 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_44 + var_327_36
					end

					if var_327_39.prefab_name ~= "" and arg_324_1.actors_[var_327_39.prefab_name] ~= nil then
						local var_327_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_39.prefab_name].transform, "story_v_out_116431", "116431073", "story_v_out_116431.awb")

						arg_324_1:RecordAudio("116431073", var_327_45)
						arg_324_1:RecordAudio("116431073", var_327_45)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_116431", "116431073", "story_v_out_116431.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_116431", "116431073", "story_v_out_116431.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_46 = math.max(var_327_37, arg_324_1.talkMaxDuration)

			if var_327_36 <= arg_324_1.time_ and arg_324_1.time_ < var_327_36 + var_327_46 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_36) / var_327_46

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_36 + var_327_46 and arg_324_1.time_ < var_327_36 + var_327_46 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play116431074 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 116431074
		arg_328_1.duration_ = 4.5

		local var_328_0 = {
			zh = 4.366,
			ja = 4.5
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
				arg_328_0:Play116431075(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1019ui_story"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos1019ui_story = var_331_0.localPosition
			end

			local var_331_2 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2
				local var_331_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1019ui_story, var_331_4, var_331_3)

				local var_331_5 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_5.x, var_331_5.y, var_331_5.z)

				local var_331_6 = var_331_0.localEulerAngles

				var_331_6.z = 0
				var_331_6.x = 0
				var_331_0.localEulerAngles = var_331_6
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_331_7 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_7.x, var_331_7.y, var_331_7.z)

				local var_331_8 = var_331_0.localEulerAngles

				var_331_8.z = 0
				var_331_8.x = 0
				var_331_0.localEulerAngles = var_331_8
			end

			local var_331_9 = arg_328_1.actors_["1029ui_story"].transform
			local var_331_10 = 0

			if var_331_10 < arg_328_1.time_ and arg_328_1.time_ <= var_331_10 + arg_331_0 then
				arg_328_1.var_.moveOldPos1029ui_story = var_331_9.localPosition
			end

			local var_331_11 = 0.001

			if var_331_10 <= arg_328_1.time_ and arg_328_1.time_ < var_331_10 + var_331_11 then
				local var_331_12 = (arg_328_1.time_ - var_331_10) / var_331_11
				local var_331_13 = Vector3.New(0.7, -1.09, -6.2)

				var_331_9.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1029ui_story, var_331_13, var_331_12)

				local var_331_14 = manager.ui.mainCamera.transform.position - var_331_9.position

				var_331_9.forward = Vector3.New(var_331_14.x, var_331_14.y, var_331_14.z)

				local var_331_15 = var_331_9.localEulerAngles

				var_331_15.z = 0
				var_331_15.x = 0
				var_331_9.localEulerAngles = var_331_15
			end

			if arg_328_1.time_ >= var_331_10 + var_331_11 and arg_328_1.time_ < var_331_10 + var_331_11 + arg_331_0 then
				var_331_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_331_16 = manager.ui.mainCamera.transform.position - var_331_9.position

				var_331_9.forward = Vector3.New(var_331_16.x, var_331_16.y, var_331_16.z)

				local var_331_17 = var_331_9.localEulerAngles

				var_331_17.z = 0
				var_331_17.x = 0
				var_331_9.localEulerAngles = var_331_17
			end

			local var_331_18 = arg_328_1.actors_["1019ui_story"]
			local var_331_19 = 0

			if var_331_19 < arg_328_1.time_ and arg_328_1.time_ <= var_331_19 + arg_331_0 and not isNil(var_331_18) and arg_328_1.var_.characterEffect1019ui_story == nil then
				arg_328_1.var_.characterEffect1019ui_story = var_331_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_20 = 0.2

			if var_331_19 <= arg_328_1.time_ and arg_328_1.time_ < var_331_19 + var_331_20 and not isNil(var_331_18) then
				local var_331_21 = (arg_328_1.time_ - var_331_19) / var_331_20

				if arg_328_1.var_.characterEffect1019ui_story and not isNil(var_331_18) then
					local var_331_22 = Mathf.Lerp(0, 0.5, var_331_21)

					arg_328_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1019ui_story.fillRatio = var_331_22
				end
			end

			if arg_328_1.time_ >= var_331_19 + var_331_20 and arg_328_1.time_ < var_331_19 + var_331_20 + arg_331_0 and not isNil(var_331_18) and arg_328_1.var_.characterEffect1019ui_story then
				local var_331_23 = 0.5

				arg_328_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1019ui_story.fillRatio = var_331_23
			end

			local var_331_24 = arg_328_1.actors_["1029ui_story"]
			local var_331_25 = 0

			if var_331_25 < arg_328_1.time_ and arg_328_1.time_ <= var_331_25 + arg_331_0 and not isNil(var_331_24) and arg_328_1.var_.characterEffect1029ui_story == nil then
				arg_328_1.var_.characterEffect1029ui_story = var_331_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_26 = 0.2

			if var_331_25 <= arg_328_1.time_ and arg_328_1.time_ < var_331_25 + var_331_26 and not isNil(var_331_24) then
				local var_331_27 = (arg_328_1.time_ - var_331_25) / var_331_26

				if arg_328_1.var_.characterEffect1029ui_story and not isNil(var_331_24) then
					arg_328_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_25 + var_331_26 and arg_328_1.time_ < var_331_25 + var_331_26 + arg_331_0 and not isNil(var_331_24) and arg_328_1.var_.characterEffect1029ui_story then
				arg_328_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_331_28 = 0

			if var_331_28 < arg_328_1.time_ and arg_328_1.time_ <= var_331_28 + arg_331_0 then
				arg_328_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_331_29 = 0

			if var_331_29 < arg_328_1.time_ and arg_328_1.time_ <= var_331_29 + arg_331_0 then
				arg_328_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_331_30 = 0
			local var_331_31 = 0.375

			if var_331_30 < arg_328_1.time_ and arg_328_1.time_ <= var_331_30 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_32 = arg_328_1:FormatText(StoryNameCfg[319].name)

				arg_328_1.leftNameTxt_.text = var_331_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_33 = arg_328_1:GetWordFromCfg(116431074)
				local var_331_34 = arg_328_1:FormatText(var_331_33.content)

				arg_328_1.text_.text = var_331_34

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_35 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431074", "story_v_out_116431.awb") ~= 0 then
					local var_331_38 = manager.audio:GetVoiceLength("story_v_out_116431", "116431074", "story_v_out_116431.awb") / 1000

					if var_331_38 + var_331_30 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_38 + var_331_30
					end

					if var_331_33.prefab_name ~= "" and arg_328_1.actors_[var_331_33.prefab_name] ~= nil then
						local var_331_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_33.prefab_name].transform, "story_v_out_116431", "116431074", "story_v_out_116431.awb")

						arg_328_1:RecordAudio("116431074", var_331_39)
						arg_328_1:RecordAudio("116431074", var_331_39)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_116431", "116431074", "story_v_out_116431.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_116431", "116431074", "story_v_out_116431.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play116431075 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 116431075
		arg_332_1.duration_ = 10

		local var_332_0 = {
			zh = 8.733,
			ja = 10
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
				arg_332_0:Play116431076(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1019ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos1019ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1019ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["1029ui_story"].transform
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.var_.moveOldPos1029ui_story = var_335_9.localPosition
			end

			local var_335_11 = 0.001

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11
				local var_335_13 = Vector3.New(0.7, -1.09, -6.2)

				var_335_9.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1029ui_story, var_335_13, var_335_12)

				local var_335_14 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_14.x, var_335_14.y, var_335_14.z)

				local var_335_15 = var_335_9.localEulerAngles

				var_335_15.z = 0
				var_335_15.x = 0
				var_335_9.localEulerAngles = var_335_15
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				var_335_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_335_16 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_16.x, var_335_16.y, var_335_16.z)

				local var_335_17 = var_335_9.localEulerAngles

				var_335_17.z = 0
				var_335_17.x = 0
				var_335_9.localEulerAngles = var_335_17
			end

			local var_335_18 = 0

			if var_335_18 < arg_332_1.time_ and arg_332_1.time_ <= var_335_18 + arg_335_0 then
				arg_332_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_335_19 = 0
			local var_335_20 = 0.875

			if var_335_19 < arg_332_1.time_ and arg_332_1.time_ <= var_335_19 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_21 = arg_332_1:FormatText(StoryNameCfg[319].name)

				arg_332_1.leftNameTxt_.text = var_335_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_22 = arg_332_1:GetWordFromCfg(116431075)
				local var_335_23 = arg_332_1:FormatText(var_335_22.content)

				arg_332_1.text_.text = var_335_23

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_24 = 35
				local var_335_25 = utf8.len(var_335_23)
				local var_335_26 = var_335_24 <= 0 and var_335_20 or var_335_20 * (var_335_25 / var_335_24)

				if var_335_26 > 0 and var_335_20 < var_335_26 then
					arg_332_1.talkMaxDuration = var_335_26

					if var_335_26 + var_335_19 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_26 + var_335_19
					end
				end

				arg_332_1.text_.text = var_335_23
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431075", "story_v_out_116431.awb") ~= 0 then
					local var_335_27 = manager.audio:GetVoiceLength("story_v_out_116431", "116431075", "story_v_out_116431.awb") / 1000

					if var_335_27 + var_335_19 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_27 + var_335_19
					end

					if var_335_22.prefab_name ~= "" and arg_332_1.actors_[var_335_22.prefab_name] ~= nil then
						local var_335_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_22.prefab_name].transform, "story_v_out_116431", "116431075", "story_v_out_116431.awb")

						arg_332_1:RecordAudio("116431075", var_335_28)
						arg_332_1:RecordAudio("116431075", var_335_28)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_116431", "116431075", "story_v_out_116431.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_116431", "116431075", "story_v_out_116431.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_29 = math.max(var_335_20, arg_332_1.talkMaxDuration)

			if var_335_19 <= arg_332_1.time_ and arg_332_1.time_ < var_335_19 + var_335_29 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_19) / var_335_29

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_19 + var_335_29 and arg_332_1.time_ < var_335_19 + var_335_29 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play116431076 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 116431076
		arg_336_1.duration_ = 7.6

		local var_336_0 = {
			zh = 5.033,
			ja = 7.6
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
				arg_336_0:Play116431077(arg_336_1)
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
				local var_339_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1019ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1029ui_story"].transform
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 then
				arg_336_1.var_.moveOldPos1029ui_story = var_339_9.localPosition
			end

			local var_339_11 = 0.001

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11
				local var_339_13 = Vector3.New(0.7, -1.09, -6.2)

				var_339_9.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1029ui_story, var_339_13, var_339_12)

				local var_339_14 = manager.ui.mainCamera.transform.position - var_339_9.position

				var_339_9.forward = Vector3.New(var_339_14.x, var_339_14.y, var_339_14.z)

				local var_339_15 = var_339_9.localEulerAngles

				var_339_15.z = 0
				var_339_15.x = 0
				var_339_9.localEulerAngles = var_339_15
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 then
				var_339_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_339_16 = manager.ui.mainCamera.transform.position - var_339_9.position

				var_339_9.forward = Vector3.New(var_339_16.x, var_339_16.y, var_339_16.z)

				local var_339_17 = var_339_9.localEulerAngles

				var_339_17.z = 0
				var_339_17.x = 0
				var_339_9.localEulerAngles = var_339_17
			end

			local var_339_18 = 0

			if var_339_18 < arg_336_1.time_ and arg_336_1.time_ <= var_339_18 + arg_339_0 then
				arg_336_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_339_19 = 0
			local var_339_20 = 0.5

			if var_339_19 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_21 = arg_336_1:FormatText(StoryNameCfg[319].name)

				arg_336_1.leftNameTxt_.text = var_339_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_22 = arg_336_1:GetWordFromCfg(116431076)
				local var_339_23 = arg_336_1:FormatText(var_339_22.content)

				arg_336_1.text_.text = var_339_23

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_24 = 20
				local var_339_25 = utf8.len(var_339_23)
				local var_339_26 = var_339_24 <= 0 and var_339_20 or var_339_20 * (var_339_25 / var_339_24)

				if var_339_26 > 0 and var_339_20 < var_339_26 then
					arg_336_1.talkMaxDuration = var_339_26

					if var_339_26 + var_339_19 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_26 + var_339_19
					end
				end

				arg_336_1.text_.text = var_339_23
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431076", "story_v_out_116431.awb") ~= 0 then
					local var_339_27 = manager.audio:GetVoiceLength("story_v_out_116431", "116431076", "story_v_out_116431.awb") / 1000

					if var_339_27 + var_339_19 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_27 + var_339_19
					end

					if var_339_22.prefab_name ~= "" and arg_336_1.actors_[var_339_22.prefab_name] ~= nil then
						local var_339_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_22.prefab_name].transform, "story_v_out_116431", "116431076", "story_v_out_116431.awb")

						arg_336_1:RecordAudio("116431076", var_339_28)
						arg_336_1:RecordAudio("116431076", var_339_28)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_116431", "116431076", "story_v_out_116431.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_116431", "116431076", "story_v_out_116431.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_29 = math.max(var_339_20, arg_336_1.talkMaxDuration)

			if var_339_19 <= arg_336_1.time_ and arg_336_1.time_ < var_339_19 + var_339_29 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_19) / var_339_29

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_19 + var_339_29 and arg_336_1.time_ < var_339_19 + var_339_29 + arg_339_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play116431077 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 116431077
		arg_340_1.duration_ = 9.23

		local var_340_0 = {
			zh = 5.6,
			ja = 9.233
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
				arg_340_0:Play116431078(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1019ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1019ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1019ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["1029ui_story"].transform
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 then
				arg_340_1.var_.moveOldPos1029ui_story = var_343_9.localPosition
			end

			local var_343_11 = 0.001

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11
				local var_343_13 = Vector3.New(0.7, -1.09, -6.2)

				var_343_9.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1029ui_story, var_343_13, var_343_12)

				local var_343_14 = manager.ui.mainCamera.transform.position - var_343_9.position

				var_343_9.forward = Vector3.New(var_343_14.x, var_343_14.y, var_343_14.z)

				local var_343_15 = var_343_9.localEulerAngles

				var_343_15.z = 0
				var_343_15.x = 0
				var_343_9.localEulerAngles = var_343_15
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 then
				var_343_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_343_16 = manager.ui.mainCamera.transform.position - var_343_9.position

				var_343_9.forward = Vector3.New(var_343_16.x, var_343_16.y, var_343_16.z)

				local var_343_17 = var_343_9.localEulerAngles

				var_343_17.z = 0
				var_343_17.x = 0
				var_343_9.localEulerAngles = var_343_17
			end

			local var_343_18 = 0

			if var_343_18 < arg_340_1.time_ and arg_340_1.time_ <= var_343_18 + arg_343_0 then
				arg_340_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_343_19 = 0
			local var_343_20 = 0.725

			if var_343_19 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_21 = arg_340_1:FormatText(StoryNameCfg[319].name)

				arg_340_1.leftNameTxt_.text = var_343_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_22 = arg_340_1:GetWordFromCfg(116431077)
				local var_343_23 = arg_340_1:FormatText(var_343_22.content)

				arg_340_1.text_.text = var_343_23

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_24 = 29
				local var_343_25 = utf8.len(var_343_23)
				local var_343_26 = var_343_24 <= 0 and var_343_20 or var_343_20 * (var_343_25 / var_343_24)

				if var_343_26 > 0 and var_343_20 < var_343_26 then
					arg_340_1.talkMaxDuration = var_343_26

					if var_343_26 + var_343_19 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_26 + var_343_19
					end
				end

				arg_340_1.text_.text = var_343_23
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431077", "story_v_out_116431.awb") ~= 0 then
					local var_343_27 = manager.audio:GetVoiceLength("story_v_out_116431", "116431077", "story_v_out_116431.awb") / 1000

					if var_343_27 + var_343_19 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_27 + var_343_19
					end

					if var_343_22.prefab_name ~= "" and arg_340_1.actors_[var_343_22.prefab_name] ~= nil then
						local var_343_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_22.prefab_name].transform, "story_v_out_116431", "116431077", "story_v_out_116431.awb")

						arg_340_1:RecordAudio("116431077", var_343_28)
						arg_340_1:RecordAudio("116431077", var_343_28)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_116431", "116431077", "story_v_out_116431.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_116431", "116431077", "story_v_out_116431.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_29 = math.max(var_343_20, arg_340_1.talkMaxDuration)

			if var_343_19 <= arg_340_1.time_ and arg_340_1.time_ < var_343_19 + var_343_29 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_19) / var_343_29

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_19 + var_343_29 and arg_340_1.time_ < var_343_19 + var_343_29 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play116431078 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 116431078
		arg_344_1.duration_ = 5.87

		local var_344_0 = {
			zh = 5.866,
			ja = 5.2
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
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play116431079(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1019ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos1019ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1019ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = arg_344_1.actors_["1019ui_story"]
			local var_347_10 = 0

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1019ui_story == nil then
				arg_344_1.var_.characterEffect1019ui_story = var_347_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.2

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_11 and not isNil(var_347_9) then
				local var_347_12 = (arg_344_1.time_ - var_347_10) / var_347_11

				if arg_344_1.var_.characterEffect1019ui_story and not isNil(var_347_9) then
					arg_344_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_10 + var_347_11 and arg_344_1.time_ < var_347_10 + var_347_11 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1019ui_story then
				arg_344_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_347_13 = arg_344_1.actors_["1029ui_story"]
			local var_347_14 = 0

			if var_347_14 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 and not isNil(var_347_13) and arg_344_1.var_.characterEffect1029ui_story == nil then
				arg_344_1.var_.characterEffect1029ui_story = var_347_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_15 = 0.2

			if var_347_14 <= arg_344_1.time_ and arg_344_1.time_ < var_347_14 + var_347_15 and not isNil(var_347_13) then
				local var_347_16 = (arg_344_1.time_ - var_347_14) / var_347_15

				if arg_344_1.var_.characterEffect1029ui_story and not isNil(var_347_13) then
					local var_347_17 = Mathf.Lerp(0, 0.5, var_347_16)

					arg_344_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1029ui_story.fillRatio = var_347_17
				end
			end

			if arg_344_1.time_ >= var_347_14 + var_347_15 and arg_344_1.time_ < var_347_14 + var_347_15 + arg_347_0 and not isNil(var_347_13) and arg_344_1.var_.characterEffect1029ui_story then
				local var_347_18 = 0.5

				arg_344_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1029ui_story.fillRatio = var_347_18
			end

			local var_347_19 = 0

			if var_347_19 < arg_344_1.time_ and arg_344_1.time_ <= var_347_19 + arg_347_0 then
				arg_344_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_347_20 = 0

			if var_347_20 < arg_344_1.time_ and arg_344_1.time_ <= var_347_20 + arg_347_0 then
				arg_344_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_347_21 = 0
			local var_347_22 = 0.725

			if var_347_21 < arg_344_1.time_ and arg_344_1.time_ <= var_347_21 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_23 = arg_344_1:FormatText(StoryNameCfg[47].name)

				arg_344_1.leftNameTxt_.text = var_347_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_24 = arg_344_1:GetWordFromCfg(116431078)
				local var_347_25 = arg_344_1:FormatText(var_347_24.content)

				arg_344_1.text_.text = var_347_25

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_26 = 29
				local var_347_27 = utf8.len(var_347_25)
				local var_347_28 = var_347_26 <= 0 and var_347_22 or var_347_22 * (var_347_27 / var_347_26)

				if var_347_28 > 0 and var_347_22 < var_347_28 then
					arg_344_1.talkMaxDuration = var_347_28

					if var_347_28 + var_347_21 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_28 + var_347_21
					end
				end

				arg_344_1.text_.text = var_347_25
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431078", "story_v_out_116431.awb") ~= 0 then
					local var_347_29 = manager.audio:GetVoiceLength("story_v_out_116431", "116431078", "story_v_out_116431.awb") / 1000

					if var_347_29 + var_347_21 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_29 + var_347_21
					end

					if var_347_24.prefab_name ~= "" and arg_344_1.actors_[var_347_24.prefab_name] ~= nil then
						local var_347_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_24.prefab_name].transform, "story_v_out_116431", "116431078", "story_v_out_116431.awb")

						arg_344_1:RecordAudio("116431078", var_347_30)
						arg_344_1:RecordAudio("116431078", var_347_30)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_116431", "116431078", "story_v_out_116431.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_116431", "116431078", "story_v_out_116431.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_31 = math.max(var_347_22, arg_344_1.talkMaxDuration)

			if var_347_21 <= arg_344_1.time_ and arg_344_1.time_ < var_347_21 + var_347_31 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_21) / var_347_31

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_21 + var_347_31 and arg_344_1.time_ < var_347_21 + var_347_31 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play116431079 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 116431079
		arg_348_1.duration_ = 6.93

		local var_348_0 = {
			zh = 6.933,
			ja = 6.6
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play116431080(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1019ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1019ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1019ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1029ui_story"].transform
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 then
				arg_348_1.var_.moveOldPos1029ui_story = var_351_9.localPosition
			end

			local var_351_11 = 0.001

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11
				local var_351_13 = Vector3.New(0.7, -1.09, -6.2)

				var_351_9.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1029ui_story, var_351_13, var_351_12)

				local var_351_14 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_14.x, var_351_14.y, var_351_14.z)

				local var_351_15 = var_351_9.localEulerAngles

				var_351_15.z = 0
				var_351_15.x = 0
				var_351_9.localEulerAngles = var_351_15
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 then
				var_351_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_351_16 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_16.x, var_351_16.y, var_351_16.z)

				local var_351_17 = var_351_9.localEulerAngles

				var_351_17.z = 0
				var_351_17.x = 0
				var_351_9.localEulerAngles = var_351_17
			end

			local var_351_18 = arg_348_1.actors_["1019ui_story"]
			local var_351_19 = 0

			if var_351_19 < arg_348_1.time_ and arg_348_1.time_ <= var_351_19 + arg_351_0 and not isNil(var_351_18) and arg_348_1.var_.characterEffect1019ui_story == nil then
				arg_348_1.var_.characterEffect1019ui_story = var_351_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_20 = 0.2

			if var_351_19 <= arg_348_1.time_ and arg_348_1.time_ < var_351_19 + var_351_20 and not isNil(var_351_18) then
				local var_351_21 = (arg_348_1.time_ - var_351_19) / var_351_20

				if arg_348_1.var_.characterEffect1019ui_story and not isNil(var_351_18) then
					local var_351_22 = Mathf.Lerp(0, 0.5, var_351_21)

					arg_348_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1019ui_story.fillRatio = var_351_22
				end
			end

			if arg_348_1.time_ >= var_351_19 + var_351_20 and arg_348_1.time_ < var_351_19 + var_351_20 + arg_351_0 and not isNil(var_351_18) and arg_348_1.var_.characterEffect1019ui_story then
				local var_351_23 = 0.5

				arg_348_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1019ui_story.fillRatio = var_351_23
			end

			local var_351_24 = arg_348_1.actors_["1029ui_story"]
			local var_351_25 = 0

			if var_351_25 < arg_348_1.time_ and arg_348_1.time_ <= var_351_25 + arg_351_0 and not isNil(var_351_24) and arg_348_1.var_.characterEffect1029ui_story == nil then
				arg_348_1.var_.characterEffect1029ui_story = var_351_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_26 = 0.2

			if var_351_25 <= arg_348_1.time_ and arg_348_1.time_ < var_351_25 + var_351_26 and not isNil(var_351_24) then
				local var_351_27 = (arg_348_1.time_ - var_351_25) / var_351_26

				if arg_348_1.var_.characterEffect1029ui_story and not isNil(var_351_24) then
					arg_348_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_25 + var_351_26 and arg_348_1.time_ < var_351_25 + var_351_26 + arg_351_0 and not isNil(var_351_24) and arg_348_1.var_.characterEffect1029ui_story then
				arg_348_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_351_28 = 0

			if var_351_28 < arg_348_1.time_ and arg_348_1.time_ <= var_351_28 + arg_351_0 then
				arg_348_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_351_29 = 0
			local var_351_30 = 0.775

			if var_351_29 < arg_348_1.time_ and arg_348_1.time_ <= var_351_29 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_31 = arg_348_1:FormatText(StoryNameCfg[319].name)

				arg_348_1.leftNameTxt_.text = var_351_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_32 = arg_348_1:GetWordFromCfg(116431079)
				local var_351_33 = arg_348_1:FormatText(var_351_32.content)

				arg_348_1.text_.text = var_351_33

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_34 = 31
				local var_351_35 = utf8.len(var_351_33)
				local var_351_36 = var_351_34 <= 0 and var_351_30 or var_351_30 * (var_351_35 / var_351_34)

				if var_351_36 > 0 and var_351_30 < var_351_36 then
					arg_348_1.talkMaxDuration = var_351_36

					if var_351_36 + var_351_29 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_36 + var_351_29
					end
				end

				arg_348_1.text_.text = var_351_33
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431079", "story_v_out_116431.awb") ~= 0 then
					local var_351_37 = manager.audio:GetVoiceLength("story_v_out_116431", "116431079", "story_v_out_116431.awb") / 1000

					if var_351_37 + var_351_29 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_37 + var_351_29
					end

					if var_351_32.prefab_name ~= "" and arg_348_1.actors_[var_351_32.prefab_name] ~= nil then
						local var_351_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_32.prefab_name].transform, "story_v_out_116431", "116431079", "story_v_out_116431.awb")

						arg_348_1:RecordAudio("116431079", var_351_38)
						arg_348_1:RecordAudio("116431079", var_351_38)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_116431", "116431079", "story_v_out_116431.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_116431", "116431079", "story_v_out_116431.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_39 = math.max(var_351_30, arg_348_1.talkMaxDuration)

			if var_351_29 <= arg_348_1.time_ and arg_348_1.time_ < var_351_29 + var_351_39 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_29) / var_351_39

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_29 + var_351_39 and arg_348_1.time_ < var_351_29 + var_351_39 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play116431080 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 116431080
		arg_352_1.duration_ = 8.8

		local var_352_0 = {
			zh = 7.933,
			ja = 8.8
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play116431081(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1019ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos1019ui_story = var_355_0.localPosition
			end

			local var_355_2 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2
				local var_355_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1019ui_story, var_355_4, var_355_3)

				local var_355_5 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_5.x, var_355_5.y, var_355_5.z)

				local var_355_6 = var_355_0.localEulerAngles

				var_355_6.z = 0
				var_355_6.x = 0
				var_355_0.localEulerAngles = var_355_6
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_355_7 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_7.x, var_355_7.y, var_355_7.z)

				local var_355_8 = var_355_0.localEulerAngles

				var_355_8.z = 0
				var_355_8.x = 0
				var_355_0.localEulerAngles = var_355_8
			end

			local var_355_9 = arg_352_1.actors_["1019ui_story"]
			local var_355_10 = 0

			if var_355_10 < arg_352_1.time_ and arg_352_1.time_ <= var_355_10 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1019ui_story == nil then
				arg_352_1.var_.characterEffect1019ui_story = var_355_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_11 = 0.2

			if var_355_10 <= arg_352_1.time_ and arg_352_1.time_ < var_355_10 + var_355_11 and not isNil(var_355_9) then
				local var_355_12 = (arg_352_1.time_ - var_355_10) / var_355_11

				if arg_352_1.var_.characterEffect1019ui_story and not isNil(var_355_9) then
					arg_352_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_10 + var_355_11 and arg_352_1.time_ < var_355_10 + var_355_11 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1019ui_story then
				arg_352_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_355_13 = arg_352_1.actors_["1029ui_story"]
			local var_355_14 = 0

			if var_355_14 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 and not isNil(var_355_13) and arg_352_1.var_.characterEffect1029ui_story == nil then
				arg_352_1.var_.characterEffect1029ui_story = var_355_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_15 = 0.2

			if var_355_14 <= arg_352_1.time_ and arg_352_1.time_ < var_355_14 + var_355_15 and not isNil(var_355_13) then
				local var_355_16 = (arg_352_1.time_ - var_355_14) / var_355_15

				if arg_352_1.var_.characterEffect1029ui_story and not isNil(var_355_13) then
					local var_355_17 = Mathf.Lerp(0, 0.5, var_355_16)

					arg_352_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1029ui_story.fillRatio = var_355_17
				end
			end

			if arg_352_1.time_ >= var_355_14 + var_355_15 and arg_352_1.time_ < var_355_14 + var_355_15 + arg_355_0 and not isNil(var_355_13) and arg_352_1.var_.characterEffect1029ui_story then
				local var_355_18 = 0.5

				arg_352_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1029ui_story.fillRatio = var_355_18
			end

			local var_355_19 = 0

			if var_355_19 < arg_352_1.time_ and arg_352_1.time_ <= var_355_19 + arg_355_0 then
				arg_352_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_355_20 = 0

			if var_355_20 < arg_352_1.time_ and arg_352_1.time_ <= var_355_20 + arg_355_0 then
				arg_352_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_355_21 = 0
			local var_355_22 = 1.05

			if var_355_21 < arg_352_1.time_ and arg_352_1.time_ <= var_355_21 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_23 = arg_352_1:FormatText(StoryNameCfg[47].name)

				arg_352_1.leftNameTxt_.text = var_355_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_24 = arg_352_1:GetWordFromCfg(116431080)
				local var_355_25 = arg_352_1:FormatText(var_355_24.content)

				arg_352_1.text_.text = var_355_25

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_26 = 42
				local var_355_27 = utf8.len(var_355_25)
				local var_355_28 = var_355_26 <= 0 and var_355_22 or var_355_22 * (var_355_27 / var_355_26)

				if var_355_28 > 0 and var_355_22 < var_355_28 then
					arg_352_1.talkMaxDuration = var_355_28

					if var_355_28 + var_355_21 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_28 + var_355_21
					end
				end

				arg_352_1.text_.text = var_355_25
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431080", "story_v_out_116431.awb") ~= 0 then
					local var_355_29 = manager.audio:GetVoiceLength("story_v_out_116431", "116431080", "story_v_out_116431.awb") / 1000

					if var_355_29 + var_355_21 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_29 + var_355_21
					end

					if var_355_24.prefab_name ~= "" and arg_352_1.actors_[var_355_24.prefab_name] ~= nil then
						local var_355_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_24.prefab_name].transform, "story_v_out_116431", "116431080", "story_v_out_116431.awb")

						arg_352_1:RecordAudio("116431080", var_355_30)
						arg_352_1:RecordAudio("116431080", var_355_30)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_116431", "116431080", "story_v_out_116431.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_116431", "116431080", "story_v_out_116431.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_31 = math.max(var_355_22, arg_352_1.talkMaxDuration)

			if var_355_21 <= arg_352_1.time_ and arg_352_1.time_ < var_355_21 + var_355_31 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_21) / var_355_31

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_21 + var_355_31 and arg_352_1.time_ < var_355_21 + var_355_31 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play116431081 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 116431081
		arg_356_1.duration_ = 7.53

		local var_356_0 = {
			zh = 7.533,
			ja = 7.133
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play116431082(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1019ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos1019ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1019ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = arg_356_1.actors_["1029ui_story"].transform
			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 then
				arg_356_1.var_.moveOldPos1029ui_story = var_359_9.localPosition
			end

			local var_359_11 = 0.001

			if var_359_10 <= arg_356_1.time_ and arg_356_1.time_ < var_359_10 + var_359_11 then
				local var_359_12 = (arg_356_1.time_ - var_359_10) / var_359_11
				local var_359_13 = Vector3.New(0.7, -1.09, -6.2)

				var_359_9.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1029ui_story, var_359_13, var_359_12)

				local var_359_14 = manager.ui.mainCamera.transform.position - var_359_9.position

				var_359_9.forward = Vector3.New(var_359_14.x, var_359_14.y, var_359_14.z)

				local var_359_15 = var_359_9.localEulerAngles

				var_359_15.z = 0
				var_359_15.x = 0
				var_359_9.localEulerAngles = var_359_15
			end

			if arg_356_1.time_ >= var_359_10 + var_359_11 and arg_356_1.time_ < var_359_10 + var_359_11 + arg_359_0 then
				var_359_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_359_16 = manager.ui.mainCamera.transform.position - var_359_9.position

				var_359_9.forward = Vector3.New(var_359_16.x, var_359_16.y, var_359_16.z)

				local var_359_17 = var_359_9.localEulerAngles

				var_359_17.z = 0
				var_359_17.x = 0
				var_359_9.localEulerAngles = var_359_17
			end

			local var_359_18 = arg_356_1.actors_["1019ui_story"]
			local var_359_19 = 0

			if var_359_19 < arg_356_1.time_ and arg_356_1.time_ <= var_359_19 + arg_359_0 and not isNil(var_359_18) and arg_356_1.var_.characterEffect1019ui_story == nil then
				arg_356_1.var_.characterEffect1019ui_story = var_359_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_20 = 0.2

			if var_359_19 <= arg_356_1.time_ and arg_356_1.time_ < var_359_19 + var_359_20 and not isNil(var_359_18) then
				local var_359_21 = (arg_356_1.time_ - var_359_19) / var_359_20

				if arg_356_1.var_.characterEffect1019ui_story and not isNil(var_359_18) then
					local var_359_22 = Mathf.Lerp(0, 0.5, var_359_21)

					arg_356_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1019ui_story.fillRatio = var_359_22
				end
			end

			if arg_356_1.time_ >= var_359_19 + var_359_20 and arg_356_1.time_ < var_359_19 + var_359_20 + arg_359_0 and not isNil(var_359_18) and arg_356_1.var_.characterEffect1019ui_story then
				local var_359_23 = 0.5

				arg_356_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1019ui_story.fillRatio = var_359_23
			end

			local var_359_24 = arg_356_1.actors_["1029ui_story"]
			local var_359_25 = 0

			if var_359_25 < arg_356_1.time_ and arg_356_1.time_ <= var_359_25 + arg_359_0 and not isNil(var_359_24) and arg_356_1.var_.characterEffect1029ui_story == nil then
				arg_356_1.var_.characterEffect1029ui_story = var_359_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_26 = 0.2

			if var_359_25 <= arg_356_1.time_ and arg_356_1.time_ < var_359_25 + var_359_26 and not isNil(var_359_24) then
				local var_359_27 = (arg_356_1.time_ - var_359_25) / var_359_26

				if arg_356_1.var_.characterEffect1029ui_story and not isNil(var_359_24) then
					arg_356_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_25 + var_359_26 and arg_356_1.time_ < var_359_25 + var_359_26 + arg_359_0 and not isNil(var_359_24) and arg_356_1.var_.characterEffect1029ui_story then
				arg_356_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_359_28 = 0

			if var_359_28 < arg_356_1.time_ and arg_356_1.time_ <= var_359_28 + arg_359_0 then
				arg_356_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_359_29 = 0
			local var_359_30 = 0.775

			if var_359_29 < arg_356_1.time_ and arg_356_1.time_ <= var_359_29 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_31 = arg_356_1:FormatText(StoryNameCfg[319].name)

				arg_356_1.leftNameTxt_.text = var_359_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_32 = arg_356_1:GetWordFromCfg(116431081)
				local var_359_33 = arg_356_1:FormatText(var_359_32.content)

				arg_356_1.text_.text = var_359_33

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_34 = 31
				local var_359_35 = utf8.len(var_359_33)
				local var_359_36 = var_359_34 <= 0 and var_359_30 or var_359_30 * (var_359_35 / var_359_34)

				if var_359_36 > 0 and var_359_30 < var_359_36 then
					arg_356_1.talkMaxDuration = var_359_36

					if var_359_36 + var_359_29 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_36 + var_359_29
					end
				end

				arg_356_1.text_.text = var_359_33
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431081", "story_v_out_116431.awb") ~= 0 then
					local var_359_37 = manager.audio:GetVoiceLength("story_v_out_116431", "116431081", "story_v_out_116431.awb") / 1000

					if var_359_37 + var_359_29 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_37 + var_359_29
					end

					if var_359_32.prefab_name ~= "" and arg_356_1.actors_[var_359_32.prefab_name] ~= nil then
						local var_359_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_32.prefab_name].transform, "story_v_out_116431", "116431081", "story_v_out_116431.awb")

						arg_356_1:RecordAudio("116431081", var_359_38)
						arg_356_1:RecordAudio("116431081", var_359_38)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_116431", "116431081", "story_v_out_116431.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_116431", "116431081", "story_v_out_116431.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_39 = math.max(var_359_30, arg_356_1.talkMaxDuration)

			if var_359_29 <= arg_356_1.time_ and arg_356_1.time_ < var_359_29 + var_359_39 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_29) / var_359_39

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_29 + var_359_39 and arg_356_1.time_ < var_359_29 + var_359_39 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play116431082 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 116431082
		arg_360_1.duration_ = 2

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play116431083(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1019ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos1019ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1019ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = arg_360_1.actors_["1019ui_story"]
			local var_363_10 = 0

			if var_363_10 < arg_360_1.time_ and arg_360_1.time_ <= var_363_10 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect1019ui_story == nil then
				arg_360_1.var_.characterEffect1019ui_story = var_363_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_11 = 0.2

			if var_363_10 <= arg_360_1.time_ and arg_360_1.time_ < var_363_10 + var_363_11 and not isNil(var_363_9) then
				local var_363_12 = (arg_360_1.time_ - var_363_10) / var_363_11

				if arg_360_1.var_.characterEffect1019ui_story and not isNil(var_363_9) then
					arg_360_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_10 + var_363_11 and arg_360_1.time_ < var_363_10 + var_363_11 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect1019ui_story then
				arg_360_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_363_13 = arg_360_1.actors_["1029ui_story"]
			local var_363_14 = 0

			if var_363_14 < arg_360_1.time_ and arg_360_1.time_ <= var_363_14 + arg_363_0 and not isNil(var_363_13) and arg_360_1.var_.characterEffect1029ui_story == nil then
				arg_360_1.var_.characterEffect1029ui_story = var_363_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_15 = 0.2

			if var_363_14 <= arg_360_1.time_ and arg_360_1.time_ < var_363_14 + var_363_15 and not isNil(var_363_13) then
				local var_363_16 = (arg_360_1.time_ - var_363_14) / var_363_15

				if arg_360_1.var_.characterEffect1029ui_story and not isNil(var_363_13) then
					local var_363_17 = Mathf.Lerp(0, 0.5, var_363_16)

					arg_360_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1029ui_story.fillRatio = var_363_17
				end
			end

			if arg_360_1.time_ >= var_363_14 + var_363_15 and arg_360_1.time_ < var_363_14 + var_363_15 + arg_363_0 and not isNil(var_363_13) and arg_360_1.var_.characterEffect1029ui_story then
				local var_363_18 = 0.5

				arg_360_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1029ui_story.fillRatio = var_363_18
			end

			local var_363_19 = 0

			if var_363_19 < arg_360_1.time_ and arg_360_1.time_ <= var_363_19 + arg_363_0 then
				arg_360_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_363_20 = 0
			local var_363_21 = 0.125

			if var_363_20 < arg_360_1.time_ and arg_360_1.time_ <= var_363_20 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_22 = arg_360_1:FormatText(StoryNameCfg[47].name)

				arg_360_1.leftNameTxt_.text = var_363_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_23 = arg_360_1:GetWordFromCfg(116431082)
				local var_363_24 = arg_360_1:FormatText(var_363_23.content)

				arg_360_1.text_.text = var_363_24

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_25 = 5
				local var_363_26 = utf8.len(var_363_24)
				local var_363_27 = var_363_25 <= 0 and var_363_21 or var_363_21 * (var_363_26 / var_363_25)

				if var_363_27 > 0 and var_363_21 < var_363_27 then
					arg_360_1.talkMaxDuration = var_363_27

					if var_363_27 + var_363_20 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_27 + var_363_20
					end
				end

				arg_360_1.text_.text = var_363_24
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431082", "story_v_out_116431.awb") ~= 0 then
					local var_363_28 = manager.audio:GetVoiceLength("story_v_out_116431", "116431082", "story_v_out_116431.awb") / 1000

					if var_363_28 + var_363_20 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_28 + var_363_20
					end

					if var_363_23.prefab_name ~= "" and arg_360_1.actors_[var_363_23.prefab_name] ~= nil then
						local var_363_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_23.prefab_name].transform, "story_v_out_116431", "116431082", "story_v_out_116431.awb")

						arg_360_1:RecordAudio("116431082", var_363_29)
						arg_360_1:RecordAudio("116431082", var_363_29)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_116431", "116431082", "story_v_out_116431.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_116431", "116431082", "story_v_out_116431.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_30 = math.max(var_363_21, arg_360_1.talkMaxDuration)

			if var_363_20 <= arg_360_1.time_ and arg_360_1.time_ < var_363_20 + var_363_30 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_20) / var_363_30

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_20 + var_363_30 and arg_360_1.time_ < var_363_20 + var_363_30 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play116431083 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 116431083
		arg_364_1.duration_ = 4.13

		local var_364_0 = {
			zh = 3.866,
			ja = 4.133
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play116431084(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1019ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1019ui_story = var_367_0.localPosition
			end

			local var_367_2 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2
				local var_367_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1019ui_story, var_367_4, var_367_3)

				local var_367_5 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_5.x, var_367_5.y, var_367_5.z)

				local var_367_6 = var_367_0.localEulerAngles

				var_367_6.z = 0
				var_367_6.x = 0
				var_367_0.localEulerAngles = var_367_6
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_367_7 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_7.x, var_367_7.y, var_367_7.z)

				local var_367_8 = var_367_0.localEulerAngles

				var_367_8.z = 0
				var_367_8.x = 0
				var_367_0.localEulerAngles = var_367_8
			end

			local var_367_9 = arg_364_1.actors_["1029ui_story"].transform
			local var_367_10 = 0

			if var_367_10 < arg_364_1.time_ and arg_364_1.time_ <= var_367_10 + arg_367_0 then
				arg_364_1.var_.moveOldPos1029ui_story = var_367_9.localPosition
			end

			local var_367_11 = 0.001

			if var_367_10 <= arg_364_1.time_ and arg_364_1.time_ < var_367_10 + var_367_11 then
				local var_367_12 = (arg_364_1.time_ - var_367_10) / var_367_11
				local var_367_13 = Vector3.New(0.7, -1.09, -6.2)

				var_367_9.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1029ui_story, var_367_13, var_367_12)

				local var_367_14 = manager.ui.mainCamera.transform.position - var_367_9.position

				var_367_9.forward = Vector3.New(var_367_14.x, var_367_14.y, var_367_14.z)

				local var_367_15 = var_367_9.localEulerAngles

				var_367_15.z = 0
				var_367_15.x = 0
				var_367_9.localEulerAngles = var_367_15
			end

			if arg_364_1.time_ >= var_367_10 + var_367_11 and arg_364_1.time_ < var_367_10 + var_367_11 + arg_367_0 then
				var_367_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_367_16 = manager.ui.mainCamera.transform.position - var_367_9.position

				var_367_9.forward = Vector3.New(var_367_16.x, var_367_16.y, var_367_16.z)

				local var_367_17 = var_367_9.localEulerAngles

				var_367_17.z = 0
				var_367_17.x = 0
				var_367_9.localEulerAngles = var_367_17
			end

			local var_367_18 = arg_364_1.actors_["1019ui_story"]
			local var_367_19 = 0

			if var_367_19 < arg_364_1.time_ and arg_364_1.time_ <= var_367_19 + arg_367_0 and not isNil(var_367_18) and arg_364_1.var_.characterEffect1019ui_story == nil then
				arg_364_1.var_.characterEffect1019ui_story = var_367_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_20 = 0.2

			if var_367_19 <= arg_364_1.time_ and arg_364_1.time_ < var_367_19 + var_367_20 and not isNil(var_367_18) then
				local var_367_21 = (arg_364_1.time_ - var_367_19) / var_367_20

				if arg_364_1.var_.characterEffect1019ui_story and not isNil(var_367_18) then
					local var_367_22 = Mathf.Lerp(0, 0.5, var_367_21)

					arg_364_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1019ui_story.fillRatio = var_367_22
				end
			end

			if arg_364_1.time_ >= var_367_19 + var_367_20 and arg_364_1.time_ < var_367_19 + var_367_20 + arg_367_0 and not isNil(var_367_18) and arg_364_1.var_.characterEffect1019ui_story then
				local var_367_23 = 0.5

				arg_364_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1019ui_story.fillRatio = var_367_23
			end

			local var_367_24 = arg_364_1.actors_["1029ui_story"]
			local var_367_25 = 0

			if var_367_25 < arg_364_1.time_ and arg_364_1.time_ <= var_367_25 + arg_367_0 and not isNil(var_367_24) and arg_364_1.var_.characterEffect1029ui_story == nil then
				arg_364_1.var_.characterEffect1029ui_story = var_367_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_26 = 0.2

			if var_367_25 <= arg_364_1.time_ and arg_364_1.time_ < var_367_25 + var_367_26 and not isNil(var_367_24) then
				local var_367_27 = (arg_364_1.time_ - var_367_25) / var_367_26

				if arg_364_1.var_.characterEffect1029ui_story and not isNil(var_367_24) then
					arg_364_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_25 + var_367_26 and arg_364_1.time_ < var_367_25 + var_367_26 + arg_367_0 and not isNil(var_367_24) and arg_364_1.var_.characterEffect1029ui_story then
				arg_364_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_367_28 = 0

			if var_367_28 < arg_364_1.time_ and arg_364_1.time_ <= var_367_28 + arg_367_0 then
				arg_364_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action446")
			end

			local var_367_29 = 0

			if var_367_29 < arg_364_1.time_ and arg_364_1.time_ <= var_367_29 + arg_367_0 then
				arg_364_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_367_30 = 0
			local var_367_31 = 0.375

			if var_367_30 < arg_364_1.time_ and arg_364_1.time_ <= var_367_30 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_32 = arg_364_1:FormatText(StoryNameCfg[319].name)

				arg_364_1.leftNameTxt_.text = var_367_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_33 = arg_364_1:GetWordFromCfg(116431083)
				local var_367_34 = arg_364_1:FormatText(var_367_33.content)

				arg_364_1.text_.text = var_367_34

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_35 = 15
				local var_367_36 = utf8.len(var_367_34)
				local var_367_37 = var_367_35 <= 0 and var_367_31 or var_367_31 * (var_367_36 / var_367_35)

				if var_367_37 > 0 and var_367_31 < var_367_37 then
					arg_364_1.talkMaxDuration = var_367_37

					if var_367_37 + var_367_30 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_37 + var_367_30
					end
				end

				arg_364_1.text_.text = var_367_34
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431083", "story_v_out_116431.awb") ~= 0 then
					local var_367_38 = manager.audio:GetVoiceLength("story_v_out_116431", "116431083", "story_v_out_116431.awb") / 1000

					if var_367_38 + var_367_30 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_38 + var_367_30
					end

					if var_367_33.prefab_name ~= "" and arg_364_1.actors_[var_367_33.prefab_name] ~= nil then
						local var_367_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_33.prefab_name].transform, "story_v_out_116431", "116431083", "story_v_out_116431.awb")

						arg_364_1:RecordAudio("116431083", var_367_39)
						arg_364_1:RecordAudio("116431083", var_367_39)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_116431", "116431083", "story_v_out_116431.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_116431", "116431083", "story_v_out_116431.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_40 = math.max(var_367_31, arg_364_1.talkMaxDuration)

			if var_367_30 <= arg_364_1.time_ and arg_364_1.time_ < var_367_30 + var_367_40 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_30) / var_367_40

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_30 + var_367_40 and arg_364_1.time_ < var_367_30 + var_367_40 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play116431084 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116431084
		arg_368_1.duration_ = 4.83

		local var_368_0 = {
			zh = 4.833,
			ja = 2.9
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116431085(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1019ui_story"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos1019ui_story = var_371_0.localPosition
			end

			local var_371_2 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2
				local var_371_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1019ui_story, var_371_4, var_371_3)

				local var_371_5 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_5.x, var_371_5.y, var_371_5.z)

				local var_371_6 = var_371_0.localEulerAngles

				var_371_6.z = 0
				var_371_6.x = 0
				var_371_0.localEulerAngles = var_371_6
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_371_7 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_7.x, var_371_7.y, var_371_7.z)

				local var_371_8 = var_371_0.localEulerAngles

				var_371_8.z = 0
				var_371_8.x = 0
				var_371_0.localEulerAngles = var_371_8
			end

			local var_371_9 = arg_368_1.actors_["1029ui_story"].transform
			local var_371_10 = 0

			if var_371_10 < arg_368_1.time_ and arg_368_1.time_ <= var_371_10 + arg_371_0 then
				arg_368_1.var_.moveOldPos1029ui_story = var_371_9.localPosition
			end

			local var_371_11 = 0.001

			if var_371_10 <= arg_368_1.time_ and arg_368_1.time_ < var_371_10 + var_371_11 then
				local var_371_12 = (arg_368_1.time_ - var_371_10) / var_371_11
				local var_371_13 = Vector3.New(0.7, -1.09, -6.2)

				var_371_9.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1029ui_story, var_371_13, var_371_12)

				local var_371_14 = manager.ui.mainCamera.transform.position - var_371_9.position

				var_371_9.forward = Vector3.New(var_371_14.x, var_371_14.y, var_371_14.z)

				local var_371_15 = var_371_9.localEulerAngles

				var_371_15.z = 0
				var_371_15.x = 0
				var_371_9.localEulerAngles = var_371_15
			end

			if arg_368_1.time_ >= var_371_10 + var_371_11 and arg_368_1.time_ < var_371_10 + var_371_11 + arg_371_0 then
				var_371_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_371_16 = manager.ui.mainCamera.transform.position - var_371_9.position

				var_371_9.forward = Vector3.New(var_371_16.x, var_371_16.y, var_371_16.z)

				local var_371_17 = var_371_9.localEulerAngles

				var_371_17.z = 0
				var_371_17.x = 0
				var_371_9.localEulerAngles = var_371_17
			end

			local var_371_18 = 0

			if var_371_18 < arg_368_1.time_ and arg_368_1.time_ <= var_371_18 + arg_371_0 then
				arg_368_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_371_19 = 0
			local var_371_20 = 0.266666666666667

			if var_371_19 < arg_368_1.time_ and arg_368_1.time_ <= var_371_19 + arg_371_0 then
				local var_371_21 = "play"
				local var_371_22 = "music"

				arg_368_1:AudioAction(var_371_21, var_371_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_371_23 = ""
				local var_371_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_371_24 ~= "" then
					if arg_368_1.bgmTxt_.text ~= var_371_24 and arg_368_1.bgmTxt_.text ~= "" then
						if arg_368_1.bgmTxt2_.text ~= "" then
							arg_368_1.bgmTxt_.text = arg_368_1.bgmTxt2_.text
						end

						arg_368_1.bgmTxt2_.text = var_371_24

						arg_368_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_368_1.bgmTxt_.text = var_371_24
						arg_368_1.bgmTxt2_.text = var_371_24
					end

					if arg_368_1.bgmTimer then
						arg_368_1.bgmTimer:Stop()

						arg_368_1.bgmTimer = nil
					end

					if arg_368_1.settingData.show_music_name == 1 then
						arg_368_1.musicController:SetSelectedState("show")
						arg_368_1.musicAnimator_:Play("open", 0, 0)

						if arg_368_1.settingData.music_time ~= 0 then
							arg_368_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_368_1.settingData.music_time), function()
								if arg_368_1 == nil or isNil(arg_368_1.bgmTxt_) then
									return
								end

								arg_368_1.musicController:SetSelectedState("hide")
								arg_368_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_371_25 = 0
			local var_371_26 = 0.325

			if var_371_25 < arg_368_1.time_ and arg_368_1.time_ <= var_371_25 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_27 = arg_368_1:FormatText(StoryNameCfg[319].name)

				arg_368_1.leftNameTxt_.text = var_371_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_28 = arg_368_1:GetWordFromCfg(116431084)
				local var_371_29 = arg_368_1:FormatText(var_371_28.content)

				arg_368_1.text_.text = var_371_29

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_30 = 13
				local var_371_31 = utf8.len(var_371_29)
				local var_371_32 = var_371_30 <= 0 and var_371_26 or var_371_26 * (var_371_31 / var_371_30)

				if var_371_32 > 0 and var_371_26 < var_371_32 then
					arg_368_1.talkMaxDuration = var_371_32

					if var_371_32 + var_371_25 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_32 + var_371_25
					end
				end

				arg_368_1.text_.text = var_371_29
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431084", "story_v_out_116431.awb") ~= 0 then
					local var_371_33 = manager.audio:GetVoiceLength("story_v_out_116431", "116431084", "story_v_out_116431.awb") / 1000

					if var_371_33 + var_371_25 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_33 + var_371_25
					end

					if var_371_28.prefab_name ~= "" and arg_368_1.actors_[var_371_28.prefab_name] ~= nil then
						local var_371_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_28.prefab_name].transform, "story_v_out_116431", "116431084", "story_v_out_116431.awb")

						arg_368_1:RecordAudio("116431084", var_371_34)
						arg_368_1:RecordAudio("116431084", var_371_34)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_116431", "116431084", "story_v_out_116431.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_116431", "116431084", "story_v_out_116431.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_35 = math.max(var_371_26, arg_368_1.talkMaxDuration)

			if var_371_25 <= arg_368_1.time_ and arg_368_1.time_ < var_371_25 + var_371_35 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_25) / var_371_35

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_25 + var_371_35 and arg_368_1.time_ < var_371_25 + var_371_35 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play116431085 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 116431085
		arg_373_1.duration_ = 13.58

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play116431086(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 2

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				local var_376_1 = manager.ui.mainCamera.transform.localPosition
				local var_376_2 = Vector3.New(0, 0, 10) + Vector3.New(var_376_1.x, var_376_1.y, 0)
				local var_376_3 = arg_373_1.bgs_.STblack

				var_376_3.transform.localPosition = var_376_2
				var_376_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_4 = var_376_3:GetComponent("SpriteRenderer")

				if var_376_4 and var_376_4.sprite then
					local var_376_5 = (var_376_3.transform.localPosition - var_376_1).z
					local var_376_6 = manager.ui.mainCameraCom_
					local var_376_7 = 2 * var_376_5 * Mathf.Tan(var_376_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_376_8 = var_376_7 * var_376_6.aspect
					local var_376_9 = var_376_4.sprite.bounds.size.x
					local var_376_10 = var_376_4.sprite.bounds.size.y
					local var_376_11 = var_376_8 / var_376_9
					local var_376_12 = var_376_7 / var_376_10
					local var_376_13 = var_376_12 < var_376_11 and var_376_11 or var_376_12

					var_376_3.transform.localScale = Vector3.New(var_376_13, var_376_13, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "STblack" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_14 = 0

			if var_376_14 < arg_373_1.time_ and arg_373_1.time_ <= var_376_14 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_15 = 2

			if var_376_14 <= arg_373_1.time_ and arg_373_1.time_ < var_376_14 + var_376_15 then
				local var_376_16 = (arg_373_1.time_ - var_376_14) / var_376_15
				local var_376_17 = Color.New(0, 0, 0)

				var_376_17.a = Mathf.Lerp(0, 1, var_376_16)
				arg_373_1.mask_.color = var_376_17
			end

			if arg_373_1.time_ >= var_376_14 + var_376_15 and arg_373_1.time_ < var_376_14 + var_376_15 + arg_376_0 then
				local var_376_18 = Color.New(0, 0, 0)

				var_376_18.a = 1
				arg_373_1.mask_.color = var_376_18
			end

			local var_376_19 = 2

			if var_376_19 < arg_373_1.time_ and arg_373_1.time_ <= var_376_19 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_20 = 2

			if var_376_19 <= arg_373_1.time_ and arg_373_1.time_ < var_376_19 + var_376_20 then
				local var_376_21 = (arg_373_1.time_ - var_376_19) / var_376_20
				local var_376_22 = Color.New(0, 0, 0)

				var_376_22.a = Mathf.Lerp(1, 0, var_376_21)
				arg_373_1.mask_.color = var_376_22
			end

			if arg_373_1.time_ >= var_376_19 + var_376_20 and arg_373_1.time_ < var_376_19 + var_376_20 + arg_376_0 then
				local var_376_23 = Color.New(0, 0, 0)
				local var_376_24 = 0

				arg_373_1.mask_.enabled = false
				var_376_23.a = var_376_24
				arg_373_1.mask_.color = var_376_23
			end

			local var_376_25 = arg_373_1.actors_["1019ui_story"].transform
			local var_376_26 = 1.966

			if var_376_26 < arg_373_1.time_ and arg_373_1.time_ <= var_376_26 + arg_376_0 then
				arg_373_1.var_.moveOldPos1019ui_story = var_376_25.localPosition
			end

			local var_376_27 = 0.001

			if var_376_26 <= arg_373_1.time_ and arg_373_1.time_ < var_376_26 + var_376_27 then
				local var_376_28 = (arg_373_1.time_ - var_376_26) / var_376_27
				local var_376_29 = Vector3.New(0, 100, 0)

				var_376_25.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1019ui_story, var_376_29, var_376_28)

				local var_376_30 = manager.ui.mainCamera.transform.position - var_376_25.position

				var_376_25.forward = Vector3.New(var_376_30.x, var_376_30.y, var_376_30.z)

				local var_376_31 = var_376_25.localEulerAngles

				var_376_31.z = 0
				var_376_31.x = 0
				var_376_25.localEulerAngles = var_376_31
			end

			if arg_373_1.time_ >= var_376_26 + var_376_27 and arg_373_1.time_ < var_376_26 + var_376_27 + arg_376_0 then
				var_376_25.localPosition = Vector3.New(0, 100, 0)

				local var_376_32 = manager.ui.mainCamera.transform.position - var_376_25.position

				var_376_25.forward = Vector3.New(var_376_32.x, var_376_32.y, var_376_32.z)

				local var_376_33 = var_376_25.localEulerAngles

				var_376_33.z = 0
				var_376_33.x = 0
				var_376_25.localEulerAngles = var_376_33
			end

			local var_376_34 = arg_373_1.actors_["1029ui_story"].transform
			local var_376_35 = 1.966

			if var_376_35 < arg_373_1.time_ and arg_373_1.time_ <= var_376_35 + arg_376_0 then
				arg_373_1.var_.moveOldPos1029ui_story = var_376_34.localPosition
			end

			local var_376_36 = 0.001

			if var_376_35 <= arg_373_1.time_ and arg_373_1.time_ < var_376_35 + var_376_36 then
				local var_376_37 = (arg_373_1.time_ - var_376_35) / var_376_36
				local var_376_38 = Vector3.New(0, 100, 0)

				var_376_34.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1029ui_story, var_376_38, var_376_37)

				local var_376_39 = manager.ui.mainCamera.transform.position - var_376_34.position

				var_376_34.forward = Vector3.New(var_376_39.x, var_376_39.y, var_376_39.z)

				local var_376_40 = var_376_34.localEulerAngles

				var_376_40.z = 0
				var_376_40.x = 0
				var_376_34.localEulerAngles = var_376_40
			end

			if arg_373_1.time_ >= var_376_35 + var_376_36 and arg_373_1.time_ < var_376_35 + var_376_36 + arg_376_0 then
				var_376_34.localPosition = Vector3.New(0, 100, 0)

				local var_376_41 = manager.ui.mainCamera.transform.position - var_376_34.position

				var_376_34.forward = Vector3.New(var_376_41.x, var_376_41.y, var_376_41.z)

				local var_376_42 = var_376_34.localEulerAngles

				var_376_42.z = 0
				var_376_42.x = 0
				var_376_34.localEulerAngles = var_376_42
			end

			local var_376_43 = 0

			if var_376_43 < arg_373_1.time_ and arg_373_1.time_ <= var_376_43 + arg_376_0 then
				arg_373_1.fswbg_:SetActive(true)
				arg_373_1.dialog_:SetActive(false)

				arg_373_1.fswtw_.percent = 0

				local var_376_44 = arg_373_1:GetWordFromCfg(116431085)
				local var_376_45 = arg_373_1:FormatText(var_376_44.content)

				arg_373_1.fswt_.text = var_376_45

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.fswt_)

				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_373_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_373_1.fswtw_:SetDirty()

				arg_373_1.typewritterCharCountI18N = 0

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_46 = 0

			if var_376_46 < arg_373_1.time_ and arg_373_1.time_ <= var_376_46 + arg_376_0 then
				arg_373_1.fswbg_:SetActive(true)
				arg_373_1.dialog_:SetActive(false)

				arg_373_1.fswtw_.percent = 0

				local var_376_47 = arg_373_1:GetWordFromCfg(116431085)
				local var_376_48 = arg_373_1:FormatText(var_376_47.content)

				arg_373_1.fswt_.text = var_376_48

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.fswt_)

				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_373_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_373_1.fswtw_:SetDirty()

				arg_373_1.typewritterCharCountI18N = 0

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_49 = 4.01666666666667

			if var_376_49 < arg_373_1.time_ and arg_373_1.time_ <= var_376_49 + arg_376_0 then
				arg_373_1.var_.oldValueTypewriter = arg_373_1.fswtw_.percent

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_50 = 37
			local var_376_51 = 2.46666666666667
			local var_376_52 = arg_373_1:GetWordFromCfg(116431085)
			local var_376_53 = arg_373_1:FormatText(var_376_52.content)
			local var_376_54, var_376_55 = arg_373_1:GetPercentByPara(var_376_53, 1)

			if var_376_49 < arg_373_1.time_ and arg_373_1.time_ <= var_376_49 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				local var_376_56 = var_376_50 <= 0 and var_376_51 or var_376_51 * ((var_376_55 - arg_373_1.typewritterCharCountI18N) / var_376_50)

				if var_376_56 > 0 and var_376_51 < var_376_56 then
					arg_373_1.talkMaxDuration = var_376_56

					if var_376_56 + var_376_49 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_56 + var_376_49
					end
				end
			end

			local var_376_57 = 2.46666666666667
			local var_376_58 = math.max(var_376_57, arg_373_1.talkMaxDuration)

			if var_376_49 <= arg_373_1.time_ and arg_373_1.time_ < var_376_49 + var_376_58 then
				local var_376_59 = (arg_373_1.time_ - var_376_49) / var_376_58

				arg_373_1.fswtw_.percent = Mathf.Lerp(arg_373_1.var_.oldValueTypewriter, var_376_54, var_376_59)
				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.fswtw_:SetDirty()
			end

			if arg_373_1.time_ >= var_376_49 + var_376_58 and arg_373_1.time_ < var_376_49 + var_376_58 + arg_376_0 then
				arg_373_1.fswtw_.percent = var_376_54

				arg_373_1.fswtw_:SetDirty()
				arg_373_1:ShowNextGo(true)

				arg_373_1.typewritterCharCountI18N = var_376_55
			end

			local var_376_60 = 4.01666666666667
			local var_376_61 = 9.566
			local var_376_62 = manager.audio:GetVoiceLength("story_v_out_116431", "116431085", "story_v_out_116431.awb") / 1000

			if var_376_62 > 0 and var_376_61 < var_376_62 and var_376_62 + var_376_60 > arg_373_1.duration_ then
				local var_376_63 = var_376_62

				arg_373_1.duration_ = var_376_62 + var_376_60
			end

			if var_376_60 < arg_373_1.time_ and arg_373_1.time_ <= var_376_60 + arg_376_0 then
				local var_376_64 = "play"
				local var_376_65 = "voice"

				arg_373_1:AudioAction(var_376_64, var_376_65, "story_v_out_116431", "116431085", "story_v_out_116431.awb")
			end

			local var_376_66 = 0
			local var_376_67 = 0.666666666666667

			if var_376_66 < arg_373_1.time_ and arg_373_1.time_ <= var_376_66 + arg_376_0 then
				local var_376_68 = "play"
				local var_376_69 = "music"

				arg_373_1:AudioAction(var_376_68, var_376_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_376_70 = ""
				local var_376_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_376_71 ~= "" then
					if arg_373_1.bgmTxt_.text ~= var_376_71 and arg_373_1.bgmTxt_.text ~= "" then
						if arg_373_1.bgmTxt2_.text ~= "" then
							arg_373_1.bgmTxt_.text = arg_373_1.bgmTxt2_.text
						end

						arg_373_1.bgmTxt2_.text = var_376_71

						arg_373_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_373_1.bgmTxt_.text = var_376_71
						arg_373_1.bgmTxt2_.text = var_376_71
					end

					if arg_373_1.bgmTimer then
						arg_373_1.bgmTimer:Stop()

						arg_373_1.bgmTimer = nil
					end

					if arg_373_1.settingData.show_music_name == 1 then
						arg_373_1.musicController:SetSelectedState("show")
						arg_373_1.musicAnimator_:Play("open", 0, 0)

						if arg_373_1.settingData.music_time ~= 0 then
							arg_373_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_373_1.settingData.music_time), function()
								if arg_373_1 == nil or isNil(arg_373_1.bgmTxt_) then
									return
								end

								arg_373_1.musicController:SetSelectedState("hide")
								arg_373_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_376_72 = 0.866666666666667
			local var_376_73 = 1.13333333333333

			if var_376_72 < arg_373_1.time_ and arg_373_1.time_ <= var_376_72 + arg_376_0 then
				local var_376_74 = "play"
				local var_376_75 = "music"

				arg_373_1:AudioAction(var_376_74, var_376_75, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_376_76 = ""
				local var_376_77 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_376_77 ~= "" then
					if arg_373_1.bgmTxt_.text ~= var_376_77 and arg_373_1.bgmTxt_.text ~= "" then
						if arg_373_1.bgmTxt2_.text ~= "" then
							arg_373_1.bgmTxt_.text = arg_373_1.bgmTxt2_.text
						end

						arg_373_1.bgmTxt2_.text = var_376_77

						arg_373_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_373_1.bgmTxt_.text = var_376_77
						arg_373_1.bgmTxt2_.text = var_376_77
					end

					if arg_373_1.bgmTimer then
						arg_373_1.bgmTimer:Stop()

						arg_373_1.bgmTimer = nil
					end

					if arg_373_1.settingData.show_music_name == 1 then
						arg_373_1.musicController:SetSelectedState("show")
						arg_373_1.musicAnimator_:Play("open", 0, 0)

						if arg_373_1.settingData.music_time ~= 0 then
							arg_373_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_373_1.settingData.music_time), function()
								if arg_373_1 == nil or isNil(arg_373_1.bgmTxt_) then
									return
								end

								arg_373_1.musicController:SetSelectedState("hide")
								arg_373_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_376_78 = 4.08333333333333

			if var_376_78 < arg_373_1.time_ and arg_373_1.time_ <= var_376_78 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			local var_376_79 = 2.4

			if arg_373_1.time_ >= var_376_78 + var_376_79 and arg_373_1.time_ < var_376_78 + var_376_79 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play116431086 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 116431086
		arg_379_1.duration_ = 13.75

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play116431087(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.var_.oldValueTypewriter = arg_379_1.fswtw_.percent

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_1 = 99
			local var_382_2 = 4.13333333333333
			local var_382_3 = arg_379_1:GetWordFromCfg(116431085)
			local var_382_4 = arg_379_1:FormatText(var_382_3.content)
			local var_382_5, var_382_6 = arg_379_1:GetPercentByPara(var_382_4, 3)

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				local var_382_7 = var_382_1 <= 0 and var_382_2 or var_382_2 * ((var_382_6 - arg_379_1.typewritterCharCountI18N) / var_382_1)

				if var_382_7 > 0 and var_382_2 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end
			end

			local var_382_8 = 4.13333333333333
			local var_382_9 = math.max(var_382_8, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_9 then
				local var_382_10 = (arg_379_1.time_ - var_382_0) / var_382_9

				arg_379_1.fswtw_.percent = Mathf.Lerp(arg_379_1.var_.oldValueTypewriter, var_382_5, var_382_10)
				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_379_1.fswtw_:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_9 and arg_379_1.time_ < var_382_0 + var_382_9 + arg_382_0 then
				arg_379_1.fswtw_.percent = var_382_5

				arg_379_1.fswtw_:SetDirty()
				arg_379_1:ShowNextGo(true)

				arg_379_1.typewritterCharCountI18N = var_382_6
			end

			local var_382_11 = 0
			local var_382_12 = 13.747
			local var_382_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431086", "story_v_out_116431.awb") / 1000

			if var_382_13 > 0 and var_382_12 < var_382_13 and var_382_13 + var_382_11 > arg_379_1.duration_ then
				local var_382_14 = var_382_13

				arg_379_1.duration_ = var_382_13 + var_382_11
			end

			if var_382_11 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				local var_382_15 = "play"
				local var_382_16 = "voice"

				arg_379_1:AudioAction(var_382_15, var_382_16, "story_v_out_116431", "116431086", "story_v_out_116431.awb")
			end

			local var_382_17 = 0

			if var_382_17 < arg_379_1.time_ and arg_379_1.time_ <= var_382_17 + arg_382_0 then
				arg_379_1.allBtn_.enabled = false
			end

			local var_382_18 = 4.1

			if arg_379_1.time_ >= var_382_17 + var_382_18 and arg_379_1.time_ < var_382_17 + var_382_18 + arg_382_0 then
				arg_379_1.allBtn_.enabled = true
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play116431087 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 116431087
		arg_383_1.duration_ = 14.61

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play116431088(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.var_.oldValueTypewriter = arg_383_1.fswtw_.percent

				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_1 = 61
			local var_386_2 = 4.06666666666667
			local var_386_3 = arg_383_1:GetWordFromCfg(116431085)
			local var_386_4 = arg_383_1:FormatText(var_386_3.content)
			local var_386_5, var_386_6 = arg_383_1:GetPercentByPara(var_386_4, 5)

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				local var_386_7 = var_386_1 <= 0 and var_386_2 or var_386_2 * ((var_386_6 - arg_383_1.typewritterCharCountI18N) / var_386_1)

				if var_386_7 > 0 and var_386_2 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end
			end

			local var_386_8 = 4.06666666666667
			local var_386_9 = math.max(var_386_8, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_9 then
				local var_386_10 = (arg_383_1.time_ - var_386_0) / var_386_9

				arg_383_1.fswtw_.percent = Mathf.Lerp(arg_383_1.var_.oldValueTypewriter, var_386_5, var_386_10)
				arg_383_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_383_1.fswtw_:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_9 and arg_383_1.time_ < var_386_0 + var_386_9 + arg_386_0 then
				arg_383_1.fswtw_.percent = var_386_5

				arg_383_1.fswtw_:SetDirty()
				arg_383_1:ShowNextGo(true)

				arg_383_1.typewritterCharCountI18N = var_386_6
			end

			local var_386_11 = 0
			local var_386_12 = 14.61
			local var_386_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431087", "story_v_out_116431.awb") / 1000

			if var_386_13 > 0 and var_386_12 < var_386_13 and var_386_13 + var_386_11 > arg_383_1.duration_ then
				local var_386_14 = var_386_13

				arg_383_1.duration_ = var_386_13 + var_386_11
			end

			if var_386_11 < arg_383_1.time_ and arg_383_1.time_ <= var_386_11 + arg_386_0 then
				local var_386_15 = "play"
				local var_386_16 = "voice"

				arg_383_1:AudioAction(var_386_15, var_386_16, "story_v_out_116431", "116431087", "story_v_out_116431.awb")
			end

			local var_386_17 = 0

			if var_386_17 < arg_383_1.time_ and arg_383_1.time_ <= var_386_17 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			local var_386_18 = 4.06666666666667

			if arg_383_1.time_ >= var_386_17 + var_386_18 and arg_383_1.time_ < var_386_17 + var_386_18 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play116431088 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 116431088
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play116431089(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.fswbg_:SetActive(false)
				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_387_1:ShowNextGo(false)
			end

			local var_390_1 = 0
			local var_390_2 = 0.175

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_3 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_3:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_4 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_5 = arg_387_1:GetWordFromCfg(116431088)
				local var_390_6 = arg_387_1:FormatText(var_390_5.content)

				arg_387_1.text_.text = var_390_6

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 7
				local var_390_8 = utf8.len(var_390_6)
				local var_390_9 = var_390_7 <= 0 and var_390_2 or var_390_2 * (var_390_8 / var_390_7)

				if var_390_9 > 0 and var_390_2 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9
					var_390_1 = var_390_1 + 0.3

					if var_390_9 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_6
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = var_390_1 + 0.3
			local var_390_11 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_10) / var_390_11

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play116431089 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 116431089
		arg_393_1.duration_ = 1.27

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play116431090(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.fswbg_:SetActive(true)
				arg_393_1.dialog_:SetActive(false)

				arg_393_1.fswtw_.percent = 0

				local var_396_1 = arg_393_1:GetWordFromCfg(116431089)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.fswt_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.fswt_)

				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_393_1.fswtw_:SetDirty()

				arg_393_1.typewritterCharCountI18N = 0

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_3 = 0.0166666666666667

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.var_.oldValueTypewriter = arg_393_1.fswtw_.percent

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_4 = 3
			local var_396_5 = 0.2
			local var_396_6 = arg_393_1:GetWordFromCfg(116431089)
			local var_396_7 = arg_393_1:FormatText(var_396_6.content)
			local var_396_8, var_396_9 = arg_393_1:GetPercentByPara(var_396_7, 1)

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				local var_396_10 = var_396_4 <= 0 and var_396_5 or var_396_5 * ((var_396_9 - arg_393_1.typewritterCharCountI18N) / var_396_4)

				if var_396_10 > 0 and var_396_5 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_3 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_3
					end
				end
			end

			local var_396_11 = 0.2
			local var_396_12 = math.max(var_396_11, arg_393_1.talkMaxDuration)

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_12 then
				local var_396_13 = (arg_393_1.time_ - var_396_3) / var_396_12

				arg_393_1.fswtw_.percent = Mathf.Lerp(arg_393_1.var_.oldValueTypewriter, var_396_8, var_396_13)
				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_393_1.fswtw_:SetDirty()
			end

			if arg_393_1.time_ >= var_396_3 + var_396_12 and arg_393_1.time_ < var_396_3 + var_396_12 + arg_396_0 then
				arg_393_1.fswtw_.percent = var_396_8

				arg_393_1.fswtw_:SetDirty()
				arg_393_1:ShowNextGo(true)

				arg_393_1.typewritterCharCountI18N = var_396_9
			end

			local var_396_14 = 0
			local var_396_15 = 1.275
			local var_396_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431089", "story_v_out_116431.awb") / 1000

			if var_396_16 > 0 and var_396_15 < var_396_16 and var_396_16 + var_396_14 > arg_393_1.duration_ then
				local var_396_17 = var_396_16

				arg_393_1.duration_ = var_396_16 + var_396_14
			end

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				local var_396_18 = "play"
				local var_396_19 = "voice"

				arg_393_1:AudioAction(var_396_18, var_396_19, "story_v_out_116431", "116431089", "story_v_out_116431.awb")
			end

			local var_396_20 = 0

			if var_396_20 < arg_393_1.time_ and arg_393_1.time_ <= var_396_20 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			local var_396_21 = 0.216666666666667

			if arg_393_1.time_ >= var_396_20 + var_396_21 and arg_393_1.time_ < var_396_20 + var_396_21 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play116431090 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 116431090
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play116431091(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(false)
				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_397_1:ShowNextGo(false)
			end

			local var_400_1 = 0
			local var_400_2 = 0.15

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_3 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_3:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_4 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_5 = arg_397_1:GetWordFromCfg(116431090)
				local var_400_6 = arg_397_1:FormatText(var_400_5.content)

				arg_397_1.text_.text = var_400_6

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 6
				local var_400_8 = utf8.len(var_400_6)
				local var_400_9 = var_400_7 <= 0 and var_400_2 or var_400_2 * (var_400_8 / var_400_7)

				if var_400_9 > 0 and var_400_2 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9
					var_400_1 = var_400_1 + 0.3

					if var_400_9 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_6
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = var_400_1 + 0.3
			local var_400_11 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_10 <= arg_397_1.time_ and arg_397_1.time_ < var_400_10 + var_400_11 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_10) / var_400_11

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_10 + var_400_11 and arg_397_1.time_ < var_400_10 + var_400_11 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play116431091 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 116431091
		arg_403_1.duration_ = 4.29

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play116431092(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.fswbg_:SetActive(true)
				arg_403_1.dialog_:SetActive(false)

				arg_403_1.fswtw_.percent = 0

				local var_406_1 = arg_403_1:GetWordFromCfg(116431091)
				local var_406_2 = arg_403_1:FormatText(var_406_1.content)

				arg_403_1.fswt_.text = var_406_2

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.fswt_)

				arg_403_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_403_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_403_1.fswtw_:SetDirty()

				arg_403_1.typewritterCharCountI18N = 0

				SetActive(arg_403_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_403_1:ShowNextGo(false)
			end

			local var_406_3 = 0.0166666666666667

			if var_406_3 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 then
				arg_403_1.var_.oldValueTypewriter = arg_403_1.fswtw_.percent

				SetActive(arg_403_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_403_1:ShowNextGo(false)
			end

			local var_406_4 = 10
			local var_406_5 = 0.666666666666667
			local var_406_6 = arg_403_1:GetWordFromCfg(116431091)
			local var_406_7 = arg_403_1:FormatText(var_406_6.content)
			local var_406_8, var_406_9 = arg_403_1:GetPercentByPara(var_406_7, 1)

			if var_406_3 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				local var_406_10 = var_406_4 <= 0 and var_406_5 or var_406_5 * ((var_406_9 - arg_403_1.typewritterCharCountI18N) / var_406_4)

				if var_406_10 > 0 and var_406_5 < var_406_10 then
					arg_403_1.talkMaxDuration = var_406_10

					if var_406_10 + var_406_3 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_3
					end
				end
			end

			local var_406_11 = 0.666666666666667
			local var_406_12 = math.max(var_406_11, arg_403_1.talkMaxDuration)

			if var_406_3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_3 + var_406_12 then
				local var_406_13 = (arg_403_1.time_ - var_406_3) / var_406_12

				arg_403_1.fswtw_.percent = Mathf.Lerp(arg_403_1.var_.oldValueTypewriter, var_406_8, var_406_13)
				arg_403_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_403_1.fswtw_:SetDirty()
			end

			if arg_403_1.time_ >= var_406_3 + var_406_12 and arg_403_1.time_ < var_406_3 + var_406_12 + arg_406_0 then
				arg_403_1.fswtw_.percent = var_406_8

				arg_403_1.fswtw_:SetDirty()
				arg_403_1:ShowNextGo(true)

				arg_403_1.typewritterCharCountI18N = var_406_9
			end

			local var_406_14 = 0
			local var_406_15 = 4.293
			local var_406_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431091", "story_v_out_116431.awb") / 1000

			if var_406_16 > 0 and var_406_15 < var_406_16 and var_406_16 + var_406_14 > arg_403_1.duration_ then
				local var_406_17 = var_406_16

				arg_403_1.duration_ = var_406_16 + var_406_14
			end

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				local var_406_18 = "play"
				local var_406_19 = "voice"

				arg_403_1:AudioAction(var_406_18, var_406_19, "story_v_out_116431", "116431091", "story_v_out_116431.awb")
			end

			local var_406_20 = 0

			if var_406_20 < arg_403_1.time_ and arg_403_1.time_ <= var_406_20 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			local var_406_21 = 0.683333333333333

			if arg_403_1.time_ >= var_406_20 + var_406_21 and arg_403_1.time_ < var_406_20 + var_406_21 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play116431092 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 116431092
		arg_407_1.duration_ = 12.35

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play116431093(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.var_.oldValueTypewriter = arg_407_1.fswtw_.percent

				SetActive(arg_407_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_407_1:ShowNextGo(false)
			end

			local var_410_1 = 49
			local var_410_2 = 3.2
			local var_410_3 = arg_407_1:GetWordFromCfg(116431091)
			local var_410_4 = arg_407_1:FormatText(var_410_3.content)
			local var_410_5, var_410_6 = arg_407_1:GetPercentByPara(var_410_4, 3)

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0

				local var_410_7 = var_410_1 <= 0 and var_410_2 or var_410_2 * ((var_410_6 - arg_407_1.typewritterCharCountI18N) / var_410_1)

				if var_410_7 > 0 and var_410_2 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end
			end

			local var_410_8 = 3.2
			local var_410_9 = math.max(var_410_8, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_9 then
				local var_410_10 = (arg_407_1.time_ - var_410_0) / var_410_9

				arg_407_1.fswtw_.percent = Mathf.Lerp(arg_407_1.var_.oldValueTypewriter, var_410_5, var_410_10)
				arg_407_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_407_1.fswtw_:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_9 and arg_407_1.time_ < var_410_0 + var_410_9 + arg_410_0 then
				arg_407_1.fswtw_.percent = var_410_5

				arg_407_1.fswtw_:SetDirty()
				arg_407_1:ShowNextGo(true)

				arg_407_1.typewritterCharCountI18N = var_410_6
			end

			local var_410_11 = 0
			local var_410_12 = 12.348
			local var_410_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431092", "story_v_out_116431.awb") / 1000

			if var_410_13 > 0 and var_410_12 < var_410_13 and var_410_13 + var_410_11 > arg_407_1.duration_ then
				local var_410_14 = var_410_13

				arg_407_1.duration_ = var_410_13 + var_410_11
			end

			if var_410_11 < arg_407_1.time_ and arg_407_1.time_ <= var_410_11 + arg_410_0 then
				local var_410_15 = "play"
				local var_410_16 = "voice"

				arg_407_1:AudioAction(var_410_15, var_410_16, "story_v_out_116431", "116431092", "story_v_out_116431.awb")
			end

			local var_410_17 = 0

			if var_410_17 < arg_407_1.time_ and arg_407_1.time_ <= var_410_17 + arg_410_0 then
				arg_407_1.allBtn_.enabled = false
			end

			local var_410_18 = 3.2

			if arg_407_1.time_ >= var_410_17 + var_410_18 and arg_407_1.time_ < var_410_17 + var_410_18 + arg_410_0 then
				arg_407_1.allBtn_.enabled = true
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play116431093 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 116431093
		arg_411_1.duration_ = 4.07

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play116431094(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.var_.oldValueTypewriter = arg_411_1.fswtw_.percent

				SetActive(arg_411_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_411_1:ShowNextGo(false)
			end

			local var_414_1 = 17
			local var_414_2 = 1.13333333333333
			local var_414_3 = arg_411_1:GetWordFromCfg(116431091)
			local var_414_4 = arg_411_1:FormatText(var_414_3.content)
			local var_414_5, var_414_6 = arg_411_1:GetPercentByPara(var_414_4, 4)

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0

				local var_414_7 = var_414_1 <= 0 and var_414_2 or var_414_2 * ((var_414_6 - arg_411_1.typewritterCharCountI18N) / var_414_1)

				if var_414_7 > 0 and var_414_2 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end
			end

			local var_414_8 = 1.13333333333333
			local var_414_9 = math.max(var_414_8, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_9 then
				local var_414_10 = (arg_411_1.time_ - var_414_0) / var_414_9

				arg_411_1.fswtw_.percent = Mathf.Lerp(arg_411_1.var_.oldValueTypewriter, var_414_5, var_414_10)
				arg_411_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_411_1.fswtw_:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_9 and arg_411_1.time_ < var_414_0 + var_414_9 + arg_414_0 then
				arg_411_1.fswtw_.percent = var_414_5

				arg_411_1.fswtw_:SetDirty()
				arg_411_1:ShowNextGo(true)

				arg_411_1.typewritterCharCountI18N = var_414_6
			end

			local var_414_11 = 0
			local var_414_12 = 4.067
			local var_414_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431093", "story_v_out_116431.awb") / 1000

			if var_414_13 > 0 and var_414_12 < var_414_13 and var_414_13 + var_414_11 > arg_411_1.duration_ then
				local var_414_14 = var_414_13

				arg_411_1.duration_ = var_414_13 + var_414_11
			end

			if var_414_11 < arg_411_1.time_ and arg_411_1.time_ <= var_414_11 + arg_414_0 then
				local var_414_15 = "play"
				local var_414_16 = "voice"

				arg_411_1:AudioAction(var_414_15, var_414_16, "story_v_out_116431", "116431093", "story_v_out_116431.awb")
			end

			local var_414_17 = 0

			if var_414_17 < arg_411_1.time_ and arg_411_1.time_ <= var_414_17 + arg_414_0 then
				arg_411_1.allBtn_.enabled = false
			end

			local var_414_18 = 1.13333333333333

			if arg_411_1.time_ >= var_414_17 + var_414_18 and arg_411_1.time_ < var_414_17 + var_414_18 + arg_414_0 then
				arg_411_1.allBtn_.enabled = true
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play116431094 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 116431094
		arg_415_1.duration_ = 7.19

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play116431095(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_1 = 30
			local var_418_2 = 2
			local var_418_3 = arg_415_1:GetWordFromCfg(116431091)
			local var_418_4 = arg_415_1:FormatText(var_418_3.content)
			local var_418_5, var_418_6 = arg_415_1:GetPercentByPara(var_418_4, 5)

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_7 = var_418_1 <= 0 and var_418_2 or var_418_2 * ((var_418_6 - arg_415_1.typewritterCharCountI18N) / var_418_1)

				if var_418_7 > 0 and var_418_2 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end
			end

			local var_418_8 = 2
			local var_418_9 = math.max(var_418_8, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_9 then
				local var_418_10 = (arg_415_1.time_ - var_418_0) / var_418_9

				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_5, var_418_10)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_9 and arg_415_1.time_ < var_418_0 + var_418_9 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_5

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_6
			end

			local var_418_11 = 0
			local var_418_12 = 7.192
			local var_418_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431094", "story_v_out_116431.awb") / 1000

			if var_418_13 > 0 and var_418_12 < var_418_13 and var_418_13 + var_418_11 > arg_415_1.duration_ then
				local var_418_14 = var_418_13

				arg_415_1.duration_ = var_418_13 + var_418_11
			end

			if var_418_11 < arg_415_1.time_ and arg_415_1.time_ <= var_418_11 + arg_418_0 then
				local var_418_15 = "play"
				local var_418_16 = "voice"

				arg_415_1:AudioAction(var_418_15, var_418_16, "story_v_out_116431", "116431094", "story_v_out_116431.awb")
			end

			local var_418_17 = 0

			if var_418_17 < arg_415_1.time_ and arg_415_1.time_ <= var_418_17 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			local var_418_18 = 2

			if arg_415_1.time_ >= var_418_17 + var_418_18 and arg_415_1.time_ < var_418_17 + var_418_18 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play116431095 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 116431095
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play116431096(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.fswbg_:SetActive(false)
				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_1 = 0
			local var_422_2 = 0.125

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				arg_419_1.dialog_:SetActive(true)

				arg_419_1.dialogCg_.alpha = 0

				local var_422_3 = LeanTween.value(arg_419_1.dialog_, 0, 1, 0.3)

				var_422_3:setOnUpdate(LuaHelper.FloatAction(function(arg_423_0)
					arg_419_1.dialogCg_.alpha = arg_423_0
				end))
				var_422_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_419_1.dialog_)
					var_422_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_419_1.duration_ = arg_419_1.duration_ + 0.3

				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_4 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_5 = arg_419_1:GetWordFromCfg(116431095)
				local var_422_6 = arg_419_1:FormatText(var_422_5.content)

				arg_419_1.text_.text = var_422_6

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 5
				local var_422_8 = utf8.len(var_422_6)
				local var_422_9 = var_422_7 <= 0 and var_422_2 or var_422_2 * (var_422_8 / var_422_7)

				if var_422_9 > 0 and var_422_2 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9
					var_422_1 = var_422_1 + 0.3

					if var_422_9 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_6
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = var_422_1 + 0.3
			local var_422_11 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_10) / var_422_11

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play116431096 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 116431096
		arg_425_1.duration_ = 2.36

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play116431097(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.fswbg_:SetActive(true)
				arg_425_1.dialog_:SetActive(false)

				arg_425_1.fswtw_.percent = 0

				local var_428_1 = arg_425_1:GetWordFromCfg(116431096)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.fswt_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.fswt_)

				arg_425_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_425_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_425_1.fswtw_:SetDirty()

				arg_425_1.typewritterCharCountI18N = 0

				SetActive(arg_425_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_425_1:ShowNextGo(false)
			end

			local var_428_3 = 0.0166666666666667

			if var_428_3 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.var_.oldValueTypewriter = arg_425_1.fswtw_.percent

				SetActive(arg_425_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_425_1:ShowNextGo(false)
			end

			local var_428_4 = 10
			local var_428_5 = 0.666666666666667
			local var_428_6 = arg_425_1:GetWordFromCfg(116431096)
			local var_428_7 = arg_425_1:FormatText(var_428_6.content)
			local var_428_8, var_428_9 = arg_425_1:GetPercentByPara(var_428_7, 1)

			if var_428_3 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0

				local var_428_10 = var_428_4 <= 0 and var_428_5 or var_428_5 * ((var_428_9 - arg_425_1.typewritterCharCountI18N) / var_428_4)

				if var_428_10 > 0 and var_428_5 < var_428_10 then
					arg_425_1.talkMaxDuration = var_428_10

					if var_428_10 + var_428_3 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_3
					end
				end
			end

			local var_428_11 = 0.666666666666667
			local var_428_12 = math.max(var_428_11, arg_425_1.talkMaxDuration)

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_12 then
				local var_428_13 = (arg_425_1.time_ - var_428_3) / var_428_12

				arg_425_1.fswtw_.percent = Mathf.Lerp(arg_425_1.var_.oldValueTypewriter, var_428_8, var_428_13)
				arg_425_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_425_1.fswtw_:SetDirty()
			end

			if arg_425_1.time_ >= var_428_3 + var_428_12 and arg_425_1.time_ < var_428_3 + var_428_12 + arg_428_0 then
				arg_425_1.fswtw_.percent = var_428_8

				arg_425_1.fswtw_:SetDirty()
				arg_425_1:ShowNextGo(true)

				arg_425_1.typewritterCharCountI18N = var_428_9
			end

			local var_428_14 = 0
			local var_428_15 = 2.363
			local var_428_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431096", "story_v_out_116431.awb") / 1000

			if var_428_16 > 0 and var_428_15 < var_428_16 and var_428_16 + var_428_14 > arg_425_1.duration_ then
				local var_428_17 = var_428_16

				arg_425_1.duration_ = var_428_16 + var_428_14
			end

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				local var_428_18 = "play"
				local var_428_19 = "voice"

				arg_425_1:AudioAction(var_428_18, var_428_19, "story_v_out_116431", "116431096", "story_v_out_116431.awb")
			end

			local var_428_20 = 0

			if var_428_20 < arg_425_1.time_ and arg_425_1.time_ <= var_428_20 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			local var_428_21 = 0.683333333333333

			if arg_425_1.time_ >= var_428_20 + var_428_21 and arg_425_1.time_ < var_428_20 + var_428_21 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play116431097 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 116431097
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play116431098(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.fswbg_:SetActive(false)
				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_429_1:ShowNextGo(false)
			end

			local var_432_1 = 0
			local var_432_2 = 0.1

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_3 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_3:setOnUpdate(LuaHelper.FloatAction(function(arg_433_0)
					arg_429_1.dialogCg_.alpha = arg_433_0
				end))
				var_432_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_4 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_5 = arg_429_1:GetWordFromCfg(116431097)
				local var_432_6 = arg_429_1:FormatText(var_432_5.content)

				arg_429_1.text_.text = var_432_6

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 4
				local var_432_8 = utf8.len(var_432_6)
				local var_432_9 = var_432_7 <= 0 and var_432_2 or var_432_2 * (var_432_8 / var_432_7)

				if var_432_9 > 0 and var_432_2 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9
					var_432_1 = var_432_1 + 0.3

					if var_432_9 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_6
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = var_432_1 + 0.3
			local var_432_11 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_10) / var_432_11

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play116431098 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 116431098
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play116431099(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.95

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:GetWordFromCfg(116431098)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 38
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
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_8 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_8 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_8

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_8 and arg_435_1.time_ < var_438_0 + var_438_8 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play116431099 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 116431099
		arg_439_1.duration_ = 3.61

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play116431100(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.fswbg_:SetActive(true)
				arg_439_1.dialog_:SetActive(false)

				arg_439_1.fswtw_.percent = 0

				local var_442_1 = arg_439_1:GetWordFromCfg(116431099)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.fswt_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.fswt_)

				arg_439_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_439_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_439_1.fswtw_:SetDirty()

				arg_439_1.typewritterCharCountI18N = 0

				SetActive(arg_439_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_439_1:ShowNextGo(false)
			end

			local var_442_3 = 0.0166666666666667

			if var_442_3 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.var_.oldValueTypewriter = arg_439_1.fswtw_.percent

				SetActive(arg_439_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_439_1:ShowNextGo(false)
			end

			local var_442_4 = 12
			local var_442_5 = 0.8
			local var_442_6 = arg_439_1:GetWordFromCfg(116431099)
			local var_442_7 = arg_439_1:FormatText(var_442_6.content)
			local var_442_8, var_442_9 = arg_439_1:GetPercentByPara(var_442_7, 1)

			if var_442_3 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				local var_442_10 = var_442_4 <= 0 and var_442_5 or var_442_5 * ((var_442_9 - arg_439_1.typewritterCharCountI18N) / var_442_4)

				if var_442_10 > 0 and var_442_5 < var_442_10 then
					arg_439_1.talkMaxDuration = var_442_10

					if var_442_10 + var_442_3 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_3
					end
				end
			end

			local var_442_11 = 0.8
			local var_442_12 = math.max(var_442_11, arg_439_1.talkMaxDuration)

			if var_442_3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_3 + var_442_12 then
				local var_442_13 = (arg_439_1.time_ - var_442_3) / var_442_12

				arg_439_1.fswtw_.percent = Mathf.Lerp(arg_439_1.var_.oldValueTypewriter, var_442_8, var_442_13)
				arg_439_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_439_1.fswtw_:SetDirty()
			end

			if arg_439_1.time_ >= var_442_3 + var_442_12 and arg_439_1.time_ < var_442_3 + var_442_12 + arg_442_0 then
				arg_439_1.fswtw_.percent = var_442_8

				arg_439_1.fswtw_:SetDirty()
				arg_439_1:ShowNextGo(true)

				arg_439_1.typewritterCharCountI18N = var_442_9
			end

			local var_442_14 = 0
			local var_442_15 = 3.615
			local var_442_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431099", "story_v_out_116431.awb") / 1000

			if var_442_16 > 0 and var_442_15 < var_442_16 and var_442_16 + var_442_14 > arg_439_1.duration_ then
				local var_442_17 = var_442_16

				arg_439_1.duration_ = var_442_16 + var_442_14
			end

			if var_442_14 < arg_439_1.time_ and arg_439_1.time_ <= var_442_14 + arg_442_0 then
				local var_442_18 = "play"
				local var_442_19 = "voice"

				arg_439_1:AudioAction(var_442_18, var_442_19, "story_v_out_116431", "116431099", "story_v_out_116431.awb")
			end

			local var_442_20 = 0

			if var_442_20 < arg_439_1.time_ and arg_439_1.time_ <= var_442_20 + arg_442_0 then
				arg_439_1.allBtn_.enabled = false
			end

			local var_442_21 = 0.816666666666667

			if arg_439_1.time_ >= var_442_20 + var_442_21 and arg_439_1.time_ < var_442_20 + var_442_21 + arg_442_0 then
				arg_439_1.allBtn_.enabled = true
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play116431100 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 116431100
		arg_443_1.duration_ = 1

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"

			SetActive(arg_443_1.choicesGo_, true)

			for iter_444_0, iter_444_1 in ipairs(arg_443_1.choices_) do
				local var_444_0 = iter_444_0 <= 2

				SetActive(iter_444_1.go, var_444_0)
			end

			arg_443_1.choices_[1].txt.text = arg_443_1:FormatText(StoryChoiceCfg[276].name)
			arg_443_1.choices_[2].txt.text = arg_443_1:FormatText(StoryChoiceCfg[276].name)
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play116431101(arg_443_1)
			end

			if arg_445_0 == 2 then
				arg_443_0:Play116431101(arg_443_1)
			end

			arg_443_1:RecordChoiceLog(116431100, 276, 276)
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			return
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play116431101 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 116431101
		arg_447_1.duration_ = 8.95

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play116431102(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.fswbg_:SetActive(true)
				arg_447_1.dialog_:SetActive(false)

				arg_447_1.fswtw_.percent = 0

				local var_450_1 = arg_447_1:GetWordFromCfg(116431101)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.fswt_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.fswt_)

				arg_447_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_447_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_447_1.fswtw_:SetDirty()

				arg_447_1.typewritterCharCountI18N = 0

				SetActive(arg_447_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_447_1:ShowNextGo(false)
			end

			local var_450_3 = 0.0166666666666667

			if var_450_3 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 then
				arg_447_1.var_.oldValueTypewriter = arg_447_1.fswtw_.percent

				SetActive(arg_447_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_447_1:ShowNextGo(false)
			end

			local var_450_4 = 31
			local var_450_5 = 2.06666666666667
			local var_450_6 = arg_447_1:GetWordFromCfg(116431101)
			local var_450_7 = arg_447_1:FormatText(var_450_6.content)
			local var_450_8, var_450_9 = arg_447_1:GetPercentByPara(var_450_7, 1)

			if var_450_3 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				local var_450_10 = var_450_4 <= 0 and var_450_5 or var_450_5 * ((var_450_9 - arg_447_1.typewritterCharCountI18N) / var_450_4)

				if var_450_10 > 0 and var_450_5 < var_450_10 then
					arg_447_1.talkMaxDuration = var_450_10

					if var_450_10 + var_450_3 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_3
					end
				end
			end

			local var_450_11 = 2.06666666666667
			local var_450_12 = math.max(var_450_11, arg_447_1.talkMaxDuration)

			if var_450_3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_3 + var_450_12 then
				local var_450_13 = (arg_447_1.time_ - var_450_3) / var_450_12

				arg_447_1.fswtw_.percent = Mathf.Lerp(arg_447_1.var_.oldValueTypewriter, var_450_8, var_450_13)
				arg_447_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_447_1.fswtw_:SetDirty()
			end

			if arg_447_1.time_ >= var_450_3 + var_450_12 and arg_447_1.time_ < var_450_3 + var_450_12 + arg_450_0 then
				arg_447_1.fswtw_.percent = var_450_8

				arg_447_1.fswtw_:SetDirty()
				arg_447_1:ShowNextGo(true)

				arg_447_1.typewritterCharCountI18N = var_450_9
			end

			local var_450_14 = 0
			local var_450_15 = 8.953
			local var_450_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431101", "story_v_out_116431.awb") / 1000

			if var_450_16 > 0 and var_450_15 < var_450_16 and var_450_16 + var_450_14 > arg_447_1.duration_ then
				local var_450_17 = var_450_16

				arg_447_1.duration_ = var_450_16 + var_450_14
			end

			if var_450_14 < arg_447_1.time_ and arg_447_1.time_ <= var_450_14 + arg_450_0 then
				local var_450_18 = "play"
				local var_450_19 = "voice"

				arg_447_1:AudioAction(var_450_18, var_450_19, "story_v_out_116431", "116431101", "story_v_out_116431.awb")
			end

			local var_450_20 = 0

			if var_450_20 < arg_447_1.time_ and arg_447_1.time_ <= var_450_20 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			local var_450_21 = 2.08333333333333

			if arg_447_1.time_ >= var_450_20 + var_450_21 and arg_447_1.time_ < var_450_20 + var_450_21 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play116431102 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 116431102
		arg_451_1.duration_ = 13.08

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play116431103(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.var_.oldValueTypewriter = arg_451_1.fswtw_.percent

				SetActive(arg_451_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_451_1:ShowNextGo(false)
			end

			local var_454_1 = 51
			local var_454_2 = 3.4
			local var_454_3 = arg_451_1:GetWordFromCfg(116431101)
			local var_454_4 = arg_451_1:FormatText(var_454_3.content)
			local var_454_5, var_454_6 = arg_451_1:GetPercentByPara(var_454_4, 3)

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0

				local var_454_7 = var_454_1 <= 0 and var_454_2 or var_454_2 * ((var_454_6 - arg_451_1.typewritterCharCountI18N) / var_454_1)

				if var_454_7 > 0 and var_454_2 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end
			end

			local var_454_8 = 3.4
			local var_454_9 = math.max(var_454_8, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_9 then
				local var_454_10 = (arg_451_1.time_ - var_454_0) / var_454_9

				arg_451_1.fswtw_.percent = Mathf.Lerp(arg_451_1.var_.oldValueTypewriter, var_454_5, var_454_10)
				arg_451_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_451_1.fswtw_:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_9 and arg_451_1.time_ < var_454_0 + var_454_9 + arg_454_0 then
				arg_451_1.fswtw_.percent = var_454_5

				arg_451_1.fswtw_:SetDirty()
				arg_451_1:ShowNextGo(true)

				arg_451_1.typewritterCharCountI18N = var_454_6
			end

			local var_454_11 = 0
			local var_454_12 = 13.082
			local var_454_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431102", "story_v_out_116431.awb") / 1000

			if var_454_13 > 0 and var_454_12 < var_454_13 and var_454_13 + var_454_11 > arg_451_1.duration_ then
				local var_454_14 = var_454_13

				arg_451_1.duration_ = var_454_13 + var_454_11
			end

			if var_454_11 < arg_451_1.time_ and arg_451_1.time_ <= var_454_11 + arg_454_0 then
				local var_454_15 = "play"
				local var_454_16 = "voice"

				arg_451_1:AudioAction(var_454_15, var_454_16, "story_v_out_116431", "116431102", "story_v_out_116431.awb")
			end

			local var_454_17 = 0

			if var_454_17 < arg_451_1.time_ and arg_451_1.time_ <= var_454_17 + arg_454_0 then
				arg_451_1.allBtn_.enabled = false
			end

			local var_454_18 = 3.4

			if arg_451_1.time_ >= var_454_17 + var_454_18 and arg_451_1.time_ < var_454_17 + var_454_18 + arg_454_0 then
				arg_451_1.allBtn_.enabled = true
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play116431103 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 116431103
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play116431104(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.fswbg_:SetActive(false)
				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_455_1:ShowNextGo(false)
			end

			local var_458_1 = 0
			local var_458_2 = 0.175

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_3 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_3:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_4 = arg_455_1:FormatText(StoryNameCfg[7].name)

				arg_455_1.leftNameTxt_.text = var_458_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_5 = arg_455_1:GetWordFromCfg(116431103)
				local var_458_6 = arg_455_1:FormatText(var_458_5.content)

				arg_455_1.text_.text = var_458_6

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 7
				local var_458_8 = utf8.len(var_458_6)
				local var_458_9 = var_458_7 <= 0 and var_458_2 or var_458_2 * (var_458_8 / var_458_7)

				if var_458_9 > 0 and var_458_2 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9
					var_458_1 = var_458_1 + 0.3

					if var_458_9 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_6
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = var_458_1 + 0.3
			local var_458_11 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_10 <= arg_455_1.time_ and arg_455_1.time_ < var_458_10 + var_458_11 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_10) / var_458_11

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_10 + var_458_11 and arg_455_1.time_ < var_458_10 + var_458_11 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play116431104 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 116431104
		arg_461_1.duration_ = 11.87

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play116431105(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.fswbg_:SetActive(true)
				arg_461_1.dialog_:SetActive(false)

				arg_461_1.fswtw_.percent = 0

				local var_464_1 = arg_461_1:GetWordFromCfg(116431104)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.fswt_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.fswt_)

				arg_461_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_461_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_461_1.fswtw_:SetDirty()

				arg_461_1.typewritterCharCountI18N = 0

				SetActive(arg_461_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_461_1:ShowNextGo(false)
			end

			local var_464_3 = 0.0166666666666667

			if var_464_3 < arg_461_1.time_ and arg_461_1.time_ <= var_464_3 + arg_464_0 then
				arg_461_1.var_.oldValueTypewriter = arg_461_1.fswtw_.percent

				SetActive(arg_461_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_461_1:ShowNextGo(false)
			end

			local var_464_4 = 50
			local var_464_5 = 3.33333333333333
			local var_464_6 = arg_461_1:GetWordFromCfg(116431104)
			local var_464_7 = arg_461_1:FormatText(var_464_6.content)
			local var_464_8, var_464_9 = arg_461_1:GetPercentByPara(var_464_7, 1)

			if var_464_3 < arg_461_1.time_ and arg_461_1.time_ <= var_464_3 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				local var_464_10 = var_464_4 <= 0 and var_464_5 or var_464_5 * ((var_464_9 - arg_461_1.typewritterCharCountI18N) / var_464_4)

				if var_464_10 > 0 and var_464_5 < var_464_10 then
					arg_461_1.talkMaxDuration = var_464_10

					if var_464_10 + var_464_3 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_3
					end
				end
			end

			local var_464_11 = 3.33333333333333
			local var_464_12 = math.max(var_464_11, arg_461_1.talkMaxDuration)

			if var_464_3 <= arg_461_1.time_ and arg_461_1.time_ < var_464_3 + var_464_12 then
				local var_464_13 = (arg_461_1.time_ - var_464_3) / var_464_12

				arg_461_1.fswtw_.percent = Mathf.Lerp(arg_461_1.var_.oldValueTypewriter, var_464_8, var_464_13)
				arg_461_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_461_1.fswtw_:SetDirty()
			end

			if arg_461_1.time_ >= var_464_3 + var_464_12 and arg_461_1.time_ < var_464_3 + var_464_12 + arg_464_0 then
				arg_461_1.fswtw_.percent = var_464_8

				arg_461_1.fswtw_:SetDirty()
				arg_461_1:ShowNextGo(true)

				arg_461_1.typewritterCharCountI18N = var_464_9
			end

			local var_464_14 = 0
			local var_464_15 = 11.868
			local var_464_16 = manager.audio:GetVoiceLength("story_v_out_116431", "116431104", "story_v_out_116431.awb") / 1000

			if var_464_16 > 0 and var_464_15 < var_464_16 and var_464_16 + var_464_14 > arg_461_1.duration_ then
				local var_464_17 = var_464_16

				arg_461_1.duration_ = var_464_16 + var_464_14
			end

			if var_464_14 < arg_461_1.time_ and arg_461_1.time_ <= var_464_14 + arg_464_0 then
				local var_464_18 = "play"
				local var_464_19 = "voice"

				arg_461_1:AudioAction(var_464_18, var_464_19, "story_v_out_116431", "116431104", "story_v_out_116431.awb")
			end

			local var_464_20 = 0

			if var_464_20 < arg_461_1.time_ and arg_461_1.time_ <= var_464_20 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			local var_464_21 = 3.35

			if arg_461_1.time_ >= var_464_20 + var_464_21 and arg_461_1.time_ < var_464_20 + var_464_21 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play116431105 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 116431105
		arg_465_1.duration_ = 6.26

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play116431106(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.var_.oldValueTypewriter = arg_465_1.fswtw_.percent

				SetActive(arg_465_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_465_1:ShowNextGo(false)
			end

			local var_468_1 = 28
			local var_468_2 = 1.86666666666667
			local var_468_3 = arg_465_1:GetWordFromCfg(116431104)
			local var_468_4 = arg_465_1:FormatText(var_468_3.content)
			local var_468_5, var_468_6 = arg_465_1:GetPercentByPara(var_468_4, 2)

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				local var_468_7 = var_468_1 <= 0 and var_468_2 or var_468_2 * ((var_468_6 - arg_465_1.typewritterCharCountI18N) / var_468_1)

				if var_468_7 > 0 and var_468_2 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end
			end

			local var_468_8 = 1.86666666666667
			local var_468_9 = math.max(var_468_8, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_9 then
				local var_468_10 = (arg_465_1.time_ - var_468_0) / var_468_9

				arg_465_1.fswtw_.percent = Mathf.Lerp(arg_465_1.var_.oldValueTypewriter, var_468_5, var_468_10)
				arg_465_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_465_1.fswtw_:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_9 and arg_465_1.time_ < var_468_0 + var_468_9 + arg_468_0 then
				arg_465_1.fswtw_.percent = var_468_5

				arg_465_1.fswtw_:SetDirty()
				arg_465_1:ShowNextGo(true)

				arg_465_1.typewritterCharCountI18N = var_468_6
			end

			local var_468_11 = 0
			local var_468_12 = 6.263
			local var_468_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431105", "story_v_out_116431.awb") / 1000

			if var_468_13 > 0 and var_468_12 < var_468_13 and var_468_13 + var_468_11 > arg_465_1.duration_ then
				local var_468_14 = var_468_13

				arg_465_1.duration_ = var_468_13 + var_468_11
			end

			if var_468_11 < arg_465_1.time_ and arg_465_1.time_ <= var_468_11 + arg_468_0 then
				local var_468_15 = "play"
				local var_468_16 = "voice"

				arg_465_1:AudioAction(var_468_15, var_468_16, "story_v_out_116431", "116431105", "story_v_out_116431.awb")
			end

			local var_468_17 = 0

			if var_468_17 < arg_465_1.time_ and arg_465_1.time_ <= var_468_17 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			local var_468_18 = 1.86666666666667

			if arg_465_1.time_ >= var_468_17 + var_468_18 and arg_465_1.time_ < var_468_17 + var_468_18 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play116431106 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 116431106
		arg_469_1.duration_ = 8.71

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play116431107(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.var_.oldValueTypewriter = arg_469_1.fswtw_.percent

				SetActive(arg_469_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_469_1:ShowNextGo(false)
			end

			local var_472_1 = 35
			local var_472_2 = 2.33333333333333
			local var_472_3 = arg_469_1:GetWordFromCfg(116431104)
			local var_472_4 = arg_469_1:FormatText(var_472_3.content)
			local var_472_5, var_472_6 = arg_469_1:GetPercentByPara(var_472_4, 3)

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				local var_472_7 = var_472_1 <= 0 and var_472_2 or var_472_2 * ((var_472_6 - arg_469_1.typewritterCharCountI18N) / var_472_1)

				if var_472_7 > 0 and var_472_2 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end
			end

			local var_472_8 = 2.33333333333333
			local var_472_9 = math.max(var_472_8, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_9 then
				local var_472_10 = (arg_469_1.time_ - var_472_0) / var_472_9

				arg_469_1.fswtw_.percent = Mathf.Lerp(arg_469_1.var_.oldValueTypewriter, var_472_5, var_472_10)
				arg_469_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_469_1.fswtw_:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_9 and arg_469_1.time_ < var_472_0 + var_472_9 + arg_472_0 then
				arg_469_1.fswtw_.percent = var_472_5

				arg_469_1.fswtw_:SetDirty()
				arg_469_1:ShowNextGo(true)

				arg_469_1.typewritterCharCountI18N = var_472_6
			end

			local var_472_11 = 0
			local var_472_12 = 8.709
			local var_472_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431106", "story_v_out_116431.awb") / 1000

			if var_472_13 > 0 and var_472_12 < var_472_13 and var_472_13 + var_472_11 > arg_469_1.duration_ then
				local var_472_14 = var_472_13

				arg_469_1.duration_ = var_472_13 + var_472_11
			end

			if var_472_11 < arg_469_1.time_ and arg_469_1.time_ <= var_472_11 + arg_472_0 then
				local var_472_15 = "play"
				local var_472_16 = "voice"

				arg_469_1:AudioAction(var_472_15, var_472_16, "story_v_out_116431", "116431106", "story_v_out_116431.awb")
			end

			local var_472_17 = 0

			if var_472_17 < arg_469_1.time_ and arg_469_1.time_ <= var_472_17 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_18 = 2.33333333333333

			if arg_469_1.time_ >= var_472_17 + var_472_18 and arg_469_1.time_ < var_472_17 + var_472_18 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play116431107 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 116431107
		arg_473_1.duration_ = 5.57

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play116431108(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.var_.oldValueTypewriter = arg_473_1.fswtw_.percent

				SetActive(arg_473_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_473_1:ShowNextGo(false)
			end

			local var_476_1 = 19
			local var_476_2 = 1.26666666666667
			local var_476_3 = arg_473_1:GetWordFromCfg(116431104)
			local var_476_4 = arg_473_1:FormatText(var_476_3.content)
			local var_476_5, var_476_6 = arg_473_1:GetPercentByPara(var_476_4, 4)

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0

				local var_476_7 = var_476_1 <= 0 and var_476_2 or var_476_2 * ((var_476_6 - arg_473_1.typewritterCharCountI18N) / var_476_1)

				if var_476_7 > 0 and var_476_2 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end
			end

			local var_476_8 = 1.26666666666667
			local var_476_9 = math.max(var_476_8, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_9 then
				local var_476_10 = (arg_473_1.time_ - var_476_0) / var_476_9

				arg_473_1.fswtw_.percent = Mathf.Lerp(arg_473_1.var_.oldValueTypewriter, var_476_5, var_476_10)
				arg_473_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_473_1.fswtw_:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_9 and arg_473_1.time_ < var_476_0 + var_476_9 + arg_476_0 then
				arg_473_1.fswtw_.percent = var_476_5

				arg_473_1.fswtw_:SetDirty()
				arg_473_1:ShowNextGo(true)

				arg_473_1.typewritterCharCountI18N = var_476_6
			end

			local var_476_11 = 0
			local var_476_12 = 5.567
			local var_476_13 = manager.audio:GetVoiceLength("story_v_out_116431", "116431107", "story_v_out_116431.awb") / 1000

			if var_476_13 > 0 and var_476_12 < var_476_13 and var_476_13 + var_476_11 > arg_473_1.duration_ then
				local var_476_14 = var_476_13

				arg_473_1.duration_ = var_476_13 + var_476_11
			end

			if var_476_11 < arg_473_1.time_ and arg_473_1.time_ <= var_476_11 + arg_476_0 then
				local var_476_15 = "play"
				local var_476_16 = "voice"

				arg_473_1:AudioAction(var_476_15, var_476_16, "story_v_out_116431", "116431107", "story_v_out_116431.awb")
			end

			local var_476_17 = 0

			if var_476_17 < arg_473_1.time_ and arg_473_1.time_ <= var_476_17 + arg_476_0 then
				arg_473_1.allBtn_.enabled = false
			end

			local var_476_18 = 1.26666666666667

			if arg_473_1.time_ >= var_476_17 + var_476_18 and arg_473_1.time_ < var_476_17 + var_476_18 + arg_476_0 then
				arg_473_1.allBtn_.enabled = true
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play116431108 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 116431108
		arg_477_1.duration_ = 0.5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"

			SetActive(arg_477_1.choicesGo_, true)

			for iter_478_0, iter_478_1 in ipairs(arg_477_1.choices_) do
				local var_478_0 = iter_478_0 <= 1

				SetActive(iter_478_1.go, var_478_0)
			end

			arg_477_1.choices_[1].txt.text = arg_477_1:FormatText(StoryChoiceCfg[277].name)
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play116431109(arg_477_1)
			end

			arg_477_1:RecordChoiceLog(116431108, 277)
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			return
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play116431109 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 116431109
		arg_481_1.duration_ = 11.77

		local var_481_0 = {
			zh = 10.333,
			ja = 11.766
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play116431110(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 2

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				local var_484_1 = manager.ui.mainCamera.transform.localPosition
				local var_484_2 = Vector3.New(0, 0, 10) + Vector3.New(var_484_1.x, var_484_1.y, 0)
				local var_484_3 = arg_481_1.bgs_.A00

				var_484_3.transform.localPosition = var_484_2
				var_484_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_484_4 = var_484_3:GetComponent("SpriteRenderer")

				if var_484_4 and var_484_4.sprite then
					local var_484_5 = (var_484_3.transform.localPosition - var_484_1).z
					local var_484_6 = manager.ui.mainCameraCom_
					local var_484_7 = 2 * var_484_5 * Mathf.Tan(var_484_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_484_8 = var_484_7 * var_484_6.aspect
					local var_484_9 = var_484_4.sprite.bounds.size.x
					local var_484_10 = var_484_4.sprite.bounds.size.y
					local var_484_11 = var_484_8 / var_484_9
					local var_484_12 = var_484_7 / var_484_10
					local var_484_13 = var_484_12 < var_484_11 and var_484_11 or var_484_12

					var_484_3.transform.localScale = Vector3.New(var_484_13, var_484_13, 0)
				end

				for iter_484_0, iter_484_1 in pairs(arg_481_1.bgs_) do
					if iter_484_0 ~= "A00" then
						iter_484_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_484_14 = 0

			if var_484_14 < arg_481_1.time_ and arg_481_1.time_ <= var_484_14 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_15 = 2

			if var_484_14 <= arg_481_1.time_ and arg_481_1.time_ < var_484_14 + var_484_15 then
				local var_484_16 = (arg_481_1.time_ - var_484_14) / var_484_15
				local var_484_17 = Color.New(0, 0, 0)

				var_484_17.a = Mathf.Lerp(0, 1, var_484_16)
				arg_481_1.mask_.color = var_484_17
			end

			if arg_481_1.time_ >= var_484_14 + var_484_15 and arg_481_1.time_ < var_484_14 + var_484_15 + arg_484_0 then
				local var_484_18 = Color.New(0, 0, 0)

				var_484_18.a = 1
				arg_481_1.mask_.color = var_484_18
			end

			local var_484_19 = 2

			if var_484_19 < arg_481_1.time_ and arg_481_1.time_ <= var_484_19 + arg_484_0 then
				arg_481_1.mask_.enabled = true
				arg_481_1.mask_.raycastTarget = true

				arg_481_1:SetGaussion(false)
			end

			local var_484_20 = 2

			if var_484_19 <= arg_481_1.time_ and arg_481_1.time_ < var_484_19 + var_484_20 then
				local var_484_21 = (arg_481_1.time_ - var_484_19) / var_484_20
				local var_484_22 = Color.New(0, 0, 0)

				var_484_22.a = Mathf.Lerp(1, 0, var_484_21)
				arg_481_1.mask_.color = var_484_22
			end

			if arg_481_1.time_ >= var_484_19 + var_484_20 and arg_481_1.time_ < var_484_19 + var_484_20 + arg_484_0 then
				local var_484_23 = Color.New(0, 0, 0)
				local var_484_24 = 0

				arg_481_1.mask_.enabled = false
				var_484_23.a = var_484_24
				arg_481_1.mask_.color = var_484_23
			end

			local var_484_25 = arg_481_1.actors_["1019ui_story"].transform
			local var_484_26 = 4

			if var_484_26 < arg_481_1.time_ and arg_481_1.time_ <= var_484_26 + arg_484_0 then
				arg_481_1.var_.moveOldPos1019ui_story = var_484_25.localPosition
			end

			local var_484_27 = 0.001

			if var_484_26 <= arg_481_1.time_ and arg_481_1.time_ < var_484_26 + var_484_27 then
				local var_484_28 = (arg_481_1.time_ - var_484_26) / var_484_27
				local var_484_29 = Vector3.New(-0.7, -1.08, -5.9)

				var_484_25.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1019ui_story, var_484_29, var_484_28)

				local var_484_30 = manager.ui.mainCamera.transform.position - var_484_25.position

				var_484_25.forward = Vector3.New(var_484_30.x, var_484_30.y, var_484_30.z)

				local var_484_31 = var_484_25.localEulerAngles

				var_484_31.z = 0
				var_484_31.x = 0
				var_484_25.localEulerAngles = var_484_31
			end

			if arg_481_1.time_ >= var_484_26 + var_484_27 and arg_481_1.time_ < var_484_26 + var_484_27 + arg_484_0 then
				var_484_25.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_484_32 = manager.ui.mainCamera.transform.position - var_484_25.position

				var_484_25.forward = Vector3.New(var_484_32.x, var_484_32.y, var_484_32.z)

				local var_484_33 = var_484_25.localEulerAngles

				var_484_33.z = 0
				var_484_33.x = 0
				var_484_25.localEulerAngles = var_484_33
			end

			local var_484_34 = arg_481_1.actors_["1029ui_story"].transform
			local var_484_35 = 4

			if var_484_35 < arg_481_1.time_ and arg_481_1.time_ <= var_484_35 + arg_484_0 then
				arg_481_1.var_.moveOldPos1029ui_story = var_484_34.localPosition
			end

			local var_484_36 = 0.001

			if var_484_35 <= arg_481_1.time_ and arg_481_1.time_ < var_484_35 + var_484_36 then
				local var_484_37 = (arg_481_1.time_ - var_484_35) / var_484_36
				local var_484_38 = Vector3.New(0.7, -1.09, -6.2)

				var_484_34.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1029ui_story, var_484_38, var_484_37)

				local var_484_39 = manager.ui.mainCamera.transform.position - var_484_34.position

				var_484_34.forward = Vector3.New(var_484_39.x, var_484_39.y, var_484_39.z)

				local var_484_40 = var_484_34.localEulerAngles

				var_484_40.z = 0
				var_484_40.x = 0
				var_484_34.localEulerAngles = var_484_40
			end

			if arg_481_1.time_ >= var_484_35 + var_484_36 and arg_481_1.time_ < var_484_35 + var_484_36 + arg_484_0 then
				var_484_34.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_484_41 = manager.ui.mainCamera.transform.position - var_484_34.position

				var_484_34.forward = Vector3.New(var_484_41.x, var_484_41.y, var_484_41.z)

				local var_484_42 = var_484_34.localEulerAngles

				var_484_42.z = 0
				var_484_42.x = 0
				var_484_34.localEulerAngles = var_484_42
			end

			local var_484_43 = arg_481_1.actors_["1019ui_story"]
			local var_484_44 = 4

			if var_484_44 < arg_481_1.time_ and arg_481_1.time_ <= var_484_44 + arg_484_0 and not isNil(var_484_43) and arg_481_1.var_.characterEffect1019ui_story == nil then
				arg_481_1.var_.characterEffect1019ui_story = var_484_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_45 = 0.2

			if var_484_44 <= arg_481_1.time_ and arg_481_1.time_ < var_484_44 + var_484_45 and not isNil(var_484_43) then
				local var_484_46 = (arg_481_1.time_ - var_484_44) / var_484_45

				if arg_481_1.var_.characterEffect1019ui_story and not isNil(var_484_43) then
					local var_484_47 = Mathf.Lerp(0, 0.5, var_484_46)

					arg_481_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1019ui_story.fillRatio = var_484_47
				end
			end

			if arg_481_1.time_ >= var_484_44 + var_484_45 and arg_481_1.time_ < var_484_44 + var_484_45 + arg_484_0 and not isNil(var_484_43) and arg_481_1.var_.characterEffect1019ui_story then
				local var_484_48 = 0.5

				arg_481_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1019ui_story.fillRatio = var_484_48
			end

			local var_484_49 = arg_481_1.actors_["1029ui_story"]
			local var_484_50 = 4

			if var_484_50 < arg_481_1.time_ and arg_481_1.time_ <= var_484_50 + arg_484_0 and not isNil(var_484_49) and arg_481_1.var_.characterEffect1029ui_story == nil then
				arg_481_1.var_.characterEffect1029ui_story = var_484_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_51 = 0.2

			if var_484_50 <= arg_481_1.time_ and arg_481_1.time_ < var_484_50 + var_484_51 and not isNil(var_484_49) then
				local var_484_52 = (arg_481_1.time_ - var_484_50) / var_484_51

				if arg_481_1.var_.characterEffect1029ui_story and not isNil(var_484_49) then
					arg_481_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_50 + var_484_51 and arg_481_1.time_ < var_484_50 + var_484_51 + arg_484_0 and not isNil(var_484_49) and arg_481_1.var_.characterEffect1029ui_story then
				arg_481_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_484_53 = 4

			if var_484_53 < arg_481_1.time_ and arg_481_1.time_ <= var_484_53 + arg_484_0 then
				arg_481_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_484_54 = 2

			if var_484_54 < arg_481_1.time_ and arg_481_1.time_ <= var_484_54 + arg_484_0 then
				arg_481_1.fswbg_:SetActive(false)
				arg_481_1.dialog_:SetActive(false)
				SetActive(arg_481_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_481_1:ShowNextGo(false)
			end

			local var_484_55 = 0
			local var_484_56 = 0.666666666666667

			if var_484_55 < arg_481_1.time_ and arg_481_1.time_ <= var_484_55 + arg_484_0 then
				local var_484_57 = "play"
				local var_484_58 = "music"

				arg_481_1:AudioAction(var_484_57, var_484_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_484_59 = ""
				local var_484_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_484_60 ~= "" then
					if arg_481_1.bgmTxt_.text ~= var_484_60 and arg_481_1.bgmTxt_.text ~= "" then
						if arg_481_1.bgmTxt2_.text ~= "" then
							arg_481_1.bgmTxt_.text = arg_481_1.bgmTxt2_.text
						end

						arg_481_1.bgmTxt2_.text = var_484_60

						arg_481_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_481_1.bgmTxt_.text = var_484_60
						arg_481_1.bgmTxt2_.text = var_484_60
					end

					if arg_481_1.bgmTimer then
						arg_481_1.bgmTimer:Stop()

						arg_481_1.bgmTimer = nil
					end

					if arg_481_1.settingData.show_music_name == 1 then
						arg_481_1.musicController:SetSelectedState("show")
						arg_481_1.musicAnimator_:Play("open", 0, 0)

						if arg_481_1.settingData.music_time ~= 0 then
							arg_481_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_481_1.settingData.music_time), function()
								if arg_481_1 == nil or isNil(arg_481_1.bgmTxt_) then
									return
								end

								arg_481_1.musicController:SetSelectedState("hide")
								arg_481_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_61 = 4
			local var_484_62 = 0.725

			if var_484_61 < arg_481_1.time_ and arg_481_1.time_ <= var_484_61 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_63 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_63:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_481_1.dialogCg_.alpha = arg_486_0
				end))
				var_484_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_64 = arg_481_1:FormatText(StoryNameCfg[319].name)

				arg_481_1.leftNameTxt_.text = var_484_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_65 = arg_481_1:GetWordFromCfg(116431109)
				local var_484_66 = arg_481_1:FormatText(var_484_65.content)

				arg_481_1.text_.text = var_484_66

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_67 = 29
				local var_484_68 = utf8.len(var_484_66)
				local var_484_69 = var_484_67 <= 0 and var_484_62 or var_484_62 * (var_484_68 / var_484_67)

				if var_484_69 > 0 and var_484_62 < var_484_69 then
					arg_481_1.talkMaxDuration = var_484_69
					var_484_61 = var_484_61 + 0.3

					if var_484_69 + var_484_61 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_69 + var_484_61
					end
				end

				arg_481_1.text_.text = var_484_66
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431109", "story_v_out_116431.awb") ~= 0 then
					local var_484_70 = manager.audio:GetVoiceLength("story_v_out_116431", "116431109", "story_v_out_116431.awb") / 1000

					if var_484_70 + var_484_61 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_70 + var_484_61
					end

					if var_484_65.prefab_name ~= "" and arg_481_1.actors_[var_484_65.prefab_name] ~= nil then
						local var_484_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_65.prefab_name].transform, "story_v_out_116431", "116431109", "story_v_out_116431.awb")

						arg_481_1:RecordAudio("116431109", var_484_71)
						arg_481_1:RecordAudio("116431109", var_484_71)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_116431", "116431109", "story_v_out_116431.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_116431", "116431109", "story_v_out_116431.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_72 = var_484_61 + 0.3
			local var_484_73 = math.max(var_484_62, arg_481_1.talkMaxDuration)

			if var_484_72 <= arg_481_1.time_ and arg_481_1.time_ < var_484_72 + var_484_73 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_72) / var_484_73

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_72 + var_484_73 and arg_481_1.time_ < var_484_72 + var_484_73 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play116431110 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 116431110
		arg_488_1.duration_ = 4.53

		local var_488_0 = {
			zh = 2.3,
			ja = 4.533
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play116431111(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1019ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1019ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1019ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = arg_488_1.actors_["1019ui_story"]
			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1019ui_story == nil then
				arg_488_1.var_.characterEffect1019ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.2

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect1019ui_story and not isNil(var_491_9) then
					arg_488_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1019ui_story then
				arg_488_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_491_13 = arg_488_1.actors_["1029ui_story"]
			local var_491_14 = 0

			if var_491_14 < arg_488_1.time_ and arg_488_1.time_ <= var_491_14 + arg_491_0 and not isNil(var_491_13) and arg_488_1.var_.characterEffect1029ui_story == nil then
				arg_488_1.var_.characterEffect1029ui_story = var_491_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_15 = 0.2

			if var_491_14 <= arg_488_1.time_ and arg_488_1.time_ < var_491_14 + var_491_15 and not isNil(var_491_13) then
				local var_491_16 = (arg_488_1.time_ - var_491_14) / var_491_15

				if arg_488_1.var_.characterEffect1029ui_story and not isNil(var_491_13) then
					local var_491_17 = Mathf.Lerp(0, 0.5, var_491_16)

					arg_488_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1029ui_story.fillRatio = var_491_17
				end
			end

			if arg_488_1.time_ >= var_491_14 + var_491_15 and arg_488_1.time_ < var_491_14 + var_491_15 + arg_491_0 and not isNil(var_491_13) and arg_488_1.var_.characterEffect1029ui_story then
				local var_491_18 = 0.5

				arg_488_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1029ui_story.fillRatio = var_491_18
			end

			local var_491_19 = 0

			if var_491_19 < arg_488_1.time_ and arg_488_1.time_ <= var_491_19 + arg_491_0 then
				arg_488_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_491_20 = 0
			local var_491_21 = 0.275

			if var_491_20 < arg_488_1.time_ and arg_488_1.time_ <= var_491_20 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_22 = arg_488_1:FormatText(StoryNameCfg[47].name)

				arg_488_1.leftNameTxt_.text = var_491_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_23 = arg_488_1:GetWordFromCfg(116431110)
				local var_491_24 = arg_488_1:FormatText(var_491_23.content)

				arg_488_1.text_.text = var_491_24

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_25 = 11
				local var_491_26 = utf8.len(var_491_24)
				local var_491_27 = var_491_25 <= 0 and var_491_21 or var_491_21 * (var_491_26 / var_491_25)

				if var_491_27 > 0 and var_491_21 < var_491_27 then
					arg_488_1.talkMaxDuration = var_491_27

					if var_491_27 + var_491_20 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_27 + var_491_20
					end
				end

				arg_488_1.text_.text = var_491_24
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431110", "story_v_out_116431.awb") ~= 0 then
					local var_491_28 = manager.audio:GetVoiceLength("story_v_out_116431", "116431110", "story_v_out_116431.awb") / 1000

					if var_491_28 + var_491_20 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_28 + var_491_20
					end

					if var_491_23.prefab_name ~= "" and arg_488_1.actors_[var_491_23.prefab_name] ~= nil then
						local var_491_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_23.prefab_name].transform, "story_v_out_116431", "116431110", "story_v_out_116431.awb")

						arg_488_1:RecordAudio("116431110", var_491_29)
						arg_488_1:RecordAudio("116431110", var_491_29)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_116431", "116431110", "story_v_out_116431.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_116431", "116431110", "story_v_out_116431.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_30 = math.max(var_491_21, arg_488_1.talkMaxDuration)

			if var_491_20 <= arg_488_1.time_ and arg_488_1.time_ < var_491_20 + var_491_30 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_20) / var_491_30

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_20 + var_491_30 and arg_488_1.time_ < var_491_20 + var_491_30 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play116431111 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 116431111
		arg_492_1.duration_ = 26.02

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play116431117(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 2.01666666666667

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				SetActive(arg_492_1.dialog_, false)
				SetActive(arg_492_1.allBtn_.gameObject, false)
				arg_492_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/101164301.usm", function(arg_496_0)
					if arg_492_1.state_ == "playing" then
						arg_492_1:JumpToEnd()
					end

					if arg_492_1.playNext_ and not arg_492_1.auto_ then
						arg_492_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_497_0)
					if arg_497_0 then
						arg_492_1.state_ = "pause"
					else
						arg_492_1.state_ = "playing"
					end
				end, 101164301)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_495_1 = 24

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_1 then
				-- block empty
			end

			if arg_492_1.time_ >= var_495_0 + var_495_1 and arg_492_1.time_ < var_495_0 + var_495_1 + arg_495_0 then
				-- block empty
			end

			local var_495_2 = arg_492_1.actors_["1019ui_story"].transform
			local var_495_3 = 2

			if var_495_3 < arg_492_1.time_ and arg_492_1.time_ <= var_495_3 + arg_495_0 then
				arg_492_1.var_.moveOldPos1019ui_story = var_495_2.localPosition
			end

			local var_495_4 = 0.001

			if var_495_3 <= arg_492_1.time_ and arg_492_1.time_ < var_495_3 + var_495_4 then
				local var_495_5 = (arg_492_1.time_ - var_495_3) / var_495_4
				local var_495_6 = Vector3.New(0, 100, 0)

				var_495_2.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1019ui_story, var_495_6, var_495_5)

				local var_495_7 = manager.ui.mainCamera.transform.position - var_495_2.position

				var_495_2.forward = Vector3.New(var_495_7.x, var_495_7.y, var_495_7.z)

				local var_495_8 = var_495_2.localEulerAngles

				var_495_8.z = 0
				var_495_8.x = 0
				var_495_2.localEulerAngles = var_495_8
			end

			if arg_492_1.time_ >= var_495_3 + var_495_4 and arg_492_1.time_ < var_495_3 + var_495_4 + arg_495_0 then
				var_495_2.localPosition = Vector3.New(0, 100, 0)

				local var_495_9 = manager.ui.mainCamera.transform.position - var_495_2.position

				var_495_2.forward = Vector3.New(var_495_9.x, var_495_9.y, var_495_9.z)

				local var_495_10 = var_495_2.localEulerAngles

				var_495_10.z = 0
				var_495_10.x = 0
				var_495_2.localEulerAngles = var_495_10
			end

			local var_495_11 = arg_492_1.actors_["1029ui_story"].transform
			local var_495_12 = 2

			if var_495_12 < arg_492_1.time_ and arg_492_1.time_ <= var_495_12 + arg_495_0 then
				arg_492_1.var_.moveOldPos1029ui_story = var_495_11.localPosition
			end

			local var_495_13 = 0.001

			if var_495_12 <= arg_492_1.time_ and arg_492_1.time_ < var_495_12 + var_495_13 then
				local var_495_14 = (arg_492_1.time_ - var_495_12) / var_495_13
				local var_495_15 = Vector3.New(0, 100, 0)

				var_495_11.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1029ui_story, var_495_15, var_495_14)

				local var_495_16 = manager.ui.mainCamera.transform.position - var_495_11.position

				var_495_11.forward = Vector3.New(var_495_16.x, var_495_16.y, var_495_16.z)

				local var_495_17 = var_495_11.localEulerAngles

				var_495_17.z = 0
				var_495_17.x = 0
				var_495_11.localEulerAngles = var_495_17
			end

			if arg_492_1.time_ >= var_495_12 + var_495_13 and arg_492_1.time_ < var_495_12 + var_495_13 + arg_495_0 then
				var_495_11.localPosition = Vector3.New(0, 100, 0)

				local var_495_18 = manager.ui.mainCamera.transform.position - var_495_11.position

				var_495_11.forward = Vector3.New(var_495_18.x, var_495_18.y, var_495_18.z)

				local var_495_19 = var_495_11.localEulerAngles

				var_495_19.z = 0
				var_495_19.x = 0
				var_495_11.localEulerAngles = var_495_19
			end

			local var_495_20 = 0

			if var_495_20 < arg_492_1.time_ and arg_492_1.time_ <= var_495_20 + arg_495_0 then
				arg_492_1.mask_.enabled = true
				arg_492_1.mask_.raycastTarget = true

				arg_492_1:SetGaussion(false)
			end

			local var_495_21 = 2

			if var_495_20 <= arg_492_1.time_ and arg_492_1.time_ < var_495_20 + var_495_21 then
				local var_495_22 = (arg_492_1.time_ - var_495_20) / var_495_21
				local var_495_23 = Color.New(0, 0, 0)

				var_495_23.a = Mathf.Lerp(0, 1, var_495_22)
				arg_492_1.mask_.color = var_495_23
			end

			if arg_492_1.time_ >= var_495_20 + var_495_21 and arg_492_1.time_ < var_495_20 + var_495_21 + arg_495_0 then
				local var_495_24 = Color.New(0, 0, 0)

				var_495_24.a = 1
				arg_492_1.mask_.color = var_495_24
			end

			local var_495_25 = 2

			if var_495_25 < arg_492_1.time_ and arg_492_1.time_ <= var_495_25 + arg_495_0 then
				arg_492_1.mask_.enabled = true
				arg_492_1.mask_.raycastTarget = true

				arg_492_1:SetGaussion(false)
			end

			local var_495_26 = 0.0166666666666667

			if var_495_25 <= arg_492_1.time_ and arg_492_1.time_ < var_495_25 + var_495_26 then
				local var_495_27 = (arg_492_1.time_ - var_495_25) / var_495_26
				local var_495_28 = Color.New(0, 0, 0)

				var_495_28.a = Mathf.Lerp(1, 0, var_495_27)
				arg_492_1.mask_.color = var_495_28
			end

			if arg_492_1.time_ >= var_495_25 + var_495_26 and arg_492_1.time_ < var_495_25 + var_495_26 + arg_495_0 then
				local var_495_29 = Color.New(0, 0, 0)
				local var_495_30 = 0

				arg_492_1.mask_.enabled = false
				var_495_29.a = var_495_30
				arg_492_1.mask_.color = var_495_29
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play116431117 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 116431117
		arg_498_1.duration_ = 7

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play116431118(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				local var_501_1 = manager.ui.mainCamera.transform.localPosition
				local var_501_2 = Vector3.New(0, 0, 10) + Vector3.New(var_501_1.x, var_501_1.y, 0)
				local var_501_3 = arg_498_1.bgs_.I05e

				var_501_3.transform.localPosition = var_501_2
				var_501_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_501_4 = var_501_3:GetComponent("SpriteRenderer")

				if var_501_4 and var_501_4.sprite then
					local var_501_5 = (var_501_3.transform.localPosition - var_501_1).z
					local var_501_6 = manager.ui.mainCameraCom_
					local var_501_7 = 2 * var_501_5 * Mathf.Tan(var_501_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_501_8 = var_501_7 * var_501_6.aspect
					local var_501_9 = var_501_4.sprite.bounds.size.x
					local var_501_10 = var_501_4.sprite.bounds.size.y
					local var_501_11 = var_501_8 / var_501_9
					local var_501_12 = var_501_7 / var_501_10
					local var_501_13 = var_501_12 < var_501_11 and var_501_11 or var_501_12

					var_501_3.transform.localScale = Vector3.New(var_501_13, var_501_13, 0)
				end

				for iter_501_0, iter_501_1 in pairs(arg_498_1.bgs_) do
					if iter_501_0 ~= "I05e" then
						iter_501_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_501_14 = 0

			if var_501_14 < arg_498_1.time_ and arg_498_1.time_ <= var_501_14 + arg_501_0 then
				arg_498_1.mask_.enabled = true
				arg_498_1.mask_.raycastTarget = true

				arg_498_1:SetGaussion(false)
			end

			local var_501_15 = 2

			if var_501_14 <= arg_498_1.time_ and arg_498_1.time_ < var_501_14 + var_501_15 then
				local var_501_16 = (arg_498_1.time_ - var_501_14) / var_501_15
				local var_501_17 = Color.New(0, 0, 0)

				var_501_17.a = Mathf.Lerp(1, 0, var_501_16)
				arg_498_1.mask_.color = var_501_17
			end

			if arg_498_1.time_ >= var_501_14 + var_501_15 and arg_498_1.time_ < var_501_14 + var_501_15 + arg_501_0 then
				local var_501_18 = Color.New(0, 0, 0)
				local var_501_19 = 0

				arg_498_1.mask_.enabled = false
				var_501_18.a = var_501_19
				arg_498_1.mask_.color = var_501_18
			end

			local var_501_20 = 0
			local var_501_21 = 1

			if var_501_20 < arg_498_1.time_ and arg_498_1.time_ <= var_501_20 + arg_501_0 then
				local var_501_22 = "play"
				local var_501_23 = "effect"

				arg_498_1:AudioAction(var_501_22, var_501_23, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_501_24 = 0
			local var_501_25 = 1

			if var_501_24 < arg_498_1.time_ and arg_498_1.time_ <= var_501_24 + arg_501_0 then
				local var_501_26 = "play"
				local var_501_27 = "effect"

				arg_498_1:AudioAction(var_501_26, var_501_27, "se_story_16", "se_story_16_rain01_loop", "")
			end

			local var_501_28 = manager.ui.mainCamera.transform
			local var_501_29 = 0.999999999999999

			if var_501_29 < arg_498_1.time_ and arg_498_1.time_ <= var_501_29 + arg_501_0 then
				local var_501_30 = arg_498_1.var_.effectI05exiayula1
				local var_501_31
				local var_501_32 = var_501_28

				if not var_501_30 then
					var_501_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_501_32)
					var_501_30.name = "xiayula1"
					arg_498_1.var_.effectI05exiayula1 = var_501_30
				else
					var_501_30.transform:SetParent(var_501_32)
				end

				var_501_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_501_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_501_33 = 0

			if var_501_33 < arg_498_1.time_ and arg_498_1.time_ <= var_501_33 + arg_501_0 then
				SetActive(arg_498_1.dialog_, false)
				SetActive(arg_498_1.allBtn_.gameObject, true)
				arg_498_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_498_1.isInLoopVideo = false
			end

			local var_501_34 = 0.0166666666666667

			if var_501_33 <= arg_498_1.time_ and arg_498_1.time_ < var_501_33 + var_501_34 then
				-- block empty
			end

			if arg_498_1.time_ >= var_501_33 + var_501_34 and arg_498_1.time_ < var_501_33 + var_501_34 + arg_501_0 then
				-- block empty
			end

			if arg_498_1.frameCnt_ <= 1 then
				arg_498_1.dialog_:SetActive(false)
			end

			local var_501_35 = 2
			local var_501_36 = 1.3

			if var_501_35 < arg_498_1.time_ and arg_498_1.time_ <= var_501_35 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0

				arg_498_1.dialog_:SetActive(true)

				arg_498_1.dialogCg_.alpha = 0

				local var_501_37 = LeanTween.value(arg_498_1.dialog_, 0, 1, 0.3)

				var_501_37:setOnUpdate(LuaHelper.FloatAction(function(arg_502_0)
					arg_498_1.dialogCg_.alpha = arg_502_0
				end))
				var_501_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_498_1.dialog_)
					var_501_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_498_1.duration_ = arg_498_1.duration_ + 0.3

				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_38 = arg_498_1:GetWordFromCfg(116431117)
				local var_501_39 = arg_498_1:FormatText(var_501_38.content)

				arg_498_1.text_.text = var_501_39

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_40 = 52
				local var_501_41 = utf8.len(var_501_39)
				local var_501_42 = var_501_40 <= 0 and var_501_36 or var_501_36 * (var_501_41 / var_501_40)

				if var_501_42 > 0 and var_501_36 < var_501_42 then
					arg_498_1.talkMaxDuration = var_501_42
					var_501_35 = var_501_35 + 0.3

					if var_501_42 + var_501_35 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_42 + var_501_35
					end
				end

				arg_498_1.text_.text = var_501_39
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_43 = var_501_35 + 0.3
			local var_501_44 = math.max(var_501_36, arg_498_1.talkMaxDuration)

			if var_501_43 <= arg_498_1.time_ and arg_498_1.time_ < var_501_43 + var_501_44 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_43) / var_501_44

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_43 + var_501_44 and arg_498_1.time_ < var_501_43 + var_501_44 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play116431118 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 116431118
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play116431119(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.9

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(116431118)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 36
				local var_507_5 = utf8.len(var_507_3)
				local var_507_6 = var_507_4 <= 0 and var_507_1 or var_507_1 * (var_507_5 / var_507_4)

				if var_507_6 > 0 and var_507_1 < var_507_6 then
					arg_504_1.talkMaxDuration = var_507_6

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_7 and arg_504_1.time_ < var_507_0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play116431119 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 116431119
		arg_508_1.duration_ = 10.4

		local var_508_0 = {
			zh = 10.4,
			ja = 10
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play116431120(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 1.2

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[264].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:GetWordFromCfg(116431119)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 48
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431119", "story_v_out_116431.awb") ~= 0 then
					local var_511_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431119", "story_v_out_116431.awb") / 1000

					if var_511_8 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_0
					end

					if var_511_3.prefab_name ~= "" and arg_508_1.actors_[var_511_3.prefab_name] ~= nil then
						local var_511_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_3.prefab_name].transform, "story_v_out_116431", "116431119", "story_v_out_116431.awb")

						arg_508_1:RecordAudio("116431119", var_511_9)
						arg_508_1:RecordAudio("116431119", var_511_9)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_116431", "116431119", "story_v_out_116431.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_116431", "116431119", "story_v_out_116431.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_10 and arg_508_1.time_ < var_511_0 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play116431120 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 116431120
		arg_512_1.duration_ = 2

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play116431121(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = "2079ui_story"

			if arg_512_1.actors_[var_515_0] == nil then
				local var_515_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_515_1) then
					local var_515_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_512_1.stage_.transform)

					var_515_2.name = var_515_0
					var_515_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_512_1.actors_[var_515_0] = var_515_2

					local var_515_3 = var_515_2:GetComponentInChildren(typeof(CharacterEffect))

					var_515_3.enabled = true

					local var_515_4 = GameObjectTools.GetOrAddComponent(var_515_2, typeof(DynamicBoneHelper))

					if var_515_4 then
						var_515_4:EnableDynamicBone(false)
					end

					arg_512_1:ShowWeapon(var_515_3.transform, false)

					arg_512_1.var_[var_515_0 .. "Animator"] = var_515_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_512_1.var_[var_515_0 .. "Animator"].applyRootMotion = true
					arg_512_1.var_[var_515_0 .. "LipSync"] = var_515_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_515_5 = arg_512_1.actors_["2079ui_story"].transform
			local var_515_6 = 0

			if var_515_6 < arg_512_1.time_ and arg_512_1.time_ <= var_515_6 + arg_515_0 then
				arg_512_1.var_.moveOldPos2079ui_story = var_515_5.localPosition
			end

			local var_515_7 = 0.001

			if var_515_6 <= arg_512_1.time_ and arg_512_1.time_ < var_515_6 + var_515_7 then
				local var_515_8 = (arg_512_1.time_ - var_515_6) / var_515_7
				local var_515_9 = Vector3.New(0, -1.28, -5.6)

				var_515_5.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos2079ui_story, var_515_9, var_515_8)

				local var_515_10 = manager.ui.mainCamera.transform.position - var_515_5.position

				var_515_5.forward = Vector3.New(var_515_10.x, var_515_10.y, var_515_10.z)

				local var_515_11 = var_515_5.localEulerAngles

				var_515_11.z = 0
				var_515_11.x = 0
				var_515_5.localEulerAngles = var_515_11
			end

			if arg_512_1.time_ >= var_515_6 + var_515_7 and arg_512_1.time_ < var_515_6 + var_515_7 + arg_515_0 then
				var_515_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_515_12 = manager.ui.mainCamera.transform.position - var_515_5.position

				var_515_5.forward = Vector3.New(var_515_12.x, var_515_12.y, var_515_12.z)

				local var_515_13 = var_515_5.localEulerAngles

				var_515_13.z = 0
				var_515_13.x = 0
				var_515_5.localEulerAngles = var_515_13
			end

			local var_515_14 = 0

			if var_515_14 < arg_512_1.time_ and arg_512_1.time_ <= var_515_14 + arg_515_0 then
				arg_512_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_515_15 = arg_512_1.actors_["2079ui_story"]
			local var_515_16 = 0

			if var_515_16 < arg_512_1.time_ and arg_512_1.time_ <= var_515_16 + arg_515_0 and not isNil(var_515_15) and arg_512_1.var_.characterEffect2079ui_story == nil then
				arg_512_1.var_.characterEffect2079ui_story = var_515_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_17 = 0.2

			if var_515_16 <= arg_512_1.time_ and arg_512_1.time_ < var_515_16 + var_515_17 and not isNil(var_515_15) then
				local var_515_18 = (arg_512_1.time_ - var_515_16) / var_515_17

				if arg_512_1.var_.characterEffect2079ui_story and not isNil(var_515_15) then
					arg_512_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_16 + var_515_17 and arg_512_1.time_ < var_515_16 + var_515_17 + arg_515_0 and not isNil(var_515_15) and arg_512_1.var_.characterEffect2079ui_story then
				arg_512_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_515_19 = 0
			local var_515_20 = 0.075

			if var_515_19 < arg_512_1.time_ and arg_512_1.time_ <= var_515_19 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_21 = arg_512_1:FormatText(StoryNameCfg[323].name)

				arg_512_1.leftNameTxt_.text = var_515_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_22 = arg_512_1:GetWordFromCfg(116431120)
				local var_515_23 = arg_512_1:FormatText(var_515_22.content)

				arg_512_1.text_.text = var_515_23

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_24 = 3
				local var_515_25 = utf8.len(var_515_23)
				local var_515_26 = var_515_24 <= 0 and var_515_20 or var_515_20 * (var_515_25 / var_515_24)

				if var_515_26 > 0 and var_515_20 < var_515_26 then
					arg_512_1.talkMaxDuration = var_515_26

					if var_515_26 + var_515_19 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_26 + var_515_19
					end
				end

				arg_512_1.text_.text = var_515_23
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431120", "story_v_out_116431.awb") ~= 0 then
					local var_515_27 = manager.audio:GetVoiceLength("story_v_out_116431", "116431120", "story_v_out_116431.awb") / 1000

					if var_515_27 + var_515_19 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_27 + var_515_19
					end

					if var_515_22.prefab_name ~= "" and arg_512_1.actors_[var_515_22.prefab_name] ~= nil then
						local var_515_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_22.prefab_name].transform, "story_v_out_116431", "116431120", "story_v_out_116431.awb")

						arg_512_1:RecordAudio("116431120", var_515_28)
						arg_512_1:RecordAudio("116431120", var_515_28)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_116431", "116431120", "story_v_out_116431.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_116431", "116431120", "story_v_out_116431.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_29 = math.max(var_515_20, arg_512_1.talkMaxDuration)

			if var_515_19 <= arg_512_1.time_ and arg_512_1.time_ < var_515_19 + var_515_29 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_19) / var_515_29

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_19 + var_515_29 and arg_512_1.time_ < var_515_19 + var_515_29 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play116431121 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 116431121
		arg_516_1.duration_ = 10.3

		local var_516_0 = {
			zh = 7.166,
			ja = 10.3
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play116431122(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = "I05c"

			if arg_516_1.bgs_[var_519_0] == nil then
				local var_519_1 = Object.Instantiate(arg_516_1.paintGo_)

				var_519_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_519_0)
				var_519_1.name = var_519_0
				var_519_1.transform.parent = arg_516_1.stage_.transform
				var_519_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_516_1.bgs_[var_519_0] = var_519_1
			end

			local var_519_2 = 2

			if var_519_2 < arg_516_1.time_ and arg_516_1.time_ <= var_519_2 + arg_519_0 then
				local var_519_3 = manager.ui.mainCamera.transform.localPosition
				local var_519_4 = Vector3.New(0, 0, 10) + Vector3.New(var_519_3.x, var_519_3.y, 0)
				local var_519_5 = arg_516_1.bgs_.I05c

				var_519_5.transform.localPosition = var_519_4
				var_519_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_6 = var_519_5:GetComponent("SpriteRenderer")

				if var_519_6 and var_519_6.sprite then
					local var_519_7 = (var_519_5.transform.localPosition - var_519_3).z
					local var_519_8 = manager.ui.mainCameraCom_
					local var_519_9 = 2 * var_519_7 * Mathf.Tan(var_519_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_519_10 = var_519_9 * var_519_8.aspect
					local var_519_11 = var_519_6.sprite.bounds.size.x
					local var_519_12 = var_519_6.sprite.bounds.size.y
					local var_519_13 = var_519_10 / var_519_11
					local var_519_14 = var_519_9 / var_519_12
					local var_519_15 = var_519_14 < var_519_13 and var_519_13 or var_519_14

					var_519_5.transform.localScale = Vector3.New(var_519_15, var_519_15, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "I05c" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_16 = 0

			if var_519_16 < arg_516_1.time_ and arg_516_1.time_ <= var_519_16 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_17 = 2

			if var_519_16 <= arg_516_1.time_ and arg_516_1.time_ < var_519_16 + var_519_17 then
				local var_519_18 = (arg_516_1.time_ - var_519_16) / var_519_17
				local var_519_19 = Color.New(0, 0, 0)

				var_519_19.a = Mathf.Lerp(0, 1, var_519_18)
				arg_516_1.mask_.color = var_519_19
			end

			if arg_516_1.time_ >= var_519_16 + var_519_17 and arg_516_1.time_ < var_519_16 + var_519_17 + arg_519_0 then
				local var_519_20 = Color.New(0, 0, 0)

				var_519_20.a = 1
				arg_516_1.mask_.color = var_519_20
			end

			local var_519_21 = 2

			if var_519_21 < arg_516_1.time_ and arg_516_1.time_ <= var_519_21 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_22 = 2

			if var_519_21 <= arg_516_1.time_ and arg_516_1.time_ < var_519_21 + var_519_22 then
				local var_519_23 = (arg_516_1.time_ - var_519_21) / var_519_22
				local var_519_24 = Color.New(0, 0, 0)

				var_519_24.a = Mathf.Lerp(1, 0, var_519_23)
				arg_516_1.mask_.color = var_519_24
			end

			if arg_516_1.time_ >= var_519_21 + var_519_22 and arg_516_1.time_ < var_519_21 + var_519_22 + arg_519_0 then
				local var_519_25 = Color.New(0, 0, 0)
				local var_519_26 = 0

				arg_516_1.mask_.enabled = false
				var_519_25.a = var_519_26
				arg_516_1.mask_.color = var_519_25
			end

			local var_519_27 = arg_516_1.actors_["2079ui_story"].transform
			local var_519_28 = 1.966

			if var_519_28 < arg_516_1.time_ and arg_516_1.time_ <= var_519_28 + arg_519_0 then
				arg_516_1.var_.moveOldPos2079ui_story = var_519_27.localPosition
			end

			local var_519_29 = 0.001

			if var_519_28 <= arg_516_1.time_ and arg_516_1.time_ < var_519_28 + var_519_29 then
				local var_519_30 = (arg_516_1.time_ - var_519_28) / var_519_29
				local var_519_31 = Vector3.New(0, 100, 0)

				var_519_27.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos2079ui_story, var_519_31, var_519_30)

				local var_519_32 = manager.ui.mainCamera.transform.position - var_519_27.position

				var_519_27.forward = Vector3.New(var_519_32.x, var_519_32.y, var_519_32.z)

				local var_519_33 = var_519_27.localEulerAngles

				var_519_33.z = 0
				var_519_33.x = 0
				var_519_27.localEulerAngles = var_519_33
			end

			if arg_516_1.time_ >= var_519_28 + var_519_29 and arg_516_1.time_ < var_519_28 + var_519_29 + arg_519_0 then
				var_519_27.localPosition = Vector3.New(0, 100, 0)

				local var_519_34 = manager.ui.mainCamera.transform.position - var_519_27.position

				var_519_27.forward = Vector3.New(var_519_34.x, var_519_34.y, var_519_34.z)

				local var_519_35 = var_519_27.localEulerAngles

				var_519_35.z = 0
				var_519_35.x = 0
				var_519_27.localEulerAngles = var_519_35
			end

			local var_519_36 = arg_516_1.actors_["1028ui_story"].transform
			local var_519_37 = 4

			if var_519_37 < arg_516_1.time_ and arg_516_1.time_ <= var_519_37 + arg_519_0 then
				arg_516_1.var_.moveOldPos1028ui_story = var_519_36.localPosition
			end

			local var_519_38 = 0.001

			if var_519_37 <= arg_516_1.time_ and arg_516_1.time_ < var_519_37 + var_519_38 then
				local var_519_39 = (arg_516_1.time_ - var_519_37) / var_519_38
				local var_519_40 = Vector3.New(0, -0.9, -5.9)

				var_519_36.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1028ui_story, var_519_40, var_519_39)

				local var_519_41 = manager.ui.mainCamera.transform.position - var_519_36.position

				var_519_36.forward = Vector3.New(var_519_41.x, var_519_41.y, var_519_41.z)

				local var_519_42 = var_519_36.localEulerAngles

				var_519_42.z = 0
				var_519_42.x = 0
				var_519_36.localEulerAngles = var_519_42
			end

			if arg_516_1.time_ >= var_519_37 + var_519_38 and arg_516_1.time_ < var_519_37 + var_519_38 + arg_519_0 then
				var_519_36.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_519_43 = manager.ui.mainCamera.transform.position - var_519_36.position

				var_519_36.forward = Vector3.New(var_519_43.x, var_519_43.y, var_519_43.z)

				local var_519_44 = var_519_36.localEulerAngles

				var_519_44.z = 0
				var_519_44.x = 0
				var_519_36.localEulerAngles = var_519_44
			end

			local var_519_45 = arg_516_1.actors_["1028ui_story"]
			local var_519_46 = 4

			if var_519_46 < arg_516_1.time_ and arg_516_1.time_ <= var_519_46 + arg_519_0 and not isNil(var_519_45) and arg_516_1.var_.characterEffect1028ui_story == nil then
				arg_516_1.var_.characterEffect1028ui_story = var_519_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_47 = 0.2

			if var_519_46 <= arg_516_1.time_ and arg_516_1.time_ < var_519_46 + var_519_47 and not isNil(var_519_45) then
				local var_519_48 = (arg_516_1.time_ - var_519_46) / var_519_47

				if arg_516_1.var_.characterEffect1028ui_story and not isNil(var_519_45) then
					arg_516_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_46 + var_519_47 and arg_516_1.time_ < var_519_46 + var_519_47 + arg_519_0 and not isNil(var_519_45) and arg_516_1.var_.characterEffect1028ui_story then
				arg_516_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_519_49 = 4

			if var_519_49 < arg_516_1.time_ and arg_516_1.time_ <= var_519_49 + arg_519_0 then
				arg_516_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_519_50 = 4

			if var_519_50 < arg_516_1.time_ and arg_516_1.time_ <= var_519_50 + arg_519_0 then
				arg_516_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_516_1.frameCnt_ <= 1 then
				arg_516_1.dialog_:SetActive(false)
			end

			local var_519_51 = 4
			local var_519_52 = 0.275

			if var_519_51 < arg_516_1.time_ and arg_516_1.time_ <= var_519_51 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0

				arg_516_1.dialog_:SetActive(true)

				arg_516_1.dialogCg_.alpha = 0

				local var_519_53 = LeanTween.value(arg_516_1.dialog_, 0, 1, 0.3)

				var_519_53:setOnUpdate(LuaHelper.FloatAction(function(arg_520_0)
					arg_516_1.dialogCg_.alpha = arg_520_0
				end))
				var_519_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_516_1.dialog_)
					var_519_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_516_1.duration_ = arg_516_1.duration_ + 0.3

				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_54 = arg_516_1:FormatText(StoryNameCfg[327].name)

				arg_516_1.leftNameTxt_.text = var_519_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_55 = arg_516_1:GetWordFromCfg(116431121)
				local var_519_56 = arg_516_1:FormatText(var_519_55.content)

				arg_516_1.text_.text = var_519_56

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_57 = 11
				local var_519_58 = utf8.len(var_519_56)
				local var_519_59 = var_519_57 <= 0 and var_519_52 or var_519_52 * (var_519_58 / var_519_57)

				if var_519_59 > 0 and var_519_52 < var_519_59 then
					arg_516_1.talkMaxDuration = var_519_59
					var_519_51 = var_519_51 + 0.3

					if var_519_59 + var_519_51 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_59 + var_519_51
					end
				end

				arg_516_1.text_.text = var_519_56
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431121", "story_v_out_116431.awb") ~= 0 then
					local var_519_60 = manager.audio:GetVoiceLength("story_v_out_116431", "116431121", "story_v_out_116431.awb") / 1000

					if var_519_60 + var_519_51 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_60 + var_519_51
					end

					if var_519_55.prefab_name ~= "" and arg_516_1.actors_[var_519_55.prefab_name] ~= nil then
						local var_519_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_55.prefab_name].transform, "story_v_out_116431", "116431121", "story_v_out_116431.awb")

						arg_516_1:RecordAudio("116431121", var_519_61)
						arg_516_1:RecordAudio("116431121", var_519_61)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_116431", "116431121", "story_v_out_116431.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_116431", "116431121", "story_v_out_116431.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_62 = var_519_51 + 0.3
			local var_519_63 = math.max(var_519_52, arg_516_1.talkMaxDuration)

			if var_519_62 <= arg_516_1.time_ and arg_516_1.time_ < var_519_62 + var_519_63 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_62) / var_519_63

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_62 + var_519_63 and arg_516_1.time_ < var_519_62 + var_519_63 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play116431122 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 116431122
		arg_522_1.duration_ = 5

		local var_522_0 = {
			zh = 4.833,
			ja = 5
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play116431123(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_525_2 = 0
			local var_525_3 = 0.525

			if var_525_2 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_4 = arg_522_1:FormatText(StoryNameCfg[327].name)

				arg_522_1.leftNameTxt_.text = var_525_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_5 = arg_522_1:GetWordFromCfg(116431122)
				local var_525_6 = arg_522_1:FormatText(var_525_5.content)

				arg_522_1.text_.text = var_525_6

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_7 = 21
				local var_525_8 = utf8.len(var_525_6)
				local var_525_9 = var_525_7 <= 0 and var_525_3 or var_525_3 * (var_525_8 / var_525_7)

				if var_525_9 > 0 and var_525_3 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_2
					end
				end

				arg_522_1.text_.text = var_525_6
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431122", "story_v_out_116431.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_out_116431", "116431122", "story_v_out_116431.awb") / 1000

					if var_525_10 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_2
					end

					if var_525_5.prefab_name ~= "" and arg_522_1.actors_[var_525_5.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_5.prefab_name].transform, "story_v_out_116431", "116431122", "story_v_out_116431.awb")

						arg_522_1:RecordAudio("116431122", var_525_11)
						arg_522_1:RecordAudio("116431122", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_116431", "116431122", "story_v_out_116431.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_116431", "116431122", "story_v_out_116431.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_3, arg_522_1.talkMaxDuration)

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_2) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_2 + var_525_12 and arg_522_1.time_ < var_525_2 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play116431123 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 116431123
		arg_526_1.duration_ = 2.7

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play116431124(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1029ui_story"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos1029ui_story = var_529_0.localPosition
			end

			local var_529_2 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2
				local var_529_4 = Vector3.New(0.7, -1.09, -6.2)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1029ui_story, var_529_4, var_529_3)

				local var_529_5 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_5.x, var_529_5.y, var_529_5.z)

				local var_529_6 = var_529_0.localEulerAngles

				var_529_6.z = 0
				var_529_6.x = 0
				var_529_0.localEulerAngles = var_529_6
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_529_7 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_7.x, var_529_7.y, var_529_7.z)

				local var_529_8 = var_529_0.localEulerAngles

				var_529_8.z = 0
				var_529_8.x = 0
				var_529_0.localEulerAngles = var_529_8
			end

			local var_529_9 = arg_526_1.actors_["1028ui_story"]
			local var_529_10 = 0

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1028ui_story == nil then
				arg_526_1.var_.characterEffect1028ui_story = var_529_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_11 = 0.2

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_11 and not isNil(var_529_9) then
				local var_529_12 = (arg_526_1.time_ - var_529_10) / var_529_11

				if arg_526_1.var_.characterEffect1028ui_story and not isNil(var_529_9) then
					local var_529_13 = Mathf.Lerp(0, 0.5, var_529_12)

					arg_526_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1028ui_story.fillRatio = var_529_13
				end
			end

			if arg_526_1.time_ >= var_529_10 + var_529_11 and arg_526_1.time_ < var_529_10 + var_529_11 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1028ui_story then
				local var_529_14 = 0.5

				arg_526_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1028ui_story.fillRatio = var_529_14
			end

			local var_529_15 = arg_526_1.actors_["1029ui_story"]
			local var_529_16 = 0

			if var_529_16 < arg_526_1.time_ and arg_526_1.time_ <= var_529_16 + arg_529_0 and not isNil(var_529_15) and arg_526_1.var_.characterEffect1029ui_story == nil then
				arg_526_1.var_.characterEffect1029ui_story = var_529_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_17 = 0.2

			if var_529_16 <= arg_526_1.time_ and arg_526_1.time_ < var_529_16 + var_529_17 and not isNil(var_529_15) then
				local var_529_18 = (arg_526_1.time_ - var_529_16) / var_529_17

				if arg_526_1.var_.characterEffect1029ui_story and not isNil(var_529_15) then
					arg_526_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_16 + var_529_17 and arg_526_1.time_ < var_529_16 + var_529_17 + arg_529_0 and not isNil(var_529_15) and arg_526_1.var_.characterEffect1029ui_story then
				arg_526_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_529_19 = 0

			if var_529_19 < arg_526_1.time_ and arg_526_1.time_ <= var_529_19 + arg_529_0 then
				arg_526_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			local var_529_20 = 0

			if var_529_20 < arg_526_1.time_ and arg_526_1.time_ <= var_529_20 + arg_529_0 then
				arg_526_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_529_21 = arg_526_1.actors_["1028ui_story"].transform
			local var_529_22 = 0

			if var_529_22 < arg_526_1.time_ and arg_526_1.time_ <= var_529_22 + arg_529_0 then
				arg_526_1.var_.moveOldPos1028ui_story = var_529_21.localPosition
			end

			local var_529_23 = 0.001

			if var_529_22 <= arg_526_1.time_ and arg_526_1.time_ < var_529_22 + var_529_23 then
				local var_529_24 = (arg_526_1.time_ - var_529_22) / var_529_23
				local var_529_25 = Vector3.New(-0.7, -0.9, -5.9)

				var_529_21.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1028ui_story, var_529_25, var_529_24)

				local var_529_26 = manager.ui.mainCamera.transform.position - var_529_21.position

				var_529_21.forward = Vector3.New(var_529_26.x, var_529_26.y, var_529_26.z)

				local var_529_27 = var_529_21.localEulerAngles

				var_529_27.z = 0
				var_529_27.x = 0
				var_529_21.localEulerAngles = var_529_27
			end

			if arg_526_1.time_ >= var_529_22 + var_529_23 and arg_526_1.time_ < var_529_22 + var_529_23 + arg_529_0 then
				var_529_21.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_529_28 = manager.ui.mainCamera.transform.position - var_529_21.position

				var_529_21.forward = Vector3.New(var_529_28.x, var_529_28.y, var_529_28.z)

				local var_529_29 = var_529_21.localEulerAngles

				var_529_29.z = 0
				var_529_29.x = 0
				var_529_21.localEulerAngles = var_529_29
			end

			local var_529_30 = 0
			local var_529_31 = 0.05

			if var_529_30 < arg_526_1.time_ and arg_526_1.time_ <= var_529_30 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_32 = arg_526_1:FormatText(StoryNameCfg[319].name)

				arg_526_1.leftNameTxt_.text = var_529_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_33 = arg_526_1:GetWordFromCfg(116431123)
				local var_529_34 = arg_526_1:FormatText(var_529_33.content)

				arg_526_1.text_.text = var_529_34

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_35 = 2
				local var_529_36 = utf8.len(var_529_34)
				local var_529_37 = var_529_35 <= 0 and var_529_31 or var_529_31 * (var_529_36 / var_529_35)

				if var_529_37 > 0 and var_529_31 < var_529_37 then
					arg_526_1.talkMaxDuration = var_529_37

					if var_529_37 + var_529_30 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_37 + var_529_30
					end
				end

				arg_526_1.text_.text = var_529_34
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431123", "story_v_out_116431.awb") ~= 0 then
					local var_529_38 = manager.audio:GetVoiceLength("story_v_out_116431", "116431123", "story_v_out_116431.awb") / 1000

					if var_529_38 + var_529_30 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_38 + var_529_30
					end

					if var_529_33.prefab_name ~= "" and arg_526_1.actors_[var_529_33.prefab_name] ~= nil then
						local var_529_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_33.prefab_name].transform, "story_v_out_116431", "116431123", "story_v_out_116431.awb")

						arg_526_1:RecordAudio("116431123", var_529_39)
						arg_526_1:RecordAudio("116431123", var_529_39)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_116431", "116431123", "story_v_out_116431.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_116431", "116431123", "story_v_out_116431.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_40 = math.max(var_529_31, arg_526_1.talkMaxDuration)

			if var_529_30 <= arg_526_1.time_ and arg_526_1.time_ < var_529_30 + var_529_40 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_30) / var_529_40

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_30 + var_529_40 and arg_526_1.time_ < var_529_30 + var_529_40 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play116431124 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 116431124
		arg_530_1.duration_ = 3.67

		local var_530_0 = {
			zh = 3.6,
			ja = 3.666
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play116431125(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1028ui_story"].transform
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.var_.moveOldPos1028ui_story = var_533_0.localPosition
			end

			local var_533_2 = 0.001

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2
				local var_533_4 = Vector3.New(-0.7, -0.9, -5.9)

				var_533_0.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1028ui_story, var_533_4, var_533_3)

				local var_533_5 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_5.x, var_533_5.y, var_533_5.z)

				local var_533_6 = var_533_0.localEulerAngles

				var_533_6.z = 0
				var_533_6.x = 0
				var_533_0.localEulerAngles = var_533_6
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 then
				var_533_0.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_533_7 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_7.x, var_533_7.y, var_533_7.z)

				local var_533_8 = var_533_0.localEulerAngles

				var_533_8.z = 0
				var_533_8.x = 0
				var_533_0.localEulerAngles = var_533_8
			end

			local var_533_9 = arg_530_1.actors_["1029ui_story"].transform
			local var_533_10 = 0

			if var_533_10 < arg_530_1.time_ and arg_530_1.time_ <= var_533_10 + arg_533_0 then
				arg_530_1.var_.moveOldPos1029ui_story = var_533_9.localPosition
			end

			local var_533_11 = 0.001

			if var_533_10 <= arg_530_1.time_ and arg_530_1.time_ < var_533_10 + var_533_11 then
				local var_533_12 = (arg_530_1.time_ - var_533_10) / var_533_11
				local var_533_13 = Vector3.New(0.7, -1.09, -6.2)

				var_533_9.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1029ui_story, var_533_13, var_533_12)

				local var_533_14 = manager.ui.mainCamera.transform.position - var_533_9.position

				var_533_9.forward = Vector3.New(var_533_14.x, var_533_14.y, var_533_14.z)

				local var_533_15 = var_533_9.localEulerAngles

				var_533_15.z = 0
				var_533_15.x = 0
				var_533_9.localEulerAngles = var_533_15
			end

			if arg_530_1.time_ >= var_533_10 + var_533_11 and arg_530_1.time_ < var_533_10 + var_533_11 + arg_533_0 then
				var_533_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_533_16 = manager.ui.mainCamera.transform.position - var_533_9.position

				var_533_9.forward = Vector3.New(var_533_16.x, var_533_16.y, var_533_16.z)

				local var_533_17 = var_533_9.localEulerAngles

				var_533_17.z = 0
				var_533_17.x = 0
				var_533_9.localEulerAngles = var_533_17
			end

			local var_533_18 = 0

			if var_533_18 < arg_530_1.time_ and arg_530_1.time_ <= var_533_18 + arg_533_0 then
				arg_530_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_533_19 = 0
			local var_533_20 = 0.425

			if var_533_19 < arg_530_1.time_ and arg_530_1.time_ <= var_533_19 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_21 = arg_530_1:FormatText(StoryNameCfg[319].name)

				arg_530_1.leftNameTxt_.text = var_533_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_22 = arg_530_1:GetWordFromCfg(116431124)
				local var_533_23 = arg_530_1:FormatText(var_533_22.content)

				arg_530_1.text_.text = var_533_23

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_24 = 17
				local var_533_25 = utf8.len(var_533_23)
				local var_533_26 = var_533_24 <= 0 and var_533_20 or var_533_20 * (var_533_25 / var_533_24)

				if var_533_26 > 0 and var_533_20 < var_533_26 then
					arg_530_1.talkMaxDuration = var_533_26

					if var_533_26 + var_533_19 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_26 + var_533_19
					end
				end

				arg_530_1.text_.text = var_533_23
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431124", "story_v_out_116431.awb") ~= 0 then
					local var_533_27 = manager.audio:GetVoiceLength("story_v_out_116431", "116431124", "story_v_out_116431.awb") / 1000

					if var_533_27 + var_533_19 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_27 + var_533_19
					end

					if var_533_22.prefab_name ~= "" and arg_530_1.actors_[var_533_22.prefab_name] ~= nil then
						local var_533_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_22.prefab_name].transform, "story_v_out_116431", "116431124", "story_v_out_116431.awb")

						arg_530_1:RecordAudio("116431124", var_533_28)
						arg_530_1:RecordAudio("116431124", var_533_28)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_116431", "116431124", "story_v_out_116431.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_116431", "116431124", "story_v_out_116431.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_29 = math.max(var_533_20, arg_530_1.talkMaxDuration)

			if var_533_19 <= arg_530_1.time_ and arg_530_1.time_ < var_533_19 + var_533_29 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_19) / var_533_29

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_19 + var_533_29 and arg_530_1.time_ < var_533_19 + var_533_29 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play116431125 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 116431125
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play116431126(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1028ui_story"].transform
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.var_.moveOldPos1028ui_story = var_537_0.localPosition
			end

			local var_537_2 = 0.001

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2
				local var_537_4 = Vector3.New(0, 100, 0)

				var_537_0.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1028ui_story, var_537_4, var_537_3)

				local var_537_5 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_5.x, var_537_5.y, var_537_5.z)

				local var_537_6 = var_537_0.localEulerAngles

				var_537_6.z = 0
				var_537_6.x = 0
				var_537_0.localEulerAngles = var_537_6
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 then
				var_537_0.localPosition = Vector3.New(0, 100, 0)

				local var_537_7 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_7.x, var_537_7.y, var_537_7.z)

				local var_537_8 = var_537_0.localEulerAngles

				var_537_8.z = 0
				var_537_8.x = 0
				var_537_0.localEulerAngles = var_537_8
			end

			local var_537_9 = arg_534_1.actors_["1029ui_story"].transform
			local var_537_10 = 0

			if var_537_10 < arg_534_1.time_ and arg_534_1.time_ <= var_537_10 + arg_537_0 then
				arg_534_1.var_.moveOldPos1029ui_story = var_537_9.localPosition
			end

			local var_537_11 = 0.001

			if var_537_10 <= arg_534_1.time_ and arg_534_1.time_ < var_537_10 + var_537_11 then
				local var_537_12 = (arg_534_1.time_ - var_537_10) / var_537_11
				local var_537_13 = Vector3.New(0, 100, 0)

				var_537_9.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1029ui_story, var_537_13, var_537_12)

				local var_537_14 = manager.ui.mainCamera.transform.position - var_537_9.position

				var_537_9.forward = Vector3.New(var_537_14.x, var_537_14.y, var_537_14.z)

				local var_537_15 = var_537_9.localEulerAngles

				var_537_15.z = 0
				var_537_15.x = 0
				var_537_9.localEulerAngles = var_537_15
			end

			if arg_534_1.time_ >= var_537_10 + var_537_11 and arg_534_1.time_ < var_537_10 + var_537_11 + arg_537_0 then
				var_537_9.localPosition = Vector3.New(0, 100, 0)

				local var_537_16 = manager.ui.mainCamera.transform.position - var_537_9.position

				var_537_9.forward = Vector3.New(var_537_16.x, var_537_16.y, var_537_16.z)

				local var_537_17 = var_537_9.localEulerAngles

				var_537_17.z = 0
				var_537_17.x = 0
				var_537_9.localEulerAngles = var_537_17
			end

			local var_537_18 = 0
			local var_537_19 = 1.225

			if var_537_18 < arg_534_1.time_ and arg_534_1.time_ <= var_537_18 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_20 = arg_534_1:GetWordFromCfg(116431125)
				local var_537_21 = arg_534_1:FormatText(var_537_20.content)

				arg_534_1.text_.text = var_537_21

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_22 = 49
				local var_537_23 = utf8.len(var_537_21)
				local var_537_24 = var_537_22 <= 0 and var_537_19 or var_537_19 * (var_537_23 / var_537_22)

				if var_537_24 > 0 and var_537_19 < var_537_24 then
					arg_534_1.talkMaxDuration = var_537_24

					if var_537_24 + var_537_18 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_24 + var_537_18
					end
				end

				arg_534_1.text_.text = var_537_21
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_25 = math.max(var_537_19, arg_534_1.talkMaxDuration)

			if var_537_18 <= arg_534_1.time_ and arg_534_1.time_ < var_537_18 + var_537_25 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_18) / var_537_25

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_18 + var_537_25 and arg_534_1.time_ < var_537_18 + var_537_25 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play116431126 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 116431126
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play116431127(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0
			local var_541_1 = 0.7

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_2 = arg_538_1:GetWordFromCfg(116431126)
				local var_541_3 = arg_538_1:FormatText(var_541_2.content)

				arg_538_1.text_.text = var_541_3

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_4 = 28
				local var_541_5 = utf8.len(var_541_3)
				local var_541_6 = var_541_4 <= 0 and var_541_1 or var_541_1 * (var_541_5 / var_541_4)

				if var_541_6 > 0 and var_541_1 < var_541_6 then
					arg_538_1.talkMaxDuration = var_541_6

					if var_541_6 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_6 + var_541_0
					end
				end

				arg_538_1.text_.text = var_541_3
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_7 = math.max(var_541_1, arg_538_1.talkMaxDuration)

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_7 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_0) / var_541_7

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_0 + var_541_7 and arg_538_1.time_ < var_541_0 + var_541_7 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play116431127 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 116431127
		arg_542_1.duration_ = 9

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play116431128(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 2

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				local var_545_1 = manager.ui.mainCamera.transform.localPosition
				local var_545_2 = Vector3.New(0, 0, 10) + Vector3.New(var_545_1.x, var_545_1.y, 0)
				local var_545_3 = arg_542_1.bgs_.I05e

				var_545_3.transform.localPosition = var_545_2
				var_545_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_545_4 = var_545_3:GetComponent("SpriteRenderer")

				if var_545_4 and var_545_4.sprite then
					local var_545_5 = (var_545_3.transform.localPosition - var_545_1).z
					local var_545_6 = manager.ui.mainCameraCom_
					local var_545_7 = 2 * var_545_5 * Mathf.Tan(var_545_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_545_8 = var_545_7 * var_545_6.aspect
					local var_545_9 = var_545_4.sprite.bounds.size.x
					local var_545_10 = var_545_4.sprite.bounds.size.y
					local var_545_11 = var_545_8 / var_545_9
					local var_545_12 = var_545_7 / var_545_10
					local var_545_13 = var_545_12 < var_545_11 and var_545_11 or var_545_12

					var_545_3.transform.localScale = Vector3.New(var_545_13, var_545_13, 0)
				end

				for iter_545_0, iter_545_1 in pairs(arg_542_1.bgs_) do
					if iter_545_0 ~= "I05e" then
						iter_545_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_545_14 = 0

			if var_545_14 < arg_542_1.time_ and arg_542_1.time_ <= var_545_14 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_15 = 2

			if var_545_14 <= arg_542_1.time_ and arg_542_1.time_ < var_545_14 + var_545_15 then
				local var_545_16 = (arg_542_1.time_ - var_545_14) / var_545_15
				local var_545_17 = Color.New(0, 0, 0)

				var_545_17.a = Mathf.Lerp(0, 1, var_545_16)
				arg_542_1.mask_.color = var_545_17
			end

			if arg_542_1.time_ >= var_545_14 + var_545_15 and arg_542_1.time_ < var_545_14 + var_545_15 + arg_545_0 then
				local var_545_18 = Color.New(0, 0, 0)

				var_545_18.a = 1
				arg_542_1.mask_.color = var_545_18
			end

			local var_545_19 = 2

			if var_545_19 < arg_542_1.time_ and arg_542_1.time_ <= var_545_19 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_20 = 2

			if var_545_19 <= arg_542_1.time_ and arg_542_1.time_ < var_545_19 + var_545_20 then
				local var_545_21 = (arg_542_1.time_ - var_545_19) / var_545_20
				local var_545_22 = Color.New(0, 0, 0)

				var_545_22.a = Mathf.Lerp(1, 0, var_545_21)
				arg_542_1.mask_.color = var_545_22
			end

			if arg_542_1.time_ >= var_545_19 + var_545_20 and arg_542_1.time_ < var_545_19 + var_545_20 + arg_545_0 then
				local var_545_23 = Color.New(0, 0, 0)
				local var_545_24 = 0

				arg_542_1.mask_.enabled = false
				var_545_23.a = var_545_24
				arg_542_1.mask_.color = var_545_23
			end

			local var_545_25 = 0
			local var_545_26 = 1

			if var_545_25 < arg_542_1.time_ and arg_542_1.time_ <= var_545_25 + arg_545_0 then
				local var_545_27 = "stop"
				local var_545_28 = "music"

				arg_542_1:AudioAction(var_545_27, var_545_28, "se_story_16", "se_story_16_rain01_loop", "")

				local var_545_29 = ""
				local var_545_30 = manager.audio:GetAudioName("se_story_16", "se_story_16_rain01_loop")

				if var_545_30 ~= "" then
					if arg_542_1.bgmTxt_.text ~= var_545_30 and arg_542_1.bgmTxt_.text ~= "" then
						if arg_542_1.bgmTxt2_.text ~= "" then
							arg_542_1.bgmTxt_.text = arg_542_1.bgmTxt2_.text
						end

						arg_542_1.bgmTxt2_.text = var_545_30

						arg_542_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_542_1.bgmTxt_.text = var_545_30
						arg_542_1.bgmTxt2_.text = var_545_30
					end

					if arg_542_1.bgmTimer then
						arg_542_1.bgmTimer:Stop()

						arg_542_1.bgmTimer = nil
					end

					if arg_542_1.settingData.show_music_name == 1 then
						arg_542_1.musicController:SetSelectedState("show")
						arg_542_1.musicAnimator_:Play("open", 0, 0)

						if arg_542_1.settingData.music_time ~= 0 then
							arg_542_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_542_1.settingData.music_time), function()
								if arg_542_1 == nil or isNil(arg_542_1.bgmTxt_) then
									return
								end

								arg_542_1.musicController:SetSelectedState("hide")
								arg_542_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_545_31 = 0
			local var_545_32 = 1

			if var_545_31 < arg_542_1.time_ and arg_542_1.time_ <= var_545_31 + arg_545_0 then
				local var_545_33 = "play"
				local var_545_34 = "effect"

				arg_542_1:AudioAction(var_545_33, var_545_34, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_545_35 = 0
			local var_545_36 = 1

			if var_545_35 < arg_542_1.time_ and arg_542_1.time_ <= var_545_35 + arg_545_0 then
				local var_545_37 = "play"
				local var_545_38 = "effect"

				arg_542_1:AudioAction(var_545_37, var_545_38, "se_story_16", "se_story_16_rain02_loop", "")
			end

			if arg_542_1.frameCnt_ <= 1 then
				arg_542_1.dialog_:SetActive(false)
			end

			local var_545_39 = 4
			local var_545_40 = 1.225

			if var_545_39 < arg_542_1.time_ and arg_542_1.time_ <= var_545_39 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0

				arg_542_1.dialog_:SetActive(true)

				arg_542_1.dialogCg_.alpha = 0

				local var_545_41 = LeanTween.value(arg_542_1.dialog_, 0, 1, 0.3)

				var_545_41:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_542_1.dialogCg_.alpha = arg_547_0
				end))
				var_545_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_542_1.dialog_)
					var_545_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_542_1.duration_ = arg_542_1.duration_ + 0.3

				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_42 = arg_542_1:GetWordFromCfg(116431127)
				local var_545_43 = arg_542_1:FormatText(var_545_42.content)

				arg_542_1.text_.text = var_545_43

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_44 = 49
				local var_545_45 = utf8.len(var_545_43)
				local var_545_46 = var_545_44 <= 0 and var_545_40 or var_545_40 * (var_545_45 / var_545_44)

				if var_545_46 > 0 and var_545_40 < var_545_46 then
					arg_542_1.talkMaxDuration = var_545_46
					var_545_39 = var_545_39 + 0.3

					if var_545_46 + var_545_39 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_46 + var_545_39
					end
				end

				arg_542_1.text_.text = var_545_43
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_47 = var_545_39 + 0.3
			local var_545_48 = math.max(var_545_40, arg_542_1.talkMaxDuration)

			if var_545_47 <= arg_542_1.time_ and arg_542_1.time_ < var_545_47 + var_545_48 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_47) / var_545_48

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_47 + var_545_48 and arg_542_1.time_ < var_545_47 + var_545_48 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play116431128 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 116431128
		arg_549_1.duration_ = 6.67

		local var_549_0 = {
			zh = 6.666,
			ja = 6.1
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
				arg_549_0:Play116431129(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["10025ui_story"].transform
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.var_.moveOldPos10025ui_story = var_552_0.localPosition
			end

			local var_552_2 = 0.001

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2
				local var_552_4 = Vector3.New(0, -1.1, -5.9)

				var_552_0.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos10025ui_story, var_552_4, var_552_3)

				local var_552_5 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_5.x, var_552_5.y, var_552_5.z)

				local var_552_6 = var_552_0.localEulerAngles

				var_552_6.z = 0
				var_552_6.x = 0
				var_552_0.localEulerAngles = var_552_6
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 then
				var_552_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_552_7 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_7.x, var_552_7.y, var_552_7.z)

				local var_552_8 = var_552_0.localEulerAngles

				var_552_8.z = 0
				var_552_8.x = 0
				var_552_0.localEulerAngles = var_552_8
			end

			local var_552_9 = arg_549_1.actors_["10025ui_story"]
			local var_552_10 = 0

			if var_552_10 < arg_549_1.time_ and arg_549_1.time_ <= var_552_10 + arg_552_0 and not isNil(var_552_9) and arg_549_1.var_.characterEffect10025ui_story == nil then
				arg_549_1.var_.characterEffect10025ui_story = var_552_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_11 = 0.2

			if var_552_10 <= arg_549_1.time_ and arg_549_1.time_ < var_552_10 + var_552_11 and not isNil(var_552_9) then
				local var_552_12 = (arg_549_1.time_ - var_552_10) / var_552_11

				if arg_549_1.var_.characterEffect10025ui_story and not isNil(var_552_9) then
					arg_549_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_10 + var_552_11 and arg_549_1.time_ < var_552_10 + var_552_11 + arg_552_0 and not isNil(var_552_9) and arg_549_1.var_.characterEffect10025ui_story then
				arg_549_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_552_13 = 0

			if var_552_13 < arg_549_1.time_ and arg_549_1.time_ <= var_552_13 + arg_552_0 then
				arg_549_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_552_14 = 0

			if var_552_14 < arg_549_1.time_ and arg_549_1.time_ <= var_552_14 + arg_552_0 then
				arg_549_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_552_15 = 0
			local var_552_16 = 0.266666666666667

			if var_552_15 < arg_549_1.time_ and arg_549_1.time_ <= var_552_15 + arg_552_0 then
				local var_552_17 = "play"
				local var_552_18 = "music"

				arg_549_1:AudioAction(var_552_17, var_552_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_552_19 = ""
				local var_552_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_552_20 ~= "" then
					if arg_549_1.bgmTxt_.text ~= var_552_20 and arg_549_1.bgmTxt_.text ~= "" then
						if arg_549_1.bgmTxt2_.text ~= "" then
							arg_549_1.bgmTxt_.text = arg_549_1.bgmTxt2_.text
						end

						arg_549_1.bgmTxt2_.text = var_552_20

						arg_549_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_549_1.bgmTxt_.text = var_552_20
						arg_549_1.bgmTxt2_.text = var_552_20
					end

					if arg_549_1.bgmTimer then
						arg_549_1.bgmTimer:Stop()

						arg_549_1.bgmTimer = nil
					end

					if arg_549_1.settingData.show_music_name == 1 then
						arg_549_1.musicController:SetSelectedState("show")
						arg_549_1.musicAnimator_:Play("open", 0, 0)

						if arg_549_1.settingData.music_time ~= 0 then
							arg_549_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_549_1.settingData.music_time), function()
								if arg_549_1 == nil or isNil(arg_549_1.bgmTxt_) then
									return
								end

								arg_549_1.musicController:SetSelectedState("hide")
								arg_549_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_552_21 = 0.4
			local var_552_22 = 0.6

			if var_552_21 < arg_549_1.time_ and arg_549_1.time_ <= var_552_21 + arg_552_0 then
				local var_552_23 = "play"
				local var_552_24 = "music"

				arg_549_1:AudioAction(var_552_23, var_552_24, "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld.awb")

				local var_552_25 = ""
				local var_552_26 = manager.audio:GetAudioName("bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld")

				if var_552_26 ~= "" then
					if arg_549_1.bgmTxt_.text ~= var_552_26 and arg_549_1.bgmTxt_.text ~= "" then
						if arg_549_1.bgmTxt2_.text ~= "" then
							arg_549_1.bgmTxt_.text = arg_549_1.bgmTxt2_.text
						end

						arg_549_1.bgmTxt2_.text = var_552_26

						arg_549_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_549_1.bgmTxt_.text = var_552_26
						arg_549_1.bgmTxt2_.text = var_552_26
					end

					if arg_549_1.bgmTimer then
						arg_549_1.bgmTimer:Stop()

						arg_549_1.bgmTimer = nil
					end

					if arg_549_1.settingData.show_music_name == 1 then
						arg_549_1.musicController:SetSelectedState("show")
						arg_549_1.musicAnimator_:Play("open", 0, 0)

						if arg_549_1.settingData.music_time ~= 0 then
							arg_549_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_549_1.settingData.music_time), function()
								if arg_549_1 == nil or isNil(arg_549_1.bgmTxt_) then
									return
								end

								arg_549_1.musicController:SetSelectedState("hide")
								arg_549_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_552_27 = 0
			local var_552_28 = 0.35

			if var_552_27 < arg_549_1.time_ and arg_549_1.time_ <= var_552_27 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_29 = arg_549_1:FormatText(StoryNameCfg[36].name)

				arg_549_1.leftNameTxt_.text = var_552_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_30 = arg_549_1:GetWordFromCfg(116431128)
				local var_552_31 = arg_549_1:FormatText(var_552_30.content)

				arg_549_1.text_.text = var_552_31

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_32 = 14
				local var_552_33 = utf8.len(var_552_31)
				local var_552_34 = var_552_32 <= 0 and var_552_28 or var_552_28 * (var_552_33 / var_552_32)

				if var_552_34 > 0 and var_552_28 < var_552_34 then
					arg_549_1.talkMaxDuration = var_552_34

					if var_552_34 + var_552_27 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_34 + var_552_27
					end
				end

				arg_549_1.text_.text = var_552_31
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431128", "story_v_out_116431.awb") ~= 0 then
					local var_552_35 = manager.audio:GetVoiceLength("story_v_out_116431", "116431128", "story_v_out_116431.awb") / 1000

					if var_552_35 + var_552_27 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_35 + var_552_27
					end

					if var_552_30.prefab_name ~= "" and arg_549_1.actors_[var_552_30.prefab_name] ~= nil then
						local var_552_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_30.prefab_name].transform, "story_v_out_116431", "116431128", "story_v_out_116431.awb")

						arg_549_1:RecordAudio("116431128", var_552_36)
						arg_549_1:RecordAudio("116431128", var_552_36)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_116431", "116431128", "story_v_out_116431.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_116431", "116431128", "story_v_out_116431.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_37 = math.max(var_552_28, arg_549_1.talkMaxDuration)

			if var_552_27 <= arg_549_1.time_ and arg_549_1.time_ < var_552_27 + var_552_37 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_27) / var_552_37

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_27 + var_552_37 and arg_549_1.time_ < var_552_27 + var_552_37 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play116431129 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 116431129
		arg_555_1.duration_ = 9.1

		local var_555_0 = {
			zh = 8.966,
			ja = 9.1
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play116431130(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["10025ui_story"].transform
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.var_.moveOldPos10025ui_story = var_558_0.localPosition
			end

			local var_558_2 = 0.001

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2
				local var_558_4 = Vector3.New(0, -1.1, -5.9)

				var_558_0.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10025ui_story, var_558_4, var_558_3)

				local var_558_5 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_5.x, var_558_5.y, var_558_5.z)

				local var_558_6 = var_558_0.localEulerAngles

				var_558_6.z = 0
				var_558_6.x = 0
				var_558_0.localEulerAngles = var_558_6
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 then
				var_558_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_558_7 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_7.x, var_558_7.y, var_558_7.z)

				local var_558_8 = var_558_0.localEulerAngles

				var_558_8.z = 0
				var_558_8.x = 0
				var_558_0.localEulerAngles = var_558_8
			end

			local var_558_9 = 0

			if var_558_9 < arg_555_1.time_ and arg_555_1.time_ <= var_558_9 + arg_558_0 then
				arg_555_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action478")
			end

			local var_558_10 = 0

			if var_558_10 < arg_555_1.time_ and arg_555_1.time_ <= var_558_10 + arg_558_0 then
				arg_555_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_558_11 = 0
			local var_558_12 = 0.55

			if var_558_11 < arg_555_1.time_ and arg_555_1.time_ <= var_558_11 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_13 = arg_555_1:FormatText(StoryNameCfg[36].name)

				arg_555_1.leftNameTxt_.text = var_558_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_14 = arg_555_1:GetWordFromCfg(116431129)
				local var_558_15 = arg_555_1:FormatText(var_558_14.content)

				arg_555_1.text_.text = var_558_15

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_16 = 22
				local var_558_17 = utf8.len(var_558_15)
				local var_558_18 = var_558_16 <= 0 and var_558_12 or var_558_12 * (var_558_17 / var_558_16)

				if var_558_18 > 0 and var_558_12 < var_558_18 then
					arg_555_1.talkMaxDuration = var_558_18

					if var_558_18 + var_558_11 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_18 + var_558_11
					end
				end

				arg_555_1.text_.text = var_558_15
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431129", "story_v_out_116431.awb") ~= 0 then
					local var_558_19 = manager.audio:GetVoiceLength("story_v_out_116431", "116431129", "story_v_out_116431.awb") / 1000

					if var_558_19 + var_558_11 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_19 + var_558_11
					end

					if var_558_14.prefab_name ~= "" and arg_555_1.actors_[var_558_14.prefab_name] ~= nil then
						local var_558_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_14.prefab_name].transform, "story_v_out_116431", "116431129", "story_v_out_116431.awb")

						arg_555_1:RecordAudio("116431129", var_558_20)
						arg_555_1:RecordAudio("116431129", var_558_20)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_116431", "116431129", "story_v_out_116431.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_116431", "116431129", "story_v_out_116431.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_21 = math.max(var_558_12, arg_555_1.talkMaxDuration)

			if var_558_11 <= arg_555_1.time_ and arg_555_1.time_ < var_558_11 + var_558_21 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_11) / var_558_21

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_11 + var_558_21 and arg_555_1.time_ < var_558_11 + var_558_21 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play116431130 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 116431130
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play116431131(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["10025ui_story"].transform
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.var_.moveOldPos10025ui_story = var_562_0.localPosition
			end

			local var_562_2 = 0.001

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2
				local var_562_4 = Vector3.New(0, 100, 0)

				var_562_0.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos10025ui_story, var_562_4, var_562_3)

				local var_562_5 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_5.x, var_562_5.y, var_562_5.z)

				local var_562_6 = var_562_0.localEulerAngles

				var_562_6.z = 0
				var_562_6.x = 0
				var_562_0.localEulerAngles = var_562_6
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 then
				var_562_0.localPosition = Vector3.New(0, 100, 0)

				local var_562_7 = manager.ui.mainCamera.transform.position - var_562_0.position

				var_562_0.forward = Vector3.New(var_562_7.x, var_562_7.y, var_562_7.z)

				local var_562_8 = var_562_0.localEulerAngles

				var_562_8.z = 0
				var_562_8.x = 0
				var_562_0.localEulerAngles = var_562_8
			end

			local var_562_9 = 0
			local var_562_10 = 0.65

			if var_562_9 < arg_559_1.time_ and arg_559_1.time_ <= var_562_9 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_11 = arg_559_1:GetWordFromCfg(116431130)
				local var_562_12 = arg_559_1:FormatText(var_562_11.content)

				arg_559_1.text_.text = var_562_12

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_13 = 26
				local var_562_14 = utf8.len(var_562_12)
				local var_562_15 = var_562_13 <= 0 and var_562_10 or var_562_10 * (var_562_14 / var_562_13)

				if var_562_15 > 0 and var_562_10 < var_562_15 then
					arg_559_1.talkMaxDuration = var_562_15

					if var_562_15 + var_562_9 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_15 + var_562_9
					end
				end

				arg_559_1.text_.text = var_562_12
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_16 = math.max(var_562_10, arg_559_1.talkMaxDuration)

			if var_562_9 <= arg_559_1.time_ and arg_559_1.time_ < var_562_9 + var_562_16 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_9) / var_562_16

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_9 + var_562_16 and arg_559_1.time_ < var_562_9 + var_562_16 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play116431131 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 116431131
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play116431132(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0
			local var_566_1 = 0.85

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, false)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_2 = arg_563_1:GetWordFromCfg(116431131)
				local var_566_3 = arg_563_1:FormatText(var_566_2.content)

				arg_563_1.text_.text = var_566_3

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 34
				local var_566_5 = utf8.len(var_566_3)
				local var_566_6 = var_566_4 <= 0 and var_566_1 or var_566_1 * (var_566_5 / var_566_4)

				if var_566_6 > 0 and var_566_1 < var_566_6 then
					arg_563_1.talkMaxDuration = var_566_6

					if var_566_6 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_3
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_7 and arg_563_1.time_ < var_566_0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play116431132 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 116431132
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play116431133(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = manager.ui.mainCamera.transform
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.var_.shakeOldPos = var_570_0.localPosition
			end

			local var_570_2 = 0.6

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / 0.066
				local var_570_4, var_570_5 = math.modf(var_570_3)

				var_570_0.localPosition = Vector3.New(var_570_5 * 0.13, var_570_5 * 0.13, var_570_5 * 0.13) + arg_567_1.var_.shakeOldPos
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 then
				var_570_0.localPosition = arg_567_1.var_.shakeOldPos
			end

			local var_570_6 = 0

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.allBtn_.enabled = false
			end

			local var_570_7 = 0.6

			if arg_567_1.time_ >= var_570_6 + var_570_7 and arg_567_1.time_ < var_570_6 + var_570_7 + arg_570_0 then
				arg_567_1.allBtn_.enabled = true
			end

			local var_570_8 = 0
			local var_570_9 = 0.575

			if var_570_8 < arg_567_1.time_ and arg_567_1.time_ <= var_570_8 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_10 = arg_567_1:GetWordFromCfg(116431132)
				local var_570_11 = arg_567_1:FormatText(var_570_10.content)

				arg_567_1.text_.text = var_570_11

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_12 = 23
				local var_570_13 = utf8.len(var_570_11)
				local var_570_14 = var_570_12 <= 0 and var_570_9 or var_570_9 * (var_570_13 / var_570_12)

				if var_570_14 > 0 and var_570_9 < var_570_14 then
					arg_567_1.talkMaxDuration = var_570_14

					if var_570_14 + var_570_8 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_14 + var_570_8
					end
				end

				arg_567_1.text_.text = var_570_11
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_15 = math.max(var_570_9, arg_567_1.talkMaxDuration)

			if var_570_8 <= arg_567_1.time_ and arg_567_1.time_ < var_570_8 + var_570_15 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_8) / var_570_15

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_8 + var_570_15 and arg_567_1.time_ < var_570_8 + var_570_15 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play116431133 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 116431133
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play116431134(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.65

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_2 = arg_571_1:GetWordFromCfg(116431133)
				local var_574_3 = arg_571_1:FormatText(var_574_2.content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 26
				local var_574_5 = utf8.len(var_574_3)
				local var_574_6 = var_574_4 <= 0 and var_574_1 or var_574_1 * (var_574_5 / var_574_4)

				if var_574_6 > 0 and var_574_1 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_7 and arg_571_1.time_ < var_574_0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play116431134 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 116431134
		arg_575_1.duration_ = 5.13

		local var_575_0 = {
			zh = 5.133,
			ja = 1.999999999999
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play116431135(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["10025ui_story"].transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPos10025ui_story = var_578_0.localPosition
			end

			local var_578_2 = 0.001

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2
				local var_578_4 = Vector3.New(0, -1.1, -5.9)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos10025ui_story, var_578_4, var_578_3)

				local var_578_5 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_5.x, var_578_5.y, var_578_5.z)

				local var_578_6 = var_578_0.localEulerAngles

				var_578_6.z = 0
				var_578_6.x = 0
				var_578_0.localEulerAngles = var_578_6
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_578_7 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_7.x, var_578_7.y, var_578_7.z)

				local var_578_8 = var_578_0.localEulerAngles

				var_578_8.z = 0
				var_578_8.x = 0
				var_578_0.localEulerAngles = var_578_8
			end

			local var_578_9 = arg_575_1.actors_["10025ui_story"]
			local var_578_10 = 0

			if var_578_10 < arg_575_1.time_ and arg_575_1.time_ <= var_578_10 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect10025ui_story == nil then
				arg_575_1.var_.characterEffect10025ui_story = var_578_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_11 = 0.2

			if var_578_10 <= arg_575_1.time_ and arg_575_1.time_ < var_578_10 + var_578_11 and not isNil(var_578_9) then
				local var_578_12 = (arg_575_1.time_ - var_578_10) / var_578_11

				if arg_575_1.var_.characterEffect10025ui_story and not isNil(var_578_9) then
					arg_575_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= var_578_10 + var_578_11 and arg_575_1.time_ < var_578_10 + var_578_11 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect10025ui_story then
				arg_575_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_578_13 = 0

			if var_578_13 < arg_575_1.time_ and arg_575_1.time_ <= var_578_13 + arg_578_0 then
				arg_575_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action9_2")
			end

			local var_578_14 = 0

			if var_578_14 < arg_575_1.time_ and arg_575_1.time_ <= var_578_14 + arg_578_0 then
				arg_575_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_578_15 = 0
			local var_578_16 = 0.175

			if var_578_15 < arg_575_1.time_ and arg_575_1.time_ <= var_578_15 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_17 = arg_575_1:FormatText(StoryNameCfg[36].name)

				arg_575_1.leftNameTxt_.text = var_578_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_18 = arg_575_1:GetWordFromCfg(116431134)
				local var_578_19 = arg_575_1:FormatText(var_578_18.content)

				arg_575_1.text_.text = var_578_19

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_20 = 7
				local var_578_21 = utf8.len(var_578_19)
				local var_578_22 = var_578_20 <= 0 and var_578_16 or var_578_16 * (var_578_21 / var_578_20)

				if var_578_22 > 0 and var_578_16 < var_578_22 then
					arg_575_1.talkMaxDuration = var_578_22

					if var_578_22 + var_578_15 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_22 + var_578_15
					end
				end

				arg_575_1.text_.text = var_578_19
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431134", "story_v_out_116431.awb") ~= 0 then
					local var_578_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431134", "story_v_out_116431.awb") / 1000

					if var_578_23 + var_578_15 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_23 + var_578_15
					end

					if var_578_18.prefab_name ~= "" and arg_575_1.actors_[var_578_18.prefab_name] ~= nil then
						local var_578_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_18.prefab_name].transform, "story_v_out_116431", "116431134", "story_v_out_116431.awb")

						arg_575_1:RecordAudio("116431134", var_578_24)
						arg_575_1:RecordAudio("116431134", var_578_24)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_116431", "116431134", "story_v_out_116431.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_116431", "116431134", "story_v_out_116431.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_25 = math.max(var_578_16, arg_575_1.talkMaxDuration)

			if var_578_15 <= arg_575_1.time_ and arg_575_1.time_ < var_578_15 + var_578_25 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_15) / var_578_25

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_15 + var_578_25 and arg_575_1.time_ < var_578_15 + var_578_25 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play116431135 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 116431135
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play116431136(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["10025ui_story"].transform
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.var_.moveOldPos10025ui_story = var_582_0.localPosition
			end

			local var_582_2 = 0.001

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2
				local var_582_4 = Vector3.New(0, 100, 0)

				var_582_0.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPos10025ui_story, var_582_4, var_582_3)

				local var_582_5 = manager.ui.mainCamera.transform.position - var_582_0.position

				var_582_0.forward = Vector3.New(var_582_5.x, var_582_5.y, var_582_5.z)

				local var_582_6 = var_582_0.localEulerAngles

				var_582_6.z = 0
				var_582_6.x = 0
				var_582_0.localEulerAngles = var_582_6
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 then
				var_582_0.localPosition = Vector3.New(0, 100, 0)

				local var_582_7 = manager.ui.mainCamera.transform.position - var_582_0.position

				var_582_0.forward = Vector3.New(var_582_7.x, var_582_7.y, var_582_7.z)

				local var_582_8 = var_582_0.localEulerAngles

				var_582_8.z = 0
				var_582_8.x = 0
				var_582_0.localEulerAngles = var_582_8
			end

			local var_582_9 = 0
			local var_582_10 = 1.5

			if var_582_9 < arg_579_1.time_ and arg_579_1.time_ <= var_582_9 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_11 = arg_579_1:GetWordFromCfg(116431135)
				local var_582_12 = arg_579_1:FormatText(var_582_11.content)

				arg_579_1.text_.text = var_582_12

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_13 = 60
				local var_582_14 = utf8.len(var_582_12)
				local var_582_15 = var_582_13 <= 0 and var_582_10 or var_582_10 * (var_582_14 / var_582_13)

				if var_582_15 > 0 and var_582_10 < var_582_15 then
					arg_579_1.talkMaxDuration = var_582_15

					if var_582_15 + var_582_9 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_15 + var_582_9
					end
				end

				arg_579_1.text_.text = var_582_12
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_16 = math.max(var_582_10, arg_579_1.talkMaxDuration)

			if var_582_9 <= arg_579_1.time_ and arg_579_1.time_ < var_582_9 + var_582_16 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_9) / var_582_16

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_9 + var_582_16 and arg_579_1.time_ < var_582_9 + var_582_16 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play116431136 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 116431136
		arg_583_1.duration_ = 13.1

		local var_583_0 = {
			zh = 13.1,
			ja = 8.2
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play116431137(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.675

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[36].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_3 = arg_583_1:GetWordFromCfg(116431136)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 27
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431136", "story_v_out_116431.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431136", "story_v_out_116431.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_out_116431", "116431136", "story_v_out_116431.awb")

						arg_583_1:RecordAudio("116431136", var_586_9)
						arg_583_1:RecordAudio("116431136", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_116431", "116431136", "story_v_out_116431.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_116431", "116431136", "story_v_out_116431.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play116431137 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 116431137
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play116431138(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 0.65

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_2 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_3 = arg_587_1:GetWordFromCfg(116431137)
				local var_590_4 = arg_587_1:FormatText(var_590_3.content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 26
				local var_590_6 = utf8.len(var_590_4)
				local var_590_7 = var_590_5 <= 0 and var_590_1 or var_590_1 * (var_590_6 / var_590_5)

				if var_590_7 > 0 and var_590_1 < var_590_7 then
					arg_587_1.talkMaxDuration = var_590_7

					if var_590_7 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_8 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_8 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_8

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_8 and arg_587_1.time_ < var_590_0 + var_590_8 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play116431138 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 116431138
		arg_591_1.duration_ = 2.7

		local var_591_0 = {
			zh = 2.7,
			ja = 1.6
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play116431139(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.1

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[36].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(116431138)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 4
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431138", "story_v_out_116431.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431138", "story_v_out_116431.awb") / 1000

					if var_594_8 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_0
					end

					if var_594_3.prefab_name ~= "" and arg_591_1.actors_[var_594_3.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_3.prefab_name].transform, "story_v_out_116431", "116431138", "story_v_out_116431.awb")

						arg_591_1:RecordAudio("116431138", var_594_9)
						arg_591_1:RecordAudio("116431138", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_116431", "116431138", "story_v_out_116431.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_116431", "116431138", "story_v_out_116431.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_10 and arg_591_1.time_ < var_594_0 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play116431139 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 116431139
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play116431140(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.6

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[7].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(116431139)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 24
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_8 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_8 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_8

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_8 and arg_595_1.time_ < var_598_0 + var_598_8 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play116431140 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 116431140
		arg_599_1.duration_ = 3.27

		local var_599_0 = {
			zh = 2.7,
			ja = 3.266
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play116431141(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.15

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[36].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:GetWordFromCfg(116431140)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 6
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431140", "story_v_out_116431.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431140", "story_v_out_116431.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_out_116431", "116431140", "story_v_out_116431.awb")

						arg_599_1:RecordAudio("116431140", var_602_9)
						arg_599_1:RecordAudio("116431140", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_116431", "116431140", "story_v_out_116431.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_116431", "116431140", "story_v_out_116431.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play116431141 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 116431141
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play116431142(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 1

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_2 = arg_603_1:GetWordFromCfg(116431141)
				local var_606_3 = arg_603_1:FormatText(var_606_2.content)

				arg_603_1.text_.text = var_606_3

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 40
				local var_606_5 = utf8.len(var_606_3)
				local var_606_6 = var_606_4 <= 0 and var_606_1 or var_606_1 * (var_606_5 / var_606_4)

				if var_606_6 > 0 and var_606_1 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_3
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_7 and arg_603_1.time_ < var_606_0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play116431142 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 116431142
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play116431143(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 1

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				local var_610_2 = "play"
				local var_610_3 = "effect"

				arg_607_1:AudioAction(var_610_2, var_610_3, "se_story_16", "se_story_16_loading", "")
			end

			local var_610_4 = 0
			local var_610_5 = 0.375

			if var_610_4 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_6 = arg_607_1:GetWordFromCfg(116431142)
				local var_610_7 = arg_607_1:FormatText(var_610_6.content)

				arg_607_1.text_.text = var_610_7

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_8 = 15
				local var_610_9 = utf8.len(var_610_7)
				local var_610_10 = var_610_8 <= 0 and var_610_5 or var_610_5 * (var_610_9 / var_610_8)

				if var_610_10 > 0 and var_610_5 < var_610_10 then
					arg_607_1.talkMaxDuration = var_610_10

					if var_610_10 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_10 + var_610_4
					end
				end

				arg_607_1.text_.text = var_610_7
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_11 = math.max(var_610_5, arg_607_1.talkMaxDuration)

			if var_610_4 <= arg_607_1.time_ and arg_607_1.time_ < var_610_4 + var_610_11 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_4) / var_610_11

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_4 + var_610_11 and arg_607_1.time_ < var_610_4 + var_610_11 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play116431143 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 116431143
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play116431144(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 0
			local var_614_1 = 0.95

			if var_614_0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_2 = arg_611_1:FormatText(StoryNameCfg[7].name)

				arg_611_1.leftNameTxt_.text = var_614_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:GetWordFromCfg(116431143)
				local var_614_4 = arg_611_1:FormatText(var_614_3.content)

				arg_611_1.text_.text = var_614_4

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 38
				local var_614_6 = utf8.len(var_614_4)
				local var_614_7 = var_614_5 <= 0 and var_614_1 or var_614_1 * (var_614_6 / var_614_5)

				if var_614_7 > 0 and var_614_1 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_0
					end
				end

				arg_611_1.text_.text = var_614_4
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_8 = math.max(var_614_1, arg_611_1.talkMaxDuration)

			if var_614_0 <= arg_611_1.time_ and arg_611_1.time_ < var_614_0 + var_614_8 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_0) / var_614_8

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_0 + var_614_8 and arg_611_1.time_ < var_614_0 + var_614_8 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play116431144 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 116431144
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play116431145(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 1.3

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_2 = arg_615_1:GetWordFromCfg(116431144)
				local var_618_3 = arg_615_1:FormatText(var_618_2.content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_4 = 52
				local var_618_5 = utf8.len(var_618_3)
				local var_618_6 = var_618_4 <= 0 and var_618_1 or var_618_1 * (var_618_5 / var_618_4)

				if var_618_6 > 0 and var_618_1 < var_618_6 then
					arg_615_1.talkMaxDuration = var_618_6

					if var_618_6 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_6 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_7 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_7 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_7

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_7 and arg_615_1.time_ < var_618_0 + var_618_7 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play116431145 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 116431145
		arg_619_1.duration_ = 3.23

		local var_619_0 = {
			zh = 2.4,
			ja = 3.233
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play116431146(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["10025ui_story"].transform
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.var_.moveOldPos10025ui_story = var_622_0.localPosition
			end

			local var_622_2 = 0.001

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2
				local var_622_4 = Vector3.New(0, -1.1, -5.9)

				var_622_0.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos10025ui_story, var_622_4, var_622_3)

				local var_622_5 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_5.x, var_622_5.y, var_622_5.z)

				local var_622_6 = var_622_0.localEulerAngles

				var_622_6.z = 0
				var_622_6.x = 0
				var_622_0.localEulerAngles = var_622_6
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 then
				var_622_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_622_7 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_7.x, var_622_7.y, var_622_7.z)

				local var_622_8 = var_622_0.localEulerAngles

				var_622_8.z = 0
				var_622_8.x = 0
				var_622_0.localEulerAngles = var_622_8
			end

			local var_622_9 = arg_619_1.actors_["10025ui_story"]
			local var_622_10 = 0

			if var_622_10 < arg_619_1.time_ and arg_619_1.time_ <= var_622_10 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect10025ui_story == nil then
				arg_619_1.var_.characterEffect10025ui_story = var_622_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_11 = 0.2

			if var_622_10 <= arg_619_1.time_ and arg_619_1.time_ < var_622_10 + var_622_11 and not isNil(var_622_9) then
				local var_622_12 = (arg_619_1.time_ - var_622_10) / var_622_11

				if arg_619_1.var_.characterEffect10025ui_story and not isNil(var_622_9) then
					arg_619_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= var_622_10 + var_622_11 and arg_619_1.time_ < var_622_10 + var_622_11 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect10025ui_story then
				arg_619_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_622_13 = 0

			if var_622_13 < arg_619_1.time_ and arg_619_1.time_ <= var_622_13 + arg_622_0 then
				arg_619_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_622_14 = 0

			if var_622_14 < arg_619_1.time_ and arg_619_1.time_ <= var_622_14 + arg_622_0 then
				arg_619_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_622_15 = 0
			local var_622_16 = 0.125

			if var_622_15 < arg_619_1.time_ and arg_619_1.time_ <= var_622_15 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_17 = arg_619_1:FormatText(StoryNameCfg[36].name)

				arg_619_1.leftNameTxt_.text = var_622_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_18 = arg_619_1:GetWordFromCfg(116431145)
				local var_622_19 = arg_619_1:FormatText(var_622_18.content)

				arg_619_1.text_.text = var_622_19

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_20 = 5
				local var_622_21 = utf8.len(var_622_19)
				local var_622_22 = var_622_20 <= 0 and var_622_16 or var_622_16 * (var_622_21 / var_622_20)

				if var_622_22 > 0 and var_622_16 < var_622_22 then
					arg_619_1.talkMaxDuration = var_622_22

					if var_622_22 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_22 + var_622_15
					end
				end

				arg_619_1.text_.text = var_622_19
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431145", "story_v_out_116431.awb") ~= 0 then
					local var_622_23 = manager.audio:GetVoiceLength("story_v_out_116431", "116431145", "story_v_out_116431.awb") / 1000

					if var_622_23 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_23 + var_622_15
					end

					if var_622_18.prefab_name ~= "" and arg_619_1.actors_[var_622_18.prefab_name] ~= nil then
						local var_622_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_18.prefab_name].transform, "story_v_out_116431", "116431145", "story_v_out_116431.awb")

						arg_619_1:RecordAudio("116431145", var_622_24)
						arg_619_1:RecordAudio("116431145", var_622_24)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_out_116431", "116431145", "story_v_out_116431.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_out_116431", "116431145", "story_v_out_116431.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_25 = math.max(var_622_16, arg_619_1.talkMaxDuration)

			if var_622_15 <= arg_619_1.time_ and arg_619_1.time_ < var_622_15 + var_622_25 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_15) / var_622_25

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_15 + var_622_25 and arg_619_1.time_ < var_622_15 + var_622_25 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play116431146 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 116431146
		arg_623_1.duration_ = 8.2

		local var_623_0 = {
			zh = 6,
			ja = 8.2
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play116431147(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["10025ui_story"].transform
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.var_.moveOldPos10025ui_story = var_626_0.localPosition
			end

			local var_626_2 = 0.001

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2
				local var_626_4 = Vector3.New(0, -1.1, -5.9)

				var_626_0.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos10025ui_story, var_626_4, var_626_3)

				local var_626_5 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_5.x, var_626_5.y, var_626_5.z)

				local var_626_6 = var_626_0.localEulerAngles

				var_626_6.z = 0
				var_626_6.x = 0
				var_626_0.localEulerAngles = var_626_6
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 then
				var_626_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_626_7 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_7.x, var_626_7.y, var_626_7.z)

				local var_626_8 = var_626_0.localEulerAngles

				var_626_8.z = 0
				var_626_8.x = 0
				var_626_0.localEulerAngles = var_626_8
			end

			local var_626_9 = 0

			if var_626_9 < arg_623_1.time_ and arg_623_1.time_ <= var_626_9 + arg_626_0 then
				arg_623_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_626_10 = 0

			if var_626_10 < arg_623_1.time_ and arg_623_1.time_ <= var_626_10 + arg_626_0 then
				arg_623_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_626_11 = 0

			if var_626_11 < arg_623_1.time_ and arg_623_1.time_ <= var_626_11 + arg_626_0 then
				arg_623_1.allBtn_.enabled = false
			end

			local var_626_12 = 2

			if arg_623_1.time_ >= var_626_11 + var_626_12 and arg_623_1.time_ < var_626_11 + var_626_12 + arg_626_0 then
				arg_623_1.allBtn_.enabled = true
			end

			local var_626_13 = 0
			local var_626_14 = 0.45

			if var_626_13 < arg_623_1.time_ and arg_623_1.time_ <= var_626_13 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_15 = arg_623_1:FormatText(StoryNameCfg[36].name)

				arg_623_1.leftNameTxt_.text = var_626_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_16 = arg_623_1:GetWordFromCfg(116431146)
				local var_626_17 = arg_623_1:FormatText(var_626_16.content)

				arg_623_1.text_.text = var_626_17

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_18 = 18
				local var_626_19 = utf8.len(var_626_17)
				local var_626_20 = var_626_18 <= 0 and var_626_14 or var_626_14 * (var_626_19 / var_626_18)

				if var_626_20 > 0 and var_626_14 < var_626_20 then
					arg_623_1.talkMaxDuration = var_626_20

					if var_626_20 + var_626_13 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_20 + var_626_13
					end
				end

				arg_623_1.text_.text = var_626_17
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431146", "story_v_out_116431.awb") ~= 0 then
					local var_626_21 = manager.audio:GetVoiceLength("story_v_out_116431", "116431146", "story_v_out_116431.awb") / 1000

					if var_626_21 + var_626_13 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_21 + var_626_13
					end

					if var_626_16.prefab_name ~= "" and arg_623_1.actors_[var_626_16.prefab_name] ~= nil then
						local var_626_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_16.prefab_name].transform, "story_v_out_116431", "116431146", "story_v_out_116431.awb")

						arg_623_1:RecordAudio("116431146", var_626_22)
						arg_623_1:RecordAudio("116431146", var_626_22)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_116431", "116431146", "story_v_out_116431.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_116431", "116431146", "story_v_out_116431.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_23 = math.max(var_626_14, arg_623_1.talkMaxDuration)

			if var_626_13 <= arg_623_1.time_ and arg_623_1.time_ < var_626_13 + var_626_23 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_13) / var_626_23

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_13 + var_626_23 and arg_623_1.time_ < var_626_13 + var_626_23 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play116431147 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 116431147
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play116431148(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["10025ui_story"].transform
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.var_.moveOldPos10025ui_story = var_630_0.localPosition
			end

			local var_630_2 = 0.001

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2
				local var_630_4 = Vector3.New(0, 100, 0)

				var_630_0.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos10025ui_story, var_630_4, var_630_3)

				local var_630_5 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_5.x, var_630_5.y, var_630_5.z)

				local var_630_6 = var_630_0.localEulerAngles

				var_630_6.z = 0
				var_630_6.x = 0
				var_630_0.localEulerAngles = var_630_6
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 then
				var_630_0.localPosition = Vector3.New(0, 100, 0)

				local var_630_7 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_7.x, var_630_7.y, var_630_7.z)

				local var_630_8 = var_630_0.localEulerAngles

				var_630_8.z = 0
				var_630_8.x = 0
				var_630_0.localEulerAngles = var_630_8
			end

			local var_630_9 = 0
			local var_630_10 = 1.175

			if var_630_9 < arg_627_1.time_ and arg_627_1.time_ <= var_630_9 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, false)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_11 = arg_627_1:GetWordFromCfg(116431147)
				local var_630_12 = arg_627_1:FormatText(var_630_11.content)

				arg_627_1.text_.text = var_630_12

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_13 = 47
				local var_630_14 = utf8.len(var_630_12)
				local var_630_15 = var_630_13 <= 0 and var_630_10 or var_630_10 * (var_630_14 / var_630_13)

				if var_630_15 > 0 and var_630_10 < var_630_15 then
					arg_627_1.talkMaxDuration = var_630_15

					if var_630_15 + var_630_9 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_15 + var_630_9
					end
				end

				arg_627_1.text_.text = var_630_12
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_16 = math.max(var_630_10, arg_627_1.talkMaxDuration)

			if var_630_9 <= arg_627_1.time_ and arg_627_1.time_ < var_630_9 + var_630_16 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_9) / var_630_16

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_9 + var_630_16 and arg_627_1.time_ < var_630_9 + var_630_16 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play116431148 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 116431148
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play116431149(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0
			local var_634_1 = 0.05

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_2 = arg_631_1:FormatText(StoryNameCfg[7].name)

				arg_631_1.leftNameTxt_.text = var_634_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:GetWordFromCfg(116431148)
				local var_634_4 = arg_631_1:FormatText(var_634_3.content)

				arg_631_1.text_.text = var_634_4

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 2
				local var_634_6 = utf8.len(var_634_4)
				local var_634_7 = var_634_5 <= 0 and var_634_1 or var_634_1 * (var_634_6 / var_634_5)

				if var_634_7 > 0 and var_634_1 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_4
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_8 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 <= arg_631_1.time_ and arg_631_1.time_ < var_634_0 + var_634_8 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_0) / var_634_8

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_0 + var_634_8 and arg_631_1.time_ < var_634_0 + var_634_8 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play116431149 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 116431149
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play116431150(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 0.1

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_2 = arg_635_1:FormatText(StoryNameCfg[7].name)

				arg_635_1.leftNameTxt_.text = var_638_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_3 = arg_635_1:GetWordFromCfg(116431149)
				local var_638_4 = arg_635_1:FormatText(var_638_3.content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 4
				local var_638_6 = utf8.len(var_638_4)
				local var_638_7 = var_638_5 <= 0 and var_638_1 or var_638_1 * (var_638_6 / var_638_5)

				if var_638_7 > 0 and var_638_1 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_8 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_8 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_8

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_8 and arg_635_1.time_ < var_638_0 + var_638_8 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play116431150 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 116431150
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play116431151(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 0.55

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_2 = arg_639_1:GetWordFromCfg(116431150)
				local var_642_3 = arg_639_1:FormatText(var_642_2.content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_4 = 22
				local var_642_5 = utf8.len(var_642_3)
				local var_642_6 = var_642_4 <= 0 and var_642_1 or var_642_1 * (var_642_5 / var_642_4)

				if var_642_6 > 0 and var_642_1 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_7 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_7 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_7

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_7 and arg_639_1.time_ < var_642_0 + var_642_7 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play116431151 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 116431151
		arg_643_1.duration_ = 8.5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play116431152(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 1.5

			if var_646_0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				local var_646_1 = manager.ui.mainCamera.transform.localPosition
				local var_646_2 = Vector3.New(0, 0, 10) + Vector3.New(var_646_1.x, var_646_1.y, 0)
				local var_646_3 = arg_643_1.bgs_.STblack

				var_646_3.transform.localPosition = var_646_2
				var_646_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_4 = var_646_3:GetComponent("SpriteRenderer")

				if var_646_4 and var_646_4.sprite then
					local var_646_5 = (var_646_3.transform.localPosition - var_646_1).z
					local var_646_6 = manager.ui.mainCameraCom_
					local var_646_7 = 2 * var_646_5 * Mathf.Tan(var_646_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_646_8 = var_646_7 * var_646_6.aspect
					local var_646_9 = var_646_4.sprite.bounds.size.x
					local var_646_10 = var_646_4.sprite.bounds.size.y
					local var_646_11 = var_646_8 / var_646_9
					local var_646_12 = var_646_7 / var_646_10
					local var_646_13 = var_646_12 < var_646_11 and var_646_11 or var_646_12

					var_646_3.transform.localScale = Vector3.New(var_646_13, var_646_13, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "STblack" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_14 = 0

			if var_646_14 < arg_643_1.time_ and arg_643_1.time_ <= var_646_14 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_15 = 1.5

			if var_646_14 <= arg_643_1.time_ and arg_643_1.time_ < var_646_14 + var_646_15 then
				local var_646_16 = (arg_643_1.time_ - var_646_14) / var_646_15
				local var_646_17 = Color.New(0, 0, 0)

				var_646_17.a = Mathf.Lerp(0, 1, var_646_16)
				arg_643_1.mask_.color = var_646_17
			end

			if arg_643_1.time_ >= var_646_14 + var_646_15 and arg_643_1.time_ < var_646_14 + var_646_15 + arg_646_0 then
				local var_646_18 = Color.New(0, 0, 0)

				var_646_18.a = 1
				arg_643_1.mask_.color = var_646_18
			end

			local var_646_19 = 1.5

			if var_646_19 < arg_643_1.time_ and arg_643_1.time_ <= var_646_19 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_20 = 2

			if var_646_19 <= arg_643_1.time_ and arg_643_1.time_ < var_646_19 + var_646_20 then
				local var_646_21 = (arg_643_1.time_ - var_646_19) / var_646_20
				local var_646_22 = Color.New(0, 0, 0)

				var_646_22.a = Mathf.Lerp(1, 0, var_646_21)
				arg_643_1.mask_.color = var_646_22
			end

			if arg_643_1.time_ >= var_646_19 + var_646_20 and arg_643_1.time_ < var_646_19 + var_646_20 + arg_646_0 then
				local var_646_23 = Color.New(0, 0, 0)
				local var_646_24 = 0

				arg_643_1.mask_.enabled = false
				var_646_23.a = var_646_24
				arg_643_1.mask_.color = var_646_23
			end

			local var_646_25 = 3.5
			local var_646_26 = 1

			if var_646_25 < arg_643_1.time_ and arg_643_1.time_ <= var_646_25 + arg_646_0 then
				local var_646_27 = "play"
				local var_646_28 = "effect"

				arg_643_1:AudioAction(var_646_27, var_646_28, "se_story_16", "se_story_16_gun", "")
			end

			local var_646_29 = manager.ui.mainCamera.transform
			local var_646_30 = 3.5

			if var_646_30 < arg_643_1.time_ and arg_643_1.time_ <= var_646_30 + arg_646_0 then
				arg_643_1.var_.shakeOldPos = var_646_29.localPosition
			end

			local var_646_31 = 1

			if var_646_30 <= arg_643_1.time_ and arg_643_1.time_ < var_646_30 + var_646_31 then
				local var_646_32 = (arg_643_1.time_ - var_646_30) / 0.066
				local var_646_33, var_646_34 = math.modf(var_646_32)

				var_646_29.localPosition = Vector3.New(var_646_34 * 0.13, var_646_34 * 0.13, var_646_34 * 0.13) + arg_643_1.var_.shakeOldPos
			end

			if arg_643_1.time_ >= var_646_30 + var_646_31 and arg_643_1.time_ < var_646_30 + var_646_31 + arg_646_0 then
				var_646_29.localPosition = arg_643_1.var_.shakeOldPos
			end

			local var_646_35 = arg_643_1.bgs_.I05e.transform
			local var_646_36 = 0

			if var_646_36 < arg_643_1.time_ and arg_643_1.time_ <= var_646_36 + arg_646_0 then
				local var_646_37 = arg_643_1.var_.effectI05exiayula1

				if var_646_37 then
					Object.Destroy(var_646_37)

					arg_643_1.var_.effectI05exiayula1 = nil
				end
			end

			if arg_643_1.frameCnt_ <= 1 then
				arg_643_1.dialog_:SetActive(false)
			end

			local var_646_38 = 3.5
			local var_646_39 = 0.1

			if var_646_38 < arg_643_1.time_ and arg_643_1.time_ <= var_646_38 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0

				arg_643_1.dialog_:SetActive(true)

				arg_643_1.dialogCg_.alpha = 0

				local var_646_40 = LeanTween.value(arg_643_1.dialog_, 0, 1, 0.3)

				var_646_40:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_643_1.dialogCg_.alpha = arg_647_0
				end))
				var_646_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_643_1.dialog_)
					var_646_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_643_1.duration_ = arg_643_1.duration_ + 0.3

				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_41 = arg_643_1:GetWordFromCfg(116431151)
				local var_646_42 = arg_643_1:FormatText(var_646_41.content)

				arg_643_1.text_.text = var_646_42

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_43 = 4
				local var_646_44 = utf8.len(var_646_42)
				local var_646_45 = var_646_43 <= 0 and var_646_39 or var_646_39 * (var_646_44 / var_646_43)

				if var_646_45 > 0 and var_646_39 < var_646_45 then
					arg_643_1.talkMaxDuration = var_646_45
					var_646_38 = var_646_38 + 0.3

					if var_646_45 + var_646_38 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_45 + var_646_38
					end
				end

				arg_643_1.text_.text = var_646_42
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_46 = var_646_38 + 0.3
			local var_646_47 = math.max(var_646_39, arg_643_1.talkMaxDuration)

			if var_646_46 <= arg_643_1.time_ and arg_643_1.time_ < var_646_46 + var_646_47 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_46) / var_646_47

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_46 + var_646_47 and arg_643_1.time_ < var_646_46 + var_646_47 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play116431152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 116431152
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play116431153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.3

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				local var_652_2 = "play"
				local var_652_3 = "effect"

				arg_649_1:AudioAction(var_652_2, var_652_3, "se_story_16", "se_story_16_gun", "")
			end

			local var_652_4 = 0.233333333333333
			local var_652_5 = 0.433333333333333

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				local var_652_6 = "play"
				local var_652_7 = "effect"

				arg_649_1:AudioAction(var_652_6, var_652_7, "se_story_16", "se_story_16_gun", "")
			end

			local var_652_8 = 0.533333333333333
			local var_652_9 = 0.466666666666667

			if var_652_8 < arg_649_1.time_ and arg_649_1.time_ <= var_652_8 + arg_652_0 then
				local var_652_10 = "play"
				local var_652_11 = "effect"

				arg_649_1:AudioAction(var_652_10, var_652_11, "se_story_16", "se_story_16_gun", "")
			end

			local var_652_12 = manager.ui.mainCamera.transform
			local var_652_13 = 0

			if var_652_13 < arg_649_1.time_ and arg_649_1.time_ <= var_652_13 + arg_652_0 then
				arg_649_1.var_.shakeOldPos = var_652_12.localPosition
			end

			local var_652_14 = 0.3

			if var_652_13 <= arg_649_1.time_ and arg_649_1.time_ < var_652_13 + var_652_14 then
				local var_652_15 = (arg_649_1.time_ - var_652_13) / 0.066
				local var_652_16, var_652_17 = math.modf(var_652_15)

				var_652_12.localPosition = Vector3.New(var_652_17 * 0.13, var_652_17 * 0.13, var_652_17 * 0.13) + arg_649_1.var_.shakeOldPos
			end

			if arg_649_1.time_ >= var_652_13 + var_652_14 and arg_649_1.time_ < var_652_13 + var_652_14 + arg_652_0 then
				var_652_12.localPosition = arg_649_1.var_.shakeOldPos
			end

			local var_652_18 = manager.ui.mainCamera.transform
			local var_652_19 = 0.233333333333333

			if var_652_19 < arg_649_1.time_ and arg_649_1.time_ <= var_652_19 + arg_652_0 then
				arg_649_1.var_.shakeOldPos = var_652_18.localPosition
			end

			local var_652_20 = 0.433333333333333

			if var_652_19 <= arg_649_1.time_ and arg_649_1.time_ < var_652_19 + var_652_20 then
				local var_652_21 = (arg_649_1.time_ - var_652_19) / 0.066
				local var_652_22, var_652_23 = math.modf(var_652_21)

				var_652_18.localPosition = Vector3.New(var_652_23 * 0.13, var_652_23 * 0.13, var_652_23 * 0.13) + arg_649_1.var_.shakeOldPos
			end

			if arg_649_1.time_ >= var_652_19 + var_652_20 and arg_649_1.time_ < var_652_19 + var_652_20 + arg_652_0 then
				var_652_18.localPosition = arg_649_1.var_.shakeOldPos
			end

			local var_652_24 = manager.ui.mainCamera.transform
			local var_652_25 = 0.533333333333333

			if var_652_25 < arg_649_1.time_ and arg_649_1.time_ <= var_652_25 + arg_652_0 then
				arg_649_1.var_.shakeOldPos = var_652_24.localPosition
			end

			local var_652_26 = 0.433333333333333

			if var_652_25 <= arg_649_1.time_ and arg_649_1.time_ < var_652_25 + var_652_26 then
				local var_652_27 = (arg_649_1.time_ - var_652_25) / 0.066
				local var_652_28, var_652_29 = math.modf(var_652_27)

				var_652_24.localPosition = Vector3.New(var_652_29 * 0.13, var_652_29 * 0.13, var_652_29 * 0.13) + arg_649_1.var_.shakeOldPos
			end

			if arg_649_1.time_ >= var_652_25 + var_652_26 and arg_649_1.time_ < var_652_25 + var_652_26 + arg_652_0 then
				var_652_24.localPosition = arg_649_1.var_.shakeOldPos
			end

			local var_652_30 = 0
			local var_652_31 = 0.266666666666667

			if var_652_30 < arg_649_1.time_ and arg_649_1.time_ <= var_652_30 + arg_652_0 then
				local var_652_32 = "play"
				local var_652_33 = "music"

				arg_649_1:AudioAction(var_652_32, var_652_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_652_34 = ""
				local var_652_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_652_35 ~= "" then
					if arg_649_1.bgmTxt_.text ~= var_652_35 and arg_649_1.bgmTxt_.text ~= "" then
						if arg_649_1.bgmTxt2_.text ~= "" then
							arg_649_1.bgmTxt_.text = arg_649_1.bgmTxt2_.text
						end

						arg_649_1.bgmTxt2_.text = var_652_35

						arg_649_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_649_1.bgmTxt_.text = var_652_35
						arg_649_1.bgmTxt2_.text = var_652_35
					end

					if arg_649_1.bgmTimer then
						arg_649_1.bgmTimer:Stop()

						arg_649_1.bgmTimer = nil
					end

					if arg_649_1.settingData.show_music_name == 1 then
						arg_649_1.musicController:SetSelectedState("show")
						arg_649_1.musicAnimator_:Play("open", 0, 0)

						if arg_649_1.settingData.music_time ~= 0 then
							arg_649_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_649_1.settingData.music_time), function()
								if arg_649_1 == nil or isNil(arg_649_1.bgmTxt_) then
									return
								end

								arg_649_1.musicController:SetSelectedState("hide")
								arg_649_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_652_36 = 0.4
			local var_652_37 = 0.6

			if var_652_36 < arg_649_1.time_ and arg_649_1.time_ <= var_652_36 + arg_652_0 then
				local var_652_38 = "play"
				local var_652_39 = "music"

				arg_649_1:AudioAction(var_652_38, var_652_39, "bgm_activity_1_6_ui", "bgm_activity_1_6_ui", "bgm_activity_1_6_ui.awb")

				local var_652_40 = ""
				local var_652_41 = manager.audio:GetAudioName("bgm_activity_1_6_ui", "bgm_activity_1_6_ui")

				if var_652_41 ~= "" then
					if arg_649_1.bgmTxt_.text ~= var_652_41 and arg_649_1.bgmTxt_.text ~= "" then
						if arg_649_1.bgmTxt2_.text ~= "" then
							arg_649_1.bgmTxt_.text = arg_649_1.bgmTxt2_.text
						end

						arg_649_1.bgmTxt2_.text = var_652_41

						arg_649_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_649_1.bgmTxt_.text = var_652_41
						arg_649_1.bgmTxt2_.text = var_652_41
					end

					if arg_649_1.bgmTimer then
						arg_649_1.bgmTimer:Stop()

						arg_649_1.bgmTimer = nil
					end

					if arg_649_1.settingData.show_music_name == 1 then
						arg_649_1.musicController:SetSelectedState("show")
						arg_649_1.musicAnimator_:Play("open", 0, 0)

						if arg_649_1.settingData.music_time ~= 0 then
							arg_649_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_649_1.settingData.music_time), function()
								if arg_649_1 == nil or isNil(arg_649_1.bgmTxt_) then
									return
								end

								arg_649_1.musicController:SetSelectedState("hide")
								arg_649_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_652_42 = 0
			local var_652_43 = 0.3

			if var_652_42 < arg_649_1.time_ and arg_649_1.time_ <= var_652_42 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_44 = arg_649_1:GetWordFromCfg(116431152)
				local var_652_45 = arg_649_1:FormatText(var_652_44.content)

				arg_649_1.text_.text = var_652_45

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_46 = 12
				local var_652_47 = utf8.len(var_652_45)
				local var_652_48 = var_652_46 <= 0 and var_652_43 or var_652_43 * (var_652_47 / var_652_46)

				if var_652_48 > 0 and var_652_43 < var_652_48 then
					arg_649_1.talkMaxDuration = var_652_48

					if var_652_48 + var_652_42 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_48 + var_652_42
					end
				end

				arg_649_1.text_.text = var_652_45
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_49 = math.max(var_652_43, arg_649_1.talkMaxDuration)

			if var_652_42 <= arg_649_1.time_ and arg_649_1.time_ < var_652_42 + var_652_49 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_42) / var_652_49

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_42 + var_652_49 and arg_649_1.time_ < var_652_42 + var_652_49 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play116431153 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 116431153
		arg_655_1.duration_ = 10

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play116431154(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = "SK0208"

			if arg_655_1.bgs_[var_658_0] == nil then
				local var_658_1 = Object.Instantiate(arg_655_1.paintGo_)

				var_658_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_658_0)
				var_658_1.name = var_658_0
				var_658_1.transform.parent = arg_655_1.stage_.transform
				var_658_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_655_1.bgs_[var_658_0] = var_658_1
			end

			local var_658_2 = 2

			if var_658_2 < arg_655_1.time_ and arg_655_1.time_ <= var_658_2 + arg_658_0 then
				local var_658_3 = manager.ui.mainCamera.transform.localPosition
				local var_658_4 = Vector3.New(0, 0, 10) + Vector3.New(var_658_3.x, var_658_3.y, 0)
				local var_658_5 = arg_655_1.bgs_.SK0208

				var_658_5.transform.localPosition = var_658_4
				var_658_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_658_6 = var_658_5:GetComponent("SpriteRenderer")

				if var_658_6 and var_658_6.sprite then
					local var_658_7 = (var_658_5.transform.localPosition - var_658_3).z
					local var_658_8 = manager.ui.mainCameraCom_
					local var_658_9 = 2 * var_658_7 * Mathf.Tan(var_658_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_658_10 = var_658_9 * var_658_8.aspect
					local var_658_11 = var_658_6.sprite.bounds.size.x
					local var_658_12 = var_658_6.sprite.bounds.size.y
					local var_658_13 = var_658_10 / var_658_11
					local var_658_14 = var_658_9 / var_658_12
					local var_658_15 = var_658_14 < var_658_13 and var_658_13 or var_658_14

					var_658_5.transform.localScale = Vector3.New(var_658_15, var_658_15, 0)
				end

				for iter_658_0, iter_658_1 in pairs(arg_655_1.bgs_) do
					if iter_658_0 ~= "SK0208" then
						iter_658_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_658_16 = 0

			if var_658_16 < arg_655_1.time_ and arg_655_1.time_ <= var_658_16 + arg_658_0 then
				arg_655_1.mask_.enabled = true
				arg_655_1.mask_.raycastTarget = true

				arg_655_1:SetGaussion(false)
			end

			local var_658_17 = 2

			if var_658_16 <= arg_655_1.time_ and arg_655_1.time_ < var_658_16 + var_658_17 then
				local var_658_18 = (arg_655_1.time_ - var_658_16) / var_658_17
				local var_658_19 = Color.New(0, 0, 0)

				var_658_19.a = Mathf.Lerp(0, 1, var_658_18)
				arg_655_1.mask_.color = var_658_19
			end

			if arg_655_1.time_ >= var_658_16 + var_658_17 and arg_655_1.time_ < var_658_16 + var_658_17 + arg_658_0 then
				local var_658_20 = Color.New(0, 0, 0)

				var_658_20.a = 1
				arg_655_1.mask_.color = var_658_20
			end

			local var_658_21 = 2

			if var_658_21 < arg_655_1.time_ and arg_655_1.time_ <= var_658_21 + arg_658_0 then
				arg_655_1.mask_.enabled = true
				arg_655_1.mask_.raycastTarget = true

				arg_655_1:SetGaussion(false)
			end

			local var_658_22 = 2

			if var_658_21 <= arg_655_1.time_ and arg_655_1.time_ < var_658_21 + var_658_22 then
				local var_658_23 = (arg_655_1.time_ - var_658_21) / var_658_22
				local var_658_24 = Color.New(0, 0, 0)

				var_658_24.a = Mathf.Lerp(1, 0, var_658_23)
				arg_655_1.mask_.color = var_658_24
			end

			if arg_655_1.time_ >= var_658_21 + var_658_22 and arg_655_1.time_ < var_658_21 + var_658_22 + arg_658_0 then
				local var_658_25 = Color.New(0, 0, 0)
				local var_658_26 = 0

				arg_655_1.mask_.enabled = false
				var_658_25.a = var_658_26
				arg_655_1.mask_.color = var_658_25
			end

			local var_658_27 = 0
			local var_658_28 = 1

			if var_658_27 < arg_655_1.time_ and arg_655_1.time_ <= var_658_27 + arg_658_0 then
				local var_658_29 = "stop"
				local var_658_30 = "music"

				arg_655_1:AudioAction(var_658_29, var_658_30, "se_story_16", "se_story_16_rain02_loop", "")

				local var_658_31 = ""
				local var_658_32 = manager.audio:GetAudioName("se_story_16", "se_story_16_rain02_loop")

				if var_658_32 ~= "" then
					if arg_655_1.bgmTxt_.text ~= var_658_32 and arg_655_1.bgmTxt_.text ~= "" then
						if arg_655_1.bgmTxt2_.text ~= "" then
							arg_655_1.bgmTxt_.text = arg_655_1.bgmTxt2_.text
						end

						arg_655_1.bgmTxt2_.text = var_658_32

						arg_655_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_655_1.bgmTxt_.text = var_658_32
						arg_655_1.bgmTxt2_.text = var_658_32
					end

					if arg_655_1.bgmTimer then
						arg_655_1.bgmTimer:Stop()

						arg_655_1.bgmTimer = nil
					end

					if arg_655_1.settingData.show_music_name == 1 then
						arg_655_1.musicController:SetSelectedState("show")
						arg_655_1.musicAnimator_:Play("open", 0, 0)

						if arg_655_1.settingData.music_time ~= 0 then
							arg_655_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_655_1.settingData.music_time), function()
								if arg_655_1 == nil or isNil(arg_655_1.bgmTxt_) then
									return
								end

								arg_655_1.musicController:SetSelectedState("hide")
								arg_655_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_658_33 = 0
			local var_658_34 = 1

			if var_658_33 < arg_655_1.time_ and arg_655_1.time_ <= var_658_33 + arg_658_0 then
				local var_658_35 = "play"
				local var_658_36 = "effect"

				arg_655_1:AudioAction(var_658_35, var_658_36, "se_story_16", "se_story_16_rain01_loop", "")
			end

			local var_658_37 = 0

			if var_658_37 < arg_655_1.time_ and arg_655_1.time_ <= var_658_37 + arg_658_0 then
				arg_655_1.allBtn_.enabled = false
			end

			local var_658_38 = 5.05

			if arg_655_1.time_ >= var_658_37 + var_658_38 and arg_655_1.time_ < var_658_37 + var_658_38 + arg_658_0 then
				arg_655_1.allBtn_.enabled = true
			end

			if arg_655_1.frameCnt_ <= 1 then
				arg_655_1.dialog_:SetActive(false)
			end

			local var_658_39 = 5
			local var_658_40 = 0.05

			if var_658_39 < arg_655_1.time_ and arg_655_1.time_ <= var_658_39 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0

				arg_655_1.dialog_:SetActive(true)

				arg_655_1.dialogCg_.alpha = 0

				local var_658_41 = LeanTween.value(arg_655_1.dialog_, 0, 1, 0.3)

				var_658_41:setOnUpdate(LuaHelper.FloatAction(function(arg_660_0)
					arg_655_1.dialogCg_.alpha = arg_660_0
				end))
				var_658_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_655_1.dialog_)
					var_658_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_655_1.duration_ = arg_655_1.duration_ + 0.3

				SetActive(arg_655_1.leftNameGo_, false)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_42 = arg_655_1:GetWordFromCfg(116431153)
				local var_658_43 = arg_655_1:FormatText(var_658_42.content)

				arg_655_1.text_.text = var_658_43

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_44 = 2
				local var_658_45 = utf8.len(var_658_43)
				local var_658_46 = var_658_44 <= 0 and var_658_40 or var_658_40 * (var_658_45 / var_658_44)

				if var_658_46 > 0 and var_658_40 < var_658_46 then
					arg_655_1.talkMaxDuration = var_658_46
					var_658_39 = var_658_39 + 0.3

					if var_658_46 + var_658_39 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_46 + var_658_39
					end
				end

				arg_655_1.text_.text = var_658_43
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_47 = var_658_39 + 0.3
			local var_658_48 = math.max(var_658_40, arg_655_1.talkMaxDuration)

			if var_658_47 <= arg_655_1.time_ and arg_655_1.time_ < var_658_47 + var_658_48 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_47) / var_658_48

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_47 + var_658_48 and arg_655_1.time_ < var_658_47 + var_658_48 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play116431154 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 116431154
		arg_662_1.duration_ = 7.9

		local var_662_0 = {
			zh = 5.033,
			ja = 7.9
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play116431155(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = 0
			local var_665_1 = 0.625

			if var_665_0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_0 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				local var_665_2 = arg_662_1:FormatText(StoryNameCfg[349].name)

				arg_662_1.leftNameTxt_.text = var_665_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, true)
				arg_662_1.iconController_:SetSelectedState("hero")

				arg_662_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_662_1.callingController_:SetSelectedState("normal")

				arg_662_1.keyicon_.color = Color.New(1, 1, 1)
				arg_662_1.icon_.color = Color.New(1, 1, 1)

				local var_665_3 = arg_662_1:GetWordFromCfg(116431154)
				local var_665_4 = arg_662_1:FormatText(var_665_3.content)

				arg_662_1.text_.text = var_665_4

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_5 = 25
				local var_665_6 = utf8.len(var_665_4)
				local var_665_7 = var_665_5 <= 0 and var_665_1 or var_665_1 * (var_665_6 / var_665_5)

				if var_665_7 > 0 and var_665_1 < var_665_7 then
					arg_662_1.talkMaxDuration = var_665_7

					if var_665_7 + var_665_0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_7 + var_665_0
					end
				end

				arg_662_1.text_.text = var_665_4
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431154", "story_v_out_116431.awb") ~= 0 then
					local var_665_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431154", "story_v_out_116431.awb") / 1000

					if var_665_8 + var_665_0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_8 + var_665_0
					end

					if var_665_3.prefab_name ~= "" and arg_662_1.actors_[var_665_3.prefab_name] ~= nil then
						local var_665_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_3.prefab_name].transform, "story_v_out_116431", "116431154", "story_v_out_116431.awb")

						arg_662_1:RecordAudio("116431154", var_665_9)
						arg_662_1:RecordAudio("116431154", var_665_9)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_116431", "116431154", "story_v_out_116431.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_116431", "116431154", "story_v_out_116431.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_10 = math.max(var_665_1, arg_662_1.talkMaxDuration)

			if var_665_0 <= arg_662_1.time_ and arg_662_1.time_ < var_665_0 + var_665_10 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_0) / var_665_10

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_0 + var_665_10 and arg_662_1.time_ < var_665_0 + var_665_10 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play116431155 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 116431155
		arg_666_1.duration_ = 5.8

		local var_666_0 = {
			zh = 5.8,
			ja = 4.833
		}
		local var_666_1 = manager.audio:GetLocalizationFlag()

		if var_666_0[var_666_1] ~= nil then
			arg_666_1.duration_ = var_666_0[var_666_1]
		end

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play116431156(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 0
			local var_669_1 = 0.8

			if var_669_0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				local var_669_2 = arg_666_1:FormatText(StoryNameCfg[349].name)

				arg_666_1.leftNameTxt_.text = var_669_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, true)
				arg_666_1.iconController_:SetSelectedState("hero")

				arg_666_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_666_1.callingController_:SetSelectedState("normal")

				arg_666_1.keyicon_.color = Color.New(1, 1, 1)
				arg_666_1.icon_.color = Color.New(1, 1, 1)

				local var_669_3 = arg_666_1:GetWordFromCfg(116431155)
				local var_669_4 = arg_666_1:FormatText(var_669_3.content)

				arg_666_1.text_.text = var_669_4

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_5 = 32
				local var_669_6 = utf8.len(var_669_4)
				local var_669_7 = var_669_5 <= 0 and var_669_1 or var_669_1 * (var_669_6 / var_669_5)

				if var_669_7 > 0 and var_669_1 < var_669_7 then
					arg_666_1.talkMaxDuration = var_669_7

					if var_669_7 + var_669_0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_7 + var_669_0
					end
				end

				arg_666_1.text_.text = var_669_4
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431155", "story_v_out_116431.awb") ~= 0 then
					local var_669_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431155", "story_v_out_116431.awb") / 1000

					if var_669_8 + var_669_0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_8 + var_669_0
					end

					if var_669_3.prefab_name ~= "" and arg_666_1.actors_[var_669_3.prefab_name] ~= nil then
						local var_669_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_3.prefab_name].transform, "story_v_out_116431", "116431155", "story_v_out_116431.awb")

						arg_666_1:RecordAudio("116431155", var_669_9)
						arg_666_1:RecordAudio("116431155", var_669_9)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_out_116431", "116431155", "story_v_out_116431.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_out_116431", "116431155", "story_v_out_116431.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_10 = math.max(var_669_1, arg_666_1.talkMaxDuration)

			if var_669_0 <= arg_666_1.time_ and arg_666_1.time_ < var_669_0 + var_669_10 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_0) / var_669_10

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_0 + var_669_10 and arg_666_1.time_ < var_669_0 + var_669_10 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play116431156 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 116431156
		arg_670_1.duration_ = 8.87

		local var_670_0 = {
			zh = 8.866,
			ja = 3.266
		}
		local var_670_1 = manager.audio:GetLocalizationFlag()

		if var_670_0[var_670_1] ~= nil then
			arg_670_1.duration_ = var_670_0[var_670_1]
		end

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play116431157(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = 0
			local var_673_1 = 1.075

			if var_673_0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_0 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				local var_673_2 = arg_670_1:FormatText(StoryNameCfg[264].name)

				arg_670_1.leftNameTxt_.text = var_673_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, true)
				arg_670_1.iconController_:SetSelectedState("hero")

				arg_670_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_670_1.callingController_:SetSelectedState("normal")

				arg_670_1.keyicon_.color = Color.New(1, 1, 1)
				arg_670_1.icon_.color = Color.New(1, 1, 1)

				local var_673_3 = arg_670_1:GetWordFromCfg(116431156)
				local var_673_4 = arg_670_1:FormatText(var_673_3.content)

				arg_670_1.text_.text = var_673_4

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_5 = 43
				local var_673_6 = utf8.len(var_673_4)
				local var_673_7 = var_673_5 <= 0 and var_673_1 or var_673_1 * (var_673_6 / var_673_5)

				if var_673_7 > 0 and var_673_1 < var_673_7 then
					arg_670_1.talkMaxDuration = var_673_7

					if var_673_7 + var_673_0 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_7 + var_673_0
					end
				end

				arg_670_1.text_.text = var_673_4
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431156", "story_v_out_116431.awb") ~= 0 then
					local var_673_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431156", "story_v_out_116431.awb") / 1000

					if var_673_8 + var_673_0 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_8 + var_673_0
					end

					if var_673_3.prefab_name ~= "" and arg_670_1.actors_[var_673_3.prefab_name] ~= nil then
						local var_673_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_670_1.actors_[var_673_3.prefab_name].transform, "story_v_out_116431", "116431156", "story_v_out_116431.awb")

						arg_670_1:RecordAudio("116431156", var_673_9)
						arg_670_1:RecordAudio("116431156", var_673_9)
					else
						arg_670_1:AudioAction("play", "voice", "story_v_out_116431", "116431156", "story_v_out_116431.awb")
					end

					arg_670_1:RecordHistoryTalkVoice("story_v_out_116431", "116431156", "story_v_out_116431.awb")
				end

				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_10 = math.max(var_673_1, arg_670_1.talkMaxDuration)

			if var_673_0 <= arg_670_1.time_ and arg_670_1.time_ < var_673_0 + var_673_10 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_0) / var_673_10

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_0 + var_673_10 and arg_670_1.time_ < var_673_0 + var_673_10 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play116431157 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 116431157
		arg_674_1.duration_ = 4.23

		local var_674_0 = {
			zh = 3.7,
			ja = 4.233
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play116431158(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 0
			local var_677_1 = 0.425

			if var_677_0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				local var_677_2 = arg_674_1:FormatText(StoryNameCfg[264].name)

				arg_674_1.leftNameTxt_.text = var_677_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, true)
				arg_674_1.iconController_:SetSelectedState("hero")

				arg_674_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_674_1.callingController_:SetSelectedState("normal")

				arg_674_1.keyicon_.color = Color.New(1, 1, 1)
				arg_674_1.icon_.color = Color.New(1, 1, 1)

				local var_677_3 = arg_674_1:GetWordFromCfg(116431157)
				local var_677_4 = arg_674_1:FormatText(var_677_3.content)

				arg_674_1.text_.text = var_677_4

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_5 = 17
				local var_677_6 = utf8.len(var_677_4)
				local var_677_7 = var_677_5 <= 0 and var_677_1 or var_677_1 * (var_677_6 / var_677_5)

				if var_677_7 > 0 and var_677_1 < var_677_7 then
					arg_674_1.talkMaxDuration = var_677_7

					if var_677_7 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_7 + var_677_0
					end
				end

				arg_674_1.text_.text = var_677_4
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431157", "story_v_out_116431.awb") ~= 0 then
					local var_677_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431157", "story_v_out_116431.awb") / 1000

					if var_677_8 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_8 + var_677_0
					end

					if var_677_3.prefab_name ~= "" and arg_674_1.actors_[var_677_3.prefab_name] ~= nil then
						local var_677_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_3.prefab_name].transform, "story_v_out_116431", "116431157", "story_v_out_116431.awb")

						arg_674_1:RecordAudio("116431157", var_677_9)
						arg_674_1:RecordAudio("116431157", var_677_9)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_out_116431", "116431157", "story_v_out_116431.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_out_116431", "116431157", "story_v_out_116431.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_10 = math.max(var_677_1, arg_674_1.talkMaxDuration)

			if var_677_0 <= arg_674_1.time_ and arg_674_1.time_ < var_677_0 + var_677_10 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_0) / var_677_10

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_0 + var_677_10 and arg_674_1.time_ < var_677_0 + var_677_10 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play116431158 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 116431158
		arg_678_1.duration_ = 3.4

		local var_678_0 = {
			zh = 1.466,
			ja = 3.4
		}
		local var_678_1 = manager.audio:GetLocalizationFlag()

		if var_678_0[var_678_1] ~= nil then
			arg_678_1.duration_ = var_678_0[var_678_1]
		end

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play116431159(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0
			local var_681_1 = 0.15

			if var_681_0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				local var_681_2 = arg_678_1:FormatText(StoryNameCfg[319].name)

				arg_678_1.leftNameTxt_.text = var_681_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_3 = arg_678_1:GetWordFromCfg(116431158)
				local var_681_4 = arg_678_1:FormatText(var_681_3.content)

				arg_678_1.text_.text = var_681_4

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_5 = 6
				local var_681_6 = utf8.len(var_681_4)
				local var_681_7 = var_681_5 <= 0 and var_681_1 or var_681_1 * (var_681_6 / var_681_5)

				if var_681_7 > 0 and var_681_1 < var_681_7 then
					arg_678_1.talkMaxDuration = var_681_7

					if var_681_7 + var_681_0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_7 + var_681_0
					end
				end

				arg_678_1.text_.text = var_681_4
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431158", "story_v_out_116431.awb") ~= 0 then
					local var_681_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431158", "story_v_out_116431.awb") / 1000

					if var_681_8 + var_681_0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_8 + var_681_0
					end

					if var_681_3.prefab_name ~= "" and arg_678_1.actors_[var_681_3.prefab_name] ~= nil then
						local var_681_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_678_1.actors_[var_681_3.prefab_name].transform, "story_v_out_116431", "116431158", "story_v_out_116431.awb")

						arg_678_1:RecordAudio("116431158", var_681_9)
						arg_678_1:RecordAudio("116431158", var_681_9)
					else
						arg_678_1:AudioAction("play", "voice", "story_v_out_116431", "116431158", "story_v_out_116431.awb")
					end

					arg_678_1:RecordHistoryTalkVoice("story_v_out_116431", "116431158", "story_v_out_116431.awb")
				end

				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_10 = math.max(var_681_1, arg_678_1.talkMaxDuration)

			if var_681_0 <= arg_678_1.time_ and arg_678_1.time_ < var_681_0 + var_681_10 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_0) / var_681_10

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_0 + var_681_10 and arg_678_1.time_ < var_681_0 + var_681_10 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play116431159 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 116431159
		arg_682_1.duration_ = 2.43

		local var_682_0 = {
			zh = 2.433,
			ja = 1.133
		}
		local var_682_1 = manager.audio:GetLocalizationFlag()

		if var_682_0[var_682_1] ~= nil then
			arg_682_1.duration_ = var_682_0[var_682_1]
		end

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play116431160(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			local var_685_0 = 0
			local var_685_1 = 0.2

			if var_685_0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_0 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				local var_685_2 = arg_682_1:FormatText(StoryNameCfg[264].name)

				arg_682_1.leftNameTxt_.text = var_685_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, true)
				arg_682_1.iconController_:SetSelectedState("hero")

				arg_682_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_682_1.callingController_:SetSelectedState("normal")

				arg_682_1.keyicon_.color = Color.New(1, 1, 1)
				arg_682_1.icon_.color = Color.New(1, 1, 1)

				local var_685_3 = arg_682_1:GetWordFromCfg(116431159)
				local var_685_4 = arg_682_1:FormatText(var_685_3.content)

				arg_682_1.text_.text = var_685_4

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_5 = 8
				local var_685_6 = utf8.len(var_685_4)
				local var_685_7 = var_685_5 <= 0 and var_685_1 or var_685_1 * (var_685_6 / var_685_5)

				if var_685_7 > 0 and var_685_1 < var_685_7 then
					arg_682_1.talkMaxDuration = var_685_7

					if var_685_7 + var_685_0 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_7 + var_685_0
					end
				end

				arg_682_1.text_.text = var_685_4
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431159", "story_v_out_116431.awb") ~= 0 then
					local var_685_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431159", "story_v_out_116431.awb") / 1000

					if var_685_8 + var_685_0 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_8 + var_685_0
					end

					if var_685_3.prefab_name ~= "" and arg_682_1.actors_[var_685_3.prefab_name] ~= nil then
						local var_685_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_3.prefab_name].transform, "story_v_out_116431", "116431159", "story_v_out_116431.awb")

						arg_682_1:RecordAudio("116431159", var_685_9)
						arg_682_1:RecordAudio("116431159", var_685_9)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_out_116431", "116431159", "story_v_out_116431.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_out_116431", "116431159", "story_v_out_116431.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_10 = math.max(var_685_1, arg_682_1.talkMaxDuration)

			if var_685_0 <= arg_682_1.time_ and arg_682_1.time_ < var_685_0 + var_685_10 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_0) / var_685_10

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_0 + var_685_10 and arg_682_1.time_ < var_685_0 + var_685_10 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play116431160 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 116431160
		arg_686_1.duration_ = 4.23

		local var_686_0 = {
			zh = 3.333,
			ja = 4.233
		}
		local var_686_1 = manager.audio:GetLocalizationFlag()

		if var_686_0[var_686_1] ~= nil then
			arg_686_1.duration_ = var_686_0[var_686_1]
		end

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play116431161(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			local var_689_0 = 0
			local var_689_1 = 0.45

			if var_689_0 < arg_686_1.time_ and arg_686_1.time_ <= var_689_0 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				local var_689_2 = arg_686_1:FormatText(StoryNameCfg[319].name)

				arg_686_1.leftNameTxt_.text = var_689_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, true)
				arg_686_1.iconController_:SetSelectedState("hero")

				arg_686_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_686_1.callingController_:SetSelectedState("normal")

				arg_686_1.keyicon_.color = Color.New(1, 1, 1)
				arg_686_1.icon_.color = Color.New(1, 1, 1)

				local var_689_3 = arg_686_1:GetWordFromCfg(116431160)
				local var_689_4 = arg_686_1:FormatText(var_689_3.content)

				arg_686_1.text_.text = var_689_4

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_5 = 18
				local var_689_6 = utf8.len(var_689_4)
				local var_689_7 = var_689_5 <= 0 and var_689_1 or var_689_1 * (var_689_6 / var_689_5)

				if var_689_7 > 0 and var_689_1 < var_689_7 then
					arg_686_1.talkMaxDuration = var_689_7

					if var_689_7 + var_689_0 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_7 + var_689_0
					end
				end

				arg_686_1.text_.text = var_689_4
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431160", "story_v_out_116431.awb") ~= 0 then
					local var_689_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431160", "story_v_out_116431.awb") / 1000

					if var_689_8 + var_689_0 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_8 + var_689_0
					end

					if var_689_3.prefab_name ~= "" and arg_686_1.actors_[var_689_3.prefab_name] ~= nil then
						local var_689_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_686_1.actors_[var_689_3.prefab_name].transform, "story_v_out_116431", "116431160", "story_v_out_116431.awb")

						arg_686_1:RecordAudio("116431160", var_689_9)
						arg_686_1:RecordAudio("116431160", var_689_9)
					else
						arg_686_1:AudioAction("play", "voice", "story_v_out_116431", "116431160", "story_v_out_116431.awb")
					end

					arg_686_1:RecordHistoryTalkVoice("story_v_out_116431", "116431160", "story_v_out_116431.awb")
				end

				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_10 = math.max(var_689_1, arg_686_1.talkMaxDuration)

			if var_689_0 <= arg_686_1.time_ and arg_686_1.time_ < var_689_0 + var_689_10 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_0) / var_689_10

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_0 + var_689_10 and arg_686_1.time_ < var_689_0 + var_689_10 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play116431161 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 116431161
		arg_690_1.duration_ = 10.03

		local var_690_0 = {
			zh = 5.933,
			ja = 10.033
		}
		local var_690_1 = manager.audio:GetLocalizationFlag()

		if var_690_0[var_690_1] ~= nil then
			arg_690_1.duration_ = var_690_0[var_690_1]
		end

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play116431162(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			local var_693_0 = 0
			local var_693_1 = 0.675

			if var_693_0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_0 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				local var_693_2 = arg_690_1:FormatText(StoryNameCfg[349].name)

				arg_690_1.leftNameTxt_.text = var_693_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, true)
				arg_690_1.iconController_:SetSelectedState("hero")

				arg_690_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_690_1.callingController_:SetSelectedState("normal")

				arg_690_1.keyicon_.color = Color.New(1, 1, 1)
				arg_690_1.icon_.color = Color.New(1, 1, 1)

				local var_693_3 = arg_690_1:GetWordFromCfg(116431161)
				local var_693_4 = arg_690_1:FormatText(var_693_3.content)

				arg_690_1.text_.text = var_693_4

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_5 = 27
				local var_693_6 = utf8.len(var_693_4)
				local var_693_7 = var_693_5 <= 0 and var_693_1 or var_693_1 * (var_693_6 / var_693_5)

				if var_693_7 > 0 and var_693_1 < var_693_7 then
					arg_690_1.talkMaxDuration = var_693_7

					if var_693_7 + var_693_0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_7 + var_693_0
					end
				end

				arg_690_1.text_.text = var_693_4
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431161", "story_v_out_116431.awb") ~= 0 then
					local var_693_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431161", "story_v_out_116431.awb") / 1000

					if var_693_8 + var_693_0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_8 + var_693_0
					end

					if var_693_3.prefab_name ~= "" and arg_690_1.actors_[var_693_3.prefab_name] ~= nil then
						local var_693_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_3.prefab_name].transform, "story_v_out_116431", "116431161", "story_v_out_116431.awb")

						arg_690_1:RecordAudio("116431161", var_693_9)
						arg_690_1:RecordAudio("116431161", var_693_9)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_out_116431", "116431161", "story_v_out_116431.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_out_116431", "116431161", "story_v_out_116431.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_10 = math.max(var_693_1, arg_690_1.talkMaxDuration)

			if var_693_0 <= arg_690_1.time_ and arg_690_1.time_ < var_693_0 + var_693_10 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_0) / var_693_10

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_0 + var_693_10 and arg_690_1.time_ < var_693_0 + var_693_10 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play116431162 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 116431162
		arg_694_1.duration_ = 1.43

		local var_694_0 = {
			zh = 1.2,
			ja = 1.433
		}
		local var_694_1 = manager.audio:GetLocalizationFlag()

		if var_694_0[var_694_1] ~= nil then
			arg_694_1.duration_ = var_694_0[var_694_1]
		end

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play116431163(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			local var_697_0 = 0
			local var_697_1 = 0.125

			if var_697_0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_0 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, true)

				local var_697_2 = arg_694_1:FormatText(StoryNameCfg[264].name)

				arg_694_1.leftNameTxt_.text = var_697_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_694_1.leftNameTxt_.transform)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1.leftNameTxt_.text)
				SetActive(arg_694_1.iconTrs_.gameObject, true)
				arg_694_1.iconController_:SetSelectedState("hero")

				arg_694_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_694_1.callingController_:SetSelectedState("normal")

				arg_694_1.keyicon_.color = Color.New(1, 1, 1)
				arg_694_1.icon_.color = Color.New(1, 1, 1)

				local var_697_3 = arg_694_1:GetWordFromCfg(116431162)
				local var_697_4 = arg_694_1:FormatText(var_697_3.content)

				arg_694_1.text_.text = var_697_4

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_5 = 5
				local var_697_6 = utf8.len(var_697_4)
				local var_697_7 = var_697_5 <= 0 and var_697_1 or var_697_1 * (var_697_6 / var_697_5)

				if var_697_7 > 0 and var_697_1 < var_697_7 then
					arg_694_1.talkMaxDuration = var_697_7

					if var_697_7 + var_697_0 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_7 + var_697_0
					end
				end

				arg_694_1.text_.text = var_697_4
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431162", "story_v_out_116431.awb") ~= 0 then
					local var_697_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431162", "story_v_out_116431.awb") / 1000

					if var_697_8 + var_697_0 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_8 + var_697_0
					end

					if var_697_3.prefab_name ~= "" and arg_694_1.actors_[var_697_3.prefab_name] ~= nil then
						local var_697_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_694_1.actors_[var_697_3.prefab_name].transform, "story_v_out_116431", "116431162", "story_v_out_116431.awb")

						arg_694_1:RecordAudio("116431162", var_697_9)
						arg_694_1:RecordAudio("116431162", var_697_9)
					else
						arg_694_1:AudioAction("play", "voice", "story_v_out_116431", "116431162", "story_v_out_116431.awb")
					end

					arg_694_1:RecordHistoryTalkVoice("story_v_out_116431", "116431162", "story_v_out_116431.awb")
				end

				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_10 = math.max(var_697_1, arg_694_1.talkMaxDuration)

			if var_697_0 <= arg_694_1.time_ and arg_694_1.time_ < var_697_0 + var_697_10 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_0) / var_697_10

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_0 + var_697_10 and arg_694_1.time_ < var_697_0 + var_697_10 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play116431163 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 116431163
		arg_698_1.duration_ = 13.3

		local var_698_0 = {
			zh = 9.033,
			ja = 13.3
		}
		local var_698_1 = manager.audio:GetLocalizationFlag()

		if var_698_0[var_698_1] ~= nil then
			arg_698_1.duration_ = var_698_0[var_698_1]
		end

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play116431164(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			local var_701_0 = 0
			local var_701_1 = 1.2

			if var_701_0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_0 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, true)

				local var_701_2 = arg_698_1:FormatText(StoryNameCfg[349].name)

				arg_698_1.leftNameTxt_.text = var_701_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_698_1.leftNameTxt_.transform)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1.leftNameTxt_.text)
				SetActive(arg_698_1.iconTrs_.gameObject, true)
				arg_698_1.iconController_:SetSelectedState("hero")

				arg_698_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_698_1.callingController_:SetSelectedState("normal")

				arg_698_1.keyicon_.color = Color.New(1, 1, 1)
				arg_698_1.icon_.color = Color.New(1, 1, 1)

				local var_701_3 = arg_698_1:GetWordFromCfg(116431163)
				local var_701_4 = arg_698_1:FormatText(var_701_3.content)

				arg_698_1.text_.text = var_701_4

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_5 = 48
				local var_701_6 = utf8.len(var_701_4)
				local var_701_7 = var_701_5 <= 0 and var_701_1 or var_701_1 * (var_701_6 / var_701_5)

				if var_701_7 > 0 and var_701_1 < var_701_7 then
					arg_698_1.talkMaxDuration = var_701_7

					if var_701_7 + var_701_0 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_7 + var_701_0
					end
				end

				arg_698_1.text_.text = var_701_4
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431163", "story_v_out_116431.awb") ~= 0 then
					local var_701_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431163", "story_v_out_116431.awb") / 1000

					if var_701_8 + var_701_0 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_8 + var_701_0
					end

					if var_701_3.prefab_name ~= "" and arg_698_1.actors_[var_701_3.prefab_name] ~= nil then
						local var_701_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_698_1.actors_[var_701_3.prefab_name].transform, "story_v_out_116431", "116431163", "story_v_out_116431.awb")

						arg_698_1:RecordAudio("116431163", var_701_9)
						arg_698_1:RecordAudio("116431163", var_701_9)
					else
						arg_698_1:AudioAction("play", "voice", "story_v_out_116431", "116431163", "story_v_out_116431.awb")
					end

					arg_698_1:RecordHistoryTalkVoice("story_v_out_116431", "116431163", "story_v_out_116431.awb")
				end

				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_10 = math.max(var_701_1, arg_698_1.talkMaxDuration)

			if var_701_0 <= arg_698_1.time_ and arg_698_1.time_ < var_701_0 + var_701_10 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_0) / var_701_10

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_0 + var_701_10 and arg_698_1.time_ < var_701_0 + var_701_10 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {}

		arg_698_1:InitPlayNodeList()
	end,
	Play116431164 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 116431164
		arg_702_1.duration_ = 2.6

		local var_702_0 = {
			zh = 1.1,
			ja = 2.6
		}
		local var_702_1 = manager.audio:GetLocalizationFlag()

		if var_702_0[var_702_1] ~= nil then
			arg_702_1.duration_ = var_702_0[var_702_1]
		end

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play116431165(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_0 = 0
			local var_705_1 = 0.125

			if var_705_0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_0 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				local var_705_2 = arg_702_1:FormatText(StoryNameCfg[264].name)

				arg_702_1.leftNameTxt_.text = var_705_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, true)
				arg_702_1.iconController_:SetSelectedState("hero")

				arg_702_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_702_1.callingController_:SetSelectedState("normal")

				arg_702_1.keyicon_.color = Color.New(1, 1, 1)
				arg_702_1.icon_.color = Color.New(1, 1, 1)

				local var_705_3 = arg_702_1:GetWordFromCfg(116431164)
				local var_705_4 = arg_702_1:FormatText(var_705_3.content)

				arg_702_1.text_.text = var_705_4

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_5 = 5
				local var_705_6 = utf8.len(var_705_4)
				local var_705_7 = var_705_5 <= 0 and var_705_1 or var_705_1 * (var_705_6 / var_705_5)

				if var_705_7 > 0 and var_705_1 < var_705_7 then
					arg_702_1.talkMaxDuration = var_705_7

					if var_705_7 + var_705_0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_7 + var_705_0
					end
				end

				arg_702_1.text_.text = var_705_4
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431164", "story_v_out_116431.awb") ~= 0 then
					local var_705_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431164", "story_v_out_116431.awb") / 1000

					if var_705_8 + var_705_0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_8 + var_705_0
					end

					if var_705_3.prefab_name ~= "" and arg_702_1.actors_[var_705_3.prefab_name] ~= nil then
						local var_705_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_702_1.actors_[var_705_3.prefab_name].transform, "story_v_out_116431", "116431164", "story_v_out_116431.awb")

						arg_702_1:RecordAudio("116431164", var_705_9)
						arg_702_1:RecordAudio("116431164", var_705_9)
					else
						arg_702_1:AudioAction("play", "voice", "story_v_out_116431", "116431164", "story_v_out_116431.awb")
					end

					arg_702_1:RecordHistoryTalkVoice("story_v_out_116431", "116431164", "story_v_out_116431.awb")
				end

				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_10 = math.max(var_705_1, arg_702_1.talkMaxDuration)

			if var_705_0 <= arg_702_1.time_ and arg_702_1.time_ < var_705_0 + var_705_10 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_0) / var_705_10

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_0 + var_705_10 and arg_702_1.time_ < var_705_0 + var_705_10 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play116431165 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 116431165
		arg_706_1.duration_ = 11.6

		local var_706_0 = {
			zh = 10.2,
			ja = 11.6
		}
		local var_706_1 = manager.audio:GetLocalizationFlag()

		if var_706_0[var_706_1] ~= nil then
			arg_706_1.duration_ = var_706_0[var_706_1]
		end

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play116431166(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			local var_709_0 = 0
			local var_709_1 = 0.975

			if var_709_0 < arg_706_1.time_ and arg_706_1.time_ <= var_709_0 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0
				arg_706_1.dialogCg_.alpha = 1

				arg_706_1.dialog_:SetActive(true)
				SetActive(arg_706_1.leftNameGo_, true)

				local var_709_2 = arg_706_1:FormatText(StoryNameCfg[264].name)

				arg_706_1.leftNameTxt_.text = var_709_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, true)
				arg_706_1.iconController_:SetSelectedState("hero")

				arg_706_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_706_1.callingController_:SetSelectedState("normal")

				arg_706_1.keyicon_.color = Color.New(1, 1, 1)
				arg_706_1.icon_.color = Color.New(1, 1, 1)

				local var_709_3 = arg_706_1:GetWordFromCfg(116431165)
				local var_709_4 = arg_706_1:FormatText(var_709_3.content)

				arg_706_1.text_.text = var_709_4

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_5 = 39
				local var_709_6 = utf8.len(var_709_4)
				local var_709_7 = var_709_5 <= 0 and var_709_1 or var_709_1 * (var_709_6 / var_709_5)

				if var_709_7 > 0 and var_709_1 < var_709_7 then
					arg_706_1.talkMaxDuration = var_709_7

					if var_709_7 + var_709_0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_7 + var_709_0
					end
				end

				arg_706_1.text_.text = var_709_4
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431165", "story_v_out_116431.awb") ~= 0 then
					local var_709_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431165", "story_v_out_116431.awb") / 1000

					if var_709_8 + var_709_0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_8 + var_709_0
					end

					if var_709_3.prefab_name ~= "" and arg_706_1.actors_[var_709_3.prefab_name] ~= nil then
						local var_709_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_706_1.actors_[var_709_3.prefab_name].transform, "story_v_out_116431", "116431165", "story_v_out_116431.awb")

						arg_706_1:RecordAudio("116431165", var_709_9)
						arg_706_1:RecordAudio("116431165", var_709_9)
					else
						arg_706_1:AudioAction("play", "voice", "story_v_out_116431", "116431165", "story_v_out_116431.awb")
					end

					arg_706_1:RecordHistoryTalkVoice("story_v_out_116431", "116431165", "story_v_out_116431.awb")
				end

				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_10 = math.max(var_709_1, arg_706_1.talkMaxDuration)

			if var_709_0 <= arg_706_1.time_ and arg_706_1.time_ < var_709_0 + var_709_10 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - var_709_0) / var_709_10

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= var_709_0 + var_709_10 and arg_706_1.time_ < var_709_0 + var_709_10 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {}

		arg_706_1:InitPlayNodeList()
	end,
	Play116431166 = function(arg_710_0, arg_710_1)
		arg_710_1.time_ = 0
		arg_710_1.frameCnt_ = 0
		arg_710_1.state_ = "playing"
		arg_710_1.curTalkId_ = 116431166
		arg_710_1.duration_ = 5.4

		local var_710_0 = {
			zh = 5.4,
			ja = 5.1
		}
		local var_710_1 = manager.audio:GetLocalizationFlag()

		if var_710_0[var_710_1] ~= nil then
			arg_710_1.duration_ = var_710_0[var_710_1]
		end

		SetActive(arg_710_1.tipsGo_, false)

		function arg_710_1.onSingleLineFinish_()
			arg_710_1.onSingleLineUpdate_ = nil
			arg_710_1.onSingleLineFinish_ = nil
			arg_710_1.state_ = "waiting"
		end

		function arg_710_1.playNext_(arg_712_0)
			if arg_712_0 == 1 then
				arg_710_0:Play116431167(arg_710_1)
			end
		end

		function arg_710_1.onSingleLineUpdate_(arg_713_0)
			local var_713_0 = 2

			if var_713_0 < arg_710_1.time_ and arg_710_1.time_ <= var_713_0 + arg_713_0 then
				local var_713_1 = manager.ui.mainCamera.transform.localPosition
				local var_713_2 = Vector3.New(0, 0, 10) + Vector3.New(var_713_1.x, var_713_1.y, 0)
				local var_713_3 = arg_710_1.bgs_.I05c

				var_713_3.transform.localPosition = var_713_2
				var_713_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_713_4 = var_713_3:GetComponent("SpriteRenderer")

				if var_713_4 and var_713_4.sprite then
					local var_713_5 = (var_713_3.transform.localPosition - var_713_1).z
					local var_713_6 = manager.ui.mainCameraCom_
					local var_713_7 = 2 * var_713_5 * Mathf.Tan(var_713_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_713_8 = var_713_7 * var_713_6.aspect
					local var_713_9 = var_713_4.sprite.bounds.size.x
					local var_713_10 = var_713_4.sprite.bounds.size.y
					local var_713_11 = var_713_8 / var_713_9
					local var_713_12 = var_713_7 / var_713_10
					local var_713_13 = var_713_12 < var_713_11 and var_713_11 or var_713_12

					var_713_3.transform.localScale = Vector3.New(var_713_13, var_713_13, 0)
				end

				for iter_713_0, iter_713_1 in pairs(arg_710_1.bgs_) do
					if iter_713_0 ~= "I05c" then
						iter_713_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_713_14 = 0

			if var_713_14 < arg_710_1.time_ and arg_710_1.time_ <= var_713_14 + arg_713_0 then
				arg_710_1.mask_.enabled = true
				arg_710_1.mask_.raycastTarget = true

				arg_710_1:SetGaussion(false)
			end

			local var_713_15 = 2

			if var_713_14 <= arg_710_1.time_ and arg_710_1.time_ < var_713_14 + var_713_15 then
				local var_713_16 = (arg_710_1.time_ - var_713_14) / var_713_15
				local var_713_17 = Color.New(0, 0, 0)

				var_713_17.a = Mathf.Lerp(0, 1, var_713_16)
				arg_710_1.mask_.color = var_713_17
			end

			if arg_710_1.time_ >= var_713_14 + var_713_15 and arg_710_1.time_ < var_713_14 + var_713_15 + arg_713_0 then
				local var_713_18 = Color.New(0, 0, 0)

				var_713_18.a = 1
				arg_710_1.mask_.color = var_713_18
			end

			local var_713_19 = 2

			if var_713_19 < arg_710_1.time_ and arg_710_1.time_ <= var_713_19 + arg_713_0 then
				arg_710_1.mask_.enabled = true
				arg_710_1.mask_.raycastTarget = true

				arg_710_1:SetGaussion(false)
			end

			local var_713_20 = 2

			if var_713_19 <= arg_710_1.time_ and arg_710_1.time_ < var_713_19 + var_713_20 then
				local var_713_21 = (arg_710_1.time_ - var_713_19) / var_713_20
				local var_713_22 = Color.New(0, 0, 0)

				var_713_22.a = Mathf.Lerp(1, 0, var_713_21)
				arg_710_1.mask_.color = var_713_22
			end

			if arg_710_1.time_ >= var_713_19 + var_713_20 and arg_710_1.time_ < var_713_19 + var_713_20 + arg_713_0 then
				local var_713_23 = Color.New(0, 0, 0)
				local var_713_24 = 0

				arg_710_1.mask_.enabled = false
				var_713_23.a = var_713_24
				arg_710_1.mask_.color = var_713_23
			end

			local var_713_25 = 2
			local var_713_26 = 1

			if var_713_25 < arg_710_1.time_ and arg_710_1.time_ <= var_713_25 + arg_713_0 then
				local var_713_27 = "stop"
				local var_713_28 = "effect"

				arg_710_1:AudioAction(var_713_27, var_713_28, "se_story_16", "se_story_16_rain01_loop", "")
			end

			if arg_710_1.frameCnt_ <= 1 then
				arg_710_1.dialog_:SetActive(false)
			end

			local var_713_29 = 4
			local var_713_30 = 0.05

			if var_713_29 < arg_710_1.time_ and arg_710_1.time_ <= var_713_29 + arg_713_0 then
				arg_710_1.talkMaxDuration = 0

				arg_710_1.dialog_:SetActive(true)

				arg_710_1.dialogCg_.alpha = 0

				local var_713_31 = LeanTween.value(arg_710_1.dialog_, 0, 1, 0.3)

				var_713_31:setOnUpdate(LuaHelper.FloatAction(function(arg_714_0)
					arg_710_1.dialogCg_.alpha = arg_714_0
				end))
				var_713_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_710_1.dialog_)
					var_713_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_710_1.duration_ = arg_710_1.duration_ + 0.3

				SetActive(arg_710_1.leftNameGo_, true)

				local var_713_32 = arg_710_1:FormatText(StoryNameCfg[319].name)

				arg_710_1.leftNameTxt_.text = var_713_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_710_1.leftNameTxt_.transform)

				arg_710_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_710_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_710_1:RecordName(arg_710_1.leftNameTxt_.text)
				SetActive(arg_710_1.iconTrs_.gameObject, true)
				arg_710_1.iconController_:SetSelectedState("hero")

				arg_710_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_710_1.callingController_:SetSelectedState("normal")

				arg_710_1.keyicon_.color = Color.New(1, 1, 1)
				arg_710_1.icon_.color = Color.New(1, 1, 1)

				local var_713_33 = arg_710_1:GetWordFromCfg(116431166)
				local var_713_34 = arg_710_1:FormatText(var_713_33.content)

				arg_710_1.text_.text = var_713_34

				LuaForUtil.ClearLinePrefixSymbol(arg_710_1.text_)

				local var_713_35 = 2
				local var_713_36 = utf8.len(var_713_34)
				local var_713_37 = var_713_35 <= 0 and var_713_30 or var_713_30 * (var_713_36 / var_713_35)

				if var_713_37 > 0 and var_713_30 < var_713_37 then
					arg_710_1.talkMaxDuration = var_713_37
					var_713_29 = var_713_29 + 0.3

					if var_713_37 + var_713_29 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_37 + var_713_29
					end
				end

				arg_710_1.text_.text = var_713_34
				arg_710_1.typewritter.percent = 0

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431166", "story_v_out_116431.awb") ~= 0 then
					local var_713_38 = manager.audio:GetVoiceLength("story_v_out_116431", "116431166", "story_v_out_116431.awb") / 1000

					if var_713_38 + var_713_29 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_38 + var_713_29
					end

					if var_713_33.prefab_name ~= "" and arg_710_1.actors_[var_713_33.prefab_name] ~= nil then
						local var_713_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_710_1.actors_[var_713_33.prefab_name].transform, "story_v_out_116431", "116431166", "story_v_out_116431.awb")

						arg_710_1:RecordAudio("116431166", var_713_39)
						arg_710_1:RecordAudio("116431166", var_713_39)
					else
						arg_710_1:AudioAction("play", "voice", "story_v_out_116431", "116431166", "story_v_out_116431.awb")
					end

					arg_710_1:RecordHistoryTalkVoice("story_v_out_116431", "116431166", "story_v_out_116431.awb")
				end

				arg_710_1:RecordContent(arg_710_1.text_.text)
			end

			local var_713_40 = var_713_29 + 0.3
			local var_713_41 = math.max(var_713_30, arg_710_1.talkMaxDuration)

			if var_713_40 <= arg_710_1.time_ and arg_710_1.time_ < var_713_40 + var_713_41 then
				arg_710_1.typewritter.percent = (arg_710_1.time_ - var_713_40) / var_713_41

				arg_710_1.typewritter:SetDirty()
			end

			if arg_710_1.time_ >= var_713_40 + var_713_41 and arg_710_1.time_ < var_713_40 + var_713_41 + arg_713_0 then
				arg_710_1.typewritter.percent = 1

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(true)
			end
		end

		arg_710_1.nodeConfigList_ = {}

		arg_710_1:InitPlayNodeList()
	end,
	Play116431167 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 116431167
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play116431168(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0
			local var_719_1 = 0.775

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, false)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_2 = arg_716_1:GetWordFromCfg(116431167)
				local var_719_3 = arg_716_1:FormatText(var_719_2.content)

				arg_716_1.text_.text = var_719_3

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_4 = 31
				local var_719_5 = utf8.len(var_719_3)
				local var_719_6 = var_719_4 <= 0 and var_719_1 or var_719_1 * (var_719_5 / var_719_4)

				if var_719_6 > 0 and var_719_1 < var_719_6 then
					arg_716_1.talkMaxDuration = var_719_6

					if var_719_6 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_6 + var_719_0
					end
				end

				arg_716_1.text_.text = var_719_3
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_7 = math.max(var_719_1, arg_716_1.talkMaxDuration)

			if var_719_0 <= arg_716_1.time_ and arg_716_1.time_ < var_719_0 + var_719_7 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_0) / var_719_7

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_0 + var_719_7 and arg_716_1.time_ < var_719_0 + var_719_7 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play116431168 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 116431168
		arg_720_1.duration_ = 2.2

		local var_720_0 = {
			zh = 2.2,
			ja = 1.366
		}
		local var_720_1 = manager.audio:GetLocalizationFlag()

		if var_720_0[var_720_1] ~= nil then
			arg_720_1.duration_ = var_720_0[var_720_1]
		end

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play116431169(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = 0
			local var_723_1 = 0.225

			if var_723_0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_0 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				local var_723_2 = arg_720_1:FormatText(StoryNameCfg[319].name)

				arg_720_1.leftNameTxt_.text = var_723_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, true)
				arg_720_1.iconController_:SetSelectedState("hero")

				arg_720_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_720_1.callingController_:SetSelectedState("normal")

				arg_720_1.keyicon_.color = Color.New(1, 1, 1)
				arg_720_1.icon_.color = Color.New(1, 1, 1)

				local var_723_3 = arg_720_1:GetWordFromCfg(116431168)
				local var_723_4 = arg_720_1:FormatText(var_723_3.content)

				arg_720_1.text_.text = var_723_4

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_5 = 9
				local var_723_6 = utf8.len(var_723_4)
				local var_723_7 = var_723_5 <= 0 and var_723_1 or var_723_1 * (var_723_6 / var_723_5)

				if var_723_7 > 0 and var_723_1 < var_723_7 then
					arg_720_1.talkMaxDuration = var_723_7

					if var_723_7 + var_723_0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_7 + var_723_0
					end
				end

				arg_720_1.text_.text = var_723_4
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431168", "story_v_out_116431.awb") ~= 0 then
					local var_723_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431168", "story_v_out_116431.awb") / 1000

					if var_723_8 + var_723_0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_8 + var_723_0
					end

					if var_723_3.prefab_name ~= "" and arg_720_1.actors_[var_723_3.prefab_name] ~= nil then
						local var_723_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_720_1.actors_[var_723_3.prefab_name].transform, "story_v_out_116431", "116431168", "story_v_out_116431.awb")

						arg_720_1:RecordAudio("116431168", var_723_9)
						arg_720_1:RecordAudio("116431168", var_723_9)
					else
						arg_720_1:AudioAction("play", "voice", "story_v_out_116431", "116431168", "story_v_out_116431.awb")
					end

					arg_720_1:RecordHistoryTalkVoice("story_v_out_116431", "116431168", "story_v_out_116431.awb")
				end

				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_10 = math.max(var_723_1, arg_720_1.talkMaxDuration)

			if var_723_0 <= arg_720_1.time_ and arg_720_1.time_ < var_723_0 + var_723_10 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_0) / var_723_10

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_0 + var_723_10 and arg_720_1.time_ < var_723_0 + var_723_10 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	Play116431169 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 116431169
		arg_724_1.duration_ = 7.3

		local var_724_0 = {
			zh = 7.3,
			ja = 4.333
		}
		local var_724_1 = manager.audio:GetLocalizationFlag()

		if var_724_0[var_724_1] ~= nil then
			arg_724_1.duration_ = var_724_0[var_724_1]
		end

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
			arg_724_1.auto_ = false
		end

		function arg_724_1.playNext_(arg_726_0)
			arg_724_1.onStoryFinished_()
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			local var_727_0 = 0
			local var_727_1 = 0.575

			if var_727_0 < arg_724_1.time_ and arg_724_1.time_ <= var_727_0 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0
				arg_724_1.dialogCg_.alpha = 1

				arg_724_1.dialog_:SetActive(true)
				SetActive(arg_724_1.leftNameGo_, true)

				local var_727_2 = arg_724_1:FormatText(StoryNameCfg[319].name)

				arg_724_1.leftNameTxt_.text = var_727_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_724_1.leftNameTxt_.transform)

				arg_724_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_724_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_724_1:RecordName(arg_724_1.leftNameTxt_.text)
				SetActive(arg_724_1.iconTrs_.gameObject, true)
				arg_724_1.iconController_:SetSelectedState("hero")

				arg_724_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_724_1.callingController_:SetSelectedState("normal")

				arg_724_1.keyicon_.color = Color.New(1, 1, 1)
				arg_724_1.icon_.color = Color.New(1, 1, 1)

				local var_727_3 = arg_724_1:GetWordFromCfg(116431169)
				local var_727_4 = arg_724_1:FormatText(var_727_3.content)

				arg_724_1.text_.text = var_727_4

				LuaForUtil.ClearLinePrefixSymbol(arg_724_1.text_)

				local var_727_5 = 23
				local var_727_6 = utf8.len(var_727_4)
				local var_727_7 = var_727_5 <= 0 and var_727_1 or var_727_1 * (var_727_6 / var_727_5)

				if var_727_7 > 0 and var_727_1 < var_727_7 then
					arg_724_1.talkMaxDuration = var_727_7

					if var_727_7 + var_727_0 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_7 + var_727_0
					end
				end

				arg_724_1.text_.text = var_727_4
				arg_724_1.typewritter.percent = 0

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116431", "116431169", "story_v_out_116431.awb") ~= 0 then
					local var_727_8 = manager.audio:GetVoiceLength("story_v_out_116431", "116431169", "story_v_out_116431.awb") / 1000

					if var_727_8 + var_727_0 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_8 + var_727_0
					end

					if var_727_3.prefab_name ~= "" and arg_724_1.actors_[var_727_3.prefab_name] ~= nil then
						local var_727_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_724_1.actors_[var_727_3.prefab_name].transform, "story_v_out_116431", "116431169", "story_v_out_116431.awb")

						arg_724_1:RecordAudio("116431169", var_727_9)
						arg_724_1:RecordAudio("116431169", var_727_9)
					else
						arg_724_1:AudioAction("play", "voice", "story_v_out_116431", "116431169", "story_v_out_116431.awb")
					end

					arg_724_1:RecordHistoryTalkVoice("story_v_out_116431", "116431169", "story_v_out_116431.awb")
				end

				arg_724_1:RecordContent(arg_724_1.text_.text)
			end

			local var_727_10 = math.max(var_727_1, arg_724_1.talkMaxDuration)

			if var_727_0 <= arg_724_1.time_ and arg_724_1.time_ < var_727_0 + var_727_10 then
				arg_724_1.typewritter.percent = (arg_724_1.time_ - var_727_0) / var_727_10

				arg_724_1.typewritter:SetDirty()
			end

			if arg_724_1.time_ >= var_727_0 + var_727_10 and arg_724_1.time_ < var_727_0 + var_727_10 + arg_727_0 then
				arg_724_1.typewritter.percent = 1

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(true)
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I02",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/SK0202",
		"TextureConfig/Background/SK0205",
		"TextureConfig/Background/SK0106",
		"TextureConfig/Background/SK0206",
		"TextureConfig/Background/I05e",
		"TextureConfig/Background/SK0211",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00",
		"SofdecAsset/story/101164301.usm",
		"TextureConfig/Background/I05c",
		"TextureConfig/Background/SK0208"
	},
	voices = {
		"story_v_out_116431.awb"
	}
}
