return {
	Play121481001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121481001
		arg_1_1.duration_ = 7.07

		local var_1_0 = {
			ja = 7.066,
			ko = 5.633,
			zh = 5.633
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
				arg_1_0:Play121481002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST41"

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
				local var_4_5 = arg_1_1.bgs_.ST41

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
					if iter_4_0 ~= "ST41" then
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
			local var_4_23 = 0.133333333333333

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

			local var_4_28 = 0.266666666666667
			local var_4_29 = 0.633333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

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
			local var_4_35 = 0.35

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[379].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(121481001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481001", "story_v_out_121481.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_121481", "121481001", "story_v_out_121481.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_121481", "121481001", "story_v_out_121481.awb")

						arg_1_1:RecordAudio("121481001", var_4_44)
						arg_1_1:RecordAudio("121481001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_121481", "121481001", "story_v_out_121481.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_121481", "121481001", "story_v_out_121481.awb")
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
	Play121481002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121481002
		arg_9_1.duration_ = 2.63

		local var_9_0 = {
			ja = 2.633,
			ko = 1.566,
			zh = 1.566
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
				arg_9_0:Play121481003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[389].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(121481002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481002", "story_v_out_121481.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481002", "story_v_out_121481.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_121481", "121481002", "story_v_out_121481.awb")

						arg_9_1:RecordAudio("121481002", var_12_9)
						arg_9_1:RecordAudio("121481002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_121481", "121481002", "story_v_out_121481.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_121481", "121481002", "story_v_out_121481.awb")
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
	Play121481003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121481003
		arg_13_1.duration_ = 3.6

		local var_13_0 = {
			ja = 3.6,
			ko = 1.733,
			zh = 1.733
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
				arg_13_0:Play121481004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = manager.ui.mainCamera.transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_0.localPosition
			end

			local var_16_2 = 0.6

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / 0.066
				local var_16_4, var_16_5 = math.modf(var_16_3)

				var_16_0.localPosition = Vector3.New(var_16_5 * 0.13, var_16_5 * 0.13, var_16_5 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_7 = 0.6

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_8 = 0
			local var_16_9 = 0.15

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[379].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(121481003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 6
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481003", "story_v_out_121481.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_121481", "121481003", "story_v_out_121481.awb") / 1000

					if var_16_16 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_8
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_121481", "121481003", "story_v_out_121481.awb")

						arg_13_1:RecordAudio("121481003", var_16_17)
						arg_13_1:RecordAudio("121481003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121481", "121481003", "story_v_out_121481.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121481", "121481003", "story_v_out_121481.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_18 and arg_13_1.time_ < var_16_8 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play121481004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121481004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121481005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.5

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

				local var_20_2 = arg_17_1:GetWordFromCfg(121481004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 60
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
	Play121481005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121481005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121481006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.875

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

				local var_24_2 = arg_21_1:GetWordFromCfg(121481005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 35
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
	Play121481006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121481006
		arg_25_1.duration_ = 11.37

		local var_25_0 = {
			ja = 11.366,
			ko = 7.3,
			zh = 7.3
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
				arg_25_0:Play121481007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1072ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_25_1.stage_.transform)

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

			local var_28_5 = arg_25_1.actors_["1072ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1072ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(-0.7, -0.71, -6)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1072ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["1072ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect1072ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1072ui_story then
				arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_20 = "1076ui_story"

			if arg_25_1.actors_[var_28_20] == nil then
				local var_28_21 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_28_21) then
					local var_28_22 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_25_1.stage_.transform)

					var_28_22.name = var_28_20
					var_28_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_20] = var_28_22

					local var_28_23 = var_28_22:GetComponentInChildren(typeof(CharacterEffect))

					var_28_23.enabled = true

					local var_28_24 = GameObjectTools.GetOrAddComponent(var_28_22, typeof(DynamicBoneHelper))

					if var_28_24 then
						var_28_24:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_23.transform, false)

					arg_25_1.var_[var_28_20 .. "Animator"] = var_28_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_20 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_20 .. "LipSync"] = var_28_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_25 = arg_25_1.actors_["1076ui_story"].transform
			local var_28_26 = 0

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				arg_25_1.var_.moveOldPos1076ui_story = var_28_25.localPosition
			end

			local var_28_27 = 0.001

			if var_28_26 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_27 then
				local var_28_28 = (arg_25_1.time_ - var_28_26) / var_28_27
				local var_28_29 = Vector3.New(0.7, -1.06, -6.2)

				var_28_25.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1076ui_story, var_28_29, var_28_28)

				local var_28_30 = manager.ui.mainCamera.transform.position - var_28_25.position

				var_28_25.forward = Vector3.New(var_28_30.x, var_28_30.y, var_28_30.z)

				local var_28_31 = var_28_25.localEulerAngles

				var_28_31.z = 0
				var_28_31.x = 0
				var_28_25.localEulerAngles = var_28_31
			end

			if arg_25_1.time_ >= var_28_26 + var_28_27 and arg_25_1.time_ < var_28_26 + var_28_27 + arg_28_0 then
				var_28_25.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_28_32 = manager.ui.mainCamera.transform.position - var_28_25.position

				var_28_25.forward = Vector3.New(var_28_32.x, var_28_32.y, var_28_32.z)

				local var_28_33 = var_28_25.localEulerAngles

				var_28_33.z = 0
				var_28_33.x = 0
				var_28_25.localEulerAngles = var_28_33
			end

			local var_28_34 = arg_25_1.actors_["1076ui_story"]
			local var_28_35 = 0

			if var_28_35 < arg_25_1.time_ and arg_25_1.time_ <= var_28_35 + arg_28_0 and not isNil(var_28_34) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_36 = 0.200000002980232

			if var_28_35 <= arg_25_1.time_ and arg_25_1.time_ < var_28_35 + var_28_36 and not isNil(var_28_34) then
				local var_28_37 = (arg_25_1.time_ - var_28_35) / var_28_36

				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_34) then
					local var_28_38 = Mathf.Lerp(0, 0.5, var_28_37)

					arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1076ui_story.fillRatio = var_28_38
				end
			end

			if arg_25_1.time_ >= var_28_35 + var_28_36 and arg_25_1.time_ < var_28_35 + var_28_36 + arg_28_0 and not isNil(var_28_34) and arg_25_1.var_.characterEffect1076ui_story then
				local var_28_39 = 0.5

				arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1076ui_story.fillRatio = var_28_39
			end

			local var_28_40 = 0

			if var_28_40 < arg_25_1.time_ and arg_25_1.time_ <= var_28_40 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_28_41 = 0
			local var_28_42 = 0.6

			if var_28_41 < arg_25_1.time_ and arg_25_1.time_ <= var_28_41 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_43 = arg_25_1:FormatText(StoryNameCfg[379].name)

				arg_25_1.leftNameTxt_.text = var_28_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_44 = arg_25_1:GetWordFromCfg(121481006)
				local var_28_45 = arg_25_1:FormatText(var_28_44.content)

				arg_25_1.text_.text = var_28_45

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_46 = 24
				local var_28_47 = utf8.len(var_28_45)
				local var_28_48 = var_28_46 <= 0 and var_28_42 or var_28_42 * (var_28_47 / var_28_46)

				if var_28_48 > 0 and var_28_42 < var_28_48 then
					arg_25_1.talkMaxDuration = var_28_48

					if var_28_48 + var_28_41 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_48 + var_28_41
					end
				end

				arg_25_1.text_.text = var_28_45
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481006", "story_v_out_121481.awb") ~= 0 then
					local var_28_49 = manager.audio:GetVoiceLength("story_v_out_121481", "121481006", "story_v_out_121481.awb") / 1000

					if var_28_49 + var_28_41 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_49 + var_28_41
					end

					if var_28_44.prefab_name ~= "" and arg_25_1.actors_[var_28_44.prefab_name] ~= nil then
						local var_28_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_44.prefab_name].transform, "story_v_out_121481", "121481006", "story_v_out_121481.awb")

						arg_25_1:RecordAudio("121481006", var_28_50)
						arg_25_1:RecordAudio("121481006", var_28_50)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121481", "121481006", "story_v_out_121481.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121481", "121481006", "story_v_out_121481.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_51 = math.max(var_28_42, arg_25_1.talkMaxDuration)

			if var_28_41 <= arg_25_1.time_ and arg_25_1.time_ < var_28_41 + var_28_51 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_41) / var_28_51

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_41 + var_28_51 and arg_25_1.time_ < var_28_41 + var_28_51 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play121481007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121481007
		arg_29_1.duration_ = 6.27

		local var_29_0 = {
			ja = 6.266,
			ko = 3.133,
			zh = 3.133
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
				arg_29_0:Play121481008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1072ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1072ui_story == nil then
				arg_29_1.var_.characterEffect1072ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1072ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1072ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_32_7 = arg_29_1.actors_["1076ui_story"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1076ui_story == nil then
				arg_29_1.var_.characterEffect1076ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_9 = 0.200000002980232

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.characterEffect1076ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1076ui_story then
				arg_29_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_32_11 = 0
			local var_32_12 = 0.375

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[389].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(121481007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 15
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481007", "story_v_out_121481.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481007", "story_v_out_121481.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_121481", "121481007", "story_v_out_121481.awb")

						arg_29_1:RecordAudio("121481007", var_32_20)
						arg_29_1:RecordAudio("121481007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121481", "121481007", "story_v_out_121481.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121481", "121481007", "story_v_out_121481.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121481008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121481008
		arg_33_1.duration_ = 5.3

		local var_33_0 = {
			ja = 5.3,
			ko = 1.7,
			zh = 1.7
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
				arg_33_0:Play121481009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.2

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[389].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(121481008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481008", "story_v_out_121481.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481008", "story_v_out_121481.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_121481", "121481008", "story_v_out_121481.awb")

						arg_33_1:RecordAudio("121481008", var_36_9)
						arg_33_1:RecordAudio("121481008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121481", "121481008", "story_v_out_121481.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121481", "121481008", "story_v_out_121481.awb")
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
	Play121481009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121481009
		arg_37_1.duration_ = 8.2

		local var_37_0 = {
			ja = 8.2,
			ko = 7,
			zh = 7
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
				arg_37_0:Play121481010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1072ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1072ui_story == nil then
				arg_37_1.var_.characterEffect1072ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1072ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1072ui_story then
				arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1076ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1076ui_story == nil then
				arg_37_1.var_.characterEffect1076ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect1076ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1076ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1076ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1076ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0
			local var_40_11 = 0.85

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_12 = arg_37_1:FormatText(StoryNameCfg[379].name)

				arg_37_1.leftNameTxt_.text = var_40_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(121481009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 34
				local var_40_16 = utf8.len(var_40_14)
				local var_40_17 = var_40_15 <= 0 and var_40_11 or var_40_11 * (var_40_16 / var_40_15)

				if var_40_17 > 0 and var_40_11 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481009", "story_v_out_121481.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481009", "story_v_out_121481.awb") / 1000

					if var_40_18 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_10
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_121481", "121481009", "story_v_out_121481.awb")

						arg_37_1:RecordAudio("121481009", var_40_19)
						arg_37_1:RecordAudio("121481009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121481", "121481009", "story_v_out_121481.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121481", "121481009", "story_v_out_121481.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_20 and arg_37_1.time_ < var_40_10 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121481010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121481010
		arg_41_1.duration_ = 14.9

		local var_41_0 = {
			ja = 14.9,
			ko = 7.666,
			zh = 7.666
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
				arg_41_0:Play121481011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_44_2 = 0
			local var_44_3 = 1.025

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_4 = arg_41_1:FormatText(StoryNameCfg[379].name)

				arg_41_1.leftNameTxt_.text = var_44_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(121481010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 41
				local var_44_8 = utf8.len(var_44_6)
				local var_44_9 = var_44_7 <= 0 and var_44_3 or var_44_3 * (var_44_8 / var_44_7)

				if var_44_9 > 0 and var_44_3 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481010", "story_v_out_121481.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_121481", "121481010", "story_v_out_121481.awb") / 1000

					if var_44_10 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_2
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_121481", "121481010", "story_v_out_121481.awb")

						arg_41_1:RecordAudio("121481010", var_44_11)
						arg_41_1:RecordAudio("121481010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121481", "121481010", "story_v_out_121481.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121481", "121481010", "story_v_out_121481.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_12 and arg_41_1.time_ < var_44_2 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121481011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121481011
		arg_45_1.duration_ = 3.9

		local var_45_0 = {
			ja = 3.9,
			ko = 3.366,
			zh = 3.366
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
				arg_45_0:Play121481012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1072ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1072ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1072ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1072ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1072ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["1076ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1076ui_story then
				arg_45_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_48_10 = 0
			local var_48_11 = 0.45

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[389].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(121481011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 18
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481011", "story_v_out_121481.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481011", "story_v_out_121481.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_121481", "121481011", "story_v_out_121481.awb")

						arg_45_1:RecordAudio("121481011", var_48_19)
						arg_45_1:RecordAudio("121481011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121481", "121481011", "story_v_out_121481.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121481", "121481011", "story_v_out_121481.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121481012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121481012
		arg_49_1.duration_ = 11.57

		local var_49_0 = {
			ja = 11.566,
			ko = 7.9,
			zh = 7.9
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
				arg_49_0:Play121481013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = arg_49_1.actors_["1072ui_story"]
			local var_52_3 = 0

			if var_52_3 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 and not isNil(var_52_2) then
				local var_52_5 = (arg_49_1.time_ - var_52_3) / var_52_4

				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_52_6 = arg_49_1.actors_["1076ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1076ui_story == nil then
				arg_49_1.var_.characterEffect1076ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1076ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1076ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1076ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1076ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 0.975

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[379].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(121481012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 39
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481012", "story_v_out_121481.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481012", "story_v_out_121481.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_121481", "121481012", "story_v_out_121481.awb")

						arg_49_1:RecordAudio("121481012", var_52_21)
						arg_49_1:RecordAudio("121481012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121481", "121481012", "story_v_out_121481.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121481", "121481012", "story_v_out_121481.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121481013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121481013
		arg_53_1.duration_ = 5.53

		local var_53_0 = {
			ja = 5.533,
			ko = 1.866,
			zh = 1.866
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
				arg_53_0:Play121481014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1072ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1072ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1072ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1072ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1072ui_story.fillRatio = var_56_5
			end

			local var_56_6 = arg_53_1.actors_["1076ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1076ui_story == nil then
				arg_53_1.var_.characterEffect1076ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect1076ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1076ui_story then
				arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_56_10 = 0
			local var_56_11 = 0.275

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_12 = arg_53_1:FormatText(StoryNameCfg[389].name)

				arg_53_1.leftNameTxt_.text = var_56_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:GetWordFromCfg(121481013)
				local var_56_14 = arg_53_1:FormatText(var_56_13.content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 11
				local var_56_16 = utf8.len(var_56_14)
				local var_56_17 = var_56_15 <= 0 and var_56_11 or var_56_11 * (var_56_16 / var_56_15)

				if var_56_17 > 0 and var_56_11 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_10
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481013", "story_v_out_121481.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481013", "story_v_out_121481.awb") / 1000

					if var_56_18 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_10
					end

					if var_56_13.prefab_name ~= "" and arg_53_1.actors_[var_56_13.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_13.prefab_name].transform, "story_v_out_121481", "121481013", "story_v_out_121481.awb")

						arg_53_1:RecordAudio("121481013", var_56_19)
						arg_53_1:RecordAudio("121481013", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121481", "121481013", "story_v_out_121481.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121481", "121481013", "story_v_out_121481.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_11, arg_53_1.talkMaxDuration)

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_20 and arg_53_1.time_ < var_56_10 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121481014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121481014
		arg_57_1.duration_ = 10.3

		local var_57_0 = {
			ja = 10.3,
			ko = 6.666,
			zh = 6.666
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
				arg_57_0:Play121481015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_60_2 = arg_57_1.actors_["1072ui_story"]
			local var_60_3 = 0

			if var_60_3 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1072ui_story == nil then
				arg_57_1.var_.characterEffect1072ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_4 and not isNil(var_60_2) then
				local var_60_5 = (arg_57_1.time_ - var_60_3) / var_60_4

				if arg_57_1.var_.characterEffect1072ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_3 + var_60_4 and arg_57_1.time_ < var_60_3 + var_60_4 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1072ui_story then
				arg_57_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_60_6 = arg_57_1.actors_["1076ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1076ui_story == nil then
				arg_57_1.var_.characterEffect1076ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect1076ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1076ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1076ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1076ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 1

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[379].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(121481014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481014", "story_v_out_121481.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481014", "story_v_out_121481.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_121481", "121481014", "story_v_out_121481.awb")

						arg_57_1:RecordAudio("121481014", var_60_21)
						arg_57_1:RecordAudio("121481014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121481", "121481014", "story_v_out_121481.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121481", "121481014", "story_v_out_121481.awb")
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
	Play121481015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121481015
		arg_61_1.duration_ = 10.4

		local var_61_0 = {
			ja = 10.4,
			ko = 7.766,
			zh = 7.766
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
				arg_61_0:Play121481016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1072ui_story"]
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 and not isNil(var_64_2) then
				local var_64_5 = (arg_61_1.time_ - var_64_3) / var_64_4

				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_64_6 = arg_61_1.actors_["1076ui_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_6) then
					local var_64_10 = Mathf.Lerp(0, 0.5, var_64_9)

					arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1076ui_story.fillRatio = var_64_10
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1076ui_story then
				local var_64_11 = 0.5

				arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1076ui_story.fillRatio = var_64_11
			end

			local var_64_12 = 0
			local var_64_13 = 1.05

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[379].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(121481015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 42
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481015", "story_v_out_121481.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481015", "story_v_out_121481.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_121481", "121481015", "story_v_out_121481.awb")

						arg_61_1:RecordAudio("121481015", var_64_21)
						arg_61_1:RecordAudio("121481015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121481", "121481015", "story_v_out_121481.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121481", "121481015", "story_v_out_121481.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121481016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121481016
		arg_65_1.duration_ = 4.8

		local var_65_0 = {
			ja = 4.8,
			ko = 3.4,
			zh = 3.4
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
				arg_65_0:Play121481017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1072ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1072ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1072ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1072ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["1076ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story then
				arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_68_10 = 0
			local var_68_11 = 0.3

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_12 = arg_65_1:FormatText(StoryNameCfg[389].name)

				arg_65_1.leftNameTxt_.text = var_68_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(121481016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 12
				local var_68_16 = utf8.len(var_68_14)
				local var_68_17 = var_68_15 <= 0 and var_68_11 or var_68_11 * (var_68_16 / var_68_15)

				if var_68_17 > 0 and var_68_11 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481016", "story_v_out_121481.awb") ~= 0 then
					local var_68_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481016", "story_v_out_121481.awb") / 1000

					if var_68_18 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_10
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_121481", "121481016", "story_v_out_121481.awb")

						arg_65_1:RecordAudio("121481016", var_68_19)
						arg_65_1:RecordAudio("121481016", var_68_19)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121481", "121481016", "story_v_out_121481.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121481", "121481016", "story_v_out_121481.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_20 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_20 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_20

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_20 and arg_65_1.time_ < var_68_10 + var_68_20 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121481017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121481017
		arg_69_1.duration_ = 12.63

		local var_69_0 = {
			ja = 12.633,
			ko = 11.4,
			zh = 11.4
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
				arg_69_0:Play121481018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1072ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["1076ui_story"]
			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1076ui_story == nil then
				arg_69_1.var_.characterEffect1076ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 and not isNil(var_72_4) then
				local var_72_7 = (arg_69_1.time_ - var_72_5) / var_72_6

				if arg_69_1.var_.characterEffect1076ui_story and not isNil(var_72_4) then
					local var_72_8 = Mathf.Lerp(0, 0.5, var_72_7)

					arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1076ui_story.fillRatio = var_72_8
				end
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1076ui_story then
				local var_72_9 = 0.5

				arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1076ui_story.fillRatio = var_72_9
			end

			local var_72_10 = 0
			local var_72_11 = 1.325

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_12 = arg_69_1:FormatText(StoryNameCfg[379].name)

				arg_69_1.leftNameTxt_.text = var_72_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(121481017)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 53
				local var_72_16 = utf8.len(var_72_14)
				local var_72_17 = var_72_15 <= 0 and var_72_11 or var_72_11 * (var_72_16 / var_72_15)

				if var_72_17 > 0 and var_72_11 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481017", "story_v_out_121481.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481017", "story_v_out_121481.awb") / 1000

					if var_72_18 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_10
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_121481", "121481017", "story_v_out_121481.awb")

						arg_69_1:RecordAudio("121481017", var_72_19)
						arg_69_1:RecordAudio("121481017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121481", "121481017", "story_v_out_121481.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121481", "121481017", "story_v_out_121481.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_20 and arg_69_1.time_ < var_72_10 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121481018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121481018
		arg_73_1.duration_ = 11.47

		local var_73_0 = {
			ja = 11.466,
			ko = 7.433,
			zh = 7.433
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121481019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[379].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(121481018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 40
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481018", "story_v_out_121481.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481018", "story_v_out_121481.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_121481", "121481018", "story_v_out_121481.awb")

						arg_73_1:RecordAudio("121481018", var_76_9)
						arg_73_1:RecordAudio("121481018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121481", "121481018", "story_v_out_121481.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121481", "121481018", "story_v_out_121481.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121481019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121481019
		arg_77_1.duration_ = 12.93

		local var_77_0 = {
			ja = 12.933,
			ko = 9.666,
			zh = 9.666
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
				arg_77_0:Play121481020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.15

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[379].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(121481019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 46
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481019", "story_v_out_121481.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481019", "story_v_out_121481.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_121481", "121481019", "story_v_out_121481.awb")

						arg_77_1:RecordAudio("121481019", var_80_9)
						arg_77_1:RecordAudio("121481019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121481", "121481019", "story_v_out_121481.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121481", "121481019", "story_v_out_121481.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121481020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121481020
		arg_81_1.duration_ = 6.63

		local var_81_0 = {
			ja = 6.633,
			ko = 2.5,
			zh = 2.5
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
				arg_81_0:Play121481021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1072ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1072ui_story == nil then
				arg_81_1.var_.characterEffect1072ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1072ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1072ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1072ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1072ui_story.fillRatio = var_84_5
			end

			local var_84_6 = arg_81_1.actors_["1076ui_story"]
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.200000002980232

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 and not isNil(var_84_6) then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8

				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_6) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_84_10 = 0
			local var_84_11 = 0.2

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_12 = arg_81_1:FormatText(StoryNameCfg[389].name)

				arg_81_1.leftNameTxt_.text = var_84_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(121481020)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 8
				local var_84_16 = utf8.len(var_84_14)
				local var_84_17 = var_84_15 <= 0 and var_84_11 or var_84_11 * (var_84_16 / var_84_15)

				if var_84_17 > 0 and var_84_11 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17

					if var_84_17 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481020", "story_v_out_121481.awb") ~= 0 then
					local var_84_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481020", "story_v_out_121481.awb") / 1000

					if var_84_18 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_10
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_121481", "121481020", "story_v_out_121481.awb")

						arg_81_1:RecordAudio("121481020", var_84_19)
						arg_81_1:RecordAudio("121481020", var_84_19)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121481", "121481020", "story_v_out_121481.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121481", "121481020", "story_v_out_121481.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_20 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_20 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_20

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_20 and arg_81_1.time_ < var_84_10 + var_84_20 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121481021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121481021
		arg_85_1.duration_ = 12.2

		local var_85_0 = {
			ja = 12.2,
			ko = 10.433,
			zh = 10.433
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
				arg_85_0:Play121481022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1072ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_88_4 = arg_85_1.actors_["1076ui_story"]
			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1076ui_story == nil then
				arg_85_1.var_.characterEffect1076ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 and not isNil(var_88_4) then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / var_88_6

				if arg_85_1.var_.characterEffect1076ui_story and not isNil(var_88_4) then
					local var_88_8 = Mathf.Lerp(0, 0.5, var_88_7)

					arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1076ui_story.fillRatio = var_88_8
				end
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1076ui_story then
				local var_88_9 = 0.5

				arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1076ui_story.fillRatio = var_88_9
			end

			local var_88_10 = 0
			local var_88_11 = 1.225

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_12 = arg_85_1:FormatText(StoryNameCfg[379].name)

				arg_85_1.leftNameTxt_.text = var_88_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(121481021)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 49
				local var_88_16 = utf8.len(var_88_14)
				local var_88_17 = var_88_15 <= 0 and var_88_11 or var_88_11 * (var_88_16 / var_88_15)

				if var_88_17 > 0 and var_88_11 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17

					if var_88_17 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481021", "story_v_out_121481.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481021", "story_v_out_121481.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_121481", "121481021", "story_v_out_121481.awb")

						arg_85_1:RecordAudio("121481021", var_88_19)
						arg_85_1:RecordAudio("121481021", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121481", "121481021", "story_v_out_121481.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121481", "121481021", "story_v_out_121481.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_20 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_20 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_20

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_20 and arg_85_1.time_ < var_88_10 + var_88_20 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121481022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121481022
		arg_89_1.duration_ = 7.77

		local var_89_0 = {
			ja = 7.766,
			ko = 7.433,
			zh = 7.433
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
				arg_89_0:Play121481023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.975

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[379].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(121481022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481022", "story_v_out_121481.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481022", "story_v_out_121481.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_121481", "121481022", "story_v_out_121481.awb")

						arg_89_1:RecordAudio("121481022", var_92_9)
						arg_89_1:RecordAudio("121481022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121481", "121481022", "story_v_out_121481.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121481", "121481022", "story_v_out_121481.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121481023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121481023
		arg_93_1.duration_ = 13.07

		local var_93_0 = {
			ja = 7.733,
			ko = 13.066,
			zh = 13.066
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
				arg_93_0:Play121481024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.7

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[379].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(121481023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 68
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481023", "story_v_out_121481.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481023", "story_v_out_121481.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_121481", "121481023", "story_v_out_121481.awb")

						arg_93_1:RecordAudio("121481023", var_96_9)
						arg_93_1:RecordAudio("121481023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121481", "121481023", "story_v_out_121481.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121481", "121481023", "story_v_out_121481.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121481024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121481024
		arg_97_1.duration_ = 13.1

		local var_97_0 = {
			ja = 13.1,
			ko = 11.866,
			zh = 11.866
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
				arg_97_0:Play121481025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.4

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[379].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(121481024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481024", "story_v_out_121481.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481024", "story_v_out_121481.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_121481", "121481024", "story_v_out_121481.awb")

						arg_97_1:RecordAudio("121481024", var_100_9)
						arg_97_1:RecordAudio("121481024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121481", "121481024", "story_v_out_121481.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121481", "121481024", "story_v_out_121481.awb")
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
	Play121481025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121481025
		arg_101_1.duration_ = 9.1

		local var_101_0 = {
			ja = 4.5,
			ko = 9.1,
			zh = 9.1
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121481026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_2 = 0
			local var_104_3 = 0.75

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_4 = arg_101_1:FormatText(StoryNameCfg[379].name)

				arg_101_1.leftNameTxt_.text = var_104_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_5 = arg_101_1:GetWordFromCfg(121481025)
				local var_104_6 = arg_101_1:FormatText(var_104_5.content)

				arg_101_1.text_.text = var_104_6

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 30
				local var_104_8 = utf8.len(var_104_6)
				local var_104_9 = var_104_7 <= 0 and var_104_3 or var_104_3 * (var_104_8 / var_104_7)

				if var_104_9 > 0 and var_104_3 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_6
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481025", "story_v_out_121481.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_121481", "121481025", "story_v_out_121481.awb") / 1000

					if var_104_10 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_2
					end

					if var_104_5.prefab_name ~= "" and arg_101_1.actors_[var_104_5.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_5.prefab_name].transform, "story_v_out_121481", "121481025", "story_v_out_121481.awb")

						arg_101_1:RecordAudio("121481025", var_104_11)
						arg_101_1:RecordAudio("121481025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121481", "121481025", "story_v_out_121481.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121481", "121481025", "story_v_out_121481.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_12 and arg_101_1.time_ < var_104_2 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121481026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121481026
		arg_105_1.duration_ = 7.43

		local var_105_0 = {
			ja = 7.433,
			ko = 3.366,
			zh = 3.366
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
				arg_105_0:Play121481027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1072ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1072ui_story == nil then
				arg_105_1.var_.characterEffect1072ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1072ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1072ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1072ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1072ui_story.fillRatio = var_108_5
			end

			local var_108_6 = arg_105_1.actors_["1076ui_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1076ui_story == nil then
				arg_105_1.var_.characterEffect1076ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.200000002980232

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect1076ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1076ui_story then
				arg_105_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_108_10 = 0
			local var_108_11 = 0.3

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_12 = arg_105_1:FormatText(StoryNameCfg[389].name)

				arg_105_1.leftNameTxt_.text = var_108_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_13 = arg_105_1:GetWordFromCfg(121481026)
				local var_108_14 = arg_105_1:FormatText(var_108_13.content)

				arg_105_1.text_.text = var_108_14

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_15 = 12
				local var_108_16 = utf8.len(var_108_14)
				local var_108_17 = var_108_15 <= 0 and var_108_11 or var_108_11 * (var_108_16 / var_108_15)

				if var_108_17 > 0 and var_108_11 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_14
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481026", "story_v_out_121481.awb") ~= 0 then
					local var_108_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481026", "story_v_out_121481.awb") / 1000

					if var_108_18 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_10
					end

					if var_108_13.prefab_name ~= "" and arg_105_1.actors_[var_108_13.prefab_name] ~= nil then
						local var_108_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_13.prefab_name].transform, "story_v_out_121481", "121481026", "story_v_out_121481.awb")

						arg_105_1:RecordAudio("121481026", var_108_19)
						arg_105_1:RecordAudio("121481026", var_108_19)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121481", "121481026", "story_v_out_121481.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121481", "121481026", "story_v_out_121481.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_20 and arg_105_1.time_ < var_108_10 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121481027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121481027
		arg_109_1.duration_ = 2.57

		local var_109_0 = {
			ja = 2.2,
			ko = 2.566,
			zh = 2.566
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
				arg_109_0:Play121481028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1072ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1072ui_story == nil then
				arg_109_1.var_.characterEffect1072ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1072ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1072ui_story then
				arg_109_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_112_4 = arg_109_1.actors_["1076ui_story"]
			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect1076ui_story == nil then
				arg_109_1.var_.characterEffect1076ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_6 and not isNil(var_112_4) then
				local var_112_7 = (arg_109_1.time_ - var_112_5) / var_112_6

				if arg_109_1.var_.characterEffect1076ui_story and not isNil(var_112_4) then
					local var_112_8 = Mathf.Lerp(0, 0.5, var_112_7)

					arg_109_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1076ui_story.fillRatio = var_112_8
				end
			end

			if arg_109_1.time_ >= var_112_5 + var_112_6 and arg_109_1.time_ < var_112_5 + var_112_6 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect1076ui_story then
				local var_112_9 = 0.5

				arg_109_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1076ui_story.fillRatio = var_112_9
			end

			local var_112_10 = 0
			local var_112_11 = 0.15

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_12 = arg_109_1:FormatText(StoryNameCfg[379].name)

				arg_109_1.leftNameTxt_.text = var_112_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(121481027)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 6
				local var_112_16 = utf8.len(var_112_14)
				local var_112_17 = var_112_15 <= 0 and var_112_11 or var_112_11 * (var_112_16 / var_112_15)

				if var_112_17 > 0 and var_112_11 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17

					if var_112_17 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481027", "story_v_out_121481.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481027", "story_v_out_121481.awb") / 1000

					if var_112_18 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_10
					end

					if var_112_13.prefab_name ~= "" and arg_109_1.actors_[var_112_13.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_13.prefab_name].transform, "story_v_out_121481", "121481027", "story_v_out_121481.awb")

						arg_109_1:RecordAudio("121481027", var_112_19)
						arg_109_1:RecordAudio("121481027", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121481", "121481027", "story_v_out_121481.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121481", "121481027", "story_v_out_121481.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_20 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_20

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_20 and arg_109_1.time_ < var_112_10 + var_112_20 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121481028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121481028
		arg_113_1.duration_ = 11.1

		local var_113_0 = {
			ja = 11.1,
			ko = 10.366,
			zh = 10.366
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
				arg_113_0:Play121481029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.35

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[379].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(121481028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 54
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481028", "story_v_out_121481.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481028", "story_v_out_121481.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_121481", "121481028", "story_v_out_121481.awb")

						arg_113_1:RecordAudio("121481028", var_116_9)
						arg_113_1:RecordAudio("121481028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121481", "121481028", "story_v_out_121481.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121481", "121481028", "story_v_out_121481.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play121481029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121481029
		arg_117_1.duration_ = 9.73

		local var_117_0 = {
			ja = 9.733,
			ko = 7.233,
			zh = 7.233
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
				arg_117_0:Play121481030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_120_1 = 0
			local var_120_2 = 0.85

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_3 = arg_117_1:FormatText(StoryNameCfg[379].name)

				arg_117_1.leftNameTxt_.text = var_120_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(121481029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 34
				local var_120_7 = utf8.len(var_120_5)
				local var_120_8 = var_120_6 <= 0 and var_120_2 or var_120_2 * (var_120_7 / var_120_6)

				if var_120_8 > 0 and var_120_2 < var_120_8 then
					arg_117_1.talkMaxDuration = var_120_8

					if var_120_8 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481029", "story_v_out_121481.awb") ~= 0 then
					local var_120_9 = manager.audio:GetVoiceLength("story_v_out_121481", "121481029", "story_v_out_121481.awb") / 1000

					if var_120_9 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_1
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_121481", "121481029", "story_v_out_121481.awb")

						arg_117_1:RecordAudio("121481029", var_120_10)
						arg_117_1:RecordAudio("121481029", var_120_10)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121481", "121481029", "story_v_out_121481.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121481", "121481029", "story_v_out_121481.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_11 and arg_117_1.time_ < var_120_1 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play121481030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121481030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play121481031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1072ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1072ui_story == nil then
				arg_121_1.var_.characterEffect1072ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1072ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1072ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1072ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1072ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.625

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(121481030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 25
				local var_124_11 = utf8.len(var_124_9)
				local var_124_12 = var_124_10 <= 0 and var_124_7 or var_124_7 * (var_124_11 / var_124_10)

				if var_124_12 > 0 and var_124_7 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_13 and arg_121_1.time_ < var_124_6 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play121481031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121481031
		arg_125_1.duration_ = 8.13

		local var_125_0 = {
			ja = 5.433,
			ko = 8.133,
			zh = 8.133
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
				arg_125_0:Play121481032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1072ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1072ui_story == nil then
				arg_125_1.var_.characterEffect1072ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1072ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1072ui_story then
				arg_125_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_128_4 = 0
			local var_128_5 = 1.1

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_6 = arg_125_1:FormatText(StoryNameCfg[379].name)

				arg_125_1.leftNameTxt_.text = var_128_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(121481031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 44
				local var_128_10 = utf8.len(var_128_8)
				local var_128_11 = var_128_9 <= 0 and var_128_5 or var_128_5 * (var_128_10 / var_128_9)

				if var_128_11 > 0 and var_128_5 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481031", "story_v_out_121481.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_121481", "121481031", "story_v_out_121481.awb") / 1000

					if var_128_12 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_4
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_121481", "121481031", "story_v_out_121481.awb")

						arg_125_1:RecordAudio("121481031", var_128_13)
						arg_125_1:RecordAudio("121481031", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_121481", "121481031", "story_v_out_121481.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_121481", "121481031", "story_v_out_121481.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_14 and arg_125_1.time_ < var_128_4 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play121481032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121481032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play121481033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1072ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1072ui_story == nil then
				arg_129_1.var_.characterEffect1072ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1072ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1072ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1072ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1072ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 1.225

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(121481032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 49
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play121481033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121481033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play121481034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(121481033)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 40
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play121481034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121481034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play121481035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1076ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1076ui_story == nil then
				arg_137_1.var_.characterEffect1076ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1076ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1076ui_story then
				arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_140_5 = 0
			local var_140_6 = 0.125

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_7 = arg_137_1:FormatText(StoryNameCfg[389].name)

				arg_137_1.leftNameTxt_.text = var_140_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(121481034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 5
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_6 or var_140_6 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_6 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481034", "story_v_out_121481.awb") ~= 0 then
					local var_140_13 = manager.audio:GetVoiceLength("story_v_out_121481", "121481034", "story_v_out_121481.awb") / 1000

					if var_140_13 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_5
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_121481", "121481034", "story_v_out_121481.awb")

						arg_137_1:RecordAudio("121481034", var_140_14)
						arg_137_1:RecordAudio("121481034", var_140_14)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_121481", "121481034", "story_v_out_121481.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_121481", "121481034", "story_v_out_121481.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_15 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_15 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_15

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_15 and arg_137_1.time_ < var_140_5 + var_140_15 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play121481035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121481035
		arg_141_1.duration_ = 6.73

		local var_141_0 = {
			ja = 6.733,
			ko = 3.766,
			zh = 3.766
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
				arg_141_0:Play121481036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1072ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1072ui_story == nil then
				arg_141_1.var_.characterEffect1072ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1072ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1072ui_story then
				arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1076ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1076ui_story == nil then
				arg_141_1.var_.characterEffect1076ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect1076ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1076ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1076ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1076ui_story.fillRatio = var_144_9
			end

			local var_144_10 = 0
			local var_144_11 = 0.475

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_12 = arg_141_1:FormatText(StoryNameCfg[379].name)

				arg_141_1.leftNameTxt_.text = var_144_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(121481035)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 19
				local var_144_16 = utf8.len(var_144_14)
				local var_144_17 = var_144_15 <= 0 and var_144_11 or var_144_11 * (var_144_16 / var_144_15)

				if var_144_17 > 0 and var_144_11 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481035", "story_v_out_121481.awb") ~= 0 then
					local var_144_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481035", "story_v_out_121481.awb") / 1000

					if var_144_18 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_10
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_121481", "121481035", "story_v_out_121481.awb")

						arg_141_1:RecordAudio("121481035", var_144_19)
						arg_141_1:RecordAudio("121481035", var_144_19)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121481", "121481035", "story_v_out_121481.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121481", "121481035", "story_v_out_121481.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_20 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_20 and arg_141_1.time_ < var_144_10 + var_144_20 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121481036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121481036
		arg_145_1.duration_ = 12.3

		local var_145_0 = {
			ja = 12.3,
			ko = 8.933,
			zh = 8.933
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
				arg_145_0:Play121481037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 1.175

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[379].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(121481036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 46
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481036", "story_v_out_121481.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481036", "story_v_out_121481.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_121481", "121481036", "story_v_out_121481.awb")

						arg_145_1:RecordAudio("121481036", var_148_9)
						arg_145_1:RecordAudio("121481036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121481", "121481036", "story_v_out_121481.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121481", "121481036", "story_v_out_121481.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play121481037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 121481037
		arg_149_1.duration_ = 8.6

		local var_149_0 = {
			ja = 8.6,
			ko = 4.666,
			zh = 4.666
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
				arg_149_0:Play121481038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1072ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1072ui_story == nil then
				arg_149_1.var_.characterEffect1072ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1072ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1072ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1072ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1072ui_story.fillRatio = var_152_5
			end

			local var_152_6 = arg_149_1.actors_["1076ui_story"]
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1076ui_story == nil then
				arg_149_1.var_.characterEffect1076ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.200000002980232

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 and not isNil(var_152_6) then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / var_152_8

				if arg_149_1.var_.characterEffect1076ui_story and not isNil(var_152_6) then
					arg_149_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1076ui_story then
				arg_149_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_152_11 = 0
			local var_152_12 = 0.6

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_13 = arg_149_1:FormatText(StoryNameCfg[389].name)

				arg_149_1.leftNameTxt_.text = var_152_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:GetWordFromCfg(121481037)
				local var_152_15 = arg_149_1:FormatText(var_152_14.content)

				arg_149_1.text_.text = var_152_15

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 24
				local var_152_17 = utf8.len(var_152_15)
				local var_152_18 = var_152_16 <= 0 and var_152_12 or var_152_12 * (var_152_17 / var_152_16)

				if var_152_18 > 0 and var_152_12 < var_152_18 then
					arg_149_1.talkMaxDuration = var_152_18

					if var_152_18 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_15
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481037", "story_v_out_121481.awb") ~= 0 then
					local var_152_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481037", "story_v_out_121481.awb") / 1000

					if var_152_19 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_11
					end

					if var_152_14.prefab_name ~= "" and arg_149_1.actors_[var_152_14.prefab_name] ~= nil then
						local var_152_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_14.prefab_name].transform, "story_v_out_121481", "121481037", "story_v_out_121481.awb")

						arg_149_1:RecordAudio("121481037", var_152_20)
						arg_149_1:RecordAudio("121481037", var_152_20)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_121481", "121481037", "story_v_out_121481.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_121481", "121481037", "story_v_out_121481.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_21 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_21 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_21

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_21 and arg_149_1.time_ < var_152_11 + var_152_21 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play121481038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 121481038
		arg_153_1.duration_ = 8.93

		local var_153_0 = {
			ja = 8.933,
			ko = 5.366,
			zh = 5.366
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
				arg_153_0:Play121481039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1072ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1072ui_story == nil then
				arg_153_1.var_.characterEffect1072ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1072ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1072ui_story then
				arg_153_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1076ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1076ui_story == nil then
				arg_153_1.var_.characterEffect1076ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect1076ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1076ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1076ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1076ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0
			local var_156_11 = 0.55

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_12 = arg_153_1:FormatText(StoryNameCfg[379].name)

				arg_153_1.leftNameTxt_.text = var_156_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_13 = arg_153_1:GetWordFromCfg(121481038)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 21
				local var_156_16 = utf8.len(var_156_14)
				local var_156_17 = var_156_15 <= 0 and var_156_11 or var_156_11 * (var_156_16 / var_156_15)

				if var_156_17 > 0 and var_156_11 < var_156_17 then
					arg_153_1.talkMaxDuration = var_156_17

					if var_156_17 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481038", "story_v_out_121481.awb") ~= 0 then
					local var_156_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481038", "story_v_out_121481.awb") / 1000

					if var_156_18 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_10
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_121481", "121481038", "story_v_out_121481.awb")

						arg_153_1:RecordAudio("121481038", var_156_19)
						arg_153_1:RecordAudio("121481038", var_156_19)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_121481", "121481038", "story_v_out_121481.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_121481", "121481038", "story_v_out_121481.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_20 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_20 and arg_153_1.time_ < var_156_10 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play121481039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 121481039
		arg_157_1.duration_ = 10.83

		local var_157_0 = {
			ja = 4.166,
			ko = 10.833,
			zh = 10.833
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
				arg_157_0:Play121481040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.275

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[379].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(121481039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481039", "story_v_out_121481.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481039", "story_v_out_121481.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_121481", "121481039", "story_v_out_121481.awb")

						arg_157_1:RecordAudio("121481039", var_160_9)
						arg_157_1:RecordAudio("121481039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_121481", "121481039", "story_v_out_121481.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_121481", "121481039", "story_v_out_121481.awb")
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
	Play121481040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 121481040
		arg_161_1.duration_ = 12.4

		local var_161_0 = {
			ja = 12.4,
			ko = 6.8,
			zh = 6.8
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
				arg_161_0:Play121481041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.875

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[379].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(121481040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481040", "story_v_out_121481.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481040", "story_v_out_121481.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_121481", "121481040", "story_v_out_121481.awb")

						arg_161_1:RecordAudio("121481040", var_164_9)
						arg_161_1:RecordAudio("121481040", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_121481", "121481040", "story_v_out_121481.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_121481", "121481040", "story_v_out_121481.awb")
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
	Play121481041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 121481041
		arg_165_1.duration_ = 4.2

		local var_165_0 = {
			ja = 3.966,
			ko = 4.2,
			zh = 4.2
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
				arg_165_0:Play121481042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1072ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1072ui_story == nil then
				arg_165_1.var_.characterEffect1072ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1072ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1072ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1072ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1072ui_story.fillRatio = var_168_5
			end

			local var_168_6 = arg_165_1.actors_["1076ui_story"]
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1076ui_story == nil then
				arg_165_1.var_.characterEffect1076ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.200000002980232

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 and not isNil(var_168_6) then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8

				if arg_165_1.var_.characterEffect1076ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect1076ui_story then
				arg_165_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_168_10 = 0
			local var_168_11 = 0.35

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_12 = arg_165_1:FormatText(StoryNameCfg[389].name)

				arg_165_1.leftNameTxt_.text = var_168_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:GetWordFromCfg(121481041)
				local var_168_14 = arg_165_1:FormatText(var_168_13.content)

				arg_165_1.text_.text = var_168_14

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 14
				local var_168_16 = utf8.len(var_168_14)
				local var_168_17 = var_168_15 <= 0 and var_168_11 or var_168_11 * (var_168_16 / var_168_15)

				if var_168_17 > 0 and var_168_11 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_14
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481041", "story_v_out_121481.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481041", "story_v_out_121481.awb") / 1000

					if var_168_18 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_10
					end

					if var_168_13.prefab_name ~= "" and arg_165_1.actors_[var_168_13.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_13.prefab_name].transform, "story_v_out_121481", "121481041", "story_v_out_121481.awb")

						arg_165_1:RecordAudio("121481041", var_168_19)
						arg_165_1:RecordAudio("121481041", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_121481", "121481041", "story_v_out_121481.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_121481", "121481041", "story_v_out_121481.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_20 and arg_165_1.time_ < var_168_10 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play121481042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 121481042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play121481043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1072ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1072ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, 100, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1072ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 100, 0)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1072ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1072ui_story == nil then
				arg_169_1.var_.characterEffect1072ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1072ui_story and not isNil(var_172_9) then
					local var_172_13 = Mathf.Lerp(0, 0.5, var_172_12)

					arg_169_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1072ui_story.fillRatio = var_172_13
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1072ui_story then
				local var_172_14 = 0.5

				arg_169_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1072ui_story.fillRatio = var_172_14
			end

			local var_172_15 = arg_169_1.actors_["1076ui_story"].transform
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.var_.moveOldPos1076ui_story = var_172_15.localPosition
			end

			local var_172_17 = 0.001

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Vector3.New(0, 100, 0)

				var_172_15.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1076ui_story, var_172_19, var_172_18)

				local var_172_20 = manager.ui.mainCamera.transform.position - var_172_15.position

				var_172_15.forward = Vector3.New(var_172_20.x, var_172_20.y, var_172_20.z)

				local var_172_21 = var_172_15.localEulerAngles

				var_172_21.z = 0
				var_172_21.x = 0
				var_172_15.localEulerAngles = var_172_21
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				var_172_15.localPosition = Vector3.New(0, 100, 0)

				local var_172_22 = manager.ui.mainCamera.transform.position - var_172_15.position

				var_172_15.forward = Vector3.New(var_172_22.x, var_172_22.y, var_172_22.z)

				local var_172_23 = var_172_15.localEulerAngles

				var_172_23.z = 0
				var_172_23.x = 0
				var_172_15.localEulerAngles = var_172_23
			end

			local var_172_24 = arg_169_1.actors_["1076ui_story"]
			local var_172_25 = 0

			if var_172_25 < arg_169_1.time_ and arg_169_1.time_ <= var_172_25 + arg_172_0 and not isNil(var_172_24) and arg_169_1.var_.characterEffect1076ui_story == nil then
				arg_169_1.var_.characterEffect1076ui_story = var_172_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_26 = 0.200000002980232

			if var_172_25 <= arg_169_1.time_ and arg_169_1.time_ < var_172_25 + var_172_26 and not isNil(var_172_24) then
				local var_172_27 = (arg_169_1.time_ - var_172_25) / var_172_26

				if arg_169_1.var_.characterEffect1076ui_story and not isNil(var_172_24) then
					local var_172_28 = Mathf.Lerp(0, 0.5, var_172_27)

					arg_169_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1076ui_story.fillRatio = var_172_28
				end
			end

			if arg_169_1.time_ >= var_172_25 + var_172_26 and arg_169_1.time_ < var_172_25 + var_172_26 + arg_172_0 and not isNil(var_172_24) and arg_169_1.var_.characterEffect1076ui_story then
				local var_172_29 = 0.5

				arg_169_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1076ui_story.fillRatio = var_172_29
			end

			local var_172_30 = 0
			local var_172_31 = 0.975

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_32 = arg_169_1:GetWordFromCfg(121481042)
				local var_172_33 = arg_169_1:FormatText(var_172_32.content)

				arg_169_1.text_.text = var_172_33

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_34 = 39
				local var_172_35 = utf8.len(var_172_33)
				local var_172_36 = var_172_34 <= 0 and var_172_31 or var_172_31 * (var_172_35 / var_172_34)

				if var_172_36 > 0 and var_172_31 < var_172_36 then
					arg_169_1.talkMaxDuration = var_172_36

					if var_172_36 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_36 + var_172_30
					end
				end

				arg_169_1.text_.text = var_172_33
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_37 = math.max(var_172_31, arg_169_1.talkMaxDuration)

			if var_172_30 <= arg_169_1.time_ and arg_169_1.time_ < var_172_30 + var_172_37 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_30) / var_172_37

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_30 + var_172_37 and arg_169_1.time_ < var_172_30 + var_172_37 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play121481043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 121481043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play121481044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1072ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1072ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -0.71, -6)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1072ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1072ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1072ui_story == nil then
				arg_173_1.var_.characterEffect1072ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1072ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1072ui_story then
				arg_173_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_176_15 = 0
			local var_176_16 = 0.075

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[379].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(121481043)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 3
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481043", "story_v_out_121481.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_out_121481", "121481043", "story_v_out_121481.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_out_121481", "121481043", "story_v_out_121481.awb")

						arg_173_1:RecordAudio("121481043", var_176_24)
						arg_173_1:RecordAudio("121481043", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_121481", "121481043", "story_v_out_121481.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_121481", "121481043", "story_v_out_121481.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play121481044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 121481044
		arg_177_1.duration_ = 8

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play121481045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1072ui_story"].transform
			local var_180_1 = 1.96599999815226

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1072ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1072ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1072ui_story"]
			local var_180_10 = 1.96599999815226

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1072ui_story == nil then
				arg_177_1.var_.characterEffect1072ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.034000001847744

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1072ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1072ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1072ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1072ui_story.fillRatio = var_180_14
			end

			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_16 = 2

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_16 then
				local var_180_17 = (arg_177_1.time_ - var_180_15) / var_180_16
				local var_180_18 = Color.New(0, 0, 0)

				var_180_18.a = Mathf.Lerp(0, 1, var_180_17)
				arg_177_1.mask_.color = var_180_18
			end

			if arg_177_1.time_ >= var_180_15 + var_180_16 and arg_177_1.time_ < var_180_15 + var_180_16 + arg_180_0 then
				local var_180_19 = Color.New(0, 0, 0)

				var_180_19.a = 1
				arg_177_1.mask_.color = var_180_19
			end

			local var_180_20 = 2

			if var_180_20 < arg_177_1.time_ and arg_177_1.time_ <= var_180_20 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_21 = 2

			if var_180_20 <= arg_177_1.time_ and arg_177_1.time_ < var_180_20 + var_180_21 then
				local var_180_22 = (arg_177_1.time_ - var_180_20) / var_180_21
				local var_180_23 = Color.New(0, 0, 0)

				var_180_23.a = Mathf.Lerp(1, 0, var_180_22)
				arg_177_1.mask_.color = var_180_23
			end

			if arg_177_1.time_ >= var_180_20 + var_180_21 and arg_177_1.time_ < var_180_20 + var_180_21 + arg_180_0 then
				local var_180_24 = Color.New(0, 0, 0)
				local var_180_25 = 0

				arg_177_1.mask_.enabled = false
				var_180_24.a = var_180_25
				arg_177_1.mask_.color = var_180_24
			end

			local var_180_26 = "1071ui_story"

			if arg_177_1.actors_[var_180_26] == nil then
				local var_180_27 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_180_27) then
					local var_180_28 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_177_1.stage_.transform)

					var_180_28.name = var_180_26
					var_180_28.transform.localPosition = Vector3.New(0, 100, 0)
					arg_177_1.actors_[var_180_26] = var_180_28

					local var_180_29 = var_180_28:GetComponentInChildren(typeof(CharacterEffect))

					var_180_29.enabled = true

					local var_180_30 = GameObjectTools.GetOrAddComponent(var_180_28, typeof(DynamicBoneHelper))

					if var_180_30 then
						var_180_30:EnableDynamicBone(false)
					end

					arg_177_1:ShowWeapon(var_180_29.transform, false)

					arg_177_1.var_[var_180_26 .. "Animator"] = var_180_29.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_177_1.var_[var_180_26 .. "Animator"].applyRootMotion = true
					arg_177_1.var_[var_180_26 .. "LipSync"] = var_180_29.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_180_31 = 0

			if var_180_31 < arg_177_1.time_ and arg_177_1.time_ <= var_180_31 + arg_180_0 then
				arg_177_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_180_32 = 1.3
			local var_180_33 = 0.633333333333333

			if var_180_32 < arg_177_1.time_ and arg_177_1.time_ <= var_180_32 + arg_180_0 then
				local var_180_34 = "play"
				local var_180_35 = "effect"

				arg_177_1:AudioAction(var_180_34, var_180_35, "se_story_121_04", "se_story_121_04_door", "")
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_36 = 2.999999999999
			local var_180_37 = 1

			if var_180_36 < arg_177_1.time_ and arg_177_1.time_ <= var_180_36 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_38 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_38:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_39 = arg_177_1:GetWordFromCfg(121481044)
				local var_180_40 = arg_177_1:FormatText(var_180_39.content)

				arg_177_1.text_.text = var_180_40

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_41 = 40
				local var_180_42 = utf8.len(var_180_40)
				local var_180_43 = var_180_41 <= 0 and var_180_37 or var_180_37 * (var_180_42 / var_180_41)

				if var_180_43 > 0 and var_180_37 < var_180_43 then
					arg_177_1.talkMaxDuration = var_180_43
					var_180_36 = var_180_36 + 0.3

					if var_180_43 + var_180_36 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_43 + var_180_36
					end
				end

				arg_177_1.text_.text = var_180_40
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_44 = var_180_36 + 0.3
			local var_180_45 = math.max(var_180_37, arg_177_1.talkMaxDuration)

			if var_180_44 <= arg_177_1.time_ and arg_177_1.time_ < var_180_44 + var_180_45 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_44) / var_180_45

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_44 + var_180_45 and arg_177_1.time_ < var_180_44 + var_180_45 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play121481045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121481045
		arg_183_1.duration_ = 9.17

		local var_183_0 = {
			ja = 6.4,
			ko = 9.166,
			zh = 9.166
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
				arg_183_0:Play121481046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1071ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1071ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1071ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1071ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1071ui_story == nil then
				arg_183_1.var_.characterEffect1071ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1071ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1071ui_story then
				arg_183_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_186_14 = arg_183_1.actors_["1076ui_story"].transform
			local var_186_15 = 0

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.var_.moveOldPos1076ui_story = var_186_14.localPosition
			end

			local var_186_16 = 0.001

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_16 then
				local var_186_17 = (arg_183_1.time_ - var_186_15) / var_186_16
				local var_186_18 = Vector3.New(0.7, -1.06, -6.2)

				var_186_14.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1076ui_story, var_186_18, var_186_17)

				local var_186_19 = manager.ui.mainCamera.transform.position - var_186_14.position

				var_186_14.forward = Vector3.New(var_186_19.x, var_186_19.y, var_186_19.z)

				local var_186_20 = var_186_14.localEulerAngles

				var_186_20.z = 0
				var_186_20.x = 0
				var_186_14.localEulerAngles = var_186_20
			end

			if arg_183_1.time_ >= var_186_15 + var_186_16 and arg_183_1.time_ < var_186_15 + var_186_16 + arg_186_0 then
				var_186_14.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_186_21 = manager.ui.mainCamera.transform.position - var_186_14.position

				var_186_14.forward = Vector3.New(var_186_21.x, var_186_21.y, var_186_21.z)

				local var_186_22 = var_186_14.localEulerAngles

				var_186_22.z = 0
				var_186_22.x = 0
				var_186_14.localEulerAngles = var_186_22
			end

			local var_186_23 = arg_183_1.actors_["1076ui_story"]
			local var_186_24 = 0

			if var_186_24 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 and not isNil(var_186_23) and arg_183_1.var_.characterEffect1076ui_story == nil then
				arg_183_1.var_.characterEffect1076ui_story = var_186_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_25 = 0.200000002980232

			if var_186_24 <= arg_183_1.time_ and arg_183_1.time_ < var_186_24 + var_186_25 and not isNil(var_186_23) then
				local var_186_26 = (arg_183_1.time_ - var_186_24) / var_186_25

				if arg_183_1.var_.characterEffect1076ui_story and not isNil(var_186_23) then
					local var_186_27 = Mathf.Lerp(0, 0.5, var_186_26)

					arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1076ui_story.fillRatio = var_186_27
				end
			end

			if arg_183_1.time_ >= var_186_24 + var_186_25 and arg_183_1.time_ < var_186_24 + var_186_25 + arg_186_0 and not isNil(var_186_23) and arg_183_1.var_.characterEffect1076ui_story then
				local var_186_28 = 0.5

				arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1076ui_story.fillRatio = var_186_28
			end

			local var_186_29 = arg_183_1.actors_["1071ui_story"]
			local var_186_30 = 0

			if var_186_30 < arg_183_1.time_ and arg_183_1.time_ <= var_186_30 + arg_186_0 then
				if arg_183_1.var_.characterEffect1071ui_story == nil then
					arg_183_1.var_.characterEffect1071ui_story = var_186_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_186_31 = arg_183_1.var_.characterEffect1071ui_story

				var_186_31.imageEffect:turnOff()

				var_186_31.interferenceEffect.enabled = true
				var_186_31.interferenceEffect.noise = 0.001
				var_186_31.interferenceEffect.simTimeScale = 1
				var_186_31.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_186_32 = arg_183_1.actors_["1071ui_story"]
			local var_186_33 = 0
			local var_186_34 = 0.2

			if var_186_33 < arg_183_1.time_ and arg_183_1.time_ <= var_186_33 + arg_186_0 then
				if arg_183_1.var_.characterEffect1071ui_story == nil then
					arg_183_1.var_.characterEffect1071ui_story = var_186_32:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_183_1.var_.characterEffect1071ui_story.imageEffect:turnOn(false)
			end

			local var_186_35 = 0
			local var_186_36 = 0.775

			if var_186_35 < arg_183_1.time_ and arg_183_1.time_ <= var_186_35 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_37 = arg_183_1:FormatText(StoryNameCfg[384].name)

				arg_183_1.leftNameTxt_.text = var_186_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_38 = arg_183_1:GetWordFromCfg(121481045)
				local var_186_39 = arg_183_1:FormatText(var_186_38.content)

				arg_183_1.text_.text = var_186_39

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_40 = 31
				local var_186_41 = utf8.len(var_186_39)
				local var_186_42 = var_186_40 <= 0 and var_186_36 or var_186_36 * (var_186_41 / var_186_40)

				if var_186_42 > 0 and var_186_36 < var_186_42 then
					arg_183_1.talkMaxDuration = var_186_42

					if var_186_42 + var_186_35 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_42 + var_186_35
					end
				end

				arg_183_1.text_.text = var_186_39
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481045", "story_v_out_121481.awb") ~= 0 then
					local var_186_43 = manager.audio:GetVoiceLength("story_v_out_121481", "121481045", "story_v_out_121481.awb") / 1000

					if var_186_43 + var_186_35 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_43 + var_186_35
					end

					if var_186_38.prefab_name ~= "" and arg_183_1.actors_[var_186_38.prefab_name] ~= nil then
						local var_186_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_38.prefab_name].transform, "story_v_out_121481", "121481045", "story_v_out_121481.awb")

						arg_183_1:RecordAudio("121481045", var_186_44)
						arg_183_1:RecordAudio("121481045", var_186_44)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_121481", "121481045", "story_v_out_121481.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_121481", "121481045", "story_v_out_121481.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_45 = math.max(var_186_36, arg_183_1.talkMaxDuration)

			if var_186_35 <= arg_183_1.time_ and arg_183_1.time_ < var_186_35 + var_186_45 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_35) / var_186_45

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_35 + var_186_45 and arg_183_1.time_ < var_186_35 + var_186_45 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play121481046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121481046
		arg_187_1.duration_ = 9.17

		local var_187_0 = {
			ja = 9.166,
			ko = 4.666,
			zh = 4.666
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
				arg_187_0:Play121481047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1076ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1076ui_story == nil then
				arg_187_1.var_.characterEffect1076ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1076ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1076ui_story then
				arg_187_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["1071ui_story"]
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1071ui_story == nil then
				arg_187_1.var_.characterEffect1071ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 and not isNil(var_190_4) then
				local var_190_7 = (arg_187_1.time_ - var_190_5) / var_190_6

				if arg_187_1.var_.characterEffect1071ui_story and not isNil(var_190_4) then
					local var_190_8 = Mathf.Lerp(0, 0.5, var_190_7)

					arg_187_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1071ui_story.fillRatio = var_190_8
				end
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1071ui_story then
				local var_190_9 = 0.5

				arg_187_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1071ui_story.fillRatio = var_190_9
			end

			local var_190_10 = 0
			local var_190_11 = 0.4

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_12 = arg_187_1:FormatText(StoryNameCfg[389].name)

				arg_187_1.leftNameTxt_.text = var_190_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(121481046)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_15 = 16
				local var_190_16 = utf8.len(var_190_14)
				local var_190_17 = var_190_15 <= 0 and var_190_11 or var_190_11 * (var_190_16 / var_190_15)

				if var_190_17 > 0 and var_190_11 < var_190_17 then
					arg_187_1.talkMaxDuration = var_190_17

					if var_190_17 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_10
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481046", "story_v_out_121481.awb") ~= 0 then
					local var_190_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481046", "story_v_out_121481.awb") / 1000

					if var_190_18 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_10
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_121481", "121481046", "story_v_out_121481.awb")

						arg_187_1:RecordAudio("121481046", var_190_19)
						arg_187_1:RecordAudio("121481046", var_190_19)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121481", "121481046", "story_v_out_121481.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121481", "121481046", "story_v_out_121481.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = math.max(var_190_11, arg_187_1.talkMaxDuration)

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_10) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_10 + var_190_20 and arg_187_1.time_ < var_190_10 + var_190_20 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121481047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121481047
		arg_191_1.duration_ = 7.3

		local var_191_0 = {
			ja = 2.066,
			ko = 7.3,
			zh = 7.3
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
				arg_191_0:Play121481048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1076ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1076ui_story == nil then
				arg_191_1.var_.characterEffect1076ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1076ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1076ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1076ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1076ui_story.fillRatio = var_194_5
			end

			local var_194_6 = arg_191_1.actors_["1071ui_story"]
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect1071ui_story == nil then
				arg_191_1.var_.characterEffect1071ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_8 = 0.200000002980232

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 and not isNil(var_194_6) then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8

				if arg_191_1.var_.characterEffect1071ui_story and not isNil(var_194_6) then
					arg_191_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect1071ui_story then
				arg_191_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_194_10 = 0
			local var_194_11 = 0.475

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_12 = arg_191_1:FormatText(StoryNameCfg[384].name)

				arg_191_1.leftNameTxt_.text = var_194_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_13 = arg_191_1:GetWordFromCfg(121481047)
				local var_194_14 = arg_191_1:FormatText(var_194_13.content)

				arg_191_1.text_.text = var_194_14

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_15 = 19
				local var_194_16 = utf8.len(var_194_14)
				local var_194_17 = var_194_15 <= 0 and var_194_11 or var_194_11 * (var_194_16 / var_194_15)

				if var_194_17 > 0 and var_194_11 < var_194_17 then
					arg_191_1.talkMaxDuration = var_194_17

					if var_194_17 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_10
					end
				end

				arg_191_1.text_.text = var_194_14
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481047", "story_v_out_121481.awb") ~= 0 then
					local var_194_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481047", "story_v_out_121481.awb") / 1000

					if var_194_18 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_10
					end

					if var_194_13.prefab_name ~= "" and arg_191_1.actors_[var_194_13.prefab_name] ~= nil then
						local var_194_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_13.prefab_name].transform, "story_v_out_121481", "121481047", "story_v_out_121481.awb")

						arg_191_1:RecordAudio("121481047", var_194_19)
						arg_191_1:RecordAudio("121481047", var_194_19)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121481", "121481047", "story_v_out_121481.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121481", "121481047", "story_v_out_121481.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_20 = math.max(var_194_11, arg_191_1.talkMaxDuration)

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_10) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_10 + var_194_20 and arg_191_1.time_ < var_194_10 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121481048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121481048
		arg_195_1.duration_ = 4.97

		local var_195_0 = {
			ja = 4.966,
			ko = 3.133,
			zh = 3.133
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
				arg_195_0:Play121481049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1076ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1076ui_story == nil then
				arg_195_1.var_.characterEffect1076ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1076ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1076ui_story then
				arg_195_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_198_4 = arg_195_1.actors_["1071ui_story"]
			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1071ui_story == nil then
				arg_195_1.var_.characterEffect1071ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_6 and not isNil(var_198_4) then
				local var_198_7 = (arg_195_1.time_ - var_198_5) / var_198_6

				if arg_195_1.var_.characterEffect1071ui_story and not isNil(var_198_4) then
					local var_198_8 = Mathf.Lerp(0, 0.5, var_198_7)

					arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1071ui_story.fillRatio = var_198_8
				end
			end

			if arg_195_1.time_ >= var_198_5 + var_198_6 and arg_195_1.time_ < var_198_5 + var_198_6 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1071ui_story then
				local var_198_9 = 0.5

				arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1071ui_story.fillRatio = var_198_9
			end

			local var_198_10 = 0
			local var_198_11 = 0.3

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_12 = arg_195_1:FormatText(StoryNameCfg[389].name)

				arg_195_1.leftNameTxt_.text = var_198_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(121481048)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_15 = 12
				local var_198_16 = utf8.len(var_198_14)
				local var_198_17 = var_198_15 <= 0 and var_198_11 or var_198_11 * (var_198_16 / var_198_15)

				if var_198_17 > 0 and var_198_11 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17

					if var_198_17 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_10
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481048", "story_v_out_121481.awb") ~= 0 then
					local var_198_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481048", "story_v_out_121481.awb") / 1000

					if var_198_18 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_10
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_121481", "121481048", "story_v_out_121481.awb")

						arg_195_1:RecordAudio("121481048", var_198_19)
						arg_195_1:RecordAudio("121481048", var_198_19)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121481", "121481048", "story_v_out_121481.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121481", "121481048", "story_v_out_121481.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_11, arg_195_1.talkMaxDuration)

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_10) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_10 + var_198_20 and arg_195_1.time_ < var_198_10 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121481049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121481049
		arg_199_1.duration_ = 7.73

		local var_199_0 = {
			ja = 7.733,
			ko = 5.466,
			zh = 5.466
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
				arg_199_0:Play121481050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1071ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1071ui_story == nil then
				arg_199_1.var_.characterEffect1071ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1071ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1071ui_story then
				arg_199_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_202_5 = arg_199_1.actors_["1076ui_story"]
			local var_202_6 = 0

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1076ui_story == nil then
				arg_199_1.var_.characterEffect1076ui_story = var_202_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_7 = 0.200000002980232

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_7 and not isNil(var_202_5) then
				local var_202_8 = (arg_199_1.time_ - var_202_6) / var_202_7

				if arg_199_1.var_.characterEffect1076ui_story and not isNil(var_202_5) then
					local var_202_9 = Mathf.Lerp(0, 0.5, var_202_8)

					arg_199_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1076ui_story.fillRatio = var_202_9
				end
			end

			if arg_199_1.time_ >= var_202_6 + var_202_7 and arg_199_1.time_ < var_202_6 + var_202_7 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1076ui_story then
				local var_202_10 = 0.5

				arg_199_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1076ui_story.fillRatio = var_202_10
			end

			local var_202_11 = 0
			local var_202_12 = 0.625

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_13 = arg_199_1:FormatText(StoryNameCfg[384].name)

				arg_199_1.leftNameTxt_.text = var_202_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_14 = arg_199_1:GetWordFromCfg(121481049)
				local var_202_15 = arg_199_1:FormatText(var_202_14.content)

				arg_199_1.text_.text = var_202_15

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_16 = 25
				local var_202_17 = utf8.len(var_202_15)
				local var_202_18 = var_202_16 <= 0 and var_202_12 or var_202_12 * (var_202_17 / var_202_16)

				if var_202_18 > 0 and var_202_12 < var_202_18 then
					arg_199_1.talkMaxDuration = var_202_18

					if var_202_18 + var_202_11 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_11
					end
				end

				arg_199_1.text_.text = var_202_15
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481049", "story_v_out_121481.awb") ~= 0 then
					local var_202_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481049", "story_v_out_121481.awb") / 1000

					if var_202_19 + var_202_11 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_19 + var_202_11
					end

					if var_202_14.prefab_name ~= "" and arg_199_1.actors_[var_202_14.prefab_name] ~= nil then
						local var_202_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_14.prefab_name].transform, "story_v_out_121481", "121481049", "story_v_out_121481.awb")

						arg_199_1:RecordAudio("121481049", var_202_20)
						arg_199_1:RecordAudio("121481049", var_202_20)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121481", "121481049", "story_v_out_121481.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121481", "121481049", "story_v_out_121481.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_21 = math.max(var_202_12, arg_199_1.talkMaxDuration)

			if var_202_11 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_21 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_11) / var_202_21

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_11 + var_202_21 and arg_199_1.time_ < var_202_11 + var_202_21 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121481050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121481050
		arg_203_1.duration_ = 12.7

		local var_203_0 = {
			ja = 12.7,
			ko = 7.8,
			zh = 7.8
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
				arg_203_0:Play121481051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_206_1 = 0
			local var_206_2 = 1.025

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_3 = arg_203_1:FormatText(StoryNameCfg[384].name)

				arg_203_1.leftNameTxt_.text = var_206_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(121481050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 41
				local var_206_7 = utf8.len(var_206_5)
				local var_206_8 = var_206_6 <= 0 and var_206_2 or var_206_2 * (var_206_7 / var_206_6)

				if var_206_8 > 0 and var_206_2 < var_206_8 then
					arg_203_1.talkMaxDuration = var_206_8

					if var_206_8 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481050", "story_v_out_121481.awb") ~= 0 then
					local var_206_9 = manager.audio:GetVoiceLength("story_v_out_121481", "121481050", "story_v_out_121481.awb") / 1000

					if var_206_9 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_1
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_121481", "121481050", "story_v_out_121481.awb")

						arg_203_1:RecordAudio("121481050", var_206_10)
						arg_203_1:RecordAudio("121481050", var_206_10)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121481", "121481050", "story_v_out_121481.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121481", "121481050", "story_v_out_121481.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_11 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_11 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_11

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_11 and arg_203_1.time_ < var_206_1 + var_206_11 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121481051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121481051
		arg_207_1.duration_ = 11.9

		local var_207_0 = {
			ja = 11.9,
			ko = 8,
			zh = 8
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
				arg_207_0:Play121481052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.95

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[384].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(121481051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 38
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481051", "story_v_out_121481.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481051", "story_v_out_121481.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_121481", "121481051", "story_v_out_121481.awb")

						arg_207_1:RecordAudio("121481051", var_210_9)
						arg_207_1:RecordAudio("121481051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_121481", "121481051", "story_v_out_121481.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_121481", "121481051", "story_v_out_121481.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121481052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121481052
		arg_211_1.duration_ = 10.8

		local var_211_0 = {
			ja = 10.8,
			ko = 9.1,
			zh = 9.1
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
				arg_211_0:Play121481053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.025

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[384].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(121481052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 41
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481052", "story_v_out_121481.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481052", "story_v_out_121481.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_121481", "121481052", "story_v_out_121481.awb")

						arg_211_1:RecordAudio("121481052", var_214_9)
						arg_211_1:RecordAudio("121481052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_121481", "121481052", "story_v_out_121481.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_121481", "121481052", "story_v_out_121481.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play121481053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121481053
		arg_215_1.duration_ = 8.63

		local var_215_0 = {
			ja = 8.633,
			ko = 5.5,
			zh = 5.5
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
				arg_215_0:Play121481054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1076ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1076ui_story == nil then
				arg_215_1.var_.characterEffect1076ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1076ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1076ui_story then
				arg_215_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["1071ui_story"]
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1071ui_story == nil then
				arg_215_1.var_.characterEffect1071ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.200000002980232

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 and not isNil(var_218_4) then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6

				if arg_215_1.var_.characterEffect1071ui_story and not isNil(var_218_4) then
					local var_218_8 = Mathf.Lerp(0, 0.5, var_218_7)

					arg_215_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1071ui_story.fillRatio = var_218_8
				end
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1071ui_story then
				local var_218_9 = 0.5

				arg_215_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1071ui_story.fillRatio = var_218_9
			end

			local var_218_10 = 0
			local var_218_11 = 0.525

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_12 = arg_215_1:FormatText(StoryNameCfg[389].name)

				arg_215_1.leftNameTxt_.text = var_218_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_13 = arg_215_1:GetWordFromCfg(121481053)
				local var_218_14 = arg_215_1:FormatText(var_218_13.content)

				arg_215_1.text_.text = var_218_14

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_15 = 20
				local var_218_16 = utf8.len(var_218_14)
				local var_218_17 = var_218_15 <= 0 and var_218_11 or var_218_11 * (var_218_16 / var_218_15)

				if var_218_17 > 0 and var_218_11 < var_218_17 then
					arg_215_1.talkMaxDuration = var_218_17

					if var_218_17 + var_218_10 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_17 + var_218_10
					end
				end

				arg_215_1.text_.text = var_218_14
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481053", "story_v_out_121481.awb") ~= 0 then
					local var_218_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481053", "story_v_out_121481.awb") / 1000

					if var_218_18 + var_218_10 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_10
					end

					if var_218_13.prefab_name ~= "" and arg_215_1.actors_[var_218_13.prefab_name] ~= nil then
						local var_218_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_13.prefab_name].transform, "story_v_out_121481", "121481053", "story_v_out_121481.awb")

						arg_215_1:RecordAudio("121481053", var_218_19)
						arg_215_1:RecordAudio("121481053", var_218_19)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_121481", "121481053", "story_v_out_121481.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_121481", "121481053", "story_v_out_121481.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_20 = math.max(var_218_11, arg_215_1.talkMaxDuration)

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_20 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_10) / var_218_20

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_10 + var_218_20 and arg_215_1.time_ < var_218_10 + var_218_20 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play121481054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 121481054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play121481055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1076ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1076ui_story == nil then
				arg_219_1.var_.characterEffect1076ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1076ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1076ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1076ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1076ui_story.fillRatio = var_222_5
			end

			local var_222_6 = 0
			local var_222_7 = 0.7

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(121481054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_10 = 28
				local var_222_11 = utf8.len(var_222_9)
				local var_222_12 = var_222_10 <= 0 and var_222_7 or var_222_7 * (var_222_11 / var_222_10)

				if var_222_12 > 0 and var_222_7 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_13 and arg_219_1.time_ < var_222_6 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play121481055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121481055
		arg_223_1.duration_ = 6.1

		local var_223_0 = {
			ja = 6.1,
			ko = 5.5,
			zh = 5.5
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
				arg_223_0:Play121481056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1076ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1076ui_story == nil then
				arg_223_1.var_.characterEffect1076ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1076ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1076ui_story then
				arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_226_4 = 0

			if var_226_4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action3_1")
			end

			local var_226_5 = 0

			if var_226_5 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_226_6 = 0
			local var_226_7 = 0.525

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[389].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_9 = arg_223_1:GetWordFromCfg(121481055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 21
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481055", "story_v_out_121481.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_121481", "121481055", "story_v_out_121481.awb") / 1000

					if var_226_14 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_6
					end

					if var_226_9.prefab_name ~= "" and arg_223_1.actors_[var_226_9.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_9.prefab_name].transform, "story_v_out_121481", "121481055", "story_v_out_121481.awb")

						arg_223_1:RecordAudio("121481055", var_226_15)
						arg_223_1:RecordAudio("121481055", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_121481", "121481055", "story_v_out_121481.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_121481", "121481055", "story_v_out_121481.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_16 and arg_223_1.time_ < var_226_6 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play121481056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121481056
		arg_227_1.duration_ = 11.9

		local var_227_0 = {
			ja = 10.566,
			ko = 11.9,
			zh = 11.9
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
				arg_227_0:Play121481057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1071ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1071ui_story == nil then
				arg_227_1.var_.characterEffect1071ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1071ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1071ui_story then
				arg_227_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_230_5 = arg_227_1.actors_["1076ui_story"]
			local var_230_6 = 0

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1076ui_story == nil then
				arg_227_1.var_.characterEffect1076ui_story = var_230_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_7 = 0.200000002980232

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_7 and not isNil(var_230_5) then
				local var_230_8 = (arg_227_1.time_ - var_230_6) / var_230_7

				if arg_227_1.var_.characterEffect1076ui_story and not isNil(var_230_5) then
					local var_230_9 = Mathf.Lerp(0, 0.5, var_230_8)

					arg_227_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1076ui_story.fillRatio = var_230_9
				end
			end

			if arg_227_1.time_ >= var_230_6 + var_230_7 and arg_227_1.time_ < var_230_6 + var_230_7 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1076ui_story then
				local var_230_10 = 0.5

				arg_227_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1076ui_story.fillRatio = var_230_10
			end

			local var_230_11 = 0
			local var_230_12 = 1

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_13 = arg_227_1:FormatText(StoryNameCfg[384].name)

				arg_227_1.leftNameTxt_.text = var_230_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_14 = arg_227_1:GetWordFromCfg(121481056)
				local var_230_15 = arg_227_1:FormatText(var_230_14.content)

				arg_227_1.text_.text = var_230_15

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 40
				local var_230_17 = utf8.len(var_230_15)
				local var_230_18 = var_230_16 <= 0 and var_230_12 or var_230_12 * (var_230_17 / var_230_16)

				if var_230_18 > 0 and var_230_12 < var_230_18 then
					arg_227_1.talkMaxDuration = var_230_18

					if var_230_18 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_18 + var_230_11
					end
				end

				arg_227_1.text_.text = var_230_15
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481056", "story_v_out_121481.awb") ~= 0 then
					local var_230_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481056", "story_v_out_121481.awb") / 1000

					if var_230_19 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_11
					end

					if var_230_14.prefab_name ~= "" and arg_227_1.actors_[var_230_14.prefab_name] ~= nil then
						local var_230_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_14.prefab_name].transform, "story_v_out_121481", "121481056", "story_v_out_121481.awb")

						arg_227_1:RecordAudio("121481056", var_230_20)
						arg_227_1:RecordAudio("121481056", var_230_20)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_121481", "121481056", "story_v_out_121481.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_121481", "121481056", "story_v_out_121481.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_21 = math.max(var_230_12, arg_227_1.talkMaxDuration)

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_21 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_11) / var_230_21

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_11 + var_230_21 and arg_227_1.time_ < var_230_11 + var_230_21 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play121481057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121481057
		arg_231_1.duration_ = 3.9

		local var_231_0 = {
			ja = 3.9,
			ko = 3.1,
			zh = 3.1
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
				arg_231_0:Play121481058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1076ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1076ui_story == nil then
				arg_231_1.var_.characterEffect1076ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1076ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1076ui_story then
				arg_231_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["1071ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1071ui_story == nil then
				arg_231_1.var_.characterEffect1071ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect1071ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1071ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1071ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1071ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action3_2")
			end

			local var_234_11 = 0
			local var_234_12 = 0.325

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_13 = arg_231_1:FormatText(StoryNameCfg[389].name)

				arg_231_1.leftNameTxt_.text = var_234_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_14 = arg_231_1:GetWordFromCfg(121481057)
				local var_234_15 = arg_231_1:FormatText(var_234_14.content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_16 = 13
				local var_234_17 = utf8.len(var_234_15)
				local var_234_18 = var_234_16 <= 0 and var_234_12 or var_234_12 * (var_234_17 / var_234_16)

				if var_234_18 > 0 and var_234_12 < var_234_18 then
					arg_231_1.talkMaxDuration = var_234_18

					if var_234_18 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_18 + var_234_11
					end
				end

				arg_231_1.text_.text = var_234_15
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481057", "story_v_out_121481.awb") ~= 0 then
					local var_234_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481057", "story_v_out_121481.awb") / 1000

					if var_234_19 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_11
					end

					if var_234_14.prefab_name ~= "" and arg_231_1.actors_[var_234_14.prefab_name] ~= nil then
						local var_234_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_14.prefab_name].transform, "story_v_out_121481", "121481057", "story_v_out_121481.awb")

						arg_231_1:RecordAudio("121481057", var_234_20)
						arg_231_1:RecordAudio("121481057", var_234_20)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121481", "121481057", "story_v_out_121481.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121481", "121481057", "story_v_out_121481.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_21 = math.max(var_234_12, arg_231_1.talkMaxDuration)

			if var_234_11 <= arg_231_1.time_ and arg_231_1.time_ < var_234_11 + var_234_21 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_11) / var_234_21

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_11 + var_234_21 and arg_231_1.time_ < var_234_11 + var_234_21 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play121481058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121481058
		arg_235_1.duration_ = 12.57

		local var_235_0 = {
			ja = 12.566,
			ko = 9.366,
			zh = 9.366
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
				arg_235_0:Play121481059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1071ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1071ui_story == nil then
				arg_235_1.var_.characterEffect1071ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1071ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1071ui_story then
				arg_235_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_238_4 = 0

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_2")
			end

			local var_238_5 = arg_235_1.actors_["1076ui_story"]
			local var_238_6 = 0

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1076ui_story == nil then
				arg_235_1.var_.characterEffect1076ui_story = var_238_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_7 = 0.200000002980232

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_7 and not isNil(var_238_5) then
				local var_238_8 = (arg_235_1.time_ - var_238_6) / var_238_7

				if arg_235_1.var_.characterEffect1076ui_story and not isNil(var_238_5) then
					local var_238_9 = Mathf.Lerp(0, 0.5, var_238_8)

					arg_235_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1076ui_story.fillRatio = var_238_9
				end
			end

			if arg_235_1.time_ >= var_238_6 + var_238_7 and arg_235_1.time_ < var_238_6 + var_238_7 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1076ui_story then
				local var_238_10 = 0.5

				arg_235_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1076ui_story.fillRatio = var_238_10
			end

			local var_238_11 = 0
			local var_238_12 = 1.125

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_13 = arg_235_1:FormatText(StoryNameCfg[384].name)

				arg_235_1.leftNameTxt_.text = var_238_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:GetWordFromCfg(121481058)
				local var_238_15 = arg_235_1:FormatText(var_238_14.content)

				arg_235_1.text_.text = var_238_15

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 45
				local var_238_17 = utf8.len(var_238_15)
				local var_238_18 = var_238_16 <= 0 and var_238_12 or var_238_12 * (var_238_17 / var_238_16)

				if var_238_18 > 0 and var_238_12 < var_238_18 then
					arg_235_1.talkMaxDuration = var_238_18

					if var_238_18 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_15
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481058", "story_v_out_121481.awb") ~= 0 then
					local var_238_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481058", "story_v_out_121481.awb") / 1000

					if var_238_19 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_19 + var_238_11
					end

					if var_238_14.prefab_name ~= "" and arg_235_1.actors_[var_238_14.prefab_name] ~= nil then
						local var_238_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_14.prefab_name].transform, "story_v_out_121481", "121481058", "story_v_out_121481.awb")

						arg_235_1:RecordAudio("121481058", var_238_20)
						arg_235_1:RecordAudio("121481058", var_238_20)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_121481", "121481058", "story_v_out_121481.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_121481", "121481058", "story_v_out_121481.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_21 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_21 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_11) / var_238_21

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_21 and arg_235_1.time_ < var_238_11 + var_238_21 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play121481059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 121481059
		arg_239_1.duration_ = 7.33

		local var_239_0 = {
			ja = 7.333,
			ko = 6.866,
			zh = 6.866
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
				arg_239_0:Play121481060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1071ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1071ui_story == nil then
				arg_239_1.var_.characterEffect1071ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1071ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1071ui_story then
				arg_239_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_242_4 = 0

			if var_242_4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_242_5 = 0
			local var_242_6 = 0.725

			if var_242_5 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_7 = arg_239_1:FormatText(StoryNameCfg[384].name)

				arg_239_1.leftNameTxt_.text = var_242_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(121481059)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 29
				local var_242_11 = utf8.len(var_242_9)
				local var_242_12 = var_242_10 <= 0 and var_242_6 or var_242_6 * (var_242_11 / var_242_10)

				if var_242_12 > 0 and var_242_6 < var_242_12 then
					arg_239_1.talkMaxDuration = var_242_12

					if var_242_12 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481059", "story_v_out_121481.awb") ~= 0 then
					local var_242_13 = manager.audio:GetVoiceLength("story_v_out_121481", "121481059", "story_v_out_121481.awb") / 1000

					if var_242_13 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_5
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_121481", "121481059", "story_v_out_121481.awb")

						arg_239_1:RecordAudio("121481059", var_242_14)
						arg_239_1:RecordAudio("121481059", var_242_14)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_121481", "121481059", "story_v_out_121481.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_121481", "121481059", "story_v_out_121481.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_15 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_15 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_15

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_15 and arg_239_1.time_ < var_242_5 + var_242_15 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play121481060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 121481060
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play121481061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = "ST31"

			if arg_243_1.bgs_[var_246_0] == nil then
				local var_246_1 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_0)
				var_246_1.name = var_246_0
				var_246_1.transform.parent = arg_243_1.stage_.transform
				var_246_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_0] = var_246_1
			end

			local var_246_2 = 2

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				local var_246_3 = manager.ui.mainCamera.transform.localPosition
				local var_246_4 = Vector3.New(0, 0, 10) + Vector3.New(var_246_3.x, var_246_3.y, 0)
				local var_246_5 = arg_243_1.bgs_.ST31

				var_246_5.transform.localPosition = var_246_4
				var_246_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_6 = var_246_5:GetComponent("SpriteRenderer")

				if var_246_6 and var_246_6.sprite then
					local var_246_7 = (var_246_5.transform.localPosition - var_246_3).z
					local var_246_8 = manager.ui.mainCameraCom_
					local var_246_9 = 2 * var_246_7 * Mathf.Tan(var_246_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_10 = var_246_9 * var_246_8.aspect
					local var_246_11 = var_246_6.sprite.bounds.size.x
					local var_246_12 = var_246_6.sprite.bounds.size.y
					local var_246_13 = var_246_10 / var_246_11
					local var_246_14 = var_246_9 / var_246_12
					local var_246_15 = var_246_14 < var_246_13 and var_246_13 or var_246_14

					var_246_5.transform.localScale = Vector3.New(var_246_15, var_246_15, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST31" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_16 = 0

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_17 = 2

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 then
				local var_246_18 = (arg_243_1.time_ - var_246_16) / var_246_17
				local var_246_19 = Color.New(0, 0, 0)

				var_246_19.a = Mathf.Lerp(0, 1, var_246_18)
				arg_243_1.mask_.color = var_246_19
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				local var_246_20 = Color.New(0, 0, 0)

				var_246_20.a = 1
				arg_243_1.mask_.color = var_246_20
			end

			local var_246_21 = 2

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_22 = 2

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_22 then
				local var_246_23 = (arg_243_1.time_ - var_246_21) / var_246_22
				local var_246_24 = Color.New(0, 0, 0)

				var_246_24.a = Mathf.Lerp(1, 0, var_246_23)
				arg_243_1.mask_.color = var_246_24
			end

			if arg_243_1.time_ >= var_246_21 + var_246_22 and arg_243_1.time_ < var_246_21 + var_246_22 + arg_246_0 then
				local var_246_25 = Color.New(0, 0, 0)
				local var_246_26 = 0

				arg_243_1.mask_.enabled = false
				var_246_25.a = var_246_26
				arg_243_1.mask_.color = var_246_25
			end

			local var_246_27 = arg_243_1.actors_["1071ui_story"].transform
			local var_246_28 = 1.96599999815226

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1.var_.moveOldPos1071ui_story = var_246_27.localPosition
			end

			local var_246_29 = 0.001

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_29 then
				local var_246_30 = (arg_243_1.time_ - var_246_28) / var_246_29
				local var_246_31 = Vector3.New(0, 100, 0)

				var_246_27.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1071ui_story, var_246_31, var_246_30)

				local var_246_32 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_32.x, var_246_32.y, var_246_32.z)

				local var_246_33 = var_246_27.localEulerAngles

				var_246_33.z = 0
				var_246_33.x = 0
				var_246_27.localEulerAngles = var_246_33
			end

			if arg_243_1.time_ >= var_246_28 + var_246_29 and arg_243_1.time_ < var_246_28 + var_246_29 + arg_246_0 then
				var_246_27.localPosition = Vector3.New(0, 100, 0)

				local var_246_34 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_34.x, var_246_34.y, var_246_34.z)

				local var_246_35 = var_246_27.localEulerAngles

				var_246_35.z = 0
				var_246_35.x = 0
				var_246_27.localEulerAngles = var_246_35
			end

			local var_246_36 = arg_243_1.actors_["1071ui_story"]
			local var_246_37 = 1.96599999815226

			if var_246_37 < arg_243_1.time_ and arg_243_1.time_ <= var_246_37 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1071ui_story == nil then
				arg_243_1.var_.characterEffect1071ui_story = var_246_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_38 = 0.034000001847744

			if var_246_37 <= arg_243_1.time_ and arg_243_1.time_ < var_246_37 + var_246_38 and not isNil(var_246_36) then
				local var_246_39 = (arg_243_1.time_ - var_246_37) / var_246_38

				if arg_243_1.var_.characterEffect1071ui_story and not isNil(var_246_36) then
					local var_246_40 = Mathf.Lerp(0, 0.5, var_246_39)

					arg_243_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1071ui_story.fillRatio = var_246_40
				end
			end

			if arg_243_1.time_ >= var_246_37 + var_246_38 and arg_243_1.time_ < var_246_37 + var_246_38 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1071ui_story then
				local var_246_41 = 0.5

				arg_243_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1071ui_story.fillRatio = var_246_41
			end

			local var_246_42 = arg_243_1.actors_["1076ui_story"].transform
			local var_246_43 = 1.96599999815226

			if var_246_43 < arg_243_1.time_ and arg_243_1.time_ <= var_246_43 + arg_246_0 then
				arg_243_1.var_.moveOldPos1076ui_story = var_246_42.localPosition
			end

			local var_246_44 = 0.001

			if var_246_43 <= arg_243_1.time_ and arg_243_1.time_ < var_246_43 + var_246_44 then
				local var_246_45 = (arg_243_1.time_ - var_246_43) / var_246_44
				local var_246_46 = Vector3.New(0, 100, 0)

				var_246_42.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1076ui_story, var_246_46, var_246_45)

				local var_246_47 = manager.ui.mainCamera.transform.position - var_246_42.position

				var_246_42.forward = Vector3.New(var_246_47.x, var_246_47.y, var_246_47.z)

				local var_246_48 = var_246_42.localEulerAngles

				var_246_48.z = 0
				var_246_48.x = 0
				var_246_42.localEulerAngles = var_246_48
			end

			if arg_243_1.time_ >= var_246_43 + var_246_44 and arg_243_1.time_ < var_246_43 + var_246_44 + arg_246_0 then
				var_246_42.localPosition = Vector3.New(0, 100, 0)

				local var_246_49 = manager.ui.mainCamera.transform.position - var_246_42.position

				var_246_42.forward = Vector3.New(var_246_49.x, var_246_49.y, var_246_49.z)

				local var_246_50 = var_246_42.localEulerAngles

				var_246_50.z = 0
				var_246_50.x = 0
				var_246_42.localEulerAngles = var_246_50
			end

			local var_246_51 = arg_243_1.actors_["1076ui_story"]
			local var_246_52 = 1.96599999815226

			if var_246_52 < arg_243_1.time_ and arg_243_1.time_ <= var_246_52 + arg_246_0 and not isNil(var_246_51) and arg_243_1.var_.characterEffect1076ui_story == nil then
				arg_243_1.var_.characterEffect1076ui_story = var_246_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_53 = 0.034000001847744

			if var_246_52 <= arg_243_1.time_ and arg_243_1.time_ < var_246_52 + var_246_53 and not isNil(var_246_51) then
				local var_246_54 = (arg_243_1.time_ - var_246_52) / var_246_53

				if arg_243_1.var_.characterEffect1076ui_story and not isNil(var_246_51) then
					local var_246_55 = Mathf.Lerp(0, 0.5, var_246_54)

					arg_243_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1076ui_story.fillRatio = var_246_55
				end
			end

			if arg_243_1.time_ >= var_246_52 + var_246_53 and arg_243_1.time_ < var_246_52 + var_246_53 + arg_246_0 and not isNil(var_246_51) and arg_243_1.var_.characterEffect1076ui_story then
				local var_246_56 = 0.5

				arg_243_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1076ui_story.fillRatio = var_246_56
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_57 = 4
			local var_246_58 = 0.75

			if var_246_57 < arg_243_1.time_ and arg_243_1.time_ <= var_246_57 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_59 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_59:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_60 = arg_243_1:GetWordFromCfg(121481060)
				local var_246_61 = arg_243_1:FormatText(var_246_60.content)

				arg_243_1.text_.text = var_246_61

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_62 = 30
				local var_246_63 = utf8.len(var_246_61)
				local var_246_64 = var_246_62 <= 0 and var_246_58 or var_246_58 * (var_246_63 / var_246_62)

				if var_246_64 > 0 and var_246_58 < var_246_64 then
					arg_243_1.talkMaxDuration = var_246_64
					var_246_57 = var_246_57 + 0.3

					if var_246_64 + var_246_57 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_64 + var_246_57
					end
				end

				arg_243_1.text_.text = var_246_61
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_65 = var_246_57 + 0.3
			local var_246_66 = math.max(var_246_58, arg_243_1.talkMaxDuration)

			if var_246_65 <= arg_243_1.time_ and arg_243_1.time_ < var_246_65 + var_246_66 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_65) / var_246_66

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_65 + var_246_66 and arg_243_1.time_ < var_246_65 + var_246_66 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play121481061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 121481061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play121481062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(121481061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 40
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play121481062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 121481062
		arg_253_1.duration_ = 3.97

		local var_253_0 = {
			ja = 3.966,
			ko = 3.366,
			zh = 3.366
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play121481063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = "1084ui_story"

			if arg_253_1.actors_[var_256_0] == nil then
				local var_256_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_256_1) then
					local var_256_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_253_1.stage_.transform)

					var_256_2.name = var_256_0
					var_256_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_253_1.actors_[var_256_0] = var_256_2

					local var_256_3 = var_256_2:GetComponentInChildren(typeof(CharacterEffect))

					var_256_3.enabled = true

					local var_256_4 = GameObjectTools.GetOrAddComponent(var_256_2, typeof(DynamicBoneHelper))

					if var_256_4 then
						var_256_4:EnableDynamicBone(false)
					end

					arg_253_1:ShowWeapon(var_256_3.transform, false)

					arg_253_1.var_[var_256_0 .. "Animator"] = var_256_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_253_1.var_[var_256_0 .. "Animator"].applyRootMotion = true
					arg_253_1.var_[var_256_0 .. "LipSync"] = var_256_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_256_5 = arg_253_1.actors_["1084ui_story"].transform
			local var_256_6 = 0

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.var_.moveOldPos1084ui_story = var_256_5.localPosition
			end

			local var_256_7 = 0.001

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_7 then
				local var_256_8 = (arg_253_1.time_ - var_256_6) / var_256_7
				local var_256_9 = Vector3.New(0, -0.97, -6)

				var_256_5.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1084ui_story, var_256_9, var_256_8)

				local var_256_10 = manager.ui.mainCamera.transform.position - var_256_5.position

				var_256_5.forward = Vector3.New(var_256_10.x, var_256_10.y, var_256_10.z)

				local var_256_11 = var_256_5.localEulerAngles

				var_256_11.z = 0
				var_256_11.x = 0
				var_256_5.localEulerAngles = var_256_11
			end

			if arg_253_1.time_ >= var_256_6 + var_256_7 and arg_253_1.time_ < var_256_6 + var_256_7 + arg_256_0 then
				var_256_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_256_12 = manager.ui.mainCamera.transform.position - var_256_5.position

				var_256_5.forward = Vector3.New(var_256_12.x, var_256_12.y, var_256_12.z)

				local var_256_13 = var_256_5.localEulerAngles

				var_256_13.z = 0
				var_256_13.x = 0
				var_256_5.localEulerAngles = var_256_13
			end

			local var_256_14 = arg_253_1.actors_["1084ui_story"]
			local var_256_15 = 0

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 and not isNil(var_256_14) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = var_256_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_16 = 0.200000002980232

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_16 and not isNil(var_256_14) then
				local var_256_17 = (arg_253_1.time_ - var_256_15) / var_256_16

				if arg_253_1.var_.characterEffect1084ui_story and not isNil(var_256_14) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_15 + var_256_16 and arg_253_1.time_ < var_256_15 + var_256_16 + arg_256_0 and not isNil(var_256_14) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_256_18 = 0

			if var_256_18 < arg_253_1.time_ and arg_253_1.time_ <= var_256_18 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_20 = 0
			local var_256_21 = 0.375

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_22 = arg_253_1:FormatText(StoryNameCfg[6].name)

				arg_253_1.leftNameTxt_.text = var_256_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_23 = arg_253_1:GetWordFromCfg(121481062)
				local var_256_24 = arg_253_1:FormatText(var_256_23.content)

				arg_253_1.text_.text = var_256_24

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_25 = 15
				local var_256_26 = utf8.len(var_256_24)
				local var_256_27 = var_256_25 <= 0 and var_256_21 or var_256_21 * (var_256_26 / var_256_25)

				if var_256_27 > 0 and var_256_21 < var_256_27 then
					arg_253_1.talkMaxDuration = var_256_27

					if var_256_27 + var_256_20 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_27 + var_256_20
					end
				end

				arg_253_1.text_.text = var_256_24
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481062", "story_v_out_121481.awb") ~= 0 then
					local var_256_28 = manager.audio:GetVoiceLength("story_v_out_121481", "121481062", "story_v_out_121481.awb") / 1000

					if var_256_28 + var_256_20 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_20
					end

					if var_256_23.prefab_name ~= "" and arg_253_1.actors_[var_256_23.prefab_name] ~= nil then
						local var_256_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_23.prefab_name].transform, "story_v_out_121481", "121481062", "story_v_out_121481.awb")

						arg_253_1:RecordAudio("121481062", var_256_29)
						arg_253_1:RecordAudio("121481062", var_256_29)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_121481", "121481062", "story_v_out_121481.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_121481", "121481062", "story_v_out_121481.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_30 = math.max(var_256_21, arg_253_1.talkMaxDuration)

			if var_256_20 <= arg_253_1.time_ and arg_253_1.time_ < var_256_20 + var_256_30 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_20) / var_256_30

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_20 + var_256_30 and arg_253_1.time_ < var_256_20 + var_256_30 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play121481063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121481063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play121481064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1084ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1084ui_story and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1084ui_story.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1084ui_story.fillRatio = var_260_5
			end

			local var_260_6 = 0
			local var_260_7 = 0.125

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_9 = arg_257_1:GetWordFromCfg(121481063)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 5
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play121481064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 121481064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play121481065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.85

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(121481064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 34
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play121481065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 121481065
		arg_265_1.duration_ = 3.5

		local var_265_0 = {
			ja = 3.4,
			ko = 3.5,
			zh = 3.5
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play121481066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1084ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_268_6 = 0
			local var_268_7 = 0.35

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:GetWordFromCfg(121481065)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 14
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481065", "story_v_out_121481.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_121481", "121481065", "story_v_out_121481.awb") / 1000

					if var_268_14 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_6
					end

					if var_268_9.prefab_name ~= "" and arg_265_1.actors_[var_268_9.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_9.prefab_name].transform, "story_v_out_121481", "121481065", "story_v_out_121481.awb")

						arg_265_1:RecordAudio("121481065", var_268_15)
						arg_265_1:RecordAudio("121481065", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_121481", "121481065", "story_v_out_121481.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_121481", "121481065", "story_v_out_121481.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_16 and arg_265_1.time_ < var_268_6 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play121481066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 121481066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play121481067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1084ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1084ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1084ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1084ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_9) then
					local var_272_13 = Mathf.Lerp(0, 0.5, var_272_12)

					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_13
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1084ui_story then
				local var_272_14 = 0.5

				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_14
			end

			local var_272_15 = 0
			local var_272_16 = 0.9

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_17 = arg_269_1:GetWordFromCfg(121481066)
				local var_272_18 = arg_269_1:FormatText(var_272_17.content)

				arg_269_1.text_.text = var_272_18

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_19 = 36
				local var_272_20 = utf8.len(var_272_18)
				local var_272_21 = var_272_19 <= 0 and var_272_16 or var_272_16 * (var_272_20 / var_272_19)

				if var_272_21 > 0 and var_272_16 < var_272_21 then
					arg_269_1.talkMaxDuration = var_272_21

					if var_272_21 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_21 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_18
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_22 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_22 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_22

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_22 and arg_269_1.time_ < var_272_15 + var_272_22 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play121481067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 121481067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play121481068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 1.025

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_2 = arg_273_1:GetWordFromCfg(121481067)
				local var_276_3 = arg_273_1:FormatText(var_276_2.content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 41
				local var_276_5 = utf8.len(var_276_3)
				local var_276_6 = var_276_4 <= 0 and var_276_1 or var_276_1 * (var_276_5 / var_276_4)

				if var_276_6 > 0 and var_276_1 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_7 and arg_273_1.time_ < var_276_0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play121481068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 121481068
		arg_277_1.duration_ = 3.37

		local var_277_0 = {
			ja = 3.366,
			ko = 3.166,
			zh = 3.166
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play121481069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = "1069ui_story"

			if arg_277_1.actors_[var_280_0] == nil then
				local var_280_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_280_1) then
					local var_280_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_277_1.stage_.transform)

					var_280_2.name = var_280_0
					var_280_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_277_1.actors_[var_280_0] = var_280_2

					local var_280_3 = var_280_2:GetComponentInChildren(typeof(CharacterEffect))

					var_280_3.enabled = true

					local var_280_4 = GameObjectTools.GetOrAddComponent(var_280_2, typeof(DynamicBoneHelper))

					if var_280_4 then
						var_280_4:EnableDynamicBone(false)
					end

					arg_277_1:ShowWeapon(var_280_3.transform, false)

					arg_277_1.var_[var_280_0 .. "Animator"] = var_280_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_277_1.var_[var_280_0 .. "Animator"].applyRootMotion = true
					arg_277_1.var_[var_280_0 .. "LipSync"] = var_280_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_280_5 = arg_277_1.actors_["1069ui_story"].transform
			local var_280_6 = 0

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.var_.moveOldPos1069ui_story = var_280_5.localPosition
			end

			local var_280_7 = 0.001

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_7 then
				local var_280_8 = (arg_277_1.time_ - var_280_6) / var_280_7
				local var_280_9 = Vector3.New(-0.7, -1, -6)

				var_280_5.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1069ui_story, var_280_9, var_280_8)

				local var_280_10 = manager.ui.mainCamera.transform.position - var_280_5.position

				var_280_5.forward = Vector3.New(var_280_10.x, var_280_10.y, var_280_10.z)

				local var_280_11 = var_280_5.localEulerAngles

				var_280_11.z = 0
				var_280_11.x = 0
				var_280_5.localEulerAngles = var_280_11
			end

			if arg_277_1.time_ >= var_280_6 + var_280_7 and arg_277_1.time_ < var_280_6 + var_280_7 + arg_280_0 then
				var_280_5.localPosition = Vector3.New(-0.7, -1, -6)

				local var_280_12 = manager.ui.mainCamera.transform.position - var_280_5.position

				var_280_5.forward = Vector3.New(var_280_12.x, var_280_12.y, var_280_12.z)

				local var_280_13 = var_280_5.localEulerAngles

				var_280_13.z = 0
				var_280_13.x = 0
				var_280_5.localEulerAngles = var_280_13
			end

			local var_280_14 = arg_277_1.actors_["1069ui_story"]
			local var_280_15 = 0

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.characterEffect1069ui_story == nil then
				arg_277_1.var_.characterEffect1069ui_story = var_280_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_16 = 0.200000002980232

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_16 and not isNil(var_280_14) then
				local var_280_17 = (arg_277_1.time_ - var_280_15) / var_280_16

				if arg_277_1.var_.characterEffect1069ui_story and not isNil(var_280_14) then
					arg_277_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_15 + var_280_16 and arg_277_1.time_ < var_280_15 + var_280_16 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.characterEffect1069ui_story then
				arg_277_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_280_18 = 0

			if var_280_18 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_20 = arg_277_1.actors_["1084ui_story"].transform
			local var_280_21 = 0

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.var_.moveOldPos1084ui_story = var_280_20.localPosition
			end

			local var_280_22 = 0.001

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_22 then
				local var_280_23 = (arg_277_1.time_ - var_280_21) / var_280_22
				local var_280_24 = Vector3.New(0.7, -0.97, -6)

				var_280_20.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1084ui_story, var_280_24, var_280_23)

				local var_280_25 = manager.ui.mainCamera.transform.position - var_280_20.position

				var_280_20.forward = Vector3.New(var_280_25.x, var_280_25.y, var_280_25.z)

				local var_280_26 = var_280_20.localEulerAngles

				var_280_26.z = 0
				var_280_26.x = 0
				var_280_20.localEulerAngles = var_280_26
			end

			if arg_277_1.time_ >= var_280_21 + var_280_22 and arg_277_1.time_ < var_280_21 + var_280_22 + arg_280_0 then
				var_280_20.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_280_27 = manager.ui.mainCamera.transform.position - var_280_20.position

				var_280_20.forward = Vector3.New(var_280_27.x, var_280_27.y, var_280_27.z)

				local var_280_28 = var_280_20.localEulerAngles

				var_280_28.z = 0
				var_280_28.x = 0
				var_280_20.localEulerAngles = var_280_28
			end

			local var_280_29 = arg_277_1.actors_["1084ui_story"]
			local var_280_30 = 0

			if var_280_30 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 and not isNil(var_280_29) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = var_280_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_31 = 0.200000002980232

			if var_280_30 <= arg_277_1.time_ and arg_277_1.time_ < var_280_30 + var_280_31 and not isNil(var_280_29) then
				local var_280_32 = (arg_277_1.time_ - var_280_30) / var_280_31

				if arg_277_1.var_.characterEffect1084ui_story and not isNil(var_280_29) then
					local var_280_33 = Mathf.Lerp(0, 0.5, var_280_32)

					arg_277_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1084ui_story.fillRatio = var_280_33
				end
			end

			if arg_277_1.time_ >= var_280_30 + var_280_31 and arg_277_1.time_ < var_280_30 + var_280_31 + arg_280_0 and not isNil(var_280_29) and arg_277_1.var_.characterEffect1084ui_story then
				local var_280_34 = 0.5

				arg_277_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1084ui_story.fillRatio = var_280_34
			end

			local var_280_35 = 0
			local var_280_36 = 0.4

			if var_280_35 < arg_277_1.time_ and arg_277_1.time_ <= var_280_35 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_37 = arg_277_1:FormatText(StoryNameCfg[378].name)

				arg_277_1.leftNameTxt_.text = var_280_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_38 = arg_277_1:GetWordFromCfg(121481068)
				local var_280_39 = arg_277_1:FormatText(var_280_38.content)

				arg_277_1.text_.text = var_280_39

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_40 = 16
				local var_280_41 = utf8.len(var_280_39)
				local var_280_42 = var_280_40 <= 0 and var_280_36 or var_280_36 * (var_280_41 / var_280_40)

				if var_280_42 > 0 and var_280_36 < var_280_42 then
					arg_277_1.talkMaxDuration = var_280_42

					if var_280_42 + var_280_35 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_42 + var_280_35
					end
				end

				arg_277_1.text_.text = var_280_39
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481068", "story_v_out_121481.awb") ~= 0 then
					local var_280_43 = manager.audio:GetVoiceLength("story_v_out_121481", "121481068", "story_v_out_121481.awb") / 1000

					if var_280_43 + var_280_35 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_43 + var_280_35
					end

					if var_280_38.prefab_name ~= "" and arg_277_1.actors_[var_280_38.prefab_name] ~= nil then
						local var_280_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_38.prefab_name].transform, "story_v_out_121481", "121481068", "story_v_out_121481.awb")

						arg_277_1:RecordAudio("121481068", var_280_44)
						arg_277_1:RecordAudio("121481068", var_280_44)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_121481", "121481068", "story_v_out_121481.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_121481", "121481068", "story_v_out_121481.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_45 = math.max(var_280_36, arg_277_1.talkMaxDuration)

			if var_280_35 <= arg_277_1.time_ and arg_277_1.time_ < var_280_35 + var_280_45 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_35) / var_280_45

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_35 + var_280_45 and arg_277_1.time_ < var_280_35 + var_280_45 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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

		arg_277_1:InitPlayNodeList()
	end,
	Play121481069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 121481069
		arg_281_1.duration_ = 8.77

		local var_281_0 = {
			ja = 8.766,
			ko = 5.366,
			zh = 5.366
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play121481070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1084ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1084ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1084ui_story then
				arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_284_4 = 0

			if var_284_4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_284_5 = 0

			if var_284_5 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_6 = arg_281_1.actors_["1069ui_story"]
			local var_284_7 = 0

			if var_284_7 < arg_281_1.time_ and arg_281_1.time_ <= var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect1069ui_story == nil then
				arg_281_1.var_.characterEffect1069ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_8 = 0.200000002980232

			if var_284_7 <= arg_281_1.time_ and arg_281_1.time_ < var_284_7 + var_284_8 and not isNil(var_284_6) then
				local var_284_9 = (arg_281_1.time_ - var_284_7) / var_284_8

				if arg_281_1.var_.characterEffect1069ui_story and not isNil(var_284_6) then
					local var_284_10 = Mathf.Lerp(0, 0.5, var_284_9)

					arg_281_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1069ui_story.fillRatio = var_284_10
				end
			end

			if arg_281_1.time_ >= var_284_7 + var_284_8 and arg_281_1.time_ < var_284_7 + var_284_8 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect1069ui_story then
				local var_284_11 = 0.5

				arg_281_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1069ui_story.fillRatio = var_284_11
			end

			local var_284_12 = 0
			local var_284_13 = 0.75

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_14 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_15 = arg_281_1:GetWordFromCfg(121481069)
				local var_284_16 = arg_281_1:FormatText(var_284_15.content)

				arg_281_1.text_.text = var_284_16

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_17 = 30
				local var_284_18 = utf8.len(var_284_16)
				local var_284_19 = var_284_17 <= 0 and var_284_13 or var_284_13 * (var_284_18 / var_284_17)

				if var_284_19 > 0 and var_284_13 < var_284_19 then
					arg_281_1.talkMaxDuration = var_284_19

					if var_284_19 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_12
					end
				end

				arg_281_1.text_.text = var_284_16
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481069", "story_v_out_121481.awb") ~= 0 then
					local var_284_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481069", "story_v_out_121481.awb") / 1000

					if var_284_20 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_12
					end

					if var_284_15.prefab_name ~= "" and arg_281_1.actors_[var_284_15.prefab_name] ~= nil then
						local var_284_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_15.prefab_name].transform, "story_v_out_121481", "121481069", "story_v_out_121481.awb")

						arg_281_1:RecordAudio("121481069", var_284_21)
						arg_281_1:RecordAudio("121481069", var_284_21)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_121481", "121481069", "story_v_out_121481.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_121481", "121481069", "story_v_out_121481.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_22 = math.max(var_284_13, arg_281_1.talkMaxDuration)

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_22 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_12) / var_284_22

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_12 + var_284_22 and arg_281_1.time_ < var_284_12 + var_284_22 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play121481070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 121481070
		arg_285_1.duration_ = 4.9

		local var_285_0 = {
			ja = 4.9,
			ko = 3,
			zh = 3
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play121481071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1069ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1069ui_story == nil then
				arg_285_1.var_.characterEffect1069ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1069ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1069ui_story then
				arg_285_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_288_4 = 0

			if var_288_4 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_6 = arg_285_1.actors_["1084ui_story"]
			local var_288_7 = 0

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_8 = 0.200000002980232

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 and not isNil(var_288_6) then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / var_288_8

				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_6) then
					local var_288_10 = Mathf.Lerp(0, 0.5, var_288_9)

					arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_10
				end
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1084ui_story then
				local var_288_11 = 0.5

				arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_11
			end

			local var_288_12 = 0
			local var_288_13 = 0.4

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_14 = arg_285_1:FormatText(StoryNameCfg[378].name)

				arg_285_1.leftNameTxt_.text = var_288_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_15 = arg_285_1:GetWordFromCfg(121481070)
				local var_288_16 = arg_285_1:FormatText(var_288_15.content)

				arg_285_1.text_.text = var_288_16

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_17 = 16
				local var_288_18 = utf8.len(var_288_16)
				local var_288_19 = var_288_17 <= 0 and var_288_13 or var_288_13 * (var_288_18 / var_288_17)

				if var_288_19 > 0 and var_288_13 < var_288_19 then
					arg_285_1.talkMaxDuration = var_288_19

					if var_288_19 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_12
					end
				end

				arg_285_1.text_.text = var_288_16
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481070", "story_v_out_121481.awb") ~= 0 then
					local var_288_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481070", "story_v_out_121481.awb") / 1000

					if var_288_20 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_20 + var_288_12
					end

					if var_288_15.prefab_name ~= "" and arg_285_1.actors_[var_288_15.prefab_name] ~= nil then
						local var_288_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_15.prefab_name].transform, "story_v_out_121481", "121481070", "story_v_out_121481.awb")

						arg_285_1:RecordAudio("121481070", var_288_21)
						arg_285_1:RecordAudio("121481070", var_288_21)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_121481", "121481070", "story_v_out_121481.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_121481", "121481070", "story_v_out_121481.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_22 = math.max(var_288_13, arg_285_1.talkMaxDuration)

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_22 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_12) / var_288_22

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_12 + var_288_22 and arg_285_1.time_ < var_288_12 + var_288_22 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play121481071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 121481071
		arg_289_1.duration_ = 7.3

		local var_289_0 = {
			ja = 5.166,
			ko = 7.3,
			zh = 7.3
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play121481072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_2")
			end

			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_2 = 0
			local var_292_3 = 0.85

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_4 = arg_289_1:FormatText(StoryNameCfg[378].name)

				arg_289_1.leftNameTxt_.text = var_292_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_5 = arg_289_1:GetWordFromCfg(121481071)
				local var_292_6 = arg_289_1:FormatText(var_292_5.content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 34
				local var_292_8 = utf8.len(var_292_6)
				local var_292_9 = var_292_7 <= 0 and var_292_3 or var_292_3 * (var_292_8 / var_292_7)

				if var_292_9 > 0 and var_292_3 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481071", "story_v_out_121481.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_121481", "121481071", "story_v_out_121481.awb") / 1000

					if var_292_10 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_2
					end

					if var_292_5.prefab_name ~= "" and arg_289_1.actors_[var_292_5.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_5.prefab_name].transform, "story_v_out_121481", "121481071", "story_v_out_121481.awb")

						arg_289_1:RecordAudio("121481071", var_292_11)
						arg_289_1:RecordAudio("121481071", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_121481", "121481071", "story_v_out_121481.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_121481", "121481071", "story_v_out_121481.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_12 and arg_289_1.time_ < var_292_2 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play121481072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 121481072
		arg_293_1.duration_ = 9.77

		local var_293_0 = {
			ja = 9.766,
			ko = 4.566,
			zh = 4.566
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
				arg_293_0:Play121481073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1084ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1084ui_story then
				arg_293_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_296_4 = 0

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_6 = arg_293_1.actors_["1069ui_story"]
			local var_296_7 = 0

			if var_296_7 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1069ui_story == nil then
				arg_293_1.var_.characterEffect1069ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_8 = 0.200000002980232

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_8 and not isNil(var_296_6) then
				local var_296_9 = (arg_293_1.time_ - var_296_7) / var_296_8

				if arg_293_1.var_.characterEffect1069ui_story and not isNil(var_296_6) then
					local var_296_10 = Mathf.Lerp(0, 0.5, var_296_9)

					arg_293_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1069ui_story.fillRatio = var_296_10
				end
			end

			if arg_293_1.time_ >= var_296_7 + var_296_8 and arg_293_1.time_ < var_296_7 + var_296_8 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1069ui_story then
				local var_296_11 = 0.5

				arg_293_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1069ui_story.fillRatio = var_296_11
			end

			local var_296_12 = 0
			local var_296_13 = 0.45

			if var_296_12 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_14 = arg_293_1:FormatText(StoryNameCfg[6].name)

				arg_293_1.leftNameTxt_.text = var_296_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_15 = arg_293_1:GetWordFromCfg(121481072)
				local var_296_16 = arg_293_1:FormatText(var_296_15.content)

				arg_293_1.text_.text = var_296_16

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_17 = 18
				local var_296_18 = utf8.len(var_296_16)
				local var_296_19 = var_296_17 <= 0 and var_296_13 or var_296_13 * (var_296_18 / var_296_17)

				if var_296_19 > 0 and var_296_13 < var_296_19 then
					arg_293_1.talkMaxDuration = var_296_19

					if var_296_19 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_12
					end
				end

				arg_293_1.text_.text = var_296_16
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481072", "story_v_out_121481.awb") ~= 0 then
					local var_296_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481072", "story_v_out_121481.awb") / 1000

					if var_296_20 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_20 + var_296_12
					end

					if var_296_15.prefab_name ~= "" and arg_293_1.actors_[var_296_15.prefab_name] ~= nil then
						local var_296_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_15.prefab_name].transform, "story_v_out_121481", "121481072", "story_v_out_121481.awb")

						arg_293_1:RecordAudio("121481072", var_296_21)
						arg_293_1:RecordAudio("121481072", var_296_21)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_121481", "121481072", "story_v_out_121481.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_121481", "121481072", "story_v_out_121481.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_22 = math.max(var_296_13, arg_293_1.talkMaxDuration)

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_22 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_12) / var_296_22

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_12 + var_296_22 and arg_293_1.time_ < var_296_12 + var_296_22 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play121481073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 121481073
		arg_297_1.duration_ = 7.63

		local var_297_0 = {
			ja = 7.633,
			ko = 5.466,
			zh = 5.466
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play121481074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1084ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1084ui_story == nil then
				arg_297_1.var_.characterEffect1084ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1084ui_story and not isNil(var_300_0) then
					local var_300_4 = Mathf.Lerp(0, 0.5, var_300_3)

					arg_297_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1084ui_story.fillRatio = var_300_4
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1084ui_story then
				local var_300_5 = 0.5

				arg_297_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1084ui_story.fillRatio = var_300_5
			end

			local var_300_6 = arg_297_1.actors_["1069ui_story"]
			local var_300_7 = 0

			if var_300_7 < arg_297_1.time_ and arg_297_1.time_ <= var_300_7 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect1069ui_story == nil then
				arg_297_1.var_.characterEffect1069ui_story = var_300_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_8 = 0.200000002980232

			if var_300_7 <= arg_297_1.time_ and arg_297_1.time_ < var_300_7 + var_300_8 and not isNil(var_300_6) then
				local var_300_9 = (arg_297_1.time_ - var_300_7) / var_300_8

				if arg_297_1.var_.characterEffect1069ui_story and not isNil(var_300_6) then
					arg_297_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_7 + var_300_8 and arg_297_1.time_ < var_300_7 + var_300_8 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect1069ui_story then
				arg_297_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_300_10 = 0
			local var_300_11 = 0.675

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_12 = arg_297_1:FormatText(StoryNameCfg[378].name)

				arg_297_1.leftNameTxt_.text = var_300_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_13 = arg_297_1:GetWordFromCfg(121481073)
				local var_300_14 = arg_297_1:FormatText(var_300_13.content)

				arg_297_1.text_.text = var_300_14

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_15 = 27
				local var_300_16 = utf8.len(var_300_14)
				local var_300_17 = var_300_15 <= 0 and var_300_11 or var_300_11 * (var_300_16 / var_300_15)

				if var_300_17 > 0 and var_300_11 < var_300_17 then
					arg_297_1.talkMaxDuration = var_300_17

					if var_300_17 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_17 + var_300_10
					end
				end

				arg_297_1.text_.text = var_300_14
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481073", "story_v_out_121481.awb") ~= 0 then
					local var_300_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481073", "story_v_out_121481.awb") / 1000

					if var_300_18 + var_300_10 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_10
					end

					if var_300_13.prefab_name ~= "" and arg_297_1.actors_[var_300_13.prefab_name] ~= nil then
						local var_300_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_13.prefab_name].transform, "story_v_out_121481", "121481073", "story_v_out_121481.awb")

						arg_297_1:RecordAudio("121481073", var_300_19)
						arg_297_1:RecordAudio("121481073", var_300_19)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_121481", "121481073", "story_v_out_121481.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_121481", "121481073", "story_v_out_121481.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_20 = math.max(var_300_11, arg_297_1.talkMaxDuration)

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_20 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_10) / var_300_20

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_10 + var_300_20 and arg_297_1.time_ < var_300_10 + var_300_20 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play121481074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 121481074
		arg_301_1.duration_ = 9.17

		local var_301_0 = {
			ja = 9.166,
			ko = 3.933,
			zh = 3.933
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play121481075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.55

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[378].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(121481074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 22
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481074", "story_v_out_121481.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481074", "story_v_out_121481.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_121481", "121481074", "story_v_out_121481.awb")

						arg_301_1:RecordAudio("121481074", var_304_9)
						arg_301_1:RecordAudio("121481074", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_121481", "121481074", "story_v_out_121481.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_121481", "121481074", "story_v_out_121481.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play121481075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 121481075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play121481076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1069ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1069ui_story == nil then
				arg_305_1.var_.characterEffect1069ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1069ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1069ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1069ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1069ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.2

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(121481075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 8
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play121481076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 121481076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play121481077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1084ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1084ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, 100, 0)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1084ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, 100, 0)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1084ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1084ui_story == nil then
				arg_309_1.var_.characterEffect1084ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1084ui_story and not isNil(var_312_9) then
					local var_312_13 = Mathf.Lerp(0, 0.5, var_312_12)

					arg_309_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1084ui_story.fillRatio = var_312_13
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1084ui_story then
				local var_312_14 = 0.5

				arg_309_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1084ui_story.fillRatio = var_312_14
			end

			local var_312_15 = arg_309_1.actors_["1069ui_story"].transform
			local var_312_16 = 0

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 then
				arg_309_1.var_.moveOldPos1069ui_story = var_312_15.localPosition
			end

			local var_312_17 = 0.001

			if var_312_16 <= arg_309_1.time_ and arg_309_1.time_ < var_312_16 + var_312_17 then
				local var_312_18 = (arg_309_1.time_ - var_312_16) / var_312_17
				local var_312_19 = Vector3.New(0, 100, 0)

				var_312_15.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1069ui_story, var_312_19, var_312_18)

				local var_312_20 = manager.ui.mainCamera.transform.position - var_312_15.position

				var_312_15.forward = Vector3.New(var_312_20.x, var_312_20.y, var_312_20.z)

				local var_312_21 = var_312_15.localEulerAngles

				var_312_21.z = 0
				var_312_21.x = 0
				var_312_15.localEulerAngles = var_312_21
			end

			if arg_309_1.time_ >= var_312_16 + var_312_17 and arg_309_1.time_ < var_312_16 + var_312_17 + arg_312_0 then
				var_312_15.localPosition = Vector3.New(0, 100, 0)

				local var_312_22 = manager.ui.mainCamera.transform.position - var_312_15.position

				var_312_15.forward = Vector3.New(var_312_22.x, var_312_22.y, var_312_22.z)

				local var_312_23 = var_312_15.localEulerAngles

				var_312_23.z = 0
				var_312_23.x = 0
				var_312_15.localEulerAngles = var_312_23
			end

			local var_312_24 = arg_309_1.actors_["1069ui_story"]
			local var_312_25 = 0

			if var_312_25 < arg_309_1.time_ and arg_309_1.time_ <= var_312_25 + arg_312_0 and not isNil(var_312_24) and arg_309_1.var_.characterEffect1069ui_story == nil then
				arg_309_1.var_.characterEffect1069ui_story = var_312_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_26 = 0.200000002980232

			if var_312_25 <= arg_309_1.time_ and arg_309_1.time_ < var_312_25 + var_312_26 and not isNil(var_312_24) then
				local var_312_27 = (arg_309_1.time_ - var_312_25) / var_312_26

				if arg_309_1.var_.characterEffect1069ui_story and not isNil(var_312_24) then
					local var_312_28 = Mathf.Lerp(0, 0.5, var_312_27)

					arg_309_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1069ui_story.fillRatio = var_312_28
				end
			end

			if arg_309_1.time_ >= var_312_25 + var_312_26 and arg_309_1.time_ < var_312_25 + var_312_26 + arg_312_0 and not isNil(var_312_24) and arg_309_1.var_.characterEffect1069ui_story then
				local var_312_29 = 0.5

				arg_309_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1069ui_story.fillRatio = var_312_29
			end

			local var_312_30 = 0
			local var_312_31 = 0.65

			if var_312_30 < arg_309_1.time_ and arg_309_1.time_ <= var_312_30 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_32 = arg_309_1:GetWordFromCfg(121481076)
				local var_312_33 = arg_309_1:FormatText(var_312_32.content)

				arg_309_1.text_.text = var_312_33

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_34 = 26
				local var_312_35 = utf8.len(var_312_33)
				local var_312_36 = var_312_34 <= 0 and var_312_31 or var_312_31 * (var_312_35 / var_312_34)

				if var_312_36 > 0 and var_312_31 < var_312_36 then
					arg_309_1.talkMaxDuration = var_312_36

					if var_312_36 + var_312_30 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_36 + var_312_30
					end
				end

				arg_309_1.text_.text = var_312_33
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_37 = math.max(var_312_31, arg_309_1.talkMaxDuration)

			if var_312_30 <= arg_309_1.time_ and arg_309_1.time_ < var_312_30 + var_312_37 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_30) / var_312_37

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_30 + var_312_37 and arg_309_1.time_ < var_312_30 + var_312_37 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play121481077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 121481077
		arg_313_1.duration_ = 15.87

		local var_313_0 = {
			ja = 15.865999999999,
			ko = 14.432999999999,
			zh = 14.432999999999
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play121481078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = "ST42"

			if arg_313_1.bgs_[var_316_0] == nil then
				local var_316_1 = Object.Instantiate(arg_313_1.paintGo_)

				var_316_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_316_0)
				var_316_1.name = var_316_0
				var_316_1.transform.parent = arg_313_1.stage_.transform
				var_316_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.bgs_[var_316_0] = var_316_1
			end

			local var_316_2 = 1.999999999999

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				local var_316_3 = manager.ui.mainCamera.transform.localPosition
				local var_316_4 = Vector3.New(0, 0, 10) + Vector3.New(var_316_3.x, var_316_3.y, 0)
				local var_316_5 = arg_313_1.bgs_.ST42

				var_316_5.transform.localPosition = var_316_4
				var_316_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_6 = var_316_5:GetComponent("SpriteRenderer")

				if var_316_6 and var_316_6.sprite then
					local var_316_7 = (var_316_5.transform.localPosition - var_316_3).z
					local var_316_8 = manager.ui.mainCameraCom_
					local var_316_9 = 2 * var_316_7 * Mathf.Tan(var_316_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_316_10 = var_316_9 * var_316_8.aspect
					local var_316_11 = var_316_6.sprite.bounds.size.x
					local var_316_12 = var_316_6.sprite.bounds.size.y
					local var_316_13 = var_316_10 / var_316_11
					local var_316_14 = var_316_9 / var_316_12
					local var_316_15 = var_316_14 < var_316_13 and var_316_13 or var_316_14

					var_316_5.transform.localScale = Vector3.New(var_316_15, var_316_15, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "ST42" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_17 = 2

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17
				local var_316_19 = Color.New(0, 0, 0)

				var_316_19.a = Mathf.Lerp(0, 1, var_316_18)
				arg_313_1.mask_.color = var_316_19
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 then
				local var_316_20 = Color.New(0, 0, 0)

				var_316_20.a = 1
				arg_313_1.mask_.color = var_316_20
			end

			local var_316_21 = 1.999999999999

			if var_316_21 < arg_313_1.time_ and arg_313_1.time_ <= var_316_21 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_22 = 2

			if var_316_21 <= arg_313_1.time_ and arg_313_1.time_ < var_316_21 + var_316_22 then
				local var_316_23 = (arg_313_1.time_ - var_316_21) / var_316_22
				local var_316_24 = Color.New(0, 0, 0)

				var_316_24.a = Mathf.Lerp(1, 0, var_316_23)
				arg_313_1.mask_.color = var_316_24
			end

			if arg_313_1.time_ >= var_316_21 + var_316_22 and arg_313_1.time_ < var_316_21 + var_316_22 + arg_316_0 then
				local var_316_25 = Color.New(0, 0, 0)
				local var_316_26 = 0

				arg_313_1.mask_.enabled = false
				var_316_25.a = var_316_26
				arg_313_1.mask_.color = var_316_25
			end

			local var_316_27 = 0
			local var_316_28 = 0.2

			if var_316_27 < arg_313_1.time_ and arg_313_1.time_ <= var_316_27 + arg_316_0 then
				local var_316_29 = "play"
				local var_316_30 = "effect"

				arg_313_1:AudioAction(var_316_29, var_316_30, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_316_31 = 0.3
			local var_316_32 = 1

			if var_316_31 < arg_313_1.time_ and arg_313_1.time_ <= var_316_31 + arg_316_0 then
				local var_316_33 = "play"
				local var_316_34 = "music"

				arg_313_1:AudioAction(var_316_33, var_316_34, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_316_35 = ""
				local var_316_36 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_316_36 ~= "" then
					if arg_313_1.bgmTxt_.text ~= var_316_36 and arg_313_1.bgmTxt_.text ~= "" then
						if arg_313_1.bgmTxt2_.text ~= "" then
							arg_313_1.bgmTxt_.text = arg_313_1.bgmTxt2_.text
						end

						arg_313_1.bgmTxt2_.text = var_316_36

						arg_313_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_313_1.bgmTxt_.text = var_316_36
						arg_313_1.bgmTxt2_.text = var_316_36
					end

					if arg_313_1.bgmTimer then
						arg_313_1.bgmTimer:Stop()

						arg_313_1.bgmTimer = nil
					end

					if arg_313_1.settingData.show_music_name == 1 then
						arg_313_1.musicController:SetSelectedState("show")
						arg_313_1.musicAnimator_:Play("open", 0, 0)

						if arg_313_1.settingData.music_time ~= 0 then
							arg_313_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_313_1.settingData.music_time), function()
								if arg_313_1 == nil or isNil(arg_313_1.bgmTxt_) then
									return
								end

								arg_313_1.musicController:SetSelectedState("hide")
								arg_313_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_316_37 = 2

			arg_313_1.isInRecall_ = false

			if var_316_37 < arg_313_1.time_ and arg_313_1.time_ <= var_316_37 + arg_316_0 then
				arg_313_1.screenFilterGo_:SetActive(true)

				arg_313_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_316_2, iter_316_3 in pairs(arg_313_1.actors_) do
					local var_316_38 = iter_316_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_316_4, iter_316_5 in ipairs(var_316_38) do
						if iter_316_5.color.r > 0.51 then
							iter_316_5.color = Color.New(1, 1, 1)
						else
							iter_316_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_316_39 = 0.1

			if var_316_37 <= arg_313_1.time_ and arg_313_1.time_ < var_316_37 + var_316_39 then
				local var_316_40 = (arg_313_1.time_ - var_316_37) / var_316_39

				arg_313_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_316_40)
			end

			if arg_313_1.time_ >= var_316_37 + var_316_39 and arg_313_1.time_ < var_316_37 + var_316_39 + arg_316_0 then
				arg_313_1.screenFilterEffect_.weight = 1
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_41 = 3.999999999999
			local var_316_42 = 1.225

			if var_316_41 < arg_313_1.time_ and arg_313_1.time_ <= var_316_41 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_43 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_43:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_313_1.dialogCg_.alpha = arg_318_0
				end))
				var_316_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_44 = arg_313_1:FormatText(StoryNameCfg[379].name)

				arg_313_1.leftNameTxt_.text = var_316_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_45 = arg_313_1:GetWordFromCfg(121481077)
				local var_316_46 = arg_313_1:FormatText(var_316_45.content)

				arg_313_1.text_.text = var_316_46

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_47 = 49
				local var_316_48 = utf8.len(var_316_46)
				local var_316_49 = var_316_47 <= 0 and var_316_42 or var_316_42 * (var_316_48 / var_316_47)

				if var_316_49 > 0 and var_316_42 < var_316_49 then
					arg_313_1.talkMaxDuration = var_316_49
					var_316_41 = var_316_41 + 0.3

					if var_316_49 + var_316_41 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_49 + var_316_41
					end
				end

				arg_313_1.text_.text = var_316_46
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481077", "story_v_out_121481.awb") ~= 0 then
					local var_316_50 = manager.audio:GetVoiceLength("story_v_out_121481", "121481077", "story_v_out_121481.awb") / 1000

					if var_316_50 + var_316_41 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_50 + var_316_41
					end

					if var_316_45.prefab_name ~= "" and arg_313_1.actors_[var_316_45.prefab_name] ~= nil then
						local var_316_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_45.prefab_name].transform, "story_v_out_121481", "121481077", "story_v_out_121481.awb")

						arg_313_1:RecordAudio("121481077", var_316_51)
						arg_313_1:RecordAudio("121481077", var_316_51)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_121481", "121481077", "story_v_out_121481.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_121481", "121481077", "story_v_out_121481.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_52 = var_316_41 + 0.3
			local var_316_53 = math.max(var_316_42, arg_313_1.talkMaxDuration)

			if var_316_52 <= arg_313_1.time_ and arg_313_1.time_ < var_316_52 + var_316_53 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_52) / var_316_53

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_52 + var_316_53 and arg_313_1.time_ < var_316_52 + var_316_53 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play121481078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 121481078
		arg_320_1.duration_ = 2.8

		local var_320_0 = {
			ja = 2.8,
			ko = 1.7,
			zh = 1.7
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play121481079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.225

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[378].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(121481078)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 9
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481078", "story_v_out_121481.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481078", "story_v_out_121481.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_121481", "121481078", "story_v_out_121481.awb")

						arg_320_1:RecordAudio("121481078", var_323_9)
						arg_320_1:RecordAudio("121481078", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_121481", "121481078", "story_v_out_121481.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_121481", "121481078", "story_v_out_121481.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play121481079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 121481079
		arg_324_1.duration_ = 10.8

		local var_324_0 = {
			ja = 10.8,
			ko = 10.4,
			zh = 10.4
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
				arg_324_0:Play121481080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1.35

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[379].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(121481079)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 54
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481079", "story_v_out_121481.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481079", "story_v_out_121481.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_121481", "121481079", "story_v_out_121481.awb")

						arg_324_1:RecordAudio("121481079", var_327_9)
						arg_324_1:RecordAudio("121481079", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_121481", "121481079", "story_v_out_121481.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_121481", "121481079", "story_v_out_121481.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play121481080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 121481080
		arg_328_1.duration_ = 1.57

		local var_328_0 = {
			ja = 1.566,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_328_0:Play121481081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.05

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[378].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(121481080)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 2
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481080", "story_v_out_121481.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481080", "story_v_out_121481.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_121481", "121481080", "story_v_out_121481.awb")

						arg_328_1:RecordAudio("121481080", var_331_9)
						arg_328_1:RecordAudio("121481080", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_121481", "121481080", "story_v_out_121481.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_121481", "121481080", "story_v_out_121481.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play121481081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 121481081
		arg_332_1.duration_ = 10.3

		local var_332_0 = {
			ja = 10.3,
			ko = 8.2,
			zh = 8.2
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
				arg_332_0:Play121481082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = "J02h"

			if arg_332_1.bgs_[var_335_0] == nil then
				local var_335_1 = Object.Instantiate(arg_332_1.paintGo_)

				var_335_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_335_0)
				var_335_1.name = var_335_0
				var_335_1.transform.parent = arg_332_1.stage_.transform
				var_335_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.bgs_[var_335_0] = var_335_1
			end

			local var_335_2 = 2

			if var_335_2 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				local var_335_3 = manager.ui.mainCamera.transform.localPosition
				local var_335_4 = Vector3.New(0, 0, 10) + Vector3.New(var_335_3.x, var_335_3.y, 0)
				local var_335_5 = arg_332_1.bgs_.J02h

				var_335_5.transform.localPosition = var_335_4
				var_335_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_6 = var_335_5:GetComponent("SpriteRenderer")

				if var_335_6 and var_335_6.sprite then
					local var_335_7 = (var_335_5.transform.localPosition - var_335_3).z
					local var_335_8 = manager.ui.mainCameraCom_
					local var_335_9 = 2 * var_335_7 * Mathf.Tan(var_335_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_335_10 = var_335_9 * var_335_8.aspect
					local var_335_11 = var_335_6.sprite.bounds.size.x
					local var_335_12 = var_335_6.sprite.bounds.size.y
					local var_335_13 = var_335_10 / var_335_11
					local var_335_14 = var_335_9 / var_335_12
					local var_335_15 = var_335_14 < var_335_13 and var_335_13 or var_335_14

					var_335_5.transform.localScale = Vector3.New(var_335_15, var_335_15, 0)
				end

				for iter_335_0, iter_335_1 in pairs(arg_332_1.bgs_) do
					if iter_335_0 ~= "J02h" then
						iter_335_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_16 = 0

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_17 = 2

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_17 then
				local var_335_18 = (arg_332_1.time_ - var_335_16) / var_335_17
				local var_335_19 = Color.New(0, 0, 0)

				var_335_19.a = Mathf.Lerp(0, 1, var_335_18)
				arg_332_1.mask_.color = var_335_19
			end

			if arg_332_1.time_ >= var_335_16 + var_335_17 and arg_332_1.time_ < var_335_16 + var_335_17 + arg_335_0 then
				local var_335_20 = Color.New(0, 0, 0)

				var_335_20.a = 1
				arg_332_1.mask_.color = var_335_20
			end

			local var_335_21 = 2.00000000298023

			if var_335_21 < arg_332_1.time_ and arg_332_1.time_ <= var_335_21 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_22 = 2

			if var_335_21 <= arg_332_1.time_ and arg_332_1.time_ < var_335_21 + var_335_22 then
				local var_335_23 = (arg_332_1.time_ - var_335_21) / var_335_22
				local var_335_24 = Color.New(0, 0, 0)

				var_335_24.a = Mathf.Lerp(1, 0, var_335_23)
				arg_332_1.mask_.color = var_335_24
			end

			if arg_332_1.time_ >= var_335_21 + var_335_22 and arg_332_1.time_ < var_335_21 + var_335_22 + arg_335_0 then
				local var_335_25 = Color.New(0, 0, 0)
				local var_335_26 = 0

				arg_332_1.mask_.enabled = false
				var_335_25.a = var_335_26
				arg_332_1.mask_.color = var_335_25
			end

			local var_335_27 = arg_332_1.actors_["1069ui_story"].transform
			local var_335_28 = 3.8

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 then
				arg_332_1.var_.moveOldPos1069ui_story = var_335_27.localPosition
			end

			local var_335_29 = 0.001

			if var_335_28 <= arg_332_1.time_ and arg_332_1.time_ < var_335_28 + var_335_29 then
				local var_335_30 = (arg_332_1.time_ - var_335_28) / var_335_29
				local var_335_31 = Vector3.New(0, -1, -6)

				var_335_27.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1069ui_story, var_335_31, var_335_30)

				local var_335_32 = manager.ui.mainCamera.transform.position - var_335_27.position

				var_335_27.forward = Vector3.New(var_335_32.x, var_335_32.y, var_335_32.z)

				local var_335_33 = var_335_27.localEulerAngles

				var_335_33.z = 0
				var_335_33.x = 0
				var_335_27.localEulerAngles = var_335_33
			end

			if arg_332_1.time_ >= var_335_28 + var_335_29 and arg_332_1.time_ < var_335_28 + var_335_29 + arg_335_0 then
				var_335_27.localPosition = Vector3.New(0, -1, -6)

				local var_335_34 = manager.ui.mainCamera.transform.position - var_335_27.position

				var_335_27.forward = Vector3.New(var_335_34.x, var_335_34.y, var_335_34.z)

				local var_335_35 = var_335_27.localEulerAngles

				var_335_35.z = 0
				var_335_35.x = 0
				var_335_27.localEulerAngles = var_335_35
			end

			local var_335_36 = arg_332_1.actors_["1069ui_story"]
			local var_335_37 = 3.8

			if var_335_37 < arg_332_1.time_ and arg_332_1.time_ <= var_335_37 + arg_335_0 and not isNil(var_335_36) and arg_332_1.var_.characterEffect1069ui_story == nil then
				arg_332_1.var_.characterEffect1069ui_story = var_335_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_38 = 0.200000002980232

			if var_335_37 <= arg_332_1.time_ and arg_332_1.time_ < var_335_37 + var_335_38 and not isNil(var_335_36) then
				local var_335_39 = (arg_332_1.time_ - var_335_37) / var_335_38

				if arg_332_1.var_.characterEffect1069ui_story and not isNil(var_335_36) then
					arg_332_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_37 + var_335_38 and arg_332_1.time_ < var_335_37 + var_335_38 + arg_335_0 and not isNil(var_335_36) and arg_332_1.var_.characterEffect1069ui_story then
				arg_332_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_335_40 = 3.8

			if var_335_40 < arg_332_1.time_ and arg_332_1.time_ <= var_335_40 + arg_335_0 then
				arg_332_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_335_41 = 3.8

			if var_335_41 < arg_332_1.time_ and arg_332_1.time_ <= var_335_41 + arg_335_0 then
				arg_332_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_335_42 = 2

			arg_332_1.isInRecall_ = false

			if var_335_42 < arg_332_1.time_ and arg_332_1.time_ <= var_335_42 + arg_335_0 then
				arg_332_1.screenFilterGo_:SetActive(false)

				for iter_335_2, iter_335_3 in pairs(arg_332_1.actors_) do
					local var_335_43 = iter_335_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_335_4, iter_335_5 in ipairs(var_335_43) do
						if iter_335_5.color.r > 0.51 then
							iter_335_5.color = Color.New(1, 1, 1)
						else
							iter_335_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_335_44 = 0.1

			if var_335_42 <= arg_332_1.time_ and arg_332_1.time_ < var_335_42 + var_335_44 then
				local var_335_45 = (arg_332_1.time_ - var_335_42) / var_335_44

				arg_332_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_335_45)
			end

			if arg_332_1.time_ >= var_335_42 + var_335_44 and arg_332_1.time_ < var_335_42 + var_335_44 + arg_335_0 then
				arg_332_1.screenFilterEffect_.weight = 0
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_46 = 4
			local var_335_47 = 0.275

			if var_335_46 < arg_332_1.time_ and arg_332_1.time_ <= var_335_46 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_48 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_48:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_49 = arg_332_1:FormatText(StoryNameCfg[378].name)

				arg_332_1.leftNameTxt_.text = var_335_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_50 = arg_332_1:GetWordFromCfg(121481081)
				local var_335_51 = arg_332_1:FormatText(var_335_50.content)

				arg_332_1.text_.text = var_335_51

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_52 = 11
				local var_335_53 = utf8.len(var_335_51)
				local var_335_54 = var_335_52 <= 0 and var_335_47 or var_335_47 * (var_335_53 / var_335_52)

				if var_335_54 > 0 and var_335_47 < var_335_54 then
					arg_332_1.talkMaxDuration = var_335_54
					var_335_46 = var_335_46 + 0.3

					if var_335_54 + var_335_46 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_54 + var_335_46
					end
				end

				arg_332_1.text_.text = var_335_51
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481081", "story_v_out_121481.awb") ~= 0 then
					local var_335_55 = manager.audio:GetVoiceLength("story_v_out_121481", "121481081", "story_v_out_121481.awb") / 1000

					if var_335_55 + var_335_46 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_55 + var_335_46
					end

					if var_335_50.prefab_name ~= "" and arg_332_1.actors_[var_335_50.prefab_name] ~= nil then
						local var_335_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_50.prefab_name].transform, "story_v_out_121481", "121481081", "story_v_out_121481.awb")

						arg_332_1:RecordAudio("121481081", var_335_56)
						arg_332_1:RecordAudio("121481081", var_335_56)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_121481", "121481081", "story_v_out_121481.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_121481", "121481081", "story_v_out_121481.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_57 = var_335_46 + 0.3
			local var_335_58 = math.max(var_335_47, arg_332_1.talkMaxDuration)

			if var_335_57 <= arg_332_1.time_ and arg_332_1.time_ < var_335_57 + var_335_58 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_57) / var_335_58

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_57 + var_335_58 and arg_332_1.time_ < var_335_57 + var_335_58 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play121481082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 121481082
		arg_338_1.duration_ = 9.8

		local var_338_0 = {
			ja = 9.766,
			ko = 9.8,
			zh = 9.8
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play121481083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 1

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[378].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:GetWordFromCfg(121481082)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 40
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481082", "story_v_out_121481.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481082", "story_v_out_121481.awb") / 1000

					if var_341_8 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_0
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_121481", "121481082", "story_v_out_121481.awb")

						arg_338_1:RecordAudio("121481082", var_341_9)
						arg_338_1:RecordAudio("121481082", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_121481", "121481082", "story_v_out_121481.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_121481", "121481082", "story_v_out_121481.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_10 and arg_338_1.time_ < var_341_0 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play121481083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 121481083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play121481084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.633333333333333

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				local var_345_2 = "play"
				local var_345_3 = "music"

				arg_342_1:AudioAction(var_345_2, var_345_3, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_345_4 = ""
				local var_345_5 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_345_5 ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_5 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_5

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_5
						arg_342_1.bgmTxt2_.text = var_345_5
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_345_6 = arg_342_1.actors_["1069ui_story"].transform
			local var_345_7 = 0

			if var_345_7 < arg_342_1.time_ and arg_342_1.time_ <= var_345_7 + arg_345_0 then
				arg_342_1.var_.moveOldPos1069ui_story = var_345_6.localPosition
			end

			local var_345_8 = 0.001

			if var_345_7 <= arg_342_1.time_ and arg_342_1.time_ < var_345_7 + var_345_8 then
				local var_345_9 = (arg_342_1.time_ - var_345_7) / var_345_8
				local var_345_10 = Vector3.New(0, 100, 0)

				var_345_6.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1069ui_story, var_345_10, var_345_9)

				local var_345_11 = manager.ui.mainCamera.transform.position - var_345_6.position

				var_345_6.forward = Vector3.New(var_345_11.x, var_345_11.y, var_345_11.z)

				local var_345_12 = var_345_6.localEulerAngles

				var_345_12.z = 0
				var_345_12.x = 0
				var_345_6.localEulerAngles = var_345_12
			end

			if arg_342_1.time_ >= var_345_7 + var_345_8 and arg_342_1.time_ < var_345_7 + var_345_8 + arg_345_0 then
				var_345_6.localPosition = Vector3.New(0, 100, 0)

				local var_345_13 = manager.ui.mainCamera.transform.position - var_345_6.position

				var_345_6.forward = Vector3.New(var_345_13.x, var_345_13.y, var_345_13.z)

				local var_345_14 = var_345_6.localEulerAngles

				var_345_14.z = 0
				var_345_14.x = 0
				var_345_6.localEulerAngles = var_345_14
			end

			local var_345_15 = 0
			local var_345_16 = 0.75

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_17 = arg_342_1:GetWordFromCfg(121481083)
				local var_345_18 = arg_342_1:FormatText(var_345_17.content)

				arg_342_1.text_.text = var_345_18

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_19 = 30
				local var_345_20 = utf8.len(var_345_18)
				local var_345_21 = var_345_19 <= 0 and var_345_16 or var_345_16 * (var_345_20 / var_345_19)

				if var_345_21 > 0 and var_345_16 < var_345_21 then
					arg_342_1.talkMaxDuration = var_345_21

					if var_345_21 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_21 + var_345_15
					end
				end

				arg_342_1.text_.text = var_345_18
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_22 = math.max(var_345_16, arg_342_1.talkMaxDuration)

			if var_345_15 <= arg_342_1.time_ and arg_342_1.time_ < var_345_15 + var_345_22 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_15) / var_345_22

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_15 + var_345_22 and arg_342_1.time_ < var_345_15 + var_345_22 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play121481084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 121481084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play121481085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1069ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1069ui_story == nil then
				arg_347_1.var_.characterEffect1069ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1069ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1069ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1069ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1069ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0
			local var_350_7 = 1.05

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_8 = arg_347_1:GetWordFromCfg(121481084)
				local var_350_9 = arg_347_1:FormatText(var_350_8.content)

				arg_347_1.text_.text = var_350_9

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 42
				local var_350_11 = utf8.len(var_350_9)
				local var_350_12 = var_350_10 <= 0 and var_350_7 or var_350_7 * (var_350_11 / var_350_10)

				if var_350_12 > 0 and var_350_7 < var_350_12 then
					arg_347_1.talkMaxDuration = var_350_12

					if var_350_12 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_9
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_13 and arg_347_1.time_ < var_350_6 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play121481085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 121481085
		arg_351_1.duration_ = 4.97

		local var_351_0 = {
			ja = 4.966,
			ko = 3.566,
			zh = 3.566
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
				arg_351_0:Play121481086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action424")
			end

			local var_354_1 = arg_351_1.actors_["1069ui_story"].transform
			local var_354_2 = 0

			if var_354_2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.var_.moveOldPos1069ui_story = var_354_1.localPosition
			end

			local var_354_3 = 0.001

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_3 then
				local var_354_4 = (arg_351_1.time_ - var_354_2) / var_354_3
				local var_354_5 = Vector3.New(0, -1, -6)

				var_354_1.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1069ui_story, var_354_5, var_354_4)

				local var_354_6 = manager.ui.mainCamera.transform.position - var_354_1.position

				var_354_1.forward = Vector3.New(var_354_6.x, var_354_6.y, var_354_6.z)

				local var_354_7 = var_354_1.localEulerAngles

				var_354_7.z = 0
				var_354_7.x = 0
				var_354_1.localEulerAngles = var_354_7
			end

			if arg_351_1.time_ >= var_354_2 + var_354_3 and arg_351_1.time_ < var_354_2 + var_354_3 + arg_354_0 then
				var_354_1.localPosition = Vector3.New(0, -1, -6)

				local var_354_8 = manager.ui.mainCamera.transform.position - var_354_1.position

				var_354_1.forward = Vector3.New(var_354_8.x, var_354_8.y, var_354_8.z)

				local var_354_9 = var_354_1.localEulerAngles

				var_354_9.z = 0
				var_354_9.x = 0
				var_354_1.localEulerAngles = var_354_9
			end

			local var_354_10 = arg_351_1.actors_["1069ui_story"]
			local var_354_11 = 0

			if var_354_11 < arg_351_1.time_ and arg_351_1.time_ <= var_354_11 + arg_354_0 and not isNil(var_354_10) and arg_351_1.var_.characterEffect1069ui_story == nil then
				arg_351_1.var_.characterEffect1069ui_story = var_354_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_12 = 0.200000002980232

			if var_354_11 <= arg_351_1.time_ and arg_351_1.time_ < var_354_11 + var_354_12 and not isNil(var_354_10) then
				local var_354_13 = (arg_351_1.time_ - var_354_11) / var_354_12

				if arg_351_1.var_.characterEffect1069ui_story and not isNil(var_354_10) then
					arg_351_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_11 + var_354_12 and arg_351_1.time_ < var_354_11 + var_354_12 + arg_354_0 and not isNil(var_354_10) and arg_351_1.var_.characterEffect1069ui_story then
				arg_351_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_354_14 = 0
			local var_354_15 = 0.325

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_16 = arg_351_1:FormatText(StoryNameCfg[378].name)

				arg_351_1.leftNameTxt_.text = var_354_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_17 = arg_351_1:GetWordFromCfg(121481085)
				local var_354_18 = arg_351_1:FormatText(var_354_17.content)

				arg_351_1.text_.text = var_354_18

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_19 = 13
				local var_354_20 = utf8.len(var_354_18)
				local var_354_21 = var_354_19 <= 0 and var_354_15 or var_354_15 * (var_354_20 / var_354_19)

				if var_354_21 > 0 and var_354_15 < var_354_21 then
					arg_351_1.talkMaxDuration = var_354_21

					if var_354_21 + var_354_14 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_21 + var_354_14
					end
				end

				arg_351_1.text_.text = var_354_18
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481085", "story_v_out_121481.awb") ~= 0 then
					local var_354_22 = manager.audio:GetVoiceLength("story_v_out_121481", "121481085", "story_v_out_121481.awb") / 1000

					if var_354_22 + var_354_14 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_14
					end

					if var_354_17.prefab_name ~= "" and arg_351_1.actors_[var_354_17.prefab_name] ~= nil then
						local var_354_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_17.prefab_name].transform, "story_v_out_121481", "121481085", "story_v_out_121481.awb")

						arg_351_1:RecordAudio("121481085", var_354_23)
						arg_351_1:RecordAudio("121481085", var_354_23)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_121481", "121481085", "story_v_out_121481.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_121481", "121481085", "story_v_out_121481.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_24 = math.max(var_354_15, arg_351_1.talkMaxDuration)

			if var_354_14 <= arg_351_1.time_ and arg_351_1.time_ < var_354_14 + var_354_24 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_14) / var_354_24

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_14 + var_354_24 and arg_351_1.time_ < var_354_14 + var_354_24 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play121481086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 121481086
		arg_355_1.duration_ = 11.23

		local var_355_0 = {
			ja = 11.233,
			ko = 9.266,
			zh = 9.266
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
				arg_355_0:Play121481087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_1 = 0
			local var_358_2 = 0.75

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_3 = arg_355_1:FormatText(StoryNameCfg[378].name)

				arg_355_1.leftNameTxt_.text = var_358_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_4 = arg_355_1:GetWordFromCfg(121481086)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 30
				local var_358_7 = utf8.len(var_358_5)
				local var_358_8 = var_358_6 <= 0 and var_358_2 or var_358_2 * (var_358_7 / var_358_6)

				if var_358_8 > 0 and var_358_2 < var_358_8 then
					arg_355_1.talkMaxDuration = var_358_8

					if var_358_8 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481086", "story_v_out_121481.awb") ~= 0 then
					local var_358_9 = manager.audio:GetVoiceLength("story_v_out_121481", "121481086", "story_v_out_121481.awb") / 1000

					if var_358_9 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_1
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_out_121481", "121481086", "story_v_out_121481.awb")

						arg_355_1:RecordAudio("121481086", var_358_10)
						arg_355_1:RecordAudio("121481086", var_358_10)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_121481", "121481086", "story_v_out_121481.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_121481", "121481086", "story_v_out_121481.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_11 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_11 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_11

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_11 and arg_355_1.time_ < var_358_1 + var_358_11 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play121481087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 121481087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play121481088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1069ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1069ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1069ui_story, var_362_4, var_362_3)

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

			local var_362_9 = arg_359_1.actors_["1069ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1069ui_story == nil then
				arg_359_1.var_.characterEffect1069ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect1069ui_story and not isNil(var_362_9) then
					local var_362_13 = Mathf.Lerp(0, 0.5, var_362_12)

					arg_359_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1069ui_story.fillRatio = var_362_13
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect1069ui_story then
				local var_362_14 = 0.5

				arg_359_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1069ui_story.fillRatio = var_362_14
			end

			local var_362_15 = 0
			local var_362_16 = 0.633333333333333

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				local var_362_17 = "play"
				local var_362_18 = "effect"

				arg_359_1:AudioAction(var_362_17, var_362_18, "se_story_121_04", "se_story_121_04_jump2", "")
			end

			local var_362_19 = 0
			local var_362_20 = 1.425

			if var_362_19 < arg_359_1.time_ and arg_359_1.time_ <= var_362_19 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_21 = arg_359_1:GetWordFromCfg(121481087)
				local var_362_22 = arg_359_1:FormatText(var_362_21.content)

				arg_359_1.text_.text = var_362_22

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_23 = 57
				local var_362_24 = utf8.len(var_362_22)
				local var_362_25 = var_362_23 <= 0 and var_362_20 or var_362_20 * (var_362_24 / var_362_23)

				if var_362_25 > 0 and var_362_20 < var_362_25 then
					arg_359_1.talkMaxDuration = var_362_25

					if var_362_25 + var_362_19 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_25 + var_362_19
					end
				end

				arg_359_1.text_.text = var_362_22
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_26 = math.max(var_362_20, arg_359_1.talkMaxDuration)

			if var_362_19 <= arg_359_1.time_ and arg_359_1.time_ < var_362_19 + var_362_26 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_19) / var_362_26

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_19 + var_362_26 and arg_359_1.time_ < var_362_19 + var_362_26 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play121481088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 121481088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play121481089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.0666666666666667

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				local var_366_2 = "stop"
				local var_366_3 = "effect"

				arg_363_1:AudioAction(var_366_2, var_366_3, "se_story_121_04", "se_story_121_04_jump2", "")
			end

			local var_366_4 = 0.133333333333333
			local var_366_5 = 0.266666666666667

			if var_366_4 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				local var_366_6 = "play"
				local var_366_7 = "effect"

				arg_363_1:AudioAction(var_366_6, var_366_7, "se_story_121_04", "se_story_121_04_drill_loop", "")
			end

			local var_366_8 = 0
			local var_366_9 = 0.2

			if var_366_8 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:GetWordFromCfg(121481088)
				local var_366_11 = arg_363_1:FormatText(var_366_10.content)

				arg_363_1.text_.text = var_366_11

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 8
				local var_366_13 = utf8.len(var_366_11)
				local var_366_14 = var_366_12 <= 0 and var_366_9 or var_366_9 * (var_366_13 / var_366_12)

				if var_366_14 > 0 and var_366_9 < var_366_14 then
					arg_363_1.talkMaxDuration = var_366_14

					if var_366_14 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_11
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_15 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_15 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_15

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_15 and arg_363_1.time_ < var_366_8 + var_366_15 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play121481089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 121481089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play121481090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.1

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(121481089)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 44
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play121481090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 121481090
		arg_371_1.duration_ = 2.83

		local var_371_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_371_0:Play121481091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1069ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1069ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -1, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1069ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -1, -6)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1069ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1069ui_story == nil then
				arg_371_1.var_.characterEffect1069ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1069ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1069ui_story then
				arg_371_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_374_15 = 0
			local var_374_16 = 0.225

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[378].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(121481090)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 9
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481090", "story_v_out_121481.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_121481", "121481090", "story_v_out_121481.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_121481", "121481090", "story_v_out_121481.awb")

						arg_371_1:RecordAudio("121481090", var_374_24)
						arg_371_1:RecordAudio("121481090", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_121481", "121481090", "story_v_out_121481.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_121481", "121481090", "story_v_out_121481.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play121481091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 121481091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play121481092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1069ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1069ui_story == nil then
				arg_375_1.var_.characterEffect1069ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1069ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1069ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1069ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1069ui_story.fillRatio = var_378_5
			end

			local var_378_6 = 0
			local var_378_7 = 1.4

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_8 = arg_375_1:GetWordFromCfg(121481091)
				local var_378_9 = arg_375_1:FormatText(var_378_8.content)

				arg_375_1.text_.text = var_378_9

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 56
				local var_378_11 = utf8.len(var_378_9)
				local var_378_12 = var_378_10 <= 0 and var_378_7 or var_378_7 * (var_378_11 / var_378_10)

				if var_378_12 > 0 and var_378_7 < var_378_12 then
					arg_375_1.talkMaxDuration = var_378_12

					if var_378_12 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_12 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_9
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_13 and arg_375_1.time_ < var_378_6 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play121481092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 121481092
		arg_379_1.duration_ = 9.9

		local var_379_0 = {
			ja = 5.433,
			ko = 9.9,
			zh = 9.9
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
				arg_379_0:Play121481093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1069ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1069ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(0, -1, -6)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1069ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -1, -6)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1069ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1069ui_story == nil then
				arg_379_1.var_.characterEffect1069ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1069ui_story and not isNil(var_382_9) then
					arg_379_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1069ui_story then
				arg_379_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_382_13 = 0

			if var_382_13 < arg_379_1.time_ and arg_379_1.time_ <= var_382_13 + arg_382_0 then
				arg_379_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_382_14 = 0

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_382_15 = 0
			local var_382_16 = 0.034000001847744

			if var_382_15 < arg_379_1.time_ and arg_379_1.time_ <= var_382_15 + arg_382_0 then
				local var_382_17 = "play"
				local var_382_18 = "music"

				arg_379_1:AudioAction(var_382_17, var_382_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_382_19 = ""
				local var_382_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_382_20 ~= "" then
					if arg_379_1.bgmTxt_.text ~= var_382_20 and arg_379_1.bgmTxt_.text ~= "" then
						if arg_379_1.bgmTxt2_.text ~= "" then
							arg_379_1.bgmTxt_.text = arg_379_1.bgmTxt2_.text
						end

						arg_379_1.bgmTxt2_.text = var_382_20

						arg_379_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_379_1.bgmTxt_.text = var_382_20
						arg_379_1.bgmTxt2_.text = var_382_20
					end

					if arg_379_1.bgmTimer then
						arg_379_1.bgmTimer:Stop()

						arg_379_1.bgmTimer = nil
					end

					if arg_379_1.settingData.show_music_name == 1 then
						arg_379_1.musicController:SetSelectedState("show")
						arg_379_1.musicAnimator_:Play("open", 0, 0)

						if arg_379_1.settingData.music_time ~= 0 then
							arg_379_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_379_1.settingData.music_time), function()
								if arg_379_1 == nil or isNil(arg_379_1.bgmTxt_) then
									return
								end

								arg_379_1.musicController:SetSelectedState("hide")
								arg_379_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_382_21 = 0.133333333333333
			local var_382_22 = 1

			if var_382_21 < arg_379_1.time_ and arg_379_1.time_ <= var_382_21 + arg_382_0 then
				local var_382_23 = "play"
				local var_382_24 = "music"

				arg_379_1:AudioAction(var_382_23, var_382_24, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_382_25 = ""
				local var_382_26 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if var_382_26 ~= "" then
					if arg_379_1.bgmTxt_.text ~= var_382_26 and arg_379_1.bgmTxt_.text ~= "" then
						if arg_379_1.bgmTxt2_.text ~= "" then
							arg_379_1.bgmTxt_.text = arg_379_1.bgmTxt2_.text
						end

						arg_379_1.bgmTxt2_.text = var_382_26

						arg_379_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_379_1.bgmTxt_.text = var_382_26
						arg_379_1.bgmTxt2_.text = var_382_26
					end

					if arg_379_1.bgmTimer then
						arg_379_1.bgmTimer:Stop()

						arg_379_1.bgmTimer = nil
					end

					if arg_379_1.settingData.show_music_name == 1 then
						arg_379_1.musicController:SetSelectedState("show")
						arg_379_1.musicAnimator_:Play("open", 0, 0)

						if arg_379_1.settingData.music_time ~= 0 then
							arg_379_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_379_1.settingData.music_time), function()
								if arg_379_1 == nil or isNil(arg_379_1.bgmTxt_) then
									return
								end

								arg_379_1.musicController:SetSelectedState("hide")
								arg_379_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_382_27 = 0
			local var_382_28 = 0.75

			if var_382_27 < arg_379_1.time_ and arg_379_1.time_ <= var_382_27 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_29 = arg_379_1:FormatText(StoryNameCfg[378].name)

				arg_379_1.leftNameTxt_.text = var_382_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_30 = arg_379_1:GetWordFromCfg(121481092)
				local var_382_31 = arg_379_1:FormatText(var_382_30.content)

				arg_379_1.text_.text = var_382_31

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_32 = 30
				local var_382_33 = utf8.len(var_382_31)
				local var_382_34 = var_382_32 <= 0 and var_382_28 or var_382_28 * (var_382_33 / var_382_32)

				if var_382_34 > 0 and var_382_28 < var_382_34 then
					arg_379_1.talkMaxDuration = var_382_34

					if var_382_34 + var_382_27 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_34 + var_382_27
					end
				end

				arg_379_1.text_.text = var_382_31
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481092", "story_v_out_121481.awb") ~= 0 then
					local var_382_35 = manager.audio:GetVoiceLength("story_v_out_121481", "121481092", "story_v_out_121481.awb") / 1000

					if var_382_35 + var_382_27 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_35 + var_382_27
					end

					if var_382_30.prefab_name ~= "" and arg_379_1.actors_[var_382_30.prefab_name] ~= nil then
						local var_382_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_30.prefab_name].transform, "story_v_out_121481", "121481092", "story_v_out_121481.awb")

						arg_379_1:RecordAudio("121481092", var_382_36)
						arg_379_1:RecordAudio("121481092", var_382_36)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_121481", "121481092", "story_v_out_121481.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_121481", "121481092", "story_v_out_121481.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_37 = math.max(var_382_28, arg_379_1.talkMaxDuration)

			if var_382_27 <= arg_379_1.time_ and arg_379_1.time_ < var_382_27 + var_382_37 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_27) / var_382_37

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_27 + var_382_37 and arg_379_1.time_ < var_382_27 + var_382_37 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play121481093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 121481093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play121481094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1069ui_story"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1069ui_story = var_388_0.localPosition
			end

			local var_388_2 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2
				local var_388_4 = Vector3.New(0, 100, 0)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1069ui_story, var_388_4, var_388_3)

				local var_388_5 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_5.x, var_388_5.y, var_388_5.z)

				local var_388_6 = var_388_0.localEulerAngles

				var_388_6.z = 0
				var_388_6.x = 0
				var_388_0.localEulerAngles = var_388_6
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, 100, 0)

				local var_388_7 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_7.x, var_388_7.y, var_388_7.z)

				local var_388_8 = var_388_0.localEulerAngles

				var_388_8.z = 0
				var_388_8.x = 0
				var_388_0.localEulerAngles = var_388_8
			end

			local var_388_9 = 0
			local var_388_10 = 0.633333333333333

			if var_388_9 < arg_385_1.time_ and arg_385_1.time_ <= var_388_9 + arg_388_0 then
				local var_388_11 = "play"
				local var_388_12 = "effect"

				arg_385_1:AudioAction(var_388_11, var_388_12, "se_story_121_04", "se_story_121_04_deformation", "")
			end

			local var_388_13 = 0
			local var_388_14 = 0.433333333333333

			if var_388_13 < arg_385_1.time_ and arg_385_1.time_ <= var_388_13 + arg_388_0 then
				local var_388_15 = "stop"
				local var_388_16 = "effect"

				arg_385_1:AudioAction(var_388_15, var_388_16, "se_story_121_04", "se_story_121_04_drill_loop", "")
			end

			local var_388_17 = 0
			local var_388_18 = 1.75

			if var_388_17 < arg_385_1.time_ and arg_385_1.time_ <= var_388_17 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_19 = arg_385_1:GetWordFromCfg(121481093)
				local var_388_20 = arg_385_1:FormatText(var_388_19.content)

				arg_385_1.text_.text = var_388_20

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_21 = 70
				local var_388_22 = utf8.len(var_388_20)
				local var_388_23 = var_388_21 <= 0 and var_388_18 or var_388_18 * (var_388_22 / var_388_21)

				if var_388_23 > 0 and var_388_18 < var_388_23 then
					arg_385_1.talkMaxDuration = var_388_23

					if var_388_23 + var_388_17 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_23 + var_388_17
					end
				end

				arg_385_1.text_.text = var_388_20
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_24 = math.max(var_388_18, arg_385_1.talkMaxDuration)

			if var_388_17 <= arg_385_1.time_ and arg_385_1.time_ < var_388_17 + var_388_24 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_17) / var_388_24

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_17 + var_388_24 and arg_385_1.time_ < var_388_17 + var_388_24 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play121481094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 121481094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play121481095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.1

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				local var_392_2 = "stop"
				local var_392_3 = "effect"

				arg_389_1:AudioAction(var_392_2, var_392_3, "se_story_121_04", "se_story_121_04_deformation", "")
			end

			local var_392_4 = 0.2
			local var_392_5 = 0.533333333333333

			if var_392_4 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				local var_392_6 = "play"
				local var_392_7 = "effect"

				arg_389_1:AudioAction(var_392_6, var_392_7, "se_story_121_04", "se_story_121_04_bow", "")
			end

			local var_392_8 = 0
			local var_392_9 = 1.575

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:GetWordFromCfg(121481094)
				local var_392_11 = arg_389_1:FormatText(var_392_10.content)

				arg_389_1.text_.text = var_392_11

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_12 = 63
				local var_392_13 = utf8.len(var_392_11)
				local var_392_14 = var_392_12 <= 0 and var_392_9 or var_392_9 * (var_392_13 / var_392_12)

				if var_392_14 > 0 and var_392_9 < var_392_14 then
					arg_389_1.talkMaxDuration = var_392_14

					if var_392_14 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_11
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_15 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_15 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_15

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_15 and arg_389_1.time_ < var_392_8 + var_392_15 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play121481095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 121481095
		arg_393_1.duration_ = 4.83

		local var_393_0 = {
			ja = 4.833,
			ko = 3.033,
			zh = 3.033
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
				arg_393_0:Play121481096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.35

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[378].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(121481095)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481095", "story_v_out_121481.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481095", "story_v_out_121481.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_out_121481", "121481095", "story_v_out_121481.awb")

						arg_393_1:RecordAudio("121481095", var_396_9)
						arg_393_1:RecordAudio("121481095", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_121481", "121481095", "story_v_out_121481.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_121481", "121481095", "story_v_out_121481.awb")
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
	Play121481096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 121481096
		arg_397_1.duration_ = 6.37

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play121481097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.0666666666666667

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				local var_400_2 = "stop"
				local var_400_3 = "music"

				arg_397_1:AudioAction(var_400_2, var_400_3, "se_story_121_04", "se_story_121_04_bow", "")

				local var_400_4 = ""
				local var_400_5 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_bow")

				if var_400_5 ~= "" then
					if arg_397_1.bgmTxt_.text ~= var_400_5 and arg_397_1.bgmTxt_.text ~= "" then
						if arg_397_1.bgmTxt2_.text ~= "" then
							arg_397_1.bgmTxt_.text = arg_397_1.bgmTxt2_.text
						end

						arg_397_1.bgmTxt2_.text = var_400_5

						arg_397_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_397_1.bgmTxt_.text = var_400_5
						arg_397_1.bgmTxt2_.text = var_400_5
					end

					if arg_397_1.bgmTimer then
						arg_397_1.bgmTimer:Stop()

						arg_397_1.bgmTimer = nil
					end

					if arg_397_1.settingData.show_music_name == 1 then
						arg_397_1.musicController:SetSelectedState("show")
						arg_397_1.musicAnimator_:Play("open", 0, 0)

						if arg_397_1.settingData.music_time ~= 0 then
							arg_397_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_397_1.settingData.music_time), function()
								if arg_397_1 == nil or isNil(arg_397_1.bgmTxt_) then
									return
								end

								arg_397_1.musicController:SetSelectedState("hide")
								arg_397_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_400_6 = 0.0999999999999999
			local var_400_7 = 0.633333333333333

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				local var_400_8 = "play"
				local var_400_9 = "effect"

				arg_397_1:AudioAction(var_400_8, var_400_9, "se_story_121_04", "se_story_121_04_bowhit1", "")
			end

			local var_400_10 = 0

			if var_400_10 < arg_397_1.time_ and arg_397_1.time_ <= var_400_10 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_11 = 2

			if var_400_10 <= arg_397_1.time_ and arg_397_1.time_ < var_400_10 + var_400_11 then
				local var_400_12 = (arg_397_1.time_ - var_400_10) / var_400_11
				local var_400_13 = Color.New(1, 1, 1)

				var_400_13.a = Mathf.Lerp(1, 0, var_400_12)
				arg_397_1.mask_.color = var_400_13
			end

			if arg_397_1.time_ >= var_400_10 + var_400_11 and arg_397_1.time_ < var_400_10 + var_400_11 + arg_400_0 then
				local var_400_14 = Color.New(1, 1, 1)
				local var_400_15 = 0

				arg_397_1.mask_.enabled = false
				var_400_14.a = var_400_15
				arg_397_1.mask_.color = var_400_14
			end

			local var_400_16 = manager.ui.mainCamera.transform
			local var_400_17 = 0

			if var_400_17 < arg_397_1.time_ and arg_397_1.time_ <= var_400_17 + arg_400_0 then
				arg_397_1.var_.shakeOldPos = var_400_16.localPosition
			end

			local var_400_18 = 1

			if var_400_17 <= arg_397_1.time_ and arg_397_1.time_ < var_400_17 + var_400_18 then
				local var_400_19 = (arg_397_1.time_ - var_400_17) / 0.066
				local var_400_20, var_400_21 = math.modf(var_400_19)

				var_400_16.localPosition = Vector3.New(var_400_21 * 0.13, var_400_21 * 0.13, var_400_21 * 0.13) + arg_397_1.var_.shakeOldPos
			end

			if arg_397_1.time_ >= var_400_17 + var_400_18 and arg_397_1.time_ < var_400_17 + var_400_18 + arg_400_0 then
				var_400_16.localPosition = arg_397_1.var_.shakeOldPos
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_22 = 1.36666666666667
			local var_400_23 = 1.375

			if var_400_22 < arg_397_1.time_ and arg_397_1.time_ <= var_400_22 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_24 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_24:setOnUpdate(LuaHelper.FloatAction(function(arg_402_0)
					arg_397_1.dialogCg_.alpha = arg_402_0
				end))
				var_400_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_25 = arg_397_1:GetWordFromCfg(121481096)
				local var_400_26 = arg_397_1:FormatText(var_400_25.content)

				arg_397_1.text_.text = var_400_26

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_27 = 55
				local var_400_28 = utf8.len(var_400_26)
				local var_400_29 = var_400_27 <= 0 and var_400_23 or var_400_23 * (var_400_28 / var_400_27)

				if var_400_29 > 0 and var_400_23 < var_400_29 then
					arg_397_1.talkMaxDuration = var_400_29
					var_400_22 = var_400_22 + 0.3

					if var_400_29 + var_400_22 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_29 + var_400_22
					end
				end

				arg_397_1.text_.text = var_400_26
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_30 = var_400_22 + 0.3
			local var_400_31 = math.max(var_400_23, arg_397_1.talkMaxDuration)

			if var_400_30 <= arg_397_1.time_ and arg_397_1.time_ < var_400_30 + var_400_31 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_30) / var_400_31

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_30 + var_400_31 and arg_397_1.time_ < var_400_30 + var_400_31 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play121481097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 121481097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play121481098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.133333333333333
			local var_407_1 = 0.633333333333333

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				local var_407_2 = "play"
				local var_407_3 = "effect"

				arg_404_1:AudioAction(var_407_2, var_407_3, "se_story_121_04", "se_story_121_04_weaponstart", "")
			end

			local var_407_4 = 0
			local var_407_5 = 1.225

			if var_407_4 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(121481097)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_8 = 49
				local var_407_9 = utf8.len(var_407_7)
				local var_407_10 = var_407_8 <= 0 and var_407_5 or var_407_5 * (var_407_9 / var_407_8)

				if var_407_10 > 0 and var_407_5 < var_407_10 then
					arg_404_1.talkMaxDuration = var_407_10

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_11 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_11 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_11

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_11 and arg_404_1.time_ < var_407_4 + var_407_11 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play121481098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 121481098
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play121481099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.925

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(121481098)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 37
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play121481099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 121481099
		arg_412_1.duration_ = 4.83

		local var_412_0 = {
			ja = 4.833,
			ko = 2.8,
			zh = 2.8
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play121481100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = "10045ui_story"

			if arg_412_1.actors_[var_415_0] == nil then
				local var_415_1 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_415_1) then
					local var_415_2 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_412_1.stage_.transform)

					var_415_2.name = var_415_0
					var_415_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_412_1.actors_[var_415_0] = var_415_2

					local var_415_3 = var_415_2:GetComponentInChildren(typeof(CharacterEffect))

					var_415_3.enabled = true

					local var_415_4 = GameObjectTools.GetOrAddComponent(var_415_2, typeof(DynamicBoneHelper))

					if var_415_4 then
						var_415_4:EnableDynamicBone(false)
					end

					arg_412_1:ShowWeapon(var_415_3.transform, false)

					arg_412_1.var_[var_415_0 .. "Animator"] = var_415_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_412_1.var_[var_415_0 .. "Animator"].applyRootMotion = true
					arg_412_1.var_[var_415_0 .. "LipSync"] = var_415_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_415_5 = arg_412_1.actors_["10045ui_story"].transform
			local var_415_6 = 0

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.var_.moveOldPos10045ui_story = var_415_5.localPosition
			end

			local var_415_7 = 0.001

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_7 then
				local var_415_8 = (arg_412_1.time_ - var_415_6) / var_415_7
				local var_415_9 = Vector3.New(0, -1.18, -6.05)

				var_415_5.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10045ui_story, var_415_9, var_415_8)

				local var_415_10 = manager.ui.mainCamera.transform.position - var_415_5.position

				var_415_5.forward = Vector3.New(var_415_10.x, var_415_10.y, var_415_10.z)

				local var_415_11 = var_415_5.localEulerAngles

				var_415_11.z = 0
				var_415_11.x = 0
				var_415_5.localEulerAngles = var_415_11
			end

			if arg_412_1.time_ >= var_415_6 + var_415_7 and arg_412_1.time_ < var_415_6 + var_415_7 + arg_415_0 then
				var_415_5.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_415_12 = manager.ui.mainCamera.transform.position - var_415_5.position

				var_415_5.forward = Vector3.New(var_415_12.x, var_415_12.y, var_415_12.z)

				local var_415_13 = var_415_5.localEulerAngles

				var_415_13.z = 0
				var_415_13.x = 0
				var_415_5.localEulerAngles = var_415_13
			end

			local var_415_14 = arg_412_1.actors_["10045ui_story"]
			local var_415_15 = 0

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 and not isNil(var_415_14) and arg_412_1.var_.characterEffect10045ui_story == nil then
				arg_412_1.var_.characterEffect10045ui_story = var_415_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_16 = 0.200000002980232

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_16 and not isNil(var_415_14) then
				local var_415_17 = (arg_412_1.time_ - var_415_15) / var_415_16

				if arg_412_1.var_.characterEffect10045ui_story and not isNil(var_415_14) then
					arg_412_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_15 + var_415_16 and arg_412_1.time_ < var_415_15 + var_415_16 + arg_415_0 and not isNil(var_415_14) and arg_412_1.var_.characterEffect10045ui_story then
				arg_412_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_415_18 = 0

			if var_415_18 < arg_412_1.time_ and arg_412_1.time_ <= var_415_18 + arg_415_0 then
				arg_412_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			local var_415_19 = 0

			if var_415_19 < arg_412_1.time_ and arg_412_1.time_ <= var_415_19 + arg_415_0 then
				arg_412_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_415_20 = 0
			local var_415_21 = 0.325

			if var_415_20 < arg_412_1.time_ and arg_412_1.time_ <= var_415_20 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_22 = arg_412_1:FormatText(StoryNameCfg[412].name)

				arg_412_1.leftNameTxt_.text = var_415_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_23 = arg_412_1:GetWordFromCfg(121481099)
				local var_415_24 = arg_412_1:FormatText(var_415_23.content)

				arg_412_1.text_.text = var_415_24

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_25 = 13
				local var_415_26 = utf8.len(var_415_24)
				local var_415_27 = var_415_25 <= 0 and var_415_21 or var_415_21 * (var_415_26 / var_415_25)

				if var_415_27 > 0 and var_415_21 < var_415_27 then
					arg_412_1.talkMaxDuration = var_415_27

					if var_415_27 + var_415_20 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_27 + var_415_20
					end
				end

				arg_412_1.text_.text = var_415_24
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481099", "story_v_out_121481.awb") ~= 0 then
					local var_415_28 = manager.audio:GetVoiceLength("story_v_out_121481", "121481099", "story_v_out_121481.awb") / 1000

					if var_415_28 + var_415_20 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_28 + var_415_20
					end

					if var_415_23.prefab_name ~= "" and arg_412_1.actors_[var_415_23.prefab_name] ~= nil then
						local var_415_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_23.prefab_name].transform, "story_v_out_121481", "121481099", "story_v_out_121481.awb")

						arg_412_1:RecordAudio("121481099", var_415_29)
						arg_412_1:RecordAudio("121481099", var_415_29)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_121481", "121481099", "story_v_out_121481.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_121481", "121481099", "story_v_out_121481.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_30 = math.max(var_415_21, arg_412_1.talkMaxDuration)

			if var_415_20 <= arg_412_1.time_ and arg_412_1.time_ < var_415_20 + var_415_30 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_20) / var_415_30

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_20 + var_415_30 and arg_412_1.time_ < var_415_20 + var_415_30 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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

		arg_412_1:InitPlayNodeList()
	end,
	Play121481100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 121481100
		arg_416_1.duration_ = 3.67

		local var_416_0 = {
			ja = 3.166,
			ko = 3.666,
			zh = 3.666
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play121481101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10045ui_story"].transform
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.var_.moveOldPos10045ui_story = var_419_0.localPosition
			end

			local var_419_2 = 0.001

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2
				local var_419_4 = Vector3.New(0, -1.18, -6.05)

				var_419_0.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10045ui_story, var_419_4, var_419_3)

				local var_419_5 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_5.x, var_419_5.y, var_419_5.z)

				local var_419_6 = var_419_0.localEulerAngles

				var_419_6.z = 0
				var_419_6.x = 0
				var_419_0.localEulerAngles = var_419_6
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 then
				var_419_0.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_419_7 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_7.x, var_419_7.y, var_419_7.z)

				local var_419_8 = var_419_0.localEulerAngles

				var_419_8.z = 0
				var_419_8.x = 0
				var_419_0.localEulerAngles = var_419_8
			end

			local var_419_9 = arg_416_1.actors_["10045ui_story"]
			local var_419_10 = 0

			if var_419_10 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect10045ui_story == nil then
				arg_416_1.var_.characterEffect10045ui_story = var_419_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_11 = 0.200000002980232

			if var_419_10 <= arg_416_1.time_ and arg_416_1.time_ < var_419_10 + var_419_11 and not isNil(var_419_9) then
				local var_419_12 = (arg_416_1.time_ - var_419_10) / var_419_11

				if arg_416_1.var_.characterEffect10045ui_story and not isNil(var_419_9) then
					arg_416_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_10 + var_419_11 and arg_416_1.time_ < var_419_10 + var_419_11 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect10045ui_story then
				arg_416_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_419_13 = 0

			if var_419_13 < arg_416_1.time_ and arg_416_1.time_ <= var_419_13 + arg_419_0 then
				arg_416_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			local var_419_14 = 0

			if var_419_14 < arg_416_1.time_ and arg_416_1.time_ <= var_419_14 + arg_419_0 then
				arg_416_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_419_15 = 0
			local var_419_16 = 0.4

			if var_419_15 < arg_416_1.time_ and arg_416_1.time_ <= var_419_15 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_17 = arg_416_1:FormatText(StoryNameCfg[412].name)

				arg_416_1.leftNameTxt_.text = var_419_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_18 = arg_416_1:GetWordFromCfg(121481100)
				local var_419_19 = arg_416_1:FormatText(var_419_18.content)

				arg_416_1.text_.text = var_419_19

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_20 = 16
				local var_419_21 = utf8.len(var_419_19)
				local var_419_22 = var_419_20 <= 0 and var_419_16 or var_419_16 * (var_419_21 / var_419_20)

				if var_419_22 > 0 and var_419_16 < var_419_22 then
					arg_416_1.talkMaxDuration = var_419_22

					if var_419_22 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_22 + var_419_15
					end
				end

				arg_416_1.text_.text = var_419_19
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481100", "story_v_out_121481.awb") ~= 0 then
					local var_419_23 = manager.audio:GetVoiceLength("story_v_out_121481", "121481100", "story_v_out_121481.awb") / 1000

					if var_419_23 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_23 + var_419_15
					end

					if var_419_18.prefab_name ~= "" and arg_416_1.actors_[var_419_18.prefab_name] ~= nil then
						local var_419_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_18.prefab_name].transform, "story_v_out_121481", "121481100", "story_v_out_121481.awb")

						arg_416_1:RecordAudio("121481100", var_419_24)
						arg_416_1:RecordAudio("121481100", var_419_24)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_121481", "121481100", "story_v_out_121481.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_121481", "121481100", "story_v_out_121481.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_25 = math.max(var_419_16, arg_416_1.talkMaxDuration)

			if var_419_15 <= arg_416_1.time_ and arg_416_1.time_ < var_419_15 + var_419_25 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_15) / var_419_25

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_15 + var_419_25 and arg_416_1.time_ < var_419_15 + var_419_25 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play121481101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 121481101
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play121481102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10045ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10045ui_story == nil then
				arg_420_1.var_.characterEffect10045ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10045ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10045ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10045ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10045ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.975

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_8 = arg_420_1:GetWordFromCfg(121481101)
				local var_423_9 = arg_420_1:FormatText(var_423_8.content)

				arg_420_1.text_.text = var_423_9

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_10 = 39
				local var_423_11 = utf8.len(var_423_9)
				local var_423_12 = var_423_10 <= 0 and var_423_7 or var_423_7 * (var_423_11 / var_423_10)

				if var_423_12 > 0 and var_423_7 < var_423_12 then
					arg_420_1.talkMaxDuration = var_423_12

					if var_423_12 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_9
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_13 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_13 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_13

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_13 and arg_420_1.time_ < var_423_6 + var_423_13 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play121481102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 121481102
		arg_424_1.duration_ = 4.07

		local var_424_0 = {
			ja = 4.066,
			ko = 3.366,
			zh = 3.366
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play121481103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10045ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10045ui_story == nil then
				arg_424_1.var_.characterEffect10045ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect10045ui_story and not isNil(var_427_0) then
					arg_424_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10045ui_story then
				arg_424_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_427_4 = 0

			if var_427_4 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action4_1")
			end

			local var_427_5 = 0

			if var_427_5 < arg_424_1.time_ and arg_424_1.time_ <= var_427_5 + arg_427_0 then
				arg_424_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_427_6 = 0
			local var_427_7 = 0.225

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[412].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_9 = arg_424_1:GetWordFromCfg(121481102)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 9
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481102", "story_v_out_121481.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_121481", "121481102", "story_v_out_121481.awb") / 1000

					if var_427_14 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_6
					end

					if var_427_9.prefab_name ~= "" and arg_424_1.actors_[var_427_9.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_9.prefab_name].transform, "story_v_out_121481", "121481102", "story_v_out_121481.awb")

						arg_424_1:RecordAudio("121481102", var_427_15)
						arg_424_1:RecordAudio("121481102", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_121481", "121481102", "story_v_out_121481.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_121481", "121481102", "story_v_out_121481.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_16 and arg_424_1.time_ < var_427_6 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play121481103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 121481103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play121481104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10045ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos10045ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0, 100, 0)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10045ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, 100, 0)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = arg_428_1.actors_["10045ui_story"]
			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect10045ui_story == nil then
				arg_428_1.var_.characterEffect10045ui_story = var_431_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_11 = 0.200000002980232

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_11 and not isNil(var_431_9) then
				local var_431_12 = (arg_428_1.time_ - var_431_10) / var_431_11

				if arg_428_1.var_.characterEffect10045ui_story and not isNil(var_431_9) then
					local var_431_13 = Mathf.Lerp(0, 0.5, var_431_12)

					arg_428_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10045ui_story.fillRatio = var_431_13
				end
			end

			if arg_428_1.time_ >= var_431_10 + var_431_11 and arg_428_1.time_ < var_431_10 + var_431_11 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect10045ui_story then
				local var_431_14 = 0.5

				arg_428_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10045ui_story.fillRatio = var_431_14
			end

			local var_431_15 = 0
			local var_431_16 = 1.1

			if var_431_15 < arg_428_1.time_ and arg_428_1.time_ <= var_431_15 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_17 = arg_428_1:GetWordFromCfg(121481103)
				local var_431_18 = arg_428_1:FormatText(var_431_17.content)

				arg_428_1.text_.text = var_431_18

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_19 = 44
				local var_431_20 = utf8.len(var_431_18)
				local var_431_21 = var_431_19 <= 0 and var_431_16 or var_431_16 * (var_431_20 / var_431_19)

				if var_431_21 > 0 and var_431_16 < var_431_21 then
					arg_428_1.talkMaxDuration = var_431_21

					if var_431_21 + var_431_15 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_21 + var_431_15
					end
				end

				arg_428_1.text_.text = var_431_18
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_22 = math.max(var_431_16, arg_428_1.talkMaxDuration)

			if var_431_15 <= arg_428_1.time_ and arg_428_1.time_ < var_431_15 + var_431_22 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_15) / var_431_22

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_15 + var_431_22 and arg_428_1.time_ < var_431_15 + var_431_22 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play121481104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 121481104
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play121481105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.633333333333333

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				local var_435_2 = "play"
				local var_435_3 = "effect"

				arg_432_1:AudioAction(var_435_2, var_435_3, "se_story_16", "se_story_16_thunder", "")
			end

			local var_435_4 = 0
			local var_435_5 = 1.1

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_6 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_6:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_7 = arg_432_1:GetWordFromCfg(121481104)
				local var_435_8 = arg_432_1:FormatText(var_435_7.content)

				arg_432_1.text_.text = var_435_8

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_9 = 44
				local var_435_10 = utf8.len(var_435_8)
				local var_435_11 = var_435_9 <= 0 and var_435_5 or var_435_5 * (var_435_10 / var_435_9)

				if var_435_11 > 0 and var_435_5 < var_435_11 then
					arg_432_1.talkMaxDuration = var_435_11
					var_435_4 = var_435_4 + 0.3

					if var_435_11 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_4
					end
				end

				arg_432_1.text_.text = var_435_8
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_12 = var_435_4 + 0.3
			local var_435_13 = math.max(var_435_5, arg_432_1.talkMaxDuration)

			if var_435_12 <= arg_432_1.time_ and arg_432_1.time_ < var_435_12 + var_435_13 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_12) / var_435_13

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_12 + var_435_13 and arg_432_1.time_ < var_435_12 + var_435_13 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play121481105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 121481105
		arg_438_1.duration_ = 7

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play121481106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = manager.ui.mainCamera.transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.shakeOldPos = var_441_0.localPosition
			end

			local var_441_2 = 2

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / 0.066
				local var_441_4, var_441_5 = math.modf(var_441_3)

				var_441_0.localPosition = Vector3.New(var_441_5 * 0.13, var_441_5 * 0.13, var_441_5 * 0.13) + arg_438_1.var_.shakeOldPos
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = arg_438_1.var_.shakeOldPos
			end

			local var_441_6 = 0

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = false

				arg_438_1:SetGaussion(false)
			end

			local var_441_7 = 2

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_7 then
				local var_441_8 = (arg_438_1.time_ - var_441_6) / var_441_7
				local var_441_9 = Color.New(1, 1, 1)

				var_441_9.a = Mathf.Lerp(1, 0, var_441_8)
				arg_438_1.mask_.color = var_441_9
			end

			if arg_438_1.time_ >= var_441_6 + var_441_7 and arg_438_1.time_ < var_441_6 + var_441_7 + arg_441_0 then
				local var_441_10 = Color.New(1, 1, 1)
				local var_441_11 = 0

				arg_438_1.mask_.enabled = false
				var_441_10.a = var_441_11
				arg_438_1.mask_.color = var_441_10
			end

			local var_441_12 = "J02h_blur"

			if arg_438_1.bgs_[var_441_12] == nil then
				local var_441_13 = Object.Instantiate(arg_438_1.blurPaintGo_)
				local var_441_14 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_441_12)

				var_441_13:GetComponent("SpriteRenderer").sprite = var_441_14
				var_441_13.name = var_441_12
				var_441_13.transform.parent = arg_438_1.stage_.transform
				var_441_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_438_1.bgs_[var_441_12] = var_441_13
			end

			local var_441_15 = 0
			local var_441_16 = arg_438_1.bgs_[var_441_12]

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				local var_441_17 = manager.ui.mainCamera.transform.localPosition
				local var_441_18 = Vector3.New(0, 0, 10) + Vector3.New(var_441_17.x, var_441_17.y, 0)

				var_441_16.transform.localPosition = var_441_18
				var_441_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_441_19 = var_441_16:GetComponent("SpriteRenderer")

				if var_441_19 and var_441_19.sprite then
					local var_441_20 = (var_441_16.transform.localPosition - var_441_17).z
					local var_441_21 = manager.ui.mainCameraCom_
					local var_441_22 = 2 * var_441_20 * Mathf.Tan(var_441_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_441_23 = var_441_22 * var_441_21.aspect
					local var_441_24 = var_441_19.sprite.bounds.size.x
					local var_441_25 = var_441_19.sprite.bounds.size.y
					local var_441_26 = var_441_23 / var_441_24
					local var_441_27 = var_441_22 / var_441_25
					local var_441_28 = var_441_27 < var_441_26 and var_441_26 or var_441_27

					var_441_16.transform.localScale = Vector3.New(var_441_28, var_441_28, 0)
				end
			end

			local var_441_29 = 3

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_29 then
				local var_441_30 = (arg_438_1.time_ - var_441_15) / var_441_29
				local var_441_31 = Color.New(1, 1, 1)

				var_441_31.a = Mathf.Lerp(0, 1, var_441_30)

				var_441_16:GetComponent("SpriteRenderer").material:SetColor("_Color", var_441_31)
			end

			local var_441_32 = 0.333333333333333
			local var_441_33 = 0.633333333333333

			if var_441_32 < arg_438_1.time_ and arg_438_1.time_ <= var_441_32 + arg_441_0 then
				local var_441_34 = "play"
				local var_441_35 = "effect"

				arg_438_1:AudioAction(var_441_34, var_441_35, "se_story_16", "se_story_16_hit", "")
			end

			if arg_438_1.frameCnt_ <= 1 then
				arg_438_1.dialog_:SetActive(false)
			end

			local var_441_36 = 2
			local var_441_37 = 1.8

			if var_441_36 < arg_438_1.time_ and arg_438_1.time_ <= var_441_36 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0

				arg_438_1.dialog_:SetActive(true)

				arg_438_1.dialogCg_.alpha = 0

				local var_441_38 = LeanTween.value(arg_438_1.dialog_, 0, 1, 0.3)

				var_441_38:setOnUpdate(LuaHelper.FloatAction(function(arg_442_0)
					arg_438_1.dialogCg_.alpha = arg_442_0
				end))
				var_441_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_438_1.dialog_)
					var_441_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_438_1.duration_ = arg_438_1.duration_ + 0.3

				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_39 = arg_438_1:GetWordFromCfg(121481105)
				local var_441_40 = arg_438_1:FormatText(var_441_39.content)

				arg_438_1.text_.text = var_441_40

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_41 = 72
				local var_441_42 = utf8.len(var_441_40)
				local var_441_43 = var_441_41 <= 0 and var_441_37 or var_441_37 * (var_441_42 / var_441_41)

				if var_441_43 > 0 and var_441_37 < var_441_43 then
					arg_438_1.talkMaxDuration = var_441_43
					var_441_36 = var_441_36 + 0.3

					if var_441_43 + var_441_36 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_43 + var_441_36
					end
				end

				arg_438_1.text_.text = var_441_40
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_44 = var_441_36 + 0.3
			local var_441_45 = math.max(var_441_37, arg_438_1.talkMaxDuration)

			if var_441_44 <= arg_438_1.time_ and arg_438_1.time_ < var_441_44 + var_441_45 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_44) / var_441_45

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_44 + var_441_45 and arg_438_1.time_ < var_441_44 + var_441_45 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play121481106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 121481106
		arg_444_1.duration_ = 6.8

		local var_444_0 = {
			ja = 3.7,
			ko = 6.8,
			zh = 6.8
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play121481107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.2

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[412].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:GetWordFromCfg(121481106)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 8
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481106", "story_v_out_121481.awb") ~= 0 then
					local var_447_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481106", "story_v_out_121481.awb") / 1000

					if var_447_8 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_0
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_out_121481", "121481106", "story_v_out_121481.awb")

						arg_444_1:RecordAudio("121481106", var_447_9)
						arg_444_1:RecordAudio("121481106", var_447_9)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_121481", "121481106", "story_v_out_121481.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_121481", "121481106", "story_v_out_121481.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_10 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_10 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_10

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_10 and arg_444_1.time_ < var_447_0 + var_447_10 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play121481107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 121481107
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play121481108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 1.3

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(121481107)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 52
				local var_451_5 = utf8.len(var_451_3)
				local var_451_6 = var_451_4 <= 0 and var_451_1 or var_451_1 * (var_451_5 / var_451_4)

				if var_451_6 > 0 and var_451_1 < var_451_6 then
					arg_448_1.talkMaxDuration = var_451_6

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_7 and arg_448_1.time_ < var_451_0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play121481108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 121481108
		arg_452_1.duration_ = 7.7

		local var_452_0 = {
			ja = 4.333,
			ko = 7.7,
			zh = 7.7
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play121481109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.775

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[378].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(121481108)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 31
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481108", "story_v_out_121481.awb") ~= 0 then
					local var_455_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481108", "story_v_out_121481.awb") / 1000

					if var_455_8 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_0
					end

					if var_455_3.prefab_name ~= "" and arg_452_1.actors_[var_455_3.prefab_name] ~= nil then
						local var_455_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_3.prefab_name].transform, "story_v_out_121481", "121481108", "story_v_out_121481.awb")

						arg_452_1:RecordAudio("121481108", var_455_9)
						arg_452_1:RecordAudio("121481108", var_455_9)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_121481", "121481108", "story_v_out_121481.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_121481", "121481108", "story_v_out_121481.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_10 and arg_452_1.time_ < var_455_0 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play121481109 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 121481109
		arg_456_1.duration_ = 3.17

		local var_456_0 = {
			ja = 2.766666666666,
			ko = 3.166,
			zh = 3.166
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play121481110(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["10045ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos10045ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(-0.7, -1.18, -6.05)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10045ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["10045ui_story"]
			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect10045ui_story == nil then
				arg_456_1.var_.characterEffect10045ui_story = var_459_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_11 = 0.200000002980232

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 and not isNil(var_459_9) then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11

				if arg_456_1.var_.characterEffect10045ui_story and not isNil(var_459_9) then
					arg_456_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect10045ui_story then
				arg_456_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_459_13 = 0

			if var_459_13 < arg_456_1.time_ and arg_456_1.time_ <= var_459_13 + arg_459_0 then
				arg_456_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action1_1")
			end

			local var_459_14 = 0

			if var_459_14 < arg_456_1.time_ and arg_456_1.time_ <= var_459_14 + arg_459_0 then
				arg_456_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_459_15 = arg_456_1.actors_["1069ui_story"].transform
			local var_459_16 = 0

			if var_459_16 < arg_456_1.time_ and arg_456_1.time_ <= var_459_16 + arg_459_0 then
				arg_456_1.var_.moveOldPos1069ui_story = var_459_15.localPosition
			end

			local var_459_17 = 0.001

			if var_459_16 <= arg_456_1.time_ and arg_456_1.time_ < var_459_16 + var_459_17 then
				local var_459_18 = (arg_456_1.time_ - var_459_16) / var_459_17
				local var_459_19 = Vector3.New(0.7, -1, -6)

				var_459_15.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1069ui_story, var_459_19, var_459_18)

				local var_459_20 = manager.ui.mainCamera.transform.position - var_459_15.position

				var_459_15.forward = Vector3.New(var_459_20.x, var_459_20.y, var_459_20.z)

				local var_459_21 = var_459_15.localEulerAngles

				var_459_21.z = 0
				var_459_21.x = 0
				var_459_15.localEulerAngles = var_459_21
			end

			if arg_456_1.time_ >= var_459_16 + var_459_17 and arg_456_1.time_ < var_459_16 + var_459_17 + arg_459_0 then
				var_459_15.localPosition = Vector3.New(0.7, -1, -6)

				local var_459_22 = manager.ui.mainCamera.transform.position - var_459_15.position

				var_459_15.forward = Vector3.New(var_459_22.x, var_459_22.y, var_459_22.z)

				local var_459_23 = var_459_15.localEulerAngles

				var_459_23.z = 0
				var_459_23.x = 0
				var_459_15.localEulerAngles = var_459_23
			end

			local var_459_24 = arg_456_1.actors_["1069ui_story"]
			local var_459_25 = 0

			if var_459_25 < arg_456_1.time_ and arg_456_1.time_ <= var_459_25 + arg_459_0 and not isNil(var_459_24) and arg_456_1.var_.characterEffect1069ui_story == nil then
				arg_456_1.var_.characterEffect1069ui_story = var_459_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_26 = 0.200000002980232

			if var_459_25 <= arg_456_1.time_ and arg_456_1.time_ < var_459_25 + var_459_26 and not isNil(var_459_24) then
				local var_459_27 = (arg_456_1.time_ - var_459_25) / var_459_26

				if arg_456_1.var_.characterEffect1069ui_story and not isNil(var_459_24) then
					local var_459_28 = Mathf.Lerp(0, 0.5, var_459_27)

					arg_456_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1069ui_story.fillRatio = var_459_28
				end
			end

			if arg_456_1.time_ >= var_459_25 + var_459_26 and arg_456_1.time_ < var_459_25 + var_459_26 + arg_459_0 and not isNil(var_459_24) and arg_456_1.var_.characterEffect1069ui_story then
				local var_459_29 = 0.5

				arg_456_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1069ui_story.fillRatio = var_459_29
			end

			local var_459_30 = "J02h_blur"

			if arg_456_1.bgs_[var_459_30] == nil then
				local var_459_31 = Object.Instantiate(arg_456_1.blurPaintGo_)
				local var_459_32 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_459_30)

				var_459_31:GetComponent("SpriteRenderer").sprite = var_459_32
				var_459_31.name = var_459_30
				var_459_31.transform.parent = arg_456_1.stage_.transform
				var_459_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_456_1.bgs_[var_459_30] = var_459_31
			end

			local var_459_33 = 0
			local var_459_34 = arg_456_1.bgs_[var_459_30]

			if var_459_33 < arg_456_1.time_ and arg_456_1.time_ <= var_459_33 + arg_459_0 then
				local var_459_35 = manager.ui.mainCamera.transform.localPosition
				local var_459_36 = Vector3.New(0, 0, 10) + Vector3.New(var_459_35.x, var_459_35.y, 0)

				var_459_34.transform.localPosition = var_459_36
				var_459_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_37 = var_459_34:GetComponent("SpriteRenderer")

				if var_459_37 and var_459_37.sprite then
					local var_459_38 = (var_459_34.transform.localPosition - var_459_35).z
					local var_459_39 = manager.ui.mainCameraCom_
					local var_459_40 = 2 * var_459_38 * Mathf.Tan(var_459_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_459_41 = var_459_40 * var_459_39.aspect
					local var_459_42 = var_459_37.sprite.bounds.size.x
					local var_459_43 = var_459_37.sprite.bounds.size.y
					local var_459_44 = var_459_41 / var_459_42
					local var_459_45 = var_459_40 / var_459_43
					local var_459_46 = var_459_45 < var_459_44 and var_459_44 or var_459_45

					var_459_34.transform.localScale = Vector3.New(var_459_46, var_459_46, 0)
				end
			end

			local var_459_47 = 0.5

			if var_459_33 <= arg_456_1.time_ and arg_456_1.time_ < var_459_33 + var_459_47 then
				local var_459_48 = (arg_456_1.time_ - var_459_33) / var_459_47
				local var_459_49 = Color.New(1, 1, 1)

				var_459_49.a = Mathf.Lerp(1, 0, var_459_48)

				var_459_34:GetComponent("SpriteRenderer").material:SetColor("_Color", var_459_49)
			end

			local var_459_50 = 0

			if var_459_50 < arg_456_1.time_ and arg_456_1.time_ <= var_459_50 + arg_459_0 then
				arg_456_1.allBtn_.enabled = false
			end

			local var_459_51 = 0.5

			if arg_456_1.time_ >= var_459_50 + var_459_51 and arg_456_1.time_ < var_459_50 + var_459_51 + arg_459_0 then
				arg_456_1.allBtn_.enabled = true
			end

			local var_459_52 = 0
			local var_459_53 = 0.225

			if var_459_52 < arg_456_1.time_ and arg_456_1.time_ <= var_459_52 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_54 = arg_456_1:FormatText(StoryNameCfg[412].name)

				arg_456_1.leftNameTxt_.text = var_459_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_55 = arg_456_1:GetWordFromCfg(121481109)
				local var_459_56 = arg_456_1:FormatText(var_459_55.content)

				arg_456_1.text_.text = var_459_56

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_57 = 9
				local var_459_58 = utf8.len(var_459_56)
				local var_459_59 = var_459_57 <= 0 and var_459_53 or var_459_53 * (var_459_58 / var_459_57)

				if var_459_59 > 0 and var_459_53 < var_459_59 then
					arg_456_1.talkMaxDuration = var_459_59

					if var_459_59 + var_459_52 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_59 + var_459_52
					end
				end

				arg_456_1.text_.text = var_459_56
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481109", "story_v_out_121481.awb") ~= 0 then
					local var_459_60 = manager.audio:GetVoiceLength("story_v_out_121481", "121481109", "story_v_out_121481.awb") / 1000

					if var_459_60 + var_459_52 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_60 + var_459_52
					end

					if var_459_55.prefab_name ~= "" and arg_456_1.actors_[var_459_55.prefab_name] ~= nil then
						local var_459_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_55.prefab_name].transform, "story_v_out_121481", "121481109", "story_v_out_121481.awb")

						arg_456_1:RecordAudio("121481109", var_459_61)
						arg_456_1:RecordAudio("121481109", var_459_61)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_121481", "121481109", "story_v_out_121481.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_121481", "121481109", "story_v_out_121481.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_62 = math.max(var_459_53, arg_456_1.talkMaxDuration)

			if var_459_52 <= arg_456_1.time_ and arg_456_1.time_ < var_459_52 + var_459_62 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_52) / var_459_62

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_52 + var_459_62 and arg_456_1.time_ < var_459_52 + var_459_62 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play121481110 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 121481110
		arg_460_1.duration_ = 4.9

		local var_460_0 = {
			ja = 4.133,
			ko = 4.9,
			zh = 4.9
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play121481111(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["10045ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect10045ui_story == nil then
				arg_460_1.var_.characterEffect10045ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect10045ui_story and not isNil(var_463_0) then
					local var_463_4 = Mathf.Lerp(0, 0.5, var_463_3)

					arg_460_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_460_1.var_.characterEffect10045ui_story.fillRatio = var_463_4
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect10045ui_story then
				local var_463_5 = 0.5

				arg_460_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_460_1.var_.characterEffect10045ui_story.fillRatio = var_463_5
			end

			local var_463_6 = arg_460_1.actors_["1069ui_story"]
			local var_463_7 = 0

			if var_463_7 < arg_460_1.time_ and arg_460_1.time_ <= var_463_7 + arg_463_0 and not isNil(var_463_6) and arg_460_1.var_.characterEffect1069ui_story == nil then
				arg_460_1.var_.characterEffect1069ui_story = var_463_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_8 = 0.200000002980232

			if var_463_7 <= arg_460_1.time_ and arg_460_1.time_ < var_463_7 + var_463_8 and not isNil(var_463_6) then
				local var_463_9 = (arg_460_1.time_ - var_463_7) / var_463_8

				if arg_460_1.var_.characterEffect1069ui_story and not isNil(var_463_6) then
					arg_460_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= var_463_7 + var_463_8 and arg_460_1.time_ < var_463_7 + var_463_8 + arg_463_0 and not isNil(var_463_6) and arg_460_1.var_.characterEffect1069ui_story then
				arg_460_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_463_10 = 0
			local var_463_11 = 0.5

			if var_463_10 < arg_460_1.time_ and arg_460_1.time_ <= var_463_10 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_12 = arg_460_1:FormatText(StoryNameCfg[378].name)

				arg_460_1.leftNameTxt_.text = var_463_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_13 = arg_460_1:GetWordFromCfg(121481110)
				local var_463_14 = arg_460_1:FormatText(var_463_13.content)

				arg_460_1.text_.text = var_463_14

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_15 = 20
				local var_463_16 = utf8.len(var_463_14)
				local var_463_17 = var_463_15 <= 0 and var_463_11 or var_463_11 * (var_463_16 / var_463_15)

				if var_463_17 > 0 and var_463_11 < var_463_17 then
					arg_460_1.talkMaxDuration = var_463_17

					if var_463_17 + var_463_10 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_17 + var_463_10
					end
				end

				arg_460_1.text_.text = var_463_14
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481110", "story_v_out_121481.awb") ~= 0 then
					local var_463_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481110", "story_v_out_121481.awb") / 1000

					if var_463_18 + var_463_10 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_18 + var_463_10
					end

					if var_463_13.prefab_name ~= "" and arg_460_1.actors_[var_463_13.prefab_name] ~= nil then
						local var_463_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_13.prefab_name].transform, "story_v_out_121481", "121481110", "story_v_out_121481.awb")

						arg_460_1:RecordAudio("121481110", var_463_19)
						arg_460_1:RecordAudio("121481110", var_463_19)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_121481", "121481110", "story_v_out_121481.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_121481", "121481110", "story_v_out_121481.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_20 = math.max(var_463_11, arg_460_1.talkMaxDuration)

			if var_463_10 <= arg_460_1.time_ and arg_460_1.time_ < var_463_10 + var_463_20 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_10) / var_463_20

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_10 + var_463_20 and arg_460_1.time_ < var_463_10 + var_463_20 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play121481111 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 121481111
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play121481112(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1069ui_story"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1069ui_story == nil then
				arg_464_1.var_.characterEffect1069ui_story = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect1069ui_story and not isNil(var_467_0) then
					local var_467_4 = Mathf.Lerp(0, 0.5, var_467_3)

					arg_464_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1069ui_story.fillRatio = var_467_4
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1069ui_story then
				local var_467_5 = 0.5

				arg_464_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1069ui_story.fillRatio = var_467_5
			end

			local var_467_6 = 0
			local var_467_7 = 1.15

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_8 = arg_464_1:GetWordFromCfg(121481111)
				local var_467_9 = arg_464_1:FormatText(var_467_8.content)

				arg_464_1.text_.text = var_467_9

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_10 = 46
				local var_467_11 = utf8.len(var_467_9)
				local var_467_12 = var_467_10 <= 0 and var_467_7 or var_467_7 * (var_467_11 / var_467_10)

				if var_467_12 > 0 and var_467_7 < var_467_12 then
					arg_464_1.talkMaxDuration = var_467_12

					if var_467_12 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_12 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_9
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_13 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_13 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_13

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_13 and arg_464_1.time_ < var_467_6 + var_467_13 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play121481112 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 121481112
		arg_468_1.duration_ = 4.6

		local var_468_0 = {
			ja = 4.6,
			ko = 4,
			zh = 4
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play121481113(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1069ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1069ui_story == nil then
				arg_468_1.var_.characterEffect1069ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1069ui_story and not isNil(var_471_0) then
					arg_468_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1069ui_story then
				arg_468_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_471_4 = 0
			local var_471_5 = 0.35

			if var_471_4 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_6 = arg_468_1:FormatText(StoryNameCfg[378].name)

				arg_468_1.leftNameTxt_.text = var_471_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_7 = arg_468_1:GetWordFromCfg(121481112)
				local var_471_8 = arg_468_1:FormatText(var_471_7.content)

				arg_468_1.text_.text = var_471_8

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 14
				local var_471_10 = utf8.len(var_471_8)
				local var_471_11 = var_471_9 <= 0 and var_471_5 or var_471_5 * (var_471_10 / var_471_9)

				if var_471_11 > 0 and var_471_5 < var_471_11 then
					arg_468_1.talkMaxDuration = var_471_11

					if var_471_11 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_11 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_8
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481112", "story_v_out_121481.awb") ~= 0 then
					local var_471_12 = manager.audio:GetVoiceLength("story_v_out_121481", "121481112", "story_v_out_121481.awb") / 1000

					if var_471_12 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_12 + var_471_4
					end

					if var_471_7.prefab_name ~= "" and arg_468_1.actors_[var_471_7.prefab_name] ~= nil then
						local var_471_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_7.prefab_name].transform, "story_v_out_121481", "121481112", "story_v_out_121481.awb")

						arg_468_1:RecordAudio("121481112", var_471_13)
						arg_468_1:RecordAudio("121481112", var_471_13)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_121481", "121481112", "story_v_out_121481.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_121481", "121481112", "story_v_out_121481.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_14 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_14 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_14

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_14 and arg_468_1.time_ < var_471_4 + var_471_14 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play121481113 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 121481113
		arg_472_1.duration_ = 4.67

		local var_472_0 = {
			ja = 4.3,
			ko = 4.666,
			zh = 4.666
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play121481114(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["10045ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect10045ui_story == nil then
				arg_472_1.var_.characterEffect10045ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect10045ui_story and not isNil(var_475_0) then
					arg_472_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect10045ui_story then
				arg_472_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_475_4 = arg_472_1.actors_["1069ui_story"]
			local var_475_5 = 0

			if var_475_5 < arg_472_1.time_ and arg_472_1.time_ <= var_475_5 + arg_475_0 and not isNil(var_475_4) and arg_472_1.var_.characterEffect1069ui_story == nil then
				arg_472_1.var_.characterEffect1069ui_story = var_475_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_6 = 0.200000002980232

			if var_475_5 <= arg_472_1.time_ and arg_472_1.time_ < var_475_5 + var_475_6 and not isNil(var_475_4) then
				local var_475_7 = (arg_472_1.time_ - var_475_5) / var_475_6

				if arg_472_1.var_.characterEffect1069ui_story and not isNil(var_475_4) then
					local var_475_8 = Mathf.Lerp(0, 0.5, var_475_7)

					arg_472_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_472_1.var_.characterEffect1069ui_story.fillRatio = var_475_8
				end
			end

			if arg_472_1.time_ >= var_475_5 + var_475_6 and arg_472_1.time_ < var_475_5 + var_475_6 + arg_475_0 and not isNil(var_475_4) and arg_472_1.var_.characterEffect1069ui_story then
				local var_475_9 = 0.5

				arg_472_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_472_1.var_.characterEffect1069ui_story.fillRatio = var_475_9
			end

			local var_475_10 = 0

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 then
				arg_472_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_475_11 = 0
			local var_475_12 = 0.25

			if var_475_11 < arg_472_1.time_ and arg_472_1.time_ <= var_475_11 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_13 = arg_472_1:FormatText(StoryNameCfg[412].name)

				arg_472_1.leftNameTxt_.text = var_475_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_14 = arg_472_1:GetWordFromCfg(121481113)
				local var_475_15 = arg_472_1:FormatText(var_475_14.content)

				arg_472_1.text_.text = var_475_15

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_16 = 10
				local var_475_17 = utf8.len(var_475_15)
				local var_475_18 = var_475_16 <= 0 and var_475_12 or var_475_12 * (var_475_17 / var_475_16)

				if var_475_18 > 0 and var_475_12 < var_475_18 then
					arg_472_1.talkMaxDuration = var_475_18

					if var_475_18 + var_475_11 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_18 + var_475_11
					end
				end

				arg_472_1.text_.text = var_475_15
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481113", "story_v_out_121481.awb") ~= 0 then
					local var_475_19 = manager.audio:GetVoiceLength("story_v_out_121481", "121481113", "story_v_out_121481.awb") / 1000

					if var_475_19 + var_475_11 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_19 + var_475_11
					end

					if var_475_14.prefab_name ~= "" and arg_472_1.actors_[var_475_14.prefab_name] ~= nil then
						local var_475_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_14.prefab_name].transform, "story_v_out_121481", "121481113", "story_v_out_121481.awb")

						arg_472_1:RecordAudio("121481113", var_475_20)
						arg_472_1:RecordAudio("121481113", var_475_20)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_121481", "121481113", "story_v_out_121481.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_121481", "121481113", "story_v_out_121481.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_21 = math.max(var_475_12, arg_472_1.talkMaxDuration)

			if var_475_11 <= arg_472_1.time_ and arg_472_1.time_ < var_475_11 + var_475_21 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_11) / var_475_21

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_11 + var_475_21 and arg_472_1.time_ < var_475_11 + var_475_21 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play121481114 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 121481114
		arg_476_1.duration_ = 5.17

		local var_476_0 = {
			ja = 5.166,
			ko = 3.2,
			zh = 3.2
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play121481115(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["10045ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect10045ui_story == nil then
				arg_476_1.var_.characterEffect10045ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect10045ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_476_1.var_.characterEffect10045ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect10045ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_476_1.var_.characterEffect10045ui_story.fillRatio = var_479_5
			end

			local var_479_6 = arg_476_1.actors_["1069ui_story"]
			local var_479_7 = 0

			if var_479_7 < arg_476_1.time_ and arg_476_1.time_ <= var_479_7 + arg_479_0 and not isNil(var_479_6) and arg_476_1.var_.characterEffect1069ui_story == nil then
				arg_476_1.var_.characterEffect1069ui_story = var_479_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_8 = 0.200000002980232

			if var_479_7 <= arg_476_1.time_ and arg_476_1.time_ < var_479_7 + var_479_8 and not isNil(var_479_6) then
				local var_479_9 = (arg_476_1.time_ - var_479_7) / var_479_8

				if arg_476_1.var_.characterEffect1069ui_story and not isNil(var_479_6) then
					arg_476_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= var_479_7 + var_479_8 and arg_476_1.time_ < var_479_7 + var_479_8 + arg_479_0 and not isNil(var_479_6) and arg_476_1.var_.characterEffect1069ui_story then
				arg_476_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_479_10 = 0
			local var_479_11 = 0.325

			if var_479_10 < arg_476_1.time_ and arg_476_1.time_ <= var_479_10 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_12 = arg_476_1:FormatText(StoryNameCfg[378].name)

				arg_476_1.leftNameTxt_.text = var_479_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_13 = arg_476_1:GetWordFromCfg(121481114)
				local var_479_14 = arg_476_1:FormatText(var_479_13.content)

				arg_476_1.text_.text = var_479_14

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_15 = 13
				local var_479_16 = utf8.len(var_479_14)
				local var_479_17 = var_479_15 <= 0 and var_479_11 or var_479_11 * (var_479_16 / var_479_15)

				if var_479_17 > 0 and var_479_11 < var_479_17 then
					arg_476_1.talkMaxDuration = var_479_17

					if var_479_17 + var_479_10 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_17 + var_479_10
					end
				end

				arg_476_1.text_.text = var_479_14
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481114", "story_v_out_121481.awb") ~= 0 then
					local var_479_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481114", "story_v_out_121481.awb") / 1000

					if var_479_18 + var_479_10 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_18 + var_479_10
					end

					if var_479_13.prefab_name ~= "" and arg_476_1.actors_[var_479_13.prefab_name] ~= nil then
						local var_479_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_13.prefab_name].transform, "story_v_out_121481", "121481114", "story_v_out_121481.awb")

						arg_476_1:RecordAudio("121481114", var_479_19)
						arg_476_1:RecordAudio("121481114", var_479_19)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_121481", "121481114", "story_v_out_121481.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_121481", "121481114", "story_v_out_121481.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_20 = math.max(var_479_11, arg_476_1.talkMaxDuration)

			if var_479_10 <= arg_476_1.time_ and arg_476_1.time_ < var_479_10 + var_479_20 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_10) / var_479_20

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_10 + var_479_20 and arg_476_1.time_ < var_479_10 + var_479_20 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play121481115 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 121481115
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play121481116(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10045ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos10045ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, 100, 0)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10045ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, 100, 0)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = arg_480_1.actors_["1069ui_story"].transform
			local var_483_10 = 0

			if var_483_10 < arg_480_1.time_ and arg_480_1.time_ <= var_483_10 + arg_483_0 then
				arg_480_1.var_.moveOldPos1069ui_story = var_483_9.localPosition
			end

			local var_483_11 = 0.001

			if var_483_10 <= arg_480_1.time_ and arg_480_1.time_ < var_483_10 + var_483_11 then
				local var_483_12 = (arg_480_1.time_ - var_483_10) / var_483_11
				local var_483_13 = Vector3.New(0, 100, 0)

				var_483_9.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1069ui_story, var_483_13, var_483_12)

				local var_483_14 = manager.ui.mainCamera.transform.position - var_483_9.position

				var_483_9.forward = Vector3.New(var_483_14.x, var_483_14.y, var_483_14.z)

				local var_483_15 = var_483_9.localEulerAngles

				var_483_15.z = 0
				var_483_15.x = 0
				var_483_9.localEulerAngles = var_483_15
			end

			if arg_480_1.time_ >= var_483_10 + var_483_11 and arg_480_1.time_ < var_483_10 + var_483_11 + arg_483_0 then
				var_483_9.localPosition = Vector3.New(0, 100, 0)

				local var_483_16 = manager.ui.mainCamera.transform.position - var_483_9.position

				var_483_9.forward = Vector3.New(var_483_16.x, var_483_16.y, var_483_16.z)

				local var_483_17 = var_483_9.localEulerAngles

				var_483_17.z = 0
				var_483_17.x = 0
				var_483_9.localEulerAngles = var_483_17
			end

			local var_483_18 = 0
			local var_483_19 = 0.633333333333333

			if var_483_18 < arg_480_1.time_ and arg_480_1.time_ <= var_483_18 + arg_483_0 then
				local var_483_20 = "play"
				local var_483_21 = "effect"

				arg_480_1:AudioAction(var_483_20, var_483_21, "se_story_121_04", "se_story_121_04_bonebreak1", "")
			end

			local var_483_22 = 0
			local var_483_23 = 1.3

			if var_483_22 < arg_480_1.time_ and arg_480_1.time_ <= var_483_22 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_24 = arg_480_1:GetWordFromCfg(121481115)
				local var_483_25 = arg_480_1:FormatText(var_483_24.content)

				arg_480_1.text_.text = var_483_25

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_26 = 52
				local var_483_27 = utf8.len(var_483_25)
				local var_483_28 = var_483_26 <= 0 and var_483_23 or var_483_23 * (var_483_27 / var_483_26)

				if var_483_28 > 0 and var_483_23 < var_483_28 then
					arg_480_1.talkMaxDuration = var_483_28

					if var_483_28 + var_483_22 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_28 + var_483_22
					end
				end

				arg_480_1.text_.text = var_483_25
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_29 = math.max(var_483_23, arg_480_1.talkMaxDuration)

			if var_483_22 <= arg_480_1.time_ and arg_480_1.time_ < var_483_22 + var_483_29 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_22) / var_483_29

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_22 + var_483_29 and arg_480_1.time_ < var_483_22 + var_483_29 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play121481116 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 121481116
		arg_484_1.duration_ = 3.17

		local var_484_0 = {
			ja = 2.766,
			ko = 3.166,
			zh = 3.166
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play121481117(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = manager.ui.mainCamera.transform
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.var_.shakeOldPos = var_487_0.localPosition
			end

			local var_487_2 = 0.6

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / 0.066
				local var_487_4, var_487_5 = math.modf(var_487_3)

				var_487_0.localPosition = Vector3.New(var_487_5 * 0.13, var_487_5 * 0.13, var_487_5 * 0.13) + arg_484_1.var_.shakeOldPos
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 then
				var_487_0.localPosition = arg_484_1.var_.shakeOldPos
			end

			local var_487_6 = 0

			if var_487_6 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.allBtn_.enabled = false
			end

			local var_487_7 = 0.6

			if arg_484_1.time_ >= var_487_6 + var_487_7 and arg_484_1.time_ < var_487_6 + var_487_7 + arg_487_0 then
				arg_484_1.allBtn_.enabled = true
			end

			local var_487_8 = 0
			local var_487_9 = 0.225

			if var_487_8 < arg_484_1.time_ and arg_484_1.time_ <= var_487_8 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_10 = arg_484_1:FormatText(StoryNameCfg[412].name)

				arg_484_1.leftNameTxt_.text = var_487_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_11 = arg_484_1:GetWordFromCfg(121481116)
				local var_487_12 = arg_484_1:FormatText(var_487_11.content)

				arg_484_1.text_.text = var_487_12

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_13 = 9
				local var_487_14 = utf8.len(var_487_12)
				local var_487_15 = var_487_13 <= 0 and var_487_9 or var_487_9 * (var_487_14 / var_487_13)

				if var_487_15 > 0 and var_487_9 < var_487_15 then
					arg_484_1.talkMaxDuration = var_487_15

					if var_487_15 + var_487_8 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_15 + var_487_8
					end
				end

				arg_484_1.text_.text = var_487_12
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481116", "story_v_out_121481.awb") ~= 0 then
					local var_487_16 = manager.audio:GetVoiceLength("story_v_out_121481", "121481116", "story_v_out_121481.awb") / 1000

					if var_487_16 + var_487_8 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_16 + var_487_8
					end

					if var_487_11.prefab_name ~= "" and arg_484_1.actors_[var_487_11.prefab_name] ~= nil then
						local var_487_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_11.prefab_name].transform, "story_v_out_121481", "121481116", "story_v_out_121481.awb")

						arg_484_1:RecordAudio("121481116", var_487_17)
						arg_484_1:RecordAudio("121481116", var_487_17)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_121481", "121481116", "story_v_out_121481.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_121481", "121481116", "story_v_out_121481.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_18 = math.max(var_487_9, arg_484_1.talkMaxDuration)

			if var_487_8 <= arg_484_1.time_ and arg_484_1.time_ < var_487_8 + var_487_18 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_8) / var_487_18

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_8 + var_487_18 and arg_484_1.time_ < var_487_8 + var_487_18 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play121481117 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 121481117
		arg_488_1.duration_ = 4.77

		local var_488_0 = {
			ja = 4.766,
			ko = 4.466,
			zh = 4.466
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
				arg_488_0:Play121481118(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1069ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1069ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, -1, -6)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1069ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, -1, -6)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = 0

			if var_491_9 < arg_488_1.time_ and arg_488_1.time_ <= var_491_9 + arg_491_0 then
				arg_488_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 then
				arg_488_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_491_11 = arg_488_1.actors_["1069ui_story"]
			local var_491_12 = 0

			if var_491_12 < arg_488_1.time_ and arg_488_1.time_ <= var_491_12 + arg_491_0 and not isNil(var_491_11) and arg_488_1.var_.characterEffect1069ui_story == nil then
				arg_488_1.var_.characterEffect1069ui_story = var_491_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_13 = 0.2

			if var_491_12 <= arg_488_1.time_ and arg_488_1.time_ < var_491_12 + var_491_13 and not isNil(var_491_11) then
				local var_491_14 = (arg_488_1.time_ - var_491_12) / var_491_13

				if arg_488_1.var_.characterEffect1069ui_story and not isNil(var_491_11) then
					arg_488_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_12 + var_491_13 and arg_488_1.time_ < var_491_12 + var_491_13 + arg_491_0 and not isNil(var_491_11) and arg_488_1.var_.characterEffect1069ui_story then
				arg_488_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_491_15 = 0
			local var_491_16 = 0.475

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_17 = arg_488_1:FormatText(StoryNameCfg[378].name)

				arg_488_1.leftNameTxt_.text = var_491_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_18 = arg_488_1:GetWordFromCfg(121481117)
				local var_491_19 = arg_488_1:FormatText(var_491_18.content)

				arg_488_1.text_.text = var_491_19

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_20 = 19
				local var_491_21 = utf8.len(var_491_19)
				local var_491_22 = var_491_20 <= 0 and var_491_16 or var_491_16 * (var_491_21 / var_491_20)

				if var_491_22 > 0 and var_491_16 < var_491_22 then
					arg_488_1.talkMaxDuration = var_491_22

					if var_491_22 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_22 + var_491_15
					end
				end

				arg_488_1.text_.text = var_491_19
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481117", "story_v_out_121481.awb") ~= 0 then
					local var_491_23 = manager.audio:GetVoiceLength("story_v_out_121481", "121481117", "story_v_out_121481.awb") / 1000

					if var_491_23 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_23 + var_491_15
					end

					if var_491_18.prefab_name ~= "" and arg_488_1.actors_[var_491_18.prefab_name] ~= nil then
						local var_491_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_18.prefab_name].transform, "story_v_out_121481", "121481117", "story_v_out_121481.awb")

						arg_488_1:RecordAudio("121481117", var_491_24)
						arg_488_1:RecordAudio("121481117", var_491_24)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_121481", "121481117", "story_v_out_121481.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_121481", "121481117", "story_v_out_121481.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_25 = math.max(var_491_16, arg_488_1.talkMaxDuration)

			if var_491_15 <= arg_488_1.time_ and arg_488_1.time_ < var_491_15 + var_491_25 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_15) / var_491_25

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_15 + var_491_25 and arg_488_1.time_ < var_491_15 + var_491_25 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play121481118 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 121481118
		arg_492_1.duration_ = 3.1

		local var_492_0 = {
			ja = 2,
			ko = 3.1,
			zh = 3.1
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play121481119(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.3

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[378].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_3 = arg_492_1:GetWordFromCfg(121481118)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 12
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481118", "story_v_out_121481.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481118", "story_v_out_121481.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_out_121481", "121481118", "story_v_out_121481.awb")

						arg_492_1:RecordAudio("121481118", var_495_9)
						arg_492_1:RecordAudio("121481118", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_121481", "121481118", "story_v_out_121481.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_121481", "121481118", "story_v_out_121481.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play121481119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 121481119
		arg_496_1.duration_ = 12.23

		local var_496_0 = {
			ja = 12.233,
			ko = 11.433,
			zh = 11.433
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play121481120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1069ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1069ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, 100, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1069ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, 100, 0)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = manager.ui.mainCamera.transform
			local var_499_10 = 0.733333333333333

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 then
				arg_496_1.var_.shakeOldPos = var_499_9.localPosition
			end

			local var_499_11 = 0.6

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_11 then
				local var_499_12 = (arg_496_1.time_ - var_499_10) / 0.066
				local var_499_13, var_499_14 = math.modf(var_499_12)

				var_499_9.localPosition = Vector3.New(var_499_14 * 0.13, var_499_14 * 0.13, var_499_14 * 0.13) + arg_496_1.var_.shakeOldPos
			end

			if arg_496_1.time_ >= var_499_10 + var_499_11 and arg_496_1.time_ < var_499_10 + var_499_11 + arg_499_0 then
				var_499_9.localPosition = arg_496_1.var_.shakeOldPos
			end

			local var_499_15 = 0

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1.allBtn_.enabled = false
			end

			local var_499_16 = 1.33333333333333

			if arg_496_1.time_ >= var_499_15 + var_499_16 and arg_496_1.time_ < var_499_15 + var_499_16 + arg_499_0 then
				arg_496_1.allBtn_.enabled = true
			end

			local var_499_17 = 1.1
			local var_499_18 = 0.433333333333333

			if var_499_17 < arg_496_1.time_ and arg_496_1.time_ <= var_499_17 + arg_499_0 then
				local var_499_19 = "play"
				local var_499_20 = "effect"

				arg_496_1:AudioAction(var_499_19, var_499_20, "se_story_121_04", "se_story_121_04_hitdown", "")
			end

			local var_499_21 = 0
			local var_499_22 = 0.85

			if var_499_21 < arg_496_1.time_ and arg_496_1.time_ <= var_499_21 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_23 = arg_496_1:FormatText(StoryNameCfg[412].name)

				arg_496_1.leftNameTxt_.text = var_499_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_24 = arg_496_1:GetWordFromCfg(121481119)
				local var_499_25 = arg_496_1:FormatText(var_499_24.content)

				arg_496_1.text_.text = var_499_25

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_26 = 34
				local var_499_27 = utf8.len(var_499_25)
				local var_499_28 = var_499_26 <= 0 and var_499_22 or var_499_22 * (var_499_27 / var_499_26)

				if var_499_28 > 0 and var_499_22 < var_499_28 then
					arg_496_1.talkMaxDuration = var_499_28

					if var_499_28 + var_499_21 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_28 + var_499_21
					end
				end

				arg_496_1.text_.text = var_499_25
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481119", "story_v_out_121481.awb") ~= 0 then
					local var_499_29 = manager.audio:GetVoiceLength("story_v_out_121481", "121481119", "story_v_out_121481.awb") / 1000

					if var_499_29 + var_499_21 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_29 + var_499_21
					end

					if var_499_24.prefab_name ~= "" and arg_496_1.actors_[var_499_24.prefab_name] ~= nil then
						local var_499_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_24.prefab_name].transform, "story_v_out_121481", "121481119", "story_v_out_121481.awb")

						arg_496_1:RecordAudio("121481119", var_499_30)
						arg_496_1:RecordAudio("121481119", var_499_30)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_121481", "121481119", "story_v_out_121481.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_121481", "121481119", "story_v_out_121481.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_31 = math.max(var_499_22, arg_496_1.talkMaxDuration)

			if var_499_21 <= arg_496_1.time_ and arg_496_1.time_ < var_499_21 + var_499_31 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_21) / var_499_31

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_21 + var_499_31 and arg_496_1.time_ < var_499_21 + var_499_31 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play121481120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 121481120
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play121481121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["10045ui_story"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect10045ui_story == nil then
				arg_500_1.var_.characterEffect10045ui_story = var_503_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.200000002980232

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.characterEffect10045ui_story and not isNil(var_503_0) then
					local var_503_4 = Mathf.Lerp(0, 0.5, var_503_3)

					arg_500_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_500_1.var_.characterEffect10045ui_story.fillRatio = var_503_4
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect10045ui_story then
				local var_503_5 = 0.5

				arg_500_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_500_1.var_.characterEffect10045ui_story.fillRatio = var_503_5
			end

			local var_503_6 = 0
			local var_503_7 = 0.825

			if var_503_6 < arg_500_1.time_ and arg_500_1.time_ <= var_503_6 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_8 = arg_500_1:GetWordFromCfg(121481120)
				local var_503_9 = arg_500_1:FormatText(var_503_8.content)

				arg_500_1.text_.text = var_503_9

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_10 = 33
				local var_503_11 = utf8.len(var_503_9)
				local var_503_12 = var_503_10 <= 0 and var_503_7 or var_503_7 * (var_503_11 / var_503_10)

				if var_503_12 > 0 and var_503_7 < var_503_12 then
					arg_500_1.talkMaxDuration = var_503_12

					if var_503_12 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_12 + var_503_6
					end
				end

				arg_500_1.text_.text = var_503_9
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_13 = math.max(var_503_7, arg_500_1.talkMaxDuration)

			if var_503_6 <= arg_500_1.time_ and arg_500_1.time_ < var_503_6 + var_503_13 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_6) / var_503_13

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_6 + var_503_13 and arg_500_1.time_ < var_503_6 + var_503_13 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play121481121 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 121481121
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play121481122(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 1.15

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

				local var_507_2 = arg_504_1:GetWordFromCfg(121481121)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 46
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
	Play121481122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 121481122
		arg_508_1.duration_ = 4.77

		local var_508_0 = {
			ja = 4.766,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_508_0:Play121481123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1069ui_story"].transform
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.var_.moveOldPos1069ui_story = var_511_0.localPosition
			end

			local var_511_2 = 0.001

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2
				local var_511_4 = Vector3.New(0, -1, -6)

				var_511_0.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos1069ui_story, var_511_4, var_511_3)

				local var_511_5 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_5.x, var_511_5.y, var_511_5.z)

				local var_511_6 = var_511_0.localEulerAngles

				var_511_6.z = 0
				var_511_6.x = 0
				var_511_0.localEulerAngles = var_511_6
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 then
				var_511_0.localPosition = Vector3.New(0, -1, -6)

				local var_511_7 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_7.x, var_511_7.y, var_511_7.z)

				local var_511_8 = var_511_0.localEulerAngles

				var_511_8.z = 0
				var_511_8.x = 0
				var_511_0.localEulerAngles = var_511_8
			end

			local var_511_9 = arg_508_1.actors_["1069ui_story"]
			local var_511_10 = 0

			if var_511_10 < arg_508_1.time_ and arg_508_1.time_ <= var_511_10 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect1069ui_story == nil then
				arg_508_1.var_.characterEffect1069ui_story = var_511_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_11 = 0.200000002980232

			if var_511_10 <= arg_508_1.time_ and arg_508_1.time_ < var_511_10 + var_511_11 and not isNil(var_511_9) then
				local var_511_12 = (arg_508_1.time_ - var_511_10) / var_511_11

				if arg_508_1.var_.characterEffect1069ui_story and not isNil(var_511_9) then
					arg_508_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= var_511_10 + var_511_11 and arg_508_1.time_ < var_511_10 + var_511_11 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect1069ui_story then
				arg_508_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_511_13 = 0

			if var_511_13 < arg_508_1.time_ and arg_508_1.time_ <= var_511_13 + arg_511_0 then
				arg_508_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			local var_511_14 = 0

			if var_511_14 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_511_15 = 0
			local var_511_16 = 0.125

			if var_511_15 < arg_508_1.time_ and arg_508_1.time_ <= var_511_15 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_17 = arg_508_1:FormatText(StoryNameCfg[378].name)

				arg_508_1.leftNameTxt_.text = var_511_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_18 = arg_508_1:GetWordFromCfg(121481122)
				local var_511_19 = arg_508_1:FormatText(var_511_18.content)

				arg_508_1.text_.text = var_511_19

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_20 = 5
				local var_511_21 = utf8.len(var_511_19)
				local var_511_22 = var_511_20 <= 0 and var_511_16 or var_511_16 * (var_511_21 / var_511_20)

				if var_511_22 > 0 and var_511_16 < var_511_22 then
					arg_508_1.talkMaxDuration = var_511_22

					if var_511_22 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_22 + var_511_15
					end
				end

				arg_508_1.text_.text = var_511_19
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481122", "story_v_out_121481.awb") ~= 0 then
					local var_511_23 = manager.audio:GetVoiceLength("story_v_out_121481", "121481122", "story_v_out_121481.awb") / 1000

					if var_511_23 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_15
					end

					if var_511_18.prefab_name ~= "" and arg_508_1.actors_[var_511_18.prefab_name] ~= nil then
						local var_511_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_18.prefab_name].transform, "story_v_out_121481", "121481122", "story_v_out_121481.awb")

						arg_508_1:RecordAudio("121481122", var_511_24)
						arg_508_1:RecordAudio("121481122", var_511_24)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_121481", "121481122", "story_v_out_121481.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_121481", "121481122", "story_v_out_121481.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_25 = math.max(var_511_16, arg_508_1.talkMaxDuration)

			if var_511_15 <= arg_508_1.time_ and arg_508_1.time_ < var_511_15 + var_511_25 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_15) / var_511_25

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_15 + var_511_25 and arg_508_1.time_ < var_511_15 + var_511_25 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play121481123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 121481123
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play121481124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1069ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos1069ui_story = var_515_0.localPosition
			end

			local var_515_2 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2
				local var_515_4 = Vector3.New(0, 100, 0)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos1069ui_story, var_515_4, var_515_3)

				local var_515_5 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_5.x, var_515_5.y, var_515_5.z)

				local var_515_6 = var_515_0.localEulerAngles

				var_515_6.z = 0
				var_515_6.x = 0
				var_515_0.localEulerAngles = var_515_6
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0, 100, 0)

				local var_515_7 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_7.x, var_515_7.y, var_515_7.z)

				local var_515_8 = var_515_0.localEulerAngles

				var_515_8.z = 0
				var_515_8.x = 0
				var_515_0.localEulerAngles = var_515_8
			end

			local var_515_9 = arg_512_1.actors_["1069ui_story"]
			local var_515_10 = 0

			if var_515_10 < arg_512_1.time_ and arg_512_1.time_ <= var_515_10 + arg_515_0 and not isNil(var_515_9) and arg_512_1.var_.characterEffect1069ui_story == nil then
				arg_512_1.var_.characterEffect1069ui_story = var_515_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_11 = 0.200000002980232

			if var_515_10 <= arg_512_1.time_ and arg_512_1.time_ < var_515_10 + var_515_11 and not isNil(var_515_9) then
				local var_515_12 = (arg_512_1.time_ - var_515_10) / var_515_11

				if arg_512_1.var_.characterEffect1069ui_story and not isNil(var_515_9) then
					local var_515_13 = Mathf.Lerp(0, 0.5, var_515_12)

					arg_512_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_512_1.var_.characterEffect1069ui_story.fillRatio = var_515_13
				end
			end

			if arg_512_1.time_ >= var_515_10 + var_515_11 and arg_512_1.time_ < var_515_10 + var_515_11 + arg_515_0 and not isNil(var_515_9) and arg_512_1.var_.characterEffect1069ui_story then
				local var_515_14 = 0.5

				arg_512_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_512_1.var_.characterEffect1069ui_story.fillRatio = var_515_14
			end

			local var_515_15 = 0
			local var_515_16 = 0.775

			if var_515_15 < arg_512_1.time_ and arg_512_1.time_ <= var_515_15 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_17 = arg_512_1:GetWordFromCfg(121481123)
				local var_515_18 = arg_512_1:FormatText(var_515_17.content)

				arg_512_1.text_.text = var_515_18

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_19 = 31
				local var_515_20 = utf8.len(var_515_18)
				local var_515_21 = var_515_19 <= 0 and var_515_16 or var_515_16 * (var_515_20 / var_515_19)

				if var_515_21 > 0 and var_515_16 < var_515_21 then
					arg_512_1.talkMaxDuration = var_515_21

					if var_515_21 + var_515_15 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_21 + var_515_15
					end
				end

				arg_512_1.text_.text = var_515_18
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_22 = math.max(var_515_16, arg_512_1.talkMaxDuration)

			if var_515_15 <= arg_512_1.time_ and arg_512_1.time_ < var_515_15 + var_515_22 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_15) / var_515_22

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_15 + var_515_22 and arg_512_1.time_ < var_515_15 + var_515_22 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play121481124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 121481124
		arg_516_1.duration_ = 9.87

		local var_516_0 = {
			ja = 5.633,
			ko = 9.866,
			zh = 9.866
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
				arg_516_0:Play121481125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1069ui_story"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos1069ui_story = var_519_0.localPosition
			end

			local var_519_2 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2
				local var_519_4 = Vector3.New(0.7, -1, -6)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1069ui_story, var_519_4, var_519_3)

				local var_519_5 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_5.x, var_519_5.y, var_519_5.z)

				local var_519_6 = var_519_0.localEulerAngles

				var_519_6.z = 0
				var_519_6.x = 0
				var_519_0.localEulerAngles = var_519_6
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(0.7, -1, -6)

				local var_519_7 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_7.x, var_519_7.y, var_519_7.z)

				local var_519_8 = var_519_0.localEulerAngles

				var_519_8.z = 0
				var_519_8.x = 0
				var_519_0.localEulerAngles = var_519_8
			end

			local var_519_9 = arg_516_1.actors_["1069ui_story"]
			local var_519_10 = 0

			if var_519_10 < arg_516_1.time_ and arg_516_1.time_ <= var_519_10 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect1069ui_story == nil then
				arg_516_1.var_.characterEffect1069ui_story = var_519_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_11 = 0.200000002980232

			if var_519_10 <= arg_516_1.time_ and arg_516_1.time_ < var_519_10 + var_519_11 and not isNil(var_519_9) then
				local var_519_12 = (arg_516_1.time_ - var_519_10) / var_519_11

				if arg_516_1.var_.characterEffect1069ui_story and not isNil(var_519_9) then
					arg_516_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_10 + var_519_11 and arg_516_1.time_ < var_519_10 + var_519_11 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect1069ui_story then
				arg_516_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_519_13 = 0

			if var_519_13 < arg_516_1.time_ and arg_516_1.time_ <= var_519_13 + arg_519_0 then
				arg_516_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_519_14 = 0

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_519_15 = arg_516_1.actors_["10045ui_story"].transform
			local var_519_16 = 0

			if var_519_16 < arg_516_1.time_ and arg_516_1.time_ <= var_519_16 + arg_519_0 then
				arg_516_1.var_.moveOldPos10045ui_story = var_519_15.localPosition
			end

			local var_519_17 = 0.001

			if var_519_16 <= arg_516_1.time_ and arg_516_1.time_ < var_519_16 + var_519_17 then
				local var_519_18 = (arg_516_1.time_ - var_519_16) / var_519_17
				local var_519_19 = Vector3.New(-0.7, -1.18, -6.05)

				var_519_15.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos10045ui_story, var_519_19, var_519_18)

				local var_519_20 = manager.ui.mainCamera.transform.position - var_519_15.position

				var_519_15.forward = Vector3.New(var_519_20.x, var_519_20.y, var_519_20.z)

				local var_519_21 = var_519_15.localEulerAngles

				var_519_21.z = 0
				var_519_21.x = 0
				var_519_15.localEulerAngles = var_519_21
			end

			if arg_516_1.time_ >= var_519_16 + var_519_17 and arg_516_1.time_ < var_519_16 + var_519_17 + arg_519_0 then
				var_519_15.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_519_22 = manager.ui.mainCamera.transform.position - var_519_15.position

				var_519_15.forward = Vector3.New(var_519_22.x, var_519_22.y, var_519_22.z)

				local var_519_23 = var_519_15.localEulerAngles

				var_519_23.z = 0
				var_519_23.x = 0
				var_519_15.localEulerAngles = var_519_23
			end

			local var_519_24 = arg_516_1.actors_["10045ui_story"]
			local var_519_25 = 0

			if var_519_25 < arg_516_1.time_ and arg_516_1.time_ <= var_519_25 + arg_519_0 and not isNil(var_519_24) and arg_516_1.var_.characterEffect10045ui_story == nil then
				arg_516_1.var_.characterEffect10045ui_story = var_519_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_26 = 0.200000002980232

			if var_519_25 <= arg_516_1.time_ and arg_516_1.time_ < var_519_25 + var_519_26 and not isNil(var_519_24) then
				local var_519_27 = (arg_516_1.time_ - var_519_25) / var_519_26

				if arg_516_1.var_.characterEffect10045ui_story and not isNil(var_519_24) then
					local var_519_28 = Mathf.Lerp(0, 0.5, var_519_27)

					arg_516_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_516_1.var_.characterEffect10045ui_story.fillRatio = var_519_28
				end
			end

			if arg_516_1.time_ >= var_519_25 + var_519_26 and arg_516_1.time_ < var_519_25 + var_519_26 + arg_519_0 and not isNil(var_519_24) and arg_516_1.var_.characterEffect10045ui_story then
				local var_519_29 = 0.5

				arg_516_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_516_1.var_.characterEffect10045ui_story.fillRatio = var_519_29
			end

			local var_519_30 = 0

			if var_519_30 < arg_516_1.time_ and arg_516_1.time_ <= var_519_30 + arg_519_0 then
				arg_516_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action7_2")
			end

			local var_519_31 = 0
			local var_519_32 = 1.05

			if var_519_31 < arg_516_1.time_ and arg_516_1.time_ <= var_519_31 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_33 = arg_516_1:FormatText(StoryNameCfg[378].name)

				arg_516_1.leftNameTxt_.text = var_519_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_34 = arg_516_1:GetWordFromCfg(121481124)
				local var_519_35 = arg_516_1:FormatText(var_519_34.content)

				arg_516_1.text_.text = var_519_35

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_36 = 42
				local var_519_37 = utf8.len(var_519_35)
				local var_519_38 = var_519_36 <= 0 and var_519_32 or var_519_32 * (var_519_37 / var_519_36)

				if var_519_38 > 0 and var_519_32 < var_519_38 then
					arg_516_1.talkMaxDuration = var_519_38

					if var_519_38 + var_519_31 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_38 + var_519_31
					end
				end

				arg_516_1.text_.text = var_519_35
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481124", "story_v_out_121481.awb") ~= 0 then
					local var_519_39 = manager.audio:GetVoiceLength("story_v_out_121481", "121481124", "story_v_out_121481.awb") / 1000

					if var_519_39 + var_519_31 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_39 + var_519_31
					end

					if var_519_34.prefab_name ~= "" and arg_516_1.actors_[var_519_34.prefab_name] ~= nil then
						local var_519_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_34.prefab_name].transform, "story_v_out_121481", "121481124", "story_v_out_121481.awb")

						arg_516_1:RecordAudio("121481124", var_519_40)
						arg_516_1:RecordAudio("121481124", var_519_40)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_121481", "121481124", "story_v_out_121481.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_121481", "121481124", "story_v_out_121481.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_41 = math.max(var_519_32, arg_516_1.talkMaxDuration)

			if var_519_31 <= arg_516_1.time_ and arg_516_1.time_ < var_519_31 + var_519_41 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_31) / var_519_41

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_31 + var_519_41 and arg_516_1.time_ < var_519_31 + var_519_41 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_516_1:InitPlayNodeList()
	end,
	Play121481125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 121481125
		arg_520_1.duration_ = 7.5

		local var_520_0 = {
			ja = 5.366,
			ko = 7.5,
			zh = 7.5
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play121481126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.8

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[378].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_3 = arg_520_1:GetWordFromCfg(121481125)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 32
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481125", "story_v_out_121481.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481125", "story_v_out_121481.awb") / 1000

					if var_523_8 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_0
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_out_121481", "121481125", "story_v_out_121481.awb")

						arg_520_1:RecordAudio("121481125", var_523_9)
						arg_520_1:RecordAudio("121481125", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_121481", "121481125", "story_v_out_121481.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_121481", "121481125", "story_v_out_121481.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_10 and arg_520_1.time_ < var_523_0 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play121481126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 121481126
		arg_524_1.duration_ = 7.37

		local var_524_0 = {
			ja = 4.366,
			ko = 7.366,
			zh = 7.366
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play121481127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1069ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1069ui_story == nil then
				arg_524_1.var_.characterEffect1069ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect1069ui_story and not isNil(var_527_0) then
					local var_527_4 = Mathf.Lerp(0, 0.5, var_527_3)

					arg_524_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1069ui_story.fillRatio = var_527_4
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1069ui_story then
				local var_527_5 = 0.5

				arg_524_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1069ui_story.fillRatio = var_527_5
			end

			local var_527_6 = arg_524_1.actors_["10045ui_story"]
			local var_527_7 = 0

			if var_527_7 < arg_524_1.time_ and arg_524_1.time_ <= var_527_7 + arg_527_0 and not isNil(var_527_6) and arg_524_1.var_.characterEffect10045ui_story == nil then
				arg_524_1.var_.characterEffect10045ui_story = var_527_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_8 = 0.200000002980232

			if var_527_7 <= arg_524_1.time_ and arg_524_1.time_ < var_527_7 + var_527_8 and not isNil(var_527_6) then
				local var_527_9 = (arg_524_1.time_ - var_527_7) / var_527_8

				if arg_524_1.var_.characterEffect10045ui_story and not isNil(var_527_6) then
					arg_524_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= var_527_7 + var_527_8 and arg_524_1.time_ < var_527_7 + var_527_8 + arg_527_0 and not isNil(var_527_6) and arg_524_1.var_.characterEffect10045ui_story then
				arg_524_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_527_10 = 0
			local var_527_11 = 0.275

			if var_527_10 < arg_524_1.time_ and arg_524_1.time_ <= var_527_10 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_12 = arg_524_1:FormatText(StoryNameCfg[412].name)

				arg_524_1.leftNameTxt_.text = var_527_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_13 = arg_524_1:GetWordFromCfg(121481126)
				local var_527_14 = arg_524_1:FormatText(var_527_13.content)

				arg_524_1.text_.text = var_527_14

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_15 = 11
				local var_527_16 = utf8.len(var_527_14)
				local var_527_17 = var_527_15 <= 0 and var_527_11 or var_527_11 * (var_527_16 / var_527_15)

				if var_527_17 > 0 and var_527_11 < var_527_17 then
					arg_524_1.talkMaxDuration = var_527_17

					if var_527_17 + var_527_10 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_17 + var_527_10
					end
				end

				arg_524_1.text_.text = var_527_14
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481126", "story_v_out_121481.awb") ~= 0 then
					local var_527_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481126", "story_v_out_121481.awb") / 1000

					if var_527_18 + var_527_10 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_18 + var_527_10
					end

					if var_527_13.prefab_name ~= "" and arg_524_1.actors_[var_527_13.prefab_name] ~= nil then
						local var_527_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_13.prefab_name].transform, "story_v_out_121481", "121481126", "story_v_out_121481.awb")

						arg_524_1:RecordAudio("121481126", var_527_19)
						arg_524_1:RecordAudio("121481126", var_527_19)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_121481", "121481126", "story_v_out_121481.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_121481", "121481126", "story_v_out_121481.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_20 = math.max(var_527_11, arg_524_1.talkMaxDuration)

			if var_527_10 <= arg_524_1.time_ and arg_524_1.time_ < var_527_10 + var_527_20 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_10) / var_527_20

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_10 + var_527_20 and arg_524_1.time_ < var_527_10 + var_527_20 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play121481127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 121481127
		arg_528_1.duration_ = 11.47

		local var_528_0 = {
			ja = 11.466,
			ko = 6.5,
			zh = 6.5
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play121481128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1069ui_story"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1069ui_story == nil then
				arg_528_1.var_.characterEffect1069ui_story = var_531_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_2 = 0.200000002980232

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.characterEffect1069ui_story and not isNil(var_531_0) then
					arg_528_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1069ui_story then
				arg_528_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_531_4 = arg_528_1.actors_["10045ui_story"]
			local var_531_5 = 0

			if var_531_5 < arg_528_1.time_ and arg_528_1.time_ <= var_531_5 + arg_531_0 and not isNil(var_531_4) and arg_528_1.var_.characterEffect10045ui_story == nil then
				arg_528_1.var_.characterEffect10045ui_story = var_531_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_6 = 0.200000002980232

			if var_531_5 <= arg_528_1.time_ and arg_528_1.time_ < var_531_5 + var_531_6 and not isNil(var_531_4) then
				local var_531_7 = (arg_528_1.time_ - var_531_5) / var_531_6

				if arg_528_1.var_.characterEffect10045ui_story and not isNil(var_531_4) then
					local var_531_8 = Mathf.Lerp(0, 0.5, var_531_7)

					arg_528_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_528_1.var_.characterEffect10045ui_story.fillRatio = var_531_8
				end
			end

			if arg_528_1.time_ >= var_531_5 + var_531_6 and arg_528_1.time_ < var_531_5 + var_531_6 + arg_531_0 and not isNil(var_531_4) and arg_528_1.var_.characterEffect10045ui_story then
				local var_531_9 = 0.5

				arg_528_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_528_1.var_.characterEffect10045ui_story.fillRatio = var_531_9
			end

			local var_531_10 = 0
			local var_531_11 = 0.725

			if var_531_10 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_12 = arg_528_1:FormatText(StoryNameCfg[378].name)

				arg_528_1.leftNameTxt_.text = var_531_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_13 = arg_528_1:GetWordFromCfg(121481127)
				local var_531_14 = arg_528_1:FormatText(var_531_13.content)

				arg_528_1.text_.text = var_531_14

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_15 = 29
				local var_531_16 = utf8.len(var_531_14)
				local var_531_17 = var_531_15 <= 0 and var_531_11 or var_531_11 * (var_531_16 / var_531_15)

				if var_531_17 > 0 and var_531_11 < var_531_17 then
					arg_528_1.talkMaxDuration = var_531_17

					if var_531_17 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_17 + var_531_10
					end
				end

				arg_528_1.text_.text = var_531_14
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481127", "story_v_out_121481.awb") ~= 0 then
					local var_531_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481127", "story_v_out_121481.awb") / 1000

					if var_531_18 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_18 + var_531_10
					end

					if var_531_13.prefab_name ~= "" and arg_528_1.actors_[var_531_13.prefab_name] ~= nil then
						local var_531_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_13.prefab_name].transform, "story_v_out_121481", "121481127", "story_v_out_121481.awb")

						arg_528_1:RecordAudio("121481127", var_531_19)
						arg_528_1:RecordAudio("121481127", var_531_19)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_121481", "121481127", "story_v_out_121481.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_121481", "121481127", "story_v_out_121481.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_20 = math.max(var_531_11, arg_528_1.talkMaxDuration)

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_20 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_10) / var_531_20

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_10 + var_531_20 and arg_528_1.time_ < var_531_10 + var_531_20 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play121481128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 121481128
		arg_532_1.duration_ = 5.4

		local var_532_0 = {
			ja = 5.033,
			ko = 5.4,
			zh = 5.4
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play121481129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["10045ui_story"].transform
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.var_.moveOldPos10045ui_story = var_535_0.localPosition
			end

			local var_535_2 = 0.001

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2
				local var_535_4 = Vector3.New(0, 100, 0)

				var_535_0.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos10045ui_story, var_535_4, var_535_3)

				local var_535_5 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_5.x, var_535_5.y, var_535_5.z)

				local var_535_6 = var_535_0.localEulerAngles

				var_535_6.z = 0
				var_535_6.x = 0
				var_535_0.localEulerAngles = var_535_6
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 then
				var_535_0.localPosition = Vector3.New(0, 100, 0)

				local var_535_7 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_7.x, var_535_7.y, var_535_7.z)

				local var_535_8 = var_535_0.localEulerAngles

				var_535_8.z = 0
				var_535_8.x = 0
				var_535_0.localEulerAngles = var_535_8
			end

			local var_535_9 = arg_532_1.actors_["1069ui_story"].transform
			local var_535_10 = 0

			if var_535_10 < arg_532_1.time_ and arg_532_1.time_ <= var_535_10 + arg_535_0 then
				arg_532_1.var_.moveOldPos1069ui_story = var_535_9.localPosition
			end

			local var_535_11 = 0.001

			if var_535_10 <= arg_532_1.time_ and arg_532_1.time_ < var_535_10 + var_535_11 then
				local var_535_12 = (arg_532_1.time_ - var_535_10) / var_535_11
				local var_535_13 = Vector3.New(0, 100, 0)

				var_535_9.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1069ui_story, var_535_13, var_535_12)

				local var_535_14 = manager.ui.mainCamera.transform.position - var_535_9.position

				var_535_9.forward = Vector3.New(var_535_14.x, var_535_14.y, var_535_14.z)

				local var_535_15 = var_535_9.localEulerAngles

				var_535_15.z = 0
				var_535_15.x = 0
				var_535_9.localEulerAngles = var_535_15
			end

			if arg_532_1.time_ >= var_535_10 + var_535_11 and arg_532_1.time_ < var_535_10 + var_535_11 + arg_535_0 then
				var_535_9.localPosition = Vector3.New(0, 100, 0)

				local var_535_16 = manager.ui.mainCamera.transform.position - var_535_9.position

				var_535_9.forward = Vector3.New(var_535_16.x, var_535_16.y, var_535_16.z)

				local var_535_17 = var_535_9.localEulerAngles

				var_535_17.z = 0
				var_535_17.x = 0
				var_535_9.localEulerAngles = var_535_17
			end

			local var_535_18 = 0.225
			local var_535_19 = 0.408333333333333

			if var_535_18 < arg_532_1.time_ and arg_532_1.time_ <= var_535_18 + arg_535_0 then
				local var_535_20 = "play"
				local var_535_21 = "effect"

				arg_532_1:AudioAction(var_535_20, var_535_21, "se_story_121_04", "se_story_121_04_bonebreak2", "")
			end

			local var_535_22 = 0
			local var_535_23 = 0.225

			if var_535_22 < arg_532_1.time_ and arg_532_1.time_ <= var_535_22 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_24 = arg_532_1:FormatText(StoryNameCfg[412].name)

				arg_532_1.leftNameTxt_.text = var_535_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_25 = arg_532_1:GetWordFromCfg(121481128)
				local var_535_26 = arg_532_1:FormatText(var_535_25.content)

				arg_532_1.text_.text = var_535_26

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_27 = 9
				local var_535_28 = utf8.len(var_535_26)
				local var_535_29 = var_535_27 <= 0 and var_535_23 or var_535_23 * (var_535_28 / var_535_27)

				if var_535_29 > 0 and var_535_23 < var_535_29 then
					arg_532_1.talkMaxDuration = var_535_29

					if var_535_29 + var_535_22 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_29 + var_535_22
					end
				end

				arg_532_1.text_.text = var_535_26
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481128", "story_v_out_121481.awb") ~= 0 then
					local var_535_30 = manager.audio:GetVoiceLength("story_v_out_121481", "121481128", "story_v_out_121481.awb") / 1000

					if var_535_30 + var_535_22 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_30 + var_535_22
					end

					if var_535_25.prefab_name ~= "" and arg_532_1.actors_[var_535_25.prefab_name] ~= nil then
						local var_535_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_25.prefab_name].transform, "story_v_out_121481", "121481128", "story_v_out_121481.awb")

						arg_532_1:RecordAudio("121481128", var_535_31)
						arg_532_1:RecordAudio("121481128", var_535_31)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_121481", "121481128", "story_v_out_121481.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_121481", "121481128", "story_v_out_121481.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_32 = math.max(var_535_23, arg_532_1.talkMaxDuration)

			if var_535_22 <= arg_532_1.time_ and arg_532_1.time_ < var_535_22 + var_535_32 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_22) / var_535_32

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_22 + var_535_32 and arg_532_1.time_ < var_535_22 + var_535_32 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play121481129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 121481129
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play121481130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.475

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_2 = arg_536_1:GetWordFromCfg(121481129)
				local var_539_3 = arg_536_1:FormatText(var_539_2.content)

				arg_536_1.text_.text = var_539_3

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_4 = 19
				local var_539_5 = utf8.len(var_539_3)
				local var_539_6 = var_539_4 <= 0 and var_539_1 or var_539_1 * (var_539_5 / var_539_4)

				if var_539_6 > 0 and var_539_1 < var_539_6 then
					arg_536_1.talkMaxDuration = var_539_6

					if var_539_6 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_6 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_3
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_7 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_7 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_7

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_7 and arg_536_1.time_ < var_539_0 + var_539_7 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play121481130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 121481130
		arg_540_1.duration_ = 8.17

		local var_540_0 = {
			ja = 5.7,
			ko = 8.166,
			zh = 8.166
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play121481131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1069ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos1069ui_story = var_543_0.localPosition
			end

			local var_543_2 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2
				local var_543_4 = Vector3.New(0.7, -1, -6)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1069ui_story, var_543_4, var_543_3)

				local var_543_5 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_5.x, var_543_5.y, var_543_5.z)

				local var_543_6 = var_543_0.localEulerAngles

				var_543_6.z = 0
				var_543_6.x = 0
				var_543_0.localEulerAngles = var_543_6
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0.7, -1, -6)

				local var_543_7 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_7.x, var_543_7.y, var_543_7.z)

				local var_543_8 = var_543_0.localEulerAngles

				var_543_8.z = 0
				var_543_8.x = 0
				var_543_0.localEulerAngles = var_543_8
			end

			local var_543_9 = arg_540_1.actors_["1069ui_story"]
			local var_543_10 = 0

			if var_543_10 < arg_540_1.time_ and arg_540_1.time_ <= var_543_10 + arg_543_0 and not isNil(var_543_9) and arg_540_1.var_.characterEffect1069ui_story == nil then
				arg_540_1.var_.characterEffect1069ui_story = var_543_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_11 = 0.200000002980232

			if var_543_10 <= arg_540_1.time_ and arg_540_1.time_ < var_543_10 + var_543_11 and not isNil(var_543_9) then
				local var_543_12 = (arg_540_1.time_ - var_543_10) / var_543_11

				if arg_540_1.var_.characterEffect1069ui_story and not isNil(var_543_9) then
					arg_540_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_540_1.time_ >= var_543_10 + var_543_11 and arg_540_1.time_ < var_543_10 + var_543_11 + arg_543_0 and not isNil(var_543_9) and arg_540_1.var_.characterEffect1069ui_story then
				arg_540_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_543_13 = 0

			if var_543_13 < arg_540_1.time_ and arg_540_1.time_ <= var_543_13 + arg_543_0 then
				arg_540_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action423")
			end

			local var_543_14 = 0

			if var_543_14 < arg_540_1.time_ and arg_540_1.time_ <= var_543_14 + arg_543_0 then
				arg_540_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_543_15 = arg_540_1.actors_["10045ui_story"].transform
			local var_543_16 = 0

			if var_543_16 < arg_540_1.time_ and arg_540_1.time_ <= var_543_16 + arg_543_0 then
				arg_540_1.var_.moveOldPos10045ui_story = var_543_15.localPosition
			end

			local var_543_17 = 0.001

			if var_543_16 <= arg_540_1.time_ and arg_540_1.time_ < var_543_16 + var_543_17 then
				local var_543_18 = (arg_540_1.time_ - var_543_16) / var_543_17
				local var_543_19 = Vector3.New(-0.7, -1.18, -6.05)

				var_543_15.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos10045ui_story, var_543_19, var_543_18)

				local var_543_20 = manager.ui.mainCamera.transform.position - var_543_15.position

				var_543_15.forward = Vector3.New(var_543_20.x, var_543_20.y, var_543_20.z)

				local var_543_21 = var_543_15.localEulerAngles

				var_543_21.z = 0
				var_543_21.x = 0
				var_543_15.localEulerAngles = var_543_21
			end

			if arg_540_1.time_ >= var_543_16 + var_543_17 and arg_540_1.time_ < var_543_16 + var_543_17 + arg_543_0 then
				var_543_15.localPosition = Vector3.New(-0.7, -1.18, -6.05)

				local var_543_22 = manager.ui.mainCamera.transform.position - var_543_15.position

				var_543_15.forward = Vector3.New(var_543_22.x, var_543_22.y, var_543_22.z)

				local var_543_23 = var_543_15.localEulerAngles

				var_543_23.z = 0
				var_543_23.x = 0
				var_543_15.localEulerAngles = var_543_23
			end

			local var_543_24 = arg_540_1.actors_["10045ui_story"]
			local var_543_25 = 0

			if var_543_25 < arg_540_1.time_ and arg_540_1.time_ <= var_543_25 + arg_543_0 and not isNil(var_543_24) and arg_540_1.var_.characterEffect10045ui_story == nil then
				arg_540_1.var_.characterEffect10045ui_story = var_543_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_26 = 0.200000002980232

			if var_543_25 <= arg_540_1.time_ and arg_540_1.time_ < var_543_25 + var_543_26 and not isNil(var_543_24) then
				local var_543_27 = (arg_540_1.time_ - var_543_25) / var_543_26

				if arg_540_1.var_.characterEffect10045ui_story and not isNil(var_543_24) then
					local var_543_28 = Mathf.Lerp(0, 0.5, var_543_27)

					arg_540_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_540_1.var_.characterEffect10045ui_story.fillRatio = var_543_28
				end
			end

			if arg_540_1.time_ >= var_543_25 + var_543_26 and arg_540_1.time_ < var_543_25 + var_543_26 + arg_543_0 and not isNil(var_543_24) and arg_540_1.var_.characterEffect10045ui_story then
				local var_543_29 = 0.5

				arg_540_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_540_1.var_.characterEffect10045ui_story.fillRatio = var_543_29
			end

			local var_543_30 = 0

			if var_543_30 < arg_540_1.time_ and arg_540_1.time_ <= var_543_30 + arg_543_0 then
				arg_540_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action7_2")
			end

			local var_543_31 = 0
			local var_543_32 = 0.925

			if var_543_31 < arg_540_1.time_ and arg_540_1.time_ <= var_543_31 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_33 = arg_540_1:FormatText(StoryNameCfg[378].name)

				arg_540_1.leftNameTxt_.text = var_543_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_34 = arg_540_1:GetWordFromCfg(121481130)
				local var_543_35 = arg_540_1:FormatText(var_543_34.content)

				arg_540_1.text_.text = var_543_35

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_36 = 37
				local var_543_37 = utf8.len(var_543_35)
				local var_543_38 = var_543_36 <= 0 and var_543_32 or var_543_32 * (var_543_37 / var_543_36)

				if var_543_38 > 0 and var_543_32 < var_543_38 then
					arg_540_1.talkMaxDuration = var_543_38

					if var_543_38 + var_543_31 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_38 + var_543_31
					end
				end

				arg_540_1.text_.text = var_543_35
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481130", "story_v_out_121481.awb") ~= 0 then
					local var_543_39 = manager.audio:GetVoiceLength("story_v_out_121481", "121481130", "story_v_out_121481.awb") / 1000

					if var_543_39 + var_543_31 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_39 + var_543_31
					end

					if var_543_34.prefab_name ~= "" and arg_540_1.actors_[var_543_34.prefab_name] ~= nil then
						local var_543_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_34.prefab_name].transform, "story_v_out_121481", "121481130", "story_v_out_121481.awb")

						arg_540_1:RecordAudio("121481130", var_543_40)
						arg_540_1:RecordAudio("121481130", var_543_40)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_121481", "121481130", "story_v_out_121481.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_121481", "121481130", "story_v_out_121481.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_41 = math.max(var_543_32, arg_540_1.talkMaxDuration)

			if var_543_31 <= arg_540_1.time_ and arg_540_1.time_ < var_543_31 + var_543_41 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_31) / var_543_41

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_31 + var_543_41 and arg_540_1.time_ < var_543_31 + var_543_41 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_540_1:InitPlayNodeList()
	end,
	Play121481131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 121481131
		arg_544_1.duration_ = 11.27

		local var_544_0 = {
			ja = 9.533,
			ko = 11.266,
			zh = 11.266
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play121481132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 1.075

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[378].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_3 = arg_544_1:GetWordFromCfg(121481131)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 43
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481131", "story_v_out_121481.awb") ~= 0 then
					local var_547_8 = manager.audio:GetVoiceLength("story_v_out_121481", "121481131", "story_v_out_121481.awb") / 1000

					if var_547_8 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_8 + var_547_0
					end

					if var_547_3.prefab_name ~= "" and arg_544_1.actors_[var_547_3.prefab_name] ~= nil then
						local var_547_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_3.prefab_name].transform, "story_v_out_121481", "121481131", "story_v_out_121481.awb")

						arg_544_1:RecordAudio("121481131", var_547_9)
						arg_544_1:RecordAudio("121481131", var_547_9)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_121481", "121481131", "story_v_out_121481.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_121481", "121481131", "story_v_out_121481.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_10 and arg_544_1.time_ < var_547_0 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play121481132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 121481132
		arg_548_1.duration_ = 8

		local var_548_0 = {
			ja = 7.3,
			ko = 8,
			zh = 8
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play121481133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1069ui_story"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1069ui_story == nil then
				arg_548_1.var_.characterEffect1069ui_story = var_551_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_2 = 0.200000002980232

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.characterEffect1069ui_story and not isNil(var_551_0) then
					local var_551_4 = Mathf.Lerp(0, 0.5, var_551_3)

					arg_548_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_548_1.var_.characterEffect1069ui_story.fillRatio = var_551_4
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1069ui_story then
				local var_551_5 = 0.5

				arg_548_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_548_1.var_.characterEffect1069ui_story.fillRatio = var_551_5
			end

			local var_551_6 = arg_548_1.actors_["10045ui_story"]
			local var_551_7 = 0

			if var_551_7 < arg_548_1.time_ and arg_548_1.time_ <= var_551_7 + arg_551_0 and not isNil(var_551_6) and arg_548_1.var_.characterEffect10045ui_story == nil then
				arg_548_1.var_.characterEffect10045ui_story = var_551_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_8 = 0.200000002980232

			if var_551_7 <= arg_548_1.time_ and arg_548_1.time_ < var_551_7 + var_551_8 and not isNil(var_551_6) then
				local var_551_9 = (arg_548_1.time_ - var_551_7) / var_551_8

				if arg_548_1.var_.characterEffect10045ui_story and not isNil(var_551_6) then
					arg_548_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= var_551_7 + var_551_8 and arg_548_1.time_ < var_551_7 + var_551_8 + arg_551_0 and not isNil(var_551_6) and arg_548_1.var_.characterEffect10045ui_story then
				arg_548_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_551_10 = 0
			local var_551_11 = 0.375

			if var_551_10 < arg_548_1.time_ and arg_548_1.time_ <= var_551_10 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_12 = arg_548_1:FormatText(StoryNameCfg[412].name)

				arg_548_1.leftNameTxt_.text = var_551_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_13 = arg_548_1:GetWordFromCfg(121481132)
				local var_551_14 = arg_548_1:FormatText(var_551_13.content)

				arg_548_1.text_.text = var_551_14

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_15 = 15
				local var_551_16 = utf8.len(var_551_14)
				local var_551_17 = var_551_15 <= 0 and var_551_11 or var_551_11 * (var_551_16 / var_551_15)

				if var_551_17 > 0 and var_551_11 < var_551_17 then
					arg_548_1.talkMaxDuration = var_551_17

					if var_551_17 + var_551_10 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_17 + var_551_10
					end
				end

				arg_548_1.text_.text = var_551_14
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481132", "story_v_out_121481.awb") ~= 0 then
					local var_551_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481132", "story_v_out_121481.awb") / 1000

					if var_551_18 + var_551_10 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_18 + var_551_10
					end

					if var_551_13.prefab_name ~= "" and arg_548_1.actors_[var_551_13.prefab_name] ~= nil then
						local var_551_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_13.prefab_name].transform, "story_v_out_121481", "121481132", "story_v_out_121481.awb")

						arg_548_1:RecordAudio("121481132", var_551_19)
						arg_548_1:RecordAudio("121481132", var_551_19)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_121481", "121481132", "story_v_out_121481.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_121481", "121481132", "story_v_out_121481.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_20 = math.max(var_551_11, arg_548_1.talkMaxDuration)

			if var_551_10 <= arg_548_1.time_ and arg_548_1.time_ < var_551_10 + var_551_20 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_10) / var_551_20

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_10 + var_551_20 and arg_548_1.time_ < var_551_10 + var_551_20 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play121481133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 121481133
		arg_552_1.duration_ = 7.97

		local var_552_0 = {
			ja = 7.966,
			ko = 5.9,
			zh = 5.9
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play121481134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1069ui_story"]
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect1069ui_story == nil then
				arg_552_1.var_.characterEffect1069ui_story = var_555_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_2 = 0.200000002980232

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 and not isNil(var_555_0) then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2

				if arg_552_1.var_.characterEffect1069ui_story and not isNil(var_555_0) then
					arg_552_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect1069ui_story then
				arg_552_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_555_4 = arg_552_1.actors_["10045ui_story"]
			local var_555_5 = 0

			if var_555_5 < arg_552_1.time_ and arg_552_1.time_ <= var_555_5 + arg_555_0 and not isNil(var_555_4) and arg_552_1.var_.characterEffect10045ui_story == nil then
				arg_552_1.var_.characterEffect10045ui_story = var_555_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_6 = 0.200000002980232

			if var_555_5 <= arg_552_1.time_ and arg_552_1.time_ < var_555_5 + var_555_6 and not isNil(var_555_4) then
				local var_555_7 = (arg_552_1.time_ - var_555_5) / var_555_6

				if arg_552_1.var_.characterEffect10045ui_story and not isNil(var_555_4) then
					local var_555_8 = Mathf.Lerp(0, 0.5, var_555_7)

					arg_552_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_552_1.var_.characterEffect10045ui_story.fillRatio = var_555_8
				end
			end

			if arg_552_1.time_ >= var_555_5 + var_555_6 and arg_552_1.time_ < var_555_5 + var_555_6 + arg_555_0 and not isNil(var_555_4) and arg_552_1.var_.characterEffect10045ui_story then
				local var_555_9 = 0.5

				arg_552_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_552_1.var_.characterEffect10045ui_story.fillRatio = var_555_9
			end

			local var_555_10 = 0

			if var_555_10 < arg_552_1.time_ and arg_552_1.time_ <= var_555_10 + arg_555_0 then
				arg_552_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_555_11 = 0

			if var_555_11 < arg_552_1.time_ and arg_552_1.time_ <= var_555_11 + arg_555_0 then
				arg_552_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action432")
			end

			local var_555_12 = 0
			local var_555_13 = 0.5

			if var_555_12 < arg_552_1.time_ and arg_552_1.time_ <= var_555_12 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_14 = arg_552_1:FormatText(StoryNameCfg[378].name)

				arg_552_1.leftNameTxt_.text = var_555_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_15 = arg_552_1:GetWordFromCfg(121481133)
				local var_555_16 = arg_552_1:FormatText(var_555_15.content)

				arg_552_1.text_.text = var_555_16

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_17 = 20
				local var_555_18 = utf8.len(var_555_16)
				local var_555_19 = var_555_17 <= 0 and var_555_13 or var_555_13 * (var_555_18 / var_555_17)

				if var_555_19 > 0 and var_555_13 < var_555_19 then
					arg_552_1.talkMaxDuration = var_555_19

					if var_555_19 + var_555_12 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_19 + var_555_12
					end
				end

				arg_552_1.text_.text = var_555_16
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481133", "story_v_out_121481.awb") ~= 0 then
					local var_555_20 = manager.audio:GetVoiceLength("story_v_out_121481", "121481133", "story_v_out_121481.awb") / 1000

					if var_555_20 + var_555_12 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_20 + var_555_12
					end

					if var_555_15.prefab_name ~= "" and arg_552_1.actors_[var_555_15.prefab_name] ~= nil then
						local var_555_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_15.prefab_name].transform, "story_v_out_121481", "121481133", "story_v_out_121481.awb")

						arg_552_1:RecordAudio("121481133", var_555_21)
						arg_552_1:RecordAudio("121481133", var_555_21)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_121481", "121481133", "story_v_out_121481.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_121481", "121481133", "story_v_out_121481.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_22 = math.max(var_555_13, arg_552_1.talkMaxDuration)

			if var_555_12 <= arg_552_1.time_ and arg_552_1.time_ < var_555_12 + var_555_22 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_12) / var_555_22

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_12 + var_555_22 and arg_552_1.time_ < var_555_12 + var_555_22 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play121481134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 121481134
		arg_556_1.duration_ = 8.23

		local var_556_0 = {
			ja = 5.6,
			ko = 8.233,
			zh = 8.233
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play121481135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["10045ui_story"]
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect10045ui_story == nil then
				arg_556_1.var_.characterEffect10045ui_story = var_559_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_2 = 0.200000002980232

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 and not isNil(var_559_0) then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2

				if arg_556_1.var_.characterEffect10045ui_story and not isNil(var_559_0) then
					arg_556_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect10045ui_story then
				arg_556_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_559_4 = arg_556_1.actors_["1069ui_story"]
			local var_559_5 = 0

			if var_559_5 < arg_556_1.time_ and arg_556_1.time_ <= var_559_5 + arg_559_0 and not isNil(var_559_4) and arg_556_1.var_.characterEffect1069ui_story == nil then
				arg_556_1.var_.characterEffect1069ui_story = var_559_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_6 = 0.200000002980232

			if var_559_5 <= arg_556_1.time_ and arg_556_1.time_ < var_559_5 + var_559_6 and not isNil(var_559_4) then
				local var_559_7 = (arg_556_1.time_ - var_559_5) / var_559_6

				if arg_556_1.var_.characterEffect1069ui_story and not isNil(var_559_4) then
					local var_559_8 = Mathf.Lerp(0, 0.5, var_559_7)

					arg_556_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1069ui_story.fillRatio = var_559_8
				end
			end

			if arg_556_1.time_ >= var_559_5 + var_559_6 and arg_556_1.time_ < var_559_5 + var_559_6 + arg_559_0 and not isNil(var_559_4) and arg_556_1.var_.characterEffect1069ui_story then
				local var_559_9 = 0.5

				arg_556_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1069ui_story.fillRatio = var_559_9
			end

			local var_559_10 = 0
			local var_559_11 = 0.525

			if var_559_10 < arg_556_1.time_ and arg_556_1.time_ <= var_559_10 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_12 = arg_556_1:FormatText(StoryNameCfg[412].name)

				arg_556_1.leftNameTxt_.text = var_559_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_13 = arg_556_1:GetWordFromCfg(121481134)
				local var_559_14 = arg_556_1:FormatText(var_559_13.content)

				arg_556_1.text_.text = var_559_14

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_15 = 21
				local var_559_16 = utf8.len(var_559_14)
				local var_559_17 = var_559_15 <= 0 and var_559_11 or var_559_11 * (var_559_16 / var_559_15)

				if var_559_17 > 0 and var_559_11 < var_559_17 then
					arg_556_1.talkMaxDuration = var_559_17

					if var_559_17 + var_559_10 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_17 + var_559_10
					end
				end

				arg_556_1.text_.text = var_559_14
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121481", "121481134", "story_v_out_121481.awb") ~= 0 then
					local var_559_18 = manager.audio:GetVoiceLength("story_v_out_121481", "121481134", "story_v_out_121481.awb") / 1000

					if var_559_18 + var_559_10 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_18 + var_559_10
					end

					if var_559_13.prefab_name ~= "" and arg_556_1.actors_[var_559_13.prefab_name] ~= nil then
						local var_559_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_13.prefab_name].transform, "story_v_out_121481", "121481134", "story_v_out_121481.awb")

						arg_556_1:RecordAudio("121481134", var_559_19)
						arg_556_1:RecordAudio("121481134", var_559_19)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_121481", "121481134", "story_v_out_121481.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_121481", "121481134", "story_v_out_121481.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_20 = math.max(var_559_11, arg_556_1.talkMaxDuration)

			if var_559_10 <= arg_556_1.time_ and arg_556_1.time_ < var_559_10 + var_559_20 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_10) / var_559_20

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_10 + var_559_20 and arg_556_1.time_ < var_559_10 + var_559_20 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play121481135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 121481135
		arg_560_1.duration_ = 7

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play121481136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1069ui_story"].transform
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.var_.moveOldPos1069ui_story = var_563_0.localPosition
			end

			local var_563_2 = 0.001

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2
				local var_563_4 = Vector3.New(0, 100, 0)

				var_563_0.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos1069ui_story, var_563_4, var_563_3)

				local var_563_5 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_5.x, var_563_5.y, var_563_5.z)

				local var_563_6 = var_563_0.localEulerAngles

				var_563_6.z = 0
				var_563_6.x = 0
				var_563_0.localEulerAngles = var_563_6
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 then
				var_563_0.localPosition = Vector3.New(0, 100, 0)

				local var_563_7 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_7.x, var_563_7.y, var_563_7.z)

				local var_563_8 = var_563_0.localEulerAngles

				var_563_8.z = 0
				var_563_8.x = 0
				var_563_0.localEulerAngles = var_563_8
			end

			local var_563_9 = arg_560_1.actors_["1069ui_story"]
			local var_563_10 = 0

			if var_563_10 < arg_560_1.time_ and arg_560_1.time_ <= var_563_10 + arg_563_0 and not isNil(var_563_9) and arg_560_1.var_.characterEffect1069ui_story == nil then
				arg_560_1.var_.characterEffect1069ui_story = var_563_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_11 = 0.200000002980232

			if var_563_10 <= arg_560_1.time_ and arg_560_1.time_ < var_563_10 + var_563_11 and not isNil(var_563_9) then
				local var_563_12 = (arg_560_1.time_ - var_563_10) / var_563_11

				if arg_560_1.var_.characterEffect1069ui_story and not isNil(var_563_9) then
					local var_563_13 = Mathf.Lerp(0, 0.5, var_563_12)

					arg_560_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1069ui_story.fillRatio = var_563_13
				end
			end

			if arg_560_1.time_ >= var_563_10 + var_563_11 and arg_560_1.time_ < var_563_10 + var_563_11 + arg_563_0 and not isNil(var_563_9) and arg_560_1.var_.characterEffect1069ui_story then
				local var_563_14 = 0.5

				arg_560_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1069ui_story.fillRatio = var_563_14
			end

			local var_563_15 = arg_560_1.actors_["10045ui_story"].transform
			local var_563_16 = 0

			if var_563_16 < arg_560_1.time_ and arg_560_1.time_ <= var_563_16 + arg_563_0 then
				arg_560_1.var_.moveOldPos10045ui_story = var_563_15.localPosition
			end

			local var_563_17 = 0.001

			if var_563_16 <= arg_560_1.time_ and arg_560_1.time_ < var_563_16 + var_563_17 then
				local var_563_18 = (arg_560_1.time_ - var_563_16) / var_563_17
				local var_563_19 = Vector3.New(0, 100, 0)

				var_563_15.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos10045ui_story, var_563_19, var_563_18)

				local var_563_20 = manager.ui.mainCamera.transform.position - var_563_15.position

				var_563_15.forward = Vector3.New(var_563_20.x, var_563_20.y, var_563_20.z)

				local var_563_21 = var_563_15.localEulerAngles

				var_563_21.z = 0
				var_563_21.x = 0
				var_563_15.localEulerAngles = var_563_21
			end

			if arg_560_1.time_ >= var_563_16 + var_563_17 and arg_560_1.time_ < var_563_16 + var_563_17 + arg_563_0 then
				var_563_15.localPosition = Vector3.New(0, 100, 0)

				local var_563_22 = manager.ui.mainCamera.transform.position - var_563_15.position

				var_563_15.forward = Vector3.New(var_563_22.x, var_563_22.y, var_563_22.z)

				local var_563_23 = var_563_15.localEulerAngles

				var_563_23.z = 0
				var_563_23.x = 0
				var_563_15.localEulerAngles = var_563_23
			end

			local var_563_24 = arg_560_1.actors_["10045ui_story"]
			local var_563_25 = 0

			if var_563_25 < arg_560_1.time_ and arg_560_1.time_ <= var_563_25 + arg_563_0 and not isNil(var_563_24) and arg_560_1.var_.characterEffect10045ui_story == nil then
				arg_560_1.var_.characterEffect10045ui_story = var_563_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_26 = 0.200000002980232

			if var_563_25 <= arg_560_1.time_ and arg_560_1.time_ < var_563_25 + var_563_26 and not isNil(var_563_24) then
				local var_563_27 = (arg_560_1.time_ - var_563_25) / var_563_26

				if arg_560_1.var_.characterEffect10045ui_story and not isNil(var_563_24) then
					local var_563_28 = Mathf.Lerp(0, 0.5, var_563_27)

					arg_560_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_560_1.var_.characterEffect10045ui_story.fillRatio = var_563_28
				end
			end

			if arg_560_1.time_ >= var_563_25 + var_563_26 and arg_560_1.time_ < var_563_25 + var_563_26 + arg_563_0 and not isNil(var_563_24) and arg_560_1.var_.characterEffect10045ui_story then
				local var_563_29 = 0.5

				arg_560_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_560_1.var_.characterEffect10045ui_story.fillRatio = var_563_29
			end

			local var_563_30 = 0

			if var_563_30 < arg_560_1.time_ and arg_560_1.time_ <= var_563_30 + arg_563_0 then
				arg_560_1.mask_.enabled = true
				arg_560_1.mask_.raycastTarget = true

				arg_560_1:SetGaussion(false)
			end

			local var_563_31 = 2

			if var_563_30 <= arg_560_1.time_ and arg_560_1.time_ < var_563_30 + var_563_31 then
				local var_563_32 = (arg_560_1.time_ - var_563_30) / var_563_31
				local var_563_33 = Color.New(1, 1, 1)

				var_563_33.a = Mathf.Lerp(1, 0, var_563_32)
				arg_560_1.mask_.color = var_563_33
			end

			if arg_560_1.time_ >= var_563_30 + var_563_31 and arg_560_1.time_ < var_563_30 + var_563_31 + arg_563_0 then
				local var_563_34 = Color.New(1, 1, 1)
				local var_563_35 = 0

				arg_560_1.mask_.enabled = false
				var_563_34.a = var_563_35
				arg_560_1.mask_.color = var_563_34
			end

			local var_563_36 = manager.ui.mainCamera.transform
			local var_563_37 = 0.9

			if var_563_37 < arg_560_1.time_ and arg_560_1.time_ <= var_563_37 + arg_563_0 then
				arg_560_1.var_.shakeOldPos = var_563_36.localPosition
			end

			local var_563_38 = 1.1

			if var_563_37 <= arg_560_1.time_ and arg_560_1.time_ < var_563_37 + var_563_38 then
				local var_563_39 = (arg_560_1.time_ - var_563_37) / 0.066
				local var_563_40, var_563_41 = math.modf(var_563_39)

				var_563_36.localPosition = Vector3.New(var_563_41 * 0.13, var_563_41 * 0.13, var_563_41 * 0.13) + arg_560_1.var_.shakeOldPos
			end

			if arg_560_1.time_ >= var_563_37 + var_563_38 and arg_560_1.time_ < var_563_37 + var_563_38 + arg_563_0 then
				var_563_36.localPosition = arg_560_1.var_.shakeOldPos
			end

			local var_563_42 = 0.5
			local var_563_43 = 0.633333333333333

			if var_563_42 < arg_560_1.time_ and arg_560_1.time_ <= var_563_42 + arg_563_0 then
				local var_563_44 = "play"
				local var_563_45 = "effect"

				arg_560_1:AudioAction(var_563_44, var_563_45, "se_story_121_04", "se_story_121_04_headbreak", "")
			end

			if arg_560_1.frameCnt_ <= 1 then
				arg_560_1.dialog_:SetActive(false)
			end

			local var_563_46 = 2
			local var_563_47 = 1.325

			if var_563_46 < arg_560_1.time_ and arg_560_1.time_ <= var_563_46 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0

				arg_560_1.dialog_:SetActive(true)

				arg_560_1.dialogCg_.alpha = 0

				local var_563_48 = LeanTween.value(arg_560_1.dialog_, 0, 1, 0.3)

				var_563_48:setOnUpdate(LuaHelper.FloatAction(function(arg_564_0)
					arg_560_1.dialogCg_.alpha = arg_564_0
				end))
				var_563_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_560_1.dialog_)
					var_563_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_560_1.duration_ = arg_560_1.duration_ + 0.3

				SetActive(arg_560_1.leftNameGo_, false)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_49 = arg_560_1:GetWordFromCfg(121481135)
				local var_563_50 = arg_560_1:FormatText(var_563_49.content)

				arg_560_1.text_.text = var_563_50

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_51 = 53
				local var_563_52 = utf8.len(var_563_50)
				local var_563_53 = var_563_51 <= 0 and var_563_47 or var_563_47 * (var_563_52 / var_563_51)

				if var_563_53 > 0 and var_563_47 < var_563_53 then
					arg_560_1.talkMaxDuration = var_563_53
					var_563_46 = var_563_46 + 0.3

					if var_563_53 + var_563_46 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_53 + var_563_46
					end
				end

				arg_560_1.text_.text = var_563_50
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_54 = var_563_46 + 0.3
			local var_563_55 = math.max(var_563_47, arg_560_1.talkMaxDuration)

			if var_563_54 <= arg_560_1.time_ and arg_560_1.time_ < var_563_54 + var_563_55 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_54) / var_563_55

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_54 + var_563_55 and arg_560_1.time_ < var_563_54 + var_563_55 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_560_1:InitPlayNodeList()
	end,
	Play121481136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 121481136
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play121481137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 0.633333333333333

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				local var_569_2 = "play"
				local var_569_3 = "effect"

				arg_566_1:AudioAction(var_569_2, var_569_3, "se_story_121_04", "se_story_121_04_monsteranergy", "")
			end

			local var_569_4 = 0
			local var_569_5 = 1.425

			if var_569_4 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_6 = arg_566_1:GetWordFromCfg(121481136)
				local var_569_7 = arg_566_1:FormatText(var_569_6.content)

				arg_566_1.text_.text = var_569_7

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_8 = 57
				local var_569_9 = utf8.len(var_569_7)
				local var_569_10 = var_569_8 <= 0 and var_569_5 or var_569_5 * (var_569_9 / var_569_8)

				if var_569_10 > 0 and var_569_5 < var_569_10 then
					arg_566_1.talkMaxDuration = var_569_10

					if var_569_10 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_4
					end
				end

				arg_566_1.text_.text = var_569_7
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_11 = math.max(var_569_5, arg_566_1.talkMaxDuration)

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_11 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_4) / var_569_11

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_4 + var_569_11 and arg_566_1.time_ < var_569_4 + var_569_11 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play121481137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 121481137
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
			arg_570_1.auto_ = false
		end

		function arg_570_1.playNext_(arg_572_0)
			arg_570_1.onStoryFinished_()
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0
			local var_573_1 = 1.4

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_2 = arg_570_1:GetWordFromCfg(121481137)
				local var_573_3 = arg_570_1:FormatText(var_573_2.content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_4 = 56
				local var_573_5 = utf8.len(var_573_3)
				local var_573_6 = var_573_4 <= 0 and var_573_1 or var_573_1 * (var_573_5 / var_573_4)

				if var_573_6 > 0 and var_573_1 < var_573_6 then
					arg_570_1.talkMaxDuration = var_573_6

					if var_573_6 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_6 + var_573_0
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_7 = math.max(var_573_1, arg_570_1.talkMaxDuration)

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_7 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_0) / var_573_7

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_0 + var_573_7 and arg_570_1.time_ < var_573_0 + var_573_7 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/J02h"
	},
	voices = {
		"story_v_out_121481.awb"
	}
}
