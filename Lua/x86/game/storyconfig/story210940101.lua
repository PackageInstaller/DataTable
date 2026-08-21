return {
	Play1109401001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109401001
		arg_1_1.duration_ = 6.8

		local var_1_0 = {
			ja = 6.8,
			ko = 4.866,
			zh = 4.866
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
				arg_1_0:Play1109401002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D09a"

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
				local var_4_5 = arg_1_1.bgs_.D09a

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
					if iter_4_0 ~= "D09a" then
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

			local var_4_28 = 1.2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm")

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[182].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(1109401001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401001", "story_v_side_new_1109401.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401001", "story_v_side_new_1109401.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_side_new_1109401", "1109401001", "story_v_side_new_1109401.awb")

						arg_1_1:RecordAudio("1109401001", var_4_44)
						arg_1_1:RecordAudio("1109401001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401001", "story_v_side_new_1109401.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401001", "story_v_side_new_1109401.awb")
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
	Play1109401002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109401002
		arg_9_1.duration_ = 8.07

		local var_9_0 = {
			ja = 7.066,
			ko = 8.066,
			zh = 8.066
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
				arg_9_0:Play1109401003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.65

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[176].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1109401002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401002", "story_v_side_new_1109401.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401002", "story_v_side_new_1109401.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_new_1109401", "1109401002", "story_v_side_new_1109401.awb")

						arg_9_1:RecordAudio("1109401002", var_12_9)
						arg_9_1:RecordAudio("1109401002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401002", "story_v_side_new_1109401.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401002", "story_v_side_new_1109401.awb")
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
	Play1109401003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109401003
		arg_13_1.duration_ = 14.3

		local var_13_0 = {
			ja = 14.3,
			ko = 9.1,
			zh = 9.1
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
				arg_13_0:Play1109401004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.8

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[182].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1109401003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401003", "story_v_side_new_1109401.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401003", "story_v_side_new_1109401.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1109401", "1109401003", "story_v_side_new_1109401.awb")

						arg_13_1:RecordAudio("1109401003", var_16_9)
						arg_13_1:RecordAudio("1109401003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401003", "story_v_side_new_1109401.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401003", "story_v_side_new_1109401.awb")
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
	Play1109401004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109401004
		arg_17_1.duration_ = 1.33

		local var_17_0 = {
			ja = 1.333,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_17_0:Play1109401005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[176].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1109401004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401004", "story_v_side_new_1109401.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401004", "story_v_side_new_1109401.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1109401", "1109401004", "story_v_side_new_1109401.awb")

						arg_17_1:RecordAudio("1109401004", var_20_9)
						arg_17_1:RecordAudio("1109401004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401004", "story_v_side_new_1109401.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401004", "story_v_side_new_1109401.awb")
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
	Play1109401005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109401005
		arg_21_1.duration_ = 12.43

		local var_21_0 = {
			ja = 12.433,
			ko = 7.633,
			zh = 7.633
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
				arg_21_0:Play1109401006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.725

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[182].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(1109401005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401005", "story_v_side_new_1109401.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401005", "story_v_side_new_1109401.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_side_new_1109401", "1109401005", "story_v_side_new_1109401.awb")

						arg_21_1:RecordAudio("1109401005", var_24_9)
						arg_21_1:RecordAudio("1109401005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401005", "story_v_side_new_1109401.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401005", "story_v_side_new_1109401.awb")
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
	Play1109401006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109401006
		arg_25_1.duration_ = 8.57

		local var_25_0 = {
			ja = 8.566,
			ko = 6,
			zh = 6
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
				arg_25_0:Play1109401007(arg_25_1)
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

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[182].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1109401006)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401006", "story_v_side_new_1109401.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401006", "story_v_side_new_1109401.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_side_new_1109401", "1109401006", "story_v_side_new_1109401.awb")

						arg_25_1:RecordAudio("1109401006", var_28_9)
						arg_25_1:RecordAudio("1109401006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401006", "story_v_side_new_1109401.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401006", "story_v_side_new_1109401.awb")
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
	Play1109401007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109401007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			ja = 3.366,
			ko = 2.9,
			zh = 2.9
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
				arg_29_0:Play1109401008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.275

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[176].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1109401007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401007", "story_v_side_new_1109401.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401007", "story_v_side_new_1109401.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_side_new_1109401", "1109401007", "story_v_side_new_1109401.awb")

						arg_29_1:RecordAudio("1109401007", var_32_9)
						arg_29_1:RecordAudio("1109401007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401007", "story_v_side_new_1109401.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401007", "story_v_side_new_1109401.awb")
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
	Play1109401008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109401008
		arg_33_1.duration_ = 10.8

		local var_33_0 = {
			ja = 8.866,
			ko = 10.8,
			zh = 10.8
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
				arg_33_0:Play1109401009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.925

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[182].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(1109401008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401008", "story_v_side_new_1109401.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401008", "story_v_side_new_1109401.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_side_new_1109401", "1109401008", "story_v_side_new_1109401.awb")

						arg_33_1:RecordAudio("1109401008", var_36_9)
						arg_33_1:RecordAudio("1109401008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401008", "story_v_side_new_1109401.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401008", "story_v_side_new_1109401.awb")
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
	Play1109401009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109401009
		arg_37_1.duration_ = 6.83

		local var_37_0 = {
			ja = 6.833,
			ko = 4.866,
			zh = 4.866
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
				arg_37_0:Play1109401010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.525

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[182].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1109401009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401009", "story_v_side_new_1109401.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401009", "story_v_side_new_1109401.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_new_1109401", "1109401009", "story_v_side_new_1109401.awb")

						arg_37_1:RecordAudio("1109401009", var_40_9)
						arg_37_1:RecordAudio("1109401009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401009", "story_v_side_new_1109401.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401009", "story_v_side_new_1109401.awb")
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
	Play1109401010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109401010
		arg_41_1.duration_ = 11.63

		local var_41_0 = {
			ja = 11.633,
			ko = 6.866,
			zh = 6.866
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
				arg_41_0:Play1109401011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.7

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[182].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(1109401010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401010", "story_v_side_new_1109401.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401010", "story_v_side_new_1109401.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_new_1109401", "1109401010", "story_v_side_new_1109401.awb")

						arg_41_1:RecordAudio("1109401010", var_44_9)
						arg_41_1:RecordAudio("1109401010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401010", "story_v_side_new_1109401.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401010", "story_v_side_new_1109401.awb")
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
	Play1109401011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109401011
		arg_45_1.duration_ = 6.7

		local var_45_0 = {
			ja = 6.7,
			ko = 5.366,
			zh = 5.366
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
				arg_45_0:Play1109401012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_1 = 2

			if arg_45_1.time_ >= var_48_0 + var_48_1 and arg_45_1.time_ < var_48_0 + var_48_1 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_2 = 0
			local var_48_3 = 0.566666666666667

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_4 = "play"
				local var_48_5 = "effect"

				arg_45_1:AudioAction(var_48_4, var_48_5, "se_story_side_1094", "se_story_1094_paper", "")
			end

			local var_48_6 = 0
			local var_48_7 = 0.35

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[182].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(1109401011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 14
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401011", "story_v_side_new_1109401.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401011", "story_v_side_new_1109401.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_side_new_1109401", "1109401011", "story_v_side_new_1109401.awb")

						arg_45_1:RecordAudio("1109401011", var_48_15)
						arg_45_1:RecordAudio("1109401011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401011", "story_v_side_new_1109401.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401011", "story_v_side_new_1109401.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109401012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109401012
		arg_49_1.duration_ = 7.57

		local var_49_0 = {
			ja = 7.566,
			ko = 6.933,
			zh = 6.933
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
				arg_49_0:Play1109401013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.575

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[182].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1109401012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 23
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401012", "story_v_side_new_1109401.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401012", "story_v_side_new_1109401.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_new_1109401", "1109401012", "story_v_side_new_1109401.awb")

						arg_49_1:RecordAudio("1109401012", var_52_9)
						arg_49_1:RecordAudio("1109401012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401012", "story_v_side_new_1109401.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401012", "story_v_side_new_1109401.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109401013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109401013
		arg_53_1.duration_ = 3.1

		local var_53_0 = {
			ja = 1.466,
			ko = 3.1,
			zh = 3.1
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
				arg_53_0:Play1109401014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.1

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[176].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(1109401013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 4
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401013", "story_v_side_new_1109401.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401013", "story_v_side_new_1109401.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_side_new_1109401", "1109401013", "story_v_side_new_1109401.awb")

						arg_53_1:RecordAudio("1109401013", var_56_9)
						arg_53_1:RecordAudio("1109401013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401013", "story_v_side_new_1109401.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401013", "story_v_side_new_1109401.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109401014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109401014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1109401015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.825

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(1109401014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 32
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109401015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109401015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109401016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.675

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(1109401015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 27
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109401016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109401016
		arg_65_1.duration_ = 7.9

		local var_65_0 = {
			ja = 7.9,
			ko = 3.933,
			zh = 3.933
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
				arg_65_0:Play1109401017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.3

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[176].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(1109401016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 12
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401016", "story_v_side_new_1109401.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401016", "story_v_side_new_1109401.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_side_new_1109401", "1109401016", "story_v_side_new_1109401.awb")

						arg_65_1:RecordAudio("1109401016", var_68_9)
						arg_65_1:RecordAudio("1109401016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401016", "story_v_side_new_1109401.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401016", "story_v_side_new_1109401.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1109401017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109401017
		arg_69_1.duration_ = 3.47

		local var_69_0 = {
			ja = 3.466,
			ko = 2.7,
			zh = 2.7
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
				arg_69_0:Play1109401018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.2

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[182].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(1109401017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 8
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401017", "story_v_side_new_1109401.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401017", "story_v_side_new_1109401.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_side_new_1109401", "1109401017", "story_v_side_new_1109401.awb")

						arg_69_1:RecordAudio("1109401017", var_72_9)
						arg_69_1:RecordAudio("1109401017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401017", "story_v_side_new_1109401.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401017", "story_v_side_new_1109401.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1109401018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109401018
		arg_73_1.duration_ = 9.33

		local var_73_0 = {
			ja = 9.333,
			ko = 5.9,
			zh = 5.9
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
				arg_73_0:Play1109401019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "STblack"

			if arg_73_1.bgs_[var_76_0] == nil then
				local var_76_1 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_76_0)
				var_76_1.name = var_76_0
				var_76_1.transform.parent = arg_73_1.stage_.transform
				var_76_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_[var_76_0] = var_76_1
			end

			local var_76_2 = 0

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				local var_76_3 = manager.ui.mainCamera.transform.localPosition
				local var_76_4 = Vector3.New(0, 0, 10) + Vector3.New(var_76_3.x, var_76_3.y, 0)
				local var_76_5 = arg_73_1.bgs_.STblack

				var_76_5.transform.localPosition = var_76_4
				var_76_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_6 = var_76_5:GetComponent("SpriteRenderer")

				if var_76_6 and var_76_6.sprite then
					local var_76_7 = (var_76_5.transform.localPosition - var_76_3).z
					local var_76_8 = manager.ui.mainCameraCom_
					local var_76_9 = 2 * var_76_7 * Mathf.Tan(var_76_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_10 = var_76_9 * var_76_8.aspect
					local var_76_11 = var_76_6.sprite.bounds.size.x
					local var_76_12 = var_76_6.sprite.bounds.size.y
					local var_76_13 = var_76_10 / var_76_11
					local var_76_14 = var_76_9 / var_76_12
					local var_76_15 = var_76_14 < var_76_13 and var_76_13 or var_76_14

					var_76_5.transform.localScale = Vector3.New(var_76_15, var_76_15, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "STblack" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Color.New(0, 0, 0)

				var_76_19.a = Mathf.Lerp(1, 0, var_76_18)
				arg_73_1.mask_.color = var_76_19
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				local var_76_20 = Color.New(0, 0, 0)
				local var_76_21 = 0

				arg_73_1.mask_.enabled = false
				var_76_20.a = var_76_21
				arg_73_1.mask_.color = var_76_20
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_22 = 2
			local var_76_23 = 0.15

			if var_76_22 < arg_73_1.time_ and arg_73_1.time_ <= var_76_22 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_24 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_24:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[176].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_26 = arg_73_1:GetWordFromCfg(1109401018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 6
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_23 or var_76_23 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_23 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30
					var_76_22 = var_76_22 + 0.3

					if var_76_30 + var_76_22 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_22
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401018", "story_v_side_new_1109401.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401018", "story_v_side_new_1109401.awb") / 1000

					if var_76_31 + var_76_22 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_22
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_side_new_1109401", "1109401018", "story_v_side_new_1109401.awb")

						arg_73_1:RecordAudio("1109401018", var_76_32)
						arg_73_1:RecordAudio("1109401018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401018", "story_v_side_new_1109401.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401018", "story_v_side_new_1109401.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = var_76_22 + 0.3
			local var_76_34 = math.max(var_76_23, arg_73_1.talkMaxDuration)

			if var_76_33 <= arg_73_1.time_ and arg_73_1.time_ < var_76_33 + var_76_34 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_33) / var_76_34

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_33 + var_76_34 and arg_73_1.time_ < var_76_33 + var_76_34 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1109401019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109401019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109401020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.85

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_2 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_2:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(1109401019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 34
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7
					var_82_0 = var_82_0 + 0.3

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = var_82_0 + 0.3
			local var_82_9 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109401020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109401020
		arg_85_1.duration_ = 3.13

		local var_85_0 = {
			ja = 2.933,
			ko = 3.133,
			zh = 3.133
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
				arg_85_0:Play1109401021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.2

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "music"

				arg_85_1:AudioAction(var_88_2, var_88_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_88_4 = ""
				local var_88_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_88_5 ~= "" then
					if arg_85_1.bgmTxt_.text ~= var_88_5 and arg_85_1.bgmTxt_.text ~= "" then
						if arg_85_1.bgmTxt2_.text ~= "" then
							arg_85_1.bgmTxt_.text = arg_85_1.bgmTxt2_.text
						end

						arg_85_1.bgmTxt2_.text = var_88_5

						arg_85_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_85_1.bgmTxt_.text = var_88_5
						arg_85_1.bgmTxt2_.text = var_88_5
					end

					if arg_85_1.bgmTimer then
						arg_85_1.bgmTimer:Stop()

						arg_85_1.bgmTimer = nil
					end

					if arg_85_1.settingData.show_music_name == 1 then
						arg_85_1.musicController:SetSelectedState("show")
						arg_85_1.musicAnimator_:Play("open", 0, 0)

						if arg_85_1.settingData.music_time ~= 0 then
							arg_85_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_85_1.settingData.music_time), function()
								if arg_85_1 == nil or isNil(arg_85_1.bgmTxt_) then
									return
								end

								arg_85_1.musicController:SetSelectedState("hide")
								arg_85_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_88_6 = 0
			local var_88_7 = 0.075

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[182].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(1109401020)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401020", "story_v_side_new_1109401.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401020", "story_v_side_new_1109401.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_side_new_1109401", "1109401020", "story_v_side_new_1109401.awb")

						arg_85_1:RecordAudio("1109401020", var_88_15)
						arg_85_1:RecordAudio("1109401020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401020", "story_v_side_new_1109401.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401020", "story_v_side_new_1109401.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_16 and arg_85_1.time_ < var_88_6 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109401021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1109401021
		arg_90_1.duration_ = 7

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1109401022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = "ST12"

			if arg_90_1.bgs_[var_93_0] == nil then
				local var_93_1 = Object.Instantiate(arg_90_1.paintGo_)

				var_93_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_93_0)
				var_93_1.name = var_93_0
				var_93_1.transform.parent = arg_90_1.stage_.transform
				var_93_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.bgs_[var_93_0] = var_93_1
			end

			local var_93_2 = 0

			if var_93_2 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				if arg_90_0.sceneSettingEffect_ then
					arg_90_1.sceneSettingEffect_.enabled = false
				end

				arg_90_1.sceneSettingGo_:SetActive(true)

				local var_93_3 = manager.ui.mainCamera.transform.localPosition
				local var_93_4 = Vector3.New(0, 0, 10) + Vector3.New(var_93_3.x, var_93_3.y, 0)
				local var_93_5 = arg_90_1.bgs_.ST12

				var_93_5.transform.localPosition = var_93_4
				var_93_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_93_6 = var_93_5:GetComponent("SpriteRenderer")

				if var_93_6 and var_93_6.sprite then
					local var_93_7 = (var_93_5.transform.localPosition - var_93_3).z
					local var_93_8 = manager.ui.mainCameraCom_
					local var_93_9 = 2 * var_93_7 * Mathf.Tan(var_93_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_93_10 = var_93_9 * var_93_8.aspect
					local var_93_11 = var_93_6.sprite.bounds.size.x
					local var_93_12 = var_93_6.sprite.bounds.size.y
					local var_93_13 = var_93_10 / var_93_11
					local var_93_14 = var_93_9 / var_93_12
					local var_93_15 = var_93_14 < var_93_13 and var_93_13 or var_93_14

					var_93_5.transform.localScale = Vector3.New(var_93_15, var_93_15, 0)
				end

				for iter_93_0, iter_93_1 in pairs(arg_90_1.bgs_) do
					if iter_93_0 ~= "ST12" then
						iter_93_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_93_16 = 0

			if var_93_16 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_17 = 2

			if var_93_16 <= arg_90_1.time_ and arg_90_1.time_ < var_93_16 + var_93_17 then
				local var_93_18 = (arg_90_1.time_ - var_93_16) / var_93_17
				local var_93_19 = Color.New(0, 0, 0)

				var_93_19.a = Mathf.Lerp(1, 0, var_93_18)
				arg_90_1.mask_.color = var_93_19
			end

			if arg_90_1.time_ >= var_93_16 + var_93_17 and arg_90_1.time_ < var_93_16 + var_93_17 + arg_93_0 then
				local var_93_20 = Color.New(0, 0, 0)
				local var_93_21 = 0

				arg_90_1.mask_.enabled = false
				var_93_20.a = var_93_21
				arg_90_1.mask_.color = var_93_20
			end

			local var_93_22 = 0
			local var_93_23 = 0.2

			if var_93_22 < arg_90_1.time_ and arg_90_1.time_ <= var_93_22 + arg_93_0 then
				local var_93_24 = "play"
				local var_93_25 = "music"

				arg_90_1:AudioAction(var_93_24, var_93_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_93_26 = ""
				local var_93_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_93_27 ~= "" then
					if arg_90_1.bgmTxt_.text ~= var_93_27 and arg_90_1.bgmTxt_.text ~= "" then
						if arg_90_1.bgmTxt2_.text ~= "" then
							arg_90_1.bgmTxt_.text = arg_90_1.bgmTxt2_.text
						end

						arg_90_1.bgmTxt2_.text = var_93_27

						arg_90_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_90_1.bgmTxt_.text = var_93_27
						arg_90_1.bgmTxt2_.text = var_93_27
					end

					if arg_90_1.bgmTimer then
						arg_90_1.bgmTimer:Stop()

						arg_90_1.bgmTimer = nil
					end

					if arg_90_1.settingData.show_music_name == 1 then
						arg_90_1.musicController:SetSelectedState("show")
						arg_90_1.musicAnimator_:Play("open", 0, 0)

						if arg_90_1.settingData.music_time ~= 0 then
							arg_90_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_90_1.settingData.music_time), function()
								if arg_90_1 == nil or isNil(arg_90_1.bgmTxt_) then
									return
								end

								arg_90_1.musicController:SetSelectedState("hide")
								arg_90_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_93_28 = 1.1
			local var_93_29 = 1

			if var_93_28 < arg_90_1.time_ and arg_90_1.time_ <= var_93_28 + arg_93_0 then
				local var_93_30 = "play"
				local var_93_31 = "music"

				arg_90_1:AudioAction(var_93_30, var_93_31, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_93_32 = ""
				local var_93_33 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_93_33 ~= "" then
					if arg_90_1.bgmTxt_.text ~= var_93_33 and arg_90_1.bgmTxt_.text ~= "" then
						if arg_90_1.bgmTxt2_.text ~= "" then
							arg_90_1.bgmTxt_.text = arg_90_1.bgmTxt2_.text
						end

						arg_90_1.bgmTxt2_.text = var_93_33

						arg_90_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_90_1.bgmTxt_.text = var_93_33
						arg_90_1.bgmTxt2_.text = var_93_33
					end

					if arg_90_1.bgmTimer then
						arg_90_1.bgmTimer:Stop()

						arg_90_1.bgmTimer = nil
					end

					if arg_90_1.settingData.show_music_name == 1 then
						arg_90_1.musicController:SetSelectedState("show")
						arg_90_1.musicAnimator_:Play("open", 0, 0)

						if arg_90_1.settingData.music_time ~= 0 then
							arg_90_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_90_1.settingData.music_time), function()
								if arg_90_1 == nil or isNil(arg_90_1.bgmTxt_) then
									return
								end

								arg_90_1.musicController:SetSelectedState("hide")
								arg_90_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_90_1.frameCnt_ <= 1 then
				arg_90_1.dialog_:SetActive(false)
			end

			local var_93_34 = 2
			local var_93_35 = 0.1

			if var_93_34 < arg_90_1.time_ and arg_90_1.time_ <= var_93_34 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				arg_90_1.dialog_:SetActive(true)

				arg_90_1.dialogCg_.alpha = 0

				local var_93_36 = LeanTween.value(arg_90_1.dialog_, 0, 1, 0.3)

				var_93_36:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_90_1.dialogCg_.alpha = arg_96_0
				end))
				var_93_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_90_1.dialog_)
					var_93_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_90_1.duration_ = arg_90_1.duration_ + 0.3

				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_37 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_38 = arg_90_1:GetWordFromCfg(1109401021)
				local var_93_39 = arg_90_1:FormatText(var_93_38.content)

				arg_90_1.text_.text = var_93_39

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_40 = 4
				local var_93_41 = utf8.len(var_93_39)
				local var_93_42 = var_93_40 <= 0 and var_93_35 or var_93_35 * (var_93_41 / var_93_40)

				if var_93_42 > 0 and var_93_35 < var_93_42 then
					arg_90_1.talkMaxDuration = var_93_42
					var_93_34 = var_93_34 + 0.3

					if var_93_42 + var_93_34 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_42 + var_93_34
					end
				end

				arg_90_1.text_.text = var_93_39
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_43 = var_93_34 + 0.3
			local var_93_44 = math.max(var_93_35, arg_90_1.talkMaxDuration)

			if var_93_43 <= arg_90_1.time_ and arg_90_1.time_ < var_93_43 + var_93_44 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_43) / var_93_44

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_43 + var_93_44 and arg_90_1.time_ < var_93_43 + var_93_44 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1109401022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1109401022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1109401023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.95

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(1109401022)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 38
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1109401023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1109401023
		arg_102_1.duration_ = 6.83

		local var_102_0 = {
			ja = 6.833,
			ko = 5.333,
			zh = 5.333
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
				arg_102_0:Play1109401024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.625

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[10].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(1109401023)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 25
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401023", "story_v_side_new_1109401.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401023", "story_v_side_new_1109401.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_side_new_1109401", "1109401023", "story_v_side_new_1109401.awb")

						arg_102_1:RecordAudio("1109401023", var_105_9)
						arg_102_1:RecordAudio("1109401023", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401023", "story_v_side_new_1109401.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401023", "story_v_side_new_1109401.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1109401024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1109401024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1109401025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.625

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(1109401024)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 25
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1109401025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1109401025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1109401026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.925

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(1109401025)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 37
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1109401026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1109401026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1109401027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.6

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(1109401026)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 24
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1109401027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1109401027
		arg_118_1.duration_ = 11.07

		local var_118_0 = {
			ja = 9.2,
			ko = 11.066,
			zh = 11.066
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
				arg_118_0:Play1109401028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.05

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[10].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(1109401027)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 42
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401027", "story_v_side_new_1109401.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401027", "story_v_side_new_1109401.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_side_new_1109401", "1109401027", "story_v_side_new_1109401.awb")

						arg_118_1:RecordAudio("1109401027", var_121_9)
						arg_118_1:RecordAudio("1109401027", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401027", "story_v_side_new_1109401.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401027", "story_v_side_new_1109401.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1109401028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1109401028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1109401029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.625

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(1109401028)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 25
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1109401029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1109401029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1109401030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.833333333333333

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				local var_129_2 = "play"
				local var_129_3 = "effect"

				arg_126_1:AudioAction(var_129_2, var_129_3, "se_story_side_1094", "se_story_1094_slidingdoor_1", "")
			end

			local var_129_4 = 0
			local var_129_5 = 0.525

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(1109401029)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 21
				local var_129_9 = utf8.len(var_129_7)
				local var_129_10 = var_129_8 <= 0 and var_129_5 or var_129_5 * (var_129_9 / var_129_8)

				if var_129_10 > 0 and var_129_5 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_11 and arg_126_1.time_ < var_129_4 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1109401030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1109401030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1109401031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.625

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(1109401030)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 25
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1109401031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1109401031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1109401032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.425

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(1109401031)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 17
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1109401032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1109401032
		arg_138_1.duration_ = 2.67

		local var_138_0 = {
			ja = 2.666,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1109401033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = "1094ui_story"

			if arg_138_1.actors_[var_141_0] == nil then
				local var_141_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_141_1) then
					local var_141_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_138_1.stage_.transform)

					var_141_2.name = var_141_0
					var_141_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_138_1.actors_[var_141_0] = var_141_2

					local var_141_3 = var_141_2:GetComponentInChildren(typeof(CharacterEffect))

					var_141_3.enabled = true

					local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_2, typeof(DynamicBoneHelper))

					if var_141_4 then
						var_141_4:EnableDynamicBone(false)
					end

					arg_138_1:ShowWeapon(var_141_3.transform, false)

					arg_138_1.var_[var_141_0 .. "Animator"] = var_141_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_138_1.var_[var_141_0 .. "Animator"].applyRootMotion = true
					arg_138_1.var_[var_141_0 .. "LipSync"] = var_141_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_141_5 = arg_138_1.actors_["1094ui_story"].transform
			local var_141_6 = 0

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.var_.moveOldPos1094ui_story = var_141_5.localPosition
			end

			local var_141_7 = 0.001

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_7 then
				local var_141_8 = (arg_138_1.time_ - var_141_6) / var_141_7
				local var_141_9 = Vector3.New(0, -0.84, -6.1)

				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1094ui_story, var_141_9, var_141_8)

				local var_141_10 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_10.x, var_141_10.y, var_141_10.z)

				local var_141_11 = var_141_5.localEulerAngles

				var_141_11.z = 0
				var_141_11.x = 0
				var_141_5.localEulerAngles = var_141_11
			end

			if arg_138_1.time_ >= var_141_6 + var_141_7 and arg_138_1.time_ < var_141_6 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_141_12 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_12.x, var_141_12.y, var_141_12.z)

				local var_141_13 = var_141_5.localEulerAngles

				var_141_13.z = 0
				var_141_13.x = 0
				var_141_5.localEulerAngles = var_141_13
			end

			local var_141_14 = arg_138_1.actors_["1094ui_story"]
			local var_141_15 = 0

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect1094ui_story == nil then
				arg_138_1.var_.characterEffect1094ui_story = var_141_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_16 = 0.200000002980232

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_16 and not isNil(var_141_14) then
				local var_141_17 = (arg_138_1.time_ - var_141_15) / var_141_16

				if arg_138_1.var_.characterEffect1094ui_story and not isNil(var_141_14) then
					arg_138_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_15 + var_141_16 and arg_138_1.time_ < var_141_15 + var_141_16 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect1094ui_story then
				arg_138_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_141_18 = 0

			if var_141_18 < arg_138_1.time_ and arg_138_1.time_ <= var_141_18 + arg_141_0 then
				arg_138_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_141_19 = 0

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				arg_138_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_20 = 0
			local var_141_21 = 0.15

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_22 = arg_138_1:FormatText(StoryNameCfg[181].name)

				arg_138_1.leftNameTxt_.text = var_141_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_23 = arg_138_1:GetWordFromCfg(1109401032)
				local var_141_24 = arg_138_1:FormatText(var_141_23.content)

				arg_138_1.text_.text = var_141_24

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_25 = 6
				local var_141_26 = utf8.len(var_141_24)
				local var_141_27 = var_141_25 <= 0 and var_141_21 or var_141_21 * (var_141_26 / var_141_25)

				if var_141_27 > 0 and var_141_21 < var_141_27 then
					arg_138_1.talkMaxDuration = var_141_27

					if var_141_27 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_27 + var_141_20
					end
				end

				arg_138_1.text_.text = var_141_24
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401032", "story_v_side_new_1109401.awb") ~= 0 then
					local var_141_28 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401032", "story_v_side_new_1109401.awb") / 1000

					if var_141_28 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_20
					end

					if var_141_23.prefab_name ~= "" and arg_138_1.actors_[var_141_23.prefab_name] ~= nil then
						local var_141_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_23.prefab_name].transform, "story_v_side_new_1109401", "1109401032", "story_v_side_new_1109401.awb")

						arg_138_1:RecordAudio("1109401032", var_141_29)
						arg_138_1:RecordAudio("1109401032", var_141_29)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401032", "story_v_side_new_1109401.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401032", "story_v_side_new_1109401.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_30 = math.max(var_141_21, arg_138_1.talkMaxDuration)

			if var_141_20 <= arg_138_1.time_ and arg_138_1.time_ < var_141_20 + var_141_30 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_20) / var_141_30

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_20 + var_141_30 and arg_138_1.time_ < var_141_20 + var_141_30 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1109401033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1109401033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1109401034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1094ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1094ui_story == nil then
				arg_142_1.var_.characterEffect1094ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1094ui_story and not isNil(var_145_0) then
					local var_145_4 = Mathf.Lerp(0, 0.5, var_145_3)

					arg_142_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1094ui_story.fillRatio = var_145_4
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1094ui_story then
				local var_145_5 = 0.5

				arg_142_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1094ui_story.fillRatio = var_145_5
			end

			local var_145_6 = 0
			local var_145_7 = 0.675

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_8 = arg_142_1:GetWordFromCfg(1109401033)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 27
				local var_145_11 = utf8.len(var_145_9)
				local var_145_12 = var_145_10 <= 0 and var_145_7 or var_145_7 * (var_145_11 / var_145_10)

				if var_145_12 > 0 and var_145_7 < var_145_12 then
					arg_142_1.talkMaxDuration = var_145_12

					if var_145_12 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_13 and arg_142_1.time_ < var_145_6 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1109401034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1109401034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1109401035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.375

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(1109401034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 15
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_8 and arg_146_1.time_ < var_149_0 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1109401035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1109401035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1109401036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1094ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1094ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1094ui_story, var_153_4, var_153_3)

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

			local var_153_9 = arg_150_1.actors_["1094ui_story"]
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect1094ui_story == nil then
				arg_150_1.var_.characterEffect1094ui_story = var_153_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_11 = 0.200000002980232

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 and not isNil(var_153_9) then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11

				if arg_150_1.var_.characterEffect1094ui_story and not isNil(var_153_9) then
					local var_153_13 = Mathf.Lerp(0, 0.5, var_153_12)

					arg_150_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1094ui_story.fillRatio = var_153_13
				end
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect1094ui_story then
				local var_153_14 = 0.5

				arg_150_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1094ui_story.fillRatio = var_153_14
			end

			local var_153_15 = 0
			local var_153_16 = 0.425

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_17 = arg_150_1:GetWordFromCfg(1109401035)
				local var_153_18 = arg_150_1:FormatText(var_153_17.content)

				arg_150_1.text_.text = var_153_18

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_19 = 17
				local var_153_20 = utf8.len(var_153_18)
				local var_153_21 = var_153_19 <= 0 and var_153_16 or var_153_16 * (var_153_20 / var_153_19)

				if var_153_21 > 0 and var_153_16 < var_153_21 then
					arg_150_1.talkMaxDuration = var_153_21

					if var_153_21 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_21 + var_153_15
					end
				end

				arg_150_1.text_.text = var_153_18
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_16, arg_150_1.talkMaxDuration)

			if var_153_15 <= arg_150_1.time_ and arg_150_1.time_ < var_153_15 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_15) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_15 + var_153_22 and arg_150_1.time_ < var_153_15 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1109401036
		arg_154_1.duration_ = 2

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1109401037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1094ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1094ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, -0.84, -6.1)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1094ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1094ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1094ui_story == nil then
				arg_154_1.var_.characterEffect1094ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect1094ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1094ui_story then
				arg_154_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_15 = 0
			local var_157_16 = 0.125

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[181].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(1109401036)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_20 = 5
				local var_157_21 = utf8.len(var_157_19)
				local var_157_22 = var_157_20 <= 0 and var_157_16 or var_157_16 * (var_157_21 / var_157_20)

				if var_157_22 > 0 and var_157_16 < var_157_22 then
					arg_154_1.talkMaxDuration = var_157_22

					if var_157_22 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401036", "story_v_side_new_1109401.awb") ~= 0 then
					local var_157_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401036", "story_v_side_new_1109401.awb") / 1000

					if var_157_23 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_15
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_side_new_1109401", "1109401036", "story_v_side_new_1109401.awb")

						arg_154_1:RecordAudio("1109401036", var_157_24)
						arg_154_1:RecordAudio("1109401036", var_157_24)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401036", "story_v_side_new_1109401.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401036", "story_v_side_new_1109401.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_25 and arg_154_1.time_ < var_157_15 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1109401037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1109401037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1109401038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1094ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1094ui_story == nil then
				arg_158_1.var_.characterEffect1094ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1094ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1094ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1094ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1094ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.325

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(1109401037)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 13
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1109401038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1109401038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1109401039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1094ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1094ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(0, 100, 0)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1094ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, 100, 0)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = arg_162_1.actors_["1094ui_story"]
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1094ui_story == nil then
				arg_162_1.var_.characterEffect1094ui_story = var_165_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_11 = 0.200000002980232

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 and not isNil(var_165_9) then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11

				if arg_162_1.var_.characterEffect1094ui_story and not isNil(var_165_9) then
					local var_165_13 = Mathf.Lerp(0, 0.5, var_165_12)

					arg_162_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1094ui_story.fillRatio = var_165_13
				end
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1094ui_story then
				local var_165_14 = 0.5

				arg_162_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1094ui_story.fillRatio = var_165_14
			end

			local var_165_15 = 0
			local var_165_16 = 0.525

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_17 = arg_162_1:GetWordFromCfg(1109401038)
				local var_165_18 = arg_162_1:FormatText(var_165_17.content)

				arg_162_1.text_.text = var_165_18

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_19 = 21
				local var_165_20 = utf8.len(var_165_18)
				local var_165_21 = var_165_19 <= 0 and var_165_16 or var_165_16 * (var_165_20 / var_165_19)

				if var_165_21 > 0 and var_165_16 < var_165_21 then
					arg_162_1.talkMaxDuration = var_165_21

					if var_165_21 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_21 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_18
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_22 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_22 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_22

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_22 and arg_162_1.time_ < var_165_15 + var_165_22 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play1109401039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1109401039
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1109401040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.475

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(1109401039)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 19
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
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_8 and arg_166_1.time_ < var_169_0 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1109401040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1109401040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1109401041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.625

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(1109401040)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 25
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1109401041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1109401041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1109401042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1094ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1094ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, -0.84, -6.1)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1094ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["1094ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1094ui_story == nil then
				arg_174_1.var_.characterEffect1094ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.0166666666666667

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect1094ui_story and not isNil(var_177_9) then
					local var_177_13 = Mathf.Lerp(0, 0.5, var_177_12)

					arg_174_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1094ui_story.fillRatio = var_177_13
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1094ui_story then
				local var_177_14 = 0.5

				arg_174_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1094ui_story.fillRatio = var_177_14
			end

			local var_177_15 = 0

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_177_16 = 0
			local var_177_17 = 0.75

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_18 = arg_174_1:GetWordFromCfg(1109401041)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_20 = 30
				local var_177_21 = utf8.len(var_177_19)
				local var_177_22 = var_177_20 <= 0 and var_177_17 or var_177_17 * (var_177_21 / var_177_20)

				if var_177_22 > 0 and var_177_17 < var_177_22 then
					arg_174_1.talkMaxDuration = var_177_22

					if var_177_22 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_16
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_23 = math.max(var_177_17, arg_174_1.talkMaxDuration)

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_23 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_16) / var_177_23

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_16 + var_177_23 and arg_174_1.time_ < var_177_16 + var_177_23 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play1109401042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1109401042
		arg_178_1.duration_ = 2.4

		local var_178_0 = {
			ja = 2.2,
			ko = 2.4,
			zh = 2.4
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
				arg_178_0:Play1109401043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1094ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1094ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -0.84, -6.1)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1094ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1094ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1094ui_story == nil then
				arg_178_1.var_.characterEffect1094ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1094ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1094ui_story then
				arg_178_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_14 = 0
			local var_181_15 = 0.175

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_16 = arg_178_1:FormatText(StoryNameCfg[181].name)

				arg_178_1.leftNameTxt_.text = var_181_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_17 = arg_178_1:GetWordFromCfg(1109401042)
				local var_181_18 = arg_178_1:FormatText(var_181_17.content)

				arg_178_1.text_.text = var_181_18

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_19 = 7
				local var_181_20 = utf8.len(var_181_18)
				local var_181_21 = var_181_19 <= 0 and var_181_15 or var_181_15 * (var_181_20 / var_181_19)

				if var_181_21 > 0 and var_181_15 < var_181_21 then
					arg_178_1.talkMaxDuration = var_181_21

					if var_181_21 + var_181_14 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_21 + var_181_14
					end
				end

				arg_178_1.text_.text = var_181_18
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401042", "story_v_side_new_1109401.awb") ~= 0 then
					local var_181_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401042", "story_v_side_new_1109401.awb") / 1000

					if var_181_22 + var_181_14 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_14
					end

					if var_181_17.prefab_name ~= "" and arg_178_1.actors_[var_181_17.prefab_name] ~= nil then
						local var_181_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_17.prefab_name].transform, "story_v_side_new_1109401", "1109401042", "story_v_side_new_1109401.awb")

						arg_178_1:RecordAudio("1109401042", var_181_23)
						arg_178_1:RecordAudio("1109401042", var_181_23)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401042", "story_v_side_new_1109401.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401042", "story_v_side_new_1109401.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_24 = math.max(var_181_15, arg_178_1.talkMaxDuration)

			if var_181_14 <= arg_178_1.time_ and arg_178_1.time_ < var_181_14 + var_181_24 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_14) / var_181_24

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_14 + var_181_24 and arg_178_1.time_ < var_181_14 + var_181_24 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play1109401043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1109401043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1109401044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1094ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos1094ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, 100, 0)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1094ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, 100, 0)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["1094ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1094ui_story == nil then
				arg_182_1.var_.characterEffect1094ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect1094ui_story and not isNil(var_185_9) then
					local var_185_13 = Mathf.Lerp(0, 0.5, var_185_12)

					arg_182_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1094ui_story.fillRatio = var_185_13
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1094ui_story then
				local var_185_14 = 0.5

				arg_182_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1094ui_story.fillRatio = var_185_14
			end

			local var_185_15 = 0
			local var_185_16 = 1

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				local var_185_17 = "play"
				local var_185_18 = "effect"

				arg_182_1:AudioAction(var_185_17, var_185_18, "se_story_side_1094", "se_story_1094_information", "")
			end

			local var_185_19 = 0
			local var_185_20 = 0.6

			if var_185_19 < arg_182_1.time_ and arg_182_1.time_ <= var_185_19 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_21 = arg_182_1:GetWordFromCfg(1109401043)
				local var_185_22 = arg_182_1:FormatText(var_185_21.content)

				arg_182_1.text_.text = var_185_22

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_23 = 24
				local var_185_24 = utf8.len(var_185_22)
				local var_185_25 = var_185_23 <= 0 and var_185_20 or var_185_20 * (var_185_24 / var_185_23)

				if var_185_25 > 0 and var_185_20 < var_185_25 then
					arg_182_1.talkMaxDuration = var_185_25

					if var_185_25 + var_185_19 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_25 + var_185_19
					end
				end

				arg_182_1.text_.text = var_185_22
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_26 = math.max(var_185_20, arg_182_1.talkMaxDuration)

			if var_185_19 <= arg_182_1.time_ and arg_182_1.time_ < var_185_19 + var_185_26 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_19) / var_185_26

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_19 + var_185_26 and arg_182_1.time_ < var_185_19 + var_185_26 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play1109401044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1109401044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1109401045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.975

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(1109401044)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 39
				local var_189_5 = utf8.len(var_189_3)
				local var_189_6 = var_189_4 <= 0 and var_189_1 or var_189_1 * (var_189_5 / var_189_4)

				if var_189_6 > 0 and var_189_1 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_7 and arg_186_1.time_ < var_189_0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1109401045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1109401045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1109401046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1094ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1094ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0, -0.84, -6.1)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1094ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["1094ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1094ui_story == nil then
				arg_190_1.var_.characterEffect1094ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.0166666666666667

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect1094ui_story and not isNil(var_193_9) then
					local var_193_13 = Mathf.Lerp(0, 0.5, var_193_12)

					arg_190_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1094ui_story.fillRatio = var_193_13
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1094ui_story then
				local var_193_14 = 0.5

				arg_190_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1094ui_story.fillRatio = var_193_14
			end

			local var_193_15 = 0
			local var_193_16 = 0.075

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_18 = arg_190_1:GetWordFromCfg(1109401045)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 3
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_23 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_23 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_23

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_23 and arg_190_1.time_ < var_193_15 + var_193_23 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play1109401046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1109401046
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1109401047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1094ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1094ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, -0.84, -6.1)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1094ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1094ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1094ui_story == nil then
				arg_194_1.var_.characterEffect1094ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect1094ui_story and not isNil(var_197_9) then
					arg_194_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1094ui_story then
				arg_194_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_197_13 = 0

			if var_197_13 < arg_194_1.time_ and arg_194_1.time_ <= var_197_13 + arg_197_0 then
				arg_194_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_197_14 = 0
			local var_197_15 = 0.675

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_16 = arg_194_1:GetWordFromCfg(1109401046)
				local var_197_17 = arg_194_1:FormatText(var_197_16.content)

				arg_194_1.text_.text = var_197_17

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_18 = 27
				local var_197_19 = utf8.len(var_197_17)
				local var_197_20 = var_197_18 <= 0 and var_197_15 or var_197_15 * (var_197_19 / var_197_18)

				if var_197_20 > 0 and var_197_15 < var_197_20 then
					arg_194_1.talkMaxDuration = var_197_20

					if var_197_20 + var_197_14 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_20 + var_197_14
					end
				end

				arg_194_1.text_.text = var_197_17
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_21 = math.max(var_197_15, arg_194_1.talkMaxDuration)

			if var_197_14 <= arg_194_1.time_ and arg_194_1.time_ < var_197_14 + var_197_21 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_14) / var_197_21

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_14 + var_197_21 and arg_194_1.time_ < var_197_14 + var_197_21 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play1109401047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1109401047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1109401048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1094ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1094ui_story == nil then
				arg_198_1.var_.characterEffect1094ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1094ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1094ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1094ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1094ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.325

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(1109401047)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 13
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_14 and arg_198_1.time_ < var_201_6 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1109401048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1109401048
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1109401049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1094ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1094ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, -0.84, -6.1)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1094ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1094ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1094ui_story == nil then
				arg_202_1.var_.characterEffect1094ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1094ui_story and not isNil(var_205_9) then
					arg_202_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1094ui_story then
				arg_202_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_205_13 = 0

			if var_205_13 < arg_202_1.time_ and arg_202_1.time_ <= var_205_13 + arg_205_0 then
				arg_202_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_205_14 = 0
			local var_205_15 = 0.1

			if var_205_14 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_16 = arg_202_1:FormatText(StoryNameCfg[181].name)

				arg_202_1.leftNameTxt_.text = var_205_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_17 = arg_202_1:GetWordFromCfg(1109401048)
				local var_205_18 = arg_202_1:FormatText(var_205_17.content)

				arg_202_1.text_.text = var_205_18

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 4
				local var_205_20 = utf8.len(var_205_18)
				local var_205_21 = var_205_19 <= 0 and var_205_15 or var_205_15 * (var_205_20 / var_205_19)

				if var_205_21 > 0 and var_205_15 < var_205_21 then
					arg_202_1.talkMaxDuration = var_205_21

					if var_205_21 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_21 + var_205_14
					end
				end

				arg_202_1.text_.text = var_205_18
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401048", "story_v_side_new_1109401.awb") ~= 0 then
					local var_205_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401048", "story_v_side_new_1109401.awb") / 1000

					if var_205_22 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_14
					end

					if var_205_17.prefab_name ~= "" and arg_202_1.actors_[var_205_17.prefab_name] ~= nil then
						local var_205_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_17.prefab_name].transform, "story_v_side_new_1109401", "1109401048", "story_v_side_new_1109401.awb")

						arg_202_1:RecordAudio("1109401048", var_205_23)
						arg_202_1:RecordAudio("1109401048", var_205_23)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401048", "story_v_side_new_1109401.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401048", "story_v_side_new_1109401.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_24 = math.max(var_205_15, arg_202_1.talkMaxDuration)

			if var_205_14 <= arg_202_1.time_ and arg_202_1.time_ < var_205_14 + var_205_24 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_14) / var_205_24

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_14 + var_205_24 and arg_202_1.time_ < var_205_14 + var_205_24 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play1109401049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1109401049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1109401050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1094ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1094ui_story == nil then
				arg_206_1.var_.characterEffect1094ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1094ui_story and not isNil(var_209_0) then
					local var_209_4 = Mathf.Lerp(0, 0.5, var_209_3)

					arg_206_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1094ui_story.fillRatio = var_209_4
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1094ui_story then
				local var_209_5 = 0.5

				arg_206_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1094ui_story.fillRatio = var_209_5
			end

			local var_209_6 = 0
			local var_209_7 = 0.175

			if var_209_6 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_8 = arg_206_1:FormatText(StoryNameCfg[7].name)

				arg_206_1.leftNameTxt_.text = var_209_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_9 = arg_206_1:GetWordFromCfg(1109401049)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 7
				local var_209_12 = utf8.len(var_209_10)
				local var_209_13 = var_209_11 <= 0 and var_209_7 or var_209_7 * (var_209_12 / var_209_11)

				if var_209_13 > 0 and var_209_7 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_10
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1109401050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1109401050
		arg_210_1.duration_ = 2

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1109401051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1094ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1094ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, -0.84, -6.1)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1094ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = arg_210_1.actors_["1094ui_story"]
			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1094ui_story == nil then
				arg_210_1.var_.characterEffect1094ui_story = var_213_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_11 = 0.200000002980232

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_11 and not isNil(var_213_9) then
				local var_213_12 = (arg_210_1.time_ - var_213_10) / var_213_11

				if arg_210_1.var_.characterEffect1094ui_story and not isNil(var_213_9) then
					arg_210_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_10 + var_213_11 and arg_210_1.time_ < var_213_10 + var_213_11 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1094ui_story then
				arg_210_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_213_13 = 0

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_213_14 = 0

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_213_15 = 0
			local var_213_16 = 0.1

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[181].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(1109401050)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 4
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401050", "story_v_side_new_1109401.awb") ~= 0 then
					local var_213_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401050", "story_v_side_new_1109401.awb") / 1000

					if var_213_23 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_15
					end

					if var_213_18.prefab_name ~= "" and arg_210_1.actors_[var_213_18.prefab_name] ~= nil then
						local var_213_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_18.prefab_name].transform, "story_v_side_new_1109401", "1109401050", "story_v_side_new_1109401.awb")

						arg_210_1:RecordAudio("1109401050", var_213_24)
						arg_210_1:RecordAudio("1109401050", var_213_24)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401050", "story_v_side_new_1109401.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401050", "story_v_side_new_1109401.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_25 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_25 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_25

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_25 and arg_210_1.time_ < var_213_15 + var_213_25 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1109401051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1109401051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1109401052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1094ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1094ui_story == nil then
				arg_214_1.var_.characterEffect1094ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1094ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1094ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1094ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1094ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.175

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(1109401051)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 7
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1109401052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1109401052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1109401053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1094ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1094ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1094ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["1094ui_story"]
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1094ui_story == nil then
				arg_218_1.var_.characterEffect1094ui_story = var_221_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 and not isNil(var_221_9) then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11

				if arg_218_1.var_.characterEffect1094ui_story and not isNil(var_221_9) then
					local var_221_13 = Mathf.Lerp(0, 0.5, var_221_12)

					arg_218_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1094ui_story.fillRatio = var_221_13
				end
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1094ui_story then
				local var_221_14 = 0.5

				arg_218_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1094ui_story.fillRatio = var_221_14
			end

			local var_221_15 = 0
			local var_221_16 = 0.825

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_17 = arg_218_1:GetWordFromCfg(1109401052)
				local var_221_18 = arg_218_1:FormatText(var_221_17.content)

				arg_218_1.text_.text = var_221_18

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_19 = 33
				local var_221_20 = utf8.len(var_221_18)
				local var_221_21 = var_221_19 <= 0 and var_221_16 or var_221_16 * (var_221_20 / var_221_19)

				if var_221_21 > 0 and var_221_16 < var_221_21 then
					arg_218_1.talkMaxDuration = var_221_21

					if var_221_21 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_21 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_18
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_22 and arg_218_1.time_ < var_221_15 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1109401053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1109401053
		arg_222_1.duration_ = 8.1

		local var_222_0 = {
			ja = 8.1,
			ko = 5.4,
			zh = 5.4
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1109401054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.65

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[177].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(1109401053)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 26
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401053", "story_v_side_new_1109401.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401053", "story_v_side_new_1109401.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_side_new_1109401", "1109401053", "story_v_side_new_1109401.awb")

						arg_222_1:RecordAudio("1109401053", var_225_9)
						arg_222_1:RecordAudio("1109401053", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401053", "story_v_side_new_1109401.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401053", "story_v_side_new_1109401.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1109401054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1109401054
		arg_226_1.duration_ = 8.23

		local var_226_0 = {
			ja = 8.233,
			ko = 7.566,
			zh = 7.566
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1109401055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.85

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[10].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(1109401054)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 34
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401054", "story_v_side_new_1109401.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401054", "story_v_side_new_1109401.awb") / 1000

					if var_229_8 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_0
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_side_new_1109401", "1109401054", "story_v_side_new_1109401.awb")

						arg_226_1:RecordAudio("1109401054", var_229_9)
						arg_226_1:RecordAudio("1109401054", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401054", "story_v_side_new_1109401.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401054", "story_v_side_new_1109401.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_10 and arg_226_1.time_ < var_229_0 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1109401055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1109401055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1109401056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.2

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:GetWordFromCfg(1109401055)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 8
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1109401056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1109401056
		arg_234_1.duration_ = 11.3

		local var_234_0 = {
			ja = 11.3,
			ko = 7.166,
			zh = 7.166
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1109401057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.7

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[177].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:GetWordFromCfg(1109401056)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 28
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401056", "story_v_side_new_1109401.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401056", "story_v_side_new_1109401.awb") / 1000

					if var_237_8 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_0
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_side_new_1109401", "1109401056", "story_v_side_new_1109401.awb")

						arg_234_1:RecordAudio("1109401056", var_237_9)
						arg_234_1:RecordAudio("1109401056", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401056", "story_v_side_new_1109401.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401056", "story_v_side_new_1109401.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_10 and arg_234_1.time_ < var_237_0 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1109401057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1109401057
		arg_238_1.duration_ = 7.67

		local var_238_0 = {
			ja = 7.666,
			ko = 5.366,
			zh = 5.366
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1109401058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.5

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[10].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(1109401057)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 20
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401057", "story_v_side_new_1109401.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401057", "story_v_side_new_1109401.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_side_new_1109401", "1109401057", "story_v_side_new_1109401.awb")

						arg_238_1:RecordAudio("1109401057", var_241_9)
						arg_238_1:RecordAudio("1109401057", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401057", "story_v_side_new_1109401.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401057", "story_v_side_new_1109401.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1109401058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1109401058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1109401059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.875

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_2 = arg_242_1:GetWordFromCfg(1109401058)
				local var_245_3 = arg_242_1:FormatText(var_245_2.content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 35
				local var_245_5 = utf8.len(var_245_3)
				local var_245_6 = var_245_4 <= 0 and var_245_1 or var_245_1 * (var_245_5 / var_245_4)

				if var_245_6 > 0 and var_245_1 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_7 and arg_242_1.time_ < var_245_0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1109401059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1109401059
		arg_246_1.duration_ = 8.6

		local var_246_0 = {
			ja = 8.6,
			ko = 7.166,
			zh = 7.166
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1109401060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.6

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[10].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(1109401059)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 24
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401059", "story_v_side_new_1109401.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401059", "story_v_side_new_1109401.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_side_new_1109401", "1109401059", "story_v_side_new_1109401.awb")

						arg_246_1:RecordAudio("1109401059", var_249_9)
						arg_246_1:RecordAudio("1109401059", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401059", "story_v_side_new_1109401.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401059", "story_v_side_new_1109401.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1109401060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1109401060
		arg_250_1.duration_ = 8.73

		local var_250_0 = {
			ja = 8.733,
			ko = 6.033,
			zh = 6.033
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1109401061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.725

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[10].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(1109401060)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 29
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401060", "story_v_side_new_1109401.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401060", "story_v_side_new_1109401.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_side_new_1109401", "1109401060", "story_v_side_new_1109401.awb")

						arg_250_1:RecordAudio("1109401060", var_253_9)
						arg_250_1:RecordAudio("1109401060", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401060", "story_v_side_new_1109401.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401060", "story_v_side_new_1109401.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1109401061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1109401061
		arg_254_1.duration_ = 8.73

		local var_254_0 = {
			ja = 8.733,
			ko = 4.033,
			zh = 4.033
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1109401062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.5

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[177].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:GetWordFromCfg(1109401061)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 20
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401061", "story_v_side_new_1109401.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401061", "story_v_side_new_1109401.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_side_new_1109401", "1109401061", "story_v_side_new_1109401.awb")

						arg_254_1:RecordAudio("1109401061", var_257_9)
						arg_254_1:RecordAudio("1109401061", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401061", "story_v_side_new_1109401.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401061", "story_v_side_new_1109401.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1109401062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1109401062
		arg_258_1.duration_ = 10.03

		local var_258_0 = {
			ja = 10.033,
			ko = 5.666,
			zh = 5.666
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1109401063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.625

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[177].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(1109401062)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 25
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401062", "story_v_side_new_1109401.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401062", "story_v_side_new_1109401.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_side_new_1109401", "1109401062", "story_v_side_new_1109401.awb")

						arg_258_1:RecordAudio("1109401062", var_261_9)
						arg_258_1:RecordAudio("1109401062", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401062", "story_v_side_new_1109401.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401062", "story_v_side_new_1109401.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1109401063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1109401063
		arg_262_1.duration_ = 5.8

		local var_262_0 = {
			ja = 5.8,
			ko = 3.066,
			zh = 3.066
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1109401064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.325

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[10].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(1109401063)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 13
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401063", "story_v_side_new_1109401.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401063", "story_v_side_new_1109401.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_side_new_1109401", "1109401063", "story_v_side_new_1109401.awb")

						arg_262_1:RecordAudio("1109401063", var_265_9)
						arg_262_1:RecordAudio("1109401063", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401063", "story_v_side_new_1109401.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401063", "story_v_side_new_1109401.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1109401064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1109401064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1109401065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.55

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_2 = arg_266_1:GetWordFromCfg(1109401064)
				local var_269_3 = arg_266_1:FormatText(var_269_2.content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 22
				local var_269_5 = utf8.len(var_269_3)
				local var_269_6 = var_269_4 <= 0 and var_269_1 or var_269_1 * (var_269_5 / var_269_4)

				if var_269_6 > 0 and var_269_1 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_7 and arg_266_1.time_ < var_269_0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1109401065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1109401065
		arg_270_1.duration_ = 2.63

		local var_270_0 = {
			ja = 2.633,
			ko = 2.433,
			zh = 2.433
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1109401066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1094ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1094ui_story = var_273_0.localPosition
			end

			local var_273_2 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2
				local var_273_4 = Vector3.New(0, -0.84, -6.1)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1094ui_story, var_273_4, var_273_3)

				local var_273_5 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_5.x, var_273_5.y, var_273_5.z)

				local var_273_6 = var_273_0.localEulerAngles

				var_273_6.z = 0
				var_273_6.x = 0
				var_273_0.localEulerAngles = var_273_6
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_0.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_0.localEulerAngles = var_273_8
			end

			local var_273_9 = arg_270_1.actors_["1094ui_story"]
			local var_273_10 = 0

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect1094ui_story == nil then
				arg_270_1.var_.characterEffect1094ui_story = var_273_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_11 = 0.200000002980232

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_11 and not isNil(var_273_9) then
				local var_273_12 = (arg_270_1.time_ - var_273_10) / var_273_11

				if arg_270_1.var_.characterEffect1094ui_story and not isNil(var_273_9) then
					arg_270_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_10 + var_273_11 and arg_270_1.time_ < var_273_10 + var_273_11 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect1094ui_story then
				arg_270_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_273_13 = 0

			if var_273_13 < arg_270_1.time_ and arg_270_1.time_ <= var_273_13 + arg_273_0 then
				arg_270_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_15 = 0
			local var_273_16 = 0.2

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[181].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(1109401065)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 8
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401065", "story_v_side_new_1109401.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401065", "story_v_side_new_1109401.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_side_new_1109401", "1109401065", "story_v_side_new_1109401.awb")

						arg_270_1:RecordAudio("1109401065", var_273_24)
						arg_270_1:RecordAudio("1109401065", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401065", "story_v_side_new_1109401.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401065", "story_v_side_new_1109401.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1109401066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1109401066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1109401067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1094ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1094ui_story == nil then
				arg_274_1.var_.characterEffect1094ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1094ui_story and not isNil(var_277_0) then
					local var_277_4 = Mathf.Lerp(0, 0.5, var_277_3)

					arg_274_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1094ui_story.fillRatio = var_277_4
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1094ui_story then
				local var_277_5 = 0.5

				arg_274_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1094ui_story.fillRatio = var_277_5
			end

			local var_277_6 = 0
			local var_277_7 = 1.3

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_8 = arg_274_1:GetWordFromCfg(1109401066)
				local var_277_9 = arg_274_1:FormatText(var_277_8.content)

				arg_274_1.text_.text = var_277_9

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_10 = 52
				local var_277_11 = utf8.len(var_277_9)
				local var_277_12 = var_277_10 <= 0 and var_277_7 or var_277_7 * (var_277_11 / var_277_10)

				if var_277_12 > 0 and var_277_7 < var_277_12 then
					arg_274_1.talkMaxDuration = var_277_12

					if var_277_12 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_9
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_13 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_13 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_13

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_13 and arg_274_1.time_ < var_277_6 + var_277_13 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1109401067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1109401067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1109401068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.55

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(1109401067)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 22
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1109401068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1109401068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1109401069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1094ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1094ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, 100, 0)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1094ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, 100, 0)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1094ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1094ui_story == nil then
				arg_282_1.var_.characterEffect1094ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1094ui_story and not isNil(var_285_9) then
					local var_285_13 = Mathf.Lerp(0, 0.5, var_285_12)

					arg_282_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1094ui_story.fillRatio = var_285_13
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1094ui_story then
				local var_285_14 = 0.5

				arg_282_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1094ui_story.fillRatio = var_285_14
			end

			local var_285_15 = 0
			local var_285_16 = 0.15

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_17 = arg_282_1:GetWordFromCfg(1109401068)
				local var_285_18 = arg_282_1:FormatText(var_285_17.content)

				arg_282_1.text_.text = var_285_18

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_19 = 6
				local var_285_20 = utf8.len(var_285_18)
				local var_285_21 = var_285_19 <= 0 and var_285_16 or var_285_16 * (var_285_20 / var_285_19)

				if var_285_21 > 0 and var_285_16 < var_285_21 then
					arg_282_1.talkMaxDuration = var_285_21

					if var_285_21 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_21 + var_285_15
					end
				end

				arg_282_1.text_.text = var_285_18
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_16, arg_282_1.talkMaxDuration)

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_15) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_15 + var_285_22 and arg_282_1.time_ < var_285_15 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1109401069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1109401069
		arg_286_1.duration_ = 6.03

		local var_286_0 = {
			ja = 6.033,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1109401070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = "1019ui_story"

			if arg_286_1.actors_[var_289_0] == nil then
				local var_289_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_289_1) then
					local var_289_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_286_1.stage_.transform)

					var_289_2.name = var_289_0
					var_289_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_286_1.actors_[var_289_0] = var_289_2

					local var_289_3 = var_289_2:GetComponentInChildren(typeof(CharacterEffect))

					var_289_3.enabled = true

					local var_289_4 = GameObjectTools.GetOrAddComponent(var_289_2, typeof(DynamicBoneHelper))

					if var_289_4 then
						var_289_4:EnableDynamicBone(false)
					end

					arg_286_1:ShowWeapon(var_289_3.transform, false)

					arg_286_1.var_[var_289_0 .. "Animator"] = var_289_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_286_1.var_[var_289_0 .. "Animator"].applyRootMotion = true
					arg_286_1.var_[var_289_0 .. "LipSync"] = var_289_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_289_5 = arg_286_1.actors_["1019ui_story"].transform
			local var_289_6 = 0

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.var_.moveOldPos1019ui_story = var_289_5.localPosition
			end

			local var_289_7 = 0.001

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_7 then
				local var_289_8 = (arg_286_1.time_ - var_289_6) / var_289_7
				local var_289_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1019ui_story, var_289_9, var_289_8)

				local var_289_10 = manager.ui.mainCamera.transform.position - var_289_5.position

				var_289_5.forward = Vector3.New(var_289_10.x, var_289_10.y, var_289_10.z)

				local var_289_11 = var_289_5.localEulerAngles

				var_289_11.z = 0
				var_289_11.x = 0
				var_289_5.localEulerAngles = var_289_11
			end

			if arg_286_1.time_ >= var_289_6 + var_289_7 and arg_286_1.time_ < var_289_6 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_289_12 = manager.ui.mainCamera.transform.position - var_289_5.position

				var_289_5.forward = Vector3.New(var_289_12.x, var_289_12.y, var_289_12.z)

				local var_289_13 = var_289_5.localEulerAngles

				var_289_13.z = 0
				var_289_13.x = 0
				var_289_5.localEulerAngles = var_289_13
			end

			local var_289_14 = arg_286_1.actors_["1019ui_story"]
			local var_289_15 = 0

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.characterEffect1019ui_story == nil then
				arg_286_1.var_.characterEffect1019ui_story = var_289_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_16 = 0.200000002980232

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_16 and not isNil(var_289_14) then
				local var_289_17 = (arg_286_1.time_ - var_289_15) / var_289_16

				if arg_286_1.var_.characterEffect1019ui_story and not isNil(var_289_14) then
					arg_286_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_15 + var_289_16 and arg_286_1.time_ < var_289_15 + var_289_16 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.characterEffect1019ui_story then
				arg_286_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_289_18 = 0

			if var_289_18 < arg_286_1.time_ and arg_286_1.time_ <= var_289_18 + arg_289_0 then
				arg_286_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_289_19 = 0

			if var_289_19 < arg_286_1.time_ and arg_286_1.time_ <= var_289_19 + arg_289_0 then
				arg_286_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_20 = 0
			local var_289_21 = 0.175

			if var_289_20 < arg_286_1.time_ and arg_286_1.time_ <= var_289_20 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_22 = arg_286_1:FormatText(StoryNameCfg[13].name)

				arg_286_1.leftNameTxt_.text = var_289_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_23 = arg_286_1:GetWordFromCfg(1109401069)
				local var_289_24 = arg_286_1:FormatText(var_289_23.content)

				arg_286_1.text_.text = var_289_24

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_25 = 7
				local var_289_26 = utf8.len(var_289_24)
				local var_289_27 = var_289_25 <= 0 and var_289_21 or var_289_21 * (var_289_26 / var_289_25)

				if var_289_27 > 0 and var_289_21 < var_289_27 then
					arg_286_1.talkMaxDuration = var_289_27

					if var_289_27 + var_289_20 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_27 + var_289_20
					end
				end

				arg_286_1.text_.text = var_289_24
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401069", "story_v_side_new_1109401.awb") ~= 0 then
					local var_289_28 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401069", "story_v_side_new_1109401.awb") / 1000

					if var_289_28 + var_289_20 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_28 + var_289_20
					end

					if var_289_23.prefab_name ~= "" and arg_286_1.actors_[var_289_23.prefab_name] ~= nil then
						local var_289_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_23.prefab_name].transform, "story_v_side_new_1109401", "1109401069", "story_v_side_new_1109401.awb")

						arg_286_1:RecordAudio("1109401069", var_289_29)
						arg_286_1:RecordAudio("1109401069", var_289_29)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401069", "story_v_side_new_1109401.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401069", "story_v_side_new_1109401.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_30 = math.max(var_289_21, arg_286_1.talkMaxDuration)

			if var_289_20 <= arg_286_1.time_ and arg_286_1.time_ < var_289_20 + var_289_30 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_20) / var_289_30

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_20 + var_289_30 and arg_286_1.time_ < var_289_20 + var_289_30 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play1109401070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1109401070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1109401071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1019ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1019ui_story == nil then
				arg_290_1.var_.characterEffect1019ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1019ui_story and not isNil(var_293_0) then
					local var_293_4 = Mathf.Lerp(0, 0.5, var_293_3)

					arg_290_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1019ui_story.fillRatio = var_293_4
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1019ui_story then
				local var_293_5 = 0.5

				arg_290_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1019ui_story.fillRatio = var_293_5
			end

			local var_293_6 = 0
			local var_293_7 = 0.575

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_8 = arg_290_1:GetWordFromCfg(1109401070)
				local var_293_9 = arg_290_1:FormatText(var_293_8.content)

				arg_290_1.text_.text = var_293_9

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 23
				local var_293_11 = utf8.len(var_293_9)
				local var_293_12 = var_293_10 <= 0 and var_293_7 or var_293_7 * (var_293_11 / var_293_10)

				if var_293_12 > 0 and var_293_7 < var_293_12 then
					arg_290_1.talkMaxDuration = var_293_12

					if var_293_12 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_12 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_9
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_13 and arg_290_1.time_ < var_293_6 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1109401071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1109401071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1109401072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.45

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(1109401071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 18
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_8 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_8 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_8

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_8 and arg_294_1.time_ < var_297_0 + var_297_8 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1109401072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1109401072
		arg_298_1.duration_ = 8.07

		local var_298_0 = {
			ja = 7.6,
			ko = 8.066,
			zh = 8.066
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1109401073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1019ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1019ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1019ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1019ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1019ui_story == nil then
				arg_298_1.var_.characterEffect1019ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect1019ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1019ui_story then
				arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_301_13 = 0
			local var_301_14 = 1.025

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_15 = arg_298_1:FormatText(StoryNameCfg[13].name)

				arg_298_1.leftNameTxt_.text = var_301_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_16 = arg_298_1:GetWordFromCfg(1109401072)
				local var_301_17 = arg_298_1:FormatText(var_301_16.content)

				arg_298_1.text_.text = var_301_17

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_18 = 40
				local var_301_19 = utf8.len(var_301_17)
				local var_301_20 = var_301_18 <= 0 and var_301_14 or var_301_14 * (var_301_19 / var_301_18)

				if var_301_20 > 0 and var_301_14 < var_301_20 then
					arg_298_1.talkMaxDuration = var_301_20

					if var_301_20 + var_301_13 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_20 + var_301_13
					end
				end

				arg_298_1.text_.text = var_301_17
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401072", "story_v_side_new_1109401.awb") ~= 0 then
					local var_301_21 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401072", "story_v_side_new_1109401.awb") / 1000

					if var_301_21 + var_301_13 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_21 + var_301_13
					end

					if var_301_16.prefab_name ~= "" and arg_298_1.actors_[var_301_16.prefab_name] ~= nil then
						local var_301_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_16.prefab_name].transform, "story_v_side_new_1109401", "1109401072", "story_v_side_new_1109401.awb")

						arg_298_1:RecordAudio("1109401072", var_301_22)
						arg_298_1:RecordAudio("1109401072", var_301_22)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401072", "story_v_side_new_1109401.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401072", "story_v_side_new_1109401.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_23 = math.max(var_301_14, arg_298_1.talkMaxDuration)

			if var_301_13 <= arg_298_1.time_ and arg_298_1.time_ < var_301_13 + var_301_23 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_13) / var_301_23

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_13 + var_301_23 and arg_298_1.time_ < var_301_13 + var_301_23 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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

		arg_298_1:InitPlayNodeList()
	end,
	Play1109401073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1109401073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1109401074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1019ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1019ui_story == nil then
				arg_302_1.var_.characterEffect1019ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1019ui_story and not isNil(var_305_0) then
					local var_305_4 = Mathf.Lerp(0, 0.5, var_305_3)

					arg_302_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1019ui_story.fillRatio = var_305_4
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1019ui_story then
				local var_305_5 = 0.5

				arg_302_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1019ui_story.fillRatio = var_305_5
			end

			local var_305_6 = 0
			local var_305_7 = 1.025

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(1109401073)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 39
				local var_305_11 = utf8.len(var_305_9)
				local var_305_12 = var_305_10 <= 0 and var_305_7 or var_305_7 * (var_305_11 / var_305_10)

				if var_305_12 > 0 and var_305_7 < var_305_12 then
					arg_302_1.talkMaxDuration = var_305_12

					if var_305_12 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_13 and arg_302_1.time_ < var_305_6 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1109401074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1109401074
		arg_306_1.duration_ = 13.8

		local var_306_0 = {
			ja = 13.8,
			ko = 11.666,
			zh = 11.666
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1109401075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1019ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1019ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1019ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1019ui_story"]
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1019ui_story == nil then
				arg_306_1.var_.characterEffect1019ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_11 = 0.200000002980232

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 and not isNil(var_309_9) then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11

				if arg_306_1.var_.characterEffect1019ui_story and not isNil(var_309_9) then
					arg_306_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1019ui_story then
				arg_306_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_309_13 = 0

			if var_309_13 < arg_306_1.time_ and arg_306_1.time_ <= var_309_13 + arg_309_0 then
				arg_306_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_309_14 = 0

			if var_309_14 < arg_306_1.time_ and arg_306_1.time_ <= var_309_14 + arg_309_0 then
				arg_306_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_309_15 = 0
			local var_309_16 = 1.375

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_17 = arg_306_1:FormatText(StoryNameCfg[13].name)

				arg_306_1.leftNameTxt_.text = var_309_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_18 = arg_306_1:GetWordFromCfg(1109401074)
				local var_309_19 = arg_306_1:FormatText(var_309_18.content)

				arg_306_1.text_.text = var_309_19

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_20 = 55
				local var_309_21 = utf8.len(var_309_19)
				local var_309_22 = var_309_20 <= 0 and var_309_16 or var_309_16 * (var_309_21 / var_309_20)

				if var_309_22 > 0 and var_309_16 < var_309_22 then
					arg_306_1.talkMaxDuration = var_309_22

					if var_309_22 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_15
					end
				end

				arg_306_1.text_.text = var_309_19
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401074", "story_v_side_new_1109401.awb") ~= 0 then
					local var_309_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401074", "story_v_side_new_1109401.awb") / 1000

					if var_309_23 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_23 + var_309_15
					end

					if var_309_18.prefab_name ~= "" and arg_306_1.actors_[var_309_18.prefab_name] ~= nil then
						local var_309_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_18.prefab_name].transform, "story_v_side_new_1109401", "1109401074", "story_v_side_new_1109401.awb")

						arg_306_1:RecordAudio("1109401074", var_309_24)
						arg_306_1:RecordAudio("1109401074", var_309_24)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401074", "story_v_side_new_1109401.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401074", "story_v_side_new_1109401.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_25 = math.max(var_309_16, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_25 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_15) / var_309_25

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_25 and arg_306_1.time_ < var_309_15 + var_309_25 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play1109401075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1109401075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1109401076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1019ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1019ui_story == nil then
				arg_310_1.var_.characterEffect1019ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1019ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1019ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1019ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1019ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 1

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				local var_313_8 = "play"
				local var_313_9 = "effect"

				arg_310_1:AudioAction(var_313_8, var_313_9, "se_story_side_1094", "se_story_1094_data", "")
			end

			local var_313_10 = 0
			local var_313_11 = 1.05

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_12 = arg_310_1:GetWordFromCfg(1109401075)
				local var_313_13 = arg_310_1:FormatText(var_313_12.content)

				arg_310_1.text_.text = var_313_13

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_14 = 42
				local var_313_15 = utf8.len(var_313_13)
				local var_313_16 = var_313_14 <= 0 and var_313_11 or var_313_11 * (var_313_15 / var_313_14)

				if var_313_16 > 0 and var_313_11 < var_313_16 then
					arg_310_1.talkMaxDuration = var_313_16

					if var_313_16 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_16 + var_313_10
					end
				end

				arg_310_1.text_.text = var_313_13
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_17 = math.max(var_313_11, arg_310_1.talkMaxDuration)

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_17 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_10) / var_313_17

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_10 + var_313_17 and arg_310_1.time_ < var_313_10 + var_313_17 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1109401076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1109401076
		arg_314_1.duration_ = 8.2

		local var_314_0 = {
			ja = 8.2,
			ko = 7.566,
			zh = 7.566
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1109401077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1019ui_story"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos1019ui_story = var_317_0.localPosition
			end

			local var_317_2 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2
				local var_317_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1019ui_story, var_317_4, var_317_3)

				local var_317_5 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_5.x, var_317_5.y, var_317_5.z)

				local var_317_6 = var_317_0.localEulerAngles

				var_317_6.z = 0
				var_317_6.x = 0
				var_317_0.localEulerAngles = var_317_6
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_317_7 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_7.x, var_317_7.y, var_317_7.z)

				local var_317_8 = var_317_0.localEulerAngles

				var_317_8.z = 0
				var_317_8.x = 0
				var_317_0.localEulerAngles = var_317_8
			end

			local var_317_9 = arg_314_1.actors_["1019ui_story"]
			local var_317_10 = 0

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect1019ui_story == nil then
				arg_314_1.var_.characterEffect1019ui_story = var_317_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_11 = 0.200000002980232

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_11 and not isNil(var_317_9) then
				local var_317_12 = (arg_314_1.time_ - var_317_10) / var_317_11

				if arg_314_1.var_.characterEffect1019ui_story and not isNil(var_317_9) then
					arg_314_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_10 + var_317_11 and arg_314_1.time_ < var_317_10 + var_317_11 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect1019ui_story then
				arg_314_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_317_13 = 0

			if var_317_13 < arg_314_1.time_ and arg_314_1.time_ <= var_317_13 + arg_317_0 then
				arg_314_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_317_14 = 0

			if var_317_14 < arg_314_1.time_ and arg_314_1.time_ <= var_317_14 + arg_317_0 then
				arg_314_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_317_15 = 0
			local var_317_16 = 0.825

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_17 = arg_314_1:FormatText(StoryNameCfg[13].name)

				arg_314_1.leftNameTxt_.text = var_317_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_18 = arg_314_1:GetWordFromCfg(1109401076)
				local var_317_19 = arg_314_1:FormatText(var_317_18.content)

				arg_314_1.text_.text = var_317_19

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_20 = 33
				local var_317_21 = utf8.len(var_317_19)
				local var_317_22 = var_317_20 <= 0 and var_317_16 or var_317_16 * (var_317_21 / var_317_20)

				if var_317_22 > 0 and var_317_16 < var_317_22 then
					arg_314_1.talkMaxDuration = var_317_22

					if var_317_22 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_22 + var_317_15
					end
				end

				arg_314_1.text_.text = var_317_19
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401076", "story_v_side_new_1109401.awb") ~= 0 then
					local var_317_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401076", "story_v_side_new_1109401.awb") / 1000

					if var_317_23 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_23 + var_317_15
					end

					if var_317_18.prefab_name ~= "" and arg_314_1.actors_[var_317_18.prefab_name] ~= nil then
						local var_317_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_18.prefab_name].transform, "story_v_side_new_1109401", "1109401076", "story_v_side_new_1109401.awb")

						arg_314_1:RecordAudio("1109401076", var_317_24)
						arg_314_1:RecordAudio("1109401076", var_317_24)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401076", "story_v_side_new_1109401.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401076", "story_v_side_new_1109401.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_25 = math.max(var_317_16, arg_314_1.talkMaxDuration)

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_25 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_15) / var_317_25

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_15 + var_317_25 and arg_314_1.time_ < var_317_15 + var_317_25 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
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

		arg_314_1:InitPlayNodeList()
	end,
	Play1109401077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1109401077
		arg_318_1.duration_ = 9

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1109401078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = "B13"

			if arg_318_1.bgs_[var_321_0] == nil then
				local var_321_1 = Object.Instantiate(arg_318_1.paintGo_)

				var_321_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_321_0)
				var_321_1.name = var_321_0
				var_321_1.transform.parent = arg_318_1.stage_.transform
				var_321_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.bgs_[var_321_0] = var_321_1
			end

			local var_321_2 = 2

			if var_321_2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				if arg_318_0.sceneSettingEffect_ then
					arg_318_1.sceneSettingEffect_.enabled = false
				end

				arg_318_1.sceneSettingGo_:SetActive(true)

				local var_321_3 = manager.ui.mainCamera.transform.localPosition
				local var_321_4 = Vector3.New(0, 0, 10) + Vector3.New(var_321_3.x, var_321_3.y, 0)
				local var_321_5 = arg_318_1.bgs_.B13

				var_321_5.transform.localPosition = var_321_4
				var_321_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_6 = var_321_5:GetComponent("SpriteRenderer")

				if var_321_6 and var_321_6.sprite then
					local var_321_7 = (var_321_5.transform.localPosition - var_321_3).z
					local var_321_8 = manager.ui.mainCameraCom_
					local var_321_9 = 2 * var_321_7 * Mathf.Tan(var_321_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_321_10 = var_321_9 * var_321_8.aspect
					local var_321_11 = var_321_6.sprite.bounds.size.x
					local var_321_12 = var_321_6.sprite.bounds.size.y
					local var_321_13 = var_321_10 / var_321_11
					local var_321_14 = var_321_9 / var_321_12
					local var_321_15 = var_321_14 < var_321_13 and var_321_13 or var_321_14

					var_321_5.transform.localScale = Vector3.New(var_321_15, var_321_15, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "B13" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_16 = 0

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_17 = 2

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_17 then
				local var_321_18 = (arg_318_1.time_ - var_321_16) / var_321_17
				local var_321_19 = Color.New(0, 0, 0)

				var_321_19.a = Mathf.Lerp(0, 1, var_321_18)
				arg_318_1.mask_.color = var_321_19
			end

			if arg_318_1.time_ >= var_321_16 + var_321_17 and arg_318_1.time_ < var_321_16 + var_321_17 + arg_321_0 then
				local var_321_20 = Color.New(0, 0, 0)

				var_321_20.a = 1
				arg_318_1.mask_.color = var_321_20
			end

			local var_321_21 = 2

			if var_321_21 < arg_318_1.time_ and arg_318_1.time_ <= var_321_21 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_22 = 2

			if var_321_21 <= arg_318_1.time_ and arg_318_1.time_ < var_321_21 + var_321_22 then
				local var_321_23 = (arg_318_1.time_ - var_321_21) / var_321_22
				local var_321_24 = Color.New(0, 0, 0)

				var_321_24.a = Mathf.Lerp(1, 0, var_321_23)
				arg_318_1.mask_.color = var_321_24
			end

			if arg_318_1.time_ >= var_321_21 + var_321_22 and arg_318_1.time_ < var_321_21 + var_321_22 + arg_321_0 then
				local var_321_25 = Color.New(0, 0, 0)
				local var_321_26 = 0

				arg_318_1.mask_.enabled = false
				var_321_25.a = var_321_26
				arg_318_1.mask_.color = var_321_25
			end

			local var_321_27 = arg_318_1.actors_["1019ui_story"].transform
			local var_321_28 = 0

			if var_321_28 < arg_318_1.time_ and arg_318_1.time_ <= var_321_28 + arg_321_0 then
				arg_318_1.var_.moveOldPos1019ui_story = var_321_27.localPosition
			end

			local var_321_29 = 0.001

			if var_321_28 <= arg_318_1.time_ and arg_318_1.time_ < var_321_28 + var_321_29 then
				local var_321_30 = (arg_318_1.time_ - var_321_28) / var_321_29
				local var_321_31 = Vector3.New(0, 100, 0)

				var_321_27.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1019ui_story, var_321_31, var_321_30)

				local var_321_32 = manager.ui.mainCamera.transform.position - var_321_27.position

				var_321_27.forward = Vector3.New(var_321_32.x, var_321_32.y, var_321_32.z)

				local var_321_33 = var_321_27.localEulerAngles

				var_321_33.z = 0
				var_321_33.x = 0
				var_321_27.localEulerAngles = var_321_33
			end

			if arg_318_1.time_ >= var_321_28 + var_321_29 and arg_318_1.time_ < var_321_28 + var_321_29 + arg_321_0 then
				var_321_27.localPosition = Vector3.New(0, 100, 0)

				local var_321_34 = manager.ui.mainCamera.transform.position - var_321_27.position

				var_321_27.forward = Vector3.New(var_321_34.x, var_321_34.y, var_321_34.z)

				local var_321_35 = var_321_27.localEulerAngles

				var_321_35.z = 0
				var_321_35.x = 0
				var_321_27.localEulerAngles = var_321_35
			end

			local var_321_36 = arg_318_1.actors_["1019ui_story"]
			local var_321_37 = 0

			if var_321_37 < arg_318_1.time_ and arg_318_1.time_ <= var_321_37 + arg_321_0 and not isNil(var_321_36) and arg_318_1.var_.characterEffect1019ui_story == nil then
				arg_318_1.var_.characterEffect1019ui_story = var_321_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_38 = 0.200000002980232

			if var_321_37 <= arg_318_1.time_ and arg_318_1.time_ < var_321_37 + var_321_38 and not isNil(var_321_36) then
				local var_321_39 = (arg_318_1.time_ - var_321_37) / var_321_38

				if arg_318_1.var_.characterEffect1019ui_story and not isNil(var_321_36) then
					local var_321_40 = Mathf.Lerp(0, 0.5, var_321_39)

					arg_318_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1019ui_story.fillRatio = var_321_40
				end
			end

			if arg_318_1.time_ >= var_321_37 + var_321_38 and arg_318_1.time_ < var_321_37 + var_321_38 + arg_321_0 and not isNil(var_321_36) and arg_318_1.var_.characterEffect1019ui_story then
				local var_321_41 = 0.5

				arg_318_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1019ui_story.fillRatio = var_321_41
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_42 = 4
			local var_321_43 = 0.3

			if var_321_42 < arg_318_1.time_ and arg_318_1.time_ <= var_321_42 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_44 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_44:setOnUpdate(LuaHelper.FloatAction(function(arg_322_0)
					arg_318_1.dialogCg_.alpha = arg_322_0
				end))
				var_321_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_45 = arg_318_1:GetWordFromCfg(1109401077)
				local var_321_46 = arg_318_1:FormatText(var_321_45.content)

				arg_318_1.text_.text = var_321_46

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_47 = 12
				local var_321_48 = utf8.len(var_321_46)
				local var_321_49 = var_321_47 <= 0 and var_321_43 or var_321_43 * (var_321_48 / var_321_47)

				if var_321_49 > 0 and var_321_43 < var_321_49 then
					arg_318_1.talkMaxDuration = var_321_49
					var_321_42 = var_321_42 + 0.3

					if var_321_49 + var_321_42 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_49 + var_321_42
					end
				end

				arg_318_1.text_.text = var_321_46
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_50 = var_321_42 + 0.3
			local var_321_51 = math.max(var_321_43, arg_318_1.talkMaxDuration)

			if var_321_50 <= arg_318_1.time_ and arg_318_1.time_ < var_321_50 + var_321_51 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_50) / var_321_51

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_50 + var_321_51 and arg_318_1.time_ < var_321_50 + var_321_51 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
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

		arg_318_1:InitPlayNodeList()
	end,
	Play1109401078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1109401078
		arg_324_1.duration_ = 5.7

		local var_324_0 = {
			ja = 5.7,
			ko = 5.4,
			zh = 5.4
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
				arg_324_0:Play1109401079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1019ui_story"].transform
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.var_.moveOldPos1019ui_story = var_327_0.localPosition
			end

			local var_327_2 = 0.001

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2
				local var_327_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_327_0.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1019ui_story, var_327_4, var_327_3)

				local var_327_5 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_5.x, var_327_5.y, var_327_5.z)

				local var_327_6 = var_327_0.localEulerAngles

				var_327_6.z = 0
				var_327_6.x = 0
				var_327_0.localEulerAngles = var_327_6
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 then
				var_327_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_327_7 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_7.x, var_327_7.y, var_327_7.z)

				local var_327_8 = var_327_0.localEulerAngles

				var_327_8.z = 0
				var_327_8.x = 0
				var_327_0.localEulerAngles = var_327_8
			end

			local var_327_9 = arg_324_1.actors_["1019ui_story"]
			local var_327_10 = 0

			if var_327_10 < arg_324_1.time_ and arg_324_1.time_ <= var_327_10 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect1019ui_story == nil then
				arg_324_1.var_.characterEffect1019ui_story = var_327_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_11 = 0.200000002980232

			if var_327_10 <= arg_324_1.time_ and arg_324_1.time_ < var_327_10 + var_327_11 and not isNil(var_327_9) then
				local var_327_12 = (arg_324_1.time_ - var_327_10) / var_327_11

				if arg_324_1.var_.characterEffect1019ui_story and not isNil(var_327_9) then
					arg_324_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_10 + var_327_11 and arg_324_1.time_ < var_327_10 + var_327_11 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect1019ui_story then
				arg_324_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_327_13 = 0

			if var_327_13 < arg_324_1.time_ and arg_324_1.time_ <= var_327_13 + arg_327_0 then
				arg_324_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_327_14 = 0

			if var_327_14 < arg_324_1.time_ and arg_324_1.time_ <= var_327_14 + arg_327_0 then
				arg_324_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_327_15 = 0
			local var_327_16 = 0.675

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_17 = arg_324_1:FormatText(StoryNameCfg[13].name)

				arg_324_1.leftNameTxt_.text = var_327_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_18 = arg_324_1:GetWordFromCfg(1109401078)
				local var_327_19 = arg_324_1:FormatText(var_327_18.content)

				arg_324_1.text_.text = var_327_19

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_20 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401078", "story_v_side_new_1109401.awb") ~= 0 then
					local var_327_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401078", "story_v_side_new_1109401.awb") / 1000

					if var_327_23 + var_327_15 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_23 + var_327_15
					end

					if var_327_18.prefab_name ~= "" and arg_324_1.actors_[var_327_18.prefab_name] ~= nil then
						local var_327_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_18.prefab_name].transform, "story_v_side_new_1109401", "1109401078", "story_v_side_new_1109401.awb")

						arg_324_1:RecordAudio("1109401078", var_327_24)
						arg_324_1:RecordAudio("1109401078", var_327_24)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401078", "story_v_side_new_1109401.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401078", "story_v_side_new_1109401.awb")
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
				actorName = "1019ui_story",
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
	Play1109401079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1109401079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1109401080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1019ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1019ui_story == nil then
				arg_328_1.var_.characterEffect1019ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1019ui_story and not isNil(var_331_0) then
					local var_331_4 = Mathf.Lerp(0, 0.5, var_331_3)

					arg_328_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1019ui_story.fillRatio = var_331_4
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1019ui_story then
				local var_331_5 = 0.5

				arg_328_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1019ui_story.fillRatio = var_331_5
			end

			local var_331_6 = 0
			local var_331_7 = 0.525

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_9 = arg_328_1:GetWordFromCfg(1109401079)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 21
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_14 and arg_328_1.time_ < var_331_6 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1109401080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1109401080
		arg_332_1.duration_ = 5.43

		local var_332_0 = {
			ja = 5.433,
			ko = 5.333,
			zh = 5.333
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
				arg_332_0:Play1109401081(arg_332_1)
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
				local var_335_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1019ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["1019ui_story"]
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect1019ui_story == nil then
				arg_332_1.var_.characterEffect1019ui_story = var_335_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_11 = 0.200000002980232

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 and not isNil(var_335_9) then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11

				if arg_332_1.var_.characterEffect1019ui_story and not isNil(var_335_9) then
					arg_332_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect1019ui_story then
				arg_332_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_335_13 = 0

			if var_335_13 < arg_332_1.time_ and arg_332_1.time_ <= var_335_13 + arg_335_0 then
				arg_332_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_335_14 = 0

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_15 = 0
			local var_335_16 = 0.6

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_17 = arg_332_1:FormatText(StoryNameCfg[13].name)

				arg_332_1.leftNameTxt_.text = var_335_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_18 = arg_332_1:GetWordFromCfg(1109401080)
				local var_335_19 = arg_332_1:FormatText(var_335_18.content)

				arg_332_1.text_.text = var_335_19

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_20 = 24
				local var_335_21 = utf8.len(var_335_19)
				local var_335_22 = var_335_20 <= 0 and var_335_16 or var_335_16 * (var_335_21 / var_335_20)

				if var_335_22 > 0 and var_335_16 < var_335_22 then
					arg_332_1.talkMaxDuration = var_335_22

					if var_335_22 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_22 + var_335_15
					end
				end

				arg_332_1.text_.text = var_335_19
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401080", "story_v_side_new_1109401.awb") ~= 0 then
					local var_335_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401080", "story_v_side_new_1109401.awb") / 1000

					if var_335_23 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_23 + var_335_15
					end

					if var_335_18.prefab_name ~= "" and arg_332_1.actors_[var_335_18.prefab_name] ~= nil then
						local var_335_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_18.prefab_name].transform, "story_v_side_new_1109401", "1109401080", "story_v_side_new_1109401.awb")

						arg_332_1:RecordAudio("1109401080", var_335_24)
						arg_332_1:RecordAudio("1109401080", var_335_24)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401080", "story_v_side_new_1109401.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401080", "story_v_side_new_1109401.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_25 = math.max(var_335_16, arg_332_1.talkMaxDuration)

			if var_335_15 <= arg_332_1.time_ and arg_332_1.time_ < var_335_15 + var_335_25 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_15) / var_335_25

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_15 + var_335_25 and arg_332_1.time_ < var_335_15 + var_335_25 + arg_335_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1109401081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1109401081
		arg_336_1.duration_ = 6.93

		local var_336_0 = {
			ja = 6.933,
			ko = 3.9,
			zh = 3.9
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
				arg_336_0:Play1109401082(arg_336_1)
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
				local var_339_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1019ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

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

			local var_339_13 = 0

			if var_339_13 < arg_336_1.time_ and arg_336_1.time_ <= var_339_13 + arg_339_0 then
				arg_336_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_339_14 = 0
			local var_339_15 = 0.425

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_16 = arg_336_1:FormatText(StoryNameCfg[13].name)

				arg_336_1.leftNameTxt_.text = var_339_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_17 = arg_336_1:GetWordFromCfg(1109401081)
				local var_339_18 = arg_336_1:FormatText(var_339_17.content)

				arg_336_1.text_.text = var_339_18

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_19 = 17
				local var_339_20 = utf8.len(var_339_18)
				local var_339_21 = var_339_19 <= 0 and var_339_15 or var_339_15 * (var_339_20 / var_339_19)

				if var_339_21 > 0 and var_339_15 < var_339_21 then
					arg_336_1.talkMaxDuration = var_339_21

					if var_339_21 + var_339_14 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_21 + var_339_14
					end
				end

				arg_336_1.text_.text = var_339_18
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401081", "story_v_side_new_1109401.awb") ~= 0 then
					local var_339_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401081", "story_v_side_new_1109401.awb") / 1000

					if var_339_22 + var_339_14 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_22 + var_339_14
					end

					if var_339_17.prefab_name ~= "" and arg_336_1.actors_[var_339_17.prefab_name] ~= nil then
						local var_339_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_17.prefab_name].transform, "story_v_side_new_1109401", "1109401081", "story_v_side_new_1109401.awb")

						arg_336_1:RecordAudio("1109401081", var_339_23)
						arg_336_1:RecordAudio("1109401081", var_339_23)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401081", "story_v_side_new_1109401.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401081", "story_v_side_new_1109401.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_24 = math.max(var_339_15, arg_336_1.talkMaxDuration)

			if var_339_14 <= arg_336_1.time_ and arg_336_1.time_ < var_339_14 + var_339_24 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_14) / var_339_24

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_14 + var_339_24 and arg_336_1.time_ < var_339_14 + var_339_24 + arg_339_0 then
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
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1109401082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109401082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109401083(arg_340_1)
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
				local var_343_4 = Vector3.New(0, 100, 0)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1019ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, 100, 0)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["1019ui_story"]
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1019ui_story == nil then
				arg_340_1.var_.characterEffect1019ui_story = var_343_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_11 = 0.200000002980232

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 and not isNil(var_343_9) then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11

				if arg_340_1.var_.characterEffect1019ui_story and not isNil(var_343_9) then
					local var_343_13 = Mathf.Lerp(0, 0.5, var_343_12)

					arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1019ui_story.fillRatio = var_343_13
				end
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1019ui_story then
				local var_343_14 = 0.5

				arg_340_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1019ui_story.fillRatio = var_343_14
			end

			local var_343_15 = 0
			local var_343_16 = 0.825

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_17 = arg_340_1:GetWordFromCfg(1109401082)
				local var_343_18 = arg_340_1:FormatText(var_343_17.content)

				arg_340_1.text_.text = var_343_18

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_19 = 33
				local var_343_20 = utf8.len(var_343_18)
				local var_343_21 = var_343_19 <= 0 and var_343_16 or var_343_16 * (var_343_20 / var_343_19)

				if var_343_21 > 0 and var_343_16 < var_343_21 then
					arg_340_1.talkMaxDuration = var_343_21

					if var_343_21 + var_343_15 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_21 + var_343_15
					end
				end

				arg_340_1.text_.text = var_343_18
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_22 = math.max(var_343_16, arg_340_1.talkMaxDuration)

			if var_343_15 <= arg_340_1.time_ and arg_340_1.time_ < var_343_15 + var_343_22 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_15) / var_343_22

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_15 + var_343_22 and arg_340_1.time_ < var_343_15 + var_343_22 + arg_343_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109401083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109401083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109401084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1094ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos1094ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0, -0.84, -6.1)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1094ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = 0

			if var_347_9 < arg_344_1.time_ and arg_344_1.time_ <= var_347_9 + arg_347_0 then
				arg_344_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_347_10 = 0
			local var_347_11 = 0.55

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_12 = arg_344_1:GetWordFromCfg(1109401083)
				local var_347_13 = arg_344_1:FormatText(var_347_12.content)

				arg_344_1.text_.text = var_347_13

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_14 = 22
				local var_347_15 = utf8.len(var_347_13)
				local var_347_16 = var_347_14 <= 0 and var_347_11 or var_347_11 * (var_347_15 / var_347_14)

				if var_347_16 > 0 and var_347_11 < var_347_16 then
					arg_344_1.talkMaxDuration = var_347_16

					if var_347_16 + var_347_10 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_16 + var_347_10
					end
				end

				arg_344_1.text_.text = var_347_13
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_17 = math.max(var_347_11, arg_344_1.talkMaxDuration)

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_17 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_10) / var_347_17

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_10 + var_347_17 and arg_344_1.time_ < var_347_10 + var_347_17 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109401084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109401085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1094ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1094ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, 100, 0)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1094ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, 100, 0)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = 0
			local var_351_10 = 0.75

			if var_351_9 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_11 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_12 = arg_348_1:GetWordFromCfg(1109401084)
				local var_351_13 = arg_348_1:FormatText(var_351_12.content)

				arg_348_1.text_.text = var_351_13

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_14 = 30
				local var_351_15 = utf8.len(var_351_13)
				local var_351_16 = var_351_14 <= 0 and var_351_10 or var_351_10 * (var_351_15 / var_351_14)

				if var_351_16 > 0 and var_351_10 < var_351_16 then
					arg_348_1.talkMaxDuration = var_351_16

					if var_351_16 + var_351_9 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_16 + var_351_9
					end
				end

				arg_348_1.text_.text = var_351_13
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_17 = math.max(var_351_10, arg_348_1.talkMaxDuration)

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_17 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_9) / var_351_17

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_9 + var_351_17 and arg_348_1.time_ < var_351_9 + var_351_17 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109401085
		arg_352_1.duration_ = 9

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109401086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = "ST34"

			if arg_352_1.bgs_[var_355_0] == nil then
				local var_355_1 = Object.Instantiate(arg_352_1.paintGo_)

				var_355_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_355_0)
				var_355_1.name = var_355_0
				var_355_1.transform.parent = arg_352_1.stage_.transform
				var_355_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_352_1.bgs_[var_355_0] = var_355_1
			end

			local var_355_2 = 2

			if var_355_2 < arg_352_1.time_ and arg_352_1.time_ <= var_355_2 + arg_355_0 then
				local var_355_3 = manager.ui.mainCamera.transform.localPosition
				local var_355_4 = Vector3.New(0, 0, 10) + Vector3.New(var_355_3.x, var_355_3.y, 0)
				local var_355_5 = arg_352_1.bgs_.ST34

				var_355_5.transform.localPosition = var_355_4
				var_355_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_355_6 = var_355_5:GetComponent("SpriteRenderer")

				if var_355_6 and var_355_6.sprite then
					local var_355_7 = (var_355_5.transform.localPosition - var_355_3).z
					local var_355_8 = manager.ui.mainCameraCom_
					local var_355_9 = 2 * var_355_7 * Mathf.Tan(var_355_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_355_10 = var_355_9 * var_355_8.aspect
					local var_355_11 = var_355_6.sprite.bounds.size.x
					local var_355_12 = var_355_6.sprite.bounds.size.y
					local var_355_13 = var_355_10 / var_355_11
					local var_355_14 = var_355_9 / var_355_12
					local var_355_15 = var_355_14 < var_355_13 and var_355_13 or var_355_14

					var_355_5.transform.localScale = Vector3.New(var_355_15, var_355_15, 0)
				end

				for iter_355_0, iter_355_1 in pairs(arg_352_1.bgs_) do
					if iter_355_0 ~= "ST34" then
						iter_355_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_355_16 = 0

			if var_355_16 < arg_352_1.time_ and arg_352_1.time_ <= var_355_16 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_17 = 2

			if var_355_16 <= arg_352_1.time_ and arg_352_1.time_ < var_355_16 + var_355_17 then
				local var_355_18 = (arg_352_1.time_ - var_355_16) / var_355_17
				local var_355_19 = Color.New(0, 0, 0)

				var_355_19.a = Mathf.Lerp(0, 1, var_355_18)
				arg_352_1.mask_.color = var_355_19
			end

			if arg_352_1.time_ >= var_355_16 + var_355_17 and arg_352_1.time_ < var_355_16 + var_355_17 + arg_355_0 then
				local var_355_20 = Color.New(0, 0, 0)

				var_355_20.a = 1
				arg_352_1.mask_.color = var_355_20
			end

			local var_355_21 = 2

			if var_355_21 < arg_352_1.time_ and arg_352_1.time_ <= var_355_21 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_22 = 2

			if var_355_21 <= arg_352_1.time_ and arg_352_1.time_ < var_355_21 + var_355_22 then
				local var_355_23 = (arg_352_1.time_ - var_355_21) / var_355_22
				local var_355_24 = Color.New(0, 0, 0)

				var_355_24.a = Mathf.Lerp(1, 0, var_355_23)
				arg_352_1.mask_.color = var_355_24
			end

			if arg_352_1.time_ >= var_355_21 + var_355_22 and arg_352_1.time_ < var_355_21 + var_355_22 + arg_355_0 then
				local var_355_25 = Color.New(0, 0, 0)
				local var_355_26 = 0

				arg_352_1.mask_.enabled = false
				var_355_25.a = var_355_26
				arg_352_1.mask_.color = var_355_25
			end

			if arg_352_1.frameCnt_ <= 1 then
				arg_352_1.dialog_:SetActive(false)
			end

			local var_355_27 = 4
			local var_355_28 = 0.45

			if var_355_27 < arg_352_1.time_ and arg_352_1.time_ <= var_355_27 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0

				arg_352_1.dialog_:SetActive(true)

				arg_352_1.dialogCg_.alpha = 0

				local var_355_29 = LeanTween.value(arg_352_1.dialog_, 0, 1, 0.3)

				var_355_29:setOnUpdate(LuaHelper.FloatAction(function(arg_356_0)
					arg_352_1.dialogCg_.alpha = arg_356_0
				end))
				var_355_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_352_1.dialog_)
					var_355_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_352_1.duration_ = arg_352_1.duration_ + 0.3

				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_30 = arg_352_1:GetWordFromCfg(1109401085)
				local var_355_31 = arg_352_1:FormatText(var_355_30.content)

				arg_352_1.text_.text = var_355_31

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_32 = 18
				local var_355_33 = utf8.len(var_355_31)
				local var_355_34 = var_355_32 <= 0 and var_355_28 or var_355_28 * (var_355_33 / var_355_32)

				if var_355_34 > 0 and var_355_28 < var_355_34 then
					arg_352_1.talkMaxDuration = var_355_34
					var_355_27 = var_355_27 + 0.3

					if var_355_34 + var_355_27 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_34 + var_355_27
					end
				end

				arg_352_1.text_.text = var_355_31
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_35 = var_355_27 + 0.3
			local var_355_36 = math.max(var_355_28, arg_352_1.talkMaxDuration)

			if var_355_35 <= arg_352_1.time_ and arg_352_1.time_ < var_355_35 + var_355_36 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_35) / var_355_36

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_35 + var_355_36 and arg_352_1.time_ < var_355_35 + var_355_36 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1109401086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1109401086
		arg_358_1.duration_ = 5.17

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1109401087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.175

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_2 = arg_358_1:GetWordFromCfg(1109401086)
				local var_361_3 = arg_358_1:FormatText(var_361_2.content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 47
				local var_361_5 = utf8.len(var_361_3)
				local var_361_6 = var_361_4 <= 0 and var_361_1 or var_361_1 * (var_361_5 / var_361_4)

				if var_361_6 > 0 and var_361_1 < var_361_6 then
					arg_358_1.talkMaxDuration = var_361_6

					if var_361_6 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_6 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_7 and arg_358_1.time_ < var_361_0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1109401087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1109401087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1109401088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.025

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_2 = arg_362_1:GetWordFromCfg(1109401087)
				local var_365_3 = arg_362_1:FormatText(var_365_2.content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 41
				local var_365_5 = utf8.len(var_365_3)
				local var_365_6 = var_365_4 <= 0 and var_365_1 or var_365_1 * (var_365_5 / var_365_4)

				if var_365_6 > 0 and var_365_1 < var_365_6 then
					arg_362_1.talkMaxDuration = var_365_6

					if var_365_6 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_7 and arg_362_1.time_ < var_365_0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1109401088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1109401088
		arg_366_1.duration_ = 11.73

		local var_366_0 = {
			ja = 11.733,
			ko = 9.6,
			zh = 9.6
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1109401089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = "B13b"

			if arg_366_1.bgs_[var_369_0] == nil then
				local var_369_1 = Object.Instantiate(arg_366_1.paintGo_)

				var_369_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_369_0)
				var_369_1.name = var_369_0
				var_369_1.transform.parent = arg_366_1.stage_.transform
				var_369_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.bgs_[var_369_0] = var_369_1
			end

			local var_369_2 = 2

			if var_369_2 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				if arg_366_0.sceneSettingEffect_ then
					arg_366_1.sceneSettingEffect_.enabled = false
				end

				arg_366_1.sceneSettingGo_:SetActive(true)

				local var_369_3 = manager.ui.mainCamera.transform.localPosition
				local var_369_4 = Vector3.New(0, 0, 10) + Vector3.New(var_369_3.x, var_369_3.y, 0)
				local var_369_5 = arg_366_1.bgs_.B13b

				var_369_5.transform.localPosition = var_369_4
				var_369_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_369_6 = var_369_5:GetComponent("SpriteRenderer")

				if var_369_6 and var_369_6.sprite then
					local var_369_7 = (var_369_5.transform.localPosition - var_369_3).z
					local var_369_8 = manager.ui.mainCameraCom_
					local var_369_9 = 2 * var_369_7 * Mathf.Tan(var_369_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_369_10 = var_369_9 * var_369_8.aspect
					local var_369_11 = var_369_6.sprite.bounds.size.x
					local var_369_12 = var_369_6.sprite.bounds.size.y
					local var_369_13 = var_369_10 / var_369_11
					local var_369_14 = var_369_9 / var_369_12
					local var_369_15 = var_369_14 < var_369_13 and var_369_13 or var_369_14

					var_369_5.transform.localScale = Vector3.New(var_369_15, var_369_15, 0)
				end

				for iter_369_0, iter_369_1 in pairs(arg_366_1.bgs_) do
					if iter_369_0 ~= "B13b" then
						iter_369_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_369_16 = 0

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_17 = 2

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_17 then
				local var_369_18 = (arg_366_1.time_ - var_369_16) / var_369_17
				local var_369_19 = Color.New(0, 0, 0)

				var_369_19.a = Mathf.Lerp(0, 1, var_369_18)
				arg_366_1.mask_.color = var_369_19
			end

			if arg_366_1.time_ >= var_369_16 + var_369_17 and arg_366_1.time_ < var_369_16 + var_369_17 + arg_369_0 then
				local var_369_20 = Color.New(0, 0, 0)

				var_369_20.a = 1
				arg_366_1.mask_.color = var_369_20
			end

			local var_369_21 = 2

			if var_369_21 < arg_366_1.time_ and arg_366_1.time_ <= var_369_21 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_22 = 2

			if var_369_21 <= arg_366_1.time_ and arg_366_1.time_ < var_369_21 + var_369_22 then
				local var_369_23 = (arg_366_1.time_ - var_369_21) / var_369_22
				local var_369_24 = Color.New(0, 0, 0)

				var_369_24.a = Mathf.Lerp(1, 0, var_369_23)
				arg_366_1.mask_.color = var_369_24
			end

			if arg_366_1.time_ >= var_369_21 + var_369_22 and arg_366_1.time_ < var_369_21 + var_369_22 + arg_369_0 then
				local var_369_25 = Color.New(0, 0, 0)
				local var_369_26 = 0

				arg_366_1.mask_.enabled = false
				var_369_25.a = var_369_26
				arg_366_1.mask_.color = var_369_25
			end

			if arg_366_1.frameCnt_ <= 1 then
				arg_366_1.dialog_:SetActive(false)
			end

			local var_369_27 = 4
			local var_369_28 = 0.65

			if var_369_27 < arg_366_1.time_ and arg_366_1.time_ <= var_369_27 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0

				arg_366_1.dialog_:SetActive(true)

				arg_366_1.dialogCg_.alpha = 0

				local var_369_29 = LeanTween.value(arg_366_1.dialog_, 0, 1, 0.3)

				var_369_29:setOnUpdate(LuaHelper.FloatAction(function(arg_370_0)
					arg_366_1.dialogCg_.alpha = arg_370_0
				end))
				var_369_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_366_1.dialog_)
					var_369_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_366_1.duration_ = arg_366_1.duration_ + 0.3

				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_30 = arg_366_1:FormatText(StoryNameCfg[177].name)

				arg_366_1.leftNameTxt_.text = var_369_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_31 = arg_366_1:GetWordFromCfg(1109401088)
				local var_369_32 = arg_366_1:FormatText(var_369_31.content)

				arg_366_1.text_.text = var_369_32

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_33 = 26
				local var_369_34 = utf8.len(var_369_32)
				local var_369_35 = var_369_33 <= 0 and var_369_28 or var_369_28 * (var_369_34 / var_369_33)

				if var_369_35 > 0 and var_369_28 < var_369_35 then
					arg_366_1.talkMaxDuration = var_369_35
					var_369_27 = var_369_27 + 0.3

					if var_369_35 + var_369_27 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_35 + var_369_27
					end
				end

				arg_366_1.text_.text = var_369_32
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401088", "story_v_side_new_1109401.awb") ~= 0 then
					local var_369_36 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401088", "story_v_side_new_1109401.awb") / 1000

					if var_369_36 + var_369_27 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_36 + var_369_27
					end

					if var_369_31.prefab_name ~= "" and arg_366_1.actors_[var_369_31.prefab_name] ~= nil then
						local var_369_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_31.prefab_name].transform, "story_v_side_new_1109401", "1109401088", "story_v_side_new_1109401.awb")

						arg_366_1:RecordAudio("1109401088", var_369_37)
						arg_366_1:RecordAudio("1109401088", var_369_37)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401088", "story_v_side_new_1109401.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401088", "story_v_side_new_1109401.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_38 = var_369_27 + 0.3
			local var_369_39 = math.max(var_369_28, arg_366_1.talkMaxDuration)

			if var_369_38 <= arg_366_1.time_ and arg_366_1.time_ < var_369_38 + var_369_39 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_38) / var_369_39

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_38 + var_369_39 and arg_366_1.time_ < var_369_38 + var_369_39 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1109401089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109401089
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109401090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.45

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_2 = arg_372_1:GetWordFromCfg(1109401089)
				local var_375_3 = arg_372_1:FormatText(var_375_2.content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 18
				local var_375_5 = utf8.len(var_375_3)
				local var_375_6 = var_375_4 <= 0 and var_375_1 or var_375_1 * (var_375_5 / var_375_4)

				if var_375_6 > 0 and var_375_1 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_7 and arg_372_1.time_ < var_375_0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109401090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109401090
		arg_376_1.duration_ = 2.97

		local var_376_0 = {
			ja = 2.5,
			ko = 2.966,
			zh = 2.966
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109401091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1094ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1094ui_story = var_379_0.localPosition
			end

			local var_379_2 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2
				local var_379_4 = Vector3.New(0, -0.84, -6.1)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1094ui_story, var_379_4, var_379_3)

				local var_379_5 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_5.x, var_379_5.y, var_379_5.z)

				local var_379_6 = var_379_0.localEulerAngles

				var_379_6.z = 0
				var_379_6.x = 0
				var_379_0.localEulerAngles = var_379_6
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_379_7 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_7.x, var_379_7.y, var_379_7.z)

				local var_379_8 = var_379_0.localEulerAngles

				var_379_8.z = 0
				var_379_8.x = 0
				var_379_0.localEulerAngles = var_379_8
			end

			local var_379_9 = arg_376_1.actors_["1094ui_story"]
			local var_379_10 = 0

			if var_379_10 < arg_376_1.time_ and arg_376_1.time_ <= var_379_10 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect1094ui_story == nil then
				arg_376_1.var_.characterEffect1094ui_story = var_379_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_11 = 0.200000002980232

			if var_379_10 <= arg_376_1.time_ and arg_376_1.time_ < var_379_10 + var_379_11 and not isNil(var_379_9) then
				local var_379_12 = (arg_376_1.time_ - var_379_10) / var_379_11

				if arg_376_1.var_.characterEffect1094ui_story and not isNil(var_379_9) then
					arg_376_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_10 + var_379_11 and arg_376_1.time_ < var_379_10 + var_379_11 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect1094ui_story then
				arg_376_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_379_13 = 0

			if var_379_13 < arg_376_1.time_ and arg_376_1.time_ <= var_379_13 + arg_379_0 then
				arg_376_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_379_14 = 0

			if var_379_14 < arg_376_1.time_ and arg_376_1.time_ <= var_379_14 + arg_379_0 then
				arg_376_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_379_15 = 0
			local var_379_16 = 0.275

			if var_379_15 < arg_376_1.time_ and arg_376_1.time_ <= var_379_15 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_17 = arg_376_1:FormatText(StoryNameCfg[181].name)

				arg_376_1.leftNameTxt_.text = var_379_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_18 = arg_376_1:GetWordFromCfg(1109401090)
				local var_379_19 = arg_376_1:FormatText(var_379_18.content)

				arg_376_1.text_.text = var_379_19

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_20 = 11
				local var_379_21 = utf8.len(var_379_19)
				local var_379_22 = var_379_20 <= 0 and var_379_16 or var_379_16 * (var_379_21 / var_379_20)

				if var_379_22 > 0 and var_379_16 < var_379_22 then
					arg_376_1.talkMaxDuration = var_379_22

					if var_379_22 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_22 + var_379_15
					end
				end

				arg_376_1.text_.text = var_379_19
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401090", "story_v_side_new_1109401.awb") ~= 0 then
					local var_379_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401090", "story_v_side_new_1109401.awb") / 1000

					if var_379_23 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_23 + var_379_15
					end

					if var_379_18.prefab_name ~= "" and arg_376_1.actors_[var_379_18.prefab_name] ~= nil then
						local var_379_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_18.prefab_name].transform, "story_v_side_new_1109401", "1109401090", "story_v_side_new_1109401.awb")

						arg_376_1:RecordAudio("1109401090", var_379_24)
						arg_376_1:RecordAudio("1109401090", var_379_24)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401090", "story_v_side_new_1109401.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401090", "story_v_side_new_1109401.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_25 = math.max(var_379_16, arg_376_1.talkMaxDuration)

			if var_379_15 <= arg_376_1.time_ and arg_376_1.time_ < var_379_15 + var_379_25 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_15) / var_379_25

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_15 + var_379_25 and arg_376_1.time_ < var_379_15 + var_379_25 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109401091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109401091
		arg_380_1.duration_ = 7.27

		local var_380_0 = {
			ja = 5.3,
			ko = 7.266,
			zh = 7.266
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109401092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1094ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1094ui_story == nil then
				arg_380_1.var_.characterEffect1094ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect1094ui_story and not isNil(var_383_0) then
					local var_383_4 = Mathf.Lerp(0, 0.5, var_383_3)

					arg_380_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1094ui_story.fillRatio = var_383_4
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1094ui_story then
				local var_383_5 = 0.5

				arg_380_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1094ui_story.fillRatio = var_383_5
			end

			local var_383_6 = 0
			local var_383_7 = 0.875

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[177].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_9 = arg_380_1:GetWordFromCfg(1109401091)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 35
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401091", "story_v_side_new_1109401.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401091", "story_v_side_new_1109401.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_side_new_1109401", "1109401091", "story_v_side_new_1109401.awb")

						arg_380_1:RecordAudio("1109401091", var_383_15)
						arg_380_1:RecordAudio("1109401091", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401091", "story_v_side_new_1109401.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401091", "story_v_side_new_1109401.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_16 and arg_380_1.time_ < var_383_6 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109401092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109401092
		arg_384_1.duration_ = 4.47

		local var_384_0 = {
			ja = 3.533,
			ko = 4.466,
			zh = 4.466
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109401093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.575

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[177].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(1109401092)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 23
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401092", "story_v_side_new_1109401.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401092", "story_v_side_new_1109401.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_side_new_1109401", "1109401092", "story_v_side_new_1109401.awb")

						arg_384_1:RecordAudio("1109401092", var_387_9)
						arg_384_1:RecordAudio("1109401092", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401092", "story_v_side_new_1109401.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401092", "story_v_side_new_1109401.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109401093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109401093
		arg_388_1.duration_ = 2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109401094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1094ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos1094ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, -0.84, -6.1)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1094ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["1094ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1094ui_story == nil then
				arg_388_1.var_.characterEffect1094ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect1094ui_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1094ui_story then
				arg_388_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_391_13 = 0

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_391_14 = 0
			local var_391_15 = 0.125

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_16 = arg_388_1:FormatText(StoryNameCfg[181].name)

				arg_388_1.leftNameTxt_.text = var_391_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_17 = arg_388_1:GetWordFromCfg(1109401093)
				local var_391_18 = arg_388_1:FormatText(var_391_17.content)

				arg_388_1.text_.text = var_391_18

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_19 = 5
				local var_391_20 = utf8.len(var_391_18)
				local var_391_21 = var_391_19 <= 0 and var_391_15 or var_391_15 * (var_391_20 / var_391_19)

				if var_391_21 > 0 and var_391_15 < var_391_21 then
					arg_388_1.talkMaxDuration = var_391_21

					if var_391_21 + var_391_14 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_14
					end
				end

				arg_388_1.text_.text = var_391_18
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401093", "story_v_side_new_1109401.awb") ~= 0 then
					local var_391_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401093", "story_v_side_new_1109401.awb") / 1000

					if var_391_22 + var_391_14 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_14
					end

					if var_391_17.prefab_name ~= "" and arg_388_1.actors_[var_391_17.prefab_name] ~= nil then
						local var_391_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_17.prefab_name].transform, "story_v_side_new_1109401", "1109401093", "story_v_side_new_1109401.awb")

						arg_388_1:RecordAudio("1109401093", var_391_23)
						arg_388_1:RecordAudio("1109401093", var_391_23)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401093", "story_v_side_new_1109401.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401093", "story_v_side_new_1109401.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_24 = math.max(var_391_15, arg_388_1.talkMaxDuration)

			if var_391_14 <= arg_388_1.time_ and arg_388_1.time_ < var_391_14 + var_391_24 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_14) / var_391_24

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_14 + var_391_24 and arg_388_1.time_ < var_391_14 + var_391_24 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109401094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1109401094
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1109401095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1094ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1094ui_story == nil then
				arg_392_1.var_.characterEffect1094ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1094ui_story and not isNil(var_395_0) then
					local var_395_4 = Mathf.Lerp(0, 0.5, var_395_3)

					arg_392_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1094ui_story.fillRatio = var_395_4
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1094ui_story then
				local var_395_5 = 0.5

				arg_392_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1094ui_story.fillRatio = var_395_5
			end

			local var_395_6 = arg_392_1.actors_["1094ui_story"].transform
			local var_395_7 = 0

			if var_395_7 < arg_392_1.time_ and arg_392_1.time_ <= var_395_7 + arg_395_0 then
				arg_392_1.var_.moveOldPos1094ui_story = var_395_6.localPosition
			end

			local var_395_8 = 0.001

			if var_395_7 <= arg_392_1.time_ and arg_392_1.time_ < var_395_7 + var_395_8 then
				local var_395_9 = (arg_392_1.time_ - var_395_7) / var_395_8
				local var_395_10 = Vector3.New(0, 100, 0)

				var_395_6.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1094ui_story, var_395_10, var_395_9)

				local var_395_11 = manager.ui.mainCamera.transform.position - var_395_6.position

				var_395_6.forward = Vector3.New(var_395_11.x, var_395_11.y, var_395_11.z)

				local var_395_12 = var_395_6.localEulerAngles

				var_395_12.z = 0
				var_395_12.x = 0
				var_395_6.localEulerAngles = var_395_12
			end

			if arg_392_1.time_ >= var_395_7 + var_395_8 and arg_392_1.time_ < var_395_7 + var_395_8 + arg_395_0 then
				var_395_6.localPosition = Vector3.New(0, 100, 0)

				local var_395_13 = manager.ui.mainCamera.transform.position - var_395_6.position

				var_395_6.forward = Vector3.New(var_395_13.x, var_395_13.y, var_395_13.z)

				local var_395_14 = var_395_6.localEulerAngles

				var_395_14.z = 0
				var_395_14.x = 0
				var_395_6.localEulerAngles = var_395_14
			end

			local var_395_15 = 0
			local var_395_16 = 0.825

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_17 = arg_392_1:GetWordFromCfg(1109401094)
				local var_395_18 = arg_392_1:FormatText(var_395_17.content)

				arg_392_1.text_.text = var_395_18

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_19 = 33
				local var_395_20 = utf8.len(var_395_18)
				local var_395_21 = var_395_19 <= 0 and var_395_16 or var_395_16 * (var_395_20 / var_395_19)

				if var_395_21 > 0 and var_395_16 < var_395_21 then
					arg_392_1.talkMaxDuration = var_395_21

					if var_395_21 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_21 + var_395_15
					end
				end

				arg_392_1.text_.text = var_395_18
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_22 = math.max(var_395_16, arg_392_1.talkMaxDuration)

			if var_395_15 <= arg_392_1.time_ and arg_392_1.time_ < var_395_15 + var_395_22 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_15) / var_395_22

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_15 + var_395_22 and arg_392_1.time_ < var_395_15 + var_395_22 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play1109401095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1109401095
		arg_396_1.duration_ = 4.13

		local var_396_0 = {
			ja = 4.133,
			ko = 2.833,
			zh = 2.833
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1109401096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1094ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1094ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, -0.84, -6.1)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1094ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = arg_396_1.actors_["1094ui_story"]
			local var_399_10 = 0

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1094ui_story == nil then
				arg_396_1.var_.characterEffect1094ui_story = var_399_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_11 and not isNil(var_399_9) then
				local var_399_12 = (arg_396_1.time_ - var_399_10) / var_399_11

				if arg_396_1.var_.characterEffect1094ui_story and not isNil(var_399_9) then
					arg_396_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_10 + var_399_11 and arg_396_1.time_ < var_399_10 + var_399_11 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1094ui_story then
				arg_396_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_399_13 = 0

			if var_399_13 < arg_396_1.time_ and arg_396_1.time_ <= var_399_13 + arg_399_0 then
				arg_396_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_399_14 = 0
			local var_399_15 = 0.4

			if var_399_14 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_16 = arg_396_1:FormatText(StoryNameCfg[181].name)

				arg_396_1.leftNameTxt_.text = var_399_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_17 = arg_396_1:GetWordFromCfg(1109401095)
				local var_399_18 = arg_396_1:FormatText(var_399_17.content)

				arg_396_1.text_.text = var_399_18

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_19 = 16
				local var_399_20 = utf8.len(var_399_18)
				local var_399_21 = var_399_19 <= 0 and var_399_15 or var_399_15 * (var_399_20 / var_399_19)

				if var_399_21 > 0 and var_399_15 < var_399_21 then
					arg_396_1.talkMaxDuration = var_399_21

					if var_399_21 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_21 + var_399_14
					end
				end

				arg_396_1.text_.text = var_399_18
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401095", "story_v_side_new_1109401.awb") ~= 0 then
					local var_399_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401095", "story_v_side_new_1109401.awb") / 1000

					if var_399_22 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_22 + var_399_14
					end

					if var_399_17.prefab_name ~= "" and arg_396_1.actors_[var_399_17.prefab_name] ~= nil then
						local var_399_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_17.prefab_name].transform, "story_v_side_new_1109401", "1109401095", "story_v_side_new_1109401.awb")

						arg_396_1:RecordAudio("1109401095", var_399_23)
						arg_396_1:RecordAudio("1109401095", var_399_23)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401095", "story_v_side_new_1109401.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401095", "story_v_side_new_1109401.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_24 = math.max(var_399_15, arg_396_1.talkMaxDuration)

			if var_399_14 <= arg_396_1.time_ and arg_396_1.time_ < var_399_14 + var_399_24 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_14) / var_399_24

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_14 + var_399_24 and arg_396_1.time_ < var_399_14 + var_399_24 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play1109401096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1109401096
		arg_400_1.duration_ = 7.2

		local var_400_0 = {
			ja = 7.2,
			ko = 5.5,
			zh = 5.5
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1109401097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1094ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1094ui_story == nil then
				arg_400_1.var_.characterEffect1094ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect1094ui_story and not isNil(var_403_0) then
					local var_403_4 = Mathf.Lerp(0, 0.5, var_403_3)

					arg_400_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1094ui_story.fillRatio = var_403_4
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1094ui_story then
				local var_403_5 = 0.5

				arg_400_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1094ui_story.fillRatio = var_403_5
			end

			local var_403_6 = 0
			local var_403_7 = 0.675

			if var_403_6 < arg_400_1.time_ and arg_400_1.time_ <= var_403_6 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_8 = arg_400_1:FormatText(StoryNameCfg[177].name)

				arg_400_1.leftNameTxt_.text = var_403_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_9 = arg_400_1:GetWordFromCfg(1109401096)
				local var_403_10 = arg_400_1:FormatText(var_403_9.content)

				arg_400_1.text_.text = var_403_10

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_11 = 27
				local var_403_12 = utf8.len(var_403_10)
				local var_403_13 = var_403_11 <= 0 and var_403_7 or var_403_7 * (var_403_12 / var_403_11)

				if var_403_13 > 0 and var_403_7 < var_403_13 then
					arg_400_1.talkMaxDuration = var_403_13

					if var_403_13 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_13 + var_403_6
					end
				end

				arg_400_1.text_.text = var_403_10
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401096", "story_v_side_new_1109401.awb") ~= 0 then
					local var_403_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401096", "story_v_side_new_1109401.awb") / 1000

					if var_403_14 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_14 + var_403_6
					end

					if var_403_9.prefab_name ~= "" and arg_400_1.actors_[var_403_9.prefab_name] ~= nil then
						local var_403_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_9.prefab_name].transform, "story_v_side_new_1109401", "1109401096", "story_v_side_new_1109401.awb")

						arg_400_1:RecordAudio("1109401096", var_403_15)
						arg_400_1:RecordAudio("1109401096", var_403_15)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401096", "story_v_side_new_1109401.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401096", "story_v_side_new_1109401.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_16 = math.max(var_403_7, arg_400_1.talkMaxDuration)

			if var_403_6 <= arg_400_1.time_ and arg_400_1.time_ < var_403_6 + var_403_16 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_6) / var_403_16

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_6 + var_403_16 and arg_400_1.time_ < var_403_6 + var_403_16 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1109401097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1109401097
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1109401098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1094ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1094ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(0, -0.84, -6.1)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1094ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["1094ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1094ui_story == nil then
				arg_404_1.var_.characterEffect1094ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect1094ui_story and not isNil(var_407_9) then
					arg_404_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1094ui_story then
				arg_404_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_407_13 = 0

			if var_407_13 < arg_404_1.time_ and arg_404_1.time_ <= var_407_13 + arg_407_0 then
				arg_404_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_407_14 = 0
			local var_407_15 = 0.075

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_16 = arg_404_1:FormatText(StoryNameCfg[181].name)

				arg_404_1.leftNameTxt_.text = var_407_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_17 = arg_404_1:GetWordFromCfg(1109401097)
				local var_407_18 = arg_404_1:FormatText(var_407_17.content)

				arg_404_1.text_.text = var_407_18

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_19 = 3
				local var_407_20 = utf8.len(var_407_18)
				local var_407_21 = var_407_19 <= 0 and var_407_15 or var_407_15 * (var_407_20 / var_407_19)

				if var_407_21 > 0 and var_407_15 < var_407_21 then
					arg_404_1.talkMaxDuration = var_407_21

					if var_407_21 + var_407_14 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_21 + var_407_14
					end
				end

				arg_404_1.text_.text = var_407_18
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401097", "story_v_side_new_1109401.awb") ~= 0 then
					local var_407_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401097", "story_v_side_new_1109401.awb") / 1000

					if var_407_22 + var_407_14 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_22 + var_407_14
					end

					if var_407_17.prefab_name ~= "" and arg_404_1.actors_[var_407_17.prefab_name] ~= nil then
						local var_407_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_17.prefab_name].transform, "story_v_side_new_1109401", "1109401097", "story_v_side_new_1109401.awb")

						arg_404_1:RecordAudio("1109401097", var_407_23)
						arg_404_1:RecordAudio("1109401097", var_407_23)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401097", "story_v_side_new_1109401.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401097", "story_v_side_new_1109401.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_24 = math.max(var_407_15, arg_404_1.talkMaxDuration)

			if var_407_14 <= arg_404_1.time_ and arg_404_1.time_ < var_407_14 + var_407_24 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_14) / var_407_24

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_14 + var_407_24 and arg_404_1.time_ < var_407_14 + var_407_24 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1109401098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1109401098
		arg_408_1.duration_ = 7.5

		local var_408_0 = {
			ja = 7.5,
			ko = 4.266,
			zh = 4.266
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1109401099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1094ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1094ui_story == nil then
				arg_408_1.var_.characterEffect1094ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1094ui_story and not isNil(var_411_0) then
					local var_411_4 = Mathf.Lerp(0, 0.5, var_411_3)

					arg_408_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1094ui_story.fillRatio = var_411_4
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1094ui_story then
				local var_411_5 = 0.5

				arg_408_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1094ui_story.fillRatio = var_411_5
			end

			local var_411_6 = 0
			local var_411_7 = 0.55

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_8 = arg_408_1:FormatText(StoryNameCfg[177].name)

				arg_408_1.leftNameTxt_.text = var_411_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_9 = arg_408_1:GetWordFromCfg(1109401098)
				local var_411_10 = arg_408_1:FormatText(var_411_9.content)

				arg_408_1.text_.text = var_411_10

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_11 = 22
				local var_411_12 = utf8.len(var_411_10)
				local var_411_13 = var_411_11 <= 0 and var_411_7 or var_411_7 * (var_411_12 / var_411_11)

				if var_411_13 > 0 and var_411_7 < var_411_13 then
					arg_408_1.talkMaxDuration = var_411_13

					if var_411_13 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_13 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_10
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401098", "story_v_side_new_1109401.awb") ~= 0 then
					local var_411_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401098", "story_v_side_new_1109401.awb") / 1000

					if var_411_14 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_6
					end

					if var_411_9.prefab_name ~= "" and arg_408_1.actors_[var_411_9.prefab_name] ~= nil then
						local var_411_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_9.prefab_name].transform, "story_v_side_new_1109401", "1109401098", "story_v_side_new_1109401.awb")

						arg_408_1:RecordAudio("1109401098", var_411_15)
						arg_408_1:RecordAudio("1109401098", var_411_15)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401098", "story_v_side_new_1109401.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401098", "story_v_side_new_1109401.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_16 and arg_408_1.time_ < var_411_6 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1109401099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1109401099
		arg_412_1.duration_ = 2

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1109401100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1094ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1094ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -0.84, -6.1)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1094ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["1094ui_story"]
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1094ui_story == nil then
				arg_412_1.var_.characterEffect1094ui_story = var_415_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 and not isNil(var_415_9) then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11

				if arg_412_1.var_.characterEffect1094ui_story and not isNil(var_415_9) then
					arg_412_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1094ui_story then
				arg_412_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_415_13 = 0

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_415_14 = 0
			local var_415_15 = 0.05

			if var_415_14 < arg_412_1.time_ and arg_412_1.time_ <= var_415_14 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_16 = arg_412_1:FormatText(StoryNameCfg[181].name)

				arg_412_1.leftNameTxt_.text = var_415_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_17 = arg_412_1:GetWordFromCfg(1109401099)
				local var_415_18 = arg_412_1:FormatText(var_415_17.content)

				arg_412_1.text_.text = var_415_18

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_19 = 2
				local var_415_20 = utf8.len(var_415_18)
				local var_415_21 = var_415_19 <= 0 and var_415_15 or var_415_15 * (var_415_20 / var_415_19)

				if var_415_21 > 0 and var_415_15 < var_415_21 then
					arg_412_1.talkMaxDuration = var_415_21

					if var_415_21 + var_415_14 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_21 + var_415_14
					end
				end

				arg_412_1.text_.text = var_415_18
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401099", "story_v_side_new_1109401.awb") ~= 0 then
					local var_415_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401099", "story_v_side_new_1109401.awb") / 1000

					if var_415_22 + var_415_14 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_14
					end

					if var_415_17.prefab_name ~= "" and arg_412_1.actors_[var_415_17.prefab_name] ~= nil then
						local var_415_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_17.prefab_name].transform, "story_v_side_new_1109401", "1109401099", "story_v_side_new_1109401.awb")

						arg_412_1:RecordAudio("1109401099", var_415_23)
						arg_412_1:RecordAudio("1109401099", var_415_23)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401099", "story_v_side_new_1109401.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401099", "story_v_side_new_1109401.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_24 = math.max(var_415_15, arg_412_1.talkMaxDuration)

			if var_415_14 <= arg_412_1.time_ and arg_412_1.time_ < var_415_14 + var_415_24 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_14) / var_415_24

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_14 + var_415_24 and arg_412_1.time_ < var_415_14 + var_415_24 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1109401100
		arg_416_1.duration_ = 6.4

		local var_416_0 = {
			ja = 6.4,
			ko = 4.2,
			zh = 4.2
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
				arg_416_0:Play1109401101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1094ui_story"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1094ui_story == nil then
				arg_416_1.var_.characterEffect1094ui_story = var_419_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.characterEffect1094ui_story and not isNil(var_419_0) then
					local var_419_4 = Mathf.Lerp(0, 0.5, var_419_3)

					arg_416_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1094ui_story.fillRatio = var_419_4
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1094ui_story then
				local var_419_5 = 0.5

				arg_416_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1094ui_story.fillRatio = var_419_5
			end

			local var_419_6 = 0
			local var_419_7 = 0.5

			if var_419_6 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_8 = arg_416_1:FormatText(StoryNameCfg[177].name)

				arg_416_1.leftNameTxt_.text = var_419_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_9 = arg_416_1:GetWordFromCfg(1109401100)
				local var_419_10 = arg_416_1:FormatText(var_419_9.content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 20
				local var_419_12 = utf8.len(var_419_10)
				local var_419_13 = var_419_11 <= 0 and var_419_7 or var_419_7 * (var_419_12 / var_419_11)

				if var_419_13 > 0 and var_419_7 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_10
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401100", "story_v_side_new_1109401.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401100", "story_v_side_new_1109401.awb") / 1000

					if var_419_14 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_6
					end

					if var_419_9.prefab_name ~= "" and arg_416_1.actors_[var_419_9.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_9.prefab_name].transform, "story_v_side_new_1109401", "1109401100", "story_v_side_new_1109401.awb")

						arg_416_1:RecordAudio("1109401100", var_419_15)
						arg_416_1:RecordAudio("1109401100", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401100", "story_v_side_new_1109401.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401100", "story_v_side_new_1109401.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_16 and arg_416_1.time_ < var_419_6 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1109401101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1109401101
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1109401102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.65

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_2 = arg_420_1:GetWordFromCfg(1109401101)
				local var_423_3 = arg_420_1:FormatText(var_423_2.content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 26
				local var_423_5 = utf8.len(var_423_3)
				local var_423_6 = var_423_4 <= 0 and var_423_1 or var_423_1 * (var_423_5 / var_423_4)

				if var_423_6 > 0 and var_423_1 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_7 and arg_420_1.time_ < var_423_0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1109401102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1109401102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1109401103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_427_1 = 0
			local var_427_2 = 0.675

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_3 = arg_424_1:GetWordFromCfg(1109401102)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 27
				local var_427_6 = utf8.len(var_427_4)
				local var_427_7 = var_427_5 <= 0 and var_427_2 or var_427_2 * (var_427_6 / var_427_5)

				if var_427_7 > 0 and var_427_2 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_8 and arg_424_1.time_ < var_427_1 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1109401103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1109401103
		arg_428_1.duration_ = 2

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1109401104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1094ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1094ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0, -0.84, -6.1)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1094ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = arg_428_1.actors_["1094ui_story"]
			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1094ui_story == nil then
				arg_428_1.var_.characterEffect1094ui_story = var_431_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_11 = 0.200000002980232

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_11 and not isNil(var_431_9) then
				local var_431_12 = (arg_428_1.time_ - var_431_10) / var_431_11

				if arg_428_1.var_.characterEffect1094ui_story and not isNil(var_431_9) then
					arg_428_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_10 + var_431_11 and arg_428_1.time_ < var_431_10 + var_431_11 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1094ui_story then
				arg_428_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_431_13 = 0

			if var_431_13 < arg_428_1.time_ and arg_428_1.time_ <= var_431_13 + arg_431_0 then
				arg_428_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_431_14 = 0
			local var_431_15 = 0.15

			if var_431_14 < arg_428_1.time_ and arg_428_1.time_ <= var_431_14 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_16 = arg_428_1:FormatText(StoryNameCfg[181].name)

				arg_428_1.leftNameTxt_.text = var_431_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_17 = arg_428_1:GetWordFromCfg(1109401103)
				local var_431_18 = arg_428_1:FormatText(var_431_17.content)

				arg_428_1.text_.text = var_431_18

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_19 = 6
				local var_431_20 = utf8.len(var_431_18)
				local var_431_21 = var_431_19 <= 0 and var_431_15 or var_431_15 * (var_431_20 / var_431_19)

				if var_431_21 > 0 and var_431_15 < var_431_21 then
					arg_428_1.talkMaxDuration = var_431_21

					if var_431_21 + var_431_14 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_21 + var_431_14
					end
				end

				arg_428_1.text_.text = var_431_18
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401103", "story_v_side_new_1109401.awb") ~= 0 then
					local var_431_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401103", "story_v_side_new_1109401.awb") / 1000

					if var_431_22 + var_431_14 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_22 + var_431_14
					end

					if var_431_17.prefab_name ~= "" and arg_428_1.actors_[var_431_17.prefab_name] ~= nil then
						local var_431_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_17.prefab_name].transform, "story_v_side_new_1109401", "1109401103", "story_v_side_new_1109401.awb")

						arg_428_1:RecordAudio("1109401103", var_431_23)
						arg_428_1:RecordAudio("1109401103", var_431_23)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401103", "story_v_side_new_1109401.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401103", "story_v_side_new_1109401.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_24 = math.max(var_431_15, arg_428_1.talkMaxDuration)

			if var_431_14 <= arg_428_1.time_ and arg_428_1.time_ < var_431_14 + var_431_24 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_14) / var_431_24

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_14 + var_431_24 and arg_428_1.time_ < var_431_14 + var_431_24 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1109401104
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1109401105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1094ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1094ui_story == nil then
				arg_432_1.var_.characterEffect1094ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1094ui_story and not isNil(var_435_0) then
					local var_435_4 = Mathf.Lerp(0, 0.5, var_435_3)

					arg_432_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1094ui_story.fillRatio = var_435_4
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1094ui_story then
				local var_435_5 = 0.5

				arg_432_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1094ui_story.fillRatio = var_435_5
			end

			local var_435_6 = 0
			local var_435_7 = 0.4

			if var_435_6 < arg_432_1.time_ and arg_432_1.time_ <= var_435_6 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_8 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_9 = arg_432_1:GetWordFromCfg(1109401104)
				local var_435_10 = arg_432_1:FormatText(var_435_9.content)

				arg_432_1.text_.text = var_435_10

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_11 = 16
				local var_435_12 = utf8.len(var_435_10)
				local var_435_13 = var_435_11 <= 0 and var_435_7 or var_435_7 * (var_435_12 / var_435_11)

				if var_435_13 > 0 and var_435_7 < var_435_13 then
					arg_432_1.talkMaxDuration = var_435_13

					if var_435_13 + var_435_6 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_6
					end
				end

				arg_432_1.text_.text = var_435_10
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_14 = math.max(var_435_7, arg_432_1.talkMaxDuration)

			if var_435_6 <= arg_432_1.time_ and arg_432_1.time_ < var_435_6 + var_435_14 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_6) / var_435_14

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_6 + var_435_14 and arg_432_1.time_ < var_435_6 + var_435_14 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1109401105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1109401105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1109401106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 0.525

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_2 = arg_436_1:GetWordFromCfg(1109401105)
				local var_439_3 = arg_436_1:FormatText(var_439_2.content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 21
				local var_439_5 = utf8.len(var_439_3)
				local var_439_6 = var_439_4 <= 0 and var_439_1 or var_439_1 * (var_439_5 / var_439_4)

				if var_439_6 > 0 and var_439_1 < var_439_6 then
					arg_436_1.talkMaxDuration = var_439_6

					if var_439_6 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_7 and arg_436_1.time_ < var_439_0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1109401106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1109401106
		arg_440_1.duration_ = 3.87

		local var_440_0 = {
			ja = 3.866,
			ko = 3.066,
			zh = 3.066
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1109401107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1094ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1094ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(0, -0.84, -6.1)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1094ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1094ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1094ui_story == nil then
				arg_440_1.var_.characterEffect1094ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.200000002980232

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1094ui_story and not isNil(var_443_9) then
					arg_440_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1094ui_story then
				arg_440_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_443_13 = 0

			if var_443_13 < arg_440_1.time_ and arg_440_1.time_ <= var_443_13 + arg_443_0 then
				arg_440_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_443_14 = 0
			local var_443_15 = 0.325

			if var_443_14 < arg_440_1.time_ and arg_440_1.time_ <= var_443_14 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_16 = arg_440_1:FormatText(StoryNameCfg[181].name)

				arg_440_1.leftNameTxt_.text = var_443_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_17 = arg_440_1:GetWordFromCfg(1109401106)
				local var_443_18 = arg_440_1:FormatText(var_443_17.content)

				arg_440_1.text_.text = var_443_18

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_19 = 13
				local var_443_20 = utf8.len(var_443_18)
				local var_443_21 = var_443_19 <= 0 and var_443_15 or var_443_15 * (var_443_20 / var_443_19)

				if var_443_21 > 0 and var_443_15 < var_443_21 then
					arg_440_1.talkMaxDuration = var_443_21

					if var_443_21 + var_443_14 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_21 + var_443_14
					end
				end

				arg_440_1.text_.text = var_443_18
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401106", "story_v_side_new_1109401.awb") ~= 0 then
					local var_443_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401106", "story_v_side_new_1109401.awb") / 1000

					if var_443_22 + var_443_14 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_22 + var_443_14
					end

					if var_443_17.prefab_name ~= "" and arg_440_1.actors_[var_443_17.prefab_name] ~= nil then
						local var_443_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_17.prefab_name].transform, "story_v_side_new_1109401", "1109401106", "story_v_side_new_1109401.awb")

						arg_440_1:RecordAudio("1109401106", var_443_23)
						arg_440_1:RecordAudio("1109401106", var_443_23)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401106", "story_v_side_new_1109401.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401106", "story_v_side_new_1109401.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_24 = math.max(var_443_15, arg_440_1.talkMaxDuration)

			if var_443_14 <= arg_440_1.time_ and arg_440_1.time_ < var_443_14 + var_443_24 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_14) / var_443_24

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_14 + var_443_24 and arg_440_1.time_ < var_443_14 + var_443_24 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1109401107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1109401107
		arg_444_1.duration_ = 15.2

		local var_444_0 = {
			ja = 15.2,
			ko = 11.4,
			zh = 11.4
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
				arg_444_0:Play1109401108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1094ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1094ui_story == nil then
				arg_444_1.var_.characterEffect1094ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1094ui_story and not isNil(var_447_0) then
					local var_447_4 = Mathf.Lerp(0, 0.5, var_447_3)

					arg_444_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1094ui_story.fillRatio = var_447_4
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1094ui_story then
				local var_447_5 = 0.5

				arg_444_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1094ui_story.fillRatio = var_447_5
			end

			local var_447_6 = 0
			local var_447_7 = 1.375

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_8 = arg_444_1:FormatText(StoryNameCfg[177].name)

				arg_444_1.leftNameTxt_.text = var_447_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_9 = arg_444_1:GetWordFromCfg(1109401107)
				local var_447_10 = arg_444_1:FormatText(var_447_9.content)

				arg_444_1.text_.text = var_447_10

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 76
				local var_447_12 = utf8.len(var_447_10)
				local var_447_13 = var_447_11 <= 0 and var_447_7 or var_447_7 * (var_447_12 / var_447_11)

				if var_447_13 > 0 and var_447_7 < var_447_13 then
					arg_444_1.talkMaxDuration = var_447_13

					if var_447_13 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_13 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_10
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401107", "story_v_side_new_1109401.awb") ~= 0 then
					local var_447_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401107", "story_v_side_new_1109401.awb") / 1000

					if var_447_14 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_14 + var_447_6
					end

					if var_447_9.prefab_name ~= "" and arg_444_1.actors_[var_447_9.prefab_name] ~= nil then
						local var_447_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_9.prefab_name].transform, "story_v_side_new_1109401", "1109401107", "story_v_side_new_1109401.awb")

						arg_444_1:RecordAudio("1109401107", var_447_15)
						arg_444_1:RecordAudio("1109401107", var_447_15)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401107", "story_v_side_new_1109401.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401107", "story_v_side_new_1109401.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_16 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_16 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_16

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_16 and arg_444_1.time_ < var_447_6 + var_447_16 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1109401108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1109401108
		arg_448_1.duration_ = 4.9

		local var_448_0 = {
			ja = 4.9,
			ko = 4.266,
			zh = 4.266
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1109401109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1094ui_story"].transform
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.var_.moveOldPos1094ui_story = var_451_0.localPosition
			end

			local var_451_2 = 0.001

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2
				local var_451_4 = Vector3.New(0, -0.84, -6.1)

				var_451_0.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1094ui_story, var_451_4, var_451_3)

				local var_451_5 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_5.x, var_451_5.y, var_451_5.z)

				local var_451_6 = var_451_0.localEulerAngles

				var_451_6.z = 0
				var_451_6.x = 0
				var_451_0.localEulerAngles = var_451_6
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 then
				var_451_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_451_7 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_7.x, var_451_7.y, var_451_7.z)

				local var_451_8 = var_451_0.localEulerAngles

				var_451_8.z = 0
				var_451_8.x = 0
				var_451_0.localEulerAngles = var_451_8
			end

			local var_451_9 = arg_448_1.actors_["1094ui_story"]
			local var_451_10 = 0

			if var_451_10 < arg_448_1.time_ and arg_448_1.time_ <= var_451_10 + arg_451_0 and not isNil(var_451_9) and arg_448_1.var_.characterEffect1094ui_story == nil then
				arg_448_1.var_.characterEffect1094ui_story = var_451_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_11 = 0.200000002980232

			if var_451_10 <= arg_448_1.time_ and arg_448_1.time_ < var_451_10 + var_451_11 and not isNil(var_451_9) then
				local var_451_12 = (arg_448_1.time_ - var_451_10) / var_451_11

				if arg_448_1.var_.characterEffect1094ui_story and not isNil(var_451_9) then
					arg_448_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_10 + var_451_11 and arg_448_1.time_ < var_451_10 + var_451_11 + arg_451_0 and not isNil(var_451_9) and arg_448_1.var_.characterEffect1094ui_story then
				arg_448_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_451_13 = 0

			if var_451_13 < arg_448_1.time_ and arg_448_1.time_ <= var_451_13 + arg_451_0 then
				arg_448_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_451_14 = 0
			local var_451_15 = 0.375

			if var_451_14 < arg_448_1.time_ and arg_448_1.time_ <= var_451_14 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_16 = arg_448_1:FormatText(StoryNameCfg[181].name)

				arg_448_1.leftNameTxt_.text = var_451_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_17 = arg_448_1:GetWordFromCfg(1109401108)
				local var_451_18 = arg_448_1:FormatText(var_451_17.content)

				arg_448_1.text_.text = var_451_18

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_19 = 15
				local var_451_20 = utf8.len(var_451_18)
				local var_451_21 = var_451_19 <= 0 and var_451_15 or var_451_15 * (var_451_20 / var_451_19)

				if var_451_21 > 0 and var_451_15 < var_451_21 then
					arg_448_1.talkMaxDuration = var_451_21

					if var_451_21 + var_451_14 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_21 + var_451_14
					end
				end

				arg_448_1.text_.text = var_451_18
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401108", "story_v_side_new_1109401.awb") ~= 0 then
					local var_451_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401108", "story_v_side_new_1109401.awb") / 1000

					if var_451_22 + var_451_14 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_22 + var_451_14
					end

					if var_451_17.prefab_name ~= "" and arg_448_1.actors_[var_451_17.prefab_name] ~= nil then
						local var_451_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_17.prefab_name].transform, "story_v_side_new_1109401", "1109401108", "story_v_side_new_1109401.awb")

						arg_448_1:RecordAudio("1109401108", var_451_23)
						arg_448_1:RecordAudio("1109401108", var_451_23)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401108", "story_v_side_new_1109401.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401108", "story_v_side_new_1109401.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_24 = math.max(var_451_15, arg_448_1.talkMaxDuration)

			if var_451_14 <= arg_448_1.time_ and arg_448_1.time_ < var_451_14 + var_451_24 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_14) / var_451_24

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_14 + var_451_24 and arg_448_1.time_ < var_451_14 + var_451_24 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1109401109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1109401109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1109401110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1094ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1094ui_story == nil then
				arg_452_1.var_.characterEffect1094ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect1094ui_story and not isNil(var_455_0) then
					local var_455_4 = Mathf.Lerp(0, 0.5, var_455_3)

					arg_452_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1094ui_story.fillRatio = var_455_4
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1094ui_story then
				local var_455_5 = 0.5

				arg_452_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1094ui_story.fillRatio = var_455_5
			end

			local var_455_6 = 0
			local var_455_7 = 0.625

			if var_455_6 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_8 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_9 = arg_452_1:GetWordFromCfg(1109401109)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 19
				local var_455_12 = utf8.len(var_455_10)
				local var_455_13 = var_455_11 <= 0 and var_455_7 or var_455_7 * (var_455_12 / var_455_11)

				if var_455_13 > 0 and var_455_7 < var_455_13 then
					arg_452_1.talkMaxDuration = var_455_13

					if var_455_13 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1109401110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1109401110
		arg_456_1.duration_ = 2.3

		local var_456_0 = {
			ja = 1.999999999999,
			ko = 2.3,
			zh = 2.3
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
				arg_456_0:Play1109401111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1094ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1094ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(0, -0.84, -6.1)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1094ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["1094ui_story"]
			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1094ui_story == nil then
				arg_456_1.var_.characterEffect1094ui_story = var_459_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_11 = 0.200000002980232

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 and not isNil(var_459_9) then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11

				if arg_456_1.var_.characterEffect1094ui_story and not isNil(var_459_9) then
					arg_456_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1094ui_story then
				arg_456_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_459_13 = 0

			if var_459_13 < arg_456_1.time_ and arg_456_1.time_ <= var_459_13 + arg_459_0 then
				arg_456_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_459_14 = 0
			local var_459_15 = 0.15

			if var_459_14 < arg_456_1.time_ and arg_456_1.time_ <= var_459_14 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_16 = arg_456_1:FormatText(StoryNameCfg[181].name)

				arg_456_1.leftNameTxt_.text = var_459_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_17 = arg_456_1:GetWordFromCfg(1109401110)
				local var_459_18 = arg_456_1:FormatText(var_459_17.content)

				arg_456_1.text_.text = var_459_18

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_19 = 6
				local var_459_20 = utf8.len(var_459_18)
				local var_459_21 = var_459_19 <= 0 and var_459_15 or var_459_15 * (var_459_20 / var_459_19)

				if var_459_21 > 0 and var_459_15 < var_459_21 then
					arg_456_1.talkMaxDuration = var_459_21

					if var_459_21 + var_459_14 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_21 + var_459_14
					end
				end

				arg_456_1.text_.text = var_459_18
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401110", "story_v_side_new_1109401.awb") ~= 0 then
					local var_459_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401110", "story_v_side_new_1109401.awb") / 1000

					if var_459_22 + var_459_14 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_22 + var_459_14
					end

					if var_459_17.prefab_name ~= "" and arg_456_1.actors_[var_459_17.prefab_name] ~= nil then
						local var_459_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_17.prefab_name].transform, "story_v_side_new_1109401", "1109401110", "story_v_side_new_1109401.awb")

						arg_456_1:RecordAudio("1109401110", var_459_23)
						arg_456_1:RecordAudio("1109401110", var_459_23)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401110", "story_v_side_new_1109401.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401110", "story_v_side_new_1109401.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_24 = math.max(var_459_15, arg_456_1.talkMaxDuration)

			if var_459_14 <= arg_456_1.time_ and arg_456_1.time_ < var_459_14 + var_459_24 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_14) / var_459_24

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_14 + var_459_24 and arg_456_1.time_ < var_459_14 + var_459_24 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1109401111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1109401112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1094ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1094ui_story == nil then
				arg_460_1.var_.characterEffect1094ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect1094ui_story and not isNil(var_463_0) then
					local var_463_4 = Mathf.Lerp(0, 0.5, var_463_3)

					arg_460_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1094ui_story.fillRatio = var_463_4
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1094ui_story then
				local var_463_5 = 0.5

				arg_460_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1094ui_story.fillRatio = var_463_5
			end

			local var_463_6 = 0
			local var_463_7 = 0.425

			if var_463_6 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_8 = arg_460_1:GetWordFromCfg(1109401111)
				local var_463_9 = arg_460_1:FormatText(var_463_8.content)

				arg_460_1.text_.text = var_463_9

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_10 = 17
				local var_463_11 = utf8.len(var_463_9)
				local var_463_12 = var_463_10 <= 0 and var_463_7 or var_463_7 * (var_463_11 / var_463_10)

				if var_463_12 > 0 and var_463_7 < var_463_12 then
					arg_460_1.talkMaxDuration = var_463_12

					if var_463_12 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_12 + var_463_6
					end
				end

				arg_460_1.text_.text = var_463_9
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_13 = math.max(var_463_7, arg_460_1.talkMaxDuration)

			if var_463_6 <= arg_460_1.time_ and arg_460_1.time_ < var_463_6 + var_463_13 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_6) / var_463_13

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_6 + var_463_13 and arg_460_1.time_ < var_463_6 + var_463_13 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1109401112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1109401112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1109401113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.075

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:GetWordFromCfg(1109401112)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 3
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_8 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_8 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_8

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_8 and arg_464_1.time_ < var_467_0 + var_467_8 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1109401113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1109401113
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1109401114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.5

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(1109401113)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 20
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1109401114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1109401114
		arg_472_1.duration_ = 2.17

		local var_472_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_472_0:Play1109401115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1094ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos1094ui_story = var_475_0.localPosition
			end

			local var_475_2 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2
				local var_475_4 = Vector3.New(0, -0.84, -6.1)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1094ui_story, var_475_4, var_475_3)

				local var_475_5 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_5.x, var_475_5.y, var_475_5.z)

				local var_475_6 = var_475_0.localEulerAngles

				var_475_6.z = 0
				var_475_6.x = 0
				var_475_0.localEulerAngles = var_475_6
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_475_7 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_7.x, var_475_7.y, var_475_7.z)

				local var_475_8 = var_475_0.localEulerAngles

				var_475_8.z = 0
				var_475_8.x = 0
				var_475_0.localEulerAngles = var_475_8
			end

			local var_475_9 = arg_472_1.actors_["1094ui_story"]
			local var_475_10 = 0

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect1094ui_story == nil then
				arg_472_1.var_.characterEffect1094ui_story = var_475_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_11 = 0.200000002980232

			if var_475_10 <= arg_472_1.time_ and arg_472_1.time_ < var_475_10 + var_475_11 and not isNil(var_475_9) then
				local var_475_12 = (arg_472_1.time_ - var_475_10) / var_475_11

				if arg_472_1.var_.characterEffect1094ui_story and not isNil(var_475_9) then
					arg_472_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_10 + var_475_11 and arg_472_1.time_ < var_475_10 + var_475_11 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect1094ui_story then
				arg_472_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_475_13 = 0

			if var_475_13 < arg_472_1.time_ and arg_472_1.time_ <= var_475_13 + arg_475_0 then
				arg_472_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_475_14 = 0
			local var_475_15 = 0.15

			if var_475_14 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_16 = arg_472_1:FormatText(StoryNameCfg[181].name)

				arg_472_1.leftNameTxt_.text = var_475_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_17 = arg_472_1:GetWordFromCfg(1109401114)
				local var_475_18 = arg_472_1:FormatText(var_475_17.content)

				arg_472_1.text_.text = var_475_18

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_19 = 6
				local var_475_20 = utf8.len(var_475_18)
				local var_475_21 = var_475_19 <= 0 and var_475_15 or var_475_15 * (var_475_20 / var_475_19)

				if var_475_21 > 0 and var_475_15 < var_475_21 then
					arg_472_1.talkMaxDuration = var_475_21

					if var_475_21 + var_475_14 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_21 + var_475_14
					end
				end

				arg_472_1.text_.text = var_475_18
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401114", "story_v_side_new_1109401.awb") ~= 0 then
					local var_475_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401114", "story_v_side_new_1109401.awb") / 1000

					if var_475_22 + var_475_14 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_22 + var_475_14
					end

					if var_475_17.prefab_name ~= "" and arg_472_1.actors_[var_475_17.prefab_name] ~= nil then
						local var_475_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_17.prefab_name].transform, "story_v_side_new_1109401", "1109401114", "story_v_side_new_1109401.awb")

						arg_472_1:RecordAudio("1109401114", var_475_23)
						arg_472_1:RecordAudio("1109401114", var_475_23)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401114", "story_v_side_new_1109401.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401114", "story_v_side_new_1109401.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_24 = math.max(var_475_15, arg_472_1.talkMaxDuration)

			if var_475_14 <= arg_472_1.time_ and arg_472_1.time_ < var_475_14 + var_475_24 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_14) / var_475_24

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_14 + var_475_24 and arg_472_1.time_ < var_475_14 + var_475_24 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1109401115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109401115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109401116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1094ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1094ui_story == nil then
				arg_476_1.var_.characterEffect1094ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1094ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1094ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1094ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1094ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.075

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_8 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(1109401115)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 3
				local var_479_12 = utf8.len(var_479_10)
				local var_479_13 = var_479_11 <= 0 and var_479_7 or var_479_7 * (var_479_12 / var_479_11)

				if var_479_13 > 0 and var_479_7 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_10
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109401116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1109401116
		arg_480_1.duration_ = 2.27

		local var_480_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1109401117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1094ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos1094ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, -0.84, -6.1)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1094ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = arg_480_1.actors_["1094ui_story"]
			local var_483_10 = 0

			if var_483_10 < arg_480_1.time_ and arg_480_1.time_ <= var_483_10 + arg_483_0 and not isNil(var_483_9) and arg_480_1.var_.characterEffect1094ui_story == nil then
				arg_480_1.var_.characterEffect1094ui_story = var_483_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_11 = 0.200000002980232

			if var_483_10 <= arg_480_1.time_ and arg_480_1.time_ < var_483_10 + var_483_11 and not isNil(var_483_9) then
				local var_483_12 = (arg_480_1.time_ - var_483_10) / var_483_11

				if arg_480_1.var_.characterEffect1094ui_story and not isNil(var_483_9) then
					arg_480_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= var_483_10 + var_483_11 and arg_480_1.time_ < var_483_10 + var_483_11 + arg_483_0 and not isNil(var_483_9) and arg_480_1.var_.characterEffect1094ui_story then
				arg_480_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_483_13 = 0

			if var_483_13 < arg_480_1.time_ and arg_480_1.time_ <= var_483_13 + arg_483_0 then
				arg_480_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_483_14 = 0
			local var_483_15 = 0.175

			if var_483_14 < arg_480_1.time_ and arg_480_1.time_ <= var_483_14 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_16 = arg_480_1:FormatText(StoryNameCfg[181].name)

				arg_480_1.leftNameTxt_.text = var_483_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_17 = arg_480_1:GetWordFromCfg(1109401116)
				local var_483_18 = arg_480_1:FormatText(var_483_17.content)

				arg_480_1.text_.text = var_483_18

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_19 = 7
				local var_483_20 = utf8.len(var_483_18)
				local var_483_21 = var_483_19 <= 0 and var_483_15 or var_483_15 * (var_483_20 / var_483_19)

				if var_483_21 > 0 and var_483_15 < var_483_21 then
					arg_480_1.talkMaxDuration = var_483_21

					if var_483_21 + var_483_14 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_21 + var_483_14
					end
				end

				arg_480_1.text_.text = var_483_18
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401116", "story_v_side_new_1109401.awb") ~= 0 then
					local var_483_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401116", "story_v_side_new_1109401.awb") / 1000

					if var_483_22 + var_483_14 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_22 + var_483_14
					end

					if var_483_17.prefab_name ~= "" and arg_480_1.actors_[var_483_17.prefab_name] ~= nil then
						local var_483_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_17.prefab_name].transform, "story_v_side_new_1109401", "1109401116", "story_v_side_new_1109401.awb")

						arg_480_1:RecordAudio("1109401116", var_483_23)
						arg_480_1:RecordAudio("1109401116", var_483_23)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401116", "story_v_side_new_1109401.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401116", "story_v_side_new_1109401.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_24 = math.max(var_483_15, arg_480_1.talkMaxDuration)

			if var_483_14 <= arg_480_1.time_ and arg_480_1.time_ < var_483_14 + var_483_24 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_14) / var_483_24

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_14 + var_483_24 and arg_480_1.time_ < var_483_14 + var_483_24 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play1109401117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1109401117
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1109401118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1094ui_story"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1094ui_story == nil then
				arg_484_1.var_.characterEffect1094ui_story = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect1094ui_story and not isNil(var_487_0) then
					local var_487_4 = Mathf.Lerp(0, 0.5, var_487_3)

					arg_484_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_484_1.var_.characterEffect1094ui_story.fillRatio = var_487_4
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1094ui_story then
				local var_487_5 = 0.5

				arg_484_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_484_1.var_.characterEffect1094ui_story.fillRatio = var_487_5
			end

			local var_487_6 = 0
			local var_487_7 = 0.625

			if var_487_6 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_8 = arg_484_1:FormatText(StoryNameCfg[7].name)

				arg_484_1.leftNameTxt_.text = var_487_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_9 = arg_484_1:GetWordFromCfg(1109401117)
				local var_487_10 = arg_484_1:FormatText(var_487_9.content)

				arg_484_1.text_.text = var_487_10

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 25
				local var_487_12 = utf8.len(var_487_10)
				local var_487_13 = var_487_11 <= 0 and var_487_7 or var_487_7 * (var_487_12 / var_487_11)

				if var_487_13 > 0 and var_487_7 < var_487_13 then
					arg_484_1.talkMaxDuration = var_487_13

					if var_487_13 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_13 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_10
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_14 and arg_484_1.time_ < var_487_6 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1109401118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1109401118
		arg_488_1.duration_ = 7.2

		local var_488_0 = {
			ja = 7.2,
			ko = 2.966,
			zh = 2.966
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
				arg_488_0:Play1109401119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1094ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1094ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, -0.84, -6.1)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1094ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = arg_488_1.actors_["1094ui_story"]
			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1094ui_story == nil then
				arg_488_1.var_.characterEffect1094ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.200000002980232

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect1094ui_story and not isNil(var_491_9) then
					arg_488_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1094ui_story then
				arg_488_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_491_13 = 0

			if var_491_13 < arg_488_1.time_ and arg_488_1.time_ <= var_491_13 + arg_491_0 then
				arg_488_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_491_14 = 0

			if var_491_14 < arg_488_1.time_ and arg_488_1.time_ <= var_491_14 + arg_491_0 then
				arg_488_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_491_15 = 0
			local var_491_16 = 0.4

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_17 = arg_488_1:FormatText(StoryNameCfg[181].name)

				arg_488_1.leftNameTxt_.text = var_491_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_18 = arg_488_1:GetWordFromCfg(1109401118)
				local var_491_19 = arg_488_1:FormatText(var_491_18.content)

				arg_488_1.text_.text = var_491_19

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401118", "story_v_side_new_1109401.awb") ~= 0 then
					local var_491_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401118", "story_v_side_new_1109401.awb") / 1000

					if var_491_23 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_23 + var_491_15
					end

					if var_491_18.prefab_name ~= "" and arg_488_1.actors_[var_491_18.prefab_name] ~= nil then
						local var_491_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_18.prefab_name].transform, "story_v_side_new_1109401", "1109401118", "story_v_side_new_1109401.awb")

						arg_488_1:RecordAudio("1109401118", var_491_24)
						arg_488_1:RecordAudio("1109401118", var_491_24)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401118", "story_v_side_new_1109401.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401118", "story_v_side_new_1109401.awb")
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
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play1109401119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1109401119
		arg_492_1.duration_ = 2

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1109401120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1094ui_story"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos1094ui_story = var_495_0.localPosition
			end

			local var_495_2 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2
				local var_495_4 = Vector3.New(0, -0.84, -6.1)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1094ui_story, var_495_4, var_495_3)

				local var_495_5 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_5.x, var_495_5.y, var_495_5.z)

				local var_495_6 = var_495_0.localEulerAngles

				var_495_6.z = 0
				var_495_6.x = 0
				var_495_0.localEulerAngles = var_495_6
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_495_7 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_7.x, var_495_7.y, var_495_7.z)

				local var_495_8 = var_495_0.localEulerAngles

				var_495_8.z = 0
				var_495_8.x = 0
				var_495_0.localEulerAngles = var_495_8
			end

			local var_495_9 = 0

			if var_495_9 < arg_492_1.time_ and arg_492_1.time_ <= var_495_9 + arg_495_0 then
				arg_492_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_495_10 = 0
			local var_495_11 = 0.125

			if var_495_10 < arg_492_1.time_ and arg_492_1.time_ <= var_495_10 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_12 = arg_492_1:FormatText(StoryNameCfg[181].name)

				arg_492_1.leftNameTxt_.text = var_495_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_13 = arg_492_1:GetWordFromCfg(1109401119)
				local var_495_14 = arg_492_1:FormatText(var_495_13.content)

				arg_492_1.text_.text = var_495_14

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_15 = 5
				local var_495_16 = utf8.len(var_495_14)
				local var_495_17 = var_495_15 <= 0 and var_495_11 or var_495_11 * (var_495_16 / var_495_15)

				if var_495_17 > 0 and var_495_11 < var_495_17 then
					arg_492_1.talkMaxDuration = var_495_17

					if var_495_17 + var_495_10 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_17 + var_495_10
					end
				end

				arg_492_1.text_.text = var_495_14
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401119", "story_v_side_new_1109401.awb") ~= 0 then
					local var_495_18 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401119", "story_v_side_new_1109401.awb") / 1000

					if var_495_18 + var_495_10 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_18 + var_495_10
					end

					if var_495_13.prefab_name ~= "" and arg_492_1.actors_[var_495_13.prefab_name] ~= nil then
						local var_495_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_13.prefab_name].transform, "story_v_side_new_1109401", "1109401119", "story_v_side_new_1109401.awb")

						arg_492_1:RecordAudio("1109401119", var_495_19)
						arg_492_1:RecordAudio("1109401119", var_495_19)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401119", "story_v_side_new_1109401.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401119", "story_v_side_new_1109401.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_20 = math.max(var_495_11, arg_492_1.talkMaxDuration)

			if var_495_10 <= arg_492_1.time_ and arg_492_1.time_ < var_495_10 + var_495_20 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_10) / var_495_20

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_10 + var_495_20 and arg_492_1.time_ < var_495_10 + var_495_20 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1109401120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1109401120
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1109401121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1094ui_story"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.characterEffect1094ui_story == nil then
				arg_496_1.var_.characterEffect1094ui_story = var_499_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_2 = 0.200000002980232

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.characterEffect1094ui_story and not isNil(var_499_0) then
					local var_499_4 = Mathf.Lerp(0, 0.5, var_499_3)

					arg_496_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1094ui_story.fillRatio = var_499_4
				end
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.characterEffect1094ui_story then
				local var_499_5 = 0.5

				arg_496_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1094ui_story.fillRatio = var_499_5
			end

			local var_499_6 = manager.ui.mainCamera.transform
			local var_499_7 = 0

			if var_499_7 < arg_496_1.time_ and arg_496_1.time_ <= var_499_7 + arg_499_0 then
				arg_496_1.var_.shakeOldPos = var_499_6.localPosition
			end

			local var_499_8 = 0.075

			if var_499_7 <= arg_496_1.time_ and arg_496_1.time_ < var_499_7 + var_499_8 then
				local var_499_9 = (arg_496_1.time_ - var_499_7) / 0.066
				local var_499_10, var_499_11 = math.modf(var_499_9)

				var_499_6.localPosition = Vector3.New(var_499_11 * 0.13, var_499_11 * 0.13, var_499_11 * 0.13) + arg_496_1.var_.shakeOldPos
			end

			if arg_496_1.time_ >= var_499_7 + var_499_8 and arg_496_1.time_ < var_499_7 + var_499_8 + arg_499_0 then
				var_499_6.localPosition = arg_496_1.var_.shakeOldPos
			end

			local var_499_12 = 0
			local var_499_13 = 0.075

			if var_499_12 < arg_496_1.time_ and arg_496_1.time_ <= var_499_12 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_14 = arg_496_1:FormatText(StoryNameCfg[7].name)

				arg_496_1.leftNameTxt_.text = var_499_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_15 = arg_496_1:GetWordFromCfg(1109401120)
				local var_499_16 = arg_496_1:FormatText(var_499_15.content)

				arg_496_1.text_.text = var_499_16

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_17 = 3
				local var_499_18 = utf8.len(var_499_16)
				local var_499_19 = var_499_17 <= 0 and var_499_13 or var_499_13 * (var_499_18 / var_499_17)

				if var_499_19 > 0 and var_499_13 < var_499_19 then
					arg_496_1.talkMaxDuration = var_499_19

					if var_499_19 + var_499_12 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_19 + var_499_12
					end
				end

				arg_496_1.text_.text = var_499_16
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_20 = math.max(var_499_13, arg_496_1.talkMaxDuration)

			if var_499_12 <= arg_496_1.time_ and arg_496_1.time_ < var_499_12 + var_499_20 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_12) / var_499_20

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_12 + var_499_20 and arg_496_1.time_ < var_499_12 + var_499_20 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1109401121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1109401121
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1109401122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.9

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_2 = arg_500_1:GetWordFromCfg(1109401121)
				local var_503_3 = arg_500_1:FormatText(var_503_2.content)

				arg_500_1.text_.text = var_503_3

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 36
				local var_503_5 = utf8.len(var_503_3)
				local var_503_6 = var_503_4 <= 0 and var_503_1 or var_503_1 * (var_503_5 / var_503_4)

				if var_503_6 > 0 and var_503_1 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_3
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_7 and arg_500_1.time_ < var_503_0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1109401122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1109401122
		arg_504_1.duration_ = 4.87

		local var_504_0 = {
			ja = 4.866,
			ko = 3.666,
			zh = 3.666
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1109401123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.475

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[177].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(1109401122)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 19
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401122", "story_v_side_new_1109401.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401122", "story_v_side_new_1109401.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_side_new_1109401", "1109401122", "story_v_side_new_1109401.awb")

						arg_504_1:RecordAudio("1109401122", var_507_9)
						arg_504_1:RecordAudio("1109401122", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401122", "story_v_side_new_1109401.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401122", "story_v_side_new_1109401.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1109401123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1109401123
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1109401124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.25

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:GetWordFromCfg(1109401123)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 10
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
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_8 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_8 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_8

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_8 and arg_508_1.time_ < var_511_0 + var_511_8 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1109401124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1109401124
		arg_512_1.duration_ = 1.33

		local var_512_0 = {
			ja = 1.333,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1109401125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.075

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_2 = arg_512_1:FormatText(StoryNameCfg[177].name)

				arg_512_1.leftNameTxt_.text = var_515_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_3 = arg_512_1:GetWordFromCfg(1109401124)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 3
				local var_515_6 = utf8.len(var_515_4)
				local var_515_7 = var_515_5 <= 0 and var_515_1 or var_515_1 * (var_515_6 / var_515_5)

				if var_515_7 > 0 and var_515_1 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_4
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401124", "story_v_side_new_1109401.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401124", "story_v_side_new_1109401.awb") / 1000

					if var_515_8 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_0
					end

					if var_515_3.prefab_name ~= "" and arg_512_1.actors_[var_515_3.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_3.prefab_name].transform, "story_v_side_new_1109401", "1109401124", "story_v_side_new_1109401.awb")

						arg_512_1:RecordAudio("1109401124", var_515_9)
						arg_512_1:RecordAudio("1109401124", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401124", "story_v_side_new_1109401.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401124", "story_v_side_new_1109401.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_10 and arg_512_1.time_ < var_515_0 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1109401125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1109401125
		arg_516_1.duration_ = 2

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1109401126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1094ui_story"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos1094ui_story = var_519_0.localPosition
			end

			local var_519_2 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2
				local var_519_4 = Vector3.New(0, -0.84, -6.1)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1094ui_story, var_519_4, var_519_3)

				local var_519_5 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_5.x, var_519_5.y, var_519_5.z)

				local var_519_6 = var_519_0.localEulerAngles

				var_519_6.z = 0
				var_519_6.x = 0
				var_519_0.localEulerAngles = var_519_6
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_519_7 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_7.x, var_519_7.y, var_519_7.z)

				local var_519_8 = var_519_0.localEulerAngles

				var_519_8.z = 0
				var_519_8.x = 0
				var_519_0.localEulerAngles = var_519_8
			end

			local var_519_9 = arg_516_1.actors_["1094ui_story"]
			local var_519_10 = 0

			if var_519_10 < arg_516_1.time_ and arg_516_1.time_ <= var_519_10 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect1094ui_story == nil then
				arg_516_1.var_.characterEffect1094ui_story = var_519_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_11 = 0.200000002980232

			if var_519_10 <= arg_516_1.time_ and arg_516_1.time_ < var_519_10 + var_519_11 and not isNil(var_519_9) then
				local var_519_12 = (arg_516_1.time_ - var_519_10) / var_519_11

				if arg_516_1.var_.characterEffect1094ui_story and not isNil(var_519_9) then
					arg_516_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_10 + var_519_11 and arg_516_1.time_ < var_519_10 + var_519_11 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect1094ui_story then
				arg_516_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_519_13 = 0

			if var_519_13 < arg_516_1.time_ and arg_516_1.time_ <= var_519_13 + arg_519_0 then
				arg_516_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_519_14 = 0

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_519_15 = 0
			local var_519_16 = 0.175

			if var_519_15 < arg_516_1.time_ and arg_516_1.time_ <= var_519_15 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_17 = arg_516_1:FormatText(StoryNameCfg[181].name)

				arg_516_1.leftNameTxt_.text = var_519_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_18 = arg_516_1:GetWordFromCfg(1109401125)
				local var_519_19 = arg_516_1:FormatText(var_519_18.content)

				arg_516_1.text_.text = var_519_19

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_20 = 7
				local var_519_21 = utf8.len(var_519_19)
				local var_519_22 = var_519_20 <= 0 and var_519_16 or var_519_16 * (var_519_21 / var_519_20)

				if var_519_22 > 0 and var_519_16 < var_519_22 then
					arg_516_1.talkMaxDuration = var_519_22

					if var_519_22 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_22 + var_519_15
					end
				end

				arg_516_1.text_.text = var_519_19
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401125", "story_v_side_new_1109401.awb") ~= 0 then
					local var_519_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401125", "story_v_side_new_1109401.awb") / 1000

					if var_519_23 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_23 + var_519_15
					end

					if var_519_18.prefab_name ~= "" and arg_516_1.actors_[var_519_18.prefab_name] ~= nil then
						local var_519_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_18.prefab_name].transform, "story_v_side_new_1109401", "1109401125", "story_v_side_new_1109401.awb")

						arg_516_1:RecordAudio("1109401125", var_519_24)
						arg_516_1:RecordAudio("1109401125", var_519_24)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401125", "story_v_side_new_1109401.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401125", "story_v_side_new_1109401.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_25 = math.max(var_519_16, arg_516_1.talkMaxDuration)

			if var_519_15 <= arg_516_1.time_ and arg_516_1.time_ < var_519_15 + var_519_25 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_15) / var_519_25

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_15 + var_519_25 and arg_516_1.time_ < var_519_15 + var_519_25 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401126 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1109401126
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1109401127(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["1094ui_story"]
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.characterEffect1094ui_story == nil then
				arg_520_1.var_.characterEffect1094ui_story = var_523_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_2 = 0.200000002980232

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 and not isNil(var_523_0) then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2

				if arg_520_1.var_.characterEffect1094ui_story and not isNil(var_523_0) then
					local var_523_4 = Mathf.Lerp(0, 0.5, var_523_3)

					arg_520_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_520_1.var_.characterEffect1094ui_story.fillRatio = var_523_4
				end
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.characterEffect1094ui_story then
				local var_523_5 = 0.5

				arg_520_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_520_1.var_.characterEffect1094ui_story.fillRatio = var_523_5
			end

			local var_523_6 = 0
			local var_523_7 = 0.55

			if var_523_6 < arg_520_1.time_ and arg_520_1.time_ <= var_523_6 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_8 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_9 = arg_520_1:GetWordFromCfg(1109401126)
				local var_523_10 = arg_520_1:FormatText(var_523_9.content)

				arg_520_1.text_.text = var_523_10

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_11 = 22
				local var_523_12 = utf8.len(var_523_10)
				local var_523_13 = var_523_11 <= 0 and var_523_7 or var_523_7 * (var_523_12 / var_523_11)

				if var_523_13 > 0 and var_523_7 < var_523_13 then
					arg_520_1.talkMaxDuration = var_523_13

					if var_523_13 + var_523_6 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_13 + var_523_6
					end
				end

				arg_520_1.text_.text = var_523_10
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_14 = math.max(var_523_7, arg_520_1.talkMaxDuration)

			if var_523_6 <= arg_520_1.time_ and arg_520_1.time_ < var_523_6 + var_523_14 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_6) / var_523_14

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_6 + var_523_14 and arg_520_1.time_ < var_523_6 + var_523_14 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1109401127 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1109401127
		arg_524_1.duration_ = 6.67

		local var_524_0 = {
			ja = 6.666,
			ko = 4.066,
			zh = 4.066
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
				arg_524_0:Play1109401128(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1094ui_story"].transform
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.var_.moveOldPos1094ui_story = var_527_0.localPosition
			end

			local var_527_2 = 0.001

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2
				local var_527_4 = Vector3.New(0, -0.84, -6.1)

				var_527_0.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1094ui_story, var_527_4, var_527_3)

				local var_527_5 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_5.x, var_527_5.y, var_527_5.z)

				local var_527_6 = var_527_0.localEulerAngles

				var_527_6.z = 0
				var_527_6.x = 0
				var_527_0.localEulerAngles = var_527_6
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 then
				var_527_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_527_7 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_7.x, var_527_7.y, var_527_7.z)

				local var_527_8 = var_527_0.localEulerAngles

				var_527_8.z = 0
				var_527_8.x = 0
				var_527_0.localEulerAngles = var_527_8
			end

			local var_527_9 = arg_524_1.actors_["1094ui_story"]
			local var_527_10 = 0

			if var_527_10 < arg_524_1.time_ and arg_524_1.time_ <= var_527_10 + arg_527_0 and not isNil(var_527_9) and arg_524_1.var_.characterEffect1094ui_story == nil then
				arg_524_1.var_.characterEffect1094ui_story = var_527_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_11 = 0.200000002980232

			if var_527_10 <= arg_524_1.time_ and arg_524_1.time_ < var_527_10 + var_527_11 and not isNil(var_527_9) then
				local var_527_12 = (arg_524_1.time_ - var_527_10) / var_527_11

				if arg_524_1.var_.characterEffect1094ui_story and not isNil(var_527_9) then
					arg_524_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= var_527_10 + var_527_11 and arg_524_1.time_ < var_527_10 + var_527_11 + arg_527_0 and not isNil(var_527_9) and arg_524_1.var_.characterEffect1094ui_story then
				arg_524_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_527_13 = 0

			if var_527_13 < arg_524_1.time_ and arg_524_1.time_ <= var_527_13 + arg_527_0 then
				arg_524_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_527_14 = 0
			local var_527_15 = 0.425

			if var_527_14 < arg_524_1.time_ and arg_524_1.time_ <= var_527_14 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_16 = arg_524_1:FormatText(StoryNameCfg[181].name)

				arg_524_1.leftNameTxt_.text = var_527_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_17 = arg_524_1:GetWordFromCfg(1109401127)
				local var_527_18 = arg_524_1:FormatText(var_527_17.content)

				arg_524_1.text_.text = var_527_18

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_19 = 17
				local var_527_20 = utf8.len(var_527_18)
				local var_527_21 = var_527_19 <= 0 and var_527_15 or var_527_15 * (var_527_20 / var_527_19)

				if var_527_21 > 0 and var_527_15 < var_527_21 then
					arg_524_1.talkMaxDuration = var_527_21

					if var_527_21 + var_527_14 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_21 + var_527_14
					end
				end

				arg_524_1.text_.text = var_527_18
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401127", "story_v_side_new_1109401.awb") ~= 0 then
					local var_527_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401127", "story_v_side_new_1109401.awb") / 1000

					if var_527_22 + var_527_14 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_22 + var_527_14
					end

					if var_527_17.prefab_name ~= "" and arg_524_1.actors_[var_527_17.prefab_name] ~= nil then
						local var_527_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_17.prefab_name].transform, "story_v_side_new_1109401", "1109401127", "story_v_side_new_1109401.awb")

						arg_524_1:RecordAudio("1109401127", var_527_23)
						arg_524_1:RecordAudio("1109401127", var_527_23)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401127", "story_v_side_new_1109401.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401127", "story_v_side_new_1109401.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_24 = math.max(var_527_15, arg_524_1.talkMaxDuration)

			if var_527_14 <= arg_524_1.time_ and arg_524_1.time_ < var_527_14 + var_527_24 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_14) / var_527_24

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_14 + var_527_24 and arg_524_1.time_ < var_527_14 + var_527_24 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play1109401128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1109401128
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1109401129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1094ui_story"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1094ui_story == nil then
				arg_528_1.var_.characterEffect1094ui_story = var_531_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_2 = 0.200000002980232

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.characterEffect1094ui_story and not isNil(var_531_0) then
					local var_531_4 = Mathf.Lerp(0, 0.5, var_531_3)

					arg_528_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_528_1.var_.characterEffect1094ui_story.fillRatio = var_531_4
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1094ui_story then
				local var_531_5 = 0.5

				arg_528_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_528_1.var_.characterEffect1094ui_story.fillRatio = var_531_5
			end

			local var_531_6 = 0
			local var_531_7 = 0.725

			if var_531_6 < arg_528_1.time_ and arg_528_1.time_ <= var_531_6 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_8 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_9 = arg_528_1:GetWordFromCfg(1109401128)
				local var_531_10 = arg_528_1:FormatText(var_531_9.content)

				arg_528_1.text_.text = var_531_10

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_11 = 29
				local var_531_12 = utf8.len(var_531_10)
				local var_531_13 = var_531_11 <= 0 and var_531_7 or var_531_7 * (var_531_12 / var_531_11)

				if var_531_13 > 0 and var_531_7 < var_531_13 then
					arg_528_1.talkMaxDuration = var_531_13

					if var_531_13 + var_531_6 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_13 + var_531_6
					end
				end

				arg_528_1.text_.text = var_531_10
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_14 = math.max(var_531_7, arg_528_1.talkMaxDuration)

			if var_531_6 <= arg_528_1.time_ and arg_528_1.time_ < var_531_6 + var_531_14 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_6) / var_531_14

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_6 + var_531_14 and arg_528_1.time_ < var_531_6 + var_531_14 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1109401129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1109401129
		arg_532_1.duration_ = 4.83

		local var_532_0 = {
			ja = 4.833,
			ko = 2.3,
			zh = 2.3
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
				arg_532_0:Play1109401130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["1094ui_story"].transform
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.var_.moveOldPos1094ui_story = var_535_0.localPosition
			end

			local var_535_2 = 0.001

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2
				local var_535_4 = Vector3.New(0, -0.84, -6.1)

				var_535_0.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1094ui_story, var_535_4, var_535_3)

				local var_535_5 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_5.x, var_535_5.y, var_535_5.z)

				local var_535_6 = var_535_0.localEulerAngles

				var_535_6.z = 0
				var_535_6.x = 0
				var_535_0.localEulerAngles = var_535_6
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 then
				var_535_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_535_7 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_7.x, var_535_7.y, var_535_7.z)

				local var_535_8 = var_535_0.localEulerAngles

				var_535_8.z = 0
				var_535_8.x = 0
				var_535_0.localEulerAngles = var_535_8
			end

			local var_535_9 = arg_532_1.actors_["1094ui_story"]
			local var_535_10 = 0

			if var_535_10 < arg_532_1.time_ and arg_532_1.time_ <= var_535_10 + arg_535_0 and not isNil(var_535_9) and arg_532_1.var_.characterEffect1094ui_story == nil then
				arg_532_1.var_.characterEffect1094ui_story = var_535_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_11 = 0.200000002980232

			if var_535_10 <= arg_532_1.time_ and arg_532_1.time_ < var_535_10 + var_535_11 and not isNil(var_535_9) then
				local var_535_12 = (arg_532_1.time_ - var_535_10) / var_535_11

				if arg_532_1.var_.characterEffect1094ui_story and not isNil(var_535_9) then
					arg_532_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_532_1.time_ >= var_535_10 + var_535_11 and arg_532_1.time_ < var_535_10 + var_535_11 + arg_535_0 and not isNil(var_535_9) and arg_532_1.var_.characterEffect1094ui_story then
				arg_532_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_535_13 = 0

			if var_535_13 < arg_532_1.time_ and arg_532_1.time_ <= var_535_13 + arg_535_0 then
				arg_532_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_535_14 = 0
			local var_535_15 = 0.2

			if var_535_14 < arg_532_1.time_ and arg_532_1.time_ <= var_535_14 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_16 = arg_532_1:FormatText(StoryNameCfg[181].name)

				arg_532_1.leftNameTxt_.text = var_535_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_17 = arg_532_1:GetWordFromCfg(1109401129)
				local var_535_18 = arg_532_1:FormatText(var_535_17.content)

				arg_532_1.text_.text = var_535_18

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_19 = 8
				local var_535_20 = utf8.len(var_535_18)
				local var_535_21 = var_535_19 <= 0 and var_535_15 or var_535_15 * (var_535_20 / var_535_19)

				if var_535_21 > 0 and var_535_15 < var_535_21 then
					arg_532_1.talkMaxDuration = var_535_21

					if var_535_21 + var_535_14 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_21 + var_535_14
					end
				end

				arg_532_1.text_.text = var_535_18
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401129", "story_v_side_new_1109401.awb") ~= 0 then
					local var_535_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401129", "story_v_side_new_1109401.awb") / 1000

					if var_535_22 + var_535_14 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_22 + var_535_14
					end

					if var_535_17.prefab_name ~= "" and arg_532_1.actors_[var_535_17.prefab_name] ~= nil then
						local var_535_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_17.prefab_name].transform, "story_v_side_new_1109401", "1109401129", "story_v_side_new_1109401.awb")

						arg_532_1:RecordAudio("1109401129", var_535_23)
						arg_532_1:RecordAudio("1109401129", var_535_23)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401129", "story_v_side_new_1109401.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401129", "story_v_side_new_1109401.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_24 = math.max(var_535_15, arg_532_1.talkMaxDuration)

			if var_535_14 <= arg_532_1.time_ and arg_532_1.time_ < var_535_14 + var_535_24 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_14) / var_535_24

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_14 + var_535_24 and arg_532_1.time_ < var_535_14 + var_535_24 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play1109401130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1109401130
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1109401131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1094ui_story"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1094ui_story == nil then
				arg_536_1.var_.characterEffect1094ui_story = var_539_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.characterEffect1094ui_story and not isNil(var_539_0) then
					local var_539_4 = Mathf.Lerp(0, 0.5, var_539_3)

					arg_536_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1094ui_story.fillRatio = var_539_4
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1094ui_story then
				local var_539_5 = 0.5

				arg_536_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1094ui_story.fillRatio = var_539_5
			end

			local var_539_6 = 0
			local var_539_7 = 0.7

			if var_539_6 < arg_536_1.time_ and arg_536_1.time_ <= var_539_6 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_8 = arg_536_1:FormatText(StoryNameCfg[7].name)

				arg_536_1.leftNameTxt_.text = var_539_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_9 = arg_536_1:GetWordFromCfg(1109401130)
				local var_539_10 = arg_536_1:FormatText(var_539_9.content)

				arg_536_1.text_.text = var_539_10

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_11 = 32
				local var_539_12 = utf8.len(var_539_10)
				local var_539_13 = var_539_11 <= 0 and var_539_7 or var_539_7 * (var_539_12 / var_539_11)

				if var_539_13 > 0 and var_539_7 < var_539_13 then
					arg_536_1.talkMaxDuration = var_539_13

					if var_539_13 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_13 + var_539_6
					end
				end

				arg_536_1.text_.text = var_539_10
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_14 = math.max(var_539_7, arg_536_1.talkMaxDuration)

			if var_539_6 <= arg_536_1.time_ and arg_536_1.time_ < var_539_6 + var_539_14 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_6) / var_539_14

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_6 + var_539_14 and arg_536_1.time_ < var_539_6 + var_539_14 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1109401131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1109401131
		arg_540_1.duration_ = 2

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1109401132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1094ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos1094ui_story = var_543_0.localPosition
			end

			local var_543_2 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2
				local var_543_4 = Vector3.New(0, -0.84, -6.1)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1094ui_story, var_543_4, var_543_3)

				local var_543_5 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_5.x, var_543_5.y, var_543_5.z)

				local var_543_6 = var_543_0.localEulerAngles

				var_543_6.z = 0
				var_543_6.x = 0
				var_543_0.localEulerAngles = var_543_6
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_543_7 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_7.x, var_543_7.y, var_543_7.z)

				local var_543_8 = var_543_0.localEulerAngles

				var_543_8.z = 0
				var_543_8.x = 0
				var_543_0.localEulerAngles = var_543_8
			end

			local var_543_9 = arg_540_1.actors_["1094ui_story"]
			local var_543_10 = 0

			if var_543_10 < arg_540_1.time_ and arg_540_1.time_ <= var_543_10 + arg_543_0 and not isNil(var_543_9) and arg_540_1.var_.characterEffect1094ui_story == nil then
				arg_540_1.var_.characterEffect1094ui_story = var_543_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_11 = 0.200000002980232

			if var_543_10 <= arg_540_1.time_ and arg_540_1.time_ < var_543_10 + var_543_11 and not isNil(var_543_9) then
				local var_543_12 = (arg_540_1.time_ - var_543_10) / var_543_11

				if arg_540_1.var_.characterEffect1094ui_story and not isNil(var_543_9) then
					arg_540_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_540_1.time_ >= var_543_10 + var_543_11 and arg_540_1.time_ < var_543_10 + var_543_11 + arg_543_0 and not isNil(var_543_9) and arg_540_1.var_.characterEffect1094ui_story then
				arg_540_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_543_13 = 0

			if var_543_13 < arg_540_1.time_ and arg_540_1.time_ <= var_543_13 + arg_543_0 then
				arg_540_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_543_14 = 0

			if var_543_14 < arg_540_1.time_ and arg_540_1.time_ <= var_543_14 + arg_543_0 then
				arg_540_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_543_15 = 0
			local var_543_16 = 0.1

			if var_543_15 < arg_540_1.time_ and arg_540_1.time_ <= var_543_15 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_17 = arg_540_1:FormatText(StoryNameCfg[181].name)

				arg_540_1.leftNameTxt_.text = var_543_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_18 = arg_540_1:GetWordFromCfg(1109401131)
				local var_543_19 = arg_540_1:FormatText(var_543_18.content)

				arg_540_1.text_.text = var_543_19

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_20 = 4
				local var_543_21 = utf8.len(var_543_19)
				local var_543_22 = var_543_20 <= 0 and var_543_16 or var_543_16 * (var_543_21 / var_543_20)

				if var_543_22 > 0 and var_543_16 < var_543_22 then
					arg_540_1.talkMaxDuration = var_543_22

					if var_543_22 + var_543_15 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_22 + var_543_15
					end
				end

				arg_540_1.text_.text = var_543_19
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401131", "story_v_side_new_1109401.awb") ~= 0 then
					local var_543_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401131", "story_v_side_new_1109401.awb") / 1000

					if var_543_23 + var_543_15 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_23 + var_543_15
					end

					if var_543_18.prefab_name ~= "" and arg_540_1.actors_[var_543_18.prefab_name] ~= nil then
						local var_543_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_18.prefab_name].transform, "story_v_side_new_1109401", "1109401131", "story_v_side_new_1109401.awb")

						arg_540_1:RecordAudio("1109401131", var_543_24)
						arg_540_1:RecordAudio("1109401131", var_543_24)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401131", "story_v_side_new_1109401.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401131", "story_v_side_new_1109401.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_25 = math.max(var_543_16, arg_540_1.talkMaxDuration)

			if var_543_15 <= arg_540_1.time_ and arg_540_1.time_ < var_543_15 + var_543_25 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_15) / var_543_25

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_15 + var_543_25 and arg_540_1.time_ < var_543_15 + var_543_25 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1109401132
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1109401133(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1094ui_story"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1094ui_story == nil then
				arg_544_1.var_.characterEffect1094ui_story = var_547_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.200000002980232

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.characterEffect1094ui_story and not isNil(var_547_0) then
					local var_547_4 = Mathf.Lerp(0, 0.5, var_547_3)

					arg_544_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_544_1.var_.characterEffect1094ui_story.fillRatio = var_547_4
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1094ui_story then
				local var_547_5 = 0.5

				arg_544_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_544_1.var_.characterEffect1094ui_story.fillRatio = var_547_5
			end

			local var_547_6 = 0
			local var_547_7 = 0.625

			if var_547_6 < arg_544_1.time_ and arg_544_1.time_ <= var_547_6 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_8 = arg_544_1:FormatText(StoryNameCfg[7].name)

				arg_544_1.leftNameTxt_.text = var_547_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_9 = arg_544_1:GetWordFromCfg(1109401132)
				local var_547_10 = arg_544_1:FormatText(var_547_9.content)

				arg_544_1.text_.text = var_547_10

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_11 = 25
				local var_547_12 = utf8.len(var_547_10)
				local var_547_13 = var_547_11 <= 0 and var_547_7 or var_547_7 * (var_547_12 / var_547_11)

				if var_547_13 > 0 and var_547_7 < var_547_13 then
					arg_544_1.talkMaxDuration = var_547_13

					if var_547_13 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_13 + var_547_6
					end
				end

				arg_544_1.text_.text = var_547_10
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_14 = math.max(var_547_7, arg_544_1.talkMaxDuration)

			if var_547_6 <= arg_544_1.time_ and arg_544_1.time_ < var_547_6 + var_547_14 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_6) / var_547_14

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_6 + var_547_14 and arg_544_1.time_ < var_547_6 + var_547_14 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1109401133 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1109401133
		arg_548_1.duration_ = 2.4

		local var_548_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_548_0:Play1109401134(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1094ui_story"].transform
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.var_.moveOldPos1094ui_story = var_551_0.localPosition
			end

			local var_551_2 = 0.001

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2
				local var_551_4 = Vector3.New(0, -0.84, -6.1)

				var_551_0.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1094ui_story, var_551_4, var_551_3)

				local var_551_5 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_5.x, var_551_5.y, var_551_5.z)

				local var_551_6 = var_551_0.localEulerAngles

				var_551_6.z = 0
				var_551_6.x = 0
				var_551_0.localEulerAngles = var_551_6
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 then
				var_551_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_551_7 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_7.x, var_551_7.y, var_551_7.z)

				local var_551_8 = var_551_0.localEulerAngles

				var_551_8.z = 0
				var_551_8.x = 0
				var_551_0.localEulerAngles = var_551_8
			end

			local var_551_9 = arg_548_1.actors_["1094ui_story"]
			local var_551_10 = 0

			if var_551_10 < arg_548_1.time_ and arg_548_1.time_ <= var_551_10 + arg_551_0 and not isNil(var_551_9) and arg_548_1.var_.characterEffect1094ui_story == nil then
				arg_548_1.var_.characterEffect1094ui_story = var_551_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_11 = 0.200000002980232

			if var_551_10 <= arg_548_1.time_ and arg_548_1.time_ < var_551_10 + var_551_11 and not isNil(var_551_9) then
				local var_551_12 = (arg_548_1.time_ - var_551_10) / var_551_11

				if arg_548_1.var_.characterEffect1094ui_story and not isNil(var_551_9) then
					arg_548_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= var_551_10 + var_551_11 and arg_548_1.time_ < var_551_10 + var_551_11 + arg_551_0 and not isNil(var_551_9) and arg_548_1.var_.characterEffect1094ui_story then
				arg_548_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_551_13 = 0

			if var_551_13 < arg_548_1.time_ and arg_548_1.time_ <= var_551_13 + arg_551_0 then
				arg_548_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_551_14 = 0
			local var_551_15 = 0.125

			if var_551_14 < arg_548_1.time_ and arg_548_1.time_ <= var_551_14 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_16 = arg_548_1:FormatText(StoryNameCfg[181].name)

				arg_548_1.leftNameTxt_.text = var_551_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_17 = arg_548_1:GetWordFromCfg(1109401133)
				local var_551_18 = arg_548_1:FormatText(var_551_17.content)

				arg_548_1.text_.text = var_551_18

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_19 = 5
				local var_551_20 = utf8.len(var_551_18)
				local var_551_21 = var_551_19 <= 0 and var_551_15 or var_551_15 * (var_551_20 / var_551_19)

				if var_551_21 > 0 and var_551_15 < var_551_21 then
					arg_548_1.talkMaxDuration = var_551_21

					if var_551_21 + var_551_14 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_21 + var_551_14
					end
				end

				arg_548_1.text_.text = var_551_18
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401133", "story_v_side_new_1109401.awb") ~= 0 then
					local var_551_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401133", "story_v_side_new_1109401.awb") / 1000

					if var_551_22 + var_551_14 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_22 + var_551_14
					end

					if var_551_17.prefab_name ~= "" and arg_548_1.actors_[var_551_17.prefab_name] ~= nil then
						local var_551_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_17.prefab_name].transform, "story_v_side_new_1109401", "1109401133", "story_v_side_new_1109401.awb")

						arg_548_1:RecordAudio("1109401133", var_551_23)
						arg_548_1:RecordAudio("1109401133", var_551_23)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401133", "story_v_side_new_1109401.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401133", "story_v_side_new_1109401.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_24 = math.max(var_551_15, arg_548_1.talkMaxDuration)

			if var_551_14 <= arg_548_1.time_ and arg_548_1.time_ < var_551_14 + var_551_24 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_14) / var_551_24

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_14 + var_551_24 and arg_548_1.time_ < var_551_14 + var_551_24 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play1109401134 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1109401134
		arg_552_1.duration_ = 5.27

		local var_552_0 = {
			ja = 5.266,
			ko = 3.366,
			zh = 3.366
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
				arg_552_0:Play1109401135(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1094ui_story"].transform
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.var_.moveOldPos1094ui_story = var_555_0.localPosition
			end

			local var_555_2 = 0.001

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2
				local var_555_4 = Vector3.New(0, -0.84, -6.1)

				var_555_0.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos1094ui_story, var_555_4, var_555_3)

				local var_555_5 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_5.x, var_555_5.y, var_555_5.z)

				local var_555_6 = var_555_0.localEulerAngles

				var_555_6.z = 0
				var_555_6.x = 0
				var_555_0.localEulerAngles = var_555_6
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 then
				var_555_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_555_7 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_7.x, var_555_7.y, var_555_7.z)

				local var_555_8 = var_555_0.localEulerAngles

				var_555_8.z = 0
				var_555_8.x = 0
				var_555_0.localEulerAngles = var_555_8
			end

			local var_555_9 = arg_552_1.actors_["1094ui_story"]
			local var_555_10 = 0

			if var_555_10 < arg_552_1.time_ and arg_552_1.time_ <= var_555_10 + arg_555_0 and not isNil(var_555_9) and arg_552_1.var_.characterEffect1094ui_story == nil then
				arg_552_1.var_.characterEffect1094ui_story = var_555_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_11 = 0.200000002980232

			if var_555_10 <= arg_552_1.time_ and arg_552_1.time_ < var_555_10 + var_555_11 and not isNil(var_555_9) then
				local var_555_12 = (arg_552_1.time_ - var_555_10) / var_555_11

				if arg_552_1.var_.characterEffect1094ui_story and not isNil(var_555_9) then
					arg_552_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= var_555_10 + var_555_11 and arg_552_1.time_ < var_555_10 + var_555_11 + arg_555_0 and not isNil(var_555_9) and arg_552_1.var_.characterEffect1094ui_story then
				arg_552_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_555_13 = 0

			if var_555_13 < arg_552_1.time_ and arg_552_1.time_ <= var_555_13 + arg_555_0 then
				arg_552_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			local var_555_14 = 0

			if var_555_14 < arg_552_1.time_ and arg_552_1.time_ <= var_555_14 + arg_555_0 then
				arg_552_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_555_15 = 0
			local var_555_16 = 0.325

			if var_555_15 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_17 = arg_552_1:FormatText(StoryNameCfg[181].name)

				arg_552_1.leftNameTxt_.text = var_555_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_18 = arg_552_1:GetWordFromCfg(1109401134)
				local var_555_19 = arg_552_1:FormatText(var_555_18.content)

				arg_552_1.text_.text = var_555_19

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 13
				local var_555_21 = utf8.len(var_555_19)
				local var_555_22 = var_555_20 <= 0 and var_555_16 or var_555_16 * (var_555_21 / var_555_20)

				if var_555_22 > 0 and var_555_16 < var_555_22 then
					arg_552_1.talkMaxDuration = var_555_22

					if var_555_22 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_22 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_19
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401134", "story_v_side_new_1109401.awb") ~= 0 then
					local var_555_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401134", "story_v_side_new_1109401.awb") / 1000

					if var_555_23 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_23 + var_555_15
					end

					if var_555_18.prefab_name ~= "" and arg_552_1.actors_[var_555_18.prefab_name] ~= nil then
						local var_555_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_18.prefab_name].transform, "story_v_side_new_1109401", "1109401134", "story_v_side_new_1109401.awb")

						arg_552_1:RecordAudio("1109401134", var_555_24)
						arg_552_1:RecordAudio("1109401134", var_555_24)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401134", "story_v_side_new_1109401.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401134", "story_v_side_new_1109401.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_25 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_15 <= arg_552_1.time_ and arg_552_1.time_ < var_555_15 + var_555_25 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_15) / var_555_25

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_15 + var_555_25 and arg_552_1.time_ < var_555_15 + var_555_25 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_552_1:InitPlayNodeList()
	end,
	Play1109401135 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1109401135
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1109401136(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["1094ui_story"]
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect1094ui_story == nil then
				arg_556_1.var_.characterEffect1094ui_story = var_559_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_2 = 0.200000002980232

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 and not isNil(var_559_0) then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2

				if arg_556_1.var_.characterEffect1094ui_story and not isNil(var_559_0) then
					local var_559_4 = Mathf.Lerp(0, 0.5, var_559_3)

					arg_556_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1094ui_story.fillRatio = var_559_4
				end
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 and not isNil(var_559_0) and arg_556_1.var_.characterEffect1094ui_story then
				local var_559_5 = 0.5

				arg_556_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1094ui_story.fillRatio = var_559_5
			end

			local var_559_6 = 0
			local var_559_7 = 0.65

			if var_559_6 < arg_556_1.time_ and arg_556_1.time_ <= var_559_6 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_8 = arg_556_1:FormatText(StoryNameCfg[7].name)

				arg_556_1.leftNameTxt_.text = var_559_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_9 = arg_556_1:GetWordFromCfg(1109401135)
				local var_559_10 = arg_556_1:FormatText(var_559_9.content)

				arg_556_1.text_.text = var_559_10

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_11 = 26
				local var_559_12 = utf8.len(var_559_10)
				local var_559_13 = var_559_11 <= 0 and var_559_7 or var_559_7 * (var_559_12 / var_559_11)

				if var_559_13 > 0 and var_559_7 < var_559_13 then
					arg_556_1.talkMaxDuration = var_559_13

					if var_559_13 + var_559_6 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_13 + var_559_6
					end
				end

				arg_556_1.text_.text = var_559_10
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_14 = math.max(var_559_7, arg_556_1.talkMaxDuration)

			if var_559_6 <= arg_556_1.time_ and arg_556_1.time_ < var_559_6 + var_559_14 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_6) / var_559_14

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_6 + var_559_14 and arg_556_1.time_ < var_559_6 + var_559_14 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1109401136 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1109401136
		arg_560_1.duration_ = 4.67

		local var_560_0 = {
			ja = 4.666,
			ko = 2.4,
			zh = 2.4
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1109401137(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1094ui_story"].transform
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.var_.moveOldPos1094ui_story = var_563_0.localPosition
			end

			local var_563_2 = 0.001

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2
				local var_563_4 = Vector3.New(0, -0.84, -6.1)

				var_563_0.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos1094ui_story, var_563_4, var_563_3)

				local var_563_5 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_5.x, var_563_5.y, var_563_5.z)

				local var_563_6 = var_563_0.localEulerAngles

				var_563_6.z = 0
				var_563_6.x = 0
				var_563_0.localEulerAngles = var_563_6
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 then
				var_563_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_563_7 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_7.x, var_563_7.y, var_563_7.z)

				local var_563_8 = var_563_0.localEulerAngles

				var_563_8.z = 0
				var_563_8.x = 0
				var_563_0.localEulerAngles = var_563_8
			end

			local var_563_9 = arg_560_1.actors_["1094ui_story"]
			local var_563_10 = 0

			if var_563_10 < arg_560_1.time_ and arg_560_1.time_ <= var_563_10 + arg_563_0 and not isNil(var_563_9) and arg_560_1.var_.characterEffect1094ui_story == nil then
				arg_560_1.var_.characterEffect1094ui_story = var_563_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_11 = 0.200000002980232

			if var_563_10 <= arg_560_1.time_ and arg_560_1.time_ < var_563_10 + var_563_11 and not isNil(var_563_9) then
				local var_563_12 = (arg_560_1.time_ - var_563_10) / var_563_11

				if arg_560_1.var_.characterEffect1094ui_story and not isNil(var_563_9) then
					arg_560_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_560_1.time_ >= var_563_10 + var_563_11 and arg_560_1.time_ < var_563_10 + var_563_11 + arg_563_0 and not isNil(var_563_9) and arg_560_1.var_.characterEffect1094ui_story then
				arg_560_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_563_13 = 0

			if var_563_13 < arg_560_1.time_ and arg_560_1.time_ <= var_563_13 + arg_563_0 then
				arg_560_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_563_14 = 0

			if var_563_14 < arg_560_1.time_ and arg_560_1.time_ <= var_563_14 + arg_563_0 then
				arg_560_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_563_15 = 0
			local var_563_16 = 0.175

			if var_563_15 < arg_560_1.time_ and arg_560_1.time_ <= var_563_15 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_17 = arg_560_1:FormatText(StoryNameCfg[181].name)

				arg_560_1.leftNameTxt_.text = var_563_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_18 = arg_560_1:GetWordFromCfg(1109401136)
				local var_563_19 = arg_560_1:FormatText(var_563_18.content)

				arg_560_1.text_.text = var_563_19

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_20 = 7
				local var_563_21 = utf8.len(var_563_19)
				local var_563_22 = var_563_20 <= 0 and var_563_16 or var_563_16 * (var_563_21 / var_563_20)

				if var_563_22 > 0 and var_563_16 < var_563_22 then
					arg_560_1.talkMaxDuration = var_563_22

					if var_563_22 + var_563_15 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_22 + var_563_15
					end
				end

				arg_560_1.text_.text = var_563_19
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401136", "story_v_side_new_1109401.awb") ~= 0 then
					local var_563_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401136", "story_v_side_new_1109401.awb") / 1000

					if var_563_23 + var_563_15 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_23 + var_563_15
					end

					if var_563_18.prefab_name ~= "" and arg_560_1.actors_[var_563_18.prefab_name] ~= nil then
						local var_563_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_18.prefab_name].transform, "story_v_side_new_1109401", "1109401136", "story_v_side_new_1109401.awb")

						arg_560_1:RecordAudio("1109401136", var_563_24)
						arg_560_1:RecordAudio("1109401136", var_563_24)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401136", "story_v_side_new_1109401.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401136", "story_v_side_new_1109401.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_25 = math.max(var_563_16, arg_560_1.talkMaxDuration)

			if var_563_15 <= arg_560_1.time_ and arg_560_1.time_ < var_563_15 + var_563_25 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_15) / var_563_25

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_15 + var_563_25 and arg_560_1.time_ < var_563_15 + var_563_25 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109401137 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1109401137
		arg_564_1.duration_ = 0.2

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"

			SetActive(arg_564_1.choicesGo_, true)

			for iter_565_0, iter_565_1 in ipairs(arg_564_1.choices_) do
				local var_565_0 = iter_565_0 <= 1

				SetActive(iter_565_1.go, var_565_0)
			end

			arg_564_1.choices_[1].txt.text = arg_564_1:FormatText(StoryChoiceCfg[404].name)
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1109401138(arg_564_1)
			end

			arg_564_1:RecordChoiceLog(1109401137, 404)
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["1094ui_story"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1094ui_story == nil then
				arg_564_1.var_.characterEffect1094ui_story = var_567_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_2 = 0.200000002980232

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.characterEffect1094ui_story and not isNil(var_567_0) then
					local var_567_4 = Mathf.Lerp(0, 0.5, var_567_3)

					arg_564_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1094ui_story.fillRatio = var_567_4
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1094ui_story then
				local var_567_5 = 0.5

				arg_564_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1094ui_story.fillRatio = var_567_5
			end

			local var_567_6 = 0

			if var_567_6 < arg_564_1.time_ and arg_564_1.time_ <= var_567_6 + arg_567_0 then
				arg_564_1.allBtn_.enabled = false
			end

			local var_567_7 = 0.200000002980232

			if arg_564_1.time_ >= var_567_6 + var_567_7 and arg_564_1.time_ < var_567_6 + var_567_7 + arg_567_0 then
				arg_564_1.allBtn_.enabled = true
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1109401138 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1109401138
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1109401139(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 0.275

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_2 = arg_568_1:FormatText(StoryNameCfg[7].name)

				arg_568_1.leftNameTxt_.text = var_571_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_3 = arg_568_1:GetWordFromCfg(1109401138)
				local var_571_4 = arg_568_1:FormatText(var_571_3.content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 11
				local var_571_6 = utf8.len(var_571_4)
				local var_571_7 = var_571_5 <= 0 and var_571_1 or var_571_1 * (var_571_6 / var_571_5)

				if var_571_7 > 0 and var_571_1 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_8 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_8 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_8

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_8 and arg_568_1.time_ < var_571_0 + var_571_8 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1109401139 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1109401139
		arg_572_1.duration_ = 2

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1109401140(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["1094ui_story"].transform
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 then
				arg_572_1.var_.moveOldPos1094ui_story = var_575_0.localPosition
			end

			local var_575_2 = 0.001

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2
				local var_575_4 = Vector3.New(0, -0.84, -6.1)

				var_575_0.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1094ui_story, var_575_4, var_575_3)

				local var_575_5 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_5.x, var_575_5.y, var_575_5.z)

				local var_575_6 = var_575_0.localEulerAngles

				var_575_6.z = 0
				var_575_6.x = 0
				var_575_0.localEulerAngles = var_575_6
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 then
				var_575_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_575_7 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_7.x, var_575_7.y, var_575_7.z)

				local var_575_8 = var_575_0.localEulerAngles

				var_575_8.z = 0
				var_575_8.x = 0
				var_575_0.localEulerAngles = var_575_8
			end

			local var_575_9 = arg_572_1.actors_["1094ui_story"]
			local var_575_10 = 0

			if var_575_10 < arg_572_1.time_ and arg_572_1.time_ <= var_575_10 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1094ui_story == nil then
				arg_572_1.var_.characterEffect1094ui_story = var_575_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_11 = 0.200000002980232

			if var_575_10 <= arg_572_1.time_ and arg_572_1.time_ < var_575_10 + var_575_11 and not isNil(var_575_9) then
				local var_575_12 = (arg_572_1.time_ - var_575_10) / var_575_11

				if arg_572_1.var_.characterEffect1094ui_story and not isNil(var_575_9) then
					arg_572_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= var_575_10 + var_575_11 and arg_572_1.time_ < var_575_10 + var_575_11 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1094ui_story then
				arg_572_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_575_13 = 0

			if var_575_13 < arg_572_1.time_ and arg_572_1.time_ <= var_575_13 + arg_575_0 then
				arg_572_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_575_14 = 0
			local var_575_15 = 0.075

			if var_575_14 < arg_572_1.time_ and arg_572_1.time_ <= var_575_14 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_16 = arg_572_1:FormatText(StoryNameCfg[181].name)

				arg_572_1.leftNameTxt_.text = var_575_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_17 = arg_572_1:GetWordFromCfg(1109401139)
				local var_575_18 = arg_572_1:FormatText(var_575_17.content)

				arg_572_1.text_.text = var_575_18

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_19 = 3
				local var_575_20 = utf8.len(var_575_18)
				local var_575_21 = var_575_19 <= 0 and var_575_15 or var_575_15 * (var_575_20 / var_575_19)

				if var_575_21 > 0 and var_575_15 < var_575_21 then
					arg_572_1.talkMaxDuration = var_575_21

					if var_575_21 + var_575_14 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_21 + var_575_14
					end
				end

				arg_572_1.text_.text = var_575_18
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401139", "story_v_side_new_1109401.awb") ~= 0 then
					local var_575_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401139", "story_v_side_new_1109401.awb") / 1000

					if var_575_22 + var_575_14 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_22 + var_575_14
					end

					if var_575_17.prefab_name ~= "" and arg_572_1.actors_[var_575_17.prefab_name] ~= nil then
						local var_575_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_17.prefab_name].transform, "story_v_side_new_1109401", "1109401139", "story_v_side_new_1109401.awb")

						arg_572_1:RecordAudio("1109401139", var_575_23)
						arg_572_1:RecordAudio("1109401139", var_575_23)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401139", "story_v_side_new_1109401.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401139", "story_v_side_new_1109401.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_24 = math.max(var_575_15, arg_572_1.talkMaxDuration)

			if var_575_14 <= arg_572_1.time_ and arg_572_1.time_ < var_575_14 + var_575_24 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_14) / var_575_24

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_14 + var_575_24 and arg_572_1.time_ < var_575_14 + var_575_24 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play1109401140 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1109401140
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1109401141(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["1094ui_story"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1094ui_story == nil then
				arg_576_1.var_.characterEffect1094ui_story = var_579_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_2 = 0.200000002980232

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.characterEffect1094ui_story and not isNil(var_579_0) then
					local var_579_4 = Mathf.Lerp(0, 0.5, var_579_3)

					arg_576_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1094ui_story.fillRatio = var_579_4
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1094ui_story then
				local var_579_5 = 0.5

				arg_576_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1094ui_story.fillRatio = var_579_5
			end

			local var_579_6 = 0
			local var_579_7 = 0.375

			if var_579_6 < arg_576_1.time_ and arg_576_1.time_ <= var_579_6 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_8 = arg_576_1:FormatText(StoryNameCfg[7].name)

				arg_576_1.leftNameTxt_.text = var_579_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_9 = arg_576_1:GetWordFromCfg(1109401140)
				local var_579_10 = arg_576_1:FormatText(var_579_9.content)

				arg_576_1.text_.text = var_579_10

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_11 = 15
				local var_579_12 = utf8.len(var_579_10)
				local var_579_13 = var_579_11 <= 0 and var_579_7 or var_579_7 * (var_579_12 / var_579_11)

				if var_579_13 > 0 and var_579_7 < var_579_13 then
					arg_576_1.talkMaxDuration = var_579_13

					if var_579_13 + var_579_6 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_13 + var_579_6
					end
				end

				arg_576_1.text_.text = var_579_10
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_14 = math.max(var_579_7, arg_576_1.talkMaxDuration)

			if var_579_6 <= arg_576_1.time_ and arg_576_1.time_ < var_579_6 + var_579_14 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_6) / var_579_14

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_6 + var_579_14 and arg_576_1.time_ < var_579_6 + var_579_14 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1109401141 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1109401141
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1109401142(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0
			local var_583_1 = 0.525

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_2 = arg_580_1:GetWordFromCfg(1109401141)
				local var_583_3 = arg_580_1:FormatText(var_583_2.content)

				arg_580_1.text_.text = var_583_3

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_4 = 21
				local var_583_5 = utf8.len(var_583_3)
				local var_583_6 = var_583_4 <= 0 and var_583_1 or var_583_1 * (var_583_5 / var_583_4)

				if var_583_6 > 0 and var_583_1 < var_583_6 then
					arg_580_1.talkMaxDuration = var_583_6

					if var_583_6 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_6 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_3
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_7 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_7 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_7

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_7 and arg_580_1.time_ < var_583_0 + var_583_7 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1109401142 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 1109401142
		arg_584_1.duration_ = 2

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play1109401143(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["1094ui_story"].transform
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 then
				arg_584_1.var_.moveOldPos1094ui_story = var_587_0.localPosition
			end

			local var_587_2 = 0.001

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2
				local var_587_4 = Vector3.New(0, -0.84, -6.1)

				var_587_0.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos1094ui_story, var_587_4, var_587_3)

				local var_587_5 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_5.x, var_587_5.y, var_587_5.z)

				local var_587_6 = var_587_0.localEulerAngles

				var_587_6.z = 0
				var_587_6.x = 0
				var_587_0.localEulerAngles = var_587_6
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 then
				var_587_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_587_7 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_7.x, var_587_7.y, var_587_7.z)

				local var_587_8 = var_587_0.localEulerAngles

				var_587_8.z = 0
				var_587_8.x = 0
				var_587_0.localEulerAngles = var_587_8
			end

			local var_587_9 = arg_584_1.actors_["1094ui_story"]
			local var_587_10 = 0

			if var_587_10 < arg_584_1.time_ and arg_584_1.time_ <= var_587_10 + arg_587_0 and not isNil(var_587_9) and arg_584_1.var_.characterEffect1094ui_story == nil then
				arg_584_1.var_.characterEffect1094ui_story = var_587_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_11 = 0.200000002980232

			if var_587_10 <= arg_584_1.time_ and arg_584_1.time_ < var_587_10 + var_587_11 and not isNil(var_587_9) then
				local var_587_12 = (arg_584_1.time_ - var_587_10) / var_587_11

				if arg_584_1.var_.characterEffect1094ui_story and not isNil(var_587_9) then
					arg_584_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= var_587_10 + var_587_11 and arg_584_1.time_ < var_587_10 + var_587_11 + arg_587_0 and not isNil(var_587_9) and arg_584_1.var_.characterEffect1094ui_story then
				arg_584_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_587_13 = 0

			if var_587_13 < arg_584_1.time_ and arg_584_1.time_ <= var_587_13 + arg_587_0 then
				arg_584_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_587_14 = 0

			if var_587_14 < arg_584_1.time_ and arg_584_1.time_ <= var_587_14 + arg_587_0 then
				arg_584_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_587_15 = 0
			local var_587_16 = 0.075

			if var_587_15 < arg_584_1.time_ and arg_584_1.time_ <= var_587_15 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_17 = arg_584_1:FormatText(StoryNameCfg[181].name)

				arg_584_1.leftNameTxt_.text = var_587_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_18 = arg_584_1:GetWordFromCfg(1109401142)
				local var_587_19 = arg_584_1:FormatText(var_587_18.content)

				arg_584_1.text_.text = var_587_19

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_20 = 3
				local var_587_21 = utf8.len(var_587_19)
				local var_587_22 = var_587_20 <= 0 and var_587_16 or var_587_16 * (var_587_21 / var_587_20)

				if var_587_22 > 0 and var_587_16 < var_587_22 then
					arg_584_1.talkMaxDuration = var_587_22

					if var_587_22 + var_587_15 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_22 + var_587_15
					end
				end

				arg_584_1.text_.text = var_587_19
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401142", "story_v_side_new_1109401.awb") ~= 0 then
					local var_587_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401142", "story_v_side_new_1109401.awb") / 1000

					if var_587_23 + var_587_15 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_23 + var_587_15
					end

					if var_587_18.prefab_name ~= "" and arg_584_1.actors_[var_587_18.prefab_name] ~= nil then
						local var_587_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_18.prefab_name].transform, "story_v_side_new_1109401", "1109401142", "story_v_side_new_1109401.awb")

						arg_584_1:RecordAudio("1109401142", var_587_24)
						arg_584_1:RecordAudio("1109401142", var_587_24)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401142", "story_v_side_new_1109401.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401142", "story_v_side_new_1109401.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_25 = math.max(var_587_16, arg_584_1.talkMaxDuration)

			if var_587_15 <= arg_584_1.time_ and arg_584_1.time_ < var_587_15 + var_587_25 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_15) / var_587_25

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_15 + var_587_25 and arg_584_1.time_ < var_587_15 + var_587_25 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_584_1:InitPlayNodeList()
	end,
	Play1109401143 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1109401143
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1109401144(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["1094ui_story"]
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.characterEffect1094ui_story == nil then
				arg_588_1.var_.characterEffect1094ui_story = var_591_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_591_2 = 0.200000002980232

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 and not isNil(var_591_0) then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2

				if arg_588_1.var_.characterEffect1094ui_story and not isNil(var_591_0) then
					local var_591_4 = Mathf.Lerp(0, 0.5, var_591_3)

					arg_588_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_588_1.var_.characterEffect1094ui_story.fillRatio = var_591_4
				end
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.characterEffect1094ui_story then
				local var_591_5 = 0.5

				arg_588_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_588_1.var_.characterEffect1094ui_story.fillRatio = var_591_5
			end

			local var_591_6 = 0
			local var_591_7 = 1.05

			if var_591_6 < arg_588_1.time_ and arg_588_1.time_ <= var_591_6 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_8 = arg_588_1:FormatText(StoryNameCfg[7].name)

				arg_588_1.leftNameTxt_.text = var_591_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_9 = arg_588_1:GetWordFromCfg(1109401143)
				local var_591_10 = arg_588_1:FormatText(var_591_9.content)

				arg_588_1.text_.text = var_591_10

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_11 = 42
				local var_591_12 = utf8.len(var_591_10)
				local var_591_13 = var_591_11 <= 0 and var_591_7 or var_591_7 * (var_591_12 / var_591_11)

				if var_591_13 > 0 and var_591_7 < var_591_13 then
					arg_588_1.talkMaxDuration = var_591_13

					if var_591_13 + var_591_6 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_13 + var_591_6
					end
				end

				arg_588_1.text_.text = var_591_10
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_14 = math.max(var_591_7, arg_588_1.talkMaxDuration)

			if var_591_6 <= arg_588_1.time_ and arg_588_1.time_ < var_591_6 + var_591_14 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_6) / var_591_14

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_6 + var_591_14 and arg_588_1.time_ < var_591_6 + var_591_14 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1109401144 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1109401144
		arg_592_1.duration_ = 3.63

		local var_592_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1109401145(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = arg_592_1.actors_["1094ui_story"].transform
			local var_595_1 = 0

			if var_595_1 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 then
				arg_592_1.var_.moveOldPos1094ui_story = var_595_0.localPosition
			end

			local var_595_2 = 0.001

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_2 then
				local var_595_3 = (arg_592_1.time_ - var_595_1) / var_595_2
				local var_595_4 = Vector3.New(0, -0.84, -6.1)

				var_595_0.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos1094ui_story, var_595_4, var_595_3)

				local var_595_5 = manager.ui.mainCamera.transform.position - var_595_0.position

				var_595_0.forward = Vector3.New(var_595_5.x, var_595_5.y, var_595_5.z)

				local var_595_6 = var_595_0.localEulerAngles

				var_595_6.z = 0
				var_595_6.x = 0
				var_595_0.localEulerAngles = var_595_6
			end

			if arg_592_1.time_ >= var_595_1 + var_595_2 and arg_592_1.time_ < var_595_1 + var_595_2 + arg_595_0 then
				var_595_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_595_7 = manager.ui.mainCamera.transform.position - var_595_0.position

				var_595_0.forward = Vector3.New(var_595_7.x, var_595_7.y, var_595_7.z)

				local var_595_8 = var_595_0.localEulerAngles

				var_595_8.z = 0
				var_595_8.x = 0
				var_595_0.localEulerAngles = var_595_8
			end

			local var_595_9 = arg_592_1.actors_["1094ui_story"]
			local var_595_10 = 0

			if var_595_10 < arg_592_1.time_ and arg_592_1.time_ <= var_595_10 + arg_595_0 and not isNil(var_595_9) and arg_592_1.var_.characterEffect1094ui_story == nil then
				arg_592_1.var_.characterEffect1094ui_story = var_595_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_11 = 0.200000002980232

			if var_595_10 <= arg_592_1.time_ and arg_592_1.time_ < var_595_10 + var_595_11 and not isNil(var_595_9) then
				local var_595_12 = (arg_592_1.time_ - var_595_10) / var_595_11

				if arg_592_1.var_.characterEffect1094ui_story and not isNil(var_595_9) then
					arg_592_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= var_595_10 + var_595_11 and arg_592_1.time_ < var_595_10 + var_595_11 + arg_595_0 and not isNil(var_595_9) and arg_592_1.var_.characterEffect1094ui_story then
				arg_592_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_595_13 = 0

			if var_595_13 < arg_592_1.time_ and arg_592_1.time_ <= var_595_13 + arg_595_0 then
				arg_592_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_595_14 = 0
			local var_595_15 = 0.125

			if var_595_14 < arg_592_1.time_ and arg_592_1.time_ <= var_595_14 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_16 = arg_592_1:FormatText(StoryNameCfg[181].name)

				arg_592_1.leftNameTxt_.text = var_595_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_17 = arg_592_1:GetWordFromCfg(1109401144)
				local var_595_18 = arg_592_1:FormatText(var_595_17.content)

				arg_592_1.text_.text = var_595_18

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_19 = 5
				local var_595_20 = utf8.len(var_595_18)
				local var_595_21 = var_595_19 <= 0 and var_595_15 or var_595_15 * (var_595_20 / var_595_19)

				if var_595_21 > 0 and var_595_15 < var_595_21 then
					arg_592_1.talkMaxDuration = var_595_21

					if var_595_21 + var_595_14 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_21 + var_595_14
					end
				end

				arg_592_1.text_.text = var_595_18
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401144", "story_v_side_new_1109401.awb") ~= 0 then
					local var_595_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401144", "story_v_side_new_1109401.awb") / 1000

					if var_595_22 + var_595_14 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_22 + var_595_14
					end

					if var_595_17.prefab_name ~= "" and arg_592_1.actors_[var_595_17.prefab_name] ~= nil then
						local var_595_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_17.prefab_name].transform, "story_v_side_new_1109401", "1109401144", "story_v_side_new_1109401.awb")

						arg_592_1:RecordAudio("1109401144", var_595_23)
						arg_592_1:RecordAudio("1109401144", var_595_23)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401144", "story_v_side_new_1109401.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401144", "story_v_side_new_1109401.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_24 = math.max(var_595_15, arg_592_1.talkMaxDuration)

			if var_595_14 <= arg_592_1.time_ and arg_592_1.time_ < var_595_14 + var_595_24 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_14) / var_595_24

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_14 + var_595_24 and arg_592_1.time_ < var_595_14 + var_595_24 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_592_1:InitPlayNodeList()
	end,
	Play1109401145 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1109401145
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1109401146(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1094ui_story"]
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1094ui_story == nil then
				arg_596_1.var_.characterEffect1094ui_story = var_599_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_2 = 0.200000002980232

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 and not isNil(var_599_0) then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2

				if arg_596_1.var_.characterEffect1094ui_story and not isNil(var_599_0) then
					local var_599_4 = Mathf.Lerp(0, 0.5, var_599_3)

					arg_596_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_596_1.var_.characterEffect1094ui_story.fillRatio = var_599_4
				end
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1094ui_story then
				local var_599_5 = 0.5

				arg_596_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_596_1.var_.characterEffect1094ui_story.fillRatio = var_599_5
			end

			local var_599_6 = 0
			local var_599_7 = 0.375

			if var_599_6 < arg_596_1.time_ and arg_596_1.time_ <= var_599_6 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_8 = arg_596_1:FormatText(StoryNameCfg[7].name)

				arg_596_1.leftNameTxt_.text = var_599_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_9 = arg_596_1:GetWordFromCfg(1109401145)
				local var_599_10 = arg_596_1:FormatText(var_599_9.content)

				arg_596_1.text_.text = var_599_10

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_11 = 15
				local var_599_12 = utf8.len(var_599_10)
				local var_599_13 = var_599_11 <= 0 and var_599_7 or var_599_7 * (var_599_12 / var_599_11)

				if var_599_13 > 0 and var_599_7 < var_599_13 then
					arg_596_1.talkMaxDuration = var_599_13

					if var_599_13 + var_599_6 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_13 + var_599_6
					end
				end

				arg_596_1.text_.text = var_599_10
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_14 = math.max(var_599_7, arg_596_1.talkMaxDuration)

			if var_599_6 <= arg_596_1.time_ and arg_596_1.time_ < var_599_6 + var_599_14 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_6) / var_599_14

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_6 + var_599_14 and arg_596_1.time_ < var_599_6 + var_599_14 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1109401146 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1109401146
		arg_600_1.duration_ = 2

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1109401147(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1094ui_story"].transform
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 then
				arg_600_1.var_.moveOldPos1094ui_story = var_603_0.localPosition
			end

			local var_603_2 = 0.001

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2
				local var_603_4 = Vector3.New(0, -0.84, -6.1)

				var_603_0.localPosition = Vector3.Lerp(arg_600_1.var_.moveOldPos1094ui_story, var_603_4, var_603_3)

				local var_603_5 = manager.ui.mainCamera.transform.position - var_603_0.position

				var_603_0.forward = Vector3.New(var_603_5.x, var_603_5.y, var_603_5.z)

				local var_603_6 = var_603_0.localEulerAngles

				var_603_6.z = 0
				var_603_6.x = 0
				var_603_0.localEulerAngles = var_603_6
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 then
				var_603_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_603_7 = manager.ui.mainCamera.transform.position - var_603_0.position

				var_603_0.forward = Vector3.New(var_603_7.x, var_603_7.y, var_603_7.z)

				local var_603_8 = var_603_0.localEulerAngles

				var_603_8.z = 0
				var_603_8.x = 0
				var_603_0.localEulerAngles = var_603_8
			end

			local var_603_9 = arg_600_1.actors_["1094ui_story"]
			local var_603_10 = 0

			if var_603_10 < arg_600_1.time_ and arg_600_1.time_ <= var_603_10 + arg_603_0 and not isNil(var_603_9) and arg_600_1.var_.characterEffect1094ui_story == nil then
				arg_600_1.var_.characterEffect1094ui_story = var_603_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_11 = 0.200000002980232

			if var_603_10 <= arg_600_1.time_ and arg_600_1.time_ < var_603_10 + var_603_11 and not isNil(var_603_9) then
				local var_603_12 = (arg_600_1.time_ - var_603_10) / var_603_11

				if arg_600_1.var_.characterEffect1094ui_story and not isNil(var_603_9) then
					arg_600_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_600_1.time_ >= var_603_10 + var_603_11 and arg_600_1.time_ < var_603_10 + var_603_11 + arg_603_0 and not isNil(var_603_9) and arg_600_1.var_.characterEffect1094ui_story then
				arg_600_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_603_13 = 0

			if var_603_13 < arg_600_1.time_ and arg_600_1.time_ <= var_603_13 + arg_603_0 then
				arg_600_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_603_14 = 0

			if var_603_14 < arg_600_1.time_ and arg_600_1.time_ <= var_603_14 + arg_603_0 then
				arg_600_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_603_15 = 0
			local var_603_16 = 0.075

			if var_603_15 < arg_600_1.time_ and arg_600_1.time_ <= var_603_15 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_17 = arg_600_1:FormatText(StoryNameCfg[181].name)

				arg_600_1.leftNameTxt_.text = var_603_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_18 = arg_600_1:GetWordFromCfg(1109401146)
				local var_603_19 = arg_600_1:FormatText(var_603_18.content)

				arg_600_1.text_.text = var_603_19

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_20 = 3
				local var_603_21 = utf8.len(var_603_19)
				local var_603_22 = var_603_20 <= 0 and var_603_16 or var_603_16 * (var_603_21 / var_603_20)

				if var_603_22 > 0 and var_603_16 < var_603_22 then
					arg_600_1.talkMaxDuration = var_603_22

					if var_603_22 + var_603_15 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_22 + var_603_15
					end
				end

				arg_600_1.text_.text = var_603_19
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401146", "story_v_side_new_1109401.awb") ~= 0 then
					local var_603_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401146", "story_v_side_new_1109401.awb") / 1000

					if var_603_23 + var_603_15 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_23 + var_603_15
					end

					if var_603_18.prefab_name ~= "" and arg_600_1.actors_[var_603_18.prefab_name] ~= nil then
						local var_603_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_18.prefab_name].transform, "story_v_side_new_1109401", "1109401146", "story_v_side_new_1109401.awb")

						arg_600_1:RecordAudio("1109401146", var_603_24)
						arg_600_1:RecordAudio("1109401146", var_603_24)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401146", "story_v_side_new_1109401.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401146", "story_v_side_new_1109401.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_25 = math.max(var_603_16, arg_600_1.talkMaxDuration)

			if var_603_15 <= arg_600_1.time_ and arg_600_1.time_ < var_603_15 + var_603_25 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_15) / var_603_25

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_15 + var_603_25 and arg_600_1.time_ < var_603_15 + var_603_25 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_600_1:InitPlayNodeList()
	end,
	Play1109401147 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1109401147
		arg_604_1.duration_ = 5.4

		local var_604_0 = {
			ja = 5.266,
			ko = 5.4,
			zh = 5.4
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1109401148(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 2

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				local var_607_1 = manager.ui.mainCamera.transform.localPosition
				local var_607_2 = Vector3.New(0, 0, 10) + Vector3.New(var_607_1.x, var_607_1.y, 0)
				local var_607_3 = arg_604_1.bgs_.B13b

				var_607_3.transform.localPosition = var_607_2
				var_607_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_607_4 = var_607_3:GetComponent("SpriteRenderer")

				if var_607_4 and var_607_4.sprite then
					local var_607_5 = (var_607_3.transform.localPosition - var_607_1).z
					local var_607_6 = manager.ui.mainCameraCom_
					local var_607_7 = 2 * var_607_5 * Mathf.Tan(var_607_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_607_8 = var_607_7 * var_607_6.aspect
					local var_607_9 = var_607_4.sprite.bounds.size.x
					local var_607_10 = var_607_4.sprite.bounds.size.y
					local var_607_11 = var_607_8 / var_607_9
					local var_607_12 = var_607_7 / var_607_10
					local var_607_13 = var_607_12 < var_607_11 and var_607_11 or var_607_12

					var_607_3.transform.localScale = Vector3.New(var_607_13, var_607_13, 0)
				end

				for iter_607_0, iter_607_1 in pairs(arg_604_1.bgs_) do
					if iter_607_0 ~= "B13b" then
						iter_607_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_607_14 = 0

			if var_607_14 < arg_604_1.time_ and arg_604_1.time_ <= var_607_14 + arg_607_0 then
				arg_604_1.mask_.enabled = true
				arg_604_1.mask_.raycastTarget = true

				arg_604_1:SetGaussion(false)
			end

			local var_607_15 = 2

			if var_607_14 <= arg_604_1.time_ and arg_604_1.time_ < var_607_14 + var_607_15 then
				local var_607_16 = (arg_604_1.time_ - var_607_14) / var_607_15
				local var_607_17 = Color.New(0, 0, 0)

				var_607_17.a = Mathf.Lerp(0, 1, var_607_16)
				arg_604_1.mask_.color = var_607_17
			end

			if arg_604_1.time_ >= var_607_14 + var_607_15 and arg_604_1.time_ < var_607_14 + var_607_15 + arg_607_0 then
				local var_607_18 = Color.New(0, 0, 0)

				var_607_18.a = 1
				arg_604_1.mask_.color = var_607_18
			end

			local var_607_19 = 2

			if var_607_19 < arg_604_1.time_ and arg_604_1.time_ <= var_607_19 + arg_607_0 then
				arg_604_1.mask_.enabled = true
				arg_604_1.mask_.raycastTarget = true

				arg_604_1:SetGaussion(false)
			end

			local var_607_20 = 2

			if var_607_19 <= arg_604_1.time_ and arg_604_1.time_ < var_607_19 + var_607_20 then
				local var_607_21 = (arg_604_1.time_ - var_607_19) / var_607_20
				local var_607_22 = Color.New(0, 0, 0)

				var_607_22.a = Mathf.Lerp(1, 0, var_607_21)
				arg_604_1.mask_.color = var_607_22
			end

			if arg_604_1.time_ >= var_607_19 + var_607_20 and arg_604_1.time_ < var_607_19 + var_607_20 + arg_607_0 then
				local var_607_23 = Color.New(0, 0, 0)
				local var_607_24 = 0

				arg_604_1.mask_.enabled = false
				var_607_23.a = var_607_24
				arg_604_1.mask_.color = var_607_23
			end

			local var_607_25 = arg_604_1.actors_["1094ui_story"]
			local var_607_26 = 0

			if var_607_26 < arg_604_1.time_ and arg_604_1.time_ <= var_607_26 + arg_607_0 and not isNil(var_607_25) and arg_604_1.var_.characterEffect1094ui_story == nil then
				arg_604_1.var_.characterEffect1094ui_story = var_607_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_27 = 0.200000002980232

			if var_607_26 <= arg_604_1.time_ and arg_604_1.time_ < var_607_26 + var_607_27 and not isNil(var_607_25) then
				local var_607_28 = (arg_604_1.time_ - var_607_26) / var_607_27

				if arg_604_1.var_.characterEffect1094ui_story and not isNil(var_607_25) then
					local var_607_29 = Mathf.Lerp(0, 0.5, var_607_28)

					arg_604_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_604_1.var_.characterEffect1094ui_story.fillRatio = var_607_29
				end
			end

			if arg_604_1.time_ >= var_607_26 + var_607_27 and arg_604_1.time_ < var_607_26 + var_607_27 + arg_607_0 and not isNil(var_607_25) and arg_604_1.var_.characterEffect1094ui_story then
				local var_607_30 = 0.5

				arg_604_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_604_1.var_.characterEffect1094ui_story.fillRatio = var_607_30
			end

			local var_607_31 = arg_604_1.actors_["1094ui_story"].transform
			local var_607_32 = 0

			if var_607_32 < arg_604_1.time_ and arg_604_1.time_ <= var_607_32 + arg_607_0 then
				arg_604_1.var_.moveOldPos1094ui_story = var_607_31.localPosition
			end

			local var_607_33 = 0.001

			if var_607_32 <= arg_604_1.time_ and arg_604_1.time_ < var_607_32 + var_607_33 then
				local var_607_34 = (arg_604_1.time_ - var_607_32) / var_607_33
				local var_607_35 = Vector3.New(0, 100, 0)

				var_607_31.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1094ui_story, var_607_35, var_607_34)

				local var_607_36 = manager.ui.mainCamera.transform.position - var_607_31.position

				var_607_31.forward = Vector3.New(var_607_36.x, var_607_36.y, var_607_36.z)

				local var_607_37 = var_607_31.localEulerAngles

				var_607_37.z = 0
				var_607_37.x = 0
				var_607_31.localEulerAngles = var_607_37
			end

			if arg_604_1.time_ >= var_607_32 + var_607_33 and arg_604_1.time_ < var_607_32 + var_607_33 + arg_607_0 then
				var_607_31.localPosition = Vector3.New(0, 100, 0)

				local var_607_38 = manager.ui.mainCamera.transform.position - var_607_31.position

				var_607_31.forward = Vector3.New(var_607_38.x, var_607_38.y, var_607_38.z)

				local var_607_39 = var_607_31.localEulerAngles

				var_607_39.z = 0
				var_607_39.x = 0
				var_607_31.localEulerAngles = var_607_39
			end

			if arg_604_1.frameCnt_ <= 1 then
				arg_604_1.dialog_:SetActive(false)
			end

			local var_607_40 = 4
			local var_607_41 = 0.125

			if var_607_40 < arg_604_1.time_ and arg_604_1.time_ <= var_607_40 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0

				arg_604_1.dialog_:SetActive(true)

				arg_604_1.dialogCg_.alpha = 0

				local var_607_42 = LeanTween.value(arg_604_1.dialog_, 0, 1, 0.3)

				var_607_42:setOnUpdate(LuaHelper.FloatAction(function(arg_608_0)
					arg_604_1.dialogCg_.alpha = arg_608_0
				end))
				var_607_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_604_1.dialog_)
					var_607_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_604_1.duration_ = arg_604_1.duration_ + 0.3

				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_43 = arg_604_1:FormatText(StoryNameCfg[177].name)

				arg_604_1.leftNameTxt_.text = var_607_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_44 = arg_604_1:GetWordFromCfg(1109401147)
				local var_607_45 = arg_604_1:FormatText(var_607_44.content)

				arg_604_1.text_.text = var_607_45

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_46 = 5
				local var_607_47 = utf8.len(var_607_45)
				local var_607_48 = var_607_46 <= 0 and var_607_41 or var_607_41 * (var_607_47 / var_607_46)

				if var_607_48 > 0 and var_607_41 < var_607_48 then
					arg_604_1.talkMaxDuration = var_607_48
					var_607_40 = var_607_40 + 0.3

					if var_607_48 + var_607_40 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_48 + var_607_40
					end
				end

				arg_604_1.text_.text = var_607_45
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401147", "story_v_side_new_1109401.awb") ~= 0 then
					local var_607_49 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401147", "story_v_side_new_1109401.awb") / 1000

					if var_607_49 + var_607_40 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_49 + var_607_40
					end

					if var_607_44.prefab_name ~= "" and arg_604_1.actors_[var_607_44.prefab_name] ~= nil then
						local var_607_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_44.prefab_name].transform, "story_v_side_new_1109401", "1109401147", "story_v_side_new_1109401.awb")

						arg_604_1:RecordAudio("1109401147", var_607_50)
						arg_604_1:RecordAudio("1109401147", var_607_50)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401147", "story_v_side_new_1109401.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401147", "story_v_side_new_1109401.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_51 = var_607_40 + 0.3
			local var_607_52 = math.max(var_607_41, arg_604_1.talkMaxDuration)

			if var_607_51 <= arg_604_1.time_ and arg_604_1.time_ < var_607_51 + var_607_52 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_51) / var_607_52

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_51 + var_607_52 and arg_604_1.time_ < var_607_51 + var_607_52 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play1109401148 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1109401148
		arg_610_1.duration_ = 2.73

		local var_610_0 = {
			ja = 1.133,
			ko = 2.733,
			zh = 2.733
		}
		local var_610_1 = manager.audio:GetLocalizationFlag()

		if var_610_0[var_610_1] ~= nil then
			arg_610_1.duration_ = var_610_0[var_610_1]
		end

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1109401149(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = arg_610_1.actors_["1094ui_story"].transform
			local var_613_1 = 0

			if var_613_1 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 then
				arg_610_1.var_.moveOldPos1094ui_story = var_613_0.localPosition
			end

			local var_613_2 = 0.001

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_2 then
				local var_613_3 = (arg_610_1.time_ - var_613_1) / var_613_2
				local var_613_4 = Vector3.New(0, -0.84, -6.1)

				var_613_0.localPosition = Vector3.Lerp(arg_610_1.var_.moveOldPos1094ui_story, var_613_4, var_613_3)

				local var_613_5 = manager.ui.mainCamera.transform.position - var_613_0.position

				var_613_0.forward = Vector3.New(var_613_5.x, var_613_5.y, var_613_5.z)

				local var_613_6 = var_613_0.localEulerAngles

				var_613_6.z = 0
				var_613_6.x = 0
				var_613_0.localEulerAngles = var_613_6
			end

			if arg_610_1.time_ >= var_613_1 + var_613_2 and arg_610_1.time_ < var_613_1 + var_613_2 + arg_613_0 then
				var_613_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_613_7 = manager.ui.mainCamera.transform.position - var_613_0.position

				var_613_0.forward = Vector3.New(var_613_7.x, var_613_7.y, var_613_7.z)

				local var_613_8 = var_613_0.localEulerAngles

				var_613_8.z = 0
				var_613_8.x = 0
				var_613_0.localEulerAngles = var_613_8
			end

			local var_613_9 = arg_610_1.actors_["1094ui_story"]
			local var_613_10 = 0

			if var_613_10 < arg_610_1.time_ and arg_610_1.time_ <= var_613_10 + arg_613_0 and not isNil(var_613_9) and arg_610_1.var_.characterEffect1094ui_story == nil then
				arg_610_1.var_.characterEffect1094ui_story = var_613_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_11 = 0.200000002980232

			if var_613_10 <= arg_610_1.time_ and arg_610_1.time_ < var_613_10 + var_613_11 and not isNil(var_613_9) then
				local var_613_12 = (arg_610_1.time_ - var_613_10) / var_613_11

				if arg_610_1.var_.characterEffect1094ui_story and not isNil(var_613_9) then
					arg_610_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_610_1.time_ >= var_613_10 + var_613_11 and arg_610_1.time_ < var_613_10 + var_613_11 + arg_613_0 and not isNil(var_613_9) and arg_610_1.var_.characterEffect1094ui_story then
				arg_610_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_613_13 = 0

			if var_613_13 < arg_610_1.time_ and arg_610_1.time_ <= var_613_13 + arg_613_0 then
				arg_610_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_613_14 = 0

			if var_613_14 < arg_610_1.time_ and arg_610_1.time_ <= var_613_14 + arg_613_0 then
				arg_610_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_613_15 = 0
			local var_613_16 = 0.2

			if var_613_15 < arg_610_1.time_ and arg_610_1.time_ <= var_613_15 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				local var_613_17 = arg_610_1:FormatText(StoryNameCfg[181].name)

				arg_610_1.leftNameTxt_.text = var_613_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_18 = arg_610_1:GetWordFromCfg(1109401148)
				local var_613_19 = arg_610_1:FormatText(var_613_18.content)

				arg_610_1.text_.text = var_613_19

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_20 = 8
				local var_613_21 = utf8.len(var_613_19)
				local var_613_22 = var_613_20 <= 0 and var_613_16 or var_613_16 * (var_613_21 / var_613_20)

				if var_613_22 > 0 and var_613_16 < var_613_22 then
					arg_610_1.talkMaxDuration = var_613_22

					if var_613_22 + var_613_15 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_22 + var_613_15
					end
				end

				arg_610_1.text_.text = var_613_19
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401148", "story_v_side_new_1109401.awb") ~= 0 then
					local var_613_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401148", "story_v_side_new_1109401.awb") / 1000

					if var_613_23 + var_613_15 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_23 + var_613_15
					end

					if var_613_18.prefab_name ~= "" and arg_610_1.actors_[var_613_18.prefab_name] ~= nil then
						local var_613_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_18.prefab_name].transform, "story_v_side_new_1109401", "1109401148", "story_v_side_new_1109401.awb")

						arg_610_1:RecordAudio("1109401148", var_613_24)
						arg_610_1:RecordAudio("1109401148", var_613_24)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401148", "story_v_side_new_1109401.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401148", "story_v_side_new_1109401.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_25 = math.max(var_613_16, arg_610_1.talkMaxDuration)

			if var_613_15 <= arg_610_1.time_ and arg_610_1.time_ < var_613_15 + var_613_25 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_15) / var_613_25

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_15 + var_613_25 and arg_610_1.time_ < var_613_15 + var_613_25 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_610_1:InitPlayNodeList()
	end,
	Play1109401149 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1109401149
		arg_614_1.duration_ = 6.23

		local var_614_0 = {
			ja = 6.233,
			ko = 2.9,
			zh = 2.9
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1109401150(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = arg_614_1.actors_["1094ui_story"]
			local var_617_1 = 0

			if var_617_1 < arg_614_1.time_ and arg_614_1.time_ <= var_617_1 + arg_617_0 and not isNil(var_617_0) and arg_614_1.var_.characterEffect1094ui_story == nil then
				arg_614_1.var_.characterEffect1094ui_story = var_617_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_2 = 0.200000002980232

			if var_617_1 <= arg_614_1.time_ and arg_614_1.time_ < var_617_1 + var_617_2 and not isNil(var_617_0) then
				local var_617_3 = (arg_614_1.time_ - var_617_1) / var_617_2

				if arg_614_1.var_.characterEffect1094ui_story and not isNil(var_617_0) then
					local var_617_4 = Mathf.Lerp(0, 0.5, var_617_3)

					arg_614_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_614_1.var_.characterEffect1094ui_story.fillRatio = var_617_4
				end
			end

			if arg_614_1.time_ >= var_617_1 + var_617_2 and arg_614_1.time_ < var_617_1 + var_617_2 + arg_617_0 and not isNil(var_617_0) and arg_614_1.var_.characterEffect1094ui_story then
				local var_617_5 = 0.5

				arg_614_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_614_1.var_.characterEffect1094ui_story.fillRatio = var_617_5
			end

			local var_617_6 = 0
			local var_617_7 = 0.375

			if var_617_6 < arg_614_1.time_ and arg_614_1.time_ <= var_617_6 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				local var_617_8 = arg_614_1:FormatText(StoryNameCfg[177].name)

				arg_614_1.leftNameTxt_.text = var_617_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, true)
				arg_614_1.iconController_:SetSelectedState("hero")

				arg_614_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_614_1.callingController_:SetSelectedState("normal")

				arg_614_1.keyicon_.color = Color.New(1, 1, 1)
				arg_614_1.icon_.color = Color.New(1, 1, 1)

				local var_617_9 = arg_614_1:GetWordFromCfg(1109401149)
				local var_617_10 = arg_614_1:FormatText(var_617_9.content)

				arg_614_1.text_.text = var_617_10

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_11 = 15
				local var_617_12 = utf8.len(var_617_10)
				local var_617_13 = var_617_11 <= 0 and var_617_7 or var_617_7 * (var_617_12 / var_617_11)

				if var_617_13 > 0 and var_617_7 < var_617_13 then
					arg_614_1.talkMaxDuration = var_617_13

					if var_617_13 + var_617_6 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_13 + var_617_6
					end
				end

				arg_614_1.text_.text = var_617_10
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401149", "story_v_side_new_1109401.awb") ~= 0 then
					local var_617_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401149", "story_v_side_new_1109401.awb") / 1000

					if var_617_14 + var_617_6 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_14 + var_617_6
					end

					if var_617_9.prefab_name ~= "" and arg_614_1.actors_[var_617_9.prefab_name] ~= nil then
						local var_617_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_9.prefab_name].transform, "story_v_side_new_1109401", "1109401149", "story_v_side_new_1109401.awb")

						arg_614_1:RecordAudio("1109401149", var_617_15)
						arg_614_1:RecordAudio("1109401149", var_617_15)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401149", "story_v_side_new_1109401.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401149", "story_v_side_new_1109401.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_16 = math.max(var_617_7, arg_614_1.talkMaxDuration)

			if var_617_6 <= arg_614_1.time_ and arg_614_1.time_ < var_617_6 + var_617_16 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_6) / var_617_16

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_6 + var_617_16 and arg_614_1.time_ < var_617_6 + var_617_16 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1109401150 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1109401150
		arg_618_1.duration_ = 2.6

		local var_618_0 = {
			ja = 2.6,
			ko = 2.533,
			zh = 2.533
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1109401151(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["1094ui_story"].transform
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.var_.moveOldPos1094ui_story = var_621_0.localPosition
			end

			local var_621_2 = 0.001

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2
				local var_621_4 = Vector3.New(0, -0.84, -6.1)

				var_621_0.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1094ui_story, var_621_4, var_621_3)

				local var_621_5 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_5.x, var_621_5.y, var_621_5.z)

				local var_621_6 = var_621_0.localEulerAngles

				var_621_6.z = 0
				var_621_6.x = 0
				var_621_0.localEulerAngles = var_621_6
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 then
				var_621_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_621_7 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_7.x, var_621_7.y, var_621_7.z)

				local var_621_8 = var_621_0.localEulerAngles

				var_621_8.z = 0
				var_621_8.x = 0
				var_621_0.localEulerAngles = var_621_8
			end

			local var_621_9 = arg_618_1.actors_["1094ui_story"]
			local var_621_10 = 0

			if var_621_10 < arg_618_1.time_ and arg_618_1.time_ <= var_621_10 + arg_621_0 and not isNil(var_621_9) and arg_618_1.var_.characterEffect1094ui_story == nil then
				arg_618_1.var_.characterEffect1094ui_story = var_621_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_11 = 0.200000002980232

			if var_621_10 <= arg_618_1.time_ and arg_618_1.time_ < var_621_10 + var_621_11 and not isNil(var_621_9) then
				local var_621_12 = (arg_618_1.time_ - var_621_10) / var_621_11

				if arg_618_1.var_.characterEffect1094ui_story and not isNil(var_621_9) then
					arg_618_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_618_1.time_ >= var_621_10 + var_621_11 and arg_618_1.time_ < var_621_10 + var_621_11 + arg_621_0 and not isNil(var_621_9) and arg_618_1.var_.characterEffect1094ui_story then
				arg_618_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_621_13 = 0

			if var_621_13 < arg_618_1.time_ and arg_618_1.time_ <= var_621_13 + arg_621_0 then
				arg_618_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_621_14 = 0

			if var_621_14 < arg_618_1.time_ and arg_618_1.time_ <= var_621_14 + arg_621_0 then
				arg_618_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_621_15 = 0
			local var_621_16 = 0.3

			if var_621_15 < arg_618_1.time_ and arg_618_1.time_ <= var_621_15 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_17 = arg_618_1:FormatText(StoryNameCfg[181].name)

				arg_618_1.leftNameTxt_.text = var_621_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_18 = arg_618_1:GetWordFromCfg(1109401150)
				local var_621_19 = arg_618_1:FormatText(var_621_18.content)

				arg_618_1.text_.text = var_621_19

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_20 = 12
				local var_621_21 = utf8.len(var_621_19)
				local var_621_22 = var_621_20 <= 0 and var_621_16 or var_621_16 * (var_621_21 / var_621_20)

				if var_621_22 > 0 and var_621_16 < var_621_22 then
					arg_618_1.talkMaxDuration = var_621_22

					if var_621_22 + var_621_15 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_22 + var_621_15
					end
				end

				arg_618_1.text_.text = var_621_19
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401150", "story_v_side_new_1109401.awb") ~= 0 then
					local var_621_23 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401150", "story_v_side_new_1109401.awb") / 1000

					if var_621_23 + var_621_15 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_23 + var_621_15
					end

					if var_621_18.prefab_name ~= "" and arg_618_1.actors_[var_621_18.prefab_name] ~= nil then
						local var_621_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_18.prefab_name].transform, "story_v_side_new_1109401", "1109401150", "story_v_side_new_1109401.awb")

						arg_618_1:RecordAudio("1109401150", var_621_24)
						arg_618_1:RecordAudio("1109401150", var_621_24)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401150", "story_v_side_new_1109401.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401150", "story_v_side_new_1109401.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_25 = math.max(var_621_16, arg_618_1.talkMaxDuration)

			if var_621_15 <= arg_618_1.time_ and arg_618_1.time_ < var_621_15 + var_621_25 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_15) / var_621_25

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_15 + var_621_25 and arg_618_1.time_ < var_621_15 + var_621_25 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1109401151 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1109401151
		arg_622_1.duration_ = 7.67

		local var_622_0 = {
			ja = 7.666,
			ko = 5.333,
			zh = 5.333
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1109401152(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["1094ui_story"]
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect1094ui_story == nil then
				arg_622_1.var_.characterEffect1094ui_story = var_625_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_2 = 0.200000002980232

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_2 and not isNil(var_625_0) then
				local var_625_3 = (arg_622_1.time_ - var_625_1) / var_625_2

				if arg_622_1.var_.characterEffect1094ui_story and not isNil(var_625_0) then
					local var_625_4 = Mathf.Lerp(0, 0.5, var_625_3)

					arg_622_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_622_1.var_.characterEffect1094ui_story.fillRatio = var_625_4
				end
			end

			if arg_622_1.time_ >= var_625_1 + var_625_2 and arg_622_1.time_ < var_625_1 + var_625_2 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect1094ui_story then
				local var_625_5 = 0.5

				arg_622_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_622_1.var_.characterEffect1094ui_story.fillRatio = var_625_5
			end

			local var_625_6 = 0
			local var_625_7 = 0.65

			if var_625_6 < arg_622_1.time_ and arg_622_1.time_ <= var_625_6 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_8 = arg_622_1:FormatText(StoryNameCfg[177].name)

				arg_622_1.leftNameTxt_.text = var_625_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_9 = arg_622_1:GetWordFromCfg(1109401151)
				local var_625_10 = arg_622_1:FormatText(var_625_9.content)

				arg_622_1.text_.text = var_625_10

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_11 = 26
				local var_625_12 = utf8.len(var_625_10)
				local var_625_13 = var_625_11 <= 0 and var_625_7 or var_625_7 * (var_625_12 / var_625_11)

				if var_625_13 > 0 and var_625_7 < var_625_13 then
					arg_622_1.talkMaxDuration = var_625_13

					if var_625_13 + var_625_6 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_13 + var_625_6
					end
				end

				arg_622_1.text_.text = var_625_10
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401151", "story_v_side_new_1109401.awb") ~= 0 then
					local var_625_14 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401151", "story_v_side_new_1109401.awb") / 1000

					if var_625_14 + var_625_6 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_14 + var_625_6
					end

					if var_625_9.prefab_name ~= "" and arg_622_1.actors_[var_625_9.prefab_name] ~= nil then
						local var_625_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_9.prefab_name].transform, "story_v_side_new_1109401", "1109401151", "story_v_side_new_1109401.awb")

						arg_622_1:RecordAudio("1109401151", var_625_15)
						arg_622_1:RecordAudio("1109401151", var_625_15)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401151", "story_v_side_new_1109401.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401151", "story_v_side_new_1109401.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_16 = math.max(var_625_7, arg_622_1.talkMaxDuration)

			if var_625_6 <= arg_622_1.time_ and arg_622_1.time_ < var_625_6 + var_625_16 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_6) / var_625_16

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_6 + var_625_16 and arg_622_1.time_ < var_625_6 + var_625_16 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1109401152 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1109401152
		arg_626_1.duration_ = 6.87

		local var_626_0 = {
			ja = 6.866,
			ko = 5.2,
			zh = 5.2
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1109401153(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0
			local var_629_1 = 0.525

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				local var_629_2 = arg_626_1:FormatText(StoryNameCfg[177].name)

				arg_626_1.leftNameTxt_.text = var_629_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, true)
				arg_626_1.iconController_:SetSelectedState("hero")

				arg_626_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_626_1.callingController_:SetSelectedState("normal")

				arg_626_1.keyicon_.color = Color.New(1, 1, 1)
				arg_626_1.icon_.color = Color.New(1, 1, 1)

				local var_629_3 = arg_626_1:GetWordFromCfg(1109401152)
				local var_629_4 = arg_626_1:FormatText(var_629_3.content)

				arg_626_1.text_.text = var_629_4

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_5 = 21
				local var_629_6 = utf8.len(var_629_4)
				local var_629_7 = var_629_5 <= 0 and var_629_1 or var_629_1 * (var_629_6 / var_629_5)

				if var_629_7 > 0 and var_629_1 < var_629_7 then
					arg_626_1.talkMaxDuration = var_629_7

					if var_629_7 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_0
					end
				end

				arg_626_1.text_.text = var_629_4
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401152", "story_v_side_new_1109401.awb") ~= 0 then
					local var_629_8 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401152", "story_v_side_new_1109401.awb") / 1000

					if var_629_8 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_8 + var_629_0
					end

					if var_629_3.prefab_name ~= "" and arg_626_1.actors_[var_629_3.prefab_name] ~= nil then
						local var_629_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_3.prefab_name].transform, "story_v_side_new_1109401", "1109401152", "story_v_side_new_1109401.awb")

						arg_626_1:RecordAudio("1109401152", var_629_9)
						arg_626_1:RecordAudio("1109401152", var_629_9)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401152", "story_v_side_new_1109401.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401152", "story_v_side_new_1109401.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_10 = math.max(var_629_1, arg_626_1.talkMaxDuration)

			if var_629_0 <= arg_626_1.time_ and arg_626_1.time_ < var_629_0 + var_629_10 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_0) / var_629_10

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_0 + var_629_10 and arg_626_1.time_ < var_629_0 + var_629_10 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1109401153 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1109401153
		arg_630_1.duration_ = 2.2

		local var_630_0 = {
			ja = 1.999999999999,
			ko = 2.2,
			zh = 2.2
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1109401154(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = arg_630_1.actors_["1094ui_story"].transform
			local var_633_1 = 0

			if var_633_1 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 then
				arg_630_1.var_.moveOldPos1094ui_story = var_633_0.localPosition
			end

			local var_633_2 = 0.001

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_2 then
				local var_633_3 = (arg_630_1.time_ - var_633_1) / var_633_2
				local var_633_4 = Vector3.New(0, -0.84, -6.1)

				var_633_0.localPosition = Vector3.Lerp(arg_630_1.var_.moveOldPos1094ui_story, var_633_4, var_633_3)

				local var_633_5 = manager.ui.mainCamera.transform.position - var_633_0.position

				var_633_0.forward = Vector3.New(var_633_5.x, var_633_5.y, var_633_5.z)

				local var_633_6 = var_633_0.localEulerAngles

				var_633_6.z = 0
				var_633_6.x = 0
				var_633_0.localEulerAngles = var_633_6
			end

			if arg_630_1.time_ >= var_633_1 + var_633_2 and arg_630_1.time_ < var_633_1 + var_633_2 + arg_633_0 then
				var_633_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_633_7 = manager.ui.mainCamera.transform.position - var_633_0.position

				var_633_0.forward = Vector3.New(var_633_7.x, var_633_7.y, var_633_7.z)

				local var_633_8 = var_633_0.localEulerAngles

				var_633_8.z = 0
				var_633_8.x = 0
				var_633_0.localEulerAngles = var_633_8
			end

			local var_633_9 = arg_630_1.actors_["1094ui_story"]
			local var_633_10 = 0

			if var_633_10 < arg_630_1.time_ and arg_630_1.time_ <= var_633_10 + arg_633_0 and not isNil(var_633_9) and arg_630_1.var_.characterEffect1094ui_story == nil then
				arg_630_1.var_.characterEffect1094ui_story = var_633_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_11 = 0.200000002980232

			if var_633_10 <= arg_630_1.time_ and arg_630_1.time_ < var_633_10 + var_633_11 and not isNil(var_633_9) then
				local var_633_12 = (arg_630_1.time_ - var_633_10) / var_633_11

				if arg_630_1.var_.characterEffect1094ui_story and not isNil(var_633_9) then
					arg_630_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_630_1.time_ >= var_633_10 + var_633_11 and arg_630_1.time_ < var_633_10 + var_633_11 + arg_633_0 and not isNil(var_633_9) and arg_630_1.var_.characterEffect1094ui_story then
				arg_630_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_633_13 = 0

			if var_633_13 < arg_630_1.time_ and arg_630_1.time_ <= var_633_13 + arg_633_0 then
				arg_630_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_633_14 = 0
			local var_633_15 = 0.3

			if var_633_14 < arg_630_1.time_ and arg_630_1.time_ <= var_633_14 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_16 = arg_630_1:FormatText(StoryNameCfg[181].name)

				arg_630_1.leftNameTxt_.text = var_633_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_17 = arg_630_1:GetWordFromCfg(1109401153)
				local var_633_18 = arg_630_1:FormatText(var_633_17.content)

				arg_630_1.text_.text = var_633_18

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_19 = 12
				local var_633_20 = utf8.len(var_633_18)
				local var_633_21 = var_633_19 <= 0 and var_633_15 or var_633_15 * (var_633_20 / var_633_19)

				if var_633_21 > 0 and var_633_15 < var_633_21 then
					arg_630_1.talkMaxDuration = var_633_21

					if var_633_21 + var_633_14 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_21 + var_633_14
					end
				end

				arg_630_1.text_.text = var_633_18
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401153", "story_v_side_new_1109401.awb") ~= 0 then
					local var_633_22 = manager.audio:GetVoiceLength("story_v_side_new_1109401", "1109401153", "story_v_side_new_1109401.awb") / 1000

					if var_633_22 + var_633_14 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_22 + var_633_14
					end

					if var_633_17.prefab_name ~= "" and arg_630_1.actors_[var_633_17.prefab_name] ~= nil then
						local var_633_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_17.prefab_name].transform, "story_v_side_new_1109401", "1109401153", "story_v_side_new_1109401.awb")

						arg_630_1:RecordAudio("1109401153", var_633_23)
						arg_630_1:RecordAudio("1109401153", var_633_23)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_side_new_1109401", "1109401153", "story_v_side_new_1109401.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_side_new_1109401", "1109401153", "story_v_side_new_1109401.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_24 = math.max(var_633_15, arg_630_1.talkMaxDuration)

			if var_633_14 <= arg_630_1.time_ and arg_630_1.time_ < var_633_14 + var_633_24 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_14) / var_633_24

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_14 + var_633_24 and arg_630_1.time_ < var_633_14 + var_633_24 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_630_1:InitPlayNodeList()
	end,
	Play1109401154 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1109401154
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
			arg_634_1.auto_ = false
		end

		function arg_634_1.playNext_(arg_636_0)
			arg_634_1.onStoryFinished_()
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["1094ui_story"].transform
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 then
				arg_634_1.var_.moveOldPos1094ui_story = var_637_0.localPosition
			end

			local var_637_2 = 0.001

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_2 then
				local var_637_3 = (arg_634_1.time_ - var_637_1) / var_637_2
				local var_637_4 = Vector3.New(0, 100, 0)

				var_637_0.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos1094ui_story, var_637_4, var_637_3)

				local var_637_5 = manager.ui.mainCamera.transform.position - var_637_0.position

				var_637_0.forward = Vector3.New(var_637_5.x, var_637_5.y, var_637_5.z)

				local var_637_6 = var_637_0.localEulerAngles

				var_637_6.z = 0
				var_637_6.x = 0
				var_637_0.localEulerAngles = var_637_6
			end

			if arg_634_1.time_ >= var_637_1 + var_637_2 and arg_634_1.time_ < var_637_1 + var_637_2 + arg_637_0 then
				var_637_0.localPosition = Vector3.New(0, 100, 0)

				local var_637_7 = manager.ui.mainCamera.transform.position - var_637_0.position

				var_637_0.forward = Vector3.New(var_637_7.x, var_637_7.y, var_637_7.z)

				local var_637_8 = var_637_0.localEulerAngles

				var_637_8.z = 0
				var_637_8.x = 0
				var_637_0.localEulerAngles = var_637_8
			end

			local var_637_9 = 0
			local var_637_10 = 0.525

			if var_637_9 < arg_634_1.time_ and arg_634_1.time_ <= var_637_9 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, false)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_11 = arg_634_1:GetWordFromCfg(1109401154)
				local var_637_12 = arg_634_1:FormatText(var_637_11.content)

				arg_634_1.text_.text = var_637_12

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_13 = 21
				local var_637_14 = utf8.len(var_637_12)
				local var_637_15 = var_637_13 <= 0 and var_637_10 or var_637_10 * (var_637_14 / var_637_13)

				if var_637_15 > 0 and var_637_10 < var_637_15 then
					arg_634_1.talkMaxDuration = var_637_15

					if var_637_15 + var_637_9 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_15 + var_637_9
					end
				end

				arg_634_1.text_.text = var_637_12
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_16 = math.max(var_637_10, arg_634_1.talkMaxDuration)

			if var_637_9 <= arg_634_1.time_ and arg_634_1.time_ < var_637_9 + var_637_16 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_9) / var_637_16

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_9 + var_637_16 and arg_634_1.time_ < var_637_9 + var_637_16 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D09a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST34",
		"TextureConfig/Background/B13b"
	},
	voices = {
		"story_v_side_new_1109401.awb"
	}
}
