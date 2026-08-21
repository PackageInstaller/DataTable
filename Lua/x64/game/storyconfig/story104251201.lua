return {
	Play425121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425121001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 5.633,
			ja = 6.666
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
				arg_1_0:Play425121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2403a"

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
				local var_4_5 = arg_1_1.bgs_.ST2403a

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
					if iter_4_0 ~= "ST2403a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.05

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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3")

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

			local var_4_36 = 0.133333333333333
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_147", "se_story_147_amb_interrogation", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.35

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_44 = arg_1_1:GetWordFromCfg(425121001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 14
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121001", "story_v_out_425121.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_425121", "425121001", "story_v_out_425121.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_425121", "425121001", "story_v_out_425121.awb")

						arg_1_1:RecordAudio("425121001", var_4_50)
						arg_1_1:RecordAudio("425121001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425121", "425121001", "story_v_out_425121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425121", "425121001", "story_v_out_425121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play425121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425121002
		arg_9_1.duration_ = 7.73

		local var_9_0 = {
			zh = 6.666,
			ja = 7.733
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
				arg_9_0:Play425121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.575

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[15].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(425121002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121002", "story_v_out_425121.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121002", "story_v_out_425121.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_425121", "425121002", "story_v_out_425121.awb")

						arg_9_1:RecordAudio("425121002", var_12_9)
						arg_9_1:RecordAudio("425121002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425121", "425121002", "story_v_out_425121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425121", "425121002", "story_v_out_425121.awb")
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
	Play425121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425121003
		arg_13_1.duration_ = 4.5

		local var_13_0 = {
			zh = 4.5,
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
				arg_13_0:Play425121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.525

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[15].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(425121003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121003", "story_v_out_425121.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121003", "story_v_out_425121.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_425121", "425121003", "story_v_out_425121.awb")

						arg_13_1:RecordAudio("425121003", var_16_9)
						arg_13_1:RecordAudio("425121003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425121", "425121003", "story_v_out_425121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425121", "425121003", "story_v_out_425121.awb")
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
	Play425121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425121004
		arg_17_1.duration_ = 2.77

		local var_17_0 = {
			zh = 1.8,
			ja = 2.766
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
				arg_17_0:Play425121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.125

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[36].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(425121004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121004", "story_v_out_425121.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121004", "story_v_out_425121.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_425121", "425121004", "story_v_out_425121.awb")

						arg_17_1:RecordAudio("425121004", var_20_9)
						arg_17_1:RecordAudio("425121004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425121", "425121004", "story_v_out_425121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425121", "425121004", "story_v_out_425121.awb")
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
	Play425121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425121005
		arg_21_1.duration_ = 1.53

		local var_21_0 = {
			zh = 1.533,
			ja = 1.5
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
				arg_21_0:Play425121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.075

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[15].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(425121005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121005", "story_v_out_425121.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121005", "story_v_out_425121.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_425121", "425121005", "story_v_out_425121.awb")

						arg_21_1:RecordAudio("425121005", var_24_9)
						arg_21_1:RecordAudio("425121005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425121", "425121005", "story_v_out_425121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425121", "425121005", "story_v_out_425121.awb")
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
	Play425121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425121006
		arg_25_1.duration_ = 3.87

		local var_25_0 = {
			zh = 3.1,
			ja = 3.866
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
				arg_25_0:Play425121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.35

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[36].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(425121006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121006", "story_v_out_425121.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121006", "story_v_out_425121.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_425121", "425121006", "story_v_out_425121.awb")

						arg_25_1:RecordAudio("425121006", var_28_9)
						arg_25_1:RecordAudio("425121006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425121", "425121006", "story_v_out_425121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425121", "425121006", "story_v_out_425121.awb")
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
	Play425121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425121007
		arg_29_1.duration_ = 7.2

		local var_29_0 = {
			zh = 7.2,
			ja = 5.7
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
				arg_29_0:Play425121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.55

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[15].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(425121007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121007", "story_v_out_425121.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121007", "story_v_out_425121.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_425121", "425121007", "story_v_out_425121.awb")

						arg_29_1:RecordAudio("425121007", var_32_9)
						arg_29_1:RecordAudio("425121007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425121", "425121007", "story_v_out_425121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425121", "425121007", "story_v_out_425121.awb")
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
	Play425121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425121008
		arg_33_1.duration_ = 3.8

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play425121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_1 = 1

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_1 then
				local var_36_2 = (arg_33_1.time_ - var_36_0) / var_36_1
				local var_36_3 = Color.New(0, 0, 0)

				var_36_3.a = Mathf.Lerp(0, 1, var_36_2)
				arg_33_1.mask_.color = var_36_3
			end

			if arg_33_1.time_ >= var_36_0 + var_36_1 and arg_33_1.time_ < var_36_0 + var_36_1 + arg_36_0 then
				local var_36_4 = Color.New(0, 0, 0)

				var_36_4.a = 1
				arg_33_1.mask_.color = var_36_4
			end

			local var_36_5 = 1

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_6 = 1

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6
				local var_36_8 = Color.New(0, 0, 0)

				var_36_8.a = Mathf.Lerp(1, 0, var_36_7)
				arg_33_1.mask_.color = var_36_8
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 then
				local var_36_9 = Color.New(0, 0, 0)
				local var_36_10 = 0

				arg_33_1.mask_.enabled = false
				var_36_9.a = var_36_10
				arg_33_1.mask_.color = var_36_9
			end

			local var_36_11 = "STblack"

			if arg_33_1.bgs_[var_36_11] == nil then
				local var_36_12 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_11)
				var_36_12.name = var_36_11
				var_36_12.transform.parent = arg_33_1.stage_.transform
				var_36_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_11] = var_36_12
			end

			local var_36_13 = 1

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				local var_36_14 = manager.ui.mainCamera.transform.localPosition
				local var_36_15 = Vector3.New(0, 0, 10) + Vector3.New(var_36_14.x, var_36_14.y, 0)
				local var_36_16 = arg_33_1.bgs_.STblack

				var_36_16.transform.localPosition = var_36_15
				var_36_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_17 = var_36_16:GetComponent("SpriteRenderer")

				if var_36_17 and var_36_17.sprite then
					local var_36_18 = (var_36_16.transform.localPosition - var_36_14).z
					local var_36_19 = manager.ui.mainCameraCom_
					local var_36_20 = 2 * var_36_18 * Mathf.Tan(var_36_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_21 = var_36_20 * var_36_19.aspect
					local var_36_22 = var_36_17.sprite.bounds.size.x
					local var_36_23 = var_36_17.sprite.bounds.size.y
					local var_36_24 = var_36_21 / var_36_22
					local var_36_25 = var_36_20 / var_36_23
					local var_36_26 = var_36_25 < var_36_24 and var_36_24 or var_36_25

					var_36_16.transform.localScale = Vector3.New(var_36_26, var_36_26, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "STblack" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_27 = 0.133333333333333
			local var_36_28 = 1

			if var_36_27 < arg_33_1.time_ and arg_33_1.time_ <= var_36_27 + arg_36_0 then
				local var_36_29 = "play"
				local var_36_30 = "effect"

				arg_33_1:AudioAction(var_36_29, var_36_30, "se_story_145", "se_story_145_gold", "")
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419173,
				charCount = 3,
				enableLayoutChange = true,
				duration = 1,
				groupID = "10082",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121008,
				charCount = 42,
				enableLayoutChange = true,
				duration = 2.8,
				groupID = "10081",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play425121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425121009
		arg_37_1.duration_ = 7.77

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play425121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 7.766
			local var_40_2 = manager.audio:GetVoiceLength("story_v_out_425121", "425121009", "story_v_out_425121.awb") / 1000

			if var_40_2 > 0 and var_40_1 < var_40_2 and var_40_2 + var_40_0 > arg_37_1.duration_ then
				local var_40_3 = var_40_2

				arg_37_1.duration_ = var_40_2 + var_40_0
			end

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				local var_40_4 = "play"
				local var_40_5 = "voice"

				arg_37_1:AudioAction(var_40_4, var_40_5, "story_v_out_425121", "425121009", "story_v_out_425121.awb")
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121009,
				charCount = 26,
				enableLayoutChange = true,
				duration = 1.73333333333333,
				groupID = "1009",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "10081",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play425121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425121010
		arg_41_1.duration_ = 2.73

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play425121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.133333333333333
			local var_44_1 = 1

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				local var_44_2 = "play"
				local var_44_3 = "effect"

				arg_41_1:AudioAction(var_44_2, var_44_3, "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_44_4 = 0
			local var_44_5 = 1

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				local var_44_6 = "stop"
				local var_44_7 = "effect"

				arg_41_1:AudioAction(var_44_6, var_44_7, "se_story_147", "se_story_147_amb_interrogation", "")
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121010,
				charCount = 41,
				enableLayoutChange = true,
				duration = 2.73333333333333,
				groupID = "1010",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1009",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play425121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425121011
		arg_45_1.duration_ = 5.97

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play425121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 5.966
			local var_48_2 = manager.audio:GetVoiceLength("story_v_out_425121", "425121011", "story_v_out_425121.awb") / 1000

			if var_48_2 > 0 and var_48_1 < var_48_2 and var_48_2 + var_48_0 > arg_45_1.duration_ then
				local var_48_3 = var_48_2

				arg_45_1.duration_ = var_48_2 + var_48_0
			end

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_4 = "play"
				local var_48_5 = "voice"

				arg_45_1:AudioAction(var_48_4, var_48_5, "story_v_out_425121", "425121011", "story_v_out_425121.awb")
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				groupID = "1010",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121011,
				charCount = 13,
				enableLayoutChange = true,
				duration = 0.866666666666667,
				groupID = "1011",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play425121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425121012
		arg_49_1.duration_ = 3.23

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play425121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 3.233
			local var_52_2 = manager.audio:GetVoiceLength("story_v_out_425121", "425121012", "story_v_out_425121.awb") / 1000

			if var_52_2 > 0 and var_52_1 < var_52_2 and var_52_2 + var_52_0 > arg_49_1.duration_ then
				local var_52_3 = var_52_2

				arg_49_1.duration_ = var_52_2 + var_52_0
			end

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				local var_52_4 = "play"
				local var_52_5 = "voice"

				arg_49_1:AudioAction(var_52_4, var_52_5, "story_v_out_425121", "425121012", "story_v_out_425121.awb")
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				groupID = "1011",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121012,
				charCount = 17,
				enableLayoutChange = true,
				duration = 1.13333333333333,
				groupID = "1012",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play425121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425121013
		arg_53_1.duration_ = 4.7

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play425121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 4.7
			local var_56_2 = manager.audio:GetVoiceLength("story_v_out_425121", "425121013", "story_v_out_425121.awb") / 1000

			if var_56_2 > 0 and var_56_1 < var_56_2 and var_56_2 + var_56_0 > arg_53_1.duration_ then
				local var_56_3 = var_56_2

				arg_53_1.duration_ = var_56_2 + var_56_0
			end

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_4 = "play"
				local var_56_5 = "voice"

				arg_53_1:AudioAction(var_56_4, var_56_5, "story_v_out_425121", "425121013", "story_v_out_425121.awb")
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				groupID = "1012",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425121013,
				charCount = 14,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "1013",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play425121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425121014
		arg_57_1.duration_ = 13.97

		local var_57_0 = {
			zh = 13.966,
			ja = 13.5
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
				arg_57_0:Play425121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_1 = 1

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_1 then
				local var_60_2 = (arg_57_1.time_ - var_60_0) / var_60_1
				local var_60_3 = Color.New(0, 0, 0)

				var_60_3.a = Mathf.Lerp(0, 1, var_60_2)
				arg_57_1.mask_.color = var_60_3
			end

			if arg_57_1.time_ >= var_60_0 + var_60_1 and arg_57_1.time_ < var_60_0 + var_60_1 + arg_60_0 then
				local var_60_4 = Color.New(0, 0, 0)

				var_60_4.a = 1
				arg_57_1.mask_.color = var_60_4
			end

			local var_60_5 = 1

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_6 = 1

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6
				local var_60_8 = Color.New(0, 0, 0)

				var_60_8.a = Mathf.Lerp(1, 0, var_60_7)
				arg_57_1.mask_.color = var_60_8
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 then
				local var_60_9 = Color.New(0, 0, 0)
				local var_60_10 = 0

				arg_57_1.mask_.enabled = false
				var_60_9.a = var_60_10
				arg_57_1.mask_.color = var_60_9
			end

			local var_60_11 = 1

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				local var_60_12 = manager.ui.mainCamera.transform.localPosition
				local var_60_13 = Vector3.New(0, 0, 10) + Vector3.New(var_60_12.x, var_60_12.y, 0)
				local var_60_14 = arg_57_1.bgs_.ST2403a

				var_60_14.transform.localPosition = var_60_13
				var_60_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_15 = var_60_14:GetComponent("SpriteRenderer")

				if var_60_15 and var_60_15.sprite then
					local var_60_16 = (var_60_14.transform.localPosition - var_60_12).z
					local var_60_17 = manager.ui.mainCameraCom_
					local var_60_18 = 2 * var_60_16 * Mathf.Tan(var_60_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_60_19 = var_60_18 * var_60_17.aspect
					local var_60_20 = var_60_15.sprite.bounds.size.x
					local var_60_21 = var_60_15.sprite.bounds.size.y
					local var_60_22 = var_60_19 / var_60_20
					local var_60_23 = var_60_18 / var_60_21
					local var_60_24 = var_60_23 < var_60_22 and var_60_22 or var_60_23

					var_60_14.transform.localScale = Vector3.New(var_60_24, var_60_24, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST2403a" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_25 = 2

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_26 = 1.73333333333333

			if arg_57_1.time_ >= var_60_25 + var_60_26 and arg_57_1.time_ < var_60_25 + var_60_26 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_27 = 3.3
			local var_60_28 = 1.2

			if var_60_27 < arg_57_1.time_ and arg_57_1.time_ <= var_60_27 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_29 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_29:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_30 = arg_57_1:FormatText(StoryNameCfg[36].name)

				arg_57_1.leftNameTxt_.text = var_60_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_31 = arg_57_1:GetWordFromCfg(425121014)
				local var_60_32 = arg_57_1:FormatText(var_60_31.content)

				arg_57_1.text_.text = var_60_32

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_33 = 48
				local var_60_34 = utf8.len(var_60_32)
				local var_60_35 = var_60_33 <= 0 and var_60_28 or var_60_28 * (var_60_34 / var_60_33)

				if var_60_35 > 0 and var_60_28 < var_60_35 then
					arg_57_1.talkMaxDuration = var_60_35
					var_60_27 = var_60_27 + 0.3

					if var_60_35 + var_60_27 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_35 + var_60_27
					end
				end

				arg_57_1.text_.text = var_60_32
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121014", "story_v_out_425121.awb") ~= 0 then
					local var_60_36 = manager.audio:GetVoiceLength("story_v_out_425121", "425121014", "story_v_out_425121.awb") / 1000

					if var_60_36 + var_60_27 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_27
					end

					if var_60_31.prefab_name ~= "" and arg_57_1.actors_[var_60_31.prefab_name] ~= nil then
						local var_60_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_31.prefab_name].transform, "story_v_out_425121", "425121014", "story_v_out_425121.awb")

						arg_57_1:RecordAudio("425121014", var_60_37)
						arg_57_1:RecordAudio("425121014", var_60_37)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425121", "425121014", "story_v_out_425121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425121", "425121014", "story_v_out_425121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_38 = var_60_27 + 0.3
			local var_60_39 = math.max(var_60_28, arg_57_1.talkMaxDuration)

			if var_60_38 <= arg_57_1.time_ and arg_57_1.time_ < var_60_38 + var_60_39 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_38) / var_60_39

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_38 + var_60_39 and arg_57_1.time_ < var_60_38 + var_60_39 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				groupID = "10082",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "1013",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play425121015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 425121015
		arg_63_1.duration_ = 2.17

		local var_63_0 = {
			zh = 2.166,
			ja = 1.066
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
				arg_63_0:Play425121016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.075

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[15].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(425121015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 3
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121015", "story_v_out_425121.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121015", "story_v_out_425121.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_425121", "425121015", "story_v_out_425121.awb")

						arg_63_1:RecordAudio("425121015", var_66_9)
						arg_63_1:RecordAudio("425121015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_425121", "425121015", "story_v_out_425121.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_425121", "425121015", "story_v_out_425121.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play425121016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 425121016
		arg_67_1.duration_ = 9.07

		local var_67_0 = {
			zh = 6.7,
			ja = 9.066
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
				arg_67_0:Play425121017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.625

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[36].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(425121016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 25
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121016", "story_v_out_425121.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121016", "story_v_out_425121.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_425121", "425121016", "story_v_out_425121.awb")

						arg_67_1:RecordAudio("425121016", var_70_9)
						arg_67_1:RecordAudio("425121016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_425121", "425121016", "story_v_out_425121.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_425121", "425121016", "story_v_out_425121.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play425121017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 425121017
		arg_71_1.duration_ = 4.97

		local var_71_0 = {
			zh = 3.566,
			ja = 4.966
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
				arg_71_0:Play425121018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.325

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[36].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(425121017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 13
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121017", "story_v_out_425121.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121017", "story_v_out_425121.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_425121", "425121017", "story_v_out_425121.awb")

						arg_71_1:RecordAudio("425121017", var_74_9)
						arg_71_1:RecordAudio("425121017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_425121", "425121017", "story_v_out_425121.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_425121", "425121017", "story_v_out_425121.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play425121018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 425121018
		arg_75_1.duration_ = 3.63

		local var_75_0 = {
			zh = 3.633,
			ja = 2.433333333332
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
				arg_75_0:Play425121019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_2 = "play"
				local var_78_3 = "effect"

				arg_75_1:AudioAction(var_78_2, var_78_3, "se_story_147", "se_story_147_electric_shock_01", "")
			end

			local var_78_4 = manager.ui.mainCamera.transform
			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				local var_78_6 = arg_75_1.var_.effect10091018
				local var_78_7
				local var_78_8 = var_78_4

				if not var_78_6 then
					var_78_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_78_8)
					var_78_6.name = "1018"
					arg_75_1.var_.effect10091018 = var_78_6
				else
					var_78_6.transform:SetParent(var_78_8)
				end

				var_78_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_78_9 = 1.7777777777777777
				local var_78_10 = Screen.width / Screen.height
				local var_78_11 = var_78_10 / var_78_9
				local var_78_12 = Mathf.Max(var_78_9 / var_78_10, 1)

				var_78_6.transform.localScale = Vector3.New(var_78_6.transform.localScale.x * var_78_11, var_78_6.transform.localScale.y * var_78_12, var_78_6.transform.localScale.z)
			end

			local var_78_13 = manager.ui.mainCamera.transform
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_13.localPosition
			end

			local var_78_15 = 0.666666666666667

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / 0.066
				local var_78_17, var_78_18 = math.modf(var_78_16)

				var_78_13.localPosition = Vector3.New(var_78_18 * 0.13, var_78_18 * 0.13, var_78_18 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 then
				var_78_13.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_19 = 0
			local var_78_20 = 0.075

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_21 = arg_75_1:FormatText(StoryNameCfg[15].name)

				arg_75_1.leftNameTxt_.text = var_78_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_22 = arg_75_1:GetWordFromCfg(425121018)
				local var_78_23 = arg_75_1:FormatText(var_78_22.content)

				arg_75_1.text_.text = var_78_23

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_24 = 3
				local var_78_25 = utf8.len(var_78_23)
				local var_78_26 = var_78_24 <= 0 and var_78_20 or var_78_20 * (var_78_25 / var_78_24)

				if var_78_26 > 0 and var_78_20 < var_78_26 then
					arg_75_1.talkMaxDuration = var_78_26

					if var_78_26 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_26 + var_78_19
					end
				end

				arg_75_1.text_.text = var_78_23
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121018", "story_v_out_425121.awb") ~= 0 then
					local var_78_27 = manager.audio:GetVoiceLength("story_v_out_425121", "425121018", "story_v_out_425121.awb") / 1000

					if var_78_27 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_19
					end

					if var_78_22.prefab_name ~= "" and arg_75_1.actors_[var_78_22.prefab_name] ~= nil then
						local var_78_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_22.prefab_name].transform, "story_v_out_425121", "425121018", "story_v_out_425121.awb")

						arg_75_1:RecordAudio("425121018", var_78_28)
						arg_75_1:RecordAudio("425121018", var_78_28)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_425121", "425121018", "story_v_out_425121.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_425121", "425121018", "story_v_out_425121.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_29 = math.max(var_78_20, arg_75_1.talkMaxDuration)

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_29 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_19) / var_78_29

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_19 + var_78_29 and arg_75_1.time_ < var_78_19 + var_78_29 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play425121019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 425121019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play425121020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.2

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(425121019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 48
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play425121020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 425121020
		arg_83_1.duration_ = 4.03

		local var_83_0 = {
			zh = 3.2,
			ja = 4.033
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
				arg_83_0:Play425121021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.225

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[15].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(425121020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 9
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121020", "story_v_out_425121.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121020", "story_v_out_425121.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_425121", "425121020", "story_v_out_425121.awb")

						arg_83_1:RecordAudio("425121020", var_86_9)
						arg_83_1:RecordAudio("425121020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_425121", "425121020", "story_v_out_425121.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_425121", "425121020", "story_v_out_425121.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play425121021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 425121021
		arg_87_1.duration_ = 9.7

		local var_87_0 = {
			zh = 7.733,
			ja = 9.7
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
				arg_87_0:Play425121022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.675

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[36].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(425121021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 27
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121021", "story_v_out_425121.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121021", "story_v_out_425121.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_425121", "425121021", "story_v_out_425121.awb")

						arg_87_1:RecordAudio("425121021", var_90_9)
						arg_87_1:RecordAudio("425121021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_425121", "425121021", "story_v_out_425121.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_425121", "425121021", "story_v_out_425121.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play425121022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 425121022
		arg_91_1.duration_ = 2.07

		local var_91_0 = {
			zh = 2.066,
			ja = 1.6
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
				arg_91_0:Play425121023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.1

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[15].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(425121022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 4
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121022", "story_v_out_425121.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121022", "story_v_out_425121.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_425121", "425121022", "story_v_out_425121.awb")

						arg_91_1:RecordAudio("425121022", var_94_9)
						arg_91_1:RecordAudio("425121022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_425121", "425121022", "story_v_out_425121.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_425121", "425121022", "story_v_out_425121.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play425121023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 425121023
		arg_95_1.duration_ = 7.7

		local var_95_0 = {
			zh = 4.833,
			ja = 7.7
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
				arg_95_0:Play425121024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.425

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[36].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(425121023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 17
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121023", "story_v_out_425121.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121023", "story_v_out_425121.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_425121", "425121023", "story_v_out_425121.awb")

						arg_95_1:RecordAudio("425121023", var_98_9)
						arg_95_1:RecordAudio("425121023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_425121", "425121023", "story_v_out_425121.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_425121", "425121023", "story_v_out_425121.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play425121024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 425121024
		arg_99_1.duration_ = 11.03

		local var_99_0 = {
			zh = 9.86633366666666,
			ja = 11.0333336666667
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play425121025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.0333333333333332

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_1 = 1.2

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_1 then
				local var_102_2 = (arg_99_1.time_ - var_102_0) / var_102_1
				local var_102_3 = Color.New(0, 0, 0)

				var_102_3.a = Mathf.Lerp(0, 1, var_102_2)
				arg_99_1.mask_.color = var_102_3
			end

			if arg_99_1.time_ >= var_102_0 + var_102_1 and arg_99_1.time_ < var_102_0 + var_102_1 + arg_102_0 then
				local var_102_4 = Color.New(0, 0, 0)

				var_102_4.a = 1
				arg_99_1.mask_.color = var_102_4
			end

			local var_102_5 = 1.23333333333333

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_6 = 1.2

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6
				local var_102_8 = Color.New(0, 0, 0)

				var_102_8.a = Mathf.Lerp(1, 0, var_102_7)
				arg_99_1.mask_.color = var_102_8
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 then
				local var_102_9 = Color.New(0, 0, 0)
				local var_102_10 = 0

				arg_99_1.mask_.enabled = false
				var_102_9.a = var_102_10
				arg_99_1.mask_.color = var_102_9
			end

			local var_102_11 = 5.63333366666666

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			local var_102_12 = 0.3

			if arg_99_1.time_ >= var_102_11 + var_102_12 and arg_99_1.time_ < var_102_11 + var_102_12 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_13 = 1.23333333333333
			local var_102_14 = 1.999999999999
			local var_102_15 = "M01i"

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1.timestampController_:SetSelectedState("show")
				arg_99_1.timestampAni_:Play("in")

				arg_99_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_15)

				arg_99_1.timestampColorController_:SetSelectedState("hot")
				arg_99_1.timeColdImg_:SetAlpha(0.031)

				local var_102_16 = arg_99_1:GetWordFromCfg(501120)
				local var_102_17 = arg_99_1:FormatText(var_102_16.content)

				arg_99_1.text_timeText_.text = var_102_17

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_timeText_)

				local var_102_18 = arg_99_1:GetWordFromCfg(501121)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_siteText_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_siteText_)
			end

			if arg_99_1.time_ >= var_102_13 + var_102_14 and arg_99_1.time_ < var_102_13 + var_102_14 + arg_102_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_99_1.timestampAni_, "out", function()
					arg_99_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_102_20 = 3.23333366666666

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_21 = 1.2

			if var_102_20 <= arg_99_1.time_ and arg_99_1.time_ < var_102_20 + var_102_21 then
				local var_102_22 = (arg_99_1.time_ - var_102_20) / var_102_21
				local var_102_23 = Color.New(0, 0, 0)

				var_102_23.a = Mathf.Lerp(0, 1, var_102_22)
				arg_99_1.mask_.color = var_102_23
			end

			if arg_99_1.time_ >= var_102_20 + var_102_21 and arg_99_1.time_ < var_102_20 + var_102_21 + arg_102_0 then
				local var_102_24 = Color.New(0, 0, 0)

				var_102_24.a = 1
				arg_99_1.mask_.color = var_102_24
			end

			local var_102_25 = 4.43333366666666

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_26 = 1.2

			if var_102_25 <= arg_99_1.time_ and arg_99_1.time_ < var_102_25 + var_102_26 then
				local var_102_27 = (arg_99_1.time_ - var_102_25) / var_102_26
				local var_102_28 = Color.New(0, 0, 0)

				var_102_28.a = Mathf.Lerp(1, 0, var_102_27)
				arg_99_1.mask_.color = var_102_28
			end

			if arg_99_1.time_ >= var_102_25 + var_102_26 and arg_99_1.time_ < var_102_25 + var_102_26 + arg_102_0 then
				local var_102_29 = Color.New(0, 0, 0)
				local var_102_30 = 0

				arg_99_1.mask_.enabled = false
				var_102_29.a = var_102_30
				arg_99_1.mask_.color = var_102_29
			end

			local var_102_31 = "M01i"

			if arg_99_1.bgs_[var_102_31] == nil then
				local var_102_32 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_31)
				var_102_32.name = var_102_31
				var_102_32.transform.parent = arg_99_1.stage_.transform
				var_102_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_31] = var_102_32
			end

			local var_102_33 = 1.23333333333333

			if var_102_33 < arg_99_1.time_ and arg_99_1.time_ <= var_102_33 + arg_102_0 then
				local var_102_34 = manager.ui.mainCamera.transform.localPosition
				local var_102_35 = Vector3.New(0, 0, 10) + Vector3.New(var_102_34.x, var_102_34.y, 0)
				local var_102_36 = arg_99_1.bgs_.M01i

				var_102_36.transform.localPosition = var_102_35
				var_102_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_37 = var_102_36:GetComponent("SpriteRenderer")

				if var_102_37 and var_102_37.sprite then
					local var_102_38 = (var_102_36.transform.localPosition - var_102_34).z
					local var_102_39 = manager.ui.mainCameraCom_
					local var_102_40 = 2 * var_102_38 * Mathf.Tan(var_102_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_41 = var_102_40 * var_102_39.aspect
					local var_102_42 = var_102_37.sprite.bounds.size.x
					local var_102_43 = var_102_37.sprite.bounds.size.y
					local var_102_44 = var_102_41 / var_102_42
					local var_102_45 = var_102_40 / var_102_43
					local var_102_46 = var_102_45 < var_102_44 and var_102_44 or var_102_45

					var_102_36.transform.localScale = Vector3.New(var_102_46, var_102_46, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "M01i" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_47 = "1036"

			if arg_99_1.actors_[var_102_47] == nil then
				local var_102_48 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1036")

				if not isNil(var_102_48) then
					local var_102_49 = Object.Instantiate(var_102_48, arg_99_1.canvasGo_.transform)

					var_102_49.transform:SetSiblingIndex(1)

					var_102_49.name = var_102_47
					var_102_49.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_99_1.actors_[var_102_47] = var_102_49

					local var_102_50 = var_102_49:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_99_1.isInRecall_ then
						for iter_102_2, iter_102_3 in ipairs(var_102_50) do
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_102_51 = arg_99_1.actors_["1036"]
			local var_102_52 = 5.43333366666666

			if var_102_52 < arg_99_1.time_ and arg_99_1.time_ <= var_102_52 + arg_102_0 and not isNil(var_102_51) and arg_99_1.var_.actorSpriteComps1036 == nil then
				arg_99_1.var_.actorSpriteComps1036 = var_102_51:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_53 = 0.2

			if var_102_52 <= arg_99_1.time_ and arg_99_1.time_ < var_102_52 + var_102_53 and not isNil(var_102_51) then
				local var_102_54 = (arg_99_1.time_ - var_102_52) / var_102_53

				if arg_99_1.var_.actorSpriteComps1036 then
					for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_102_5 then
							if arg_99_1.isInRecall_ then
								local var_102_55 = Mathf.Lerp(iter_102_5.color.r, arg_99_1.hightColor1.r, var_102_54)
								local var_102_56 = Mathf.Lerp(iter_102_5.color.g, arg_99_1.hightColor1.g, var_102_54)
								local var_102_57 = Mathf.Lerp(iter_102_5.color.b, arg_99_1.hightColor1.b, var_102_54)

								iter_102_5.color = Color.New(var_102_55, var_102_56, var_102_57)
							else
								local var_102_58 = Mathf.Lerp(iter_102_5.color.r, 1, var_102_54)

								iter_102_5.color = Color.New(var_102_58, var_102_58, var_102_58)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_52 + var_102_53 and arg_99_1.time_ < var_102_52 + var_102_53 + arg_102_0 and not isNil(var_102_51) and arg_99_1.var_.actorSpriteComps1036 then
				for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_102_7 then
						if arg_99_1.isInRecall_ then
							iter_102_7.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1036 = nil
			end

			local var_102_59 = arg_99_1.actors_["1036"].transform
			local var_102_60 = 5.43333366666666

			if var_102_60 < arg_99_1.time_ and arg_99_1.time_ <= var_102_60 + arg_102_0 then
				arg_99_1.var_.moveOldPos1036 = var_102_59.localPosition
				var_102_59.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1036", 3)

				local var_102_61 = var_102_59.childCount

				for iter_102_8 = 0, var_102_61 - 1 do
					local var_102_62 = var_102_59:GetChild(iter_102_8)

					if var_102_62.name == "" or not string.find(var_102_62.name, "split") then
						var_102_62.gameObject:SetActive(true)
					else
						var_102_62.gameObject:SetActive(false)
					end
				end
			end

			local var_102_63 = 0.001

			if var_102_60 <= arg_99_1.time_ and arg_99_1.time_ < var_102_60 + var_102_63 then
				local var_102_64 = (arg_99_1.time_ - var_102_60) / var_102_63
				local var_102_65 = Vector3.New(0, -388, -250)

				var_102_59.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1036, var_102_65, var_102_64)
			end

			if arg_99_1.time_ >= var_102_60 + var_102_63 and arg_99_1.time_ < var_102_60 + var_102_63 + arg_102_0 then
				var_102_59.localPosition = Vector3.New(0, -388, -250)
			end

			local var_102_66 = 0.133333333333333
			local var_102_67 = 0.3

			if var_102_66 < arg_99_1.time_ and arg_99_1.time_ <= var_102_66 + arg_102_0 then
				local var_102_68 = "play"
				local var_102_69 = "music"

				arg_99_1:AudioAction(var_102_68, var_102_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_102_70 = ""
				local var_102_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_102_71 ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_71 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_71

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_71
						arg_99_1.bgmTxt2_.text = var_102_71
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

			local var_102_72 = 4.06666666666667
			local var_102_73 = 1

			if var_102_72 < arg_99_1.time_ and arg_99_1.time_ <= var_102_72 + arg_102_0 then
				local var_102_74 = "play"
				local var_102_75 = "music"

				arg_99_1:AudioAction(var_102_74, var_102_75, "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_102_76 = ""
				local var_102_77 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

				if var_102_77 ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_77 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_77

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_77
						arg_99_1.bgmTxt2_.text = var_102_77
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

			local var_102_78 = 0.133333333333333
			local var_102_79 = 1

			if var_102_78 < arg_99_1.time_ and arg_99_1.time_ <= var_102_78 + arg_102_0 then
				local var_102_80 = "stop"
				local var_102_81 = "effect"

				arg_99_1:AudioAction(var_102_80, var_102_81, "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_102_82 = 4.06666666666667
			local var_102_83 = 1

			if var_102_82 < arg_99_1.time_ and arg_99_1.time_ <= var_102_82 + arg_102_0 then
				local var_102_84 = "play"
				local var_102_85 = "effect"

				arg_99_1:AudioAction(var_102_84, var_102_85, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_102_86 = manager.ui.mainCamera.transform
			local var_102_87 = 1.23333333333333

			if var_102_87 < arg_99_1.time_ and arg_99_1.time_ <= var_102_87 + arg_102_0 then
				local var_102_88 = arg_99_1.var_.effect10091018

				if var_102_88 then
					Object.Destroy(var_102_88)

					arg_99_1.var_.effect10091018 = nil
				end
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_89 = 5.63333366666666
			local var_102_90 = 0.6

			if var_102_89 < arg_99_1.time_ and arg_99_1.time_ <= var_102_89 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_91 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_91:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_99_1.dialogCg_.alpha = arg_106_0
				end))
				var_102_91:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_91:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_92 = arg_99_1:FormatText(StoryNameCfg[5].name)

				arg_99_1.leftNameTxt_.text = var_102_92

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_93 = arg_99_1:GetWordFromCfg(425121024)
				local var_102_94 = arg_99_1:FormatText(var_102_93.content)

				arg_99_1.text_.text = var_102_94

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_95 = 24
				local var_102_96 = utf8.len(var_102_94)
				local var_102_97 = var_102_95 <= 0 and var_102_90 or var_102_90 * (var_102_96 / var_102_95)

				if var_102_97 > 0 and var_102_90 < var_102_97 then
					arg_99_1.talkMaxDuration = var_102_97
					var_102_89 = var_102_89 + 0.3

					if var_102_97 + var_102_89 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_97 + var_102_89
					end
				end

				arg_99_1.text_.text = var_102_94
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121024", "story_v_out_425121.awb") ~= 0 then
					local var_102_98 = manager.audio:GetVoiceLength("story_v_out_425121", "425121024", "story_v_out_425121.awb") / 1000

					if var_102_98 + var_102_89 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_98 + var_102_89
					end

					if var_102_93.prefab_name ~= "" and arg_99_1.actors_[var_102_93.prefab_name] ~= nil then
						local var_102_99 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_93.prefab_name].transform, "story_v_out_425121", "425121024", "story_v_out_425121.awb")

						arg_99_1:RecordAudio("425121024", var_102_99)
						arg_99_1:RecordAudio("425121024", var_102_99)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_425121", "425121024", "story_v_out_425121.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_425121", "425121024", "story_v_out_425121.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_100 = var_102_89 + 0.3
			local var_102_101 = math.max(var_102_90, arg_99_1.talkMaxDuration)

			if var_102_100 <= arg_99_1.time_ and arg_99_1.time_ < var_102_100 + var_102_101 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_100) / var_102_101

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_100 + var_102_101 and arg_99_1.time_ < var_102_100 + var_102_101 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.43333366666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play425121025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 425121025
		arg_108_1.duration_ = 5

		local var_108_0 = {
			zh = 3.533,
			ja = 5
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
				arg_108_0:Play425121026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1036"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1036 == nil then
				arg_108_1.var_.actorSpriteComps1036 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1036 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 0.5, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1036 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1036 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.4

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[1082].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_11 = arg_108_1:GetWordFromCfg(425121025)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121025", "story_v_out_425121.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121025", "story_v_out_425121.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_425121", "425121025", "story_v_out_425121.awb")

						arg_108_1:RecordAudio("425121025", var_111_17)
						arg_108_1:RecordAudio("425121025", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_425121", "425121025", "story_v_out_425121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_425121", "425121025", "story_v_out_425121.awb")
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
	Play425121026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 425121026
		arg_112_1.duration_ = 4.67

		local var_112_0 = {
			zh = 2.933,
			ja = 4.666
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
				arg_112_0:Play425121027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1036"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1036 == nil then
				arg_112_1.var_.actorSpriteComps1036 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1036 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1036 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1036 = nil
			end

			local var_115_8 = arg_112_1.actors_["1036"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos1036 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1036", 3)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "" or not string.find(var_115_11.name, "split") then
						var_115_11.gameObject:SetActive(true)
					else
						var_115_11.gameObject:SetActive(false)
					end
				end
			end

			local var_115_12 = 0.001

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(0, -388, -250)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1036, var_115_14, var_115_13)
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_115_15 = 0
			local var_115_16 = 0.375

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[5].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(425121026)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 15
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121026", "story_v_out_425121.awb") ~= 0 then
					local var_115_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121026", "story_v_out_425121.awb") / 1000

					if var_115_23 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_15
					end

					if var_115_18.prefab_name ~= "" and arg_112_1.actors_[var_115_18.prefab_name] ~= nil then
						local var_115_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_18.prefab_name].transform, "story_v_out_425121", "425121026", "story_v_out_425121.awb")

						arg_112_1:RecordAudio("425121026", var_115_24)
						arg_112_1:RecordAudio("425121026", var_115_24)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_425121", "425121026", "story_v_out_425121.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_425121", "425121026", "story_v_out_425121.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_25 and arg_112_1.time_ < var_115_15 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425121027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425121027
		arg_116_1.duration_ = 4.47

		local var_116_0 = {
			zh = 2.466,
			ja = 4.466
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
				arg_116_0:Play425121028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1036"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1036 == nil then
				arg_116_1.var_.actorSpriteComps1036 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1036 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1036 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1036 = nil
			end

			local var_119_8 = 0
			local var_119_9 = 0.325

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_10 = arg_116_1:FormatText(StoryNameCfg[1082].name)

				arg_116_1.leftNameTxt_.text = var_119_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_11 = arg_116_1:GetWordFromCfg(425121027)
				local var_119_12 = arg_116_1:FormatText(var_119_11.content)

				arg_116_1.text_.text = var_119_12

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 13
				local var_119_14 = utf8.len(var_119_12)
				local var_119_15 = var_119_13 <= 0 and var_119_9 or var_119_9 * (var_119_14 / var_119_13)

				if var_119_15 > 0 and var_119_9 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_12
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121027", "story_v_out_425121.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121027", "story_v_out_425121.awb") / 1000

					if var_119_16 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_8
					end

					if var_119_11.prefab_name ~= "" and arg_116_1.actors_[var_119_11.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_11.prefab_name].transform, "story_v_out_425121", "425121027", "story_v_out_425121.awb")

						arg_116_1:RecordAudio("425121027", var_119_17)
						arg_116_1:RecordAudio("425121027", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425121", "425121027", "story_v_out_425121.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425121", "425121027", "story_v_out_425121.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_18 and arg_116_1.time_ < var_119_8 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425121028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425121028
		arg_120_1.duration_ = 10.83

		local var_120_0 = {
			zh = 10.3,
			ja = 10.833
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
				arg_120_0:Play425121029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.175

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1082].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(425121028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121028", "story_v_out_425121.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121028", "story_v_out_425121.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_425121", "425121028", "story_v_out_425121.awb")

						arg_120_1:RecordAudio("425121028", var_123_9)
						arg_120_1:RecordAudio("425121028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_425121", "425121028", "story_v_out_425121.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_425121", "425121028", "story_v_out_425121.awb")
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
	Play425121029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425121029
		arg_124_1.duration_ = 11.67

		local var_124_0 = {
			zh = 6.4,
			ja = 11.666
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
				arg_124_0:Play425121030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.8

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[1082].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(425121029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121029", "story_v_out_425121.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121029", "story_v_out_425121.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_425121", "425121029", "story_v_out_425121.awb")

						arg_124_1:RecordAudio("425121029", var_127_9)
						arg_124_1:RecordAudio("425121029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_425121", "425121029", "story_v_out_425121.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_425121", "425121029", "story_v_out_425121.awb")
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
	Play425121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425121030
		arg_128_1.duration_ = 8.37

		local var_128_0 = {
			zh = 5.5,
			ja = 8.366
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
				arg_128_0:Play425121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1036"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1036 == nil then
				arg_128_1.var_.actorSpriteComps1036 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1036 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 1, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1036 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1036 = nil
			end

			local var_131_8 = arg_128_1.actors_["1036"].transform
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.var_.moveOldPos1036 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1036", 3)

				local var_131_10 = var_131_8.childCount

				for iter_131_4 = 0, var_131_10 - 1 do
					local var_131_11 = var_131_8:GetChild(iter_131_4)

					if var_131_11.name == "" or not string.find(var_131_11.name, "split") then
						var_131_11.gameObject:SetActive(true)
					else
						var_131_11.gameObject:SetActive(false)
					end
				end
			end

			local var_131_12 = 0.001

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_12 then
				local var_131_13 = (arg_128_1.time_ - var_131_9) / var_131_12
				local var_131_14 = Vector3.New(0, -388, -250)

				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1036, var_131_14, var_131_13)
			end

			if arg_128_1.time_ >= var_131_9 + var_131_12 and arg_128_1.time_ < var_131_9 + var_131_12 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_131_15 = 0
			local var_131_16 = 0.75

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[5].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(425121030)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121030", "story_v_out_425121.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121030", "story_v_out_425121.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_425121", "425121030", "story_v_out_425121.awb")

						arg_128_1:RecordAudio("425121030", var_131_24)
						arg_128_1:RecordAudio("425121030", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425121", "425121030", "story_v_out_425121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425121", "425121030", "story_v_out_425121.awb")
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
				actorName = "1036",
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
	Play425121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425121031
		arg_132_1.duration_ = 17

		local var_132_0 = {
			zh = 9.333,
			ja = 17
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
				arg_132_0:Play425121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1.35

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[5].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(425121031)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121031", "story_v_out_425121.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121031", "story_v_out_425121.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_425121", "425121031", "story_v_out_425121.awb")

						arg_132_1:RecordAudio("425121031", var_135_9)
						arg_132_1:RecordAudio("425121031", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_425121", "425121031", "story_v_out_425121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_425121", "425121031", "story_v_out_425121.awb")
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
	Play425121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425121032
		arg_136_1.duration_ = 10.37

		local var_136_0 = {
			zh = 7.533,
			ja = 10.366
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
				arg_136_0:Play425121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1036"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1036 = var_139_0.localPosition
				var_139_0.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1036", 3)

				local var_139_2 = var_139_0.childCount

				for iter_139_0 = 0, var_139_2 - 1 do
					local var_139_3 = var_139_0:GetChild(iter_139_0)

					if var_139_3.name == "" or not string.find(var_139_3.name, "split") then
						var_139_3.gameObject:SetActive(true)
					else
						var_139_3.gameObject:SetActive(false)
					end
				end
			end

			local var_139_4 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_4 then
				local var_139_5 = (arg_136_1.time_ - var_139_1) / var_139_4
				local var_139_6 = Vector3.New(0, -388, -250)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1036, var_139_6, var_139_5)
			end

			if arg_136_1.time_ >= var_139_1 + var_139_4 and arg_136_1.time_ < var_139_1 + var_139_4 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -388, -250)
			end

			local var_139_7 = 0
			local var_139_8 = 0.95

			if var_139_7 < arg_136_1.time_ and arg_136_1.time_ <= var_139_7 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_9 = arg_136_1:FormatText(StoryNameCfg[5].name)

				arg_136_1.leftNameTxt_.text = var_139_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(425121032)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_12 = 38
				local var_139_13 = utf8.len(var_139_11)
				local var_139_14 = var_139_12 <= 0 and var_139_8 or var_139_8 * (var_139_13 / var_139_12)

				if var_139_14 > 0 and var_139_8 < var_139_14 then
					arg_136_1.talkMaxDuration = var_139_14

					if var_139_14 + var_139_7 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_7
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121032", "story_v_out_425121.awb") ~= 0 then
					local var_139_15 = manager.audio:GetVoiceLength("story_v_out_425121", "425121032", "story_v_out_425121.awb") / 1000

					if var_139_15 + var_139_7 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_7
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_425121", "425121032", "story_v_out_425121.awb")

						arg_136_1:RecordAudio("425121032", var_139_16)
						arg_136_1:RecordAudio("425121032", var_139_16)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425121", "425121032", "story_v_out_425121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425121", "425121032", "story_v_out_425121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_17 = math.max(var_139_8, arg_136_1.talkMaxDuration)

			if var_139_7 <= arg_136_1.time_ and arg_136_1.time_ < var_139_7 + var_139_17 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_7) / var_139_17

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_7 + var_139_17 and arg_136_1.time_ < var_139_7 + var_139_17 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play425121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425121033
		arg_140_1.duration_ = 6.07

		local var_140_0 = {
			zh = 5.4,
			ja = 6.066
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
				arg_140_0:Play425121034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1036"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1036 == nil then
				arg_140_1.var_.actorSpriteComps1036 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1036 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 0.5, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1036 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1036 = nil
			end

			local var_143_8 = 0
			local var_143_9 = 0.5

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_10 = arg_140_1:FormatText(StoryNameCfg[1082].name)

				arg_140_1.leftNameTxt_.text = var_143_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_11 = arg_140_1:GetWordFromCfg(425121033)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 20
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_9 or var_143_9 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_9 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121033", "story_v_out_425121.awb") ~= 0 then
					local var_143_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121033", "story_v_out_425121.awb") / 1000

					if var_143_16 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_16 + var_143_8
					end

					if var_143_11.prefab_name ~= "" and arg_140_1.actors_[var_143_11.prefab_name] ~= nil then
						local var_143_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_11.prefab_name].transform, "story_v_out_425121", "425121033", "story_v_out_425121.awb")

						arg_140_1:RecordAudio("425121033", var_143_17)
						arg_140_1:RecordAudio("425121033", var_143_17)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425121", "425121033", "story_v_out_425121.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425121", "425121033", "story_v_out_425121.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_18 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_18 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_18

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_18 and arg_140_1.time_ < var_143_8 + var_143_18 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play425121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play425121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1036"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1036 = var_147_0.localPosition
				var_147_0.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1036", 7)

				local var_147_2 = var_147_0.childCount

				for iter_147_0 = 0, var_147_2 - 1 do
					local var_147_3 = var_147_0:GetChild(iter_147_0)

					if var_147_3.name == "" or not string.find(var_147_3.name, "split") then
						var_147_3.gameObject:SetActive(true)
					else
						var_147_3.gameObject:SetActive(false)
					end
				end
			end

			local var_147_4 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_4 then
				local var_147_5 = (arg_144_1.time_ - var_147_1) / var_147_4
				local var_147_6 = Vector3.New(0, -2000, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1036, var_147_6, var_147_5)
			end

			if arg_144_1.time_ >= var_147_1 + var_147_4 and arg_144_1.time_ < var_147_1 + var_147_4 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_7 = 0
			local var_147_8 = 0.6

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(425121034)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 24
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_8 or var_147_8 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_8 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_7 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_7
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_8, arg_144_1.talkMaxDuration)

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_7) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_7 + var_147_14 and arg_144_1.time_ < var_147_7 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425121035
		arg_148_1.duration_ = 5.63

		local var_148_0 = {
			zh = 4.4,
			ja = 5.633
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
				arg_148_0:Play425121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1036"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1036 == nil then
				arg_148_1.var_.actorSpriteComps1036 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1036 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1036 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1036 = nil
			end

			local var_151_8 = arg_148_1.actors_["1036"].transform
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.var_.moveOldPos1036 = var_151_8.localPosition
				var_151_8.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1036", 3)

				local var_151_10 = var_151_8.childCount

				for iter_151_4 = 0, var_151_10 - 1 do
					local var_151_11 = var_151_8:GetChild(iter_151_4)

					if var_151_11.name == "" or not string.find(var_151_11.name, "split") then
						var_151_11.gameObject:SetActive(true)
					else
						var_151_11.gameObject:SetActive(false)
					end
				end
			end

			local var_151_12 = 0.001

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_9) / var_151_12
				local var_151_14 = Vector3.New(0, -388, -250)

				var_151_8.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1036, var_151_14, var_151_13)
			end

			if arg_148_1.time_ >= var_151_9 + var_151_12 and arg_148_1.time_ < var_151_9 + var_151_12 + arg_151_0 then
				var_151_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_151_15 = 0
			local var_151_16 = 0.55

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[5].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(425121035)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 22
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121035", "story_v_out_425121.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121035", "story_v_out_425121.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_425121", "425121035", "story_v_out_425121.awb")

						arg_148_1:RecordAudio("425121035", var_151_24)
						arg_148_1:RecordAudio("425121035", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425121", "425121035", "story_v_out_425121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425121", "425121035", "story_v_out_425121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play425121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 425121036
		arg_152_1.duration_ = 4.43

		local var_152_0 = {
			zh = 4,
			ja = 4.433
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play425121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1036"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1036 == nil then
				arg_152_1.var_.actorSpriteComps1036 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1036 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 0.5, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1036 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1036 = nil
			end

			local var_155_8 = 0
			local var_155_9 = 0.35

			if var_155_8 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_10 = arg_152_1:FormatText(StoryNameCfg[1082].name)

				arg_152_1.leftNameTxt_.text = var_155_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_11 = arg_152_1:GetWordFromCfg(425121036)
				local var_155_12 = arg_152_1:FormatText(var_155_11.content)

				arg_152_1.text_.text = var_155_12

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 14
				local var_155_14 = utf8.len(var_155_12)
				local var_155_15 = var_155_13 <= 0 and var_155_9 or var_155_9 * (var_155_14 / var_155_13)

				if var_155_15 > 0 and var_155_9 < var_155_15 then
					arg_152_1.talkMaxDuration = var_155_15

					if var_155_15 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_15 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_12
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121036", "story_v_out_425121.awb") ~= 0 then
					local var_155_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121036", "story_v_out_425121.awb") / 1000

					if var_155_16 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_8
					end

					if var_155_11.prefab_name ~= "" and arg_152_1.actors_[var_155_11.prefab_name] ~= nil then
						local var_155_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_11.prefab_name].transform, "story_v_out_425121", "425121036", "story_v_out_425121.awb")

						arg_152_1:RecordAudio("425121036", var_155_17)
						arg_152_1:RecordAudio("425121036", var_155_17)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_425121", "425121036", "story_v_out_425121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_425121", "425121036", "story_v_out_425121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_18 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_18 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_18

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_18 and arg_152_1.time_ < var_155_8 + var_155_18 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play425121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 425121037
		arg_156_1.duration_ = 5.5

		local var_156_0 = {
			zh = 5.3,
			ja = 5.5
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
				arg_156_0:Play425121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 2

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				local var_159_1 = manager.ui.mainCamera.transform.localPosition
				local var_159_2 = Vector3.New(0, 0, 10) + Vector3.New(var_159_1.x, var_159_1.y, 0)
				local var_159_3 = arg_156_1.bgs_.M01i

				var_159_3.transform.localPosition = var_159_2
				var_159_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_4 = var_159_3:GetComponent("SpriteRenderer")

				if var_159_4 and var_159_4.sprite then
					local var_159_5 = (var_159_3.transform.localPosition - var_159_1).z
					local var_159_6 = manager.ui.mainCameraCom_
					local var_159_7 = 2 * var_159_5 * Mathf.Tan(var_159_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_8 = var_159_7 * var_159_6.aspect
					local var_159_9 = var_159_4.sprite.bounds.size.x
					local var_159_10 = var_159_4.sprite.bounds.size.y
					local var_159_11 = var_159_8 / var_159_9
					local var_159_12 = var_159_7 / var_159_10
					local var_159_13 = var_159_12 < var_159_11 and var_159_11 or var_159_12

					var_159_3.transform.localScale = Vector3.New(var_159_13, var_159_13, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "M01i" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_14 = 4

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_15 = 0.0999999999999996

			if arg_156_1.time_ >= var_159_14 + var_159_15 and arg_156_1.time_ < var_159_14 + var_159_15 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_17 = 2

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 then
				local var_159_18 = (arg_156_1.time_ - var_159_16) / var_159_17
				local var_159_19 = Color.New(0, 0, 0)

				var_159_19.a = Mathf.Lerp(0, 1, var_159_18)
				arg_156_1.mask_.color = var_159_19
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				local var_159_20 = Color.New(0, 0, 0)

				var_159_20.a = 1
				arg_156_1.mask_.color = var_159_20
			end

			local var_159_21 = 2

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_22 = 2

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_22 then
				local var_159_23 = (arg_156_1.time_ - var_159_21) / var_159_22
				local var_159_24 = Color.New(0, 0, 0)

				var_159_24.a = Mathf.Lerp(1, 0, var_159_23)
				arg_156_1.mask_.color = var_159_24
			end

			if arg_156_1.time_ >= var_159_21 + var_159_22 and arg_156_1.time_ < var_159_21 + var_159_22 + arg_159_0 then
				local var_159_25 = Color.New(0, 0, 0)
				local var_159_26 = 0

				arg_156_1.mask_.enabled = false
				var_159_25.a = var_159_26
				arg_156_1.mask_.color = var_159_25
			end

			local var_159_27 = arg_156_1.actors_["1036"].transform
			local var_159_28 = 1.96666666666667

			if var_159_28 < arg_156_1.time_ and arg_156_1.time_ <= var_159_28 + arg_159_0 then
				arg_156_1.var_.moveOldPos1036 = var_159_27.localPosition
				var_159_27.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1036", 7)

				local var_159_29 = var_159_27.childCount

				for iter_159_2 = 0, var_159_29 - 1 do
					local var_159_30 = var_159_27:GetChild(iter_159_2)

					if var_159_30.name == "" or not string.find(var_159_30.name, "split") then
						var_159_30.gameObject:SetActive(true)
					else
						var_159_30.gameObject:SetActive(false)
					end
				end
			end

			local var_159_31 = 0.001

			if var_159_28 <= arg_156_1.time_ and arg_156_1.time_ < var_159_28 + var_159_31 then
				local var_159_32 = (arg_156_1.time_ - var_159_28) / var_159_31
				local var_159_33 = Vector3.New(0, -2000, 0)

				var_159_27.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1036, var_159_33, var_159_32)
			end

			if arg_156_1.time_ >= var_159_28 + var_159_31 and arg_156_1.time_ < var_159_28 + var_159_31 + arg_159_0 then
				var_159_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_34 = 4
			local var_159_35 = 0.1

			if var_159_34 < arg_156_1.time_ and arg_156_1.time_ <= var_159_34 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_36 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_36:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_37 = arg_156_1:FormatText(StoryNameCfg[5].name)

				arg_156_1.leftNameTxt_.text = var_159_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_38 = arg_156_1:GetWordFromCfg(425121037)
				local var_159_39 = arg_156_1:FormatText(var_159_38.content)

				arg_156_1.text_.text = var_159_39

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_40 = 4
				local var_159_41 = utf8.len(var_159_39)
				local var_159_42 = var_159_40 <= 0 and var_159_35 or var_159_35 * (var_159_41 / var_159_40)

				if var_159_42 > 0 and var_159_35 < var_159_42 then
					arg_156_1.talkMaxDuration = var_159_42
					var_159_34 = var_159_34 + 0.3

					if var_159_42 + var_159_34 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_42 + var_159_34
					end
				end

				arg_156_1.text_.text = var_159_39
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121037", "story_v_out_425121.awb") ~= 0 then
					local var_159_43 = manager.audio:GetVoiceLength("story_v_out_425121", "425121037", "story_v_out_425121.awb") / 1000

					if var_159_43 + var_159_34 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_43 + var_159_34
					end

					if var_159_38.prefab_name ~= "" and arg_156_1.actors_[var_159_38.prefab_name] ~= nil then
						local var_159_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_38.prefab_name].transform, "story_v_out_425121", "425121037", "story_v_out_425121.awb")

						arg_156_1:RecordAudio("425121037", var_159_44)
						arg_156_1:RecordAudio("425121037", var_159_44)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_425121", "425121037", "story_v_out_425121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_425121", "425121037", "story_v_out_425121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_45 = var_159_34 + 0.3
			local var_159_46 = math.max(var_159_35, arg_156_1.talkMaxDuration)

			if var_159_45 <= arg_156_1.time_ and arg_156_1.time_ < var_159_45 + var_159_46 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_45) / var_159_46

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_45 + var_159_46 and arg_156_1.time_ < var_159_45 + var_159_46 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play425121038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 425121038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play425121039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1036"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1036 == nil then
				arg_162_1.var_.actorSpriteComps1036 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps1036 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 0.5, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps1036 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_165_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps1036 = nil
			end

			local var_165_8 = 0
			local var_165_9 = 0.625

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_10 = arg_162_1:GetWordFromCfg(425121038)
				local var_165_11 = arg_162_1:FormatText(var_165_10.content)

				arg_162_1.text_.text = var_165_11

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_12 = 25
				local var_165_13 = utf8.len(var_165_11)
				local var_165_14 = var_165_12 <= 0 and var_165_9 or var_165_9 * (var_165_13 / var_165_12)

				if var_165_14 > 0 and var_165_9 < var_165_14 then
					arg_162_1.talkMaxDuration = var_165_14

					if var_165_14 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_11
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_15 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_15 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_15

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_15 and arg_162_1.time_ < var_165_8 + var_165_15 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play425121039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 425121039
		arg_166_1.duration_ = 1.67

		local var_166_0 = {
			zh = 1.466,
			ja = 1.666
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
				arg_166_0:Play425121040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = "1137"

			if arg_166_1.actors_[var_169_0] == nil then
				local var_169_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_169_1) then
					local var_169_2 = Object.Instantiate(var_169_1, arg_166_1.canvasGo_.transform)

					var_169_2.transform:SetSiblingIndex(1)

					var_169_2.name = var_169_0
					var_169_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_166_1.actors_[var_169_0] = var_169_2

					local var_169_3 = var_169_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_166_1.isInRecall_ then
						for iter_169_0, iter_169_1 in ipairs(var_169_3) do
							iter_169_1.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_169_4 = arg_166_1.actors_["1137"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.actorSpriteComps1137 == nil then
				arg_166_1.var_.actorSpriteComps1137 = var_169_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_6 = 0.2

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.actorSpriteComps1137 then
					for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_169_3 then
							if arg_166_1.isInRecall_ then
								local var_169_8 = Mathf.Lerp(iter_169_3.color.r, arg_166_1.hightColor1.r, var_169_7)
								local var_169_9 = Mathf.Lerp(iter_169_3.color.g, arg_166_1.hightColor1.g, var_169_7)
								local var_169_10 = Mathf.Lerp(iter_169_3.color.b, arg_166_1.hightColor1.b, var_169_7)

								iter_169_3.color = Color.New(var_169_8, var_169_9, var_169_10)
							else
								local var_169_11 = Mathf.Lerp(iter_169_3.color.r, 1, var_169_7)

								iter_169_3.color = Color.New(var_169_11, var_169_11, var_169_11)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.actorSpriteComps1137 then
				for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_169_5 then
						if arg_166_1.isInRecall_ then
							iter_169_5.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1137 = nil
			end

			local var_169_12 = arg_166_1.actors_["1137"].transform
			local var_169_13 = 0

			if var_169_13 < arg_166_1.time_ and arg_166_1.time_ <= var_169_13 + arg_169_0 then
				arg_166_1.var_.moveOldPos1137 = var_169_12.localPosition
				var_169_12.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1137", 2)

				local var_169_14 = var_169_12.childCount

				for iter_169_6 = 0, var_169_14 - 1 do
					local var_169_15 = var_169_12:GetChild(iter_169_6)

					if var_169_15.name == "split_5" or not string.find(var_169_15.name, "split") then
						var_169_15.gameObject:SetActive(true)
					else
						var_169_15.gameObject:SetActive(false)
					end
				end
			end

			local var_169_16 = 0.001

			if var_169_13 <= arg_166_1.time_ and arg_166_1.time_ < var_169_13 + var_169_16 then
				local var_169_17 = (arg_166_1.time_ - var_169_13) / var_169_16
				local var_169_18 = Vector3.New(-390, -425, -200)

				var_169_12.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1137, var_169_18, var_169_17)
			end

			if arg_166_1.time_ >= var_169_13 + var_169_16 and arg_166_1.time_ < var_169_13 + var_169_16 + arg_169_0 then
				var_169_12.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_169_19 = 0
			local var_169_20 = 0.075

			if var_169_19 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_21 = arg_166_1:FormatText(StoryNameCfg[15].name)

				arg_166_1.leftNameTxt_.text = var_169_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_22 = arg_166_1:GetWordFromCfg(425121039)
				local var_169_23 = arg_166_1:FormatText(var_169_22.content)

				arg_166_1.text_.text = var_169_23

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_24 = 3
				local var_169_25 = utf8.len(var_169_23)
				local var_169_26 = var_169_24 <= 0 and var_169_20 or var_169_20 * (var_169_25 / var_169_24)

				if var_169_26 > 0 and var_169_20 < var_169_26 then
					arg_166_1.talkMaxDuration = var_169_26

					if var_169_26 + var_169_19 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_26 + var_169_19
					end
				end

				arg_166_1.text_.text = var_169_23
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121039", "story_v_out_425121.awb") ~= 0 then
					local var_169_27 = manager.audio:GetVoiceLength("story_v_out_425121", "425121039", "story_v_out_425121.awb") / 1000

					if var_169_27 + var_169_19 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_27 + var_169_19
					end

					if var_169_22.prefab_name ~= "" and arg_166_1.actors_[var_169_22.prefab_name] ~= nil then
						local var_169_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_22.prefab_name].transform, "story_v_out_425121", "425121039", "story_v_out_425121.awb")

						arg_166_1:RecordAudio("425121039", var_169_28)
						arg_166_1:RecordAudio("425121039", var_169_28)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_425121", "425121039", "story_v_out_425121.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_425121", "425121039", "story_v_out_425121.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_29 = math.max(var_169_20, arg_166_1.talkMaxDuration)

			if var_169_19 <= arg_166_1.time_ and arg_166_1.time_ < var_169_19 + var_169_29 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_19) / var_169_29

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_19 + var_169_29 and arg_166_1.time_ < var_169_19 + var_169_29 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play425121040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 425121040
		arg_170_1.duration_ = 1.93

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play425121041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1036"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1036 == nil then
				arg_170_1.var_.actorSpriteComps1036 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps1036 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1036 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1036 = nil
			end

			local var_173_8 = arg_170_1.actors_["1137"]
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps1137 == nil then
				arg_170_1.var_.actorSpriteComps1137 = var_173_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_10 = 0.2

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 and not isNil(var_173_8) then
				local var_173_11 = (arg_170_1.time_ - var_173_9) / var_173_10

				if arg_170_1.var_.actorSpriteComps1137 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								local var_173_12 = Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, var_173_11)
								local var_173_13 = Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, var_173_11)
								local var_173_14 = Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, var_173_11)

								iter_173_5.color = Color.New(var_173_12, var_173_13, var_173_14)
							else
								local var_173_15 = Mathf.Lerp(iter_173_5.color.r, 0.5, var_173_11)

								iter_173_5.color = Color.New(var_173_15, var_173_15, var_173_15)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps1137 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_173_7 then
						if arg_170_1.isInRecall_ then
							iter_173_7.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1137 = nil
			end

			local var_173_16 = arg_170_1.actors_["1036"].transform
			local var_173_17 = 0

			if var_173_17 < arg_170_1.time_ and arg_170_1.time_ <= var_173_17 + arg_173_0 then
				arg_170_1.var_.moveOldPos1036 = var_173_16.localPosition
				var_173_16.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1036", 4)

				local var_173_18 = var_173_16.childCount

				for iter_173_8 = 0, var_173_18 - 1 do
					local var_173_19 = var_173_16:GetChild(iter_173_8)

					if var_173_19.name == "" or not string.find(var_173_19.name, "split") then
						var_173_19.gameObject:SetActive(true)
					else
						var_173_19.gameObject:SetActive(false)
					end
				end
			end

			local var_173_20 = 0.001

			if var_173_17 <= arg_170_1.time_ and arg_170_1.time_ < var_173_17 + var_173_20 then
				local var_173_21 = (arg_170_1.time_ - var_173_17) / var_173_20
				local var_173_22 = Vector3.New(390, -388, -250)

				var_173_16.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1036, var_173_22, var_173_21)
			end

			if arg_170_1.time_ >= var_173_17 + var_173_20 and arg_170_1.time_ < var_173_17 + var_173_20 + arg_173_0 then
				var_173_16.localPosition = Vector3.New(390, -388, -250)
			end

			local var_173_23 = 0
			local var_173_24 = 0.2

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_25 = arg_170_1:FormatText(StoryNameCfg[5].name)

				arg_170_1.leftNameTxt_.text = var_173_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_26 = arg_170_1:GetWordFromCfg(425121040)
				local var_173_27 = arg_170_1:FormatText(var_173_26.content)

				arg_170_1.text_.text = var_173_27

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_28 = 8
				local var_173_29 = utf8.len(var_173_27)
				local var_173_30 = var_173_28 <= 0 and var_173_24 or var_173_24 * (var_173_29 / var_173_28)

				if var_173_30 > 0 and var_173_24 < var_173_30 then
					arg_170_1.talkMaxDuration = var_173_30

					if var_173_30 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_30 + var_173_23
					end
				end

				arg_170_1.text_.text = var_173_27
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121040", "story_v_out_425121.awb") ~= 0 then
					local var_173_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121040", "story_v_out_425121.awb") / 1000

					if var_173_31 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_31 + var_173_23
					end

					if var_173_26.prefab_name ~= "" and arg_170_1.actors_[var_173_26.prefab_name] ~= nil then
						local var_173_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_26.prefab_name].transform, "story_v_out_425121", "425121040", "story_v_out_425121.awb")

						arg_170_1:RecordAudio("425121040", var_173_32)
						arg_170_1:RecordAudio("425121040", var_173_32)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_425121", "425121040", "story_v_out_425121.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_425121", "425121040", "story_v_out_425121.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_33 = math.max(var_173_24, arg_170_1.talkMaxDuration)

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_33 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_23) / var_173_33

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_23 + var_173_33 and arg_170_1.time_ < var_173_23 + var_173_33 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play425121041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 425121041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play425121042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1036"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1036 = var_177_0.localPosition
				var_177_0.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1036", 7)

				local var_177_2 = var_177_0.childCount

				for iter_177_0 = 0, var_177_2 - 1 do
					local var_177_3 = var_177_0:GetChild(iter_177_0)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_4 then
				local var_177_5 = (arg_174_1.time_ - var_177_1) / var_177_4
				local var_177_6 = Vector3.New(0, -2000, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1036, var_177_6, var_177_5)
			end

			if arg_174_1.time_ >= var_177_1 + var_177_4 and arg_174_1.time_ < var_177_1 + var_177_4 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_177_7 = arg_174_1.actors_["1137"].transform
			local var_177_8 = 0

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.var_.moveOldPos1137 = var_177_7.localPosition
				var_177_7.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1137", 7)

				local var_177_9 = var_177_7.childCount

				for iter_177_1 = 0, var_177_9 - 1 do
					local var_177_10 = var_177_7:GetChild(iter_177_1)

					if var_177_10.name == "" or not string.find(var_177_10.name, "split") then
						var_177_10.gameObject:SetActive(true)
					else
						var_177_10.gameObject:SetActive(false)
					end
				end
			end

			local var_177_11 = 0.001

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_11 then
				local var_177_12 = (arg_174_1.time_ - var_177_8) / var_177_11
				local var_177_13 = Vector3.New(0, -2000, 0)

				var_177_7.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1137, var_177_13, var_177_12)
			end

			if arg_174_1.time_ >= var_177_8 + var_177_11 and arg_174_1.time_ < var_177_8 + var_177_11 + arg_177_0 then
				var_177_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_177_14 = manager.ui.mainCamera.transform
			local var_177_15 = 0

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				local var_177_16 = arg_174_1.var_.effect1041
				local var_177_17
				local var_177_18 = var_177_14

				if not var_177_16 then
					var_177_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_177_18)
					var_177_16.name = "1041"
					arg_174_1.var_.effect1041 = var_177_16
				else
					var_177_16.transform:SetParent(var_177_18)
				end

				var_177_16.transform.localPosition = Vector3.New(0, 0, -2)
				var_177_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_177_19 = 0
			local var_177_20 = 1

			if var_177_19 < arg_174_1.time_ and arg_174_1.time_ <= var_177_19 + arg_177_0 then
				local var_177_21 = "play"
				local var_177_22 = "effect"

				arg_174_1:AudioAction(var_177_21, var_177_22, "se_story_147", "se_story_147_alarm", "")
			end

			local var_177_23 = 0
			local var_177_24 = 1

			if var_177_23 < arg_174_1.time_ and arg_174_1.time_ <= var_177_23 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_25 = arg_174_1:GetWordFromCfg(425121041)
				local var_177_26 = arg_174_1:FormatText(var_177_25.content)

				arg_174_1.text_.text = var_177_26

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_27 = 40
				local var_177_28 = utf8.len(var_177_26)
				local var_177_29 = var_177_27 <= 0 and var_177_24 or var_177_24 * (var_177_28 / var_177_27)

				if var_177_29 > 0 and var_177_24 < var_177_29 then
					arg_174_1.talkMaxDuration = var_177_29

					if var_177_29 + var_177_23 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_29 + var_177_23
					end
				end

				arg_174_1.text_.text = var_177_26
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_30 = math.max(var_177_24, arg_174_1.talkMaxDuration)

			if var_177_23 <= arg_174_1.time_ and arg_174_1.time_ < var_177_23 + var_177_30 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_23) / var_177_30

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_23 + var_177_30 and arg_174_1.time_ < var_177_23 + var_177_30 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play425121042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 425121042
		arg_178_1.duration_ = 6.23

		local var_178_0 = {
			zh = 4.866,
			ja = 6.233
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
				arg_178_0:Play425121043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1036"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1036 == nil then
				arg_178_1.var_.actorSpriteComps1036 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps1036 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 1, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1036 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps1036 = nil
			end

			local var_181_8 = arg_178_1.actors_["1036"].transform
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.var_.moveOldPos1036 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1036", 3)

				local var_181_10 = var_181_8.childCount

				for iter_181_4 = 0, var_181_10 - 1 do
					local var_181_11 = var_181_8:GetChild(iter_181_4)

					if var_181_11.name == "" or not string.find(var_181_11.name, "split") then
						var_181_11.gameObject:SetActive(true)
					else
						var_181_11.gameObject:SetActive(false)
					end
				end
			end

			local var_181_12 = 0.001

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_12 then
				local var_181_13 = (arg_178_1.time_ - var_181_9) / var_181_12
				local var_181_14 = Vector3.New(0, -388, -250)

				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1036, var_181_14, var_181_13)
			end

			if arg_178_1.time_ >= var_181_9 + var_181_12 and arg_178_1.time_ < var_181_9 + var_181_12 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_181_15 = manager.ui.mainCamera.transform
			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				local var_181_17 = arg_178_1.var_.effect1041

				if var_181_17 then
					Object.Destroy(var_181_17)

					arg_178_1.var_.effect1041 = nil
				end
			end

			local var_181_18 = 0
			local var_181_19 = 0.6

			if var_181_18 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_20 = arg_178_1:FormatText(StoryNameCfg[5].name)

				arg_178_1.leftNameTxt_.text = var_181_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_21 = arg_178_1:GetWordFromCfg(425121042)
				local var_181_22 = arg_178_1:FormatText(var_181_21.content)

				arg_178_1.text_.text = var_181_22

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_23 = 24
				local var_181_24 = utf8.len(var_181_22)
				local var_181_25 = var_181_23 <= 0 and var_181_19 or var_181_19 * (var_181_24 / var_181_23)

				if var_181_25 > 0 and var_181_19 < var_181_25 then
					arg_178_1.talkMaxDuration = var_181_25

					if var_181_25 + var_181_18 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_25 + var_181_18
					end
				end

				arg_178_1.text_.text = var_181_22
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121042", "story_v_out_425121.awb") ~= 0 then
					local var_181_26 = manager.audio:GetVoiceLength("story_v_out_425121", "425121042", "story_v_out_425121.awb") / 1000

					if var_181_26 + var_181_18 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_26 + var_181_18
					end

					if var_181_21.prefab_name ~= "" and arg_178_1.actors_[var_181_21.prefab_name] ~= nil then
						local var_181_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_21.prefab_name].transform, "story_v_out_425121", "425121042", "story_v_out_425121.awb")

						arg_178_1:RecordAudio("425121042", var_181_27)
						arg_178_1:RecordAudio("425121042", var_181_27)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_425121", "425121042", "story_v_out_425121.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_425121", "425121042", "story_v_out_425121.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_28 = math.max(var_181_19, arg_178_1.talkMaxDuration)

			if var_181_18 <= arg_178_1.time_ and arg_178_1.time_ < var_181_18 + var_181_28 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_18) / var_181_28

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_18 + var_181_28 and arg_178_1.time_ < var_181_18 + var_181_28 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play425121043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 425121043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play425121044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1036"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1036 == nil then
				arg_182_1.var_.actorSpriteComps1036 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps1036 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 0.5, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1036 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1036 = nil
			end

			local var_185_8 = arg_182_1.actors_["1036"].transform
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 then
				arg_182_1.var_.moveOldPos1036 = var_185_8.localPosition
				var_185_8.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1036", 7)

				local var_185_10 = var_185_8.childCount

				for iter_185_4 = 0, var_185_10 - 1 do
					local var_185_11 = var_185_8:GetChild(iter_185_4)

					if var_185_11.name == "" or not string.find(var_185_11.name, "split") then
						var_185_11.gameObject:SetActive(true)
					else
						var_185_11.gameObject:SetActive(false)
					end
				end
			end

			local var_185_12 = 0.001

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_12 then
				local var_185_13 = (arg_182_1.time_ - var_185_9) / var_185_12
				local var_185_14 = Vector3.New(0, -2000, 0)

				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1036, var_185_14, var_185_13)
			end

			if arg_182_1.time_ >= var_185_9 + var_185_12 and arg_182_1.time_ < var_185_9 + var_185_12 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_185_15 = 0.2
			local var_185_16 = 1

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				local var_185_17 = "play"
				local var_185_18 = "effect"

				arg_182_1:AudioAction(var_185_17, var_185_18, "se_story_134_01", "se_story_134_01_crowd", "")
			end

			local var_185_19 = 0
			local var_185_20 = 0.95

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

				local var_185_21 = arg_182_1:GetWordFromCfg(425121043)
				local var_185_22 = arg_182_1:FormatText(var_185_21.content)

				arg_182_1.text_.text = var_185_22

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_23 = 38
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
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play425121044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 425121044
		arg_186_1.duration_ = 6.9

		local var_186_0 = {
			zh = 5.966,
			ja = 6.9
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
				arg_186_0:Play425121045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1036"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1036 == nil then
				arg_186_1.var_.actorSpriteComps1036 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps1036 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 1, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1036 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1036 = nil
			end

			local var_189_8 = arg_186_1.actors_["1036"].transform
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 then
				arg_186_1.var_.moveOldPos1036 = var_189_8.localPosition
				var_189_8.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1036", 3)

				local var_189_10 = var_189_8.childCount

				for iter_189_4 = 0, var_189_10 - 1 do
					local var_189_11 = var_189_8:GetChild(iter_189_4)

					if var_189_11.name == "" or not string.find(var_189_11.name, "split") then
						var_189_11.gameObject:SetActive(true)
					else
						var_189_11.gameObject:SetActive(false)
					end
				end
			end

			local var_189_12 = 0.001

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_12 then
				local var_189_13 = (arg_186_1.time_ - var_189_9) / var_189_12
				local var_189_14 = Vector3.New(0, -388, -250)

				var_189_8.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1036, var_189_14, var_189_13)
			end

			if arg_186_1.time_ >= var_189_9 + var_189_12 and arg_186_1.time_ < var_189_9 + var_189_12 + arg_189_0 then
				var_189_8.localPosition = Vector3.New(0, -388, -250)
			end

			local var_189_15 = 0
			local var_189_16 = 0.775

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_17 = arg_186_1:FormatText(StoryNameCfg[5].name)

				arg_186_1.leftNameTxt_.text = var_189_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:GetWordFromCfg(425121044)
				local var_189_19 = arg_186_1:FormatText(var_189_18.content)

				arg_186_1.text_.text = var_189_19

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 31
				local var_189_21 = utf8.len(var_189_19)
				local var_189_22 = var_189_20 <= 0 and var_189_16 or var_189_16 * (var_189_21 / var_189_20)

				if var_189_22 > 0 and var_189_16 < var_189_22 then
					arg_186_1.talkMaxDuration = var_189_22

					if var_189_22 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_22 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_19
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121044", "story_v_out_425121.awb") ~= 0 then
					local var_189_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121044", "story_v_out_425121.awb") / 1000

					if var_189_23 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_15
					end

					if var_189_18.prefab_name ~= "" and arg_186_1.actors_[var_189_18.prefab_name] ~= nil then
						local var_189_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_18.prefab_name].transform, "story_v_out_425121", "425121044", "story_v_out_425121.awb")

						arg_186_1:RecordAudio("425121044", var_189_24)
						arg_186_1:RecordAudio("425121044", var_189_24)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_425121", "425121044", "story_v_out_425121.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_425121", "425121044", "story_v_out_425121.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_25 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_15) / var_189_25

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_15 + var_189_25 and arg_186_1.time_ < var_189_15 + var_189_25 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play425121045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 425121045
		arg_190_1.duration_ = 5.93

		local var_190_0 = {
			zh = 5.933,
			ja = 4.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play425121046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.725

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[5].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:GetWordFromCfg(425121045)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 29
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121045", "story_v_out_425121.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121045", "story_v_out_425121.awb") / 1000

					if var_193_8 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_0
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_425121", "425121045", "story_v_out_425121.awb")

						arg_190_1:RecordAudio("425121045", var_193_9)
						arg_190_1:RecordAudio("425121045", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_425121", "425121045", "story_v_out_425121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_425121", "425121045", "story_v_out_425121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_10 and arg_190_1.time_ < var_193_0 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play425121046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 425121046
		arg_194_1.duration_ = 9.8

		local var_194_0 = {
			zh = 8.266,
			ja = 9.8
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play425121047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1036"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1036 = var_197_0.localPosition
				var_197_0.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1036", 3)

				local var_197_2 = var_197_0.childCount

				for iter_197_0 = 0, var_197_2 - 1 do
					local var_197_3 = var_197_0:GetChild(iter_197_0)

					if var_197_3.name == "" or not string.find(var_197_3.name, "split") then
						var_197_3.gameObject:SetActive(true)
					else
						var_197_3.gameObject:SetActive(false)
					end
				end
			end

			local var_197_4 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_4 then
				local var_197_5 = (arg_194_1.time_ - var_197_1) / var_197_4
				local var_197_6 = Vector3.New(0, -388, -250)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1036, var_197_6, var_197_5)
			end

			if arg_194_1.time_ >= var_197_1 + var_197_4 and arg_194_1.time_ < var_197_1 + var_197_4 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, -388, -250)
			end

			local var_197_7 = 0
			local var_197_8 = 1.125

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_9 = arg_194_1:FormatText(StoryNameCfg[5].name)

				arg_194_1.leftNameTxt_.text = var_197_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_10 = arg_194_1:GetWordFromCfg(425121046)
				local var_197_11 = arg_194_1:FormatText(var_197_10.content)

				arg_194_1.text_.text = var_197_11

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_12 = 45
				local var_197_13 = utf8.len(var_197_11)
				local var_197_14 = var_197_12 <= 0 and var_197_8 or var_197_8 * (var_197_13 / var_197_12)

				if var_197_14 > 0 and var_197_8 < var_197_14 then
					arg_194_1.talkMaxDuration = var_197_14

					if var_197_14 + var_197_7 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_7
					end
				end

				arg_194_1.text_.text = var_197_11
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121046", "story_v_out_425121.awb") ~= 0 then
					local var_197_15 = manager.audio:GetVoiceLength("story_v_out_425121", "425121046", "story_v_out_425121.awb") / 1000

					if var_197_15 + var_197_7 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_7
					end

					if var_197_10.prefab_name ~= "" and arg_194_1.actors_[var_197_10.prefab_name] ~= nil then
						local var_197_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_10.prefab_name].transform, "story_v_out_425121", "425121046", "story_v_out_425121.awb")

						arg_194_1:RecordAudio("425121046", var_197_16)
						arg_194_1:RecordAudio("425121046", var_197_16)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_425121", "425121046", "story_v_out_425121.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_425121", "425121046", "story_v_out_425121.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_17 = math.max(var_197_8, arg_194_1.talkMaxDuration)

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_17 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_7) / var_197_17

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_7 + var_197_17 and arg_194_1.time_ < var_197_7 + var_197_17 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play425121047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 425121047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play425121048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1036"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1036 == nil then
				arg_198_1.var_.actorSpriteComps1036 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps1036 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 0.5, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1036 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1036 = nil
			end

			local var_201_8 = arg_198_1.actors_["1036"].transform
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.var_.moveOldPos1036 = var_201_8.localPosition
				var_201_8.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1036", 7)

				local var_201_10 = var_201_8.childCount

				for iter_201_4 = 0, var_201_10 - 1 do
					local var_201_11 = var_201_8:GetChild(iter_201_4)

					if var_201_11.name == "" or not string.find(var_201_11.name, "split") then
						var_201_11.gameObject:SetActive(true)
					else
						var_201_11.gameObject:SetActive(false)
					end
				end
			end

			local var_201_12 = 0.001

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_12 then
				local var_201_13 = (arg_198_1.time_ - var_201_9) / var_201_12
				local var_201_14 = Vector3.New(0, -2000, 0)

				var_201_8.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1036, var_201_14, var_201_13)
			end

			if arg_198_1.time_ >= var_201_9 + var_201_12 and arg_198_1.time_ < var_201_9 + var_201_12 + arg_201_0 then
				var_201_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_201_15 = 0
			local var_201_16 = 0.75

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_17 = arg_198_1:GetWordFromCfg(425121047)
				local var_201_18 = arg_198_1:FormatText(var_201_17.content)

				arg_198_1.text_.text = var_201_18

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_19 = 30
				local var_201_20 = utf8.len(var_201_18)
				local var_201_21 = var_201_19 <= 0 and var_201_16 or var_201_16 * (var_201_20 / var_201_19)

				if var_201_21 > 0 and var_201_16 < var_201_21 then
					arg_198_1.talkMaxDuration = var_201_21

					if var_201_21 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_21 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_18
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_22 and arg_198_1.time_ < var_201_15 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play425121048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 425121048
		arg_202_1.duration_ = 7.23

		local var_202_0 = {
			zh = 5.366,
			ja = 7.233
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
				arg_202_0:Play425121049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1036"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1036 == nil then
				arg_202_1.var_.actorSpriteComps1036 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps1036 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 1, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1036 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1036 = nil
			end

			local var_205_8 = arg_202_1.actors_["1036"].transform
			local var_205_9 = 0

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 then
				arg_202_1.var_.moveOldPos1036 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1036", 2)

				local var_205_10 = var_205_8.childCount

				for iter_205_4 = 0, var_205_10 - 1 do
					local var_205_11 = var_205_8:GetChild(iter_205_4)

					if var_205_11.name == "" or not string.find(var_205_11.name, "split") then
						var_205_11.gameObject:SetActive(true)
					else
						var_205_11.gameObject:SetActive(false)
					end
				end
			end

			local var_205_12 = 0.001

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_12 then
				local var_205_13 = (arg_202_1.time_ - var_205_9) / var_205_12
				local var_205_14 = Vector3.New(-390, -388, -250)

				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1036, var_205_14, var_205_13)
			end

			if arg_202_1.time_ >= var_205_9 + var_205_12 and arg_202_1.time_ < var_205_9 + var_205_12 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_205_15 = 0
			local var_205_16 = 0.7

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_17 = arg_202_1:FormatText(StoryNameCfg[5].name)

				arg_202_1.leftNameTxt_.text = var_205_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_18 = arg_202_1:GetWordFromCfg(425121048)
				local var_205_19 = arg_202_1:FormatText(var_205_18.content)

				arg_202_1.text_.text = var_205_19

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_20 = 28
				local var_205_21 = utf8.len(var_205_19)
				local var_205_22 = var_205_20 <= 0 and var_205_16 or var_205_16 * (var_205_21 / var_205_20)

				if var_205_22 > 0 and var_205_16 < var_205_22 then
					arg_202_1.talkMaxDuration = var_205_22

					if var_205_22 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_19
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121048", "story_v_out_425121.awb") ~= 0 then
					local var_205_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121048", "story_v_out_425121.awb") / 1000

					if var_205_23 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_15
					end

					if var_205_18.prefab_name ~= "" and arg_202_1.actors_[var_205_18.prefab_name] ~= nil then
						local var_205_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_18.prefab_name].transform, "story_v_out_425121", "425121048", "story_v_out_425121.awb")

						arg_202_1:RecordAudio("425121048", var_205_24)
						arg_202_1:RecordAudio("425121048", var_205_24)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_425121", "425121048", "story_v_out_425121.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_425121", "425121048", "story_v_out_425121.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_25 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_25 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_25

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_25 and arg_202_1.time_ < var_205_15 + var_205_25 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play425121049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 425121049
		arg_206_1.duration_ = 2.63

		local var_206_0 = {
			zh = 1.733,
			ja = 2.633
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
				arg_206_0:Play425121050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1137"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1137 == nil then
				arg_206_1.var_.actorSpriteComps1137 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1137 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1137 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1137 = nil
			end

			local var_209_8 = arg_206_1.actors_["1036"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1036 == nil then
				arg_206_1.var_.actorSpriteComps1036 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps1036 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1036 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1036 = nil
			end

			local var_209_16 = arg_206_1.actors_["1137"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos1137 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1137", 4)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "split_5" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(390, -425, -200)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1137, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_209_23 = 0
			local var_209_24 = 0.15

			if var_209_23 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_25 = arg_206_1:FormatText(StoryNameCfg[15].name)

				arg_206_1.leftNameTxt_.text = var_209_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_26 = arg_206_1:GetWordFromCfg(425121049)
				local var_209_27 = arg_206_1:FormatText(var_209_26.content)

				arg_206_1.text_.text = var_209_27

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_28 = 6
				local var_209_29 = utf8.len(var_209_27)
				local var_209_30 = var_209_28 <= 0 and var_209_24 or var_209_24 * (var_209_29 / var_209_28)

				if var_209_30 > 0 and var_209_24 < var_209_30 then
					arg_206_1.talkMaxDuration = var_209_30

					if var_209_30 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_30 + var_209_23
					end
				end

				arg_206_1.text_.text = var_209_27
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121049", "story_v_out_425121.awb") ~= 0 then
					local var_209_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121049", "story_v_out_425121.awb") / 1000

					if var_209_31 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_31 + var_209_23
					end

					if var_209_26.prefab_name ~= "" and arg_206_1.actors_[var_209_26.prefab_name] ~= nil then
						local var_209_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_26.prefab_name].transform, "story_v_out_425121", "425121049", "story_v_out_425121.awb")

						arg_206_1:RecordAudio("425121049", var_209_32)
						arg_206_1:RecordAudio("425121049", var_209_32)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_425121", "425121049", "story_v_out_425121.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_425121", "425121049", "story_v_out_425121.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_33 = math.max(var_209_24, arg_206_1.talkMaxDuration)

			if var_209_23 <= arg_206_1.time_ and arg_206_1.time_ < var_209_23 + var_209_33 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_23) / var_209_33

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_23 + var_209_33 and arg_206_1.time_ < var_209_23 + var_209_33 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play425121050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 425121050
		arg_210_1.duration_ = 6.77

		local var_210_0 = {
			zh = 6.366,
			ja = 6.766
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
				arg_210_0:Play425121051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1036"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1036 == nil then
				arg_210_1.var_.actorSpriteComps1036 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps1036 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 1, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1036 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1036 = nil
			end

			local var_213_8 = arg_210_1.actors_["1137"]
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1137 == nil then
				arg_210_1.var_.actorSpriteComps1137 = var_213_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_10 = 0.2

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_10 and not isNil(var_213_8) then
				local var_213_11 = (arg_210_1.time_ - var_213_9) / var_213_10

				if arg_210_1.var_.actorSpriteComps1137 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								local var_213_12 = Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, var_213_11)
								local var_213_13 = Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, var_213_11)
								local var_213_14 = Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, var_213_11)

								iter_213_5.color = Color.New(var_213_12, var_213_13, var_213_14)
							else
								local var_213_15 = Mathf.Lerp(iter_213_5.color.r, 0.5, var_213_11)

								iter_213_5.color = Color.New(var_213_15, var_213_15, var_213_15)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_10 and arg_210_1.time_ < var_213_9 + var_213_10 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps1137 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_213_7 then
						if arg_210_1.isInRecall_ then
							iter_213_7.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1137 = nil
			end

			local var_213_16 = arg_210_1.actors_["1036"].transform
			local var_213_17 = 0

			if var_213_17 < arg_210_1.time_ and arg_210_1.time_ <= var_213_17 + arg_213_0 then
				arg_210_1.var_.moveOldPos1036 = var_213_16.localPosition
				var_213_16.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1036", 2)

				local var_213_18 = var_213_16.childCount

				for iter_213_8 = 0, var_213_18 - 1 do
					local var_213_19 = var_213_16:GetChild(iter_213_8)

					if var_213_19.name == "" or not string.find(var_213_19.name, "split") then
						var_213_19.gameObject:SetActive(true)
					else
						var_213_19.gameObject:SetActive(false)
					end
				end
			end

			local var_213_20 = 0.001

			if var_213_17 <= arg_210_1.time_ and arg_210_1.time_ < var_213_17 + var_213_20 then
				local var_213_21 = (arg_210_1.time_ - var_213_17) / var_213_20
				local var_213_22 = Vector3.New(-390, -388, -250)

				var_213_16.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1036, var_213_22, var_213_21)
			end

			if arg_210_1.time_ >= var_213_17 + var_213_20 and arg_210_1.time_ < var_213_17 + var_213_20 + arg_213_0 then
				var_213_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_213_23 = 0
			local var_213_24 = 0.85

			if var_213_23 < arg_210_1.time_ and arg_210_1.time_ <= var_213_23 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_25 = arg_210_1:FormatText(StoryNameCfg[5].name)

				arg_210_1.leftNameTxt_.text = var_213_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_26 = arg_210_1:GetWordFromCfg(425121050)
				local var_213_27 = arg_210_1:FormatText(var_213_26.content)

				arg_210_1.text_.text = var_213_27

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_28 = 34
				local var_213_29 = utf8.len(var_213_27)
				local var_213_30 = var_213_28 <= 0 and var_213_24 or var_213_24 * (var_213_29 / var_213_28)

				if var_213_30 > 0 and var_213_24 < var_213_30 then
					arg_210_1.talkMaxDuration = var_213_30

					if var_213_30 + var_213_23 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_30 + var_213_23
					end
				end

				arg_210_1.text_.text = var_213_27
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121050", "story_v_out_425121.awb") ~= 0 then
					local var_213_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121050", "story_v_out_425121.awb") / 1000

					if var_213_31 + var_213_23 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_31 + var_213_23
					end

					if var_213_26.prefab_name ~= "" and arg_210_1.actors_[var_213_26.prefab_name] ~= nil then
						local var_213_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_26.prefab_name].transform, "story_v_out_425121", "425121050", "story_v_out_425121.awb")

						arg_210_1:RecordAudio("425121050", var_213_32)
						arg_210_1:RecordAudio("425121050", var_213_32)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_425121", "425121050", "story_v_out_425121.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_425121", "425121050", "story_v_out_425121.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_33 = math.max(var_213_24, arg_210_1.talkMaxDuration)

			if var_213_23 <= arg_210_1.time_ and arg_210_1.time_ < var_213_23 + var_213_33 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_23) / var_213_33

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_23 + var_213_33 and arg_210_1.time_ < var_213_23 + var_213_33 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play425121051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 425121051
		arg_214_1.duration_ = 5.57

		local var_214_0 = {
			zh = 5.566,
			ja = 5.066
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play425121052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1036"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1036 = var_217_0.localPosition
				var_217_0.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1036", 2)

				local var_217_2 = var_217_0.childCount

				for iter_217_0 = 0, var_217_2 - 1 do
					local var_217_3 = var_217_0:GetChild(iter_217_0)

					if var_217_3.name == "" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_4 then
				local var_217_5 = (arg_214_1.time_ - var_217_1) / var_217_4
				local var_217_6 = Vector3.New(-390, -388, -250)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1036, var_217_6, var_217_5)
			end

			if arg_214_1.time_ >= var_217_1 + var_217_4 and arg_214_1.time_ < var_217_1 + var_217_4 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_217_7 = 0
			local var_217_8 = 0.55

			if var_217_7 < arg_214_1.time_ and arg_214_1.time_ <= var_217_7 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_9 = arg_214_1:FormatText(StoryNameCfg[5].name)

				arg_214_1.leftNameTxt_.text = var_217_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:GetWordFromCfg(425121051)
				local var_217_11 = arg_214_1:FormatText(var_217_10.content)

				arg_214_1.text_.text = var_217_11

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_12 = 22
				local var_217_13 = utf8.len(var_217_11)
				local var_217_14 = var_217_12 <= 0 and var_217_8 or var_217_8 * (var_217_13 / var_217_12)

				if var_217_14 > 0 and var_217_8 < var_217_14 then
					arg_214_1.talkMaxDuration = var_217_14

					if var_217_14 + var_217_7 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_7
					end
				end

				arg_214_1.text_.text = var_217_11
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121051", "story_v_out_425121.awb") ~= 0 then
					local var_217_15 = manager.audio:GetVoiceLength("story_v_out_425121", "425121051", "story_v_out_425121.awb") / 1000

					if var_217_15 + var_217_7 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_15 + var_217_7
					end

					if var_217_10.prefab_name ~= "" and arg_214_1.actors_[var_217_10.prefab_name] ~= nil then
						local var_217_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_10.prefab_name].transform, "story_v_out_425121", "425121051", "story_v_out_425121.awb")

						arg_214_1:RecordAudio("425121051", var_217_16)
						arg_214_1:RecordAudio("425121051", var_217_16)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_425121", "425121051", "story_v_out_425121.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_425121", "425121051", "story_v_out_425121.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_17 = math.max(var_217_8, arg_214_1.talkMaxDuration)

			if var_217_7 <= arg_214_1.time_ and arg_214_1.time_ < var_217_7 + var_217_17 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_7) / var_217_17

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_7 + var_217_17 and arg_214_1.time_ < var_217_7 + var_217_17 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play425121052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 425121052
		arg_218_1.duration_ = 1.9

		local var_218_0 = {
			zh = 1.1,
			ja = 1.9
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play425121053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1137"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1137 == nil then
				arg_218_1.var_.actorSpriteComps1137 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps1137 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 1, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1137 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps1137 = nil
			end

			local var_221_8 = arg_218_1.actors_["1036"]
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps1036 == nil then
				arg_218_1.var_.actorSpriteComps1036 = var_221_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_10 = 0.2

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_10 and not isNil(var_221_8) then
				local var_221_11 = (arg_218_1.time_ - var_221_9) / var_221_10

				if arg_218_1.var_.actorSpriteComps1036 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								local var_221_12 = Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, var_221_11)
								local var_221_13 = Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, var_221_11)
								local var_221_14 = Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, var_221_11)

								iter_221_5.color = Color.New(var_221_12, var_221_13, var_221_14)
							else
								local var_221_15 = Mathf.Lerp(iter_221_5.color.r, 0.5, var_221_11)

								iter_221_5.color = Color.New(var_221_15, var_221_15, var_221_15)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_9 + var_221_10 and arg_218_1.time_ < var_221_9 + var_221_10 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps1036 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_221_7 then
						if arg_218_1.isInRecall_ then
							iter_221_7.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps1036 = nil
			end

			local var_221_16 = arg_218_1.actors_["1137"].transform
			local var_221_17 = 0

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				arg_218_1.var_.moveOldPos1137 = var_221_16.localPosition
				var_221_16.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1137", 4)

				local var_221_18 = var_221_16.childCount

				for iter_221_8 = 0, var_221_18 - 1 do
					local var_221_19 = var_221_16:GetChild(iter_221_8)

					if var_221_19.name == "split_1" then
						var_221_19:SetAsLastSibling()
						var_221_19.gameObject:SetActive(true)

						arg_218_1.var_.actorSpriteSplit1137 = var_221_19.gameObject:GetComponent(typeof(Image))

						arg_218_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_221_20 = 0.2

			if var_221_17 <= arg_218_1.time_ and arg_218_1.time_ < var_221_17 + var_221_20 then
				local var_221_21 = (arg_218_1.time_ - var_221_17) / var_221_20
				local var_221_22 = Vector3.New(390, -425, -200)

				var_221_16.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1137, var_221_22, var_221_21)

				if arg_218_1.var_.actorSpriteSplit1137 ~= nil then
					arg_218_1.var_.actorSpriteSplit1137:SetAlpha(var_221_21)
				end
			end

			if arg_218_1.time_ >= var_221_17 + var_221_20 and arg_218_1.time_ < var_221_17 + var_221_20 + arg_221_0 then
				var_221_16.localPosition = Vector3.New(390, -425, -200)

				if arg_218_1.var_.actorSpriteSplit1137 ~= nil then
					arg_218_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_221_23 = 0
			local var_221_24 = 0.15

			if var_221_23 < arg_218_1.time_ and arg_218_1.time_ <= var_221_23 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_25 = arg_218_1:FormatText(StoryNameCfg[15].name)

				arg_218_1.leftNameTxt_.text = var_221_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_26 = arg_218_1:GetWordFromCfg(425121052)
				local var_221_27 = arg_218_1:FormatText(var_221_26.content)

				arg_218_1.text_.text = var_221_27

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_28 = 6
				local var_221_29 = utf8.len(var_221_27)
				local var_221_30 = var_221_28 <= 0 and var_221_24 or var_221_24 * (var_221_29 / var_221_28)

				if var_221_30 > 0 and var_221_24 < var_221_30 then
					arg_218_1.talkMaxDuration = var_221_30

					if var_221_30 + var_221_23 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_30 + var_221_23
					end
				end

				arg_218_1.text_.text = var_221_27
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121052", "story_v_out_425121.awb") ~= 0 then
					local var_221_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121052", "story_v_out_425121.awb") / 1000

					if var_221_31 + var_221_23 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_31 + var_221_23
					end

					if var_221_26.prefab_name ~= "" and arg_218_1.actors_[var_221_26.prefab_name] ~= nil then
						local var_221_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_26.prefab_name].transform, "story_v_out_425121", "425121052", "story_v_out_425121.awb")

						arg_218_1:RecordAudio("425121052", var_221_32)
						arg_218_1:RecordAudio("425121052", var_221_32)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_425121", "425121052", "story_v_out_425121.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_425121", "425121052", "story_v_out_425121.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_33 = math.max(var_221_24, arg_218_1.talkMaxDuration)

			if var_221_23 <= arg_218_1.time_ and arg_218_1.time_ < var_221_23 + var_221_33 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_23) / var_221_33

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_23 + var_221_33 and arg_218_1.time_ < var_221_23 + var_221_33 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play425121053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 425121053
		arg_222_1.duration_ = 6.4

		local var_222_0 = {
			zh = 5.9,
			ja = 6.4
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
				arg_222_0:Play425121054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1036"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1036 == nil then
				arg_222_1.var_.actorSpriteComps1036 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1036 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1036 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1036 = nil
			end

			local var_225_8 = arg_222_1.actors_["1137"]
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps1137 == nil then
				arg_222_1.var_.actorSpriteComps1137 = var_225_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_10 = 0.2

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 and not isNil(var_225_8) then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / var_225_10

				if arg_222_1.var_.actorSpriteComps1137 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								local var_225_12 = Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor2.r, var_225_11)
								local var_225_13 = Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor2.g, var_225_11)
								local var_225_14 = Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor2.b, var_225_11)

								iter_225_5.color = Color.New(var_225_12, var_225_13, var_225_14)
							else
								local var_225_15 = Mathf.Lerp(iter_225_5.color.r, 0.5, var_225_11)

								iter_225_5.color = Color.New(var_225_15, var_225_15, var_225_15)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps1137 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_225_7 then
						if arg_222_1.isInRecall_ then
							iter_225_7.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1137 = nil
			end

			local var_225_16 = arg_222_1.actors_["1036"].transform
			local var_225_17 = 0

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 then
				arg_222_1.var_.moveOldPos1036 = var_225_16.localPosition
				var_225_16.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1036", 2)

				local var_225_18 = var_225_16.childCount

				for iter_225_8 = 0, var_225_18 - 1 do
					local var_225_19 = var_225_16:GetChild(iter_225_8)

					if var_225_19.name == "" or not string.find(var_225_19.name, "split") then
						var_225_19.gameObject:SetActive(true)
					else
						var_225_19.gameObject:SetActive(false)
					end
				end
			end

			local var_225_20 = 0.001

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_20 then
				local var_225_21 = (arg_222_1.time_ - var_225_17) / var_225_20
				local var_225_22 = Vector3.New(-390, -388, -250)

				var_225_16.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1036, var_225_22, var_225_21)
			end

			if arg_222_1.time_ >= var_225_17 + var_225_20 and arg_222_1.time_ < var_225_17 + var_225_20 + arg_225_0 then
				var_225_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_225_23 = 0
			local var_225_24 = 0.9

			if var_225_23 < arg_222_1.time_ and arg_222_1.time_ <= var_225_23 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_25 = arg_222_1:FormatText(StoryNameCfg[5].name)

				arg_222_1.leftNameTxt_.text = var_225_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_26 = arg_222_1:GetWordFromCfg(425121053)
				local var_225_27 = arg_222_1:FormatText(var_225_26.content)

				arg_222_1.text_.text = var_225_27

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_28 = 36
				local var_225_29 = utf8.len(var_225_27)
				local var_225_30 = var_225_28 <= 0 and var_225_24 or var_225_24 * (var_225_29 / var_225_28)

				if var_225_30 > 0 and var_225_24 < var_225_30 then
					arg_222_1.talkMaxDuration = var_225_30

					if var_225_30 + var_225_23 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_30 + var_225_23
					end
				end

				arg_222_1.text_.text = var_225_27
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121053", "story_v_out_425121.awb") ~= 0 then
					local var_225_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121053", "story_v_out_425121.awb") / 1000

					if var_225_31 + var_225_23 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_31 + var_225_23
					end

					if var_225_26.prefab_name ~= "" and arg_222_1.actors_[var_225_26.prefab_name] ~= nil then
						local var_225_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_26.prefab_name].transform, "story_v_out_425121", "425121053", "story_v_out_425121.awb")

						arg_222_1:RecordAudio("425121053", var_225_32)
						arg_222_1:RecordAudio("425121053", var_225_32)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_425121", "425121053", "story_v_out_425121.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_425121", "425121053", "story_v_out_425121.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_33 = math.max(var_225_24, arg_222_1.talkMaxDuration)

			if var_225_23 <= arg_222_1.time_ and arg_222_1.time_ < var_225_23 + var_225_33 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_23) / var_225_33

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_23 + var_225_33 and arg_222_1.time_ < var_225_23 + var_225_33 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play425121054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 425121054
		arg_226_1.duration_ = 1.17

		local var_226_0 = {
			zh = 1,
			ja = 1.166
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
				arg_226_0:Play425121055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1137"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1137 == nil then
				arg_226_1.var_.actorSpriteComps1137 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps1137 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 1, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1137 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps1137 = nil
			end

			local var_229_8 = arg_226_1.actors_["1036"]
			local var_229_9 = 0

			if var_229_9 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps1036 == nil then
				arg_226_1.var_.actorSpriteComps1036 = var_229_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_10 = 0.2

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 and not isNil(var_229_8) then
				local var_229_11 = (arg_226_1.time_ - var_229_9) / var_229_10

				if arg_226_1.var_.actorSpriteComps1036 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								local var_229_12 = Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, var_229_11)
								local var_229_13 = Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, var_229_11)
								local var_229_14 = Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, var_229_11)

								iter_229_5.color = Color.New(var_229_12, var_229_13, var_229_14)
							else
								local var_229_15 = Mathf.Lerp(iter_229_5.color.r, 0.5, var_229_11)

								iter_229_5.color = Color.New(var_229_15, var_229_15, var_229_15)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps1036 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_229_7 then
						if arg_226_1.isInRecall_ then
							iter_229_7.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps1036 = nil
			end

			local var_229_16 = arg_226_1.actors_["1137"].transform
			local var_229_17 = 0

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.var_.moveOldPos1137 = var_229_16.localPosition
				var_229_16.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1137", 4)

				local var_229_18 = var_229_16.childCount

				for iter_229_8 = 0, var_229_18 - 1 do
					local var_229_19 = var_229_16:GetChild(iter_229_8)

					if var_229_19.name == "split_5" then
						var_229_19:SetAsLastSibling()
						var_229_19.gameObject:SetActive(true)

						arg_226_1.var_.actorSpriteSplit1137 = var_229_19.gameObject:GetComponent(typeof(Image))

						arg_226_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_229_20 = 0.2

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_20 then
				local var_229_21 = (arg_226_1.time_ - var_229_17) / var_229_20
				local var_229_22 = Vector3.New(390, -425, -200)

				var_229_16.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1137, var_229_22, var_229_21)

				if arg_226_1.var_.actorSpriteSplit1137 ~= nil then
					arg_226_1.var_.actorSpriteSplit1137:SetAlpha(var_229_21)
				end
			end

			if arg_226_1.time_ >= var_229_17 + var_229_20 and arg_226_1.time_ < var_229_17 + var_229_20 + arg_229_0 then
				var_229_16.localPosition = Vector3.New(390, -425, -200)

				if arg_226_1.var_.actorSpriteSplit1137 ~= nil then
					arg_226_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_229_23 = 0
			local var_229_24 = 0.1

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_25 = arg_226_1:FormatText(StoryNameCfg[15].name)

				arg_226_1.leftNameTxt_.text = var_229_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_26 = arg_226_1:GetWordFromCfg(425121054)
				local var_229_27 = arg_226_1:FormatText(var_229_26.content)

				arg_226_1.text_.text = var_229_27

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_28 = 4
				local var_229_29 = utf8.len(var_229_27)
				local var_229_30 = var_229_28 <= 0 and var_229_24 or var_229_24 * (var_229_29 / var_229_28)

				if var_229_30 > 0 and var_229_24 < var_229_30 then
					arg_226_1.talkMaxDuration = var_229_30

					if var_229_30 + var_229_23 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_30 + var_229_23
					end
				end

				arg_226_1.text_.text = var_229_27
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121054", "story_v_out_425121.awb") ~= 0 then
					local var_229_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121054", "story_v_out_425121.awb") / 1000

					if var_229_31 + var_229_23 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_31 + var_229_23
					end

					if var_229_26.prefab_name ~= "" and arg_226_1.actors_[var_229_26.prefab_name] ~= nil then
						local var_229_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_26.prefab_name].transform, "story_v_out_425121", "425121054", "story_v_out_425121.awb")

						arg_226_1:RecordAudio("425121054", var_229_32)
						arg_226_1:RecordAudio("425121054", var_229_32)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_425121", "425121054", "story_v_out_425121.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_425121", "425121054", "story_v_out_425121.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_33 = math.max(var_229_24, arg_226_1.talkMaxDuration)

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_33 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_23) / var_229_33

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_23 + var_229_33 and arg_226_1.time_ < var_229_23 + var_229_33 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				frequency = 6,
				className = "StoryShakeNode",
				duration = 0.35,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(5, 0, 0)
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play425121055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 425121055
		arg_230_1.duration_ = 12

		local var_230_0 = {
			zh = 7.266,
			ja = 12
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play425121056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1036"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1036 == nil then
				arg_230_1.var_.actorSpriteComps1036 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps1036 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1036 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps1036 = nil
			end

			local var_233_8 = arg_230_1.actors_["1137"]
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps1137 == nil then
				arg_230_1.var_.actorSpriteComps1137 = var_233_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_10 = 0.2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 and not isNil(var_233_8) then
				local var_233_11 = (arg_230_1.time_ - var_233_9) / var_233_10

				if arg_230_1.var_.actorSpriteComps1137 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_12 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, var_233_11)
								local var_233_13 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, var_233_11)
								local var_233_14 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, var_233_11)

								iter_233_5.color = Color.New(var_233_12, var_233_13, var_233_14)
							else
								local var_233_15 = Mathf.Lerp(iter_233_5.color.r, 0.5, var_233_11)

								iter_233_5.color = Color.New(var_233_15, var_233_15, var_233_15)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps1137 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps1137 = nil
			end

			local var_233_16 = arg_230_1.actors_["1036"].transform
			local var_233_17 = 0

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.var_.moveOldPos1036 = var_233_16.localPosition
				var_233_16.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1036", 2)

				local var_233_18 = var_233_16.childCount

				for iter_233_8 = 0, var_233_18 - 1 do
					local var_233_19 = var_233_16:GetChild(iter_233_8)

					if var_233_19.name == "" or not string.find(var_233_19.name, "split") then
						var_233_19.gameObject:SetActive(true)
					else
						var_233_19.gameObject:SetActive(false)
					end
				end
			end

			local var_233_20 = 0.001

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_20 then
				local var_233_21 = (arg_230_1.time_ - var_233_17) / var_233_20
				local var_233_22 = Vector3.New(-390, -388, -250)

				var_233_16.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1036, var_233_22, var_233_21)
			end

			if arg_230_1.time_ >= var_233_17 + var_233_20 and arg_230_1.time_ < var_233_17 + var_233_20 + arg_233_0 then
				var_233_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_233_23 = 0
			local var_233_24 = 0.925

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_25 = arg_230_1:FormatText(StoryNameCfg[5].name)

				arg_230_1.leftNameTxt_.text = var_233_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_26 = arg_230_1:GetWordFromCfg(425121055)
				local var_233_27 = arg_230_1:FormatText(var_233_26.content)

				arg_230_1.text_.text = var_233_27

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_28 = 37
				local var_233_29 = utf8.len(var_233_27)
				local var_233_30 = var_233_28 <= 0 and var_233_24 or var_233_24 * (var_233_29 / var_233_28)

				if var_233_30 > 0 and var_233_24 < var_233_30 then
					arg_230_1.talkMaxDuration = var_233_30

					if var_233_30 + var_233_23 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_30 + var_233_23
					end
				end

				arg_230_1.text_.text = var_233_27
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121055", "story_v_out_425121.awb") ~= 0 then
					local var_233_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121055", "story_v_out_425121.awb") / 1000

					if var_233_31 + var_233_23 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_31 + var_233_23
					end

					if var_233_26.prefab_name ~= "" and arg_230_1.actors_[var_233_26.prefab_name] ~= nil then
						local var_233_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_26.prefab_name].transform, "story_v_out_425121", "425121055", "story_v_out_425121.awb")

						arg_230_1:RecordAudio("425121055", var_233_32)
						arg_230_1:RecordAudio("425121055", var_233_32)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_425121", "425121055", "story_v_out_425121.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_425121", "425121055", "story_v_out_425121.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_33 = math.max(var_233_24, arg_230_1.talkMaxDuration)

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_33 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_23) / var_233_33

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_23 + var_233_33 and arg_230_1.time_ < var_233_23 + var_233_33 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play425121056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 425121056
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 4.7,
			ja = 7
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
				arg_234_0:Play425121057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1137"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1137 == nil then
				arg_234_1.var_.actorSpriteComps1137 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps1137 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 1, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1137 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_237_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps1137 = nil
			end

			local var_237_8 = arg_234_1.actors_["1036"]
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps1036 == nil then
				arg_234_1.var_.actorSpriteComps1036 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_10 = 0.2

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_10 and not isNil(var_237_8) then
				local var_237_11 = (arg_234_1.time_ - var_237_9) / var_237_10

				if arg_234_1.var_.actorSpriteComps1036 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								local var_237_12 = Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor2.r, var_237_11)
								local var_237_13 = Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor2.g, var_237_11)
								local var_237_14 = Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor2.b, var_237_11)

								iter_237_5.color = Color.New(var_237_12, var_237_13, var_237_14)
							else
								local var_237_15 = Mathf.Lerp(iter_237_5.color.r, 0.5, var_237_11)

								iter_237_5.color = Color.New(var_237_15, var_237_15, var_237_15)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_10 and arg_234_1.time_ < var_237_9 + var_237_10 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps1036 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_237_7 then
						if arg_234_1.isInRecall_ then
							iter_237_7.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps1036 = nil
			end

			local var_237_16 = arg_234_1.actors_["1137"].transform
			local var_237_17 = 0

			if var_237_17 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				arg_234_1.var_.moveOldPos1137 = var_237_16.localPosition
				var_237_16.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1137", 4)

				local var_237_18 = var_237_16.childCount

				for iter_237_8 = 0, var_237_18 - 1 do
					local var_237_19 = var_237_16:GetChild(iter_237_8)

					if var_237_19.name == "split_6" then
						var_237_19:SetAsLastSibling()
						var_237_19.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit1137 = var_237_19.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_237_20 = 0.5

			if var_237_17 <= arg_234_1.time_ and arg_234_1.time_ < var_237_17 + var_237_20 then
				local var_237_21 = (arg_234_1.time_ - var_237_17) / var_237_20
				local var_237_22 = Vector3.New(390, -425, -200)

				var_237_16.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1137, var_237_22, var_237_21)

				if arg_234_1.var_.actorSpriteSplit1137 ~= nil then
					arg_234_1.var_.actorSpriteSplit1137:SetAlpha(var_237_21)
				end
			end

			if arg_234_1.time_ >= var_237_17 + var_237_20 and arg_234_1.time_ < var_237_17 + var_237_20 + arg_237_0 then
				var_237_16.localPosition = Vector3.New(390, -425, -200)

				if arg_234_1.var_.actorSpriteSplit1137 ~= nil then
					arg_234_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_237_23 = 0
			local var_237_24 = 0.575

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_25 = arg_234_1:FormatText(StoryNameCfg[15].name)

				arg_234_1.leftNameTxt_.text = var_237_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_26 = arg_234_1:GetWordFromCfg(425121056)
				local var_237_27 = arg_234_1:FormatText(var_237_26.content)

				arg_234_1.text_.text = var_237_27

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_28 = 23
				local var_237_29 = utf8.len(var_237_27)
				local var_237_30 = var_237_28 <= 0 and var_237_24 or var_237_24 * (var_237_29 / var_237_28)

				if var_237_30 > 0 and var_237_24 < var_237_30 then
					arg_234_1.talkMaxDuration = var_237_30

					if var_237_30 + var_237_23 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_30 + var_237_23
					end
				end

				arg_234_1.text_.text = var_237_27
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121056", "story_v_out_425121.awb") ~= 0 then
					local var_237_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121056", "story_v_out_425121.awb") / 1000

					if var_237_31 + var_237_23 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_31 + var_237_23
					end

					if var_237_26.prefab_name ~= "" and arg_234_1.actors_[var_237_26.prefab_name] ~= nil then
						local var_237_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_26.prefab_name].transform, "story_v_out_425121", "425121056", "story_v_out_425121.awb")

						arg_234_1:RecordAudio("425121056", var_237_32)
						arg_234_1:RecordAudio("425121056", var_237_32)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_425121", "425121056", "story_v_out_425121.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_425121", "425121056", "story_v_out_425121.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_33 = math.max(var_237_24, arg_234_1.talkMaxDuration)

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_33 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_23) / var_237_33

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_23 + var_237_33 and arg_234_1.time_ < var_237_23 + var_237_33 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play425121057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 425121057
		arg_238_1.duration_ = 8.83

		local var_238_0 = {
			zh = 5.866,
			ja = 8.833
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
				arg_238_0:Play425121058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1036"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps1036 == nil then
				arg_238_1.var_.actorSpriteComps1036 = var_241_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.actorSpriteComps1036 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								local var_241_4 = Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, var_241_3)
								local var_241_5 = Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, var_241_3)
								local var_241_6 = Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, var_241_3)

								iter_241_1.color = Color.New(var_241_4, var_241_5, var_241_6)
							else
								local var_241_7 = Mathf.Lerp(iter_241_1.color.r, 1, var_241_3)

								iter_241_1.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps1036 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_241_3 then
						if arg_238_1.isInRecall_ then
							iter_241_3.color = arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_241_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps1036 = nil
			end

			local var_241_8 = arg_238_1.actors_["1137"]
			local var_241_9 = 0

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps1137 == nil then
				arg_238_1.var_.actorSpriteComps1137 = var_241_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_10 = 0.2

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 and not isNil(var_241_8) then
				local var_241_11 = (arg_238_1.time_ - var_241_9) / var_241_10

				if arg_238_1.var_.actorSpriteComps1137 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_241_5 then
							if arg_238_1.isInRecall_ then
								local var_241_12 = Mathf.Lerp(iter_241_5.color.r, arg_238_1.hightColor2.r, var_241_11)
								local var_241_13 = Mathf.Lerp(iter_241_5.color.g, arg_238_1.hightColor2.g, var_241_11)
								local var_241_14 = Mathf.Lerp(iter_241_5.color.b, arg_238_1.hightColor2.b, var_241_11)

								iter_241_5.color = Color.New(var_241_12, var_241_13, var_241_14)
							else
								local var_241_15 = Mathf.Lerp(iter_241_5.color.r, 0.5, var_241_11)

								iter_241_5.color = Color.New(var_241_15, var_241_15, var_241_15)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps1137 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_241_7 then
						if arg_238_1.isInRecall_ then
							iter_241_7.color = arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_241_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps1137 = nil
			end

			local var_241_16 = arg_238_1.actors_["1036"].transform
			local var_241_17 = 0

			if var_241_17 < arg_238_1.time_ and arg_238_1.time_ <= var_241_17 + arg_241_0 then
				arg_238_1.var_.moveOldPos1036 = var_241_16.localPosition
				var_241_16.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1036", 2)

				local var_241_18 = var_241_16.childCount

				for iter_241_8 = 0, var_241_18 - 1 do
					local var_241_19 = var_241_16:GetChild(iter_241_8)

					if var_241_19.name == "" or not string.find(var_241_19.name, "split") then
						var_241_19.gameObject:SetActive(true)
					else
						var_241_19.gameObject:SetActive(false)
					end
				end
			end

			local var_241_20 = 0.001

			if var_241_17 <= arg_238_1.time_ and arg_238_1.time_ < var_241_17 + var_241_20 then
				local var_241_21 = (arg_238_1.time_ - var_241_17) / var_241_20
				local var_241_22 = Vector3.New(-390, -388, -250)

				var_241_16.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1036, var_241_22, var_241_21)
			end

			if arg_238_1.time_ >= var_241_17 + var_241_20 and arg_238_1.time_ < var_241_17 + var_241_20 + arg_241_0 then
				var_241_16.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_241_23 = 0
			local var_241_24 = 0.8

			if var_241_23 < arg_238_1.time_ and arg_238_1.time_ <= var_241_23 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_25 = arg_238_1:FormatText(StoryNameCfg[5].name)

				arg_238_1.leftNameTxt_.text = var_241_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_26 = arg_238_1:GetWordFromCfg(425121057)
				local var_241_27 = arg_238_1:FormatText(var_241_26.content)

				arg_238_1.text_.text = var_241_27

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_28 = 32
				local var_241_29 = utf8.len(var_241_27)
				local var_241_30 = var_241_28 <= 0 and var_241_24 or var_241_24 * (var_241_29 / var_241_28)

				if var_241_30 > 0 and var_241_24 < var_241_30 then
					arg_238_1.talkMaxDuration = var_241_30

					if var_241_30 + var_241_23 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_30 + var_241_23
					end
				end

				arg_238_1.text_.text = var_241_27
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121057", "story_v_out_425121.awb") ~= 0 then
					local var_241_31 = manager.audio:GetVoiceLength("story_v_out_425121", "425121057", "story_v_out_425121.awb") / 1000

					if var_241_31 + var_241_23 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_31 + var_241_23
					end

					if var_241_26.prefab_name ~= "" and arg_238_1.actors_[var_241_26.prefab_name] ~= nil then
						local var_241_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_26.prefab_name].transform, "story_v_out_425121", "425121057", "story_v_out_425121.awb")

						arg_238_1:RecordAudio("425121057", var_241_32)
						arg_238_1:RecordAudio("425121057", var_241_32)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_425121", "425121057", "story_v_out_425121.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_425121", "425121057", "story_v_out_425121.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_33 = math.max(var_241_24, arg_238_1.talkMaxDuration)

			if var_241_23 <= arg_238_1.time_ and arg_238_1.time_ < var_241_23 + var_241_33 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_23) / var_241_33

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_23 + var_241_33 and arg_238_1.time_ < var_241_23 + var_241_33 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play425121058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 425121058
		arg_242_1.duration_ = 11.43

		local var_242_0 = {
			zh = 8.9,
			ja = 11.433
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play425121059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 1.275

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[5].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_3 = arg_242_1:GetWordFromCfg(425121058)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 51
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121058", "story_v_out_425121.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121058", "story_v_out_425121.awb") / 1000

					if var_245_8 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_0
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_out_425121", "425121058", "story_v_out_425121.awb")

						arg_242_1:RecordAudio("425121058", var_245_9)
						arg_242_1:RecordAudio("425121058", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_425121", "425121058", "story_v_out_425121.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_425121", "425121058", "story_v_out_425121.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_10 and arg_242_1.time_ < var_245_0 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play425121059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 425121059
		arg_246_1.duration_ = 6.1

		local var_246_0 = {
			zh = 4.166,
			ja = 6.1
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
				arg_246_0:Play425121060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1036"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1036 = var_249_0.localPosition
				var_249_0.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1036", 2)

				local var_249_2 = var_249_0.childCount

				for iter_249_0 = 0, var_249_2 - 1 do
					local var_249_3 = var_249_0:GetChild(iter_249_0)

					if var_249_3.name == "" or not string.find(var_249_3.name, "split") then
						var_249_3.gameObject:SetActive(true)
					else
						var_249_3.gameObject:SetActive(false)
					end
				end
			end

			local var_249_4 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_4 then
				local var_249_5 = (arg_246_1.time_ - var_249_1) / var_249_4
				local var_249_6 = Vector3.New(-390, -388, -250)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1036, var_249_6, var_249_5)
			end

			if arg_246_1.time_ >= var_249_1 + var_249_4 and arg_246_1.time_ < var_249_1 + var_249_4 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_249_7 = 0
			local var_249_8 = 0.55

			if var_249_7 < arg_246_1.time_ and arg_246_1.time_ <= var_249_7 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_9 = arg_246_1:FormatText(StoryNameCfg[5].name)

				arg_246_1.leftNameTxt_.text = var_249_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(425121059)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_12 = 22
				local var_249_13 = utf8.len(var_249_11)
				local var_249_14 = var_249_12 <= 0 and var_249_8 or var_249_8 * (var_249_13 / var_249_12)

				if var_249_14 > 0 and var_249_8 < var_249_14 then
					arg_246_1.talkMaxDuration = var_249_14

					if var_249_14 + var_249_7 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_7
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121059", "story_v_out_425121.awb") ~= 0 then
					local var_249_15 = manager.audio:GetVoiceLength("story_v_out_425121", "425121059", "story_v_out_425121.awb") / 1000

					if var_249_15 + var_249_7 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_7
					end

					if var_249_10.prefab_name ~= "" and arg_246_1.actors_[var_249_10.prefab_name] ~= nil then
						local var_249_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_10.prefab_name].transform, "story_v_out_425121", "425121059", "story_v_out_425121.awb")

						arg_246_1:RecordAudio("425121059", var_249_16)
						arg_246_1:RecordAudio("425121059", var_249_16)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_425121", "425121059", "story_v_out_425121.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_425121", "425121059", "story_v_out_425121.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_17 = math.max(var_249_8, arg_246_1.talkMaxDuration)

			if var_249_7 <= arg_246_1.time_ and arg_246_1.time_ < var_249_7 + var_249_17 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_7) / var_249_17

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_7 + var_249_17 and arg_246_1.time_ < var_249_7 + var_249_17 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play425121060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 425121060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play425121061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1036"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps1036 == nil then
				arg_250_1.var_.actorSpriteComps1036 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps1036 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 0.5, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps1036 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_253_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps1036 = nil
			end

			local var_253_8 = arg_250_1.actors_["1036"].transform
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.var_.moveOldPos1036 = var_253_8.localPosition
				var_253_8.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1036", 7)

				local var_253_10 = var_253_8.childCount

				for iter_253_4 = 0, var_253_10 - 1 do
					local var_253_11 = var_253_8:GetChild(iter_253_4)

					if var_253_11.name == "" or not string.find(var_253_11.name, "split") then
						var_253_11.gameObject:SetActive(true)
					else
						var_253_11.gameObject:SetActive(false)
					end
				end
			end

			local var_253_12 = 0.001

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_9) / var_253_12
				local var_253_14 = Vector3.New(0, -2000, 0)

				var_253_8.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1036, var_253_14, var_253_13)
			end

			if arg_250_1.time_ >= var_253_9 + var_253_12 and arg_250_1.time_ < var_253_9 + var_253_12 + arg_253_0 then
				var_253_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_15 = arg_250_1.actors_["1137"].transform
			local var_253_16 = 0

			if var_253_16 < arg_250_1.time_ and arg_250_1.time_ <= var_253_16 + arg_253_0 then
				arg_250_1.var_.moveOldPos1137 = var_253_15.localPosition
				var_253_15.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1137", 7)

				local var_253_17 = var_253_15.childCount

				for iter_253_5 = 0, var_253_17 - 1 do
					local var_253_18 = var_253_15:GetChild(iter_253_5)

					if var_253_18.name == "" or not string.find(var_253_18.name, "split") then
						var_253_18.gameObject:SetActive(true)
					else
						var_253_18.gameObject:SetActive(false)
					end
				end
			end

			local var_253_19 = 0.001

			if var_253_16 <= arg_250_1.time_ and arg_250_1.time_ < var_253_16 + var_253_19 then
				local var_253_20 = (arg_250_1.time_ - var_253_16) / var_253_19
				local var_253_21 = Vector3.New(0, -2000, 0)

				var_253_15.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1137, var_253_21, var_253_20)
			end

			if arg_250_1.time_ >= var_253_16 + var_253_19 and arg_250_1.time_ < var_253_16 + var_253_19 + arg_253_0 then
				var_253_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_22 = 0
			local var_253_23 = 0.975

			if var_253_22 < arg_250_1.time_ and arg_250_1.time_ <= var_253_22 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_24 = arg_250_1:GetWordFromCfg(425121060)
				local var_253_25 = arg_250_1:FormatText(var_253_24.content)

				arg_250_1.text_.text = var_253_25

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_26 = 39
				local var_253_27 = utf8.len(var_253_25)
				local var_253_28 = var_253_26 <= 0 and var_253_23 or var_253_23 * (var_253_27 / var_253_26)

				if var_253_28 > 0 and var_253_23 < var_253_28 then
					arg_250_1.talkMaxDuration = var_253_28

					if var_253_28 + var_253_22 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_28 + var_253_22
					end
				end

				arg_250_1.text_.text = var_253_25
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_29 = math.max(var_253_23, arg_250_1.talkMaxDuration)

			if var_253_22 <= arg_250_1.time_ and arg_250_1.time_ < var_253_22 + var_253_29 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_22) / var_253_29

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_22 + var_253_29 and arg_250_1.time_ < var_253_22 + var_253_29 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play425121061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 425121061
		arg_254_1.duration_ = 8

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play425121062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = "M01f"

			if arg_254_1.bgs_[var_257_0] == nil then
				local var_257_1 = Object.Instantiate(arg_254_1.paintGo_)

				var_257_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_257_0)
				var_257_1.name = var_257_0
				var_257_1.transform.parent = arg_254_1.stage_.transform
				var_257_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.bgs_[var_257_0] = var_257_1
			end

			local var_257_2 = 1

			if var_257_2 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				local var_257_3 = manager.ui.mainCamera.transform.localPosition
				local var_257_4 = Vector3.New(0, 0, 10) + Vector3.New(var_257_3.x, var_257_3.y, 0)
				local var_257_5 = arg_254_1.bgs_.M01f

				var_257_5.transform.localPosition = var_257_4
				var_257_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_257_6 = var_257_5:GetComponent("SpriteRenderer")

				if var_257_6 and var_257_6.sprite then
					local var_257_7 = (var_257_5.transform.localPosition - var_257_3).z
					local var_257_8 = manager.ui.mainCameraCom_
					local var_257_9 = 2 * var_257_7 * Mathf.Tan(var_257_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_257_10 = var_257_9 * var_257_8.aspect
					local var_257_11 = var_257_6.sprite.bounds.size.x
					local var_257_12 = var_257_6.sprite.bounds.size.y
					local var_257_13 = var_257_10 / var_257_11
					local var_257_14 = var_257_9 / var_257_12
					local var_257_15 = var_257_14 < var_257_13 and var_257_13 or var_257_14

					var_257_5.transform.localScale = Vector3.New(var_257_15, var_257_15, 0)
				end

				for iter_257_0, iter_257_1 in pairs(arg_254_1.bgs_) do
					if iter_257_0 ~= "M01f" then
						iter_257_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_257_16 = 3

			if var_257_16 < arg_254_1.time_ and arg_254_1.time_ <= var_257_16 + arg_257_0 then
				arg_254_1.allBtn_.enabled = false
			end

			local var_257_17 = 0.533333333333333

			if arg_254_1.time_ >= var_257_16 + var_257_17 and arg_254_1.time_ < var_257_16 + var_257_17 + arg_257_0 then
				arg_254_1.allBtn_.enabled = true
			end

			local var_257_18 = 0

			if var_257_18 < arg_254_1.time_ and arg_254_1.time_ <= var_257_18 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_19 = 1

			if var_257_18 <= arg_254_1.time_ and arg_254_1.time_ < var_257_18 + var_257_19 then
				local var_257_20 = (arg_254_1.time_ - var_257_18) / var_257_19
				local var_257_21 = Color.New(0, 0, 0)

				var_257_21.a = Mathf.Lerp(0, 1, var_257_20)
				arg_254_1.mask_.color = var_257_21
			end

			if arg_254_1.time_ >= var_257_18 + var_257_19 and arg_254_1.time_ < var_257_18 + var_257_19 + arg_257_0 then
				local var_257_22 = Color.New(0, 0, 0)

				var_257_22.a = 1
				arg_254_1.mask_.color = var_257_22
			end

			local var_257_23 = 1

			if var_257_23 < arg_254_1.time_ and arg_254_1.time_ <= var_257_23 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_24 = 2

			if var_257_23 <= arg_254_1.time_ and arg_254_1.time_ < var_257_23 + var_257_24 then
				local var_257_25 = (arg_254_1.time_ - var_257_23) / var_257_24
				local var_257_26 = Color.New(0, 0, 0)

				var_257_26.a = Mathf.Lerp(1, 0, var_257_25)
				arg_254_1.mask_.color = var_257_26
			end

			if arg_254_1.time_ >= var_257_23 + var_257_24 and arg_254_1.time_ < var_257_23 + var_257_24 + arg_257_0 then
				local var_257_27 = Color.New(0, 0, 0)
				local var_257_28 = 0

				arg_254_1.mask_.enabled = false
				var_257_27.a = var_257_28
				arg_254_1.mask_.color = var_257_27
			end

			local var_257_29 = 0.133333333333333
			local var_257_30 = 1

			if var_257_29 < arg_254_1.time_ and arg_254_1.time_ <= var_257_29 + arg_257_0 then
				local var_257_31 = "stop"
				local var_257_32 = "effect"

				arg_254_1:AudioAction(var_257_31, var_257_32, "se_story_134_01", "se_story_134_01_crowd", "")
			end

			if arg_254_1.frameCnt_ <= 1 then
				arg_254_1.dialog_:SetActive(false)
			end

			local var_257_33 = 3
			local var_257_34 = 0.725

			if var_257_33 < arg_254_1.time_ and arg_254_1.time_ <= var_257_33 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0

				arg_254_1.dialog_:SetActive(true)

				arg_254_1.dialogCg_.alpha = 0

				local var_257_35 = LeanTween.value(arg_254_1.dialog_, 0, 1, 0.3)

				var_257_35:setOnUpdate(LuaHelper.FloatAction(function(arg_258_0)
					arg_254_1.dialogCg_.alpha = arg_258_0
				end))
				var_257_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_254_1.dialog_)
					var_257_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_254_1.duration_ = arg_254_1.duration_ + 0.3

				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_36 = arg_254_1:GetWordFromCfg(425121061)
				local var_257_37 = arg_254_1:FormatText(var_257_36.content)

				arg_254_1.text_.text = var_257_37

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_38 = 29
				local var_257_39 = utf8.len(var_257_37)
				local var_257_40 = var_257_38 <= 0 and var_257_34 or var_257_34 * (var_257_39 / var_257_38)

				if var_257_40 > 0 and var_257_34 < var_257_40 then
					arg_254_1.talkMaxDuration = var_257_40
					var_257_33 = var_257_33 + 0.3

					if var_257_40 + var_257_33 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_40 + var_257_33
					end
				end

				arg_254_1.text_.text = var_257_37
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_41 = var_257_33 + 0.3
			local var_257_42 = math.max(var_257_34, arg_254_1.talkMaxDuration)

			if var_257_41 <= arg_254_1.time_ and arg_254_1.time_ < var_257_41 + var_257_42 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_41) / var_257_42

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_41 + var_257_42 and arg_254_1.time_ < var_257_41 + var_257_42 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play425121062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 425121062
		arg_260_1.duration_ = 5.63

		local var_260_0 = {
			zh = 4.466,
			ja = 5.633
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
				arg_260_0:Play425121063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1137"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1137 == nil then
				arg_260_1.var_.actorSpriteComps1137 = var_263_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_2 = 0.2

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.actorSpriteComps1137 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								local var_263_4 = Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, var_263_3)
								local var_263_5 = Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, var_263_3)
								local var_263_6 = Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, var_263_3)

								iter_263_1.color = Color.New(var_263_4, var_263_5, var_263_6)
							else
								local var_263_7 = Mathf.Lerp(iter_263_1.color.r, 1, var_263_3)

								iter_263_1.color = Color.New(var_263_7, var_263_7, var_263_7)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1137 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_263_3 then
						if arg_260_1.isInRecall_ then
							iter_263_3.color = arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_263_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_260_1.var_.actorSpriteComps1137 = nil
			end

			local var_263_8 = arg_260_1.actors_["1137"].transform
			local var_263_9 = 0

			if var_263_9 < arg_260_1.time_ and arg_260_1.time_ <= var_263_9 + arg_263_0 then
				arg_260_1.var_.moveOldPos1137 = var_263_8.localPosition
				var_263_8.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("1137", 3)

				local var_263_10 = var_263_8.childCount

				for iter_263_4 = 0, var_263_10 - 1 do
					local var_263_11 = var_263_8:GetChild(iter_263_4)

					if var_263_11.name == "split_6" or not string.find(var_263_11.name, "split") then
						var_263_11.gameObject:SetActive(true)
					else
						var_263_11.gameObject:SetActive(false)
					end
				end
			end

			local var_263_12 = 0.001

			if var_263_9 <= arg_260_1.time_ and arg_260_1.time_ < var_263_9 + var_263_12 then
				local var_263_13 = (arg_260_1.time_ - var_263_9) / var_263_12
				local var_263_14 = Vector3.New(0, -425, -200)

				var_263_8.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1137, var_263_14, var_263_13)
			end

			if arg_260_1.time_ >= var_263_9 + var_263_12 and arg_260_1.time_ < var_263_9 + var_263_12 + arg_263_0 then
				var_263_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_263_15 = 0
			local var_263_16 = 0.525

			if var_263_15 < arg_260_1.time_ and arg_260_1.time_ <= var_263_15 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_17 = arg_260_1:FormatText(StoryNameCfg[15].name)

				arg_260_1.leftNameTxt_.text = var_263_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_18 = arg_260_1:GetWordFromCfg(425121062)
				local var_263_19 = arg_260_1:FormatText(var_263_18.content)

				arg_260_1.text_.text = var_263_19

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_20 = 21
				local var_263_21 = utf8.len(var_263_19)
				local var_263_22 = var_263_20 <= 0 and var_263_16 or var_263_16 * (var_263_21 / var_263_20)

				if var_263_22 > 0 and var_263_16 < var_263_22 then
					arg_260_1.talkMaxDuration = var_263_22

					if var_263_22 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_22 + var_263_15
					end
				end

				arg_260_1.text_.text = var_263_19
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121062", "story_v_out_425121.awb") ~= 0 then
					local var_263_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121062", "story_v_out_425121.awb") / 1000

					if var_263_23 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_23 + var_263_15
					end

					if var_263_18.prefab_name ~= "" and arg_260_1.actors_[var_263_18.prefab_name] ~= nil then
						local var_263_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_18.prefab_name].transform, "story_v_out_425121", "425121062", "story_v_out_425121.awb")

						arg_260_1:RecordAudio("425121062", var_263_24)
						arg_260_1:RecordAudio("425121062", var_263_24)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_425121", "425121062", "story_v_out_425121.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_425121", "425121062", "story_v_out_425121.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_25 = math.max(var_263_16, arg_260_1.talkMaxDuration)

			if var_263_15 <= arg_260_1.time_ and arg_260_1.time_ < var_263_15 + var_263_25 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_15) / var_263_25

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_15 + var_263_25 and arg_260_1.time_ < var_263_15 + var_263_25 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play425121063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 425121063
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play425121064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1137"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos1137 = var_267_0.localPosition
				var_267_0.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1137", 7)

				local var_267_2 = var_267_0.childCount

				for iter_267_0 = 0, var_267_2 - 1 do
					local var_267_3 = var_267_0:GetChild(iter_267_0)

					if var_267_3.name == "" or not string.find(var_267_3.name, "split") then
						var_267_3.gameObject:SetActive(true)
					else
						var_267_3.gameObject:SetActive(false)
					end
				end
			end

			local var_267_4 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_4 then
				local var_267_5 = (arg_264_1.time_ - var_267_1) / var_267_4
				local var_267_6 = Vector3.New(0, -2000, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1137, var_267_6, var_267_5)
			end

			if arg_264_1.time_ >= var_267_1 + var_267_4 and arg_264_1.time_ < var_267_1 + var_267_4 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_267_7 = 0.133333333333333
			local var_267_8 = 1

			if var_267_7 < arg_264_1.time_ and arg_264_1.time_ <= var_267_7 + arg_267_0 then
				local var_267_9 = "play"
				local var_267_10 = "effect"

				arg_264_1:AudioAction(var_267_9, var_267_10, "se_story_144", "se_story_144_case_open", "")
			end

			local var_267_11 = 0
			local var_267_12 = 0.675

			if var_267_11 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_13 = arg_264_1:GetWordFromCfg(425121063)
				local var_267_14 = arg_264_1:FormatText(var_267_13.content)

				arg_264_1.text_.text = var_267_14

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_15 = 27
				local var_267_16 = utf8.len(var_267_14)
				local var_267_17 = var_267_15 <= 0 and var_267_12 or var_267_12 * (var_267_16 / var_267_15)

				if var_267_17 > 0 and var_267_12 < var_267_17 then
					arg_264_1.talkMaxDuration = var_267_17

					if var_267_17 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_17 + var_267_11
					end
				end

				arg_264_1.text_.text = var_267_14
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_18 = math.max(var_267_12, arg_264_1.talkMaxDuration)

			if var_267_11 <= arg_264_1.time_ and arg_264_1.time_ < var_267_11 + var_267_18 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_11) / var_267_18

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_11 + var_267_18 and arg_264_1.time_ < var_267_11 + var_267_18 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play425121064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 425121064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play425121065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 1.575

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_2 = arg_268_1:GetWordFromCfg(425121064)
				local var_271_3 = arg_268_1:FormatText(var_271_2.content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 63
				local var_271_5 = utf8.len(var_271_3)
				local var_271_6 = var_271_4 <= 0 and var_271_1 or var_271_1 * (var_271_5 / var_271_4)

				if var_271_6 > 0 and var_271_1 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_7 and arg_268_1.time_ < var_271_0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play425121065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 425121065
		arg_272_1.duration_ = 5.3

		local var_272_0 = {
			zh = 5.3,
			ja = 5
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
				arg_272_0:Play425121066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.475

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1439].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(425121065)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 19
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121065", "story_v_out_425121.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121065", "story_v_out_425121.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_425121", "425121065", "story_v_out_425121.awb")

						arg_272_1:RecordAudio("425121065", var_275_9)
						arg_272_1:RecordAudio("425121065", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_425121", "425121065", "story_v_out_425121.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_425121", "425121065", "story_v_out_425121.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play425121066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 425121066
		arg_276_1.duration_ = 2.63

		local var_276_0 = {
			zh = 1.633,
			ja = 2.633
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
				arg_276_0:Play425121067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1137"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps1137 == nil then
				arg_276_1.var_.actorSpriteComps1137 = var_279_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_2 = 0.2

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.actorSpriteComps1137 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								local var_279_4 = Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, var_279_3)
								local var_279_5 = Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, var_279_3)
								local var_279_6 = Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, var_279_3)

								iter_279_1.color = Color.New(var_279_4, var_279_5, var_279_6)
							else
								local var_279_7 = Mathf.Lerp(iter_279_1.color.r, 1, var_279_3)

								iter_279_1.color = Color.New(var_279_7, var_279_7, var_279_7)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps1137 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_279_3 then
						if arg_276_1.isInRecall_ then
							iter_279_3.color = arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_279_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps1137 = nil
			end

			local var_279_8 = arg_276_1.actors_["1137"].transform
			local var_279_9 = 0

			if var_279_9 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.var_.moveOldPos1137 = var_279_8.localPosition
				var_279_8.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("1137", 3)

				local var_279_10 = var_279_8.childCount

				for iter_279_4 = 0, var_279_10 - 1 do
					local var_279_11 = var_279_8:GetChild(iter_279_4)

					if var_279_11.name == "split_5" or not string.find(var_279_11.name, "split") then
						var_279_11.gameObject:SetActive(true)
					else
						var_279_11.gameObject:SetActive(false)
					end
				end
			end

			local var_279_12 = 0.001

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_12 then
				local var_279_13 = (arg_276_1.time_ - var_279_9) / var_279_12
				local var_279_14 = Vector3.New(0, -425, -200)

				var_279_8.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1137, var_279_14, var_279_13)
			end

			if arg_276_1.time_ >= var_279_9 + var_279_12 and arg_276_1.time_ < var_279_9 + var_279_12 + arg_279_0 then
				var_279_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_279_15 = 0
			local var_279_16 = 0.15

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_17 = arg_276_1:FormatText(StoryNameCfg[15].name)

				arg_276_1.leftNameTxt_.text = var_279_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_18 = arg_276_1:GetWordFromCfg(425121066)
				local var_279_19 = arg_276_1:FormatText(var_279_18.content)

				arg_276_1.text_.text = var_279_19

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_20 = 6
				local var_279_21 = utf8.len(var_279_19)
				local var_279_22 = var_279_20 <= 0 and var_279_16 or var_279_16 * (var_279_21 / var_279_20)

				if var_279_22 > 0 and var_279_16 < var_279_22 then
					arg_276_1.talkMaxDuration = var_279_22

					if var_279_22 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_19
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121066", "story_v_out_425121.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121066", "story_v_out_425121.awb") / 1000

					if var_279_23 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_15
					end

					if var_279_18.prefab_name ~= "" and arg_276_1.actors_[var_279_18.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_18.prefab_name].transform, "story_v_out_425121", "425121066", "story_v_out_425121.awb")

						arg_276_1:RecordAudio("425121066", var_279_24)
						arg_276_1:RecordAudio("425121066", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_425121", "425121066", "story_v_out_425121.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_425121", "425121066", "story_v_out_425121.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_25 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_25 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_25

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_25 and arg_276_1.time_ < var_279_15 + var_279_25 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play425121067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 425121067
		arg_280_1.duration_ = 10.97

		local var_280_0 = {
			zh = 8.7,
			ja = 10.966
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play425121068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1137"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps1137 == nil then
				arg_280_1.var_.actorSpriteComps1137 = var_283_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_2 = 0.2

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.actorSpriteComps1137 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								local var_283_4 = Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, var_283_3)
								local var_283_5 = Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, var_283_3)
								local var_283_6 = Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, var_283_3)

								iter_283_1.color = Color.New(var_283_4, var_283_5, var_283_6)
							else
								local var_283_7 = Mathf.Lerp(iter_283_1.color.r, 0.5, var_283_3)

								iter_283_1.color = Color.New(var_283_7, var_283_7, var_283_7)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps1137 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_283_3 then
						if arg_280_1.isInRecall_ then
							iter_283_3.color = arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_283_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps1137 = nil
			end

			local var_283_8 = 0
			local var_283_9 = 0.775

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_10 = arg_280_1:FormatText(StoryNameCfg[1439].name)

				arg_280_1.leftNameTxt_.text = var_283_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_11 = arg_280_1:GetWordFromCfg(425121067)
				local var_283_12 = arg_280_1:FormatText(var_283_11.content)

				arg_280_1.text_.text = var_283_12

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 31
				local var_283_14 = utf8.len(var_283_12)
				local var_283_15 = var_283_13 <= 0 and var_283_9 or var_283_9 * (var_283_14 / var_283_13)

				if var_283_15 > 0 and var_283_9 < var_283_15 then
					arg_280_1.talkMaxDuration = var_283_15

					if var_283_15 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_15 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_12
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121067", "story_v_out_425121.awb") ~= 0 then
					local var_283_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121067", "story_v_out_425121.awb") / 1000

					if var_283_16 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_16 + var_283_8
					end

					if var_283_11.prefab_name ~= "" and arg_280_1.actors_[var_283_11.prefab_name] ~= nil then
						local var_283_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_11.prefab_name].transform, "story_v_out_425121", "425121067", "story_v_out_425121.awb")

						arg_280_1:RecordAudio("425121067", var_283_17)
						arg_280_1:RecordAudio("425121067", var_283_17)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_425121", "425121067", "story_v_out_425121.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_425121", "425121067", "story_v_out_425121.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_18 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_18 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_18

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_18 and arg_280_1.time_ < var_283_8 + var_283_18 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play425121068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 425121068
		arg_284_1.duration_ = 11.1

		local var_284_0 = {
			zh = 6.666,
			ja = 11.1
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
				arg_284_0:Play425121069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1137"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1137 == nil then
				arg_284_1.var_.actorSpriteComps1137 = var_287_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.actorSpriteComps1137 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1137 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_287_3 then
						if arg_284_1.isInRecall_ then
							iter_287_3.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps1137 = nil
			end

			local var_287_8 = arg_284_1.actors_["1137"].transform
			local var_287_9 = 0

			if var_287_9 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.var_.moveOldPos1137 = var_287_8.localPosition
				var_287_8.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1137", 3)

				local var_287_10 = var_287_8.childCount

				for iter_287_4 = 0, var_287_10 - 1 do
					local var_287_11 = var_287_8:GetChild(iter_287_4)

					if var_287_11.name == "split_6" then
						var_287_11:SetAsLastSibling()
						var_287_11.gameObject:SetActive(true)

						arg_284_1.var_.actorSpriteSplit1137 = var_287_11.gameObject:GetComponent(typeof(Image))

						arg_284_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_287_12 = 0.2

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_12 then
				local var_287_13 = (arg_284_1.time_ - var_287_9) / var_287_12
				local var_287_14 = Vector3.New(0, -425, -200)

				var_287_8.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1137, var_287_14, var_287_13)

				if arg_284_1.var_.actorSpriteSplit1137 ~= nil then
					arg_284_1.var_.actorSpriteSplit1137:SetAlpha(var_287_13)
				end
			end

			if arg_284_1.time_ >= var_287_9 + var_287_12 and arg_284_1.time_ < var_287_9 + var_287_12 + arg_287_0 then
				var_287_8.localPosition = Vector3.New(0, -425, -200)

				if arg_284_1.var_.actorSpriteSplit1137 ~= nil then
					arg_284_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_287_15 = 0
			local var_287_16 = 0.825

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_17 = arg_284_1:FormatText(StoryNameCfg[15].name)

				arg_284_1.leftNameTxt_.text = var_287_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:GetWordFromCfg(425121068)
				local var_287_19 = arg_284_1:FormatText(var_287_18.content)

				arg_284_1.text_.text = var_287_19

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 33
				local var_287_21 = utf8.len(var_287_19)
				local var_287_22 = var_287_20 <= 0 and var_287_16 or var_287_16 * (var_287_21 / var_287_20)

				if var_287_22 > 0 and var_287_16 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22

					if var_287_22 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_19
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121068", "story_v_out_425121.awb") ~= 0 then
					local var_287_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121068", "story_v_out_425121.awb") / 1000

					if var_287_23 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_23 + var_287_15
					end

					if var_287_18.prefab_name ~= "" and arg_284_1.actors_[var_287_18.prefab_name] ~= nil then
						local var_287_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_18.prefab_name].transform, "story_v_out_425121", "425121068", "story_v_out_425121.awb")

						arg_284_1:RecordAudio("425121068", var_287_24)
						arg_284_1:RecordAudio("425121068", var_287_24)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_425121", "425121068", "story_v_out_425121.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_425121", "425121068", "story_v_out_425121.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_25 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_25 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_25

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_25 and arg_284_1.time_ < var_287_15 + var_287_25 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play425121069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 425121069
		arg_288_1.duration_ = 5.13

		local var_288_0 = {
			zh = 4.1,
			ja = 5.133
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
				arg_288_0:Play425121070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1137"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1137 == nil then
				arg_288_1.var_.actorSpriteComps1137 = var_291_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_2 = 0.2

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.actorSpriteComps1137 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								local var_291_4 = Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, var_291_3)
								local var_291_5 = Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, var_291_3)
								local var_291_6 = Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, var_291_3)

								iter_291_1.color = Color.New(var_291_4, var_291_5, var_291_6)
							else
								local var_291_7 = Mathf.Lerp(iter_291_1.color.r, 0.5, var_291_3)

								iter_291_1.color = Color.New(var_291_7, var_291_7, var_291_7)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.actorSpriteComps1137 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_291_3 then
						if arg_288_1.isInRecall_ then
							iter_291_3.color = arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_291_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps1137 = nil
			end

			local var_291_8 = 0
			local var_291_9 = 0.35

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_10 = arg_288_1:FormatText(StoryNameCfg[1439].name)

				arg_288_1.leftNameTxt_.text = var_291_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_11 = arg_288_1:GetWordFromCfg(425121069)
				local var_291_12 = arg_288_1:FormatText(var_291_11.content)

				arg_288_1.text_.text = var_291_12

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 14
				local var_291_14 = utf8.len(var_291_12)
				local var_291_15 = var_291_13 <= 0 and var_291_9 or var_291_9 * (var_291_14 / var_291_13)

				if var_291_15 > 0 and var_291_9 < var_291_15 then
					arg_288_1.talkMaxDuration = var_291_15

					if var_291_15 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_15 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_12
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121069", "story_v_out_425121.awb") ~= 0 then
					local var_291_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121069", "story_v_out_425121.awb") / 1000

					if var_291_16 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_16 + var_291_8
					end

					if var_291_11.prefab_name ~= "" and arg_288_1.actors_[var_291_11.prefab_name] ~= nil then
						local var_291_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_11.prefab_name].transform, "story_v_out_425121", "425121069", "story_v_out_425121.awb")

						arg_288_1:RecordAudio("425121069", var_291_17)
						arg_288_1:RecordAudio("425121069", var_291_17)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_425121", "425121069", "story_v_out_425121.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_425121", "425121069", "story_v_out_425121.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_18 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_18 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_18

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_18 and arg_288_1.time_ < var_291_8 + var_291_18 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play425121070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 425121070
		arg_292_1.duration_ = 1.57

		local var_292_0 = {
			zh = 1.4,
			ja = 1.566
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
				arg_292_0:Play425121071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1137"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1137 == nil then
				arg_292_1.var_.actorSpriteComps1137 = var_295_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.actorSpriteComps1137 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.actorSpriteComps1137 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_295_3 then
						if arg_292_1.isInRecall_ then
							iter_295_3.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps1137 = nil
			end

			local var_295_8 = arg_292_1.actors_["1137"].transform
			local var_295_9 = 0

			if var_295_9 < arg_292_1.time_ and arg_292_1.time_ <= var_295_9 + arg_295_0 then
				arg_292_1.var_.moveOldPos1137 = var_295_8.localPosition
				var_295_8.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("1137", 3)

				local var_295_10 = var_295_8.childCount

				for iter_295_4 = 0, var_295_10 - 1 do
					local var_295_11 = var_295_8:GetChild(iter_295_4)

					if var_295_11.name == "split_4" then
						var_295_11:SetAsLastSibling()
						var_295_11.gameObject:SetActive(true)

						arg_292_1.var_.actorSpriteSplit1137 = var_295_11.gameObject:GetComponent(typeof(Image))

						arg_292_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_295_12 = 0.2

			if var_295_9 <= arg_292_1.time_ and arg_292_1.time_ < var_295_9 + var_295_12 then
				local var_295_13 = (arg_292_1.time_ - var_295_9) / var_295_12
				local var_295_14 = Vector3.New(0, -425, -200)

				var_295_8.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1137, var_295_14, var_295_13)

				if arg_292_1.var_.actorSpriteSplit1137 ~= nil then
					arg_292_1.var_.actorSpriteSplit1137:SetAlpha(var_295_13)
				end
			end

			if arg_292_1.time_ >= var_295_9 + var_295_12 and arg_292_1.time_ < var_295_9 + var_295_12 + arg_295_0 then
				var_295_8.localPosition = Vector3.New(0, -425, -200)

				if arg_292_1.var_.actorSpriteSplit1137 ~= nil then
					arg_292_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_295_15 = 0
			local var_295_16 = 0.075

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_17 = arg_292_1:FormatText(StoryNameCfg[15].name)

				arg_292_1.leftNameTxt_.text = var_295_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_18 = arg_292_1:GetWordFromCfg(425121070)
				local var_295_19 = arg_292_1:FormatText(var_295_18.content)

				arg_292_1.text_.text = var_295_19

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_20 = 3
				local var_295_21 = utf8.len(var_295_19)
				local var_295_22 = var_295_20 <= 0 and var_295_16 or var_295_16 * (var_295_21 / var_295_20)

				if var_295_22 > 0 and var_295_16 < var_295_22 then
					arg_292_1.talkMaxDuration = var_295_22

					if var_295_22 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_22 + var_295_15
					end
				end

				arg_292_1.text_.text = var_295_19
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121070", "story_v_out_425121.awb") ~= 0 then
					local var_295_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121070", "story_v_out_425121.awb") / 1000

					if var_295_23 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_23 + var_295_15
					end

					if var_295_18.prefab_name ~= "" and arg_292_1.actors_[var_295_18.prefab_name] ~= nil then
						local var_295_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_18.prefab_name].transform, "story_v_out_425121", "425121070", "story_v_out_425121.awb")

						arg_292_1:RecordAudio("425121070", var_295_24)
						arg_292_1:RecordAudio("425121070", var_295_24)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_425121", "425121070", "story_v_out_425121.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_425121", "425121070", "story_v_out_425121.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_25 = math.max(var_295_16, arg_292_1.talkMaxDuration)

			if var_295_15 <= arg_292_1.time_ and arg_292_1.time_ < var_295_15 + var_295_25 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_15) / var_295_25

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_15 + var_295_25 and arg_292_1.time_ < var_295_15 + var_295_25 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play425121071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 425121071
		arg_296_1.duration_ = 12.1

		local var_296_0 = {
			zh = 8.233,
			ja = 12.1
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
				arg_296_0:Play425121072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1137"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps1137 == nil then
				arg_296_1.var_.actorSpriteComps1137 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps1137 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps1137 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps1137 = nil
			end

			local var_299_8 = 0
			local var_299_9 = 0.75

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_10 = arg_296_1:FormatText(StoryNameCfg[1439].name)

				arg_296_1.leftNameTxt_.text = var_299_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_11 = arg_296_1:GetWordFromCfg(425121071)
				local var_299_12 = arg_296_1:FormatText(var_299_11.content)

				arg_296_1.text_.text = var_299_12

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 30
				local var_299_14 = utf8.len(var_299_12)
				local var_299_15 = var_299_13 <= 0 and var_299_9 or var_299_9 * (var_299_14 / var_299_13)

				if var_299_15 > 0 and var_299_9 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_12
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121071", "story_v_out_425121.awb") ~= 0 then
					local var_299_16 = manager.audio:GetVoiceLength("story_v_out_425121", "425121071", "story_v_out_425121.awb") / 1000

					if var_299_16 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_8
					end

					if var_299_11.prefab_name ~= "" and arg_296_1.actors_[var_299_11.prefab_name] ~= nil then
						local var_299_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_11.prefab_name].transform, "story_v_out_425121", "425121071", "story_v_out_425121.awb")

						arg_296_1:RecordAudio("425121071", var_299_17)
						arg_296_1:RecordAudio("425121071", var_299_17)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_425121", "425121071", "story_v_out_425121.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_425121", "425121071", "story_v_out_425121.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_18 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_18 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_18

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_18 and arg_296_1.time_ < var_299_8 + var_299_18 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play425121072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 425121072
		arg_300_1.duration_ = 11.37

		local var_300_0 = {
			zh = 7.7,
			ja = 11.366
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
				arg_300_0:Play425121073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.75

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[1439].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(425121072)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 30
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121072", "story_v_out_425121.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121072", "story_v_out_425121.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_425121", "425121072", "story_v_out_425121.awb")

						arg_300_1:RecordAudio("425121072", var_303_9)
						arg_300_1:RecordAudio("425121072", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_425121", "425121072", "story_v_out_425121.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_425121", "425121072", "story_v_out_425121.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play425121073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 425121073
		arg_304_1.duration_ = 19.17

		local var_304_0 = {
			zh = 13.4,
			ja = 19.166
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
				arg_304_0:Play425121074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.2

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[1439].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(425121073)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121073", "story_v_out_425121.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121073", "story_v_out_425121.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_425121", "425121073", "story_v_out_425121.awb")

						arg_304_1:RecordAudio("425121073", var_307_9)
						arg_304_1:RecordAudio("425121073", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_425121", "425121073", "story_v_out_425121.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_425121", "425121073", "story_v_out_425121.awb")
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
	Play425121074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 425121074
		arg_308_1.duration_ = 5.8

		local var_308_0 = {
			zh = 2.8,
			ja = 5.8
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
				arg_308_0:Play425121075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1137"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1137 == nil then
				arg_308_1.var_.actorSpriteComps1137 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps1137 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1137 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps1137 = nil
			end

			local var_311_8 = arg_308_1.actors_["1137"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos1137 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1137", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_4" or not string.find(var_311_11.name, "split") then
						var_311_11.gameObject:SetActive(true)
					else
						var_311_11.gameObject:SetActive(false)
					end
				end
			end

			local var_311_12 = 0.001

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(0, -425, -200)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1137, var_311_14, var_311_13)
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_311_15 = 0
			local var_311_16 = 0.375

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[15].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(425121074)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 15
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121074", "story_v_out_425121.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121074", "story_v_out_425121.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_425121", "425121074", "story_v_out_425121.awb")

						arg_308_1:RecordAudio("425121074", var_311_24)
						arg_308_1:RecordAudio("425121074", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_425121", "425121074", "story_v_out_425121.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_425121", "425121074", "story_v_out_425121.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play425121075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 425121075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play425121076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1137"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1137 == nil then
				arg_312_1.var_.actorSpriteComps1137 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1137 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 0.5, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1137 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1137 = nil
			end

			local var_315_8 = arg_312_1.actors_["1137"].transform
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.var_.moveOldPos1137 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1137", 7)

				local var_315_10 = var_315_8.childCount

				for iter_315_4 = 0, var_315_10 - 1 do
					local var_315_11 = var_315_8:GetChild(iter_315_4)

					if var_315_11.name == "" or not string.find(var_315_11.name, "split") then
						var_315_11.gameObject:SetActive(true)
					else
						var_315_11.gameObject:SetActive(false)
					end
				end
			end

			local var_315_12 = 0.001

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_9) / var_315_12
				local var_315_14 = Vector3.New(0, -2000, 0)

				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1137, var_315_14, var_315_13)
			end

			if arg_312_1.time_ >= var_315_9 + var_315_12 and arg_312_1.time_ < var_315_9 + var_315_12 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_15 = 0
			local var_315_16 = 0.85

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_17 = arg_312_1:GetWordFromCfg(425121075)
				local var_315_18 = arg_312_1:FormatText(var_315_17.content)

				arg_312_1.text_.text = var_315_18

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_19 = 34
				local var_315_20 = utf8.len(var_315_18)
				local var_315_21 = var_315_19 <= 0 and var_315_16 or var_315_16 * (var_315_20 / var_315_19)

				if var_315_21 > 0 and var_315_16 < var_315_21 then
					arg_312_1.talkMaxDuration = var_315_21

					if var_315_21 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_21 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_18
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_22 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_22 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_22

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_22 and arg_312_1.time_ < var_315_15 + var_315_22 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425121076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 425121076
		arg_316_1.duration_ = 3.63

		local var_316_0 = {
			zh = 3.633,
			ja = 3.5
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
				arg_316_0:Play425121077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.225

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[1439].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(425121076)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 9
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121076", "story_v_out_425121.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121076", "story_v_out_425121.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_425121", "425121076", "story_v_out_425121.awb")

						arg_316_1:RecordAudio("425121076", var_319_9)
						arg_316_1:RecordAudio("425121076", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_425121", "425121076", "story_v_out_425121.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_425121", "425121076", "story_v_out_425121.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play425121077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 425121077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play425121078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.133333333333333
			local var_323_1 = 1

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				local var_323_2 = "play"
				local var_323_3 = "effect"

				arg_320_1:AudioAction(var_323_2, var_323_3, "se_story_122_01", "se_story_122_01_beep", "")
			end

			local var_323_4 = manager.ui.mainCamera.transform
			local var_323_5 = 0

			if var_323_5 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				local var_323_6 = arg_320_1.var_.effect1077
				local var_323_7
				local var_323_8 = var_323_4

				if not var_323_6 then
					var_323_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_323_8)
					var_323_6.name = "1077"
					arg_320_1.var_.effect1077 = var_323_6
				else
					var_323_6.transform:SetParent(var_323_8)
				end

				var_323_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_323_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_323_9 = 1.7777777777777777
				local var_323_10 = Screen.width / Screen.height
				local var_323_11 = var_323_10 / var_323_9
				local var_323_12 = Mathf.Max(var_323_9 / var_323_10, 1)

				var_323_6.transform.localScale = Vector3.New(var_323_6.transform.localScale.x * var_323_11, var_323_6.transform.localScale.y * var_323_12, var_323_6.transform.localScale.z)
			end

			local var_323_13 = manager.ui.mainCamera.transform
			local var_323_14 = 1.73333333333333

			if var_323_14 < arg_320_1.time_ and arg_320_1.time_ <= var_323_14 + arg_323_0 then
				local var_323_15 = arg_320_1.var_.effect1077

				if var_323_15 then
					Object.Destroy(var_323_15)

					arg_320_1.var_.effect1077 = nil
				end
			end

			local var_323_16 = 0
			local var_323_17 = 1.05

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_18 = arg_320_1:GetWordFromCfg(425121077)
				local var_323_19 = arg_320_1:FormatText(var_323_18.content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_20 = 42
				local var_323_21 = utf8.len(var_323_19)
				local var_323_22 = var_323_20 <= 0 and var_323_17 or var_323_17 * (var_323_21 / var_323_20)

				if var_323_22 > 0 and var_323_17 < var_323_22 then
					arg_320_1.talkMaxDuration = var_323_22

					if var_323_22 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_16
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_23 = math.max(var_323_17, arg_320_1.talkMaxDuration)

			if var_323_16 <= arg_320_1.time_ and arg_320_1.time_ < var_323_16 + var_323_23 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_16) / var_323_23

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_16 + var_323_23 and arg_320_1.time_ < var_323_16 + var_323_23 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play425121078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 425121078
		arg_324_1.duration_ = 1.47

		local var_324_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_324_0:Play425121079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1137"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps1137 == nil then
				arg_324_1.var_.actorSpriteComps1137 = var_327_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.actorSpriteComps1137 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								local var_327_4 = Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor1.r, var_327_3)
								local var_327_5 = Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor1.g, var_327_3)
								local var_327_6 = Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor1.b, var_327_3)

								iter_327_1.color = Color.New(var_327_4, var_327_5, var_327_6)
							else
								local var_327_7 = Mathf.Lerp(iter_327_1.color.r, 1, var_327_3)

								iter_327_1.color = Color.New(var_327_7, var_327_7, var_327_7)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps1137 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_327_3 then
						if arg_324_1.isInRecall_ then
							iter_327_3.color = arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_327_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps1137 = nil
			end

			local var_327_8 = arg_324_1.actors_["1137"].transform
			local var_327_9 = 0

			if var_327_9 < arg_324_1.time_ and arg_324_1.time_ <= var_327_9 + arg_327_0 then
				arg_324_1.var_.moveOldPos1137 = var_327_8.localPosition
				var_327_8.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1137", 3)

				local var_327_10 = var_327_8.childCount

				for iter_327_4 = 0, var_327_10 - 1 do
					local var_327_11 = var_327_8:GetChild(iter_327_4)

					if var_327_11.name == "split_6" or not string.find(var_327_11.name, "split") then
						var_327_11.gameObject:SetActive(true)
					else
						var_327_11.gameObject:SetActive(false)
					end
				end
			end

			local var_327_12 = 0.001

			if var_327_9 <= arg_324_1.time_ and arg_324_1.time_ < var_327_9 + var_327_12 then
				local var_327_13 = (arg_324_1.time_ - var_327_9) / var_327_12
				local var_327_14 = Vector3.New(0, -425, -200)

				var_327_8.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1137, var_327_14, var_327_13)
			end

			if arg_324_1.time_ >= var_327_9 + var_327_12 and arg_324_1.time_ < var_327_9 + var_327_12 + arg_327_0 then
				var_327_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_327_15 = manager.ui.mainCamera.transform
			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				local var_327_17 = arg_324_1.var_.effect1077

				if var_327_17 then
					Object.Destroy(var_327_17)

					arg_324_1.var_.effect1077 = nil
				end
			end

			local var_327_18 = 0
			local var_327_19 = 0.075

			if var_327_18 < arg_324_1.time_ and arg_324_1.time_ <= var_327_18 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_20 = arg_324_1:FormatText(StoryNameCfg[15].name)

				arg_324_1.leftNameTxt_.text = var_327_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_21 = arg_324_1:GetWordFromCfg(425121078)
				local var_327_22 = arg_324_1:FormatText(var_327_21.content)

				arg_324_1.text_.text = var_327_22

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_23 = 3
				local var_327_24 = utf8.len(var_327_22)
				local var_327_25 = var_327_23 <= 0 and var_327_19 or var_327_19 * (var_327_24 / var_327_23)

				if var_327_25 > 0 and var_327_19 < var_327_25 then
					arg_324_1.talkMaxDuration = var_327_25

					if var_327_25 + var_327_18 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_25 + var_327_18
					end
				end

				arg_324_1.text_.text = var_327_22
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121078", "story_v_out_425121.awb") ~= 0 then
					local var_327_26 = manager.audio:GetVoiceLength("story_v_out_425121", "425121078", "story_v_out_425121.awb") / 1000

					if var_327_26 + var_327_18 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_26 + var_327_18
					end

					if var_327_21.prefab_name ~= "" and arg_324_1.actors_[var_327_21.prefab_name] ~= nil then
						local var_327_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_21.prefab_name].transform, "story_v_out_425121", "425121078", "story_v_out_425121.awb")

						arg_324_1:RecordAudio("425121078", var_327_27)
						arg_324_1:RecordAudio("425121078", var_327_27)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_425121", "425121078", "story_v_out_425121.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_425121", "425121078", "story_v_out_425121.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_28 = math.max(var_327_19, arg_324_1.talkMaxDuration)

			if var_327_18 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_28 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_18) / var_327_28

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_18 + var_327_28 and arg_324_1.time_ < var_327_18 + var_327_28 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play425121079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 425121079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play425121080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1137"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1137 == nil then
				arg_328_1.var_.actorSpriteComps1137 = var_331_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.actorSpriteComps1137 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								local var_331_4 = Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, var_331_3)
								local var_331_5 = Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, var_331_3)
								local var_331_6 = Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, var_331_3)

								iter_331_1.color = Color.New(var_331_4, var_331_5, var_331_6)
							else
								local var_331_7 = Mathf.Lerp(iter_331_1.color.r, 0.5, var_331_3)

								iter_331_1.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1137 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_331_3 then
						if arg_328_1.isInRecall_ then
							iter_331_3.color = arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_331_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_328_1.var_.actorSpriteComps1137 = nil
			end

			local var_331_8 = arg_328_1.actors_["1137"].transform
			local var_331_9 = 0

			if var_331_9 < arg_328_1.time_ and arg_328_1.time_ <= var_331_9 + arg_331_0 then
				arg_328_1.var_.moveOldPos1137 = var_331_8.localPosition
				var_331_8.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("1137", 7)

				local var_331_10 = var_331_8.childCount

				for iter_331_4 = 0, var_331_10 - 1 do
					local var_331_11 = var_331_8:GetChild(iter_331_4)

					if var_331_11.name == "" or not string.find(var_331_11.name, "split") then
						var_331_11.gameObject:SetActive(true)
					else
						var_331_11.gameObject:SetActive(false)
					end
				end
			end

			local var_331_12 = 0.001

			if var_331_9 <= arg_328_1.time_ and arg_328_1.time_ < var_331_9 + var_331_12 then
				local var_331_13 = (arg_328_1.time_ - var_331_9) / var_331_12
				local var_331_14 = Vector3.New(0, -2000, 0)

				var_331_8.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1137, var_331_14, var_331_13)
			end

			if arg_328_1.time_ >= var_331_9 + var_331_12 and arg_328_1.time_ < var_331_9 + var_331_12 + arg_331_0 then
				var_331_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_331_15 = 0
			local var_331_16 = 0.75

			if var_331_15 < arg_328_1.time_ and arg_328_1.time_ <= var_331_15 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_17 = arg_328_1:GetWordFromCfg(425121079)
				local var_331_18 = arg_328_1:FormatText(var_331_17.content)

				arg_328_1.text_.text = var_331_18

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_19 = 30
				local var_331_20 = utf8.len(var_331_18)
				local var_331_21 = var_331_19 <= 0 and var_331_16 or var_331_16 * (var_331_20 / var_331_19)

				if var_331_21 > 0 and var_331_16 < var_331_21 then
					arg_328_1.talkMaxDuration = var_331_21

					if var_331_21 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_21 + var_331_15
					end
				end

				arg_328_1.text_.text = var_331_18
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_22 = math.max(var_331_16, arg_328_1.talkMaxDuration)

			if var_331_15 <= arg_328_1.time_ and arg_328_1.time_ < var_331_15 + var_331_22 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_15) / var_331_22

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_15 + var_331_22 and arg_328_1.time_ < var_331_15 + var_331_22 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play425121080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 425121080
		arg_332_1.duration_ = 6.87

		local var_332_0 = {
			zh = 4.966,
			ja = 6.866
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
				arg_332_0:Play425121081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.425

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[1439].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(425121080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121080", "story_v_out_425121.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_425121", "425121080", "story_v_out_425121.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_425121", "425121080", "story_v_out_425121.awb")

						arg_332_1:RecordAudio("425121080", var_335_9)
						arg_332_1:RecordAudio("425121080", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_425121", "425121080", "story_v_out_425121.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_425121", "425121080", "story_v_out_425121.awb")
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
	Play425121081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 425121081
		arg_336_1.duration_ = 4.27

		local var_336_0 = {
			zh = 2.8,
			ja = 4.266
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
				arg_336_0:Play425121082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1137"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps1137 == nil then
				arg_336_1.var_.actorSpriteComps1137 = var_339_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_2 = 0.2

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.actorSpriteComps1137 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								local var_339_4 = Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor1.r, var_339_3)
								local var_339_5 = Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor1.g, var_339_3)
								local var_339_6 = Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor1.b, var_339_3)

								iter_339_1.color = Color.New(var_339_4, var_339_5, var_339_6)
							else
								local var_339_7 = Mathf.Lerp(iter_339_1.color.r, 1, var_339_3)

								iter_339_1.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps1137 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_339_3 then
						if arg_336_1.isInRecall_ then
							iter_339_3.color = arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_339_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_336_1.var_.actorSpriteComps1137 = nil
			end

			local var_339_8 = arg_336_1.actors_["1137"].transform
			local var_339_9 = 0

			if var_339_9 < arg_336_1.time_ and arg_336_1.time_ <= var_339_9 + arg_339_0 then
				arg_336_1.var_.moveOldPos1137 = var_339_8.localPosition
				var_339_8.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("1137", 3)

				local var_339_10 = var_339_8.childCount

				for iter_339_4 = 0, var_339_10 - 1 do
					local var_339_11 = var_339_8:GetChild(iter_339_4)

					if var_339_11.name == "split_6" or not string.find(var_339_11.name, "split") then
						var_339_11.gameObject:SetActive(true)
					else
						var_339_11.gameObject:SetActive(false)
					end
				end
			end

			local var_339_12 = 0.001

			if var_339_9 <= arg_336_1.time_ and arg_336_1.time_ < var_339_9 + var_339_12 then
				local var_339_13 = (arg_336_1.time_ - var_339_9) / var_339_12
				local var_339_14 = Vector3.New(0, -425, -200)

				var_339_8.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1137, var_339_14, var_339_13)
			end

			if arg_336_1.time_ >= var_339_9 + var_339_12 and arg_336_1.time_ < var_339_9 + var_339_12 + arg_339_0 then
				var_339_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_339_15 = 0
			local var_339_16 = 0.35

			if var_339_15 < arg_336_1.time_ and arg_336_1.time_ <= var_339_15 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_17 = arg_336_1:FormatText(StoryNameCfg[15].name)

				arg_336_1.leftNameTxt_.text = var_339_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_18 = arg_336_1:GetWordFromCfg(425121081)
				local var_339_19 = arg_336_1:FormatText(var_339_18.content)

				arg_336_1.text_.text = var_339_19

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_20 = 14
				local var_339_21 = utf8.len(var_339_19)
				local var_339_22 = var_339_20 <= 0 and var_339_16 or var_339_16 * (var_339_21 / var_339_20)

				if var_339_22 > 0 and var_339_16 < var_339_22 then
					arg_336_1.talkMaxDuration = var_339_22

					if var_339_22 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_22 + var_339_15
					end
				end

				arg_336_1.text_.text = var_339_19
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121081", "story_v_out_425121.awb") ~= 0 then
					local var_339_23 = manager.audio:GetVoiceLength("story_v_out_425121", "425121081", "story_v_out_425121.awb") / 1000

					if var_339_23 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_23 + var_339_15
					end

					if var_339_18.prefab_name ~= "" and arg_336_1.actors_[var_339_18.prefab_name] ~= nil then
						local var_339_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_18.prefab_name].transform, "story_v_out_425121", "425121081", "story_v_out_425121.awb")

						arg_336_1:RecordAudio("425121081", var_339_24)
						arg_336_1:RecordAudio("425121081", var_339_24)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_425121", "425121081", "story_v_out_425121.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_425121", "425121081", "story_v_out_425121.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_25 = math.max(var_339_16, arg_336_1.talkMaxDuration)

			if var_339_15 <= arg_336_1.time_ and arg_336_1.time_ < var_339_15 + var_339_25 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_15) / var_339_25

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_15 + var_339_25 and arg_336_1.time_ < var_339_15 + var_339_25 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play425121082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 425121082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play425121083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1137"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1137 == nil then
				arg_340_1.var_.actorSpriteComps1137 = var_343_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_2 = 0.2

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.actorSpriteComps1137 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								local var_343_4 = Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor2.r, var_343_3)
								local var_343_5 = Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor2.g, var_343_3)
								local var_343_6 = Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor2.b, var_343_3)

								iter_343_1.color = Color.New(var_343_4, var_343_5, var_343_6)
							else
								local var_343_7 = Mathf.Lerp(iter_343_1.color.r, 0.5, var_343_3)

								iter_343_1.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1137 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_343_3 then
						if arg_340_1.isInRecall_ then
							iter_343_3.color = arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_343_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps1137 = nil
			end

			local var_343_8 = arg_340_1.actors_["1137"].transform
			local var_343_9 = 0

			if var_343_9 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 then
				arg_340_1.var_.moveOldPos1137 = var_343_8.localPosition
				var_343_8.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1137", 7)

				local var_343_10 = var_343_8.childCount

				for iter_343_4 = 0, var_343_10 - 1 do
					local var_343_11 = var_343_8:GetChild(iter_343_4)

					if var_343_11.name == "" or not string.find(var_343_11.name, "split") then
						var_343_11.gameObject:SetActive(true)
					else
						var_343_11.gameObject:SetActive(false)
					end
				end
			end

			local var_343_12 = 0.001

			if var_343_9 <= arg_340_1.time_ and arg_340_1.time_ < var_343_9 + var_343_12 then
				local var_343_13 = (arg_340_1.time_ - var_343_9) / var_343_12
				local var_343_14 = Vector3.New(0, -2000, 0)

				var_343_8.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1137, var_343_14, var_343_13)
			end

			if arg_340_1.time_ >= var_343_9 + var_343_12 and arg_340_1.time_ < var_343_9 + var_343_12 + arg_343_0 then
				var_343_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_343_15 = 0.133333333333333
			local var_343_16 = 1

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				local var_343_17 = "play"
				local var_343_18 = "effect"

				arg_340_1:AudioAction(var_343_17, var_343_18, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_343_19 = 0
			local var_343_20 = 1.175

			if var_343_19 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_21 = arg_340_1:GetWordFromCfg(425121082)
				local var_343_22 = arg_340_1:FormatText(var_343_21.content)

				arg_340_1.text_.text = var_343_22

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_23 = 47
				local var_343_24 = utf8.len(var_343_22)
				local var_343_25 = var_343_23 <= 0 and var_343_20 or var_343_20 * (var_343_24 / var_343_23)

				if var_343_25 > 0 and var_343_20 < var_343_25 then
					arg_340_1.talkMaxDuration = var_343_25

					if var_343_25 + var_343_19 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_25 + var_343_19
					end
				end

				arg_340_1.text_.text = var_343_22
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_26 = math.max(var_343_20, arg_340_1.talkMaxDuration)

			if var_343_19 <= arg_340_1.time_ and arg_340_1.time_ < var_343_19 + var_343_26 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_19) / var_343_26

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_19 + var_343_26 and arg_340_1.time_ < var_343_19 + var_343_26 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play425121083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 425121083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play425121084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.9

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(425121083)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 36
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play425121084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 425121084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play425121085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.275

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(425121084)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 11
				local var_351_5 = utf8.len(var_351_3)
				local var_351_6 = var_351_4 <= 0 and var_351_1 or var_351_1 * (var_351_5 / var_351_4)

				if var_351_6 > 0 and var_351_1 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_7 and arg_348_1.time_ < var_351_0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play425121085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 425121085
		arg_352_1.duration_ = 5.13

		local var_352_0 = {
			zh = 5.133,
			ja = 5.066
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
			arg_352_1.auto_ = false
		end

		function arg_352_1.playNext_(arg_354_0)
			arg_352_1.onStoryFinished_()
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1137"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1137 == nil then
				arg_352_1.var_.actorSpriteComps1137 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps1137 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 1, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1137 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_355_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps1137 = nil
			end

			local var_355_8 = arg_352_1.actors_["1137"].transform
			local var_355_9 = 0

			if var_355_9 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 then
				arg_352_1.var_.moveOldPos1137 = var_355_8.localPosition
				var_355_8.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1137", 3)

				local var_355_10 = var_355_8.childCount

				for iter_355_4 = 0, var_355_10 - 1 do
					local var_355_11 = var_355_8:GetChild(iter_355_4)

					if var_355_11.name == "split_6" or not string.find(var_355_11.name, "split") then
						var_355_11.gameObject:SetActive(true)
					else
						var_355_11.gameObject:SetActive(false)
					end
				end
			end

			local var_355_12 = 0.001

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_12 then
				local var_355_13 = (arg_352_1.time_ - var_355_9) / var_355_12
				local var_355_14 = Vector3.New(0, -425, -200)

				var_355_8.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1137, var_355_14, var_355_13)
			end

			if arg_352_1.time_ >= var_355_9 + var_355_12 and arg_352_1.time_ < var_355_9 + var_355_12 + arg_355_0 then
				var_355_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_355_15 = 0

			if var_355_15 < arg_352_1.time_ and arg_352_1.time_ <= var_355_15 + arg_355_0 then
				arg_352_1.allBtn_.enabled = false
			end

			local var_355_16 = 0.45

			if arg_352_1.time_ >= var_355_15 + var_355_16 and arg_352_1.time_ < var_355_15 + var_355_16 + arg_355_0 then
				arg_352_1.allBtn_.enabled = true
			end

			local var_355_17 = 0
			local var_355_18 = 0.45

			if var_355_17 < arg_352_1.time_ and arg_352_1.time_ <= var_355_17 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_19 = arg_352_1:FormatText(StoryNameCfg[15].name)

				arg_352_1.leftNameTxt_.text = var_355_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_20 = arg_352_1:GetWordFromCfg(425121085)
				local var_355_21 = arg_352_1:FormatText(var_355_20.content)

				arg_352_1.text_.text = var_355_21

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_22 = 18
				local var_355_23 = utf8.len(var_355_21)
				local var_355_24 = var_355_22 <= 0 and var_355_18 or var_355_18 * (var_355_23 / var_355_22)

				if var_355_24 > 0 and var_355_18 < var_355_24 then
					arg_352_1.talkMaxDuration = var_355_24

					if var_355_24 + var_355_17 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_24 + var_355_17
					end
				end

				arg_352_1.text_.text = var_355_21
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425121", "425121085", "story_v_out_425121.awb") ~= 0 then
					local var_355_25 = manager.audio:GetVoiceLength("story_v_out_425121", "425121085", "story_v_out_425121.awb") / 1000

					if var_355_25 + var_355_17 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_25 + var_355_17
					end

					if var_355_20.prefab_name ~= "" and arg_352_1.actors_[var_355_20.prefab_name] ~= nil then
						local var_355_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_20.prefab_name].transform, "story_v_out_425121", "425121085", "story_v_out_425121.awb")

						arg_352_1:RecordAudio("425121085", var_355_26)
						arg_352_1:RecordAudio("425121085", var_355_26)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_425121", "425121085", "story_v_out_425121.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_425121", "425121085", "story_v_out_425121.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_27 = math.max(var_355_18, arg_352_1.talkMaxDuration)

			if var_355_17 <= arg_352_1.time_ and arg_352_1.time_ < var_355_17 + var_355_27 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_17) / var_355_27

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_17 + var_355_27 and arg_352_1.time_ < var_355_17 + var_355_27 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2403a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/M01i",
		"TextureConfig/Background/M01f"
	},
	voices = {
		"story_v_out_425121.awb"
	}
}
