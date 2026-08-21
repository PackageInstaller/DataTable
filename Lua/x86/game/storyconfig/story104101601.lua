return {
	Play410161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410161001
		arg_1_1.duration_ = 13.63

		local var_1_0 = {
			ja = 13.633,
			CriLanguages = 8.733,
			zh = 8.733
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
				arg_1_0:Play410161002(arg_1_1)
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
			local var_4_23 = 0.166666666666667

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

			local var_4_28 = 0.3
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.875

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[596].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(410161001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 35
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161001", "story_v_out_410161.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_410161", "410161001", "story_v_out_410161.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_410161", "410161001", "story_v_out_410161.awb")

						arg_1_1:RecordAudio("410161001", var_4_48)
						arg_1_1:RecordAudio("410161001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410161", "410161001", "story_v_out_410161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410161", "410161001", "story_v_out_410161.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_38 + 0.3
			local var_4_50 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410161002
		arg_9_1.duration_ = 8.23

		local var_9_0 = {
			ja = 8.233,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_9_0:Play410161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.75

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[600].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(410161002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161002", "story_v_out_410161.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161002", "story_v_out_410161.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_410161", "410161002", "story_v_out_410161.awb")

						arg_9_1:RecordAudio("410161002", var_12_9)
						arg_9_1:RecordAudio("410161002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410161", "410161002", "story_v_out_410161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410161", "410161002", "story_v_out_410161.awb")
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
	Play410161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410161003
		arg_13_1.duration_ = 8.17

		local var_13_0 = {
			ja = 8.166,
			CriLanguages = 5.433,
			zh = 5.433
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
				arg_13_0:Play410161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.35

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[596].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(410161003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161003", "story_v_out_410161.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161003", "story_v_out_410161.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_410161", "410161003", "story_v_out_410161.awb")

						arg_13_1:RecordAudio("410161003", var_16_9)
						arg_13_1:RecordAudio("410161003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410161", "410161003", "story_v_out_410161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410161", "410161003", "story_v_out_410161.awb")
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
	Play410161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410161004
		arg_17_1.duration_ = 2.37

		local var_17_0 = {
			ja = 1.3,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_17_0:Play410161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.075

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_4")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(410161004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161004", "story_v_out_410161.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161004", "story_v_out_410161.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_410161", "410161004", "story_v_out_410161.awb")

						arg_17_1:RecordAudio("410161004", var_20_9)
						arg_17_1:RecordAudio("410161004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410161", "410161004", "story_v_out_410161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410161", "410161004", "story_v_out_410161.awb")
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
	Play410161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410161005
		arg_21_1.duration_ = 7

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play410161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "ST67"

			if arg_21_1.bgs_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_0)
				var_24_1.name = var_24_0
				var_24_1.transform.parent = arg_21_1.stage_.transform
				var_24_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_0] = var_24_1
			end

			local var_24_2 = 0

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				local var_24_3 = manager.ui.mainCamera.transform.localPosition
				local var_24_4 = Vector3.New(0, 0, 10) + Vector3.New(var_24_3.x, var_24_3.y, 0)
				local var_24_5 = arg_21_1.bgs_.ST67

				var_24_5.transform.localPosition = var_24_4
				var_24_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_6 = var_24_5:GetComponent("SpriteRenderer")

				if var_24_6 and var_24_6.sprite then
					local var_24_7 = (var_24_5.transform.localPosition - var_24_3).z
					local var_24_8 = manager.ui.mainCameraCom_
					local var_24_9 = 2 * var_24_7 * Mathf.Tan(var_24_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_10 = var_24_9 * var_24_8.aspect
					local var_24_11 = var_24_6.sprite.bounds.size.x
					local var_24_12 = var_24_6.sprite.bounds.size.y
					local var_24_13 = var_24_10 / var_24_11
					local var_24_14 = var_24_9 / var_24_12
					local var_24_15 = var_24_14 < var_24_13 and var_24_13 or var_24_14

					var_24_5.transform.localScale = Vector3.New(var_24_15, var_24_15, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "ST67" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_17 = 2

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Color.New(0, 0, 0)

				var_24_19.a = Mathf.Lerp(1, 0, var_24_18)
				arg_21_1.mask_.color = var_24_19
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				local var_24_20 = Color.New(0, 0, 0)
				local var_24_21 = 0

				arg_21_1.mask_.enabled = false
				var_24_20.a = var_24_21
				arg_21_1.mask_.color = var_24_20
			end

			local var_24_22 = "ST67_blur"

			if arg_21_1.bgs_[var_24_22] == nil then
				local var_24_23 = Object.Instantiate(arg_21_1.blurPaintGo_)
				local var_24_24 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_22)

				var_24_23:GetComponent("SpriteRenderer").sprite = var_24_24
				var_24_23.name = var_24_22
				var_24_23.transform.parent = arg_21_1.stage_.transform
				var_24_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_22] = var_24_23
			end

			local var_24_25 = 0
			local var_24_26 = arg_21_1.bgs_[var_24_22]

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 then
				local var_24_27 = manager.ui.mainCamera.transform.localPosition
				local var_24_28 = Vector3.New(0, 0, 10) + Vector3.New(var_24_27.x, var_24_27.y, 0)

				var_24_26.transform.localPosition = var_24_28
				var_24_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_29 = var_24_26:GetComponent("SpriteRenderer")

				if var_24_29 and var_24_29.sprite then
					local var_24_30 = (var_24_26.transform.localPosition - var_24_27).z
					local var_24_31 = manager.ui.mainCameraCom_
					local var_24_32 = 2 * var_24_30 * Mathf.Tan(var_24_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_33 = var_24_32 * var_24_31.aspect
					local var_24_34 = var_24_29.sprite.bounds.size.x
					local var_24_35 = var_24_29.sprite.bounds.size.y
					local var_24_36 = var_24_33 / var_24_34
					local var_24_37 = var_24_32 / var_24_35
					local var_24_38 = var_24_37 < var_24_36 and var_24_36 or var_24_37

					var_24_26.transform.localScale = Vector3.New(var_24_38, var_24_38, 0)
				end
			end

			local var_24_39 = 0.2

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_39 then
				local var_24_40 = (arg_21_1.time_ - var_24_25) / var_24_39
				local var_24_41 = Color.New(1, 1, 1)

				var_24_41.a = Mathf.Lerp(0, 1, var_24_40)

				var_24_26:GetComponent("SpriteRenderer").material:SetColor("_Color", var_24_41)
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_42 = 2
			local var_24_43 = 0.975

			if var_24_42 < arg_21_1.time_ and arg_21_1.time_ <= var_24_42 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_44 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_44:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_45 = arg_21_1:GetWordFromCfg(410161005)
				local var_24_46 = arg_21_1:FormatText(var_24_45.content)

				arg_21_1.text_.text = var_24_46

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_47 = 39
				local var_24_48 = utf8.len(var_24_46)
				local var_24_49 = var_24_47 <= 0 and var_24_43 or var_24_43 * (var_24_48 / var_24_47)

				if var_24_49 > 0 and var_24_43 < var_24_49 then
					arg_21_1.talkMaxDuration = var_24_49
					var_24_42 = var_24_42 + 0.3

					if var_24_49 + var_24_42 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_49 + var_24_42
					end
				end

				arg_21_1.text_.text = var_24_46
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_50 = var_24_42 + 0.3
			local var_24_51 = math.max(var_24_43, arg_21_1.talkMaxDuration)

			if var_24_50 <= arg_21_1.time_ and arg_21_1.time_ < var_24_50 + var_24_51 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_50) / var_24_51

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_50 + var_24_51 and arg_21_1.time_ < var_24_50 + var_24_51 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410161006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 410161006
		arg_27_1.duration_ = 12.27

		local var_27_0 = {
			ja = 12.266,
			CriLanguages = 8.9,
			zh = 8.9
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play410161007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 1

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[596].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10059_split_2")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(410161006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 40
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161006", "story_v_out_410161.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161006", "story_v_out_410161.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_410161", "410161006", "story_v_out_410161.awb")

						arg_27_1:RecordAudio("410161006", var_30_9)
						arg_27_1:RecordAudio("410161006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_410161", "410161006", "story_v_out_410161.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_410161", "410161006", "story_v_out_410161.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play410161007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 410161007
		arg_31_1.duration_ = 9.63

		local var_31_0 = {
			ja = 9.633,
			CriLanguages = 9.366,
			zh = 9.366
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
				arg_31_0:Play410161008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.875

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[600].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:GetWordFromCfg(410161007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 35
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161007", "story_v_out_410161.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161007", "story_v_out_410161.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_410161", "410161007", "story_v_out_410161.awb")

						arg_31_1:RecordAudio("410161007", var_34_9)
						arg_31_1:RecordAudio("410161007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_410161", "410161007", "story_v_out_410161.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_410161", "410161007", "story_v_out_410161.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play410161008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 410161008
		arg_35_1.duration_ = 9

		local var_35_0 = {
			ja = 9,
			CriLanguages = 7.533,
			zh = 7.533
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play410161009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.725

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[600].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062_split_1")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(410161008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 29
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161008", "story_v_out_410161.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_410161", "410161008", "story_v_out_410161.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_410161", "410161008", "story_v_out_410161.awb")

						arg_35_1:RecordAudio("410161008", var_38_9)
						arg_35_1:RecordAudio("410161008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_410161", "410161008", "story_v_out_410161.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_410161", "410161008", "story_v_out_410161.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play410161009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 410161009
		arg_39_1.duration_ = 6.2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play410161010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				local var_42_2 = "stop"
				local var_42_3 = "effect"

				arg_39_1:AudioAction(var_42_2, var_42_3, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_42_4 = "10059"

			if arg_39_1.actors_[var_42_4] == nil then
				local var_42_5 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_42_5) then
					local var_42_6 = Object.Instantiate(var_42_5, arg_39_1.canvasGo_.transform)

					var_42_6.transform:SetSiblingIndex(1)

					var_42_6.name = var_42_4
					var_42_6.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_4] = var_42_6

					local var_42_7 = var_42_6:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs(var_42_7) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_8 = arg_39_1.actors_["10059"]
			local var_42_9 = 0

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.actorSpriteComps10059 == nil then
				arg_39_1.var_.actorSpriteComps10059 = var_42_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_10 = 0.034

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 and not isNil(var_42_8) then
				local var_42_11 = (arg_39_1.time_ - var_42_9) / var_42_10

				if arg_39_1.var_.actorSpriteComps10059 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								local var_42_12 = Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, var_42_11)
								local var_42_13 = Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, var_42_11)
								local var_42_14 = Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, var_42_11)

								iter_42_3.color = Color.New(var_42_12, var_42_13, var_42_14)
							else
								local var_42_15 = Mathf.Lerp(iter_42_3.color.r, 0.5, var_42_11)

								iter_42_3.color = Color.New(var_42_15, var_42_15, var_42_15)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.actorSpriteComps10059 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_42_5 then
						if arg_39_1.isInRecall_ then
							iter_42_5.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10059 = nil
			end

			local var_42_16 = "10062"

			if arg_39_1.actors_[var_42_16] == nil then
				local var_42_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_42_17) then
					local var_42_18 = Object.Instantiate(var_42_17, arg_39_1.canvasGo_.transform)

					var_42_18.transform:SetSiblingIndex(1)

					var_42_18.name = var_42_16
					var_42_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_16] = var_42_18

					local var_42_19 = var_42_18:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_39_1.isInRecall_ then
						for iter_42_6, iter_42_7 in ipairs(var_42_19) do
							iter_42_7.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_20 = arg_39_1.actors_["10062"]
			local var_42_21 = 0

			if var_42_21 < arg_39_1.time_ and arg_39_1.time_ <= var_42_21 + arg_42_0 and not isNil(var_42_20) and arg_39_1.var_.actorSpriteComps10062 == nil then
				arg_39_1.var_.actorSpriteComps10062 = var_42_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_22 = 0.034

			if var_42_21 <= arg_39_1.time_ and arg_39_1.time_ < var_42_21 + var_42_22 and not isNil(var_42_20) then
				local var_42_23 = (arg_39_1.time_ - var_42_21) / var_42_22

				if arg_39_1.var_.actorSpriteComps10062 then
					for iter_42_8, iter_42_9 in pairs(arg_39_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_42_9 then
							if arg_39_1.isInRecall_ then
								local var_42_24 = Mathf.Lerp(iter_42_9.color.r, arg_39_1.hightColor2.r, var_42_23)
								local var_42_25 = Mathf.Lerp(iter_42_9.color.g, arg_39_1.hightColor2.g, var_42_23)
								local var_42_26 = Mathf.Lerp(iter_42_9.color.b, arg_39_1.hightColor2.b, var_42_23)

								iter_42_9.color = Color.New(var_42_24, var_42_25, var_42_26)
							else
								local var_42_27 = Mathf.Lerp(iter_42_9.color.r, 0.5, var_42_23)

								iter_42_9.color = Color.New(var_42_27, var_42_27, var_42_27)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_21 + var_42_22 and arg_39_1.time_ < var_42_21 + var_42_22 + arg_42_0 and not isNil(var_42_20) and arg_39_1.var_.actorSpriteComps10062 then
				for iter_42_10, iter_42_11 in pairs(arg_39_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_42_11 then
						if arg_39_1.isInRecall_ then
							iter_42_11.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10062 = nil
			end

			local var_42_28 = 0

			if var_42_28 < arg_39_1.time_ and arg_39_1.time_ <= var_42_28 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_29 = 1

			if var_42_28 <= arg_39_1.time_ and arg_39_1.time_ < var_42_28 + var_42_29 then
				local var_42_30 = (arg_39_1.time_ - var_42_28) / var_42_29
				local var_42_31 = Color.New(0, 0, 0)

				var_42_31.a = Mathf.Lerp(0, 1, var_42_30)
				arg_39_1.mask_.color = var_42_31
			end

			if arg_39_1.time_ >= var_42_28 + var_42_29 and arg_39_1.time_ < var_42_28 + var_42_29 + arg_42_0 then
				local var_42_32 = Color.New(0, 0, 0)

				var_42_32.a = 1
				arg_39_1.mask_.color = var_42_32
			end

			local var_42_33 = 1

			if var_42_33 < arg_39_1.time_ and arg_39_1.time_ <= var_42_33 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_34 = 1.5

			if var_42_33 <= arg_39_1.time_ and arg_39_1.time_ < var_42_33 + var_42_34 then
				local var_42_35 = (arg_39_1.time_ - var_42_33) / var_42_34
				local var_42_36 = Color.New(0, 0, 0)

				var_42_36.a = Mathf.Lerp(1, 0, var_42_35)
				arg_39_1.mask_.color = var_42_36
			end

			if arg_39_1.time_ >= var_42_33 + var_42_34 and arg_39_1.time_ < var_42_33 + var_42_34 + arg_42_0 then
				local var_42_37 = Color.New(0, 0, 0)
				local var_42_38 = 0

				arg_39_1.mask_.enabled = false
				var_42_37.a = var_42_38
				arg_39_1.mask_.color = var_42_37
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_39 = 1.2
			local var_42_40 = 0.95

			if var_42_39 < arg_39_1.time_ and arg_39_1.time_ <= var_42_39 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_41 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_41:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_42 = arg_39_1:GetWordFromCfg(410161009)
				local var_42_43 = arg_39_1:FormatText(var_42_42.content)

				arg_39_1.text_.text = var_42_43

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_44 = 38
				local var_42_45 = utf8.len(var_42_43)
				local var_42_46 = var_42_44 <= 0 and var_42_40 or var_42_40 * (var_42_45 / var_42_44)

				if var_42_46 > 0 and var_42_40 < var_42_46 then
					arg_39_1.talkMaxDuration = var_42_46
					var_42_39 = var_42_39 + 0.3

					if var_42_46 + var_42_39 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_46 + var_42_39
					end
				end

				arg_39_1.text_.text = var_42_43
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_47 = var_42_39 + 0.3
			local var_42_48 = math.max(var_42_40, arg_39_1.talkMaxDuration)

			if var_42_47 <= arg_39_1.time_ and arg_39_1.time_ < var_42_47 + var_42_48 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_47) / var_42_48

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_47 + var_42_48 and arg_39_1.time_ < var_42_47 + var_42_48 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play410161010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410161010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410161011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "ST67_blur"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.blurPaintGo_)
				local var_48_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)

				var_48_1:GetComponent("SpriteRenderer").sprite = var_48_2
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_3 = 0
			local var_48_4 = arg_45_1.bgs_[var_48_0]

			if var_48_3 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				local var_48_5 = manager.ui.mainCamera.transform.localPosition
				local var_48_6 = Vector3.New(0, 0, 10) + Vector3.New(var_48_5.x, var_48_5.y, 0)

				var_48_4.transform.localPosition = var_48_6
				var_48_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_7 = var_48_4:GetComponent("SpriteRenderer")

				if var_48_7 and var_48_7.sprite then
					local var_48_8 = (var_48_4.transform.localPosition - var_48_5).z
					local var_48_9 = manager.ui.mainCameraCom_
					local var_48_10 = 2 * var_48_8 * Mathf.Tan(var_48_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_11 = var_48_10 * var_48_9.aspect
					local var_48_12 = var_48_7.sprite.bounds.size.x
					local var_48_13 = var_48_7.sprite.bounds.size.y
					local var_48_14 = var_48_11 / var_48_12
					local var_48_15 = var_48_10 / var_48_13
					local var_48_16 = var_48_15 < var_48_14 and var_48_14 or var_48_15

					var_48_4.transform.localScale = Vector3.New(var_48_16, var_48_16, 0)
				end
			end

			local var_48_17 = 1

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_17 then
				local var_48_18 = (arg_45_1.time_ - var_48_3) / var_48_17
				local var_48_19 = Color.New(1, 1, 1)

				var_48_19.a = Mathf.Lerp(1, 0, var_48_18)

				var_48_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_48_19)
			end

			local var_48_20 = 0
			local var_48_21 = 1.775

			if var_48_20 < arg_45_1.time_ and arg_45_1.time_ <= var_48_20 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_22 = arg_45_1:GetWordFromCfg(410161010)
				local var_48_23 = arg_45_1:FormatText(var_48_22.content)

				arg_45_1.text_.text = var_48_23

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_24 = 71
				local var_48_25 = utf8.len(var_48_23)
				local var_48_26 = var_48_24 <= 0 and var_48_21 or var_48_21 * (var_48_25 / var_48_24)

				if var_48_26 > 0 and var_48_21 < var_48_26 then
					arg_45_1.talkMaxDuration = var_48_26

					if var_48_26 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_26 + var_48_20
					end
				end

				arg_45_1.text_.text = var_48_23
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_27 = math.max(var_48_21, arg_45_1.talkMaxDuration)

			if var_48_20 <= arg_45_1.time_ and arg_45_1.time_ < var_48_20 + var_48_27 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_20) / var_48_27

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_20 + var_48_27 and arg_45_1.time_ < var_48_20 + var_48_27 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410161011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410161011
		arg_49_1.duration_ = 4.6

		local var_49_0 = {
			ja = 4.6,
			CriLanguages = 2.133,
			zh = 2.133
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
				arg_49_0:Play410161012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10062"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 4)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_2" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(370, -390, -290)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_52_7 = arg_49_1.actors_["10062"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 0.633333333333333

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				local var_52_17 = "stop"
				local var_52_18 = "effect"

				arg_49_1:AudioAction(var_52_17, var_52_18, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_52_19 = 0
			local var_52_20 = 0.125

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_21 = arg_49_1:FormatText(StoryNameCfg[600].name)

				arg_49_1.leftNameTxt_.text = var_52_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_22 = arg_49_1:GetWordFromCfg(410161011)
				local var_52_23 = arg_49_1:FormatText(var_52_22.content)

				arg_49_1.text_.text = var_52_23

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_24 = 5
				local var_52_25 = utf8.len(var_52_23)
				local var_52_26 = var_52_24 <= 0 and var_52_20 or var_52_20 * (var_52_25 / var_52_24)

				if var_52_26 > 0 and var_52_20 < var_52_26 then
					arg_49_1.talkMaxDuration = var_52_26

					if var_52_26 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_26 + var_52_19
					end
				end

				arg_49_1.text_.text = var_52_23
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161011", "story_v_out_410161.awb") ~= 0 then
					local var_52_27 = manager.audio:GetVoiceLength("story_v_out_410161", "410161011", "story_v_out_410161.awb") / 1000

					if var_52_27 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_19
					end

					if var_52_22.prefab_name ~= "" and arg_49_1.actors_[var_52_22.prefab_name] ~= nil then
						local var_52_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_22.prefab_name].transform, "story_v_out_410161", "410161011", "story_v_out_410161.awb")

						arg_49_1:RecordAudio("410161011", var_52_28)
						arg_49_1:RecordAudio("410161011", var_52_28)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410161", "410161011", "story_v_out_410161.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410161", "410161011", "story_v_out_410161.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_29 = math.max(var_52_20, arg_49_1.talkMaxDuration)

			if var_52_19 <= arg_49_1.time_ and arg_49_1.time_ < var_52_19 + var_52_29 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_19) / var_52_29

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_19 + var_52_29 and arg_49_1.time_ < var_52_19 + var_52_29 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410161012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410161012
		arg_53_1.duration_ = 2.67

		local var_53_0 = {
			ja = 1.2,
			CriLanguages = 2.666,
			zh = 2.666
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
				arg_53_0:Play410161013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "1061"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(var_56_1, arg_53_1.canvasGo_.transform)

					var_56_2.transform:SetSiblingIndex(1)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_53_1.isInRecall_ then
						for iter_56_0, iter_56_1 in ipairs(var_56_3) do
							iter_56_1.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_56_4 = arg_53_1.actors_["1061"].transform
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = var_56_4.localPosition
				var_56_4.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 2)

				local var_56_6 = var_56_4.childCount

				for iter_56_2 = 0, var_56_6 - 1 do
					local var_56_7 = var_56_4:GetChild(iter_56_2)

					if var_56_7.name == "split_5" or not string.find(var_56_7.name, "split") then
						var_56_7.gameObject:SetActive(true)
					else
						var_56_7.gameObject:SetActive(false)
					end
				end
			end

			local var_56_8 = 0.001

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_5) / var_56_8
				local var_56_10 = Vector3.New(-390, -490, 18)

				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, var_56_10, var_56_9)
			end

			if arg_53_1.time_ >= var_56_5 + var_56_8 and arg_53_1.time_ < var_56_5 + var_56_8 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_56_11 = arg_53_1.actors_["1061"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_13 = 0.034

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_4 then
							if arg_53_1.isInRecall_ then
								local var_56_15 = Mathf.Lerp(iter_56_4.color.r, arg_53_1.hightColor1.r, var_56_14)
								local var_56_16 = Mathf.Lerp(iter_56_4.color.g, arg_53_1.hightColor1.g, var_56_14)
								local var_56_17 = Mathf.Lerp(iter_56_4.color.b, arg_53_1.hightColor1.b, var_56_14)

								iter_56_4.color = Color.New(var_56_15, var_56_16, var_56_17)
							else
								local var_56_18 = Mathf.Lerp(iter_56_4.color.r, 1, var_56_14)

								iter_56_4.color = Color.New(var_56_18, var_56_18, var_56_18)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_6 then
						if arg_53_1.isInRecall_ then
							iter_56_6.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_19 = arg_53_1.actors_["10062"]
			local var_56_20 = 0

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.actorSpriteComps10062 == nil then
				arg_53_1.var_.actorSpriteComps10062 = var_56_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_21 = 0.034

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_21 and not isNil(var_56_19) then
				local var_56_22 = (arg_53_1.time_ - var_56_20) / var_56_21

				if arg_53_1.var_.actorSpriteComps10062 then
					for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_56_8 then
							if arg_53_1.isInRecall_ then
								local var_56_23 = Mathf.Lerp(iter_56_8.color.r, arg_53_1.hightColor2.r, var_56_22)
								local var_56_24 = Mathf.Lerp(iter_56_8.color.g, arg_53_1.hightColor2.g, var_56_22)
								local var_56_25 = Mathf.Lerp(iter_56_8.color.b, arg_53_1.hightColor2.b, var_56_22)

								iter_56_8.color = Color.New(var_56_23, var_56_24, var_56_25)
							else
								local var_56_26 = Mathf.Lerp(iter_56_8.color.r, 0.5, var_56_22)

								iter_56_8.color = Color.New(var_56_26, var_56_26, var_56_26)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_20 + var_56_21 and arg_53_1.time_ < var_56_20 + var_56_21 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.actorSpriteComps10062 then
				for iter_56_9, iter_56_10 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_56_10 then
						if arg_53_1.isInRecall_ then
							iter_56_10.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10062 = nil
			end

			local var_56_27 = 0
			local var_56_28 = 0.1

			if var_56_27 < arg_53_1.time_ and arg_53_1.time_ <= var_56_27 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_29 = arg_53_1:FormatText(StoryNameCfg[612].name)

				arg_53_1.leftNameTxt_.text = var_56_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_30 = arg_53_1:GetWordFromCfg(410161012)
				local var_56_31 = arg_53_1:FormatText(var_56_30.content)

				arg_53_1.text_.text = var_56_31

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_32 = 4
				local var_56_33 = utf8.len(var_56_31)
				local var_56_34 = var_56_32 <= 0 and var_56_28 or var_56_28 * (var_56_33 / var_56_32)

				if var_56_34 > 0 and var_56_28 < var_56_34 then
					arg_53_1.talkMaxDuration = var_56_34

					if var_56_34 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_34 + var_56_27
					end
				end

				arg_53_1.text_.text = var_56_31
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161012", "story_v_out_410161.awb") ~= 0 then
					local var_56_35 = manager.audio:GetVoiceLength("story_v_out_410161", "410161012", "story_v_out_410161.awb") / 1000

					if var_56_35 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_35 + var_56_27
					end

					if var_56_30.prefab_name ~= "" and arg_53_1.actors_[var_56_30.prefab_name] ~= nil then
						local var_56_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_30.prefab_name].transform, "story_v_out_410161", "410161012", "story_v_out_410161.awb")

						arg_53_1:RecordAudio("410161012", var_56_36)
						arg_53_1:RecordAudio("410161012", var_56_36)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410161", "410161012", "story_v_out_410161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410161", "410161012", "story_v_out_410161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_37 = math.max(var_56_28, arg_53_1.talkMaxDuration)

			if var_56_27 <= arg_53_1.time_ and arg_53_1.time_ < var_56_27 + var_56_37 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_27) / var_56_37

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_27 + var_56_37 and arg_53_1.time_ < var_56_27 + var_56_37 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play410161013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410161013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410161014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1061"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 1.35

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(410161013)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 54
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_9 or var_60_9 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_9 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_15 and arg_57_1.time_ < var_60_8 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410161014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410161014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410161015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.075

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

				local var_64_2 = arg_61_1:GetWordFromCfg(410161014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 43
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
	Play410161015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410161015
		arg_65_1.duration_ = 17.9

		local var_65_0 = {
			ja = 17.9,
			CriLanguages = 7.4,
			zh = 7.4
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
				arg_65_0:Play410161016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10062"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10062 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10062", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(370, -390, -290)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10062, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_68_7 = arg_65_1.actors_["10062"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10062 == nil then
				arg_65_1.var_.actorSpriteComps10062 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10062 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10062 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10062 = nil
			end

			local var_68_15 = 0
			local var_68_16 = 0.775

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[600].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(410161015)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 31
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161015", "story_v_out_410161.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161015", "story_v_out_410161.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_410161", "410161015", "story_v_out_410161.awb")

						arg_65_1:RecordAudio("410161015", var_68_24)
						arg_65_1:RecordAudio("410161015", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410161", "410161015", "story_v_out_410161.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410161", "410161015", "story_v_out_410161.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410161016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410161016
		arg_69_1.duration_ = 15.67

		local var_69_0 = {
			ja = 15.666,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_69_0:Play410161017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10062"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10062 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10062", 4)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(370, -390, -290)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10062, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_72_7 = arg_69_1.actors_["10062"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10062 == nil then
				arg_69_1.var_.actorSpriteComps10062 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps10062 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10062 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10062 = nil
			end

			local var_72_15 = 0
			local var_72_16 = 1

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[600].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(410161016)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 40
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161016", "story_v_out_410161.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161016", "story_v_out_410161.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_410161", "410161016", "story_v_out_410161.awb")

						arg_69_1:RecordAudio("410161016", var_72_24)
						arg_69_1:RecordAudio("410161016", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410161", "410161016", "story_v_out_410161.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410161", "410161016", "story_v_out_410161.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play410161017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410161017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410161018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10062"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10062 == nil then
				arg_73_1.var_.actorSpriteComps10062 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.034

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10062 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10062 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10062 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.95

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(410161017)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 38
				local var_76_13 = utf8.len(var_76_11)
				local var_76_14 = var_76_12 <= 0 and var_76_9 or var_76_9 * (var_76_13 / var_76_12)

				if var_76_14 > 0 and var_76_9 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_15 and arg_73_1.time_ < var_76_8 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410161018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410161018
		arg_77_1.duration_ = 11.23

		local var_77_0 = {
			ja = 11.233,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_77_0:Play410161019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1061"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 2)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_5" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(-390, -490, 18)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_80_7 = arg_77_1.actors_["1061"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_15 = 0
			local var_80_16 = 0.9

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[612].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(410161018)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 36
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161018", "story_v_out_410161.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161018", "story_v_out_410161.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_410161", "410161018", "story_v_out_410161.awb")

						arg_77_1:RecordAudio("410161018", var_80_24)
						arg_77_1:RecordAudio("410161018", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410161", "410161018", "story_v_out_410161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410161", "410161018", "story_v_out_410161.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410161019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410161019
		arg_81_1.duration_ = 22.23

		local var_81_0 = {
			ja = 22.233,
			CriLanguages = 8.3,
			zh = 8.3
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
				arg_81_0:Play410161020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10062"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10062 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10062", 4)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "split_2" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(370, -390, -290)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10062, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_84_7 = arg_81_1.actors_["10062"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10062 == nil then
				arg_81_1.var_.actorSpriteComps10062 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.034

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps10062 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 1, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10062 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10062 = nil
			end

			local var_84_15 = arg_81_1.actors_["1061"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps1061 == nil then
				arg_81_1.var_.actorSpriteComps1061 = var_84_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_17 = 0.034

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.actorSpriteComps1061 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								local var_84_19 = Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, var_84_18)
								local var_84_20 = Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, var_84_18)
								local var_84_21 = Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, var_84_18)

								iter_84_6.color = Color.New(var_84_19, var_84_20, var_84_21)
							else
								local var_84_22 = Mathf.Lerp(iter_84_6.color.r, 0.5, var_84_18)

								iter_84_6.color = Color.New(var_84_22, var_84_22, var_84_22)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps1061 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_84_8 then
						if arg_81_1.isInRecall_ then
							iter_84_8.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1061 = nil
			end

			local var_84_23 = 0
			local var_84_24 = 0.7

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[600].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(410161019)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 28
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161019", "story_v_out_410161.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161019", "story_v_out_410161.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_410161", "410161019", "story_v_out_410161.awb")

						arg_81_1:RecordAudio("410161019", var_84_32)
						arg_81_1:RecordAudio("410161019", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410161", "410161019", "story_v_out_410161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410161", "410161019", "story_v_out_410161.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_33 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_33

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_33 and arg_81_1.time_ < var_84_23 + var_84_33 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play410161020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410161020
		arg_85_1.duration_ = 13.2

		local var_85_0 = {
			ja = 13.2,
			CriLanguages = 7.1,
			zh = 7.1
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
				arg_85_0:Play410161021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1061"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1061", 2)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_5" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(-390, -490, 18)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_88_7 = arg_85_1.actors_["1061"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1061 == nil then
				arg_85_1.var_.actorSpriteComps1061 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps1061 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1061 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1061 = nil
			end

			local var_88_15 = arg_85_1.actors_["10062"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10062 == nil then
				arg_85_1.var_.actorSpriteComps10062 = var_88_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_17 = 0.034

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.actorSpriteComps10062 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								local var_88_19 = Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, var_88_18)
								local var_88_20 = Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, var_88_18)
								local var_88_21 = Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, var_88_18)

								iter_88_6.color = Color.New(var_88_19, var_88_20, var_88_21)
							else
								local var_88_22 = Mathf.Lerp(iter_88_6.color.r, 0.5, var_88_18)

								iter_88_6.color = Color.New(var_88_22, var_88_22, var_88_22)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10062 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_88_8 then
						if arg_85_1.isInRecall_ then
							iter_88_8.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10062 = nil
			end

			local var_88_23 = 0
			local var_88_24 = 0.75

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[612].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(410161020)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 30
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161020", "story_v_out_410161.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161020", "story_v_out_410161.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_410161", "410161020", "story_v_out_410161.awb")

						arg_85_1:RecordAudio("410161020", var_88_32)
						arg_85_1:RecordAudio("410161020", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410161", "410161020", "story_v_out_410161.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410161", "410161020", "story_v_out_410161.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play410161021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410161021
		arg_89_1.duration_ = 3.07

		local var_89_0 = {
			ja = 3.066,
			CriLanguages = 1.933,
			zh = 1.933
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
				arg_89_0:Play410161022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10062"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10062 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10062", 4)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_4" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(370, -390, -290)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10062, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_92_7 = arg_89_1.actors_["10062"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10062 == nil then
				arg_89_1.var_.actorSpriteComps10062 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.034

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps10062 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 1, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10062 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10062 = nil
			end

			local var_92_15 = arg_89_1.actors_["1061"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1061 == nil then
				arg_89_1.var_.actorSpriteComps1061 = var_92_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_17 = 0.034

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.actorSpriteComps1061 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								local var_92_19 = Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, var_92_18)
								local var_92_20 = Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, var_92_18)
								local var_92_21 = Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, var_92_18)

								iter_92_6.color = Color.New(var_92_19, var_92_20, var_92_21)
							else
								local var_92_22 = Mathf.Lerp(iter_92_6.color.r, 0.5, var_92_18)

								iter_92_6.color = Color.New(var_92_22, var_92_22, var_92_22)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1061 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_92_8 then
						if arg_89_1.isInRecall_ then
							iter_92_8.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1061 = nil
			end

			local var_92_23 = 0
			local var_92_24 = 0.125

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[600].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(410161021)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 5
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161021", "story_v_out_410161.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161021", "story_v_out_410161.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_410161", "410161021", "story_v_out_410161.awb")

						arg_89_1:RecordAudio("410161021", var_92_32)
						arg_89_1:RecordAudio("410161021", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410161", "410161021", "story_v_out_410161.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410161", "410161021", "story_v_out_410161.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play410161022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410161022
		arg_93_1.duration_ = 6.1

		local var_93_0 = {
			ja = 6.1,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_93_0:Play410161023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10062"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10062 == nil then
				arg_93_1.var_.actorSpriteComps10062 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10062 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10062 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10062 = nil
			end

			local var_96_8 = arg_93_1.actors_["1061"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.034

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 1, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_16 = 0
			local var_96_17 = 0.425

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_18 = arg_93_1:FormatText(StoryNameCfg[612].name)

				arg_93_1.leftNameTxt_.text = var_96_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:GetWordFromCfg(410161022)
				local var_96_20 = arg_93_1:FormatText(var_96_19.content)

				arg_93_1.text_.text = var_96_20

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 17
				local var_96_22 = utf8.len(var_96_20)
				local var_96_23 = var_96_21 <= 0 and var_96_17 or var_96_17 * (var_96_22 / var_96_21)

				if var_96_23 > 0 and var_96_17 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23

					if var_96_23 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_20
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161022", "story_v_out_410161.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_410161", "410161022", "story_v_out_410161.awb") / 1000

					if var_96_24 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_16
					end

					if var_96_19.prefab_name ~= "" and arg_93_1.actors_[var_96_19.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_19.prefab_name].transform, "story_v_out_410161", "410161022", "story_v_out_410161.awb")

						arg_93_1:RecordAudio("410161022", var_96_25)
						arg_93_1:RecordAudio("410161022", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410161", "410161022", "story_v_out_410161.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410161", "410161022", "story_v_out_410161.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_26 and arg_93_1.time_ < var_96_16 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410161023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410161023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410161024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1061"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.034

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_8 = arg_97_1.actors_["10062"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10062 == nil then
				arg_97_1.var_.actorSpriteComps10062 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.034

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10062 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 0.5, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10062 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10062 = nil
			end

			local var_100_16 = 0
			local var_100_17 = 1.6

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(410161023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 64
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_17 or var_100_17 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_17 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_16
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_23 = math.max(var_100_17, arg_97_1.talkMaxDuration)

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_23 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_16) / var_100_23

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_16 + var_100_23 and arg_97_1.time_ < var_100_16 + var_100_23 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play410161024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410161024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410161025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.475

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

				local var_104_2 = arg_101_1:GetWordFromCfg(410161024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 59
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
	Play410161025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410161025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play410161026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.625

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(410161025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 65
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410161026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410161026
		arg_109_1.duration_ = 1.37

		local var_109_0 = {
			ja = 1.3,
			CriLanguages = 1.366,
			zh = 1.366
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
				arg_109_0:Play410161027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1061"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1061", 2)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_9" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(-390, -490, 18)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_112_7 = arg_109_1.actors_["1061"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 0.1

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[612].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(410161026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 4
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161026", "story_v_out_410161.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161026", "story_v_out_410161.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_410161", "410161026", "story_v_out_410161.awb")

						arg_109_1:RecordAudio("410161026", var_112_24)
						arg_109_1:RecordAudio("410161026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410161", "410161026", "story_v_out_410161.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410161", "410161026", "story_v_out_410161.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play410161027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410161027
		arg_113_1.duration_ = 11.1

		local var_113_0 = {
			ja = 11.1,
			CriLanguages = 7,
			zh = 7
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
				arg_113_0:Play410161028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10062"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10062 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10062", 4)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_4" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(370, -390, -290)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10062, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_116_7 = arg_113_1.actors_["10062"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10062 == nil then
				arg_113_1.var_.actorSpriteComps10062 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps10062 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10062 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10062 = nil
			end

			local var_116_15 = arg_113_1.actors_["1061"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1061 == nil then
				arg_113_1.var_.actorSpriteComps1061 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps1061 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 0.5, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1061 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1061 = nil
			end

			local var_116_23 = 0
			local var_116_24 = 0.625

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[600].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(410161027)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 25
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161027", "story_v_out_410161.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161027", "story_v_out_410161.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_410161", "410161027", "story_v_out_410161.awb")

						arg_113_1:RecordAudio("410161027", var_116_32)
						arg_113_1:RecordAudio("410161027", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410161", "410161027", "story_v_out_410161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410161", "410161027", "story_v_out_410161.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410161028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410161028
		arg_117_1.duration_ = 13.43

		local var_117_0 = {
			ja = 13.433,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_117_0:Play410161029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1061"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1061 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1061", 2)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_5" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(-390, -490, 18)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1061, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_120_7 = arg_117_1.actors_["1061"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 0.034

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_15 = arg_117_1.actors_["10062"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10062 == nil then
				arg_117_1.var_.actorSpriteComps10062 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_17 = 0.034

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.actorSpriteComps10062 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								local var_120_19 = Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, var_120_18)
								local var_120_20 = Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, var_120_18)
								local var_120_21 = Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, var_120_18)

								iter_120_6.color = Color.New(var_120_19, var_120_20, var_120_21)
							else
								local var_120_22 = Mathf.Lerp(iter_120_6.color.r, 0.5, var_120_18)

								iter_120_6.color = Color.New(var_120_22, var_120_22, var_120_22)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10062 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_120_8 then
						if arg_117_1.isInRecall_ then
							iter_120_8.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10062 = nil
			end

			local var_120_23 = 0
			local var_120_24 = 0.625

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[612].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(410161028)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 25
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161028", "story_v_out_410161.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161028", "story_v_out_410161.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_410161", "410161028", "story_v_out_410161.awb")

						arg_117_1:RecordAudio("410161028", var_120_32)
						arg_117_1:RecordAudio("410161028", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410161", "410161028", "story_v_out_410161.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410161", "410161028", "story_v_out_410161.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410161029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410161029
		arg_121_1.duration_ = 14.77

		local var_121_0 = {
			ja = 14.766,
			CriLanguages = 9.933,
			zh = 9.933
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
				arg_121_0:Play410161030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10062"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10062 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10062", 4)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "split_1_1" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(370, -390, -290)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10062, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_124_7 = arg_121_1.actors_["10062"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10062 == nil then
				arg_121_1.var_.actorSpriteComps10062 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps10062 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								local var_124_11 = Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, var_124_10)
								local var_124_12 = Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, var_124_10)
								local var_124_13 = Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, var_124_10)

								iter_124_2.color = Color.New(var_124_11, var_124_12, var_124_13)
							else
								local var_124_14 = Mathf.Lerp(iter_124_2.color.r, 1, var_124_10)

								iter_124_2.color = Color.New(var_124_14, var_124_14, var_124_14)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10062 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10062 = nil
			end

			local var_124_15 = arg_121_1.actors_["1061"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 == nil then
				arg_121_1.var_.actorSpriteComps1061 = var_124_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_17 = 0.034

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.actorSpriteComps1061 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								local var_124_19 = Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, var_124_18)
								local var_124_20 = Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, var_124_18)
								local var_124_21 = Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, var_124_18)

								iter_124_6.color = Color.New(var_124_19, var_124_20, var_124_21)
							else
								local var_124_22 = Mathf.Lerp(iter_124_6.color.r, 0.5, var_124_18)

								iter_124_6.color = Color.New(var_124_22, var_124_22, var_124_22)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_124_8 then
						if arg_121_1.isInRecall_ then
							iter_124_8.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1061 = nil
			end

			local var_124_23 = 0
			local var_124_24 = 0.825

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_25 = arg_121_1:FormatText(StoryNameCfg[600].name)

				arg_121_1.leftNameTxt_.text = var_124_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_26 = arg_121_1:GetWordFromCfg(410161029)
				local var_124_27 = arg_121_1:FormatText(var_124_26.content)

				arg_121_1.text_.text = var_124_27

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_28 = 33
				local var_124_29 = utf8.len(var_124_27)
				local var_124_30 = var_124_28 <= 0 and var_124_24 or var_124_24 * (var_124_29 / var_124_28)

				if var_124_30 > 0 and var_124_24 < var_124_30 then
					arg_121_1.talkMaxDuration = var_124_30

					if var_124_30 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_30 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_27
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161029", "story_v_out_410161.awb") ~= 0 then
					local var_124_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161029", "story_v_out_410161.awb") / 1000

					if var_124_31 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_31 + var_124_23
					end

					if var_124_26.prefab_name ~= "" and arg_121_1.actors_[var_124_26.prefab_name] ~= nil then
						local var_124_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_26.prefab_name].transform, "story_v_out_410161", "410161029", "story_v_out_410161.awb")

						arg_121_1:RecordAudio("410161029", var_124_32)
						arg_121_1:RecordAudio("410161029", var_124_32)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410161", "410161029", "story_v_out_410161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410161", "410161029", "story_v_out_410161.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_33 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_23) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_23 + var_124_33 and arg_121_1.time_ < var_124_23 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play410161030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410161030
		arg_125_1.duration_ = 5.83

		local var_125_0 = {
			ja = 5.833,
			CriLanguages = 3.5,
			zh = 3.5
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
				arg_125_0:Play410161031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1061"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 2)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "split_5" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(-390, -490, 18)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_128_7 = arg_125_1.actors_["1061"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.034

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								local var_128_11 = Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, var_128_10)
								local var_128_12 = Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, var_128_10)
								local var_128_13 = Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, var_128_10)

								iter_128_2.color = Color.New(var_128_11, var_128_12, var_128_13)
							else
								local var_128_14 = Mathf.Lerp(iter_128_2.color.r, 1, var_128_10)

								iter_128_2.color = Color.New(var_128_14, var_128_14, var_128_14)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_15 = arg_125_1.actors_["10062"]
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.actorSpriteComps10062 == nil then
				arg_125_1.var_.actorSpriteComps10062 = var_128_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_17 = 0.034

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 and not isNil(var_128_15) then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17

				if arg_125_1.var_.actorSpriteComps10062 then
					for iter_128_5, iter_128_6 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_128_6 then
							if arg_125_1.isInRecall_ then
								local var_128_19 = Mathf.Lerp(iter_128_6.color.r, arg_125_1.hightColor2.r, var_128_18)
								local var_128_20 = Mathf.Lerp(iter_128_6.color.g, arg_125_1.hightColor2.g, var_128_18)
								local var_128_21 = Mathf.Lerp(iter_128_6.color.b, arg_125_1.hightColor2.b, var_128_18)

								iter_128_6.color = Color.New(var_128_19, var_128_20, var_128_21)
							else
								local var_128_22 = Mathf.Lerp(iter_128_6.color.r, 0.5, var_128_18)

								iter_128_6.color = Color.New(var_128_22, var_128_22, var_128_22)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.actorSpriteComps10062 then
				for iter_128_7, iter_128_8 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_128_8 then
						if arg_125_1.isInRecall_ then
							iter_128_8.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10062 = nil
			end

			local var_128_23 = 0
			local var_128_24 = 0.25

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_25 = arg_125_1:FormatText(StoryNameCfg[612].name)

				arg_125_1.leftNameTxt_.text = var_128_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_26 = arg_125_1:GetWordFromCfg(410161030)
				local var_128_27 = arg_125_1:FormatText(var_128_26.content)

				arg_125_1.text_.text = var_128_27

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_28 = 10
				local var_128_29 = utf8.len(var_128_27)
				local var_128_30 = var_128_28 <= 0 and var_128_24 or var_128_24 * (var_128_29 / var_128_28)

				if var_128_30 > 0 and var_128_24 < var_128_30 then
					arg_125_1.talkMaxDuration = var_128_30

					if var_128_30 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_23
					end
				end

				arg_125_1.text_.text = var_128_27
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161030", "story_v_out_410161.awb") ~= 0 then
					local var_128_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161030", "story_v_out_410161.awb") / 1000

					if var_128_31 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_23
					end

					if var_128_26.prefab_name ~= "" and arg_125_1.actors_[var_128_26.prefab_name] ~= nil then
						local var_128_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_26.prefab_name].transform, "story_v_out_410161", "410161030", "story_v_out_410161.awb")

						arg_125_1:RecordAudio("410161030", var_128_32)
						arg_125_1:RecordAudio("410161030", var_128_32)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410161", "410161030", "story_v_out_410161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410161", "410161030", "story_v_out_410161.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_33 = math.max(var_128_24, arg_125_1.talkMaxDuration)

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_33 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_33

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_33 and arg_125_1.time_ < var_128_23 + var_128_33 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410161031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410161031
		arg_129_1.duration_ = 13.23

		local var_129_0 = {
			ja = 13.233,
			CriLanguages = 8.933,
			zh = 8.933
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
				arg_129_0:Play410161032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10062"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10062 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10062", 4)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_1_1" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(370, -390, -290)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10062, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_132_7 = arg_129_1.actors_["10062"]
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 == nil then
				arg_129_1.var_.actorSpriteComps10062 = var_132_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 0.034

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 and not isNil(var_132_7) then
				local var_132_10 = (arg_129_1.time_ - var_132_8) / var_132_9

				if arg_129_1.var_.actorSpriteComps10062 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								local var_132_11 = Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, var_132_10)
								local var_132_12 = Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, var_132_10)
								local var_132_13 = Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, var_132_10)

								iter_132_2.color = Color.New(var_132_11, var_132_12, var_132_13)
							else
								local var_132_14 = Mathf.Lerp(iter_132_2.color.r, 1, var_132_10)

								iter_132_2.color = Color.New(var_132_14, var_132_14, var_132_14)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_132_4 then
						if arg_129_1.isInRecall_ then
							iter_132_4.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10062 = nil
			end

			local var_132_15 = arg_129_1.actors_["1061"]
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 and not isNil(var_132_15) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_17 = 0.034

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 and not isNil(var_132_15) then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17

				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_6 then
							if arg_129_1.isInRecall_ then
								local var_132_19 = Mathf.Lerp(iter_132_6.color.r, arg_129_1.hightColor2.r, var_132_18)
								local var_132_20 = Mathf.Lerp(iter_132_6.color.g, arg_129_1.hightColor2.g, var_132_18)
								local var_132_21 = Mathf.Lerp(iter_132_6.color.b, arg_129_1.hightColor2.b, var_132_18)

								iter_132_6.color = Color.New(var_132_19, var_132_20, var_132_21)
							else
								local var_132_22 = Mathf.Lerp(iter_132_6.color.r, 0.5, var_132_18)

								iter_132_6.color = Color.New(var_132_22, var_132_22, var_132_22)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 and not isNil(var_132_15) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_7, iter_132_8 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_8 then
						if arg_129_1.isInRecall_ then
							iter_132_8.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			local var_132_23 = 0
			local var_132_24 = 0.75

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_25 = arg_129_1:FormatText(StoryNameCfg[600].name)

				arg_129_1.leftNameTxt_.text = var_132_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_26 = arg_129_1:GetWordFromCfg(410161031)
				local var_132_27 = arg_129_1:FormatText(var_132_26.content)

				arg_129_1.text_.text = var_132_27

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_28 = 30
				local var_132_29 = utf8.len(var_132_27)
				local var_132_30 = var_132_28 <= 0 and var_132_24 or var_132_24 * (var_132_29 / var_132_28)

				if var_132_30 > 0 and var_132_24 < var_132_30 then
					arg_129_1.talkMaxDuration = var_132_30

					if var_132_30 + var_132_23 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_30 + var_132_23
					end
				end

				arg_129_1.text_.text = var_132_27
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161031", "story_v_out_410161.awb") ~= 0 then
					local var_132_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161031", "story_v_out_410161.awb") / 1000

					if var_132_31 + var_132_23 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_31 + var_132_23
					end

					if var_132_26.prefab_name ~= "" and arg_129_1.actors_[var_132_26.prefab_name] ~= nil then
						local var_132_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_26.prefab_name].transform, "story_v_out_410161", "410161031", "story_v_out_410161.awb")

						arg_129_1:RecordAudio("410161031", var_132_32)
						arg_129_1:RecordAudio("410161031", var_132_32)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410161", "410161031", "story_v_out_410161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410161", "410161031", "story_v_out_410161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_33 = math.max(var_132_24, arg_129_1.talkMaxDuration)

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_33 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_23) / var_132_33

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_23 + var_132_33 and arg_129_1.time_ < var_132_23 + var_132_33 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410161032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410161032
		arg_133_1.duration_ = 17

		local var_133_0 = {
			ja = 17,
			CriLanguages = 11,
			zh = 11
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
				arg_133_0:Play410161033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10062"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10062 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10062", 4)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_1_1" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(370, -390, -290)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10062, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_136_7 = arg_133_1.actors_["10062"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps10062 == nil then
				arg_133_1.var_.actorSpriteComps10062 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 0.034

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps10062 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								local var_136_11 = Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, var_136_10)
								local var_136_12 = Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, var_136_10)
								local var_136_13 = Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, var_136_10)

								iter_136_2.color = Color.New(var_136_11, var_136_12, var_136_13)
							else
								local var_136_14 = Mathf.Lerp(iter_136_2.color.r, 1, var_136_10)

								iter_136_2.color = Color.New(var_136_14, var_136_14, var_136_14)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps10062 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10062 = nil
			end

			local var_136_15 = arg_133_1.actors_["1061"]
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps1061 == nil then
				arg_133_1.var_.actorSpriteComps1061 = var_136_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_17 = 0.034

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 and not isNil(var_136_15) then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17

				if arg_133_1.var_.actorSpriteComps1061 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								local var_136_19 = Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, var_136_18)
								local var_136_20 = Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, var_136_18)
								local var_136_21 = Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, var_136_18)

								iter_136_6.color = Color.New(var_136_19, var_136_20, var_136_21)
							else
								local var_136_22 = Mathf.Lerp(iter_136_6.color.r, 0.5, var_136_18)

								iter_136_6.color = Color.New(var_136_22, var_136_22, var_136_22)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps1061 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_136_8 then
						if arg_133_1.isInRecall_ then
							iter_136_8.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1061 = nil
			end

			local var_136_23 = 0
			local var_136_24 = 1.025

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_25 = arg_133_1:FormatText(StoryNameCfg[600].name)

				arg_133_1.leftNameTxt_.text = var_136_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_26 = arg_133_1:GetWordFromCfg(410161032)
				local var_136_27 = arg_133_1:FormatText(var_136_26.content)

				arg_133_1.text_.text = var_136_27

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 41
				local var_136_29 = utf8.len(var_136_27)
				local var_136_30 = var_136_28 <= 0 and var_136_24 or var_136_24 * (var_136_29 / var_136_28)

				if var_136_30 > 0 and var_136_24 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30

					if var_136_30 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_27
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161032", "story_v_out_410161.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161032", "story_v_out_410161.awb") / 1000

					if var_136_31 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_23
					end

					if var_136_26.prefab_name ~= "" and arg_133_1.actors_[var_136_26.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_26.prefab_name].transform, "story_v_out_410161", "410161032", "story_v_out_410161.awb")

						arg_133_1:RecordAudio("410161032", var_136_32)
						arg_133_1:RecordAudio("410161032", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410161", "410161032", "story_v_out_410161.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410161", "410161032", "story_v_out_410161.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_33 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_33

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_33 and arg_133_1.time_ < var_136_23 + var_136_33 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play410161033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410161033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play410161034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10062"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10062 == nil then
				arg_137_1.var_.actorSpriteComps10062 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.034

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10062 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 0.5, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10062 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10062 = nil
			end

			local var_140_8 = arg_137_1.actors_["1061"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1061 == nil then
				arg_137_1.var_.actorSpriteComps1061 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.034

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps1061 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								local var_140_12 = Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, var_140_11)
								local var_140_13 = Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, var_140_11)
								local var_140_14 = Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, var_140_11)

								iter_140_5.color = Color.New(var_140_12, var_140_13, var_140_14)
							else
								local var_140_15 = Mathf.Lerp(iter_140_5.color.r, 0.5, var_140_11)

								iter_140_5.color = Color.New(var_140_15, var_140_15, var_140_15)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps1061 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1061 = nil
			end

			local var_140_16 = 0
			local var_140_17 = 1.525

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(410161033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 61
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_17 or var_140_17 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_17 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_16
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_23 = math.max(var_140_17, arg_137_1.talkMaxDuration)

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_23 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_16) / var_140_23

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_16 + var_140_23 and arg_137_1.time_ < var_140_16 + var_140_23 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play410161034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410161034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410161035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1

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

				local var_144_2 = arg_141_1:GetWordFromCfg(410161034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 40
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
	Play410161035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410161035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410161036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.375

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(410161035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 15
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play410161036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410161036
		arg_149_1.duration_ = 11.73

		local var_149_0 = {
			ja = 10.833,
			CriLanguages = 11.733,
			zh = 11.733
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
				arg_149_0:Play410161037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10062"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10062 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10062", 4)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "split_2" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(370, -390, -290)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10062, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_152_7 = arg_149_1.actors_["10062"]
			local var_152_8 = 0

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10062 == nil then
				arg_149_1.var_.actorSpriteComps10062 = var_152_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_9 = 0.034

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 and not isNil(var_152_7) then
				local var_152_10 = (arg_149_1.time_ - var_152_8) / var_152_9

				if arg_149_1.var_.actorSpriteComps10062 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								local var_152_11 = Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, var_152_10)
								local var_152_12 = Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, var_152_10)
								local var_152_13 = Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, var_152_10)

								iter_152_2.color = Color.New(var_152_11, var_152_12, var_152_13)
							else
								local var_152_14 = Mathf.Lerp(iter_152_2.color.r, 1, var_152_10)

								iter_152_2.color = Color.New(var_152_14, var_152_14, var_152_14)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10062 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_152_4 then
						if arg_149_1.isInRecall_ then
							iter_152_4.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10062 = nil
			end

			local var_152_15 = arg_149_1.actors_["1061"]
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_17 = 0.034

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 and not isNil(var_152_15) then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17

				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_5, iter_152_6 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_152_6 then
							if arg_149_1.isInRecall_ then
								local var_152_19 = Mathf.Lerp(iter_152_6.color.r, arg_149_1.hightColor2.r, var_152_18)
								local var_152_20 = Mathf.Lerp(iter_152_6.color.g, arg_149_1.hightColor2.g, var_152_18)
								local var_152_21 = Mathf.Lerp(iter_152_6.color.b, arg_149_1.hightColor2.b, var_152_18)

								iter_152_6.color = Color.New(var_152_19, var_152_20, var_152_21)
							else
								local var_152_22 = Mathf.Lerp(iter_152_6.color.r, 0.5, var_152_18)

								iter_152_6.color = Color.New(var_152_22, var_152_22, var_152_22)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_7, iter_152_8 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_8 then
						if arg_149_1.isInRecall_ then
							iter_152_8.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_23 = 0
			local var_152_24 = 0.85

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_25 = arg_149_1:FormatText(StoryNameCfg[600].name)

				arg_149_1.leftNameTxt_.text = var_152_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_26 = arg_149_1:GetWordFromCfg(410161036)
				local var_152_27 = arg_149_1:FormatText(var_152_26.content)

				arg_149_1.text_.text = var_152_27

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_28 = 34
				local var_152_29 = utf8.len(var_152_27)
				local var_152_30 = var_152_28 <= 0 and var_152_24 or var_152_24 * (var_152_29 / var_152_28)

				if var_152_30 > 0 and var_152_24 < var_152_30 then
					arg_149_1.talkMaxDuration = var_152_30

					if var_152_30 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_30 + var_152_23
					end
				end

				arg_149_1.text_.text = var_152_27
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161036", "story_v_out_410161.awb") ~= 0 then
					local var_152_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161036", "story_v_out_410161.awb") / 1000

					if var_152_31 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_23
					end

					if var_152_26.prefab_name ~= "" and arg_149_1.actors_[var_152_26.prefab_name] ~= nil then
						local var_152_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_26.prefab_name].transform, "story_v_out_410161", "410161036", "story_v_out_410161.awb")

						arg_149_1:RecordAudio("410161036", var_152_32)
						arg_149_1:RecordAudio("410161036", var_152_32)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410161", "410161036", "story_v_out_410161.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410161", "410161036", "story_v_out_410161.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_33 = math.max(var_152_24, arg_149_1.talkMaxDuration)

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_33 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_23) / var_152_33

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_23 + var_152_33 and arg_149_1.time_ < var_152_23 + var_152_33 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410161037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410161037
		arg_153_1.duration_ = 1.4

		local var_153_0 = {
			ja = 1,
			CriLanguages = 1.4,
			zh = 1.4
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
				arg_153_0:Play410161038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1061"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1061 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1061", 2)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(-390, -490, 18)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1061, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_156_7 = arg_153_1.actors_["1061"]
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1061 == nil then
				arg_153_1.var_.actorSpriteComps1061 = var_156_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.034

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 and not isNil(var_156_7) then
				local var_156_10 = (arg_153_1.time_ - var_156_8) / var_156_9

				if arg_153_1.var_.actorSpriteComps1061 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								local var_156_11 = Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, var_156_10)
								local var_156_12 = Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, var_156_10)
								local var_156_13 = Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, var_156_10)

								iter_156_2.color = Color.New(var_156_11, var_156_12, var_156_13)
							else
								local var_156_14 = Mathf.Lerp(iter_156_2.color.r, 1, var_156_10)

								iter_156_2.color = Color.New(var_156_14, var_156_14, var_156_14)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps1061 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_156_4 then
						if arg_153_1.isInRecall_ then
							iter_156_4.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1061 = nil
			end

			local var_156_15 = arg_153_1.actors_["10062"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps10062 == nil then
				arg_153_1.var_.actorSpriteComps10062 = var_156_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_17 = 0.034

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.actorSpriteComps10062 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								local var_156_19 = Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, var_156_18)
								local var_156_20 = Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, var_156_18)
								local var_156_21 = Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, var_156_18)

								iter_156_6.color = Color.New(var_156_19, var_156_20, var_156_21)
							else
								local var_156_22 = Mathf.Lerp(iter_156_6.color.r, 0.5, var_156_18)

								iter_156_6.color = Color.New(var_156_22, var_156_22, var_156_22)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.actorSpriteComps10062 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_156_8 then
						if arg_153_1.isInRecall_ then
							iter_156_8.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10062 = nil
			end

			local var_156_23 = 0
			local var_156_24 = 0.05

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_25 = arg_153_1:FormatText(StoryNameCfg[612].name)

				arg_153_1.leftNameTxt_.text = var_156_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_26 = arg_153_1:GetWordFromCfg(410161037)
				local var_156_27 = arg_153_1:FormatText(var_156_26.content)

				arg_153_1.text_.text = var_156_27

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_28 = 2
				local var_156_29 = utf8.len(var_156_27)
				local var_156_30 = var_156_28 <= 0 and var_156_24 or var_156_24 * (var_156_29 / var_156_28)

				if var_156_30 > 0 and var_156_24 < var_156_30 then
					arg_153_1.talkMaxDuration = var_156_30

					if var_156_30 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_30 + var_156_23
					end
				end

				arg_153_1.text_.text = var_156_27
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161037", "story_v_out_410161.awb") ~= 0 then
					local var_156_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161037", "story_v_out_410161.awb") / 1000

					if var_156_31 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_31 + var_156_23
					end

					if var_156_26.prefab_name ~= "" and arg_153_1.actors_[var_156_26.prefab_name] ~= nil then
						local var_156_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_26.prefab_name].transform, "story_v_out_410161", "410161037", "story_v_out_410161.awb")

						arg_153_1:RecordAudio("410161037", var_156_32)
						arg_153_1:RecordAudio("410161037", var_156_32)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410161", "410161037", "story_v_out_410161.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410161", "410161037", "story_v_out_410161.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_33 = math.max(var_156_24, arg_153_1.talkMaxDuration)

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_33 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_23) / var_156_33

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_23 + var_156_33 and arg_153_1.time_ < var_156_23 + var_156_33 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play410161038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410161038
		arg_157_1.duration_ = 5.6

		local var_157_0 = {
			ja = 5.6,
			CriLanguages = 4.633,
			zh = 4.633
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
				arg_157_0:Play410161039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10059"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10059 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10059", 4)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "split_5" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(390, -530, 35)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10059, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_160_7 = arg_157_1.actors_["10062"].transform
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.var_.moveOldPos10062 = var_160_7.localPosition
				var_160_7.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10062", 7)

				local var_160_9 = var_160_7.childCount

				for iter_160_1 = 0, var_160_9 - 1 do
					local var_160_10 = var_160_7:GetChild(iter_160_1)

					if var_160_10.name == "" or not string.find(var_160_10.name, "split") then
						var_160_10.gameObject:SetActive(true)
					else
						var_160_10.gameObject:SetActive(false)
					end
				end
			end

			local var_160_11 = 0.001

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_8) / var_160_11
				local var_160_13 = Vector3.New(0, -2000, -290)

				var_160_7.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10062, var_160_13, var_160_12)
			end

			if arg_157_1.time_ >= var_160_8 + var_160_11 and arg_157_1.time_ < var_160_8 + var_160_11 + arg_160_0 then
				var_160_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_160_14 = arg_157_1.actors_["10059"]
			local var_160_15 = 0

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 and not isNil(var_160_14) and arg_157_1.var_.actorSpriteComps10059 == nil then
				arg_157_1.var_.actorSpriteComps10059 = var_160_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_16 = 0.034

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_16 and not isNil(var_160_14) then
				local var_160_17 = (arg_157_1.time_ - var_160_15) / var_160_16

				if arg_157_1.var_.actorSpriteComps10059 then
					for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_160_3 then
							if arg_157_1.isInRecall_ then
								local var_160_18 = Mathf.Lerp(iter_160_3.color.r, arg_157_1.hightColor1.r, var_160_17)
								local var_160_19 = Mathf.Lerp(iter_160_3.color.g, arg_157_1.hightColor1.g, var_160_17)
								local var_160_20 = Mathf.Lerp(iter_160_3.color.b, arg_157_1.hightColor1.b, var_160_17)

								iter_160_3.color = Color.New(var_160_18, var_160_19, var_160_20)
							else
								local var_160_21 = Mathf.Lerp(iter_160_3.color.r, 1, var_160_17)

								iter_160_3.color = Color.New(var_160_21, var_160_21, var_160_21)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_15 + var_160_16 and arg_157_1.time_ < var_160_15 + var_160_16 + arg_160_0 and not isNil(var_160_14) and arg_157_1.var_.actorSpriteComps10059 then
				for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_160_5 then
						if arg_157_1.isInRecall_ then
							iter_160_5.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10059 = nil
			end

			local var_160_22 = arg_157_1.actors_["10062"]
			local var_160_23 = 0

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps10062 == nil then
				arg_157_1.var_.actorSpriteComps10062 = var_160_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_24 = 0.034

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 and not isNil(var_160_22) then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24

				if arg_157_1.var_.actorSpriteComps10062 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								local var_160_26 = Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, var_160_25)
								local var_160_27 = Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, var_160_25)
								local var_160_28 = Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, var_160_25)

								iter_160_7.color = Color.New(var_160_26, var_160_27, var_160_28)
							else
								local var_160_29 = Mathf.Lerp(iter_160_7.color.r, 0.5, var_160_25)

								iter_160_7.color = Color.New(var_160_29, var_160_29, var_160_29)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps10062 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_160_9 then
						if arg_157_1.isInRecall_ then
							iter_160_9.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10062 = nil
			end

			local var_160_30 = arg_157_1.actors_["1061"]
			local var_160_31 = 0

			if var_160_31 < arg_157_1.time_ and arg_157_1.time_ <= var_160_31 + arg_160_0 and not isNil(var_160_30) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_32 = 0.034

			if var_160_31 <= arg_157_1.time_ and arg_157_1.time_ < var_160_31 + var_160_32 and not isNil(var_160_30) then
				local var_160_33 = (arg_157_1.time_ - var_160_31) / var_160_32

				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_11 then
							if arg_157_1.isInRecall_ then
								local var_160_34 = Mathf.Lerp(iter_160_11.color.r, arg_157_1.hightColor2.r, var_160_33)
								local var_160_35 = Mathf.Lerp(iter_160_11.color.g, arg_157_1.hightColor2.g, var_160_33)
								local var_160_36 = Mathf.Lerp(iter_160_11.color.b, arg_157_1.hightColor2.b, var_160_33)

								iter_160_11.color = Color.New(var_160_34, var_160_35, var_160_36)
							else
								local var_160_37 = Mathf.Lerp(iter_160_11.color.r, 0.5, var_160_33)

								iter_160_11.color = Color.New(var_160_37, var_160_37, var_160_37)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_31 + var_160_32 and arg_157_1.time_ < var_160_31 + var_160_32 + arg_160_0 and not isNil(var_160_30) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_12, iter_160_13 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_13 then
						if arg_157_1.isInRecall_ then
							iter_160_13.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_38 = 0
			local var_160_39 = 0.45

			if var_160_38 < arg_157_1.time_ and arg_157_1.time_ <= var_160_38 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_40 = arg_157_1:FormatText(StoryNameCfg[596].name)

				arg_157_1.leftNameTxt_.text = var_160_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_41 = arg_157_1:GetWordFromCfg(410161038)
				local var_160_42 = arg_157_1:FormatText(var_160_41.content)

				arg_157_1.text_.text = var_160_42

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_43 = 18
				local var_160_44 = utf8.len(var_160_42)
				local var_160_45 = var_160_43 <= 0 and var_160_39 or var_160_39 * (var_160_44 / var_160_43)

				if var_160_45 > 0 and var_160_39 < var_160_45 then
					arg_157_1.talkMaxDuration = var_160_45

					if var_160_45 + var_160_38 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_45 + var_160_38
					end
				end

				arg_157_1.text_.text = var_160_42
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161038", "story_v_out_410161.awb") ~= 0 then
					local var_160_46 = manager.audio:GetVoiceLength("story_v_out_410161", "410161038", "story_v_out_410161.awb") / 1000

					if var_160_46 + var_160_38 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_46 + var_160_38
					end

					if var_160_41.prefab_name ~= "" and arg_157_1.actors_[var_160_41.prefab_name] ~= nil then
						local var_160_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_41.prefab_name].transform, "story_v_out_410161", "410161038", "story_v_out_410161.awb")

						arg_157_1:RecordAudio("410161038", var_160_47)
						arg_157_1:RecordAudio("410161038", var_160_47)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410161", "410161038", "story_v_out_410161.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410161", "410161038", "story_v_out_410161.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_48 = math.max(var_160_39, arg_157_1.talkMaxDuration)

			if var_160_38 <= arg_157_1.time_ and arg_157_1.time_ < var_160_38 + var_160_48 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_38) / var_160_48

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_38 + var_160_48 and arg_157_1.time_ < var_160_38 + var_160_48 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410161039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410161039
		arg_161_1.duration_ = 7.9

		local var_161_0 = {
			ja = 7.9,
			CriLanguages = 2.833,
			zh = 2.833
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
				arg_161_0:Play410161040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10059"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10059 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10059", 7)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "split_1" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(0, -2000, 35)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10059, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_164_7 = arg_161_1.actors_["10059"]
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps10059 == nil then
				arg_161_1.var_.actorSpriteComps10059 = var_164_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 0.034

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 and not isNil(var_164_7) then
				local var_164_10 = (arg_161_1.time_ - var_164_8) / var_164_9

				if arg_161_1.var_.actorSpriteComps10059 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								local var_164_11 = Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor2.r, var_164_10)
								local var_164_12 = Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor2.g, var_164_10)
								local var_164_13 = Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor2.b, var_164_10)

								iter_164_2.color = Color.New(var_164_11, var_164_12, var_164_13)
							else
								local var_164_14 = Mathf.Lerp(iter_164_2.color.r, 0.5, var_164_10)

								iter_164_2.color = Color.New(var_164_14, var_164_14, var_164_14)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps10059 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_164_4 then
						if arg_161_1.isInRecall_ then
							iter_164_4.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10059 = nil
			end

			local var_164_15 = arg_161_1.actors_["10062"].transform
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.var_.moveOldPos10062 = var_164_15.localPosition
				var_164_15.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10062", 4)

				local var_164_17 = var_164_15.childCount

				for iter_164_5 = 0, var_164_17 - 1 do
					local var_164_18 = var_164_15:GetChild(iter_164_5)

					if var_164_18.name == "split_1_1" or not string.find(var_164_18.name, "split") then
						var_164_18.gameObject:SetActive(true)
					else
						var_164_18.gameObject:SetActive(false)
					end
				end
			end

			local var_164_19 = 0.001

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_19 then
				local var_164_20 = (arg_161_1.time_ - var_164_16) / var_164_19
				local var_164_21 = Vector3.New(370, -390, -290)

				var_164_15.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10062, var_164_21, var_164_20)
			end

			if arg_161_1.time_ >= var_164_16 + var_164_19 and arg_161_1.time_ < var_164_16 + var_164_19 + arg_164_0 then
				var_164_15.localPosition = Vector3.New(370, -390, -290)
			end

			local var_164_22 = arg_161_1.actors_["10062"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.actorSpriteComps10062 == nil then
				arg_161_1.var_.actorSpriteComps10062 = var_164_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_24 = 0.034

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.actorSpriteComps10062 then
					for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_164_7 then
							if arg_161_1.isInRecall_ then
								local var_164_26 = Mathf.Lerp(iter_164_7.color.r, arg_161_1.hightColor1.r, var_164_25)
								local var_164_27 = Mathf.Lerp(iter_164_7.color.g, arg_161_1.hightColor1.g, var_164_25)
								local var_164_28 = Mathf.Lerp(iter_164_7.color.b, arg_161_1.hightColor1.b, var_164_25)

								iter_164_7.color = Color.New(var_164_26, var_164_27, var_164_28)
							else
								local var_164_29 = Mathf.Lerp(iter_164_7.color.r, 1, var_164_25)

								iter_164_7.color = Color.New(var_164_29, var_164_29, var_164_29)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.actorSpriteComps10062 then
				for iter_164_8, iter_164_9 in pairs(arg_161_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_164_9 then
						if arg_161_1.isInRecall_ then
							iter_164_9.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10062 = nil
			end

			local var_164_30 = 0
			local var_164_31 = 0.175

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[600].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_33 = arg_161_1:GetWordFromCfg(410161039)
				local var_164_34 = arg_161_1:FormatText(var_164_33.content)

				arg_161_1.text_.text = var_164_34

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_35 = 7
				local var_164_36 = utf8.len(var_164_34)
				local var_164_37 = var_164_35 <= 0 and var_164_31 or var_164_31 * (var_164_36 / var_164_35)

				if var_164_37 > 0 and var_164_31 < var_164_37 then
					arg_161_1.talkMaxDuration = var_164_37

					if var_164_37 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_34
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161039", "story_v_out_410161.awb") ~= 0 then
					local var_164_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161039", "story_v_out_410161.awb") / 1000

					if var_164_38 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_38 + var_164_30
					end

					if var_164_33.prefab_name ~= "" and arg_161_1.actors_[var_164_33.prefab_name] ~= nil then
						local var_164_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_33.prefab_name].transform, "story_v_out_410161", "410161039", "story_v_out_410161.awb")

						arg_161_1:RecordAudio("410161039", var_164_39)
						arg_161_1:RecordAudio("410161039", var_164_39)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410161", "410161039", "story_v_out_410161.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410161", "410161039", "story_v_out_410161.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_40 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_40 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_40

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_40 and arg_161_1.time_ < var_164_30 + var_164_40 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410161040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410161040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410161041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10062"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10062 == nil then
				arg_165_1.var_.actorSpriteComps10062 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.034

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10062 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 0.5, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10062 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10062 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.725

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(410161040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 29
				local var_168_13 = utf8.len(var_168_11)
				local var_168_14 = var_168_12 <= 0 and var_168_9 or var_168_9 * (var_168_13 / var_168_12)

				if var_168_14 > 0 and var_168_9 < var_168_14 then
					arg_165_1.talkMaxDuration = var_168_14

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_15 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_15 and arg_165_1.time_ < var_168_8 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play410161041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410161041
		arg_169_1.duration_ = 9.7

		local var_169_0 = {
			ja = 9.7,
			CriLanguages = 5.9,
			zh = 5.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410161042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10059"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10059 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10059", 4)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "split_5" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(390, -530, 35)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10059, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_172_7 = arg_169_1.actors_["10062"].transform
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.var_.moveOldPos10062 = var_172_7.localPosition
				var_172_7.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10062", 7)

				local var_172_9 = var_172_7.childCount

				for iter_172_1 = 0, var_172_9 - 1 do
					local var_172_10 = var_172_7:GetChild(iter_172_1)

					if var_172_10.name == "" or not string.find(var_172_10.name, "split") then
						var_172_10.gameObject:SetActive(true)
					else
						var_172_10.gameObject:SetActive(false)
					end
				end
			end

			local var_172_11 = 0.001

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_11 then
				local var_172_12 = (arg_169_1.time_ - var_172_8) / var_172_11
				local var_172_13 = Vector3.New(0, -2000, -290)

				var_172_7.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10062, var_172_13, var_172_12)
			end

			if arg_169_1.time_ >= var_172_8 + var_172_11 and arg_169_1.time_ < var_172_8 + var_172_11 + arg_172_0 then
				var_172_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_172_14 = arg_169_1.actors_["10059"]
			local var_172_15 = 0

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.actorSpriteComps10059 == nil then
				arg_169_1.var_.actorSpriteComps10059 = var_172_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_16 = 0.034

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_16 and not isNil(var_172_14) then
				local var_172_17 = (arg_169_1.time_ - var_172_15) / var_172_16

				if arg_169_1.var_.actorSpriteComps10059 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								local var_172_18 = Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor1.r, var_172_17)
								local var_172_19 = Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor1.g, var_172_17)
								local var_172_20 = Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor1.b, var_172_17)

								iter_172_3.color = Color.New(var_172_18, var_172_19, var_172_20)
							else
								local var_172_21 = Mathf.Lerp(iter_172_3.color.r, 1, var_172_17)

								iter_172_3.color = Color.New(var_172_21, var_172_21, var_172_21)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_15 + var_172_16 and arg_169_1.time_ < var_172_15 + var_172_16 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.actorSpriteComps10059 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_172_5 then
						if arg_169_1.isInRecall_ then
							iter_172_5.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10059 = nil
			end

			local var_172_22 = arg_169_1.actors_["10062"]
			local var_172_23 = 0

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.actorSpriteComps10062 == nil then
				arg_169_1.var_.actorSpriteComps10062 = var_172_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_24 = 0.034

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_24 and not isNil(var_172_22) then
				local var_172_25 = (arg_169_1.time_ - var_172_23) / var_172_24

				if arg_169_1.var_.actorSpriteComps10062 then
					for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_172_7 then
							if arg_169_1.isInRecall_ then
								local var_172_26 = Mathf.Lerp(iter_172_7.color.r, arg_169_1.hightColor2.r, var_172_25)
								local var_172_27 = Mathf.Lerp(iter_172_7.color.g, arg_169_1.hightColor2.g, var_172_25)
								local var_172_28 = Mathf.Lerp(iter_172_7.color.b, arg_169_1.hightColor2.b, var_172_25)

								iter_172_7.color = Color.New(var_172_26, var_172_27, var_172_28)
							else
								local var_172_29 = Mathf.Lerp(iter_172_7.color.r, 0.5, var_172_25)

								iter_172_7.color = Color.New(var_172_29, var_172_29, var_172_29)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_23 + var_172_24 and arg_169_1.time_ < var_172_23 + var_172_24 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.actorSpriteComps10062 then
				for iter_172_8, iter_172_9 in pairs(arg_169_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_172_9 then
						if arg_169_1.isInRecall_ then
							iter_172_9.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10062 = nil
			end

			local var_172_30 = 0
			local var_172_31 = 0.45

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_32 = arg_169_1:FormatText(StoryNameCfg[596].name)

				arg_169_1.leftNameTxt_.text = var_172_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_33 = arg_169_1:GetWordFromCfg(410161041)
				local var_172_34 = arg_169_1:FormatText(var_172_33.content)

				arg_169_1.text_.text = var_172_34

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_35 = 18
				local var_172_36 = utf8.len(var_172_34)
				local var_172_37 = var_172_35 <= 0 and var_172_31 or var_172_31 * (var_172_36 / var_172_35)

				if var_172_37 > 0 and var_172_31 < var_172_37 then
					arg_169_1.talkMaxDuration = var_172_37

					if var_172_37 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_37 + var_172_30
					end
				end

				arg_169_1.text_.text = var_172_34
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161041", "story_v_out_410161.awb") ~= 0 then
					local var_172_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161041", "story_v_out_410161.awb") / 1000

					if var_172_38 + var_172_30 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_38 + var_172_30
					end

					if var_172_33.prefab_name ~= "" and arg_169_1.actors_[var_172_33.prefab_name] ~= nil then
						local var_172_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_33.prefab_name].transform, "story_v_out_410161", "410161041", "story_v_out_410161.awb")

						arg_169_1:RecordAudio("410161041", var_172_39)
						arg_169_1:RecordAudio("410161041", var_172_39)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410161", "410161041", "story_v_out_410161.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410161", "410161041", "story_v_out_410161.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_40 = math.max(var_172_31, arg_169_1.talkMaxDuration)

			if var_172_30 <= arg_169_1.time_ and arg_169_1.time_ < var_172_30 + var_172_40 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_30) / var_172_40

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_30 + var_172_40 and arg_169_1.time_ < var_172_30 + var_172_40 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play410161042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410161042
		arg_173_1.duration_ = 8.8

		local var_173_0 = {
			ja = 8.8,
			CriLanguages = 3.566,
			zh = 3.566
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
				arg_173_0:Play410161043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1061"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 2)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "split_1" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(-390, -490, 18)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_176_7 = arg_173_1.actors_["1061"]
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_9 = 0.034

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 and not isNil(var_176_7) then
				local var_176_10 = (arg_173_1.time_ - var_176_8) / var_176_9

				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								local var_176_11 = Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, var_176_10)
								local var_176_12 = Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, var_176_10)
								local var_176_13 = Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, var_176_10)

								iter_176_2.color = Color.New(var_176_11, var_176_12, var_176_13)
							else
								local var_176_14 = Mathf.Lerp(iter_176_2.color.r, 1, var_176_10)

								iter_176_2.color = Color.New(var_176_14, var_176_14, var_176_14)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						if arg_173_1.isInRecall_ then
							iter_176_4.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_15 = arg_173_1.actors_["10059"]
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10059 == nil then
				arg_173_1.var_.actorSpriteComps10059 = var_176_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_17 = 0.034

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 and not isNil(var_176_15) then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17

				if arg_173_1.var_.actorSpriteComps10059 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								local var_176_19 = Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, var_176_18)
								local var_176_20 = Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, var_176_18)
								local var_176_21 = Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, var_176_18)

								iter_176_6.color = Color.New(var_176_19, var_176_20, var_176_21)
							else
								local var_176_22 = Mathf.Lerp(iter_176_6.color.r, 0.5, var_176_18)

								iter_176_6.color = Color.New(var_176_22, var_176_22, var_176_22)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10059 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_176_8 then
						if arg_173_1.isInRecall_ then
							iter_176_8.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10059 = nil
			end

			local var_176_23 = 0
			local var_176_24 = 0.425

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_25 = arg_173_1:FormatText(StoryNameCfg[612].name)

				arg_173_1.leftNameTxt_.text = var_176_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(410161042)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 17
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_24 or var_176_24 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_24 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161042", "story_v_out_410161.awb") ~= 0 then
					local var_176_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161042", "story_v_out_410161.awb") / 1000

					if var_176_31 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_31 + var_176_23
					end

					if var_176_26.prefab_name ~= "" and arg_173_1.actors_[var_176_26.prefab_name] ~= nil then
						local var_176_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_26.prefab_name].transform, "story_v_out_410161", "410161042", "story_v_out_410161.awb")

						arg_173_1:RecordAudio("410161042", var_176_32)
						arg_173_1:RecordAudio("410161042", var_176_32)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410161", "410161042", "story_v_out_410161.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410161", "410161042", "story_v_out_410161.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_33 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_33 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_23) / var_176_33

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_23 + var_176_33 and arg_173_1.time_ < var_176_23 + var_176_33 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410161043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410161043
		arg_177_1.duration_ = 11.03

		local var_177_0 = {
			ja = 11.033,
			CriLanguages = 7.3,
			zh = 7.3
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
				arg_177_0:Play410161044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10059"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10059 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10059", 2)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_2" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(-390, -530, 35)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10059, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_180_7 = arg_177_1.actors_["1061"].transform
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.var_.moveOldPos1061 = var_180_7.localPosition
				var_180_7.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1061", 7)

				local var_180_9 = var_180_7.childCount

				for iter_180_1 = 0, var_180_9 - 1 do
					local var_180_10 = var_180_7:GetChild(iter_180_1)

					if var_180_10.name == "" or not string.find(var_180_10.name, "split") then
						var_180_10.gameObject:SetActive(true)
					else
						var_180_10.gameObject:SetActive(false)
					end
				end
			end

			local var_180_11 = 0.001

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_11 then
				local var_180_12 = (arg_177_1.time_ - var_180_8) / var_180_11
				local var_180_13 = Vector3.New(0, -2000, 18)

				var_180_7.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1061, var_180_13, var_180_12)
			end

			if arg_177_1.time_ >= var_180_8 + var_180_11 and arg_177_1.time_ < var_180_8 + var_180_11 + arg_180_0 then
				var_180_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_180_14 = arg_177_1.actors_["10059"]
			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.actorSpriteComps10059 == nil then
				arg_177_1.var_.actorSpriteComps10059 = var_180_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_16 = 0.034

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_16 and not isNil(var_180_14) then
				local var_180_17 = (arg_177_1.time_ - var_180_15) / var_180_16

				if arg_177_1.var_.actorSpriteComps10059 then
					for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_180_3 then
							if arg_177_1.isInRecall_ then
								local var_180_18 = Mathf.Lerp(iter_180_3.color.r, arg_177_1.hightColor1.r, var_180_17)
								local var_180_19 = Mathf.Lerp(iter_180_3.color.g, arg_177_1.hightColor1.g, var_180_17)
								local var_180_20 = Mathf.Lerp(iter_180_3.color.b, arg_177_1.hightColor1.b, var_180_17)

								iter_180_3.color = Color.New(var_180_18, var_180_19, var_180_20)
							else
								local var_180_21 = Mathf.Lerp(iter_180_3.color.r, 1, var_180_17)

								iter_180_3.color = Color.New(var_180_21, var_180_21, var_180_21)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_15 + var_180_16 and arg_177_1.time_ < var_180_15 + var_180_16 + arg_180_0 and not isNil(var_180_14) and arg_177_1.var_.actorSpriteComps10059 then
				for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_180_5 then
						if arg_177_1.isInRecall_ then
							iter_180_5.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10059 = nil
			end

			local var_180_22 = arg_177_1.actors_["1061"]
			local var_180_23 = 0

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 and not isNil(var_180_22) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_24 = 0.034

			if var_180_23 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_24 and not isNil(var_180_22) then
				local var_180_25 = (arg_177_1.time_ - var_180_23) / var_180_24

				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_7 then
							if arg_177_1.isInRecall_ then
								local var_180_26 = Mathf.Lerp(iter_180_7.color.r, arg_177_1.hightColor2.r, var_180_25)
								local var_180_27 = Mathf.Lerp(iter_180_7.color.g, arg_177_1.hightColor2.g, var_180_25)
								local var_180_28 = Mathf.Lerp(iter_180_7.color.b, arg_177_1.hightColor2.b, var_180_25)

								iter_180_7.color = Color.New(var_180_26, var_180_27, var_180_28)
							else
								local var_180_29 = Mathf.Lerp(iter_180_7.color.r, 0.5, var_180_25)

								iter_180_7.color = Color.New(var_180_29, var_180_29, var_180_29)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_23 + var_180_24 and arg_177_1.time_ < var_180_23 + var_180_24 + arg_180_0 and not isNil(var_180_22) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_8, iter_180_9 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_9 then
						if arg_177_1.isInRecall_ then
							iter_180_9.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_30 = 0
			local var_180_31 = 0.675

			if var_180_30 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_32 = arg_177_1:FormatText(StoryNameCfg[596].name)

				arg_177_1.leftNameTxt_.text = var_180_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_33 = arg_177_1:GetWordFromCfg(410161043)
				local var_180_34 = arg_177_1:FormatText(var_180_33.content)

				arg_177_1.text_.text = var_180_34

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_35 = 27
				local var_180_36 = utf8.len(var_180_34)
				local var_180_37 = var_180_35 <= 0 and var_180_31 or var_180_31 * (var_180_36 / var_180_35)

				if var_180_37 > 0 and var_180_31 < var_180_37 then
					arg_177_1.talkMaxDuration = var_180_37

					if var_180_37 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_37 + var_180_30
					end
				end

				arg_177_1.text_.text = var_180_34
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161043", "story_v_out_410161.awb") ~= 0 then
					local var_180_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161043", "story_v_out_410161.awb") / 1000

					if var_180_38 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_38 + var_180_30
					end

					if var_180_33.prefab_name ~= "" and arg_177_1.actors_[var_180_33.prefab_name] ~= nil then
						local var_180_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_33.prefab_name].transform, "story_v_out_410161", "410161043", "story_v_out_410161.awb")

						arg_177_1:RecordAudio("410161043", var_180_39)
						arg_177_1:RecordAudio("410161043", var_180_39)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410161", "410161043", "story_v_out_410161.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410161", "410161043", "story_v_out_410161.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_40 = math.max(var_180_31, arg_177_1.talkMaxDuration)

			if var_180_30 <= arg_177_1.time_ and arg_177_1.time_ < var_180_30 + var_180_40 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_30) / var_180_40

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_30 + var_180_40 and arg_177_1.time_ < var_180_30 + var_180_40 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play410161044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410161044
		arg_181_1.duration_ = 5.9

		local var_181_0 = {
			ja = 5.9,
			CriLanguages = 2.733,
			zh = 2.733
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410161045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10062"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10062 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10062", 4)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(370, -390, -290)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10062, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_184_7 = arg_181_1.actors_["10062"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10062 == nil then
				arg_181_1.var_.actorSpriteComps10062 = var_184_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.034

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.actorSpriteComps10062 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								local var_184_11 = Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, var_184_10)
								local var_184_12 = Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, var_184_10)
								local var_184_13 = Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, var_184_10)

								iter_184_2.color = Color.New(var_184_11, var_184_12, var_184_13)
							else
								local var_184_14 = Mathf.Lerp(iter_184_2.color.r, 1, var_184_10)

								iter_184_2.color = Color.New(var_184_14, var_184_14, var_184_14)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10062 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_184_4 then
						if arg_181_1.isInRecall_ then
							iter_184_4.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10062 = nil
			end

			local var_184_15 = arg_181_1.actors_["10059"]
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.actorSpriteComps10059 == nil then
				arg_181_1.var_.actorSpriteComps10059 = var_184_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_17 = 0.034

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 and not isNil(var_184_15) then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17

				if arg_181_1.var_.actorSpriteComps10059 then
					for iter_184_5, iter_184_6 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_184_6 then
							if arg_181_1.isInRecall_ then
								local var_184_19 = Mathf.Lerp(iter_184_6.color.r, arg_181_1.hightColor2.r, var_184_18)
								local var_184_20 = Mathf.Lerp(iter_184_6.color.g, arg_181_1.hightColor2.g, var_184_18)
								local var_184_21 = Mathf.Lerp(iter_184_6.color.b, arg_181_1.hightColor2.b, var_184_18)

								iter_184_6.color = Color.New(var_184_19, var_184_20, var_184_21)
							else
								local var_184_22 = Mathf.Lerp(iter_184_6.color.r, 0.5, var_184_18)

								iter_184_6.color = Color.New(var_184_22, var_184_22, var_184_22)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.actorSpriteComps10059 then
				for iter_184_7, iter_184_8 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_184_8 then
						if arg_181_1.isInRecall_ then
							iter_184_8.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10059 = nil
			end

			local var_184_23 = 0
			local var_184_24 = 0.275

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[600].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(410161044)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 11
				local var_184_29 = utf8.len(var_184_27)
				local var_184_30 = var_184_28 <= 0 and var_184_24 or var_184_24 * (var_184_29 / var_184_28)

				if var_184_30 > 0 and var_184_24 < var_184_30 then
					arg_181_1.talkMaxDuration = var_184_30

					if var_184_30 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_30 + var_184_23
					end
				end

				arg_181_1.text_.text = var_184_27
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161044", "story_v_out_410161.awb") ~= 0 then
					local var_184_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161044", "story_v_out_410161.awb") / 1000

					if var_184_31 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_23
					end

					if var_184_26.prefab_name ~= "" and arg_181_1.actors_[var_184_26.prefab_name] ~= nil then
						local var_184_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_26.prefab_name].transform, "story_v_out_410161", "410161044", "story_v_out_410161.awb")

						arg_181_1:RecordAudio("410161044", var_184_32)
						arg_181_1:RecordAudio("410161044", var_184_32)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410161", "410161044", "story_v_out_410161.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410161", "410161044", "story_v_out_410161.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_33 = math.max(var_184_24, arg_181_1.talkMaxDuration)

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_33 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_23) / var_184_33

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_23 + var_184_33 and arg_181_1.time_ < var_184_23 + var_184_33 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play410161045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410161045
		arg_185_1.duration_ = 6.27

		local var_185_0 = {
			ja = 6.266,
			CriLanguages = 5.433,
			zh = 5.433
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410161046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10059"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10059 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10059", 2)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(-390, -530, 35)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10059, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_188_7 = arg_185_1.actors_["10059"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10059 == nil then
				arg_185_1.var_.actorSpriteComps10059 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps10059 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 1, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10059 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10059 = nil
			end

			local var_188_15 = arg_185_1.actors_["10062"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10062 == nil then
				arg_185_1.var_.actorSpriteComps10062 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps10062 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								local var_188_19 = Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, var_188_18)
								local var_188_20 = Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, var_188_18)
								local var_188_21 = Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, var_188_18)

								iter_188_6.color = Color.New(var_188_19, var_188_20, var_188_21)
							else
								local var_188_22 = Mathf.Lerp(iter_188_6.color.r, 0.5, var_188_18)

								iter_188_6.color = Color.New(var_188_22, var_188_22, var_188_22)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10062 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10062 = nil
			end

			local var_188_23 = 0
			local var_188_24 = 0.7

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[596].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(410161045)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 28
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161045", "story_v_out_410161.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161045", "story_v_out_410161.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_410161", "410161045", "story_v_out_410161.awb")

						arg_185_1:RecordAudio("410161045", var_188_32)
						arg_185_1:RecordAudio("410161045", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410161", "410161045", "story_v_out_410161.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410161", "410161045", "story_v_out_410161.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410161046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410161046
		arg_189_1.duration_ = 11.87

		local var_189_0 = {
			ja = 11.866,
			CriLanguages = 5.166,
			zh = 5.166
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410161047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10059"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10059 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10059", 2)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(-390, -530, 35)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10059, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_192_7 = arg_189_1.actors_["10059"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10059 == nil then
				arg_189_1.var_.actorSpriteComps10059 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10059 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10059 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10059 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.7

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[596].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(410161046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 28
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161046", "story_v_out_410161.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161046", "story_v_out_410161.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_410161", "410161046", "story_v_out_410161.awb")

						arg_189_1:RecordAudio("410161046", var_192_24)
						arg_189_1:RecordAudio("410161046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410161", "410161046", "story_v_out_410161.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410161", "410161046", "story_v_out_410161.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play410161047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410161047
		arg_193_1.duration_ = 5.2

		local var_193_0 = {
			ja = 5.2,
			CriLanguages = 2.733,
			zh = 2.733
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410161048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10062"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10062 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10062", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_3" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(370, -390, -290)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10062, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_196_7 = arg_193_1.actors_["10062"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10062 == nil then
				arg_193_1.var_.actorSpriteComps10062 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10062 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10062 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10062 = nil
			end

			local var_196_15 = arg_193_1.actors_["10059"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10059 == nil then
				arg_193_1.var_.actorSpriteComps10059 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_17 = 0.034

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.actorSpriteComps10059 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								local var_196_19 = Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, var_196_18)
								local var_196_20 = Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, var_196_18)
								local var_196_21 = Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, var_196_18)

								iter_196_6.color = Color.New(var_196_19, var_196_20, var_196_21)
							else
								local var_196_22 = Mathf.Lerp(iter_196_6.color.r, 0.5, var_196_18)

								iter_196_6.color = Color.New(var_196_22, var_196_22, var_196_22)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10059 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_196_8 then
						if arg_193_1.isInRecall_ then
							iter_196_8.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10059 = nil
			end

			local var_196_23 = 0
			local var_196_24 = 0.25

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[600].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(410161047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 10
				local var_196_29 = utf8.len(var_196_27)
				local var_196_30 = var_196_28 <= 0 and var_196_24 or var_196_24 * (var_196_29 / var_196_28)

				if var_196_30 > 0 and var_196_24 < var_196_30 then
					arg_193_1.talkMaxDuration = var_196_30

					if var_196_30 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_30 + var_196_23
					end
				end

				arg_193_1.text_.text = var_196_27
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161047", "story_v_out_410161.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161047", "story_v_out_410161.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_410161", "410161047", "story_v_out_410161.awb")

						arg_193_1:RecordAudio("410161047", var_196_32)
						arg_193_1:RecordAudio("410161047", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410161", "410161047", "story_v_out_410161.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410161", "410161047", "story_v_out_410161.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_33 = math.max(var_196_24, arg_193_1.talkMaxDuration)

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_33 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_23) / var_196_33

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_23 + var_196_33 and arg_193_1.time_ < var_196_23 + var_196_33 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play410161048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410161048
		arg_197_1.duration_ = 7.33

		local var_197_0 = {
			ja = 7.333,
			CriLanguages = 3.766,
			zh = 3.766
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410161049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10059"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10059 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10059", 2)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_3" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(-390, -530, 35)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10059, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_200_7 = arg_197_1.actors_["10059"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10059 == nil then
				arg_197_1.var_.actorSpriteComps10059 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps10059 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10059 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10059 = nil
			end

			local var_200_15 = arg_197_1.actors_["10062"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10062 == nil then
				arg_197_1.var_.actorSpriteComps10062 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 0.034

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps10062 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 0.5, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10062 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10062 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.375

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[596].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(410161048)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 15
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161048", "story_v_out_410161.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161048", "story_v_out_410161.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_410161", "410161048", "story_v_out_410161.awb")

						arg_197_1:RecordAudio("410161048", var_200_32)
						arg_197_1:RecordAudio("410161048", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410161", "410161048", "story_v_out_410161.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410161", "410161048", "story_v_out_410161.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410161049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410161049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410161050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10062"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10062 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10062", 3)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(0, -390, -290)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10062, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_204_7 = arg_201_1.actors_["10059"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos10059 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10059", 7)

				local var_204_9 = var_204_7.childCount

				for iter_204_1 = 0, var_204_9 - 1 do
					local var_204_10 = var_204_7:GetChild(iter_204_1)

					if var_204_10.name == "" or not string.find(var_204_10.name, "split") then
						var_204_10.gameObject:SetActive(true)
					else
						var_204_10.gameObject:SetActive(false)
					end
				end
			end

			local var_204_11 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_8) / var_204_11
				local var_204_13 = Vector3.New(0, -2000, 35)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10059, var_204_13, var_204_12)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_11 and arg_201_1.time_ < var_204_8 + var_204_11 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_204_14 = arg_201_1.actors_["10062"]
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10062 == nil then
				arg_201_1.var_.actorSpriteComps10062 = var_204_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_16 = 0.034

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_16 and not isNil(var_204_14) then
				local var_204_17 = (arg_201_1.time_ - var_204_15) / var_204_16

				if arg_201_1.var_.actorSpriteComps10062 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								local var_204_18 = Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor2.r, var_204_17)
								local var_204_19 = Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor2.g, var_204_17)
								local var_204_20 = Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor2.b, var_204_17)

								iter_204_3.color = Color.New(var_204_18, var_204_19, var_204_20)
							else
								local var_204_21 = Mathf.Lerp(iter_204_3.color.r, 0.5, var_204_17)

								iter_204_3.color = Color.New(var_204_21, var_204_21, var_204_21)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_15 + var_204_16 and arg_201_1.time_ < var_204_15 + var_204_16 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10062 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_204_5 then
						if arg_201_1.isInRecall_ then
							iter_204_5.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10062 = nil
			end

			local var_204_22 = arg_201_1.actors_["10059"]
			local var_204_23 = 0

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps10059 == nil then
				arg_201_1.var_.actorSpriteComps10059 = var_204_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_24 = 0.034

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 and not isNil(var_204_22) then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24

				if arg_201_1.var_.actorSpriteComps10059 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								local var_204_26 = Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor2.r, var_204_25)
								local var_204_27 = Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor2.g, var_204_25)
								local var_204_28 = Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor2.b, var_204_25)

								iter_204_7.color = Color.New(var_204_26, var_204_27, var_204_28)
							else
								local var_204_29 = Mathf.Lerp(iter_204_7.color.r, 0.5, var_204_25)

								iter_204_7.color = Color.New(var_204_29, var_204_29, var_204_29)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps10059 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_204_9 then
						if arg_201_1.isInRecall_ then
							iter_204_9.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10059 = nil
			end

			local var_204_30 = 0
			local var_204_31 = 0.8

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_32 = arg_201_1:GetWordFromCfg(410161049)
				local var_204_33 = arg_201_1:FormatText(var_204_32.content)

				arg_201_1.text_.text = var_204_33

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_34 = 32
				local var_204_35 = utf8.len(var_204_33)
				local var_204_36 = var_204_34 <= 0 and var_204_31 or var_204_31 * (var_204_35 / var_204_34)

				if var_204_36 > 0 and var_204_31 < var_204_36 then
					arg_201_1.talkMaxDuration = var_204_36

					if var_204_36 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_36 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_33
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_37 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_37 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_37

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_37 and arg_201_1.time_ < var_204_30 + var_204_37 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410161050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410161050
		arg_205_1.duration_ = 15.33

		local var_205_0 = {
			ja = 14.3,
			CriLanguages = 15.333,
			zh = 15.333
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410161051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10062"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10062 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10062", 3)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_1_1" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(0, -390, -290)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10062, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_208_7 = arg_205_1.actors_["10062"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10062 == nil then
				arg_205_1.var_.actorSpriteComps10062 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps10062 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10062 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10062 = nil
			end

			local var_208_15 = 0
			local var_208_16 = 1.325

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[600].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(410161050)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 53
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161050", "story_v_out_410161.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161050", "story_v_out_410161.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_410161", "410161050", "story_v_out_410161.awb")

						arg_205_1:RecordAudio("410161050", var_208_24)
						arg_205_1:RecordAudio("410161050", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410161", "410161050", "story_v_out_410161.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410161", "410161050", "story_v_out_410161.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play410161051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410161051
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410161052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "L04f"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 2

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.L04f

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
					if iter_212_0 ~= "L04f" then
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
				local var_212_19 = Color.New(0, 0, 0)

				var_212_19.a = Mathf.Lerp(0, 1, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(0, 0, 0)

				var_212_20.a = 1
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_21 = 2

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_22 = 2

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_22 then
				local var_212_23 = (arg_209_1.time_ - var_212_21) / var_212_22
				local var_212_24 = Color.New(0, 0, 0)

				var_212_24.a = Mathf.Lerp(1, 0, var_212_23)
				arg_209_1.mask_.color = var_212_24
			end

			if arg_209_1.time_ >= var_212_21 + var_212_22 and arg_209_1.time_ < var_212_21 + var_212_22 + arg_212_0 then
				local var_212_25 = Color.New(0, 0, 0)
				local var_212_26 = 0

				arg_209_1.mask_.enabled = false
				var_212_25.a = var_212_26
				arg_209_1.mask_.color = var_212_25
			end

			local var_212_27 = arg_209_1.actors_["10062"].transform
			local var_212_28 = 2

			if var_212_28 < arg_209_1.time_ and arg_209_1.time_ <= var_212_28 + arg_212_0 then
				arg_209_1.var_.moveOldPos10062 = var_212_27.localPosition
				var_212_27.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10062", 7)

				local var_212_29 = var_212_27.childCount

				for iter_212_2 = 0, var_212_29 - 1 do
					local var_212_30 = var_212_27:GetChild(iter_212_2)

					if var_212_30.name == "" or not string.find(var_212_30.name, "split") then
						var_212_30.gameObject:SetActive(true)
					else
						var_212_30.gameObject:SetActive(false)
					end
				end
			end

			local var_212_31 = 0.001

			if var_212_28 <= arg_209_1.time_ and arg_209_1.time_ < var_212_28 + var_212_31 then
				local var_212_32 = (arg_209_1.time_ - var_212_28) / var_212_31
				local var_212_33 = Vector3.New(0, -2000, -290)

				var_212_27.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10062, var_212_33, var_212_32)
			end

			if arg_209_1.time_ >= var_212_28 + var_212_31 and arg_209_1.time_ < var_212_28 + var_212_31 + arg_212_0 then
				var_212_27.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_212_34 = arg_209_1.actors_["10062"]
			local var_212_35 = 2

			if var_212_35 < arg_209_1.time_ and arg_209_1.time_ <= var_212_35 + arg_212_0 and not isNil(var_212_34) and arg_209_1.var_.actorSpriteComps10062 == nil then
				arg_209_1.var_.actorSpriteComps10062 = var_212_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_36 = 0.034

			if var_212_35 <= arg_209_1.time_ and arg_209_1.time_ < var_212_35 + var_212_36 and not isNil(var_212_34) then
				local var_212_37 = (arg_209_1.time_ - var_212_35) / var_212_36

				if arg_209_1.var_.actorSpriteComps10062 then
					for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_212_4 then
							if arg_209_1.isInRecall_ then
								local var_212_38 = Mathf.Lerp(iter_212_4.color.r, arg_209_1.hightColor2.r, var_212_37)
								local var_212_39 = Mathf.Lerp(iter_212_4.color.g, arg_209_1.hightColor2.g, var_212_37)
								local var_212_40 = Mathf.Lerp(iter_212_4.color.b, arg_209_1.hightColor2.b, var_212_37)

								iter_212_4.color = Color.New(var_212_38, var_212_39, var_212_40)
							else
								local var_212_41 = Mathf.Lerp(iter_212_4.color.r, 0.5, var_212_37)

								iter_212_4.color = Color.New(var_212_41, var_212_41, var_212_41)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_35 + var_212_36 and arg_209_1.time_ < var_212_35 + var_212_36 + arg_212_0 and not isNil(var_212_34) and arg_209_1.var_.actorSpriteComps10062 then
				for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_212_6 then
						if arg_209_1.isInRecall_ then
							iter_212_6.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10062 = nil
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_42 = 4
			local var_212_43 = 0.825

			if var_212_42 < arg_209_1.time_ and arg_209_1.time_ <= var_212_42 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_44 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_44:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_45 = arg_209_1:GetWordFromCfg(410161051)
				local var_212_46 = arg_209_1:FormatText(var_212_45.content)

				arg_209_1.text_.text = var_212_46

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_47 = 33
				local var_212_48 = utf8.len(var_212_46)
				local var_212_49 = var_212_47 <= 0 and var_212_43 or var_212_43 * (var_212_48 / var_212_47)

				if var_212_49 > 0 and var_212_43 < var_212_49 then
					arg_209_1.talkMaxDuration = var_212_49
					var_212_42 = var_212_42 + 0.3

					if var_212_49 + var_212_42 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_49 + var_212_42
					end
				end

				arg_209_1.text_.text = var_212_46
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_50 = var_212_42 + 0.3
			local var_212_51 = math.max(var_212_43, arg_209_1.talkMaxDuration)

			if var_212_50 <= arg_209_1.time_ and arg_209_1.time_ < var_212_50 + var_212_51 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_50) / var_212_51

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_50 + var_212_51 and arg_209_1.time_ < var_212_50 + var_212_51 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play410161052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410161052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play410161053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.1

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(410161052)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 44
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play410161053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410161053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410161054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.325

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(410161053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 53
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play410161054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410161054
		arg_223_1.duration_ = 2.9

		local var_223_0 = {
			ja = 1.566,
			CriLanguages = 2.9,
			zh = 2.9
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
				arg_223_0:Play410161055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10059"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10059 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10059", 4)

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
				local var_226_6 = Vector3.New(390, -530, 35)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10059, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_226_7 = arg_223_1.actors_["1061"].transform
			local var_226_8 = 0

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.var_.moveOldPos1061 = var_226_7.localPosition
				var_226_7.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1061", 2)

				local var_226_9 = var_226_7.childCount

				for iter_226_1 = 0, var_226_9 - 1 do
					local var_226_10 = var_226_7:GetChild(iter_226_1)

					if var_226_10.name == "" or not string.find(var_226_10.name, "split") then
						var_226_10.gameObject:SetActive(true)
					else
						var_226_10.gameObject:SetActive(false)
					end
				end
			end

			local var_226_11 = 0.001

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_11 then
				local var_226_12 = (arg_223_1.time_ - var_226_8) / var_226_11
				local var_226_13 = Vector3.New(-390, -490, 18)

				var_226_7.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1061, var_226_13, var_226_12)
			end

			if arg_223_1.time_ >= var_226_8 + var_226_11 and arg_223_1.time_ < var_226_8 + var_226_11 + arg_226_0 then
				var_226_7.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_226_14 = arg_223_1.actors_["10059"]
			local var_226_15 = 0

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 and not isNil(var_226_14) and arg_223_1.var_.actorSpriteComps10059 == nil then
				arg_223_1.var_.actorSpriteComps10059 = var_226_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_16 = 0.034

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_16 and not isNil(var_226_14) then
				local var_226_17 = (arg_223_1.time_ - var_226_15) / var_226_16

				if arg_223_1.var_.actorSpriteComps10059 then
					for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_226_3 then
							if arg_223_1.isInRecall_ then
								local var_226_18 = Mathf.Lerp(iter_226_3.color.r, arg_223_1.hightColor1.r, var_226_17)
								local var_226_19 = Mathf.Lerp(iter_226_3.color.g, arg_223_1.hightColor1.g, var_226_17)
								local var_226_20 = Mathf.Lerp(iter_226_3.color.b, arg_223_1.hightColor1.b, var_226_17)

								iter_226_3.color = Color.New(var_226_18, var_226_19, var_226_20)
							else
								local var_226_21 = Mathf.Lerp(iter_226_3.color.r, 1, var_226_17)

								iter_226_3.color = Color.New(var_226_21, var_226_21, var_226_21)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_15 + var_226_16 and arg_223_1.time_ < var_226_15 + var_226_16 + arg_226_0 and not isNil(var_226_14) and arg_223_1.var_.actorSpriteComps10059 then
				for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_226_5 then
						if arg_223_1.isInRecall_ then
							iter_226_5.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10059 = nil
			end

			local var_226_22 = arg_223_1.actors_["1061"]
			local var_226_23 = 0

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 and not isNil(var_226_22) and arg_223_1.var_.actorSpriteComps1061 == nil then
				arg_223_1.var_.actorSpriteComps1061 = var_226_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_24 = 0.034

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_24 and not isNil(var_226_22) then
				local var_226_25 = (arg_223_1.time_ - var_226_23) / var_226_24

				if arg_223_1.var_.actorSpriteComps1061 then
					for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_226_7 then
							if arg_223_1.isInRecall_ then
								local var_226_26 = Mathf.Lerp(iter_226_7.color.r, arg_223_1.hightColor2.r, var_226_25)
								local var_226_27 = Mathf.Lerp(iter_226_7.color.g, arg_223_1.hightColor2.g, var_226_25)
								local var_226_28 = Mathf.Lerp(iter_226_7.color.b, arg_223_1.hightColor2.b, var_226_25)

								iter_226_7.color = Color.New(var_226_26, var_226_27, var_226_28)
							else
								local var_226_29 = Mathf.Lerp(iter_226_7.color.r, 0.5, var_226_25)

								iter_226_7.color = Color.New(var_226_29, var_226_29, var_226_29)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_23 + var_226_24 and arg_223_1.time_ < var_226_23 + var_226_24 + arg_226_0 and not isNil(var_226_22) and arg_223_1.var_.actorSpriteComps1061 then
				for iter_226_8, iter_226_9 in pairs(arg_223_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_226_9 then
						if arg_223_1.isInRecall_ then
							iter_226_9.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1061 = nil
			end

			local var_226_30 = 0
			local var_226_31 = 0.325

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_32 = arg_223_1:FormatText(StoryNameCfg[596].name)

				arg_223_1.leftNameTxt_.text = var_226_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_33 = arg_223_1:GetWordFromCfg(410161054)
				local var_226_34 = arg_223_1:FormatText(var_226_33.content)

				arg_223_1.text_.text = var_226_34

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_35 = 13
				local var_226_36 = utf8.len(var_226_34)
				local var_226_37 = var_226_35 <= 0 and var_226_31 or var_226_31 * (var_226_36 / var_226_35)

				if var_226_37 > 0 and var_226_31 < var_226_37 then
					arg_223_1.talkMaxDuration = var_226_37

					if var_226_37 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_37 + var_226_30
					end
				end

				arg_223_1.text_.text = var_226_34
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161054", "story_v_out_410161.awb") ~= 0 then
					local var_226_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161054", "story_v_out_410161.awb") / 1000

					if var_226_38 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_30
					end

					if var_226_33.prefab_name ~= "" and arg_223_1.actors_[var_226_33.prefab_name] ~= nil then
						local var_226_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_33.prefab_name].transform, "story_v_out_410161", "410161054", "story_v_out_410161.awb")

						arg_223_1:RecordAudio("410161054", var_226_39)
						arg_223_1:RecordAudio("410161054", var_226_39)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410161", "410161054", "story_v_out_410161.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410161", "410161054", "story_v_out_410161.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_40 = math.max(var_226_31, arg_223_1.talkMaxDuration)

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_40 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_40

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_40 and arg_223_1.time_ < var_226_30 + var_226_40 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410161055
		arg_227_1.duration_ = 9.97

		local var_227_0 = {
			ja = 9.966,
			CriLanguages = 6.033,
			zh = 6.033
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
				arg_227_0:Play410161056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1061"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1061 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1061", 2)

				local var_230_2 = var_230_0.childCount

				for iter_230_0 = 0, var_230_2 - 1 do
					local var_230_3 = var_230_0:GetChild(iter_230_0)

					if var_230_3.name == "split_5" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_4 then
				local var_230_5 = (arg_227_1.time_ - var_230_1) / var_230_4
				local var_230_6 = Vector3.New(-390, -490, 18)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1061, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_230_7 = arg_227_1.actors_["1061"]
			local var_230_8 = 0

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1061 == nil then
				arg_227_1.var_.actorSpriteComps1061 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_9 = 0.034

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 and not isNil(var_230_7) then
				local var_230_10 = (arg_227_1.time_ - var_230_8) / var_230_9

				if arg_227_1.var_.actorSpriteComps1061 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_11 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, var_230_10)
								local var_230_12 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, var_230_10)
								local var_230_13 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, var_230_10)

								iter_230_2.color = Color.New(var_230_11, var_230_12, var_230_13)
							else
								local var_230_14 = Mathf.Lerp(iter_230_2.color.r, 1, var_230_10)

								iter_230_2.color = Color.New(var_230_14, var_230_14, var_230_14)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1061 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1061 = nil
			end

			local var_230_15 = arg_227_1.actors_["10059"]
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps10059 == nil then
				arg_227_1.var_.actorSpriteComps10059 = var_230_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_17 = 0.034

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 and not isNil(var_230_15) then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17

				if arg_227_1.var_.actorSpriteComps10059 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								local var_230_19 = Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor2.r, var_230_18)
								local var_230_20 = Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor2.g, var_230_18)
								local var_230_21 = Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor2.b, var_230_18)

								iter_230_6.color = Color.New(var_230_19, var_230_20, var_230_21)
							else
								local var_230_22 = Mathf.Lerp(iter_230_6.color.r, 0.5, var_230_18)

								iter_230_6.color = Color.New(var_230_22, var_230_22, var_230_22)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps10059 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_230_8 then
						if arg_227_1.isInRecall_ then
							iter_230_8.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10059 = nil
			end

			local var_230_23 = 0
			local var_230_24 = 0.55

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_25 = arg_227_1:FormatText(StoryNameCfg[612].name)

				arg_227_1.leftNameTxt_.text = var_230_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_26 = arg_227_1:GetWordFromCfg(410161055)
				local var_230_27 = arg_227_1:FormatText(var_230_26.content)

				arg_227_1.text_.text = var_230_27

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_28 = 22
				local var_230_29 = utf8.len(var_230_27)
				local var_230_30 = var_230_28 <= 0 and var_230_24 or var_230_24 * (var_230_29 / var_230_28)

				if var_230_30 > 0 and var_230_24 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30

					if var_230_30 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_23
					end
				end

				arg_227_1.text_.text = var_230_27
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161055", "story_v_out_410161.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161055", "story_v_out_410161.awb") / 1000

					if var_230_31 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_23
					end

					if var_230_26.prefab_name ~= "" and arg_227_1.actors_[var_230_26.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_26.prefab_name].transform, "story_v_out_410161", "410161055", "story_v_out_410161.awb")

						arg_227_1:RecordAudio("410161055", var_230_32)
						arg_227_1:RecordAudio("410161055", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410161", "410161055", "story_v_out_410161.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410161", "410161055", "story_v_out_410161.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_24, arg_227_1.talkMaxDuration)

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_23) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_23 + var_230_33 and arg_227_1.time_ < var_230_23 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410161056
		arg_231_1.duration_ = 7.8

		local var_231_0 = {
			ja = 7.8,
			CriLanguages = 7.233,
			zh = 7.233
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
				arg_231_0:Play410161057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10059"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10059 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10059", 4)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(390, -530, 35)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10059, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_234_7 = arg_231_1.actors_["10059"]
			local var_234_8 = 0

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10059 == nil then
				arg_231_1.var_.actorSpriteComps10059 = var_234_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_9 = 0.034

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 and not isNil(var_234_7) then
				local var_234_10 = (arg_231_1.time_ - var_234_8) / var_234_9

				if arg_231_1.var_.actorSpriteComps10059 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								local var_234_11 = Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor1.r, var_234_10)
								local var_234_12 = Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor1.g, var_234_10)
								local var_234_13 = Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor1.b, var_234_10)

								iter_234_2.color = Color.New(var_234_11, var_234_12, var_234_13)
							else
								local var_234_14 = Mathf.Lerp(iter_234_2.color.r, 1, var_234_10)

								iter_234_2.color = Color.New(var_234_14, var_234_14, var_234_14)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10059 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_234_4 then
						if arg_231_1.isInRecall_ then
							iter_234_4.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10059 = nil
			end

			local var_234_15 = arg_231_1.actors_["1061"]
			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.actorSpriteComps1061 == nil then
				arg_231_1.var_.actorSpriteComps1061 = var_234_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_17 = 0.034

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_17 and not isNil(var_234_15) then
				local var_234_18 = (arg_231_1.time_ - var_234_16) / var_234_17

				if arg_231_1.var_.actorSpriteComps1061 then
					for iter_234_5, iter_234_6 in pairs(arg_231_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_234_6 then
							if arg_231_1.isInRecall_ then
								local var_234_19 = Mathf.Lerp(iter_234_6.color.r, arg_231_1.hightColor2.r, var_234_18)
								local var_234_20 = Mathf.Lerp(iter_234_6.color.g, arg_231_1.hightColor2.g, var_234_18)
								local var_234_21 = Mathf.Lerp(iter_234_6.color.b, arg_231_1.hightColor2.b, var_234_18)

								iter_234_6.color = Color.New(var_234_19, var_234_20, var_234_21)
							else
								local var_234_22 = Mathf.Lerp(iter_234_6.color.r, 0.5, var_234_18)

								iter_234_6.color = Color.New(var_234_22, var_234_22, var_234_22)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_16 + var_234_17 and arg_231_1.time_ < var_234_16 + var_234_17 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.actorSpriteComps1061 then
				for iter_234_7, iter_234_8 in pairs(arg_231_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_234_8 then
						if arg_231_1.isInRecall_ then
							iter_234_8.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1061 = nil
			end

			local var_234_23 = 0
			local var_234_24 = 0.775

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[596].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(410161056)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 31
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_24 or var_234_24 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_24 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161056", "story_v_out_410161.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161056", "story_v_out_410161.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_410161", "410161056", "story_v_out_410161.awb")

						arg_231_1:RecordAudio("410161056", var_234_32)
						arg_231_1:RecordAudio("410161056", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_410161", "410161056", "story_v_out_410161.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_410161", "410161056", "story_v_out_410161.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_33 and arg_231_1.time_ < var_234_23 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play410161057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410161057
		arg_235_1.duration_ = 8.8

		local var_235_0 = {
			ja = 7.4,
			CriLanguages = 8.8,
			zh = 8.8
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
				arg_235_0:Play410161058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10059"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10059 = var_238_0.localPosition
				var_238_0.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10059", 4)

				local var_238_2 = var_238_0.childCount

				for iter_238_0 = 0, var_238_2 - 1 do
					local var_238_3 = var_238_0:GetChild(iter_238_0)

					if var_238_3.name == "" or not string.find(var_238_3.name, "split") then
						var_238_3.gameObject:SetActive(true)
					else
						var_238_3.gameObject:SetActive(false)
					end
				end
			end

			local var_238_4 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_4 then
				local var_238_5 = (arg_235_1.time_ - var_238_1) / var_238_4
				local var_238_6 = Vector3.New(390, -530, 35)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10059, var_238_6, var_238_5)
			end

			if arg_235_1.time_ >= var_238_1 + var_238_4 and arg_235_1.time_ < var_238_1 + var_238_4 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_238_7 = arg_235_1.actors_["10059"]
			local var_238_8 = 0

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps10059 == nil then
				arg_235_1.var_.actorSpriteComps10059 = var_238_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_9 = 0.034

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_9 and not isNil(var_238_7) then
				local var_238_10 = (arg_235_1.time_ - var_238_8) / var_238_9

				if arg_235_1.var_.actorSpriteComps10059 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								local var_238_11 = Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor1.r, var_238_10)
								local var_238_12 = Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor1.g, var_238_10)
								local var_238_13 = Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor1.b, var_238_10)

								iter_238_2.color = Color.New(var_238_11, var_238_12, var_238_13)
							else
								local var_238_14 = Mathf.Lerp(iter_238_2.color.r, 1, var_238_10)

								iter_238_2.color = Color.New(var_238_14, var_238_14, var_238_14)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_8 + var_238_9 and arg_235_1.time_ < var_238_8 + var_238_9 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps10059 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_238_4 then
						if arg_235_1.isInRecall_ then
							iter_238_4.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10059 = nil
			end

			local var_238_15 = 0
			local var_238_16 = 0.95

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_17 = arg_235_1:FormatText(StoryNameCfg[596].name)

				arg_235_1.leftNameTxt_.text = var_238_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_18 = arg_235_1:GetWordFromCfg(410161057)
				local var_238_19 = arg_235_1:FormatText(var_238_18.content)

				arg_235_1.text_.text = var_238_19

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_20 = 38
				local var_238_21 = utf8.len(var_238_19)
				local var_238_22 = var_238_20 <= 0 and var_238_16 or var_238_16 * (var_238_21 / var_238_20)

				if var_238_22 > 0 and var_238_16 < var_238_22 then
					arg_235_1.talkMaxDuration = var_238_22

					if var_238_22 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_22 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_19
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161057", "story_v_out_410161.awb") ~= 0 then
					local var_238_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161057", "story_v_out_410161.awb") / 1000

					if var_238_23 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_15
					end

					if var_238_18.prefab_name ~= "" and arg_235_1.actors_[var_238_18.prefab_name] ~= nil then
						local var_238_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_18.prefab_name].transform, "story_v_out_410161", "410161057", "story_v_out_410161.awb")

						arg_235_1:RecordAudio("410161057", var_238_24)
						arg_235_1:RecordAudio("410161057", var_238_24)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_410161", "410161057", "story_v_out_410161.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_410161", "410161057", "story_v_out_410161.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_25 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_25 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_25

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_25 and arg_235_1.time_ < var_238_15 + var_238_25 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play410161058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410161058
		arg_239_1.duration_ = 5.33

		local var_239_0 = {
			ja = 5.333,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_239_0:Play410161059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1061"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1061 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1061", 2)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "split_5" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(-390, -490, 18)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1061, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_242_7 = arg_239_1.actors_["1061"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1061 == nil then
				arg_239_1.var_.actorSpriteComps1061 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 0.034

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps1061 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1061 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1061 = nil
			end

			local var_242_15 = arg_239_1.actors_["10059"]
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 and not isNil(var_242_15) and arg_239_1.var_.actorSpriteComps10059 == nil then
				arg_239_1.var_.actorSpriteComps10059 = var_242_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_17 = 0.034

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 and not isNil(var_242_15) then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17

				if arg_239_1.var_.actorSpriteComps10059 then
					for iter_242_5, iter_242_6 in pairs(arg_239_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_242_6 then
							if arg_239_1.isInRecall_ then
								local var_242_19 = Mathf.Lerp(iter_242_6.color.r, arg_239_1.hightColor2.r, var_242_18)
								local var_242_20 = Mathf.Lerp(iter_242_6.color.g, arg_239_1.hightColor2.g, var_242_18)
								local var_242_21 = Mathf.Lerp(iter_242_6.color.b, arg_239_1.hightColor2.b, var_242_18)

								iter_242_6.color = Color.New(var_242_19, var_242_20, var_242_21)
							else
								local var_242_22 = Mathf.Lerp(iter_242_6.color.r, 0.5, var_242_18)

								iter_242_6.color = Color.New(var_242_22, var_242_22, var_242_22)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 and not isNil(var_242_15) and arg_239_1.var_.actorSpriteComps10059 then
				for iter_242_7, iter_242_8 in pairs(arg_239_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_242_8 then
						if arg_239_1.isInRecall_ then
							iter_242_8.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10059 = nil
			end

			local var_242_23 = 0
			local var_242_24 = 0.3

			if var_242_23 < arg_239_1.time_ and arg_239_1.time_ <= var_242_23 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_25 = arg_239_1:FormatText(StoryNameCfg[612].name)

				arg_239_1.leftNameTxt_.text = var_242_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_26 = arg_239_1:GetWordFromCfg(410161058)
				local var_242_27 = arg_239_1:FormatText(var_242_26.content)

				arg_239_1.text_.text = var_242_27

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_28 = 12
				local var_242_29 = utf8.len(var_242_27)
				local var_242_30 = var_242_28 <= 0 and var_242_24 or var_242_24 * (var_242_29 / var_242_28)

				if var_242_30 > 0 and var_242_24 < var_242_30 then
					arg_239_1.talkMaxDuration = var_242_30

					if var_242_30 + var_242_23 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_30 + var_242_23
					end
				end

				arg_239_1.text_.text = var_242_27
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161058", "story_v_out_410161.awb") ~= 0 then
					local var_242_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161058", "story_v_out_410161.awb") / 1000

					if var_242_31 + var_242_23 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_31 + var_242_23
					end

					if var_242_26.prefab_name ~= "" and arg_239_1.actors_[var_242_26.prefab_name] ~= nil then
						local var_242_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_26.prefab_name].transform, "story_v_out_410161", "410161058", "story_v_out_410161.awb")

						arg_239_1:RecordAudio("410161058", var_242_32)
						arg_239_1:RecordAudio("410161058", var_242_32)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_410161", "410161058", "story_v_out_410161.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_410161", "410161058", "story_v_out_410161.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_33 = math.max(var_242_24, arg_239_1.talkMaxDuration)

			if var_242_23 <= arg_239_1.time_ and arg_239_1.time_ < var_242_23 + var_242_33 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_23) / var_242_33

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_23 + var_242_33 and arg_239_1.time_ < var_242_23 + var_242_33 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410161059
		arg_243_1.duration_ = 2.97

		local var_243_0 = {
			ja = 2.933,
			CriLanguages = 2.966,
			zh = 2.966
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
				arg_243_0:Play410161060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10059"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos10059 = var_246_0.localPosition
				var_246_0.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10059", 4)

				local var_246_2 = var_246_0.childCount

				for iter_246_0 = 0, var_246_2 - 1 do
					local var_246_3 = var_246_0:GetChild(iter_246_0)

					if var_246_3.name == "" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_4 then
				local var_246_5 = (arg_243_1.time_ - var_246_1) / var_246_4
				local var_246_6 = Vector3.New(390, -530, 35)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10059, var_246_6, var_246_5)
			end

			if arg_243_1.time_ >= var_246_1 + var_246_4 and arg_243_1.time_ < var_246_1 + var_246_4 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_246_7 = arg_243_1.actors_["10059"]
			local var_246_8 = 0

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.actorSpriteComps10059 == nil then
				arg_243_1.var_.actorSpriteComps10059 = var_246_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_9 = 0.034

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_9 and not isNil(var_246_7) then
				local var_246_10 = (arg_243_1.time_ - var_246_8) / var_246_9

				if arg_243_1.var_.actorSpriteComps10059 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_246_2 then
							if arg_243_1.isInRecall_ then
								local var_246_11 = Mathf.Lerp(iter_246_2.color.r, arg_243_1.hightColor1.r, var_246_10)
								local var_246_12 = Mathf.Lerp(iter_246_2.color.g, arg_243_1.hightColor1.g, var_246_10)
								local var_246_13 = Mathf.Lerp(iter_246_2.color.b, arg_243_1.hightColor1.b, var_246_10)

								iter_246_2.color = Color.New(var_246_11, var_246_12, var_246_13)
							else
								local var_246_14 = Mathf.Lerp(iter_246_2.color.r, 1, var_246_10)

								iter_246_2.color = Color.New(var_246_14, var_246_14, var_246_14)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_8 + var_246_9 and arg_243_1.time_ < var_246_8 + var_246_9 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.actorSpriteComps10059 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_246_4 then
						if arg_243_1.isInRecall_ then
							iter_246_4.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10059 = nil
			end

			local var_246_15 = arg_243_1.actors_["1061"]
			local var_246_16 = 0

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 and not isNil(var_246_15) and arg_243_1.var_.actorSpriteComps1061 == nil then
				arg_243_1.var_.actorSpriteComps1061 = var_246_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_17 = 0.034

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 and not isNil(var_246_15) then
				local var_246_18 = (arg_243_1.time_ - var_246_16) / var_246_17

				if arg_243_1.var_.actorSpriteComps1061 then
					for iter_246_5, iter_246_6 in pairs(arg_243_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_246_6 then
							if arg_243_1.isInRecall_ then
								local var_246_19 = Mathf.Lerp(iter_246_6.color.r, arg_243_1.hightColor2.r, var_246_18)
								local var_246_20 = Mathf.Lerp(iter_246_6.color.g, arg_243_1.hightColor2.g, var_246_18)
								local var_246_21 = Mathf.Lerp(iter_246_6.color.b, arg_243_1.hightColor2.b, var_246_18)

								iter_246_6.color = Color.New(var_246_19, var_246_20, var_246_21)
							else
								local var_246_22 = Mathf.Lerp(iter_246_6.color.r, 0.5, var_246_18)

								iter_246_6.color = Color.New(var_246_22, var_246_22, var_246_22)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 and not isNil(var_246_15) and arg_243_1.var_.actorSpriteComps1061 then
				for iter_246_7, iter_246_8 in pairs(arg_243_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_246_8 then
						if arg_243_1.isInRecall_ then
							iter_246_8.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1061 = nil
			end

			local var_246_23 = 0
			local var_246_24 = 0.25

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_25 = arg_243_1:FormatText(StoryNameCfg[596].name)

				arg_243_1.leftNameTxt_.text = var_246_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_26 = arg_243_1:GetWordFromCfg(410161059)
				local var_246_27 = arg_243_1:FormatText(var_246_26.content)

				arg_243_1.text_.text = var_246_27

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_28 = 10
				local var_246_29 = utf8.len(var_246_27)
				local var_246_30 = var_246_28 <= 0 and var_246_24 or var_246_24 * (var_246_29 / var_246_28)

				if var_246_30 > 0 and var_246_24 < var_246_30 then
					arg_243_1.talkMaxDuration = var_246_30

					if var_246_30 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_30 + var_246_23
					end
				end

				arg_243_1.text_.text = var_246_27
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161059", "story_v_out_410161.awb") ~= 0 then
					local var_246_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161059", "story_v_out_410161.awb") / 1000

					if var_246_31 + var_246_23 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_31 + var_246_23
					end

					if var_246_26.prefab_name ~= "" and arg_243_1.actors_[var_246_26.prefab_name] ~= nil then
						local var_246_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_26.prefab_name].transform, "story_v_out_410161", "410161059", "story_v_out_410161.awb")

						arg_243_1:RecordAudio("410161059", var_246_32)
						arg_243_1:RecordAudio("410161059", var_246_32)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410161", "410161059", "story_v_out_410161.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410161", "410161059", "story_v_out_410161.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_33 = math.max(var_246_24, arg_243_1.talkMaxDuration)

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_33 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_23) / var_246_33

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_23 + var_246_33 and arg_243_1.time_ < var_246_23 + var_246_33 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play410161060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410161060
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play410161061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = "ST62"

			if arg_247_1.bgs_[var_250_0] == nil then
				local var_250_1 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_250_0)
				var_250_1.name = var_250_0
				var_250_1.transform.parent = arg_247_1.stage_.transform
				var_250_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_[var_250_0] = var_250_1
			end

			local var_250_2 = 2

			if var_250_2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				local var_250_3 = manager.ui.mainCamera.transform.localPosition
				local var_250_4 = Vector3.New(0, 0, 10) + Vector3.New(var_250_3.x, var_250_3.y, 0)
				local var_250_5 = arg_247_1.bgs_.ST62

				var_250_5.transform.localPosition = var_250_4
				var_250_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_6 = var_250_5:GetComponent("SpriteRenderer")

				if var_250_6 and var_250_6.sprite then
					local var_250_7 = (var_250_5.transform.localPosition - var_250_3).z
					local var_250_8 = manager.ui.mainCameraCom_
					local var_250_9 = 2 * var_250_7 * Mathf.Tan(var_250_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_10 = var_250_9 * var_250_8.aspect
					local var_250_11 = var_250_6.sprite.bounds.size.x
					local var_250_12 = var_250_6.sprite.bounds.size.y
					local var_250_13 = var_250_10 / var_250_11
					local var_250_14 = var_250_9 / var_250_12
					local var_250_15 = var_250_14 < var_250_13 and var_250_13 or var_250_14

					var_250_5.transform.localScale = Vector3.New(var_250_15, var_250_15, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST62" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_16 = 0

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_17 = 2

			if var_250_16 <= arg_247_1.time_ and arg_247_1.time_ < var_250_16 + var_250_17 then
				local var_250_18 = (arg_247_1.time_ - var_250_16) / var_250_17
				local var_250_19 = Color.New(0, 0, 0)

				var_250_19.a = Mathf.Lerp(0, 1, var_250_18)
				arg_247_1.mask_.color = var_250_19
			end

			if arg_247_1.time_ >= var_250_16 + var_250_17 and arg_247_1.time_ < var_250_16 + var_250_17 + arg_250_0 then
				local var_250_20 = Color.New(0, 0, 0)

				var_250_20.a = 1
				arg_247_1.mask_.color = var_250_20
			end

			local var_250_21 = 2

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_22 = 2

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_22 then
				local var_250_23 = (arg_247_1.time_ - var_250_21) / var_250_22
				local var_250_24 = Color.New(0, 0, 0)

				var_250_24.a = Mathf.Lerp(1, 0, var_250_23)
				arg_247_1.mask_.color = var_250_24
			end

			if arg_247_1.time_ >= var_250_21 + var_250_22 and arg_247_1.time_ < var_250_21 + var_250_22 + arg_250_0 then
				local var_250_25 = Color.New(0, 0, 0)
				local var_250_26 = 0

				arg_247_1.mask_.enabled = false
				var_250_25.a = var_250_26
				arg_247_1.mask_.color = var_250_25
			end

			local var_250_27 = arg_247_1.actors_["10059"].transform
			local var_250_28 = 2

			if var_250_28 < arg_247_1.time_ and arg_247_1.time_ <= var_250_28 + arg_250_0 then
				arg_247_1.var_.moveOldPos10059 = var_250_27.localPosition
				var_250_27.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10059", 7)

				local var_250_29 = var_250_27.childCount

				for iter_250_2 = 0, var_250_29 - 1 do
					local var_250_30 = var_250_27:GetChild(iter_250_2)

					if var_250_30.name == "" or not string.find(var_250_30.name, "split") then
						var_250_30.gameObject:SetActive(true)
					else
						var_250_30.gameObject:SetActive(false)
					end
				end
			end

			local var_250_31 = 0.001

			if var_250_28 <= arg_247_1.time_ and arg_247_1.time_ < var_250_28 + var_250_31 then
				local var_250_32 = (arg_247_1.time_ - var_250_28) / var_250_31
				local var_250_33 = Vector3.New(0, -2000, 35)

				var_250_27.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10059, var_250_33, var_250_32)
			end

			if arg_247_1.time_ >= var_250_28 + var_250_31 and arg_247_1.time_ < var_250_28 + var_250_31 + arg_250_0 then
				var_250_27.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_250_34 = arg_247_1.actors_["1061"].transform
			local var_250_35 = 2

			if var_250_35 < arg_247_1.time_ and arg_247_1.time_ <= var_250_35 + arg_250_0 then
				arg_247_1.var_.moveOldPos1061 = var_250_34.localPosition
				var_250_34.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1061", 7)

				local var_250_36 = var_250_34.childCount

				for iter_250_3 = 0, var_250_36 - 1 do
					local var_250_37 = var_250_34:GetChild(iter_250_3)

					if var_250_37.name == "" or not string.find(var_250_37.name, "split") then
						var_250_37.gameObject:SetActive(true)
					else
						var_250_37.gameObject:SetActive(false)
					end
				end
			end

			local var_250_38 = 0.001

			if var_250_35 <= arg_247_1.time_ and arg_247_1.time_ < var_250_35 + var_250_38 then
				local var_250_39 = (arg_247_1.time_ - var_250_35) / var_250_38
				local var_250_40 = Vector3.New(0, -2000, 18)

				var_250_34.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1061, var_250_40, var_250_39)
			end

			if arg_247_1.time_ >= var_250_35 + var_250_38 and arg_247_1.time_ < var_250_35 + var_250_38 + arg_250_0 then
				var_250_34.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_250_41 = arg_247_1.actors_["10059"]
			local var_250_42 = 2

			if var_250_42 < arg_247_1.time_ and arg_247_1.time_ <= var_250_42 + arg_250_0 and not isNil(var_250_41) and arg_247_1.var_.actorSpriteComps10059 == nil then
				arg_247_1.var_.actorSpriteComps10059 = var_250_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_43 = 0.034

			if var_250_42 <= arg_247_1.time_ and arg_247_1.time_ < var_250_42 + var_250_43 and not isNil(var_250_41) then
				local var_250_44 = (arg_247_1.time_ - var_250_42) / var_250_43

				if arg_247_1.var_.actorSpriteComps10059 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								local var_250_45 = Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, var_250_44)
								local var_250_46 = Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, var_250_44)
								local var_250_47 = Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, var_250_44)

								iter_250_5.color = Color.New(var_250_45, var_250_46, var_250_47)
							else
								local var_250_48 = Mathf.Lerp(iter_250_5.color.r, 0.5, var_250_44)

								iter_250_5.color = Color.New(var_250_48, var_250_48, var_250_48)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_42 + var_250_43 and arg_247_1.time_ < var_250_42 + var_250_43 + arg_250_0 and not isNil(var_250_41) and arg_247_1.var_.actorSpriteComps10059 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10059 = nil
			end

			local var_250_49 = arg_247_1.actors_["1061"]
			local var_250_50 = 2.00066666666667

			if var_250_50 < arg_247_1.time_ and arg_247_1.time_ <= var_250_50 + arg_250_0 and not isNil(var_250_49) and arg_247_1.var_.actorSpriteComps1061 == nil then
				arg_247_1.var_.actorSpriteComps1061 = var_250_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_51 = 0.0333333333333332

			if var_250_50 <= arg_247_1.time_ and arg_247_1.time_ < var_250_50 + var_250_51 and not isNil(var_250_49) then
				local var_250_52 = (arg_247_1.time_ - var_250_50) / var_250_51

				if arg_247_1.var_.actorSpriteComps1061 then
					for iter_250_8, iter_250_9 in pairs(arg_247_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_250_9 then
							if arg_247_1.isInRecall_ then
								local var_250_53 = Mathf.Lerp(iter_250_9.color.r, arg_247_1.hightColor2.r, var_250_52)
								local var_250_54 = Mathf.Lerp(iter_250_9.color.g, arg_247_1.hightColor2.g, var_250_52)
								local var_250_55 = Mathf.Lerp(iter_250_9.color.b, arg_247_1.hightColor2.b, var_250_52)

								iter_250_9.color = Color.New(var_250_53, var_250_54, var_250_55)
							else
								local var_250_56 = Mathf.Lerp(iter_250_9.color.r, 0.5, var_250_52)

								iter_250_9.color = Color.New(var_250_56, var_250_56, var_250_56)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_50 + var_250_51 and arg_247_1.time_ < var_250_50 + var_250_51 + arg_250_0 and not isNil(var_250_49) and arg_247_1.var_.actorSpriteComps1061 then
				for iter_250_10, iter_250_11 in pairs(arg_247_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_250_11 then
						if arg_247_1.isInRecall_ then
							iter_250_11.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1061 = nil
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_57 = 4
			local var_250_58 = 1.125

			if var_250_57 < arg_247_1.time_ and arg_247_1.time_ <= var_250_57 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_59 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_59:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_60 = arg_247_1:GetWordFromCfg(410161060)
				local var_250_61 = arg_247_1:FormatText(var_250_60.content)

				arg_247_1.text_.text = var_250_61

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_62 = 45
				local var_250_63 = utf8.len(var_250_61)
				local var_250_64 = var_250_62 <= 0 and var_250_58 or var_250_58 * (var_250_63 / var_250_62)

				if var_250_64 > 0 and var_250_58 < var_250_64 then
					arg_247_1.talkMaxDuration = var_250_64
					var_250_57 = var_250_57 + 0.3

					if var_250_64 + var_250_57 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_64 + var_250_57
					end
				end

				arg_247_1.text_.text = var_250_61
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_65 = var_250_57 + 0.3
			local var_250_66 = math.max(var_250_58, arg_247_1.talkMaxDuration)

			if var_250_65 <= arg_247_1.time_ and arg_247_1.time_ < var_250_65 + var_250_66 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_65) / var_250_66

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_65 + var_250_66 and arg_247_1.time_ < var_250_65 + var_250_66 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play410161061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410161061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410161062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.6

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(410161061)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 24
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410161062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410161062
		arg_257_1.duration_ = 5.4

		local var_257_0 = {
			ja = 5.4,
			CriLanguages = 2.166,
			zh = 2.166
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410161063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1061"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 2)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(-390, -490, 18)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_260_7 = arg_257_1.actors_["10059"].transform
			local var_260_8 = 0

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.var_.moveOldPos10059 = var_260_7.localPosition
				var_260_7.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10059", 4)

				local var_260_9 = var_260_7.childCount

				for iter_260_1 = 0, var_260_9 - 1 do
					local var_260_10 = var_260_7:GetChild(iter_260_1)

					if var_260_10.name == "" or not string.find(var_260_10.name, "split") then
						var_260_10.gameObject:SetActive(true)
					else
						var_260_10.gameObject:SetActive(false)
					end
				end
			end

			local var_260_11 = 0.001

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_11 then
				local var_260_12 = (arg_257_1.time_ - var_260_8) / var_260_11
				local var_260_13 = Vector3.New(390, -530, 35)

				var_260_7.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10059, var_260_13, var_260_12)
			end

			if arg_257_1.time_ >= var_260_8 + var_260_11 and arg_257_1.time_ < var_260_8 + var_260_11 + arg_260_0 then
				var_260_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_260_14 = arg_257_1.actors_["1061"]
			local var_260_15 = 0

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 and not isNil(var_260_14) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_16 = 0.034

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_16 and not isNil(var_260_14) then
				local var_260_17 = (arg_257_1.time_ - var_260_15) / var_260_16

				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_3 then
							if arg_257_1.isInRecall_ then
								local var_260_18 = Mathf.Lerp(iter_260_3.color.r, arg_257_1.hightColor1.r, var_260_17)
								local var_260_19 = Mathf.Lerp(iter_260_3.color.g, arg_257_1.hightColor1.g, var_260_17)
								local var_260_20 = Mathf.Lerp(iter_260_3.color.b, arg_257_1.hightColor1.b, var_260_17)

								iter_260_3.color = Color.New(var_260_18, var_260_19, var_260_20)
							else
								local var_260_21 = Mathf.Lerp(iter_260_3.color.r, 1, var_260_17)

								iter_260_3.color = Color.New(var_260_21, var_260_21, var_260_21)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_15 + var_260_16 and arg_257_1.time_ < var_260_15 + var_260_16 + arg_260_0 and not isNil(var_260_14) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_5 then
						if arg_257_1.isInRecall_ then
							iter_260_5.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_22 = arg_257_1.actors_["10059"]
			local var_260_23 = 0

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 and not isNil(var_260_22) and arg_257_1.var_.actorSpriteComps10059 == nil then
				arg_257_1.var_.actorSpriteComps10059 = var_260_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_24 = 0.034

			if var_260_23 <= arg_257_1.time_ and arg_257_1.time_ < var_260_23 + var_260_24 and not isNil(var_260_22) then
				local var_260_25 = (arg_257_1.time_ - var_260_23) / var_260_24

				if arg_257_1.var_.actorSpriteComps10059 then
					for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_260_7 then
							if arg_257_1.isInRecall_ then
								local var_260_26 = Mathf.Lerp(iter_260_7.color.r, arg_257_1.hightColor2.r, var_260_25)
								local var_260_27 = Mathf.Lerp(iter_260_7.color.g, arg_257_1.hightColor2.g, var_260_25)
								local var_260_28 = Mathf.Lerp(iter_260_7.color.b, arg_257_1.hightColor2.b, var_260_25)

								iter_260_7.color = Color.New(var_260_26, var_260_27, var_260_28)
							else
								local var_260_29 = Mathf.Lerp(iter_260_7.color.r, 0.5, var_260_25)

								iter_260_7.color = Color.New(var_260_29, var_260_29, var_260_29)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_23 + var_260_24 and arg_257_1.time_ < var_260_23 + var_260_24 + arg_260_0 and not isNil(var_260_22) and arg_257_1.var_.actorSpriteComps10059 then
				for iter_260_8, iter_260_9 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_260_9 then
						if arg_257_1.isInRecall_ then
							iter_260_9.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10059 = nil
			end

			local var_260_30 = 0
			local var_260_31 = 0.275

			if var_260_30 < arg_257_1.time_ and arg_257_1.time_ <= var_260_30 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_32 = arg_257_1:FormatText(StoryNameCfg[612].name)

				arg_257_1.leftNameTxt_.text = var_260_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_33 = arg_257_1:GetWordFromCfg(410161062)
				local var_260_34 = arg_257_1:FormatText(var_260_33.content)

				arg_257_1.text_.text = var_260_34

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_35 = 11
				local var_260_36 = utf8.len(var_260_34)
				local var_260_37 = var_260_35 <= 0 and var_260_31 or var_260_31 * (var_260_36 / var_260_35)

				if var_260_37 > 0 and var_260_31 < var_260_37 then
					arg_257_1.talkMaxDuration = var_260_37

					if var_260_37 + var_260_30 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_37 + var_260_30
					end
				end

				arg_257_1.text_.text = var_260_34
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161062", "story_v_out_410161.awb") ~= 0 then
					local var_260_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161062", "story_v_out_410161.awb") / 1000

					if var_260_38 + var_260_30 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_38 + var_260_30
					end

					if var_260_33.prefab_name ~= "" and arg_257_1.actors_[var_260_33.prefab_name] ~= nil then
						local var_260_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_33.prefab_name].transform, "story_v_out_410161", "410161062", "story_v_out_410161.awb")

						arg_257_1:RecordAudio("410161062", var_260_39)
						arg_257_1:RecordAudio("410161062", var_260_39)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410161", "410161062", "story_v_out_410161.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410161", "410161062", "story_v_out_410161.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_40 = math.max(var_260_31, arg_257_1.talkMaxDuration)

			if var_260_30 <= arg_257_1.time_ and arg_257_1.time_ < var_260_30 + var_260_40 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_30) / var_260_40

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_30 + var_260_40 and arg_257_1.time_ < var_260_30 + var_260_40 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play410161063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410161063
		arg_261_1.duration_ = 1.7

		local var_261_0 = {
			ja = 1.7,
			CriLanguages = 1.466,
			zh = 1.466
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play410161064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10059"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10059 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10059", 4)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_2" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(390, -530, 35)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10059, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_264_7 = arg_261_1.actors_["10059"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10059 == nil then
				arg_261_1.var_.actorSpriteComps10059 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10059 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 1, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10059 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10059 = nil
			end

			local var_264_15 = arg_261_1.actors_["1061"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = var_264_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_17 = 0.034

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								local var_264_19 = Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor2.r, var_264_18)
								local var_264_20 = Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor2.g, var_264_18)
								local var_264_21 = Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor2.b, var_264_18)

								iter_264_6.color = Color.New(var_264_19, var_264_20, var_264_21)
							else
								local var_264_22 = Mathf.Lerp(iter_264_6.color.r, 0.5, var_264_18)

								iter_264_6.color = Color.New(var_264_22, var_264_22, var_264_22)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_8 then
						if arg_261_1.isInRecall_ then
							iter_264_8.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_23 = 0
			local var_264_24 = 0.125

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_25 = arg_261_1:FormatText(StoryNameCfg[596].name)

				arg_261_1.leftNameTxt_.text = var_264_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_26 = arg_261_1:GetWordFromCfg(410161063)
				local var_264_27 = arg_261_1:FormatText(var_264_26.content)

				arg_261_1.text_.text = var_264_27

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_28 = 5
				local var_264_29 = utf8.len(var_264_27)
				local var_264_30 = var_264_28 <= 0 and var_264_24 or var_264_24 * (var_264_29 / var_264_28)

				if var_264_30 > 0 and var_264_24 < var_264_30 then
					arg_261_1.talkMaxDuration = var_264_30

					if var_264_30 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_30 + var_264_23
					end
				end

				arg_261_1.text_.text = var_264_27
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161063", "story_v_out_410161.awb") ~= 0 then
					local var_264_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161063", "story_v_out_410161.awb") / 1000

					if var_264_31 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_31 + var_264_23
					end

					if var_264_26.prefab_name ~= "" and arg_261_1.actors_[var_264_26.prefab_name] ~= nil then
						local var_264_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_26.prefab_name].transform, "story_v_out_410161", "410161063", "story_v_out_410161.awb")

						arg_261_1:RecordAudio("410161063", var_264_32)
						arg_261_1:RecordAudio("410161063", var_264_32)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410161", "410161063", "story_v_out_410161.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410161", "410161063", "story_v_out_410161.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_33 = math.max(var_264_24, arg_261_1.talkMaxDuration)

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_33 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_23) / var_264_33

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_23 + var_264_33 and arg_261_1.time_ < var_264_23 + var_264_33 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play410161064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410161064
		arg_265_1.duration_ = 13.1

		local var_265_0 = {
			ja = 13.1,
			CriLanguages = 4.166,
			zh = 4.166
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
				arg_265_0:Play410161065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1061"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1061 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1061", 2)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(-390, -490, 18)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1061, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_268_7 = arg_265_1.actors_["1061"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 0.034

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 1, var_268_10)

								iter_268_2.color = Color.New(var_268_14, var_268_14, var_268_14)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_15 = arg_265_1.actors_["10059"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10059 == nil then
				arg_265_1.var_.actorSpriteComps10059 = var_268_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_17 = 0.034

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.actorSpriteComps10059 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								local var_268_19 = Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor2.r, var_268_18)
								local var_268_20 = Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor2.g, var_268_18)
								local var_268_21 = Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor2.b, var_268_18)

								iter_268_6.color = Color.New(var_268_19, var_268_20, var_268_21)
							else
								local var_268_22 = Mathf.Lerp(iter_268_6.color.r, 0.5, var_268_18)

								iter_268_6.color = Color.New(var_268_22, var_268_22, var_268_22)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10059 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10059 = nil
			end

			local var_268_23 = 0
			local var_268_24 = 0.525

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[612].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(410161064)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 21
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161064", "story_v_out_410161.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161064", "story_v_out_410161.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_410161", "410161064", "story_v_out_410161.awb")

						arg_265_1:RecordAudio("410161064", var_268_32)
						arg_265_1:RecordAudio("410161064", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410161", "410161064", "story_v_out_410161.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410161", "410161064", "story_v_out_410161.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play410161065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410161065
		arg_269_1.duration_ = 2.4

		local var_269_0 = {
			ja = 2.1,
			CriLanguages = 2.4,
			zh = 2.4
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play410161066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10059"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10059 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10059", 4)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_1" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(390, -530, 35)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10059, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_272_7 = arg_269_1.actors_["10059"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10059 == nil then
				arg_269_1.var_.actorSpriteComps10059 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.034

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps10059 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								local var_272_11 = Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, var_272_10)
								local var_272_12 = Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, var_272_10)
								local var_272_13 = Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, var_272_10)

								iter_272_2.color = Color.New(var_272_11, var_272_12, var_272_13)
							else
								local var_272_14 = Mathf.Lerp(iter_272_2.color.r, 1, var_272_10)

								iter_272_2.color = Color.New(var_272_14, var_272_14, var_272_14)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10059 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10059 = nil
			end

			local var_272_15 = arg_269_1.actors_["1061"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_17 = 0.034

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								local var_272_19 = Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, var_272_18)
								local var_272_20 = Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, var_272_18)
								local var_272_21 = Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, var_272_18)

								iter_272_6.color = Color.New(var_272_19, var_272_20, var_272_21)
							else
								local var_272_22 = Mathf.Lerp(iter_272_6.color.r, 0.5, var_272_18)

								iter_272_6.color = Color.New(var_272_22, var_272_22, var_272_22)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_8 then
						if arg_269_1.isInRecall_ then
							iter_272_8.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_23 = 0
			local var_272_24 = 0.325

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[596].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(410161065)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 13
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161065", "story_v_out_410161.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161065", "story_v_out_410161.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_out_410161", "410161065", "story_v_out_410161.awb")

						arg_269_1:RecordAudio("410161065", var_272_32)
						arg_269_1:RecordAudio("410161065", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410161", "410161065", "story_v_out_410161.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410161", "410161065", "story_v_out_410161.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play410161066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410161066
		arg_273_1.duration_ = 5.87

		local var_273_0 = {
			ja = 4.866,
			CriLanguages = 5.866,
			zh = 5.866
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play410161067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1061"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 2)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_5" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(-390, -490, 18)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_276_7 = arg_273_1.actors_["1061"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_15 = arg_273_1.actors_["10059"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10059 == nil then
				arg_273_1.var_.actorSpriteComps10059 = var_276_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_17 = 0.034

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.actorSpriteComps10059 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								local var_276_19 = Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, var_276_18)
								local var_276_20 = Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, var_276_18)
								local var_276_21 = Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, var_276_18)

								iter_276_6.color = Color.New(var_276_19, var_276_20, var_276_21)
							else
								local var_276_22 = Mathf.Lerp(iter_276_6.color.r, 0.5, var_276_18)

								iter_276_6.color = Color.New(var_276_22, var_276_22, var_276_22)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10059 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_276_8 then
						if arg_273_1.isInRecall_ then
							iter_276_8.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10059 = nil
			end

			local var_276_23 = 0
			local var_276_24 = 0.625

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_25 = arg_273_1:FormatText(StoryNameCfg[612].name)

				arg_273_1.leftNameTxt_.text = var_276_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_26 = arg_273_1:GetWordFromCfg(410161066)
				local var_276_27 = arg_273_1:FormatText(var_276_26.content)

				arg_273_1.text_.text = var_276_27

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_28 = 25
				local var_276_29 = utf8.len(var_276_27)
				local var_276_30 = var_276_28 <= 0 and var_276_24 or var_276_24 * (var_276_29 / var_276_28)

				if var_276_30 > 0 and var_276_24 < var_276_30 then
					arg_273_1.talkMaxDuration = var_276_30

					if var_276_30 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_30 + var_276_23
					end
				end

				arg_273_1.text_.text = var_276_27
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161066", "story_v_out_410161.awb") ~= 0 then
					local var_276_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161066", "story_v_out_410161.awb") / 1000

					if var_276_31 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_31 + var_276_23
					end

					if var_276_26.prefab_name ~= "" and arg_273_1.actors_[var_276_26.prefab_name] ~= nil then
						local var_276_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_26.prefab_name].transform, "story_v_out_410161", "410161066", "story_v_out_410161.awb")

						arg_273_1:RecordAudio("410161066", var_276_32)
						arg_273_1:RecordAudio("410161066", var_276_32)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410161", "410161066", "story_v_out_410161.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410161", "410161066", "story_v_out_410161.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_33 = math.max(var_276_24, arg_273_1.talkMaxDuration)

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_33 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_23) / var_276_33

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_23 + var_276_33 and arg_273_1.time_ < var_276_23 + var_276_33 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410161067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410161067
		arg_277_1.duration_ = 7.87

		local var_277_0 = {
			ja = 7.866,
			CriLanguages = 6.933,
			zh = 6.933
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
				arg_277_0:Play410161068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1061"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 2)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "split_5" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(-390, -490, 18)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_280_7 = arg_277_1.actors_["1061"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 1, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 0.8

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[612].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(410161067)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 32
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161067", "story_v_out_410161.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161067", "story_v_out_410161.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_410161", "410161067", "story_v_out_410161.awb")

						arg_277_1:RecordAudio("410161067", var_280_24)
						arg_277_1:RecordAudio("410161067", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410161", "410161067", "story_v_out_410161.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410161", "410161067", "story_v_out_410161.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410161068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410161068
		arg_281_1.duration_ = 7.93

		local var_281_0 = {
			ja = 7.766,
			CriLanguages = 7.933,
			zh = 7.933
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
				arg_281_0:Play410161069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10059"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10059 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10059", 4)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "split_3" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(390, -530, 35)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10059, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_284_7 = arg_281_1.actors_["10059"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps10059 == nil then
				arg_281_1.var_.actorSpriteComps10059 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.034

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps10059 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								local var_284_11 = Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, var_284_10)
								local var_284_12 = Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, var_284_10)
								local var_284_13 = Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, var_284_10)

								iter_284_2.color = Color.New(var_284_11, var_284_12, var_284_13)
							else
								local var_284_14 = Mathf.Lerp(iter_284_2.color.r, 1, var_284_10)

								iter_284_2.color = Color.New(var_284_14, var_284_14, var_284_14)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps10059 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_284_4 then
						if arg_281_1.isInRecall_ then
							iter_284_4.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10059 = nil
			end

			local var_284_15 = arg_281_1.actors_["1061"]
			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = var_284_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_17 = 0.034

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 and not isNil(var_284_15) then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17

				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_5, iter_284_6 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_284_6 then
							if arg_281_1.isInRecall_ then
								local var_284_19 = Mathf.Lerp(iter_284_6.color.r, arg_281_1.hightColor2.r, var_284_18)
								local var_284_20 = Mathf.Lerp(iter_284_6.color.g, arg_281_1.hightColor2.g, var_284_18)
								local var_284_21 = Mathf.Lerp(iter_284_6.color.b, arg_281_1.hightColor2.b, var_284_18)

								iter_284_6.color = Color.New(var_284_19, var_284_20, var_284_21)
							else
								local var_284_22 = Mathf.Lerp(iter_284_6.color.r, 0.5, var_284_18)

								iter_284_6.color = Color.New(var_284_22, var_284_22, var_284_22)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_7, iter_284_8 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_8 then
						if arg_281_1.isInRecall_ then
							iter_284_8.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_23 = 0
			local var_284_24 = 0.725

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_25 = arg_281_1:FormatText(StoryNameCfg[596].name)

				arg_281_1.leftNameTxt_.text = var_284_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_26 = arg_281_1:GetWordFromCfg(410161068)
				local var_284_27 = arg_281_1:FormatText(var_284_26.content)

				arg_281_1.text_.text = var_284_27

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_28 = 29
				local var_284_29 = utf8.len(var_284_27)
				local var_284_30 = var_284_28 <= 0 and var_284_24 or var_284_24 * (var_284_29 / var_284_28)

				if var_284_30 > 0 and var_284_24 < var_284_30 then
					arg_281_1.talkMaxDuration = var_284_30

					if var_284_30 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_30 + var_284_23
					end
				end

				arg_281_1.text_.text = var_284_27
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161068", "story_v_out_410161.awb") ~= 0 then
					local var_284_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161068", "story_v_out_410161.awb") / 1000

					if var_284_31 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_31 + var_284_23
					end

					if var_284_26.prefab_name ~= "" and arg_281_1.actors_[var_284_26.prefab_name] ~= nil then
						local var_284_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_26.prefab_name].transform, "story_v_out_410161", "410161068", "story_v_out_410161.awb")

						arg_281_1:RecordAudio("410161068", var_284_32)
						arg_281_1:RecordAudio("410161068", var_284_32)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410161", "410161068", "story_v_out_410161.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410161", "410161068", "story_v_out_410161.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_33 = math.max(var_284_24, arg_281_1.talkMaxDuration)

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_33 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_23) / var_284_33

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_23 + var_284_33 and arg_281_1.time_ < var_284_23 + var_284_33 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play410161069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410161069
		arg_285_1.duration_ = 9.97

		local var_285_0 = {
			ja = 9.966,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_285_0:Play410161070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1061"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1061 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1061", 2)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-390, -490, 18)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1061, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_288_7 = arg_285_1.actors_["1061"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_15 = arg_285_1.actors_["10059"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10059 == nil then
				arg_285_1.var_.actorSpriteComps10059 = var_288_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_17 = 0.034

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.actorSpriteComps10059 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								local var_288_19 = Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, var_288_18)
								local var_288_20 = Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, var_288_18)
								local var_288_21 = Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, var_288_18)

								iter_288_6.color = Color.New(var_288_19, var_288_20, var_288_21)
							else
								local var_288_22 = Mathf.Lerp(iter_288_6.color.r, 0.5, var_288_18)

								iter_288_6.color = Color.New(var_288_22, var_288_22, var_288_22)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps10059 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_288_8 then
						if arg_285_1.isInRecall_ then
							iter_288_8.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10059 = nil
			end

			local var_288_23 = 0
			local var_288_24 = 0.6

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_25 = arg_285_1:FormatText(StoryNameCfg[612].name)

				arg_285_1.leftNameTxt_.text = var_288_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(410161069)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 24
				local var_288_29 = utf8.len(var_288_27)
				local var_288_30 = var_288_28 <= 0 and var_288_24 or var_288_24 * (var_288_29 / var_288_28)

				if var_288_30 > 0 and var_288_24 < var_288_30 then
					arg_285_1.talkMaxDuration = var_288_30

					if var_288_30 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_30 + var_288_23
					end
				end

				arg_285_1.text_.text = var_288_27
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161069", "story_v_out_410161.awb") ~= 0 then
					local var_288_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161069", "story_v_out_410161.awb") / 1000

					if var_288_31 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_23
					end

					if var_288_26.prefab_name ~= "" and arg_285_1.actors_[var_288_26.prefab_name] ~= nil then
						local var_288_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_26.prefab_name].transform, "story_v_out_410161", "410161069", "story_v_out_410161.awb")

						arg_285_1:RecordAudio("410161069", var_288_32)
						arg_285_1:RecordAudio("410161069", var_288_32)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410161", "410161069", "story_v_out_410161.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410161", "410161069", "story_v_out_410161.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_33 = math.max(var_288_24, arg_285_1.talkMaxDuration)

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_33 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_23) / var_288_33

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_23 + var_288_33 and arg_285_1.time_ < var_288_23 + var_288_33 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play410161070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410161070
		arg_289_1.duration_ = 10.97

		local var_289_0 = {
			ja = 10.966,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_289_0:Play410161071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10059"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10059 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10059", 4)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "split_3" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(390, -530, 35)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10059, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_292_7 = arg_289_1.actors_["10059"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10059 == nil then
				arg_289_1.var_.actorSpriteComps10059 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps10059 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								local var_292_11 = Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, var_292_10)
								local var_292_12 = Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, var_292_10)
								local var_292_13 = Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, var_292_10)

								iter_292_2.color = Color.New(var_292_11, var_292_12, var_292_13)
							else
								local var_292_14 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

								iter_292_2.color = Color.New(var_292_14, var_292_14, var_292_14)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10059 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10059 = nil
			end

			local var_292_15 = arg_289_1.actors_["1061"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1061 == nil then
				arg_289_1.var_.actorSpriteComps1061 = var_292_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_17 = 0.034

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.actorSpriteComps1061 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								local var_292_19 = Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, var_292_18)
								local var_292_20 = Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, var_292_18)
								local var_292_21 = Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, var_292_18)

								iter_292_6.color = Color.New(var_292_19, var_292_20, var_292_21)
							else
								local var_292_22 = Mathf.Lerp(iter_292_6.color.r, 0.5, var_292_18)

								iter_292_6.color = Color.New(var_292_22, var_292_22, var_292_22)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1061 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_292_8 then
						if arg_289_1.isInRecall_ then
							iter_292_8.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1061 = nil
			end

			local var_292_23 = 0
			local var_292_24 = 0.875

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[596].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(410161070)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 35
				local var_292_29 = utf8.len(var_292_27)
				local var_292_30 = var_292_28 <= 0 and var_292_24 or var_292_24 * (var_292_29 / var_292_28)

				if var_292_30 > 0 and var_292_24 < var_292_30 then
					arg_289_1.talkMaxDuration = var_292_30

					if var_292_30 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_30 + var_292_23
					end
				end

				arg_289_1.text_.text = var_292_27
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161070", "story_v_out_410161.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161070", "story_v_out_410161.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_410161", "410161070", "story_v_out_410161.awb")

						arg_289_1:RecordAudio("410161070", var_292_32)
						arg_289_1:RecordAudio("410161070", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410161", "410161070", "story_v_out_410161.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410161", "410161070", "story_v_out_410161.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_33 = math.max(var_292_24, arg_289_1.talkMaxDuration)

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_33 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_23) / var_292_33

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_23 + var_292_33 and arg_289_1.time_ < var_292_23 + var_292_33 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play410161071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410161071
		arg_293_1.duration_ = 11.63

		local var_293_0 = {
			ja = 11.633,
			CriLanguages = 7.466,
			zh = 7.466
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
				arg_293_0:Play410161072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10059"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10059 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10059", 4)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "split_3" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(390, -530, 35)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10059, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_296_7 = arg_293_1.actors_["10059"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10059 == nil then
				arg_293_1.var_.actorSpriteComps10059 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps10059 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								local var_296_11 = Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, var_296_10)
								local var_296_12 = Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, var_296_10)
								local var_296_13 = Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, var_296_10)

								iter_296_2.color = Color.New(var_296_11, var_296_12, var_296_13)
							else
								local var_296_14 = Mathf.Lerp(iter_296_2.color.r, 1, var_296_10)

								iter_296_2.color = Color.New(var_296_14, var_296_14, var_296_14)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10059 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10059 = nil
			end

			local var_296_15 = 0
			local var_296_16 = 0.8

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[596].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(410161071)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 32
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161071", "story_v_out_410161.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161071", "story_v_out_410161.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_410161", "410161071", "story_v_out_410161.awb")

						arg_293_1:RecordAudio("410161071", var_296_24)
						arg_293_1:RecordAudio("410161071", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410161", "410161071", "story_v_out_410161.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410161", "410161071", "story_v_out_410161.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play410161072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410161072
		arg_297_1.duration_ = 10.83

		local var_297_0 = {
			ja = 10.833,
			CriLanguages = 7.166,
			zh = 7.166
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
				arg_297_0:Play410161073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1061"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1061 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1061", 2)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "split_5" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(-390, -490, 18)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1061, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_300_7 = arg_297_1.actors_["1061"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = var_300_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_9 = 0.034

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								local var_300_11 = Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, var_300_10)
								local var_300_12 = Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, var_300_10)
								local var_300_13 = Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, var_300_10)

								iter_300_2.color = Color.New(var_300_11, var_300_12, var_300_13)
							else
								local var_300_14 = Mathf.Lerp(iter_300_2.color.r, 1, var_300_10)

								iter_300_2.color = Color.New(var_300_14, var_300_14, var_300_14)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_4 then
						if arg_297_1.isInRecall_ then
							iter_300_4.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_15 = arg_297_1.actors_["10059"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps10059 == nil then
				arg_297_1.var_.actorSpriteComps10059 = var_300_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_17 = 0.034

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.actorSpriteComps10059 then
					for iter_300_5, iter_300_6 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_300_6 then
							if arg_297_1.isInRecall_ then
								local var_300_19 = Mathf.Lerp(iter_300_6.color.r, arg_297_1.hightColor2.r, var_300_18)
								local var_300_20 = Mathf.Lerp(iter_300_6.color.g, arg_297_1.hightColor2.g, var_300_18)
								local var_300_21 = Mathf.Lerp(iter_300_6.color.b, arg_297_1.hightColor2.b, var_300_18)

								iter_300_6.color = Color.New(var_300_19, var_300_20, var_300_21)
							else
								local var_300_22 = Mathf.Lerp(iter_300_6.color.r, 0.5, var_300_18)

								iter_300_6.color = Color.New(var_300_22, var_300_22, var_300_22)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.actorSpriteComps10059 then
				for iter_300_7, iter_300_8 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_300_8 then
						if arg_297_1.isInRecall_ then
							iter_300_8.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10059 = nil
			end

			local var_300_23 = 0
			local var_300_24 = 0.8

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[612].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_26 = arg_297_1:GetWordFromCfg(410161072)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 32
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_24 or var_300_24 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_24 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30

					if var_300_30 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161072", "story_v_out_410161.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161072", "story_v_out_410161.awb") / 1000

					if var_300_31 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_23
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_410161", "410161072", "story_v_out_410161.awb")

						arg_297_1:RecordAudio("410161072", var_300_32)
						arg_297_1:RecordAudio("410161072", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410161", "410161072", "story_v_out_410161.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410161", "410161072", "story_v_out_410161.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_33 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_33

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_33 and arg_297_1.time_ < var_300_23 + var_300_33 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play410161073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410161073
		arg_301_1.duration_ = 13.3

		local var_301_0 = {
			ja = 13.3,
			CriLanguages = 9.566,
			zh = 9.566
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
				arg_301_0:Play410161074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10059"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10059 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10059", 4)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(390, -530, 35)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10059, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_304_7 = arg_301_1.actors_["10059"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps10059 == nil then
				arg_301_1.var_.actorSpriteComps10059 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 0.034

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps10059 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								local var_304_11 = Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, var_304_10)
								local var_304_12 = Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, var_304_10)
								local var_304_13 = Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, var_304_10)

								iter_304_2.color = Color.New(var_304_11, var_304_12, var_304_13)
							else
								local var_304_14 = Mathf.Lerp(iter_304_2.color.r, 1, var_304_10)

								iter_304_2.color = Color.New(var_304_14, var_304_14, var_304_14)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps10059 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_304_4 then
						if arg_301_1.isInRecall_ then
							iter_304_4.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10059 = nil
			end

			local var_304_15 = arg_301_1.actors_["1061"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_17 = 0.034

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_6 then
							if arg_301_1.isInRecall_ then
								local var_304_19 = Mathf.Lerp(iter_304_6.color.r, arg_301_1.hightColor2.r, var_304_18)
								local var_304_20 = Mathf.Lerp(iter_304_6.color.g, arg_301_1.hightColor2.g, var_304_18)
								local var_304_21 = Mathf.Lerp(iter_304_6.color.b, arg_301_1.hightColor2.b, var_304_18)

								iter_304_6.color = Color.New(var_304_19, var_304_20, var_304_21)
							else
								local var_304_22 = Mathf.Lerp(iter_304_6.color.r, 0.5, var_304_18)

								iter_304_6.color = Color.New(var_304_22, var_304_22, var_304_22)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_8 then
						if arg_301_1.isInRecall_ then
							iter_304_8.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_23 = 0
			local var_304_24 = 1.025

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_25 = arg_301_1:FormatText(StoryNameCfg[596].name)

				arg_301_1.leftNameTxt_.text = var_304_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_26 = arg_301_1:GetWordFromCfg(410161073)
				local var_304_27 = arg_301_1:FormatText(var_304_26.content)

				arg_301_1.text_.text = var_304_27

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_28 = 41
				local var_304_29 = utf8.len(var_304_27)
				local var_304_30 = var_304_28 <= 0 and var_304_24 or var_304_24 * (var_304_29 / var_304_28)

				if var_304_30 > 0 and var_304_24 < var_304_30 then
					arg_301_1.talkMaxDuration = var_304_30

					if var_304_30 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_30 + var_304_23
					end
				end

				arg_301_1.text_.text = var_304_27
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161073", "story_v_out_410161.awb") ~= 0 then
					local var_304_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161073", "story_v_out_410161.awb") / 1000

					if var_304_31 + var_304_23 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_31 + var_304_23
					end

					if var_304_26.prefab_name ~= "" and arg_301_1.actors_[var_304_26.prefab_name] ~= nil then
						local var_304_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_26.prefab_name].transform, "story_v_out_410161", "410161073", "story_v_out_410161.awb")

						arg_301_1:RecordAudio("410161073", var_304_32)
						arg_301_1:RecordAudio("410161073", var_304_32)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410161", "410161073", "story_v_out_410161.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410161", "410161073", "story_v_out_410161.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_33 = math.max(var_304_24, arg_301_1.talkMaxDuration)

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_33 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_23) / var_304_33

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_23 + var_304_33 and arg_301_1.time_ < var_304_23 + var_304_33 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play410161074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410161074
		arg_305_1.duration_ = 5.4

		local var_305_0 = {
			ja = 5.4,
			CriLanguages = 2.033,
			zh = 2.033
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play410161075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1061"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1061 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1061", 2)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(-390, -490, 18)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1061, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_308_7 = arg_305_1.actors_["1061"]
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps1061 == nil then
				arg_305_1.var_.actorSpriteComps1061 = var_308_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_9 = 0.034

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 and not isNil(var_308_7) then
				local var_308_10 = (arg_305_1.time_ - var_308_8) / var_308_9

				if arg_305_1.var_.actorSpriteComps1061 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								local var_308_11 = Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, var_308_10)
								local var_308_12 = Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, var_308_10)
								local var_308_13 = Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, var_308_10)

								iter_308_2.color = Color.New(var_308_11, var_308_12, var_308_13)
							else
								local var_308_14 = Mathf.Lerp(iter_308_2.color.r, 1, var_308_10)

								iter_308_2.color = Color.New(var_308_14, var_308_14, var_308_14)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps1061 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_308_4 then
						if arg_305_1.isInRecall_ then
							iter_308_4.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1061 = nil
			end

			local var_308_15 = arg_305_1.actors_["10059"]
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 and not isNil(var_308_15) and arg_305_1.var_.actorSpriteComps10059 == nil then
				arg_305_1.var_.actorSpriteComps10059 = var_308_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_17 = 0.034

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 and not isNil(var_308_15) then
				local var_308_18 = (arg_305_1.time_ - var_308_16) / var_308_17

				if arg_305_1.var_.actorSpriteComps10059 then
					for iter_308_5, iter_308_6 in pairs(arg_305_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_308_6 then
							if arg_305_1.isInRecall_ then
								local var_308_19 = Mathf.Lerp(iter_308_6.color.r, arg_305_1.hightColor2.r, var_308_18)
								local var_308_20 = Mathf.Lerp(iter_308_6.color.g, arg_305_1.hightColor2.g, var_308_18)
								local var_308_21 = Mathf.Lerp(iter_308_6.color.b, arg_305_1.hightColor2.b, var_308_18)

								iter_308_6.color = Color.New(var_308_19, var_308_20, var_308_21)
							else
								local var_308_22 = Mathf.Lerp(iter_308_6.color.r, 0.5, var_308_18)

								iter_308_6.color = Color.New(var_308_22, var_308_22, var_308_22)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 and not isNil(var_308_15) and arg_305_1.var_.actorSpriteComps10059 then
				for iter_308_7, iter_308_8 in pairs(arg_305_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_308_8 then
						if arg_305_1.isInRecall_ then
							iter_308_8.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10059 = nil
			end

			local var_308_23 = 0
			local var_308_24 = 0.275

			if var_308_23 < arg_305_1.time_ and arg_305_1.time_ <= var_308_23 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_25 = arg_305_1:FormatText(StoryNameCfg[612].name)

				arg_305_1.leftNameTxt_.text = var_308_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_26 = arg_305_1:GetWordFromCfg(410161074)
				local var_308_27 = arg_305_1:FormatText(var_308_26.content)

				arg_305_1.text_.text = var_308_27

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_28 = 11
				local var_308_29 = utf8.len(var_308_27)
				local var_308_30 = var_308_28 <= 0 and var_308_24 or var_308_24 * (var_308_29 / var_308_28)

				if var_308_30 > 0 and var_308_24 < var_308_30 then
					arg_305_1.talkMaxDuration = var_308_30

					if var_308_30 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_30 + var_308_23
					end
				end

				arg_305_1.text_.text = var_308_27
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161074", "story_v_out_410161.awb") ~= 0 then
					local var_308_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161074", "story_v_out_410161.awb") / 1000

					if var_308_31 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_31 + var_308_23
					end

					if var_308_26.prefab_name ~= "" and arg_305_1.actors_[var_308_26.prefab_name] ~= nil then
						local var_308_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_26.prefab_name].transform, "story_v_out_410161", "410161074", "story_v_out_410161.awb")

						arg_305_1:RecordAudio("410161074", var_308_32)
						arg_305_1:RecordAudio("410161074", var_308_32)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410161", "410161074", "story_v_out_410161.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410161", "410161074", "story_v_out_410161.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_33 = math.max(var_308_24, arg_305_1.talkMaxDuration)

			if var_308_23 <= arg_305_1.time_ and arg_305_1.time_ < var_308_23 + var_308_33 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_23) / var_308_33

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_23 + var_308_33 and arg_305_1.time_ < var_308_23 + var_308_33 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play410161075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410161075
		arg_309_1.duration_ = 4.67

		local var_309_0 = {
			ja = 4.666,
			CriLanguages = 3.2,
			zh = 3.2
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play410161076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1061"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1061 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1061", 2)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(-390, -490, 18)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1061, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_312_7 = arg_309_1.actors_["1061"]
			local var_312_8 = 0

			if var_312_8 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 and not isNil(var_312_7) and arg_309_1.var_.actorSpriteComps1061 == nil then
				arg_309_1.var_.actorSpriteComps1061 = var_312_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_9 = 0.034

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_9 and not isNil(var_312_7) then
				local var_312_10 = (arg_309_1.time_ - var_312_8) / var_312_9

				if arg_309_1.var_.actorSpriteComps1061 then
					for iter_312_1, iter_312_2 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_312_2 then
							if arg_309_1.isInRecall_ then
								local var_312_11 = Mathf.Lerp(iter_312_2.color.r, arg_309_1.hightColor1.r, var_312_10)
								local var_312_12 = Mathf.Lerp(iter_312_2.color.g, arg_309_1.hightColor1.g, var_312_10)
								local var_312_13 = Mathf.Lerp(iter_312_2.color.b, arg_309_1.hightColor1.b, var_312_10)

								iter_312_2.color = Color.New(var_312_11, var_312_12, var_312_13)
							else
								local var_312_14 = Mathf.Lerp(iter_312_2.color.r, 1, var_312_10)

								iter_312_2.color = Color.New(var_312_14, var_312_14, var_312_14)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_8 + var_312_9 and arg_309_1.time_ < var_312_8 + var_312_9 + arg_312_0 and not isNil(var_312_7) and arg_309_1.var_.actorSpriteComps1061 then
				for iter_312_3, iter_312_4 in pairs(arg_309_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_312_4 then
						if arg_309_1.isInRecall_ then
							iter_312_4.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1061 = nil
			end

			local var_312_15 = 0
			local var_312_16 = 0.3

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[612].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(410161075)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 12
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161075", "story_v_out_410161.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161075", "story_v_out_410161.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_out_410161", "410161075", "story_v_out_410161.awb")

						arg_309_1:RecordAudio("410161075", var_312_24)
						arg_309_1:RecordAudio("410161075", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410161", "410161075", "story_v_out_410161.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410161", "410161075", "story_v_out_410161.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play410161076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410161076
		arg_313_1.duration_ = 6.93

		local var_313_0 = {
			ja = 6.933,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_313_0:Play410161077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = "ST63"

			if arg_313_1.bgs_[var_316_0] == nil then
				local var_316_1 = Object.Instantiate(arg_313_1.paintGo_)

				var_316_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_316_0)
				var_316_1.name = var_316_0
				var_316_1.transform.parent = arg_313_1.stage_.transform
				var_316_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.bgs_[var_316_0] = var_316_1
			end

			local var_316_2 = 2

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				local var_316_3 = manager.ui.mainCamera.transform.localPosition
				local var_316_4 = Vector3.New(0, 0, 10) + Vector3.New(var_316_3.x, var_316_3.y, 0)
				local var_316_5 = arg_313_1.bgs_.ST63

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
					if iter_316_0 ~= "ST63" then
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

			local var_316_21 = 2

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

			local var_316_27 = arg_313_1.actors_["10059"].transform
			local var_316_28 = 2

			if var_316_28 < arg_313_1.time_ and arg_313_1.time_ <= var_316_28 + arg_316_0 then
				arg_313_1.var_.moveOldPos10059 = var_316_27.localPosition
				var_316_27.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10059", 7)

				local var_316_29 = var_316_27.childCount

				for iter_316_2 = 0, var_316_29 - 1 do
					local var_316_30 = var_316_27:GetChild(iter_316_2)

					if var_316_30.name == "" or not string.find(var_316_30.name, "split") then
						var_316_30.gameObject:SetActive(true)
					else
						var_316_30.gameObject:SetActive(false)
					end
				end
			end

			local var_316_31 = 0.001

			if var_316_28 <= arg_313_1.time_ and arg_313_1.time_ < var_316_28 + var_316_31 then
				local var_316_32 = (arg_313_1.time_ - var_316_28) / var_316_31
				local var_316_33 = Vector3.New(0, -2000, 35)

				var_316_27.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10059, var_316_33, var_316_32)
			end

			if arg_313_1.time_ >= var_316_28 + var_316_31 and arg_313_1.time_ < var_316_28 + var_316_31 + arg_316_0 then
				var_316_27.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_316_34 = arg_313_1.actors_["1061"].transform
			local var_316_35 = 2

			if var_316_35 < arg_313_1.time_ and arg_313_1.time_ <= var_316_35 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061 = var_316_34.localPosition
				var_316_34.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1061", 7)

				local var_316_36 = var_316_34.childCount

				for iter_316_3 = 0, var_316_36 - 1 do
					local var_316_37 = var_316_34:GetChild(iter_316_3)

					if var_316_37.name == "" or not string.find(var_316_37.name, "split") then
						var_316_37.gameObject:SetActive(true)
					else
						var_316_37.gameObject:SetActive(false)
					end
				end
			end

			local var_316_38 = 0.001

			if var_316_35 <= arg_313_1.time_ and arg_313_1.time_ < var_316_35 + var_316_38 then
				local var_316_39 = (arg_313_1.time_ - var_316_35) / var_316_38
				local var_316_40 = Vector3.New(0, -2000, 18)

				var_316_34.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1061, var_316_40, var_316_39)
			end

			if arg_313_1.time_ >= var_316_35 + var_316_38 and arg_313_1.time_ < var_316_35 + var_316_38 + arg_316_0 then
				var_316_34.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_316_41 = arg_313_1.actors_["10059"]
			local var_316_42 = 4

			if var_316_42 < arg_313_1.time_ and arg_313_1.time_ <= var_316_42 + arg_316_0 and not isNil(var_316_41) and arg_313_1.var_.actorSpriteComps10059 == nil then
				arg_313_1.var_.actorSpriteComps10059 = var_316_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_43 = 0.034

			if var_316_42 <= arg_313_1.time_ and arg_313_1.time_ < var_316_42 + var_316_43 and not isNil(var_316_41) then
				local var_316_44 = (arg_313_1.time_ - var_316_42) / var_316_43

				if arg_313_1.var_.actorSpriteComps10059 then
					for iter_316_4, iter_316_5 in pairs(arg_313_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_316_5 then
							if arg_313_1.isInRecall_ then
								local var_316_45 = Mathf.Lerp(iter_316_5.color.r, arg_313_1.hightColor1.r, var_316_44)
								local var_316_46 = Mathf.Lerp(iter_316_5.color.g, arg_313_1.hightColor1.g, var_316_44)
								local var_316_47 = Mathf.Lerp(iter_316_5.color.b, arg_313_1.hightColor1.b, var_316_44)

								iter_316_5.color = Color.New(var_316_45, var_316_46, var_316_47)
							else
								local var_316_48 = Mathf.Lerp(iter_316_5.color.r, 1, var_316_44)

								iter_316_5.color = Color.New(var_316_48, var_316_48, var_316_48)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_42 + var_316_43 and arg_313_1.time_ < var_316_42 + var_316_43 + arg_316_0 and not isNil(var_316_41) and arg_313_1.var_.actorSpriteComps10059 then
				for iter_316_6, iter_316_7 in pairs(arg_313_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_316_7 then
						if arg_313_1.isInRecall_ then
							iter_316_7.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps10059 = nil
			end

			local var_316_49 = arg_313_1.actors_["1061"]
			local var_316_50 = 2

			if var_316_50 < arg_313_1.time_ and arg_313_1.time_ <= var_316_50 + arg_316_0 and not isNil(var_316_49) and arg_313_1.var_.actorSpriteComps1061 == nil then
				arg_313_1.var_.actorSpriteComps1061 = var_316_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_51 = 0.034

			if var_316_50 <= arg_313_1.time_ and arg_313_1.time_ < var_316_50 + var_316_51 and not isNil(var_316_49) then
				local var_316_52 = (arg_313_1.time_ - var_316_50) / var_316_51

				if arg_313_1.var_.actorSpriteComps1061 then
					for iter_316_8, iter_316_9 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_316_9 then
							if arg_313_1.isInRecall_ then
								local var_316_53 = Mathf.Lerp(iter_316_9.color.r, arg_313_1.hightColor2.r, var_316_52)
								local var_316_54 = Mathf.Lerp(iter_316_9.color.g, arg_313_1.hightColor2.g, var_316_52)
								local var_316_55 = Mathf.Lerp(iter_316_9.color.b, arg_313_1.hightColor2.b, var_316_52)

								iter_316_9.color = Color.New(var_316_53, var_316_54, var_316_55)
							else
								local var_316_56 = Mathf.Lerp(iter_316_9.color.r, 0.5, var_316_52)

								iter_316_9.color = Color.New(var_316_56, var_316_56, var_316_56)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_50 + var_316_51 and arg_313_1.time_ < var_316_50 + var_316_51 + arg_316_0 and not isNil(var_316_49) and arg_313_1.var_.actorSpriteComps1061 then
				for iter_316_10, iter_316_11 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_316_11 then
						if arg_313_1.isInRecall_ then
							iter_316_11.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1061 = nil
			end

			local var_316_57 = arg_313_1.actors_["10059"].transform
			local var_316_58 = 4

			if var_316_58 < arg_313_1.time_ and arg_313_1.time_ <= var_316_58 + arg_316_0 then
				arg_313_1.var_.moveOldPos10059 = var_316_57.localPosition
				var_316_57.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10059", 3)

				local var_316_59 = var_316_57.childCount

				for iter_316_12 = 0, var_316_59 - 1 do
					local var_316_60 = var_316_57:GetChild(iter_316_12)

					if var_316_60.name == "" or not string.find(var_316_60.name, "split") then
						var_316_60.gameObject:SetActive(true)
					else
						var_316_60.gameObject:SetActive(false)
					end
				end
			end

			local var_316_61 = 0.001

			if var_316_58 <= arg_313_1.time_ and arg_313_1.time_ < var_316_58 + var_316_61 then
				local var_316_62 = (arg_313_1.time_ - var_316_58) / var_316_61
				local var_316_63 = Vector3.New(0, -530, 35)

				var_316_57.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10059, var_316_63, var_316_62)
			end

			if arg_313_1.time_ >= var_316_58 + var_316_61 and arg_313_1.time_ < var_316_58 + var_316_61 + arg_316_0 then
				var_316_57.localPosition = Vector3.New(0, -530, 35)
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_64 = 4
			local var_316_65 = 0.325

			if var_316_64 < arg_313_1.time_ and arg_313_1.time_ <= var_316_64 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_66 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_66:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_67 = arg_313_1:FormatText(StoryNameCfg[596].name)

				arg_313_1.leftNameTxt_.text = var_316_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_68 = arg_313_1:GetWordFromCfg(410161076)
				local var_316_69 = arg_313_1:FormatText(var_316_68.content)

				arg_313_1.text_.text = var_316_69

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_70 = 13
				local var_316_71 = utf8.len(var_316_69)
				local var_316_72 = var_316_70 <= 0 and var_316_65 or var_316_65 * (var_316_71 / var_316_70)

				if var_316_72 > 0 and var_316_65 < var_316_72 then
					arg_313_1.talkMaxDuration = var_316_72
					var_316_64 = var_316_64 + 0.3

					if var_316_72 + var_316_64 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_72 + var_316_64
					end
				end

				arg_313_1.text_.text = var_316_69
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161076", "story_v_out_410161.awb") ~= 0 then
					local var_316_73 = manager.audio:GetVoiceLength("story_v_out_410161", "410161076", "story_v_out_410161.awb") / 1000

					if var_316_73 + var_316_64 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_73 + var_316_64
					end

					if var_316_68.prefab_name ~= "" and arg_313_1.actors_[var_316_68.prefab_name] ~= nil then
						local var_316_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_68.prefab_name].transform, "story_v_out_410161", "410161076", "story_v_out_410161.awb")

						arg_313_1:RecordAudio("410161076", var_316_74)
						arg_313_1:RecordAudio("410161076", var_316_74)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410161", "410161076", "story_v_out_410161.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410161", "410161076", "story_v_out_410161.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_75 = var_316_64 + 0.3
			local var_316_76 = math.max(var_316_65, arg_313_1.talkMaxDuration)

			if var_316_75 <= arg_313_1.time_ and arg_313_1.time_ < var_316_75 + var_316_76 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_75) / var_316_76

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_75 + var_316_76 and arg_313_1.time_ < var_316_75 + var_316_76 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play410161077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 410161077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play410161078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10059"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10059 == nil then
				arg_319_1.var_.actorSpriteComps10059 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.034

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10059 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10059 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10059 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 1.35

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(410161077)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_12 = 54
				local var_322_13 = utf8.len(var_322_11)
				local var_322_14 = var_322_12 <= 0 and var_322_9 or var_322_9 * (var_322_13 / var_322_12)

				if var_322_14 > 0 and var_322_9 < var_322_14 then
					arg_319_1.talkMaxDuration = var_322_14

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_15 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_15 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_15

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_15 and arg_319_1.time_ < var_322_8 + var_322_15 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play410161078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 410161078
		arg_323_1.duration_ = 15.4

		local var_323_0 = {
			ja = 15.4,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_323_0:Play410161079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10059"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos10059 = var_326_0.localPosition
				var_326_0.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10059", 3)

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
				local var_326_6 = Vector3.New(0, -530, 35)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10059, var_326_6, var_326_5)
			end

			if arg_323_1.time_ >= var_326_1 + var_326_4 and arg_323_1.time_ < var_326_1 + var_326_4 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -530, 35)
			end

			local var_326_7 = arg_323_1.actors_["10059"]
			local var_326_8 = 0

			if var_326_8 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps10059 == nil then
				arg_323_1.var_.actorSpriteComps10059 = var_326_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_9 = 0.034

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_9 and not isNil(var_326_7) then
				local var_326_10 = (arg_323_1.time_ - var_326_8) / var_326_9

				if arg_323_1.var_.actorSpriteComps10059 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								local var_326_11 = Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, var_326_10)
								local var_326_12 = Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, var_326_10)
								local var_326_13 = Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, var_326_10)

								iter_326_2.color = Color.New(var_326_11, var_326_12, var_326_13)
							else
								local var_326_14 = Mathf.Lerp(iter_326_2.color.r, 1, var_326_10)

								iter_326_2.color = Color.New(var_326_14, var_326_14, var_326_14)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_8 + var_326_9 and arg_323_1.time_ < var_326_8 + var_326_9 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps10059 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_326_4 then
						if arg_323_1.isInRecall_ then
							iter_326_4.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10059 = nil
			end

			local var_326_15 = 0
			local var_326_16 = 1.25

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[596].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(410161078)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 50
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161078", "story_v_out_410161.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161078", "story_v_out_410161.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_out_410161", "410161078", "story_v_out_410161.awb")

						arg_323_1:RecordAudio("410161078", var_326_24)
						arg_323_1:RecordAudio("410161078", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_410161", "410161078", "story_v_out_410161.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_410161", "410161078", "story_v_out_410161.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 410161079
		arg_327_1.duration_ = 3.33

		local var_327_0 = {
			ja = 3.133,
			CriLanguages = 3.333,
			zh = 3.333
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play410161080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10059"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos10059 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10059", 3)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(0, -530, 35)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10059, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -530, 35)
			end

			local var_330_7 = arg_327_1.actors_["10059"]
			local var_330_8 = 0

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps10059 == nil then
				arg_327_1.var_.actorSpriteComps10059 = var_330_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_9 = 0.034

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_9 and not isNil(var_330_7) then
				local var_330_10 = (arg_327_1.time_ - var_330_8) / var_330_9

				if arg_327_1.var_.actorSpriteComps10059 then
					for iter_330_1, iter_330_2 in pairs(arg_327_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_330_2 then
							if arg_327_1.isInRecall_ then
								local var_330_11 = Mathf.Lerp(iter_330_2.color.r, arg_327_1.hightColor1.r, var_330_10)
								local var_330_12 = Mathf.Lerp(iter_330_2.color.g, arg_327_1.hightColor1.g, var_330_10)
								local var_330_13 = Mathf.Lerp(iter_330_2.color.b, arg_327_1.hightColor1.b, var_330_10)

								iter_330_2.color = Color.New(var_330_11, var_330_12, var_330_13)
							else
								local var_330_14 = Mathf.Lerp(iter_330_2.color.r, 1, var_330_10)

								iter_330_2.color = Color.New(var_330_14, var_330_14, var_330_14)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_8 + var_330_9 and arg_327_1.time_ < var_330_8 + var_330_9 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps10059 then
				for iter_330_3, iter_330_4 in pairs(arg_327_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_330_4 then
						if arg_327_1.isInRecall_ then
							iter_330_4.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10059 = nil
			end

			local var_330_15 = 0
			local var_330_16 = 0.275

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_17 = arg_327_1:FormatText(StoryNameCfg[596].name)

				arg_327_1.leftNameTxt_.text = var_330_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_18 = arg_327_1:GetWordFromCfg(410161079)
				local var_330_19 = arg_327_1:FormatText(var_330_18.content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_20 = 11
				local var_330_21 = utf8.len(var_330_19)
				local var_330_22 = var_330_20 <= 0 and var_330_16 or var_330_16 * (var_330_21 / var_330_20)

				if var_330_22 > 0 and var_330_16 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22

					if var_330_22 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161079", "story_v_out_410161.awb") ~= 0 then
					local var_330_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161079", "story_v_out_410161.awb") / 1000

					if var_330_23 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_23 + var_330_15
					end

					if var_330_18.prefab_name ~= "" and arg_327_1.actors_[var_330_18.prefab_name] ~= nil then
						local var_330_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_18.prefab_name].transform, "story_v_out_410161", "410161079", "story_v_out_410161.awb")

						arg_327_1:RecordAudio("410161079", var_330_24)
						arg_327_1:RecordAudio("410161079", var_330_24)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_410161", "410161079", "story_v_out_410161.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_410161", "410161079", "story_v_out_410161.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_25 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_25 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_25

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_25 and arg_327_1.time_ < var_330_15 + var_330_25 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play410161080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 410161080
		arg_331_1.duration_ = 12.57

		local var_331_0 = {
			ja = 12.566,
			CriLanguages = 4.5,
			zh = 4.5
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play410161081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1061"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1061 = var_334_0.localPosition
				var_334_0.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1061", 2)

				local var_334_2 = var_334_0.childCount

				for iter_334_0 = 0, var_334_2 - 1 do
					local var_334_3 = var_334_0:GetChild(iter_334_0)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_4 then
				local var_334_5 = (arg_331_1.time_ - var_334_1) / var_334_4
				local var_334_6 = Vector3.New(-390, -490, 18)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1061, var_334_6, var_334_5)
			end

			if arg_331_1.time_ >= var_334_1 + var_334_4 and arg_331_1.time_ < var_334_1 + var_334_4 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_334_7 = arg_331_1.actors_["10059"].transform
			local var_334_8 = 0

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.var_.moveOldPos10059 = var_334_7.localPosition
				var_334_7.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10059", 4)

				local var_334_9 = var_334_7.childCount

				for iter_334_1 = 0, var_334_9 - 1 do
					local var_334_10 = var_334_7:GetChild(iter_334_1)

					if var_334_10.name == "" or not string.find(var_334_10.name, "split") then
						var_334_10.gameObject:SetActive(true)
					else
						var_334_10.gameObject:SetActive(false)
					end
				end
			end

			local var_334_11 = 0.001

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_11 then
				local var_334_12 = (arg_331_1.time_ - var_334_8) / var_334_11
				local var_334_13 = Vector3.New(390, -530, 35)

				var_334_7.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10059, var_334_13, var_334_12)
			end

			if arg_331_1.time_ >= var_334_8 + var_334_11 and arg_331_1.time_ < var_334_8 + var_334_11 + arg_334_0 then
				var_334_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_334_14 = arg_331_1.actors_["1061"]
			local var_334_15 = 0

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.actorSpriteComps1061 == nil then
				arg_331_1.var_.actorSpriteComps1061 = var_334_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_16 = 0.034

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_16 and not isNil(var_334_14) then
				local var_334_17 = (arg_331_1.time_ - var_334_15) / var_334_16

				if arg_331_1.var_.actorSpriteComps1061 then
					for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_334_3 then
							if arg_331_1.isInRecall_ then
								local var_334_18 = Mathf.Lerp(iter_334_3.color.r, arg_331_1.hightColor1.r, var_334_17)
								local var_334_19 = Mathf.Lerp(iter_334_3.color.g, arg_331_1.hightColor1.g, var_334_17)
								local var_334_20 = Mathf.Lerp(iter_334_3.color.b, arg_331_1.hightColor1.b, var_334_17)

								iter_334_3.color = Color.New(var_334_18, var_334_19, var_334_20)
							else
								local var_334_21 = Mathf.Lerp(iter_334_3.color.r, 1, var_334_17)

								iter_334_3.color = Color.New(var_334_21, var_334_21, var_334_21)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_15 + var_334_16 and arg_331_1.time_ < var_334_15 + var_334_16 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.actorSpriteComps1061 then
				for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_334_5 then
						if arg_331_1.isInRecall_ then
							iter_334_5.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1061 = nil
			end

			local var_334_22 = arg_331_1.actors_["10059"]
			local var_334_23 = 0

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 and not isNil(var_334_22) and arg_331_1.var_.actorSpriteComps10059 == nil then
				arg_331_1.var_.actorSpriteComps10059 = var_334_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_24 = 0.034

			if var_334_23 <= arg_331_1.time_ and arg_331_1.time_ < var_334_23 + var_334_24 and not isNil(var_334_22) then
				local var_334_25 = (arg_331_1.time_ - var_334_23) / var_334_24

				if arg_331_1.var_.actorSpriteComps10059 then
					for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_334_7 then
							if arg_331_1.isInRecall_ then
								local var_334_26 = Mathf.Lerp(iter_334_7.color.r, arg_331_1.hightColor2.r, var_334_25)
								local var_334_27 = Mathf.Lerp(iter_334_7.color.g, arg_331_1.hightColor2.g, var_334_25)
								local var_334_28 = Mathf.Lerp(iter_334_7.color.b, arg_331_1.hightColor2.b, var_334_25)

								iter_334_7.color = Color.New(var_334_26, var_334_27, var_334_28)
							else
								local var_334_29 = Mathf.Lerp(iter_334_7.color.r, 0.5, var_334_25)

								iter_334_7.color = Color.New(var_334_29, var_334_29, var_334_29)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_23 + var_334_24 and arg_331_1.time_ < var_334_23 + var_334_24 + arg_334_0 and not isNil(var_334_22) and arg_331_1.var_.actorSpriteComps10059 then
				for iter_334_8, iter_334_9 in pairs(arg_331_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_334_9 then
						if arg_331_1.isInRecall_ then
							iter_334_9.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10059 = nil
			end

			local var_334_30 = 0
			local var_334_31 = 0.5

			if var_334_30 < arg_331_1.time_ and arg_331_1.time_ <= var_334_30 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_32 = arg_331_1:FormatText(StoryNameCfg[612].name)

				arg_331_1.leftNameTxt_.text = var_334_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_33 = arg_331_1:GetWordFromCfg(410161080)
				local var_334_34 = arg_331_1:FormatText(var_334_33.content)

				arg_331_1.text_.text = var_334_34

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_35 = 20
				local var_334_36 = utf8.len(var_334_34)
				local var_334_37 = var_334_35 <= 0 and var_334_31 or var_334_31 * (var_334_36 / var_334_35)

				if var_334_37 > 0 and var_334_31 < var_334_37 then
					arg_331_1.talkMaxDuration = var_334_37

					if var_334_37 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_37 + var_334_30
					end
				end

				arg_331_1.text_.text = var_334_34
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161080", "story_v_out_410161.awb") ~= 0 then
					local var_334_38 = manager.audio:GetVoiceLength("story_v_out_410161", "410161080", "story_v_out_410161.awb") / 1000

					if var_334_38 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_38 + var_334_30
					end

					if var_334_33.prefab_name ~= "" and arg_331_1.actors_[var_334_33.prefab_name] ~= nil then
						local var_334_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_33.prefab_name].transform, "story_v_out_410161", "410161080", "story_v_out_410161.awb")

						arg_331_1:RecordAudio("410161080", var_334_39)
						arg_331_1:RecordAudio("410161080", var_334_39)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_410161", "410161080", "story_v_out_410161.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_410161", "410161080", "story_v_out_410161.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_40 = math.max(var_334_31, arg_331_1.talkMaxDuration)

			if var_334_30 <= arg_331_1.time_ and arg_331_1.time_ < var_334_30 + var_334_40 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_30) / var_334_40

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_30 + var_334_40 and arg_331_1.time_ < var_334_30 + var_334_40 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play410161081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 410161081
		arg_335_1.duration_ = 9.83

		local var_335_0 = {
			ja = 9.833,
			CriLanguages = 8,
			zh = 8
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
				arg_335_0:Play410161082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1061"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1061 = var_338_0.localPosition
				var_338_0.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1061", 2)

				local var_338_2 = var_338_0.childCount

				for iter_338_0 = 0, var_338_2 - 1 do
					local var_338_3 = var_338_0:GetChild(iter_338_0)

					if var_338_3.name == "" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_4 then
				local var_338_5 = (arg_335_1.time_ - var_338_1) / var_338_4
				local var_338_6 = Vector3.New(-390, -490, 18)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1061, var_338_6, var_338_5)
			end

			if arg_335_1.time_ >= var_338_1 + var_338_4 and arg_335_1.time_ < var_338_1 + var_338_4 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_338_7 = arg_335_1.actors_["1061"]
			local var_338_8 = 0

			if var_338_8 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 and not isNil(var_338_7) and arg_335_1.var_.actorSpriteComps1061 == nil then
				arg_335_1.var_.actorSpriteComps1061 = var_338_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_9 = 0.034

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_9 and not isNil(var_338_7) then
				local var_338_10 = (arg_335_1.time_ - var_338_8) / var_338_9

				if arg_335_1.var_.actorSpriteComps1061 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								local var_338_11 = Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor1.r, var_338_10)
								local var_338_12 = Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor1.g, var_338_10)
								local var_338_13 = Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor1.b, var_338_10)

								iter_338_2.color = Color.New(var_338_11, var_338_12, var_338_13)
							else
								local var_338_14 = Mathf.Lerp(iter_338_2.color.r, 1, var_338_10)

								iter_338_2.color = Color.New(var_338_14, var_338_14, var_338_14)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_8 + var_338_9 and arg_335_1.time_ < var_338_8 + var_338_9 + arg_338_0 and not isNil(var_338_7) and arg_335_1.var_.actorSpriteComps1061 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_338_4 then
						if arg_335_1.isInRecall_ then
							iter_338_4.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1061 = nil
			end

			local var_338_15 = 0
			local var_338_16 = 0.925

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[612].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_18 = arg_335_1:GetWordFromCfg(410161081)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 37
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161081", "story_v_out_410161.awb") ~= 0 then
					local var_338_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161081", "story_v_out_410161.awb") / 1000

					if var_338_23 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_15
					end

					if var_338_18.prefab_name ~= "" and arg_335_1.actors_[var_338_18.prefab_name] ~= nil then
						local var_338_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_18.prefab_name].transform, "story_v_out_410161", "410161081", "story_v_out_410161.awb")

						arg_335_1:RecordAudio("410161081", var_338_24)
						arg_335_1:RecordAudio("410161081", var_338_24)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_410161", "410161081", "story_v_out_410161.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_410161", "410161081", "story_v_out_410161.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_25 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_25 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_25

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_25 and arg_335_1.time_ < var_338_15 + var_338_25 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 410161082
		arg_339_1.duration_ = 13.2

		local var_339_0 = {
			ja = 13.2,
			CriLanguages = 12.533,
			zh = 12.533
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
				arg_339_0:Play410161083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1061"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1061 = var_342_0.localPosition
				var_342_0.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1061", 2)

				local var_342_2 = var_342_0.childCount

				for iter_342_0 = 0, var_342_2 - 1 do
					local var_342_3 = var_342_0:GetChild(iter_342_0)

					if var_342_3.name == "" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_4 then
				local var_342_5 = (arg_339_1.time_ - var_342_1) / var_342_4
				local var_342_6 = Vector3.New(-390, -490, 18)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1061, var_342_6, var_342_5)
			end

			if arg_339_1.time_ >= var_342_1 + var_342_4 and arg_339_1.time_ < var_342_1 + var_342_4 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_342_7 = arg_339_1.actors_["1061"]
			local var_342_8 = 0

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps1061 == nil then
				arg_339_1.var_.actorSpriteComps1061 = var_342_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_9 = 0.034

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_9 and not isNil(var_342_7) then
				local var_342_10 = (arg_339_1.time_ - var_342_8) / var_342_9

				if arg_339_1.var_.actorSpriteComps1061 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								local var_342_11 = Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, var_342_10)
								local var_342_12 = Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, var_342_10)
								local var_342_13 = Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, var_342_10)

								iter_342_2.color = Color.New(var_342_11, var_342_12, var_342_13)
							else
								local var_342_14 = Mathf.Lerp(iter_342_2.color.r, 1, var_342_10)

								iter_342_2.color = Color.New(var_342_14, var_342_14, var_342_14)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_8 + var_342_9 and arg_339_1.time_ < var_342_8 + var_342_9 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps1061 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_342_4 then
						if arg_339_1.isInRecall_ then
							iter_342_4.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1061 = nil
			end

			local var_342_15 = 0
			local var_342_16 = 1.425

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[612].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(410161082)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 57
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161082", "story_v_out_410161.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161082", "story_v_out_410161.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_410161", "410161082", "story_v_out_410161.awb")

						arg_339_1:RecordAudio("410161082", var_342_24)
						arg_339_1:RecordAudio("410161082", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_410161", "410161082", "story_v_out_410161.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_410161", "410161082", "story_v_out_410161.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 410161083
		arg_343_1.duration_ = 6.73

		local var_343_0 = {
			ja = 6.733,
			CriLanguages = 4.466,
			zh = 4.466
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
				arg_343_0:Play410161084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10059"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos10059 = var_346_0.localPosition
				var_346_0.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10059", 4)

				local var_346_2 = var_346_0.childCount

				for iter_346_0 = 0, var_346_2 - 1 do
					local var_346_3 = var_346_0:GetChild(iter_346_0)

					if var_346_3.name == "" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_4 then
				local var_346_5 = (arg_343_1.time_ - var_346_1) / var_346_4
				local var_346_6 = Vector3.New(390, -530, 35)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10059, var_346_6, var_346_5)
			end

			if arg_343_1.time_ >= var_346_1 + var_346_4 and arg_343_1.time_ < var_346_1 + var_346_4 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_346_7 = arg_343_1.actors_["10059"]
			local var_346_8 = 0

			if var_346_8 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 and not isNil(var_346_7) and arg_343_1.var_.actorSpriteComps10059 == nil then
				arg_343_1.var_.actorSpriteComps10059 = var_346_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_9 = 0.034

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_9 and not isNil(var_346_7) then
				local var_346_10 = (arg_343_1.time_ - var_346_8) / var_346_9

				if arg_343_1.var_.actorSpriteComps10059 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								local var_346_11 = Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor1.r, var_346_10)
								local var_346_12 = Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor1.g, var_346_10)
								local var_346_13 = Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor1.b, var_346_10)

								iter_346_2.color = Color.New(var_346_11, var_346_12, var_346_13)
							else
								local var_346_14 = Mathf.Lerp(iter_346_2.color.r, 1, var_346_10)

								iter_346_2.color = Color.New(var_346_14, var_346_14, var_346_14)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_8 + var_346_9 and arg_343_1.time_ < var_346_8 + var_346_9 + arg_346_0 and not isNil(var_346_7) and arg_343_1.var_.actorSpriteComps10059 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_346_4 then
						if arg_343_1.isInRecall_ then
							iter_346_4.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10059 = nil
			end

			local var_346_15 = arg_343_1.actors_["1061"]
			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 and not isNil(var_346_15) and arg_343_1.var_.actorSpriteComps1061 == nil then
				arg_343_1.var_.actorSpriteComps1061 = var_346_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_17 = 0.034

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_17 and not isNil(var_346_15) then
				local var_346_18 = (arg_343_1.time_ - var_346_16) / var_346_17

				if arg_343_1.var_.actorSpriteComps1061 then
					for iter_346_5, iter_346_6 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_346_6 then
							if arg_343_1.isInRecall_ then
								local var_346_19 = Mathf.Lerp(iter_346_6.color.r, arg_343_1.hightColor2.r, var_346_18)
								local var_346_20 = Mathf.Lerp(iter_346_6.color.g, arg_343_1.hightColor2.g, var_346_18)
								local var_346_21 = Mathf.Lerp(iter_346_6.color.b, arg_343_1.hightColor2.b, var_346_18)

								iter_346_6.color = Color.New(var_346_19, var_346_20, var_346_21)
							else
								local var_346_22 = Mathf.Lerp(iter_346_6.color.r, 0.5, var_346_18)

								iter_346_6.color = Color.New(var_346_22, var_346_22, var_346_22)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 and not isNil(var_346_15) and arg_343_1.var_.actorSpriteComps1061 then
				for iter_346_7, iter_346_8 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_346_8 then
						if arg_343_1.isInRecall_ then
							iter_346_8.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1061 = nil
			end

			local var_346_23 = 0
			local var_346_24 = 0.325

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_25 = arg_343_1:FormatText(StoryNameCfg[596].name)

				arg_343_1.leftNameTxt_.text = var_346_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_26 = arg_343_1:GetWordFromCfg(410161083)
				local var_346_27 = arg_343_1:FormatText(var_346_26.content)

				arg_343_1.text_.text = var_346_27

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_28 = 13
				local var_346_29 = utf8.len(var_346_27)
				local var_346_30 = var_346_28 <= 0 and var_346_24 or var_346_24 * (var_346_29 / var_346_28)

				if var_346_30 > 0 and var_346_24 < var_346_30 then
					arg_343_1.talkMaxDuration = var_346_30

					if var_346_30 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_30 + var_346_23
					end
				end

				arg_343_1.text_.text = var_346_27
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161083", "story_v_out_410161.awb") ~= 0 then
					local var_346_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161083", "story_v_out_410161.awb") / 1000

					if var_346_31 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_31 + var_346_23
					end

					if var_346_26.prefab_name ~= "" and arg_343_1.actors_[var_346_26.prefab_name] ~= nil then
						local var_346_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_26.prefab_name].transform, "story_v_out_410161", "410161083", "story_v_out_410161.awb")

						arg_343_1:RecordAudio("410161083", var_346_32)
						arg_343_1:RecordAudio("410161083", var_346_32)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_410161", "410161083", "story_v_out_410161.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_410161", "410161083", "story_v_out_410161.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_33 = math.max(var_346_24, arg_343_1.talkMaxDuration)

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_33 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_23) / var_346_33

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_23 + var_346_33 and arg_343_1.time_ < var_346_23 + var_346_33 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play410161084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 410161084
		arg_347_1.duration_ = 10.97

		local var_347_0 = {
			ja = 10.966,
			CriLanguages = 8.1,
			zh = 8.1
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
				arg_347_0:Play410161085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10059"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos10059 = var_350_0.localPosition
				var_350_0.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10059", 4)

				local var_350_2 = var_350_0.childCount

				for iter_350_0 = 0, var_350_2 - 1 do
					local var_350_3 = var_350_0:GetChild(iter_350_0)

					if var_350_3.name == "" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_1) / var_350_4
				local var_350_6 = Vector3.New(390, -530, 35)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10059, var_350_6, var_350_5)
			end

			if arg_347_1.time_ >= var_350_1 + var_350_4 and arg_347_1.time_ < var_350_1 + var_350_4 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_350_7 = arg_347_1.actors_["10059"]
			local var_350_8 = 0

			if var_350_8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps10059 == nil then
				arg_347_1.var_.actorSpriteComps10059 = var_350_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_9 = 0.034

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_9 and not isNil(var_350_7) then
				local var_350_10 = (arg_347_1.time_ - var_350_8) / var_350_9

				if arg_347_1.var_.actorSpriteComps10059 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								local var_350_11 = Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, var_350_10)
								local var_350_12 = Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, var_350_10)
								local var_350_13 = Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, var_350_10)

								iter_350_2.color = Color.New(var_350_11, var_350_12, var_350_13)
							else
								local var_350_14 = Mathf.Lerp(iter_350_2.color.r, 1, var_350_10)

								iter_350_2.color = Color.New(var_350_14, var_350_14, var_350_14)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_8 + var_350_9 and arg_347_1.time_ < var_350_8 + var_350_9 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps10059 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_350_4 then
						if arg_347_1.isInRecall_ then
							iter_350_4.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10059 = nil
			end

			local var_350_15 = 0
			local var_350_16 = 0.925

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_17 = arg_347_1:FormatText(StoryNameCfg[596].name)

				arg_347_1.leftNameTxt_.text = var_350_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_18 = arg_347_1:GetWordFromCfg(410161084)
				local var_350_19 = arg_347_1:FormatText(var_350_18.content)

				arg_347_1.text_.text = var_350_19

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_20 = 37
				local var_350_21 = utf8.len(var_350_19)
				local var_350_22 = var_350_20 <= 0 and var_350_16 or var_350_16 * (var_350_21 / var_350_20)

				if var_350_22 > 0 and var_350_16 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22

					if var_350_22 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_19
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161084", "story_v_out_410161.awb") ~= 0 then
					local var_350_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161084", "story_v_out_410161.awb") / 1000

					if var_350_23 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_15
					end

					if var_350_18.prefab_name ~= "" and arg_347_1.actors_[var_350_18.prefab_name] ~= nil then
						local var_350_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_18.prefab_name].transform, "story_v_out_410161", "410161084", "story_v_out_410161.awb")

						arg_347_1:RecordAudio("410161084", var_350_24)
						arg_347_1:RecordAudio("410161084", var_350_24)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_410161", "410161084", "story_v_out_410161.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_410161", "410161084", "story_v_out_410161.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_25 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_25 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_25

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_25 and arg_347_1.time_ < var_350_15 + var_350_25 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 410161085
		arg_351_1.duration_ = 7.97

		local var_351_0 = {
			ja = 7.966,
			CriLanguages = 2.966,
			zh = 2.966
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
				arg_351_0:Play410161086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1061"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1061 = var_354_0.localPosition
				var_354_0.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1061", 2)

				local var_354_2 = var_354_0.childCount

				for iter_354_0 = 0, var_354_2 - 1 do
					local var_354_3 = var_354_0:GetChild(iter_354_0)

					if var_354_3.name == "" or not string.find(var_354_3.name, "split") then
						var_354_3.gameObject:SetActive(true)
					else
						var_354_3.gameObject:SetActive(false)
					end
				end
			end

			local var_354_4 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_4 then
				local var_354_5 = (arg_351_1.time_ - var_354_1) / var_354_4
				local var_354_6 = Vector3.New(-390, -490, 18)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1061, var_354_6, var_354_5)
			end

			if arg_351_1.time_ >= var_354_1 + var_354_4 and arg_351_1.time_ < var_354_1 + var_354_4 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_354_7 = arg_351_1.actors_["1061"]
			local var_354_8 = 0

			if var_354_8 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 and not isNil(var_354_7) and arg_351_1.var_.actorSpriteComps1061 == nil then
				arg_351_1.var_.actorSpriteComps1061 = var_354_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_9 = 0.034

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_9 and not isNil(var_354_7) then
				local var_354_10 = (arg_351_1.time_ - var_354_8) / var_354_9

				if arg_351_1.var_.actorSpriteComps1061 then
					for iter_354_1, iter_354_2 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_354_2 then
							if arg_351_1.isInRecall_ then
								local var_354_11 = Mathf.Lerp(iter_354_2.color.r, arg_351_1.hightColor1.r, var_354_10)
								local var_354_12 = Mathf.Lerp(iter_354_2.color.g, arg_351_1.hightColor1.g, var_354_10)
								local var_354_13 = Mathf.Lerp(iter_354_2.color.b, arg_351_1.hightColor1.b, var_354_10)

								iter_354_2.color = Color.New(var_354_11, var_354_12, var_354_13)
							else
								local var_354_14 = Mathf.Lerp(iter_354_2.color.r, 1, var_354_10)

								iter_354_2.color = Color.New(var_354_14, var_354_14, var_354_14)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_8 + var_354_9 and arg_351_1.time_ < var_354_8 + var_354_9 + arg_354_0 and not isNil(var_354_7) and arg_351_1.var_.actorSpriteComps1061 then
				for iter_354_3, iter_354_4 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_354_4 then
						if arg_351_1.isInRecall_ then
							iter_354_4.color = arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_354_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps1061 = nil
			end

			local var_354_15 = arg_351_1.actors_["10059"]
			local var_354_16 = 0

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 and not isNil(var_354_15) and arg_351_1.var_.actorSpriteComps10059 == nil then
				arg_351_1.var_.actorSpriteComps10059 = var_354_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_17 = 0.034

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_17 and not isNil(var_354_15) then
				local var_354_18 = (arg_351_1.time_ - var_354_16) / var_354_17

				if arg_351_1.var_.actorSpriteComps10059 then
					for iter_354_5, iter_354_6 in pairs(arg_351_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_354_6 then
							if arg_351_1.isInRecall_ then
								local var_354_19 = Mathf.Lerp(iter_354_6.color.r, arg_351_1.hightColor2.r, var_354_18)
								local var_354_20 = Mathf.Lerp(iter_354_6.color.g, arg_351_1.hightColor2.g, var_354_18)
								local var_354_21 = Mathf.Lerp(iter_354_6.color.b, arg_351_1.hightColor2.b, var_354_18)

								iter_354_6.color = Color.New(var_354_19, var_354_20, var_354_21)
							else
								local var_354_22 = Mathf.Lerp(iter_354_6.color.r, 0.5, var_354_18)

								iter_354_6.color = Color.New(var_354_22, var_354_22, var_354_22)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_16 + var_354_17 and arg_351_1.time_ < var_354_16 + var_354_17 + arg_354_0 and not isNil(var_354_15) and arg_351_1.var_.actorSpriteComps10059 then
				for iter_354_7, iter_354_8 in pairs(arg_351_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_354_8 then
						if arg_351_1.isInRecall_ then
							iter_354_8.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10059 = nil
			end

			local var_354_23 = 0
			local var_354_24 = 0.375

			if var_354_23 < arg_351_1.time_ and arg_351_1.time_ <= var_354_23 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_25 = arg_351_1:FormatText(StoryNameCfg[612].name)

				arg_351_1.leftNameTxt_.text = var_354_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_26 = arg_351_1:GetWordFromCfg(410161085)
				local var_354_27 = arg_351_1:FormatText(var_354_26.content)

				arg_351_1.text_.text = var_354_27

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_28 = 15
				local var_354_29 = utf8.len(var_354_27)
				local var_354_30 = var_354_28 <= 0 and var_354_24 or var_354_24 * (var_354_29 / var_354_28)

				if var_354_30 > 0 and var_354_24 < var_354_30 then
					arg_351_1.talkMaxDuration = var_354_30

					if var_354_30 + var_354_23 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_30 + var_354_23
					end
				end

				arg_351_1.text_.text = var_354_27
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161085", "story_v_out_410161.awb") ~= 0 then
					local var_354_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161085", "story_v_out_410161.awb") / 1000

					if var_354_31 + var_354_23 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_31 + var_354_23
					end

					if var_354_26.prefab_name ~= "" and arg_351_1.actors_[var_354_26.prefab_name] ~= nil then
						local var_354_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_26.prefab_name].transform, "story_v_out_410161", "410161085", "story_v_out_410161.awb")

						arg_351_1:RecordAudio("410161085", var_354_32)
						arg_351_1:RecordAudio("410161085", var_354_32)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_410161", "410161085", "story_v_out_410161.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_410161", "410161085", "story_v_out_410161.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_33 = math.max(var_354_24, arg_351_1.talkMaxDuration)

			if var_354_23 <= arg_351_1.time_ and arg_351_1.time_ < var_354_23 + var_354_33 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_23) / var_354_33

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_23 + var_354_33 and arg_351_1.time_ < var_354_23 + var_354_33 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play410161086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 410161086
		arg_355_1.duration_ = 8.67

		local var_355_0 = {
			ja = 8.666,
			CriLanguages = 7.066,
			zh = 7.066
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
				arg_355_0:Play410161087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10059"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10059 = var_358_0.localPosition
				var_358_0.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10059", 4)

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
				local var_358_6 = Vector3.New(390, -530, 35)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10059, var_358_6, var_358_5)
			end

			if arg_355_1.time_ >= var_358_1 + var_358_4 and arg_355_1.time_ < var_358_1 + var_358_4 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_358_7 = arg_355_1.actors_["10059"]
			local var_358_8 = 0

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 and not isNil(var_358_7) and arg_355_1.var_.actorSpriteComps10059 == nil then
				arg_355_1.var_.actorSpriteComps10059 = var_358_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_9 = 0.034

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_9 and not isNil(var_358_7) then
				local var_358_10 = (arg_355_1.time_ - var_358_8) / var_358_9

				if arg_355_1.var_.actorSpriteComps10059 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								local var_358_11 = Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor1.r, var_358_10)
								local var_358_12 = Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor1.g, var_358_10)
								local var_358_13 = Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor1.b, var_358_10)

								iter_358_2.color = Color.New(var_358_11, var_358_12, var_358_13)
							else
								local var_358_14 = Mathf.Lerp(iter_358_2.color.r, 1, var_358_10)

								iter_358_2.color = Color.New(var_358_14, var_358_14, var_358_14)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_8 + var_358_9 and arg_355_1.time_ < var_358_8 + var_358_9 + arg_358_0 and not isNil(var_358_7) and arg_355_1.var_.actorSpriteComps10059 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_358_4 then
						if arg_355_1.isInRecall_ then
							iter_358_4.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_358_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10059 = nil
			end

			local var_358_15 = arg_355_1.actors_["1061"]
			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.actorSpriteComps1061 == nil then
				arg_355_1.var_.actorSpriteComps1061 = var_358_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_17 = 0.034

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_17 and not isNil(var_358_15) then
				local var_358_18 = (arg_355_1.time_ - var_358_16) / var_358_17

				if arg_355_1.var_.actorSpriteComps1061 then
					for iter_358_5, iter_358_6 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_358_6 then
							if arg_355_1.isInRecall_ then
								local var_358_19 = Mathf.Lerp(iter_358_6.color.r, arg_355_1.hightColor2.r, var_358_18)
								local var_358_20 = Mathf.Lerp(iter_358_6.color.g, arg_355_1.hightColor2.g, var_358_18)
								local var_358_21 = Mathf.Lerp(iter_358_6.color.b, arg_355_1.hightColor2.b, var_358_18)

								iter_358_6.color = Color.New(var_358_19, var_358_20, var_358_21)
							else
								local var_358_22 = Mathf.Lerp(iter_358_6.color.r, 0.5, var_358_18)

								iter_358_6.color = Color.New(var_358_22, var_358_22, var_358_22)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_16 + var_358_17 and arg_355_1.time_ < var_358_16 + var_358_17 + arg_358_0 and not isNil(var_358_15) and arg_355_1.var_.actorSpriteComps1061 then
				for iter_358_7, iter_358_8 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_358_8 then
						if arg_355_1.isInRecall_ then
							iter_358_8.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps1061 = nil
			end

			local var_358_23 = 0
			local var_358_24 = 0.925

			if var_358_23 < arg_355_1.time_ and arg_355_1.time_ <= var_358_23 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_25 = arg_355_1:FormatText(StoryNameCfg[596].name)

				arg_355_1.leftNameTxt_.text = var_358_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_26 = arg_355_1:GetWordFromCfg(410161086)
				local var_358_27 = arg_355_1:FormatText(var_358_26.content)

				arg_355_1.text_.text = var_358_27

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_28 = 37
				local var_358_29 = utf8.len(var_358_27)
				local var_358_30 = var_358_28 <= 0 and var_358_24 or var_358_24 * (var_358_29 / var_358_28)

				if var_358_30 > 0 and var_358_24 < var_358_30 then
					arg_355_1.talkMaxDuration = var_358_30

					if var_358_30 + var_358_23 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_30 + var_358_23
					end
				end

				arg_355_1.text_.text = var_358_27
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161086", "story_v_out_410161.awb") ~= 0 then
					local var_358_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161086", "story_v_out_410161.awb") / 1000

					if var_358_31 + var_358_23 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_31 + var_358_23
					end

					if var_358_26.prefab_name ~= "" and arg_355_1.actors_[var_358_26.prefab_name] ~= nil then
						local var_358_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_26.prefab_name].transform, "story_v_out_410161", "410161086", "story_v_out_410161.awb")

						arg_355_1:RecordAudio("410161086", var_358_32)
						arg_355_1:RecordAudio("410161086", var_358_32)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_410161", "410161086", "story_v_out_410161.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_410161", "410161086", "story_v_out_410161.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_33 = math.max(var_358_24, arg_355_1.talkMaxDuration)

			if var_358_23 <= arg_355_1.time_ and arg_355_1.time_ < var_358_23 + var_358_33 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_23) / var_358_33

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_23 + var_358_33 and arg_355_1.time_ < var_358_23 + var_358_33 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 410161087
		arg_359_1.duration_ = 3.7

		local var_359_0 = {
			ja = 3.333,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_359_0:Play410161088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10059"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos10059 = var_362_0.localPosition
				var_362_0.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10059", 4)

				local var_362_2 = var_362_0.childCount

				for iter_362_0 = 0, var_362_2 - 1 do
					local var_362_3 = var_362_0:GetChild(iter_362_0)

					if var_362_3.name == "" or not string.find(var_362_3.name, "split") then
						var_362_3.gameObject:SetActive(true)
					else
						var_362_3.gameObject:SetActive(false)
					end
				end
			end

			local var_362_4 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_4 then
				local var_362_5 = (arg_359_1.time_ - var_362_1) / var_362_4
				local var_362_6 = Vector3.New(390, -530, 35)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10059, var_362_6, var_362_5)
			end

			if arg_359_1.time_ >= var_362_1 + var_362_4 and arg_359_1.time_ < var_362_1 + var_362_4 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_362_7 = arg_359_1.actors_["10059"]
			local var_362_8 = 0

			if var_362_8 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.actorSpriteComps10059 == nil then
				arg_359_1.var_.actorSpriteComps10059 = var_362_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_9 = 0.034

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_9 and not isNil(var_362_7) then
				local var_362_10 = (arg_359_1.time_ - var_362_8) / var_362_9

				if arg_359_1.var_.actorSpriteComps10059 then
					for iter_362_1, iter_362_2 in pairs(arg_359_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_362_2 then
							if arg_359_1.isInRecall_ then
								local var_362_11 = Mathf.Lerp(iter_362_2.color.r, arg_359_1.hightColor1.r, var_362_10)
								local var_362_12 = Mathf.Lerp(iter_362_2.color.g, arg_359_1.hightColor1.g, var_362_10)
								local var_362_13 = Mathf.Lerp(iter_362_2.color.b, arg_359_1.hightColor1.b, var_362_10)

								iter_362_2.color = Color.New(var_362_11, var_362_12, var_362_13)
							else
								local var_362_14 = Mathf.Lerp(iter_362_2.color.r, 1, var_362_10)

								iter_362_2.color = Color.New(var_362_14, var_362_14, var_362_14)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_8 + var_362_9 and arg_359_1.time_ < var_362_8 + var_362_9 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.actorSpriteComps10059 then
				for iter_362_3, iter_362_4 in pairs(arg_359_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_362_4 then
						if arg_359_1.isInRecall_ then
							iter_362_4.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10059 = nil
			end

			local var_362_15 = 0
			local var_362_16 = 0.3

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[596].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(410161087)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161087", "story_v_out_410161.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161087", "story_v_out_410161.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_out_410161", "410161087", "story_v_out_410161.awb")

						arg_359_1:RecordAudio("410161087", var_362_24)
						arg_359_1:RecordAudio("410161087", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_410161", "410161087", "story_v_out_410161.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_410161", "410161087", "story_v_out_410161.awb")
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
				actorName = "10059",
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
	Play410161088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 410161088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play410161089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1061"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1061 == nil then
				arg_363_1.var_.actorSpriteComps1061 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.034

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps1061 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1061 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps1061 = nil
			end

			local var_366_8 = arg_363_1.actors_["10059"]
			local var_366_9 = 0

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps10059 == nil then
				arg_363_1.var_.actorSpriteComps10059 = var_366_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_10 = 0.034

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_10 and not isNil(var_366_8) then
				local var_366_11 = (arg_363_1.time_ - var_366_9) / var_366_10

				if arg_363_1.var_.actorSpriteComps10059 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								local var_366_12 = Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor2.r, var_366_11)
								local var_366_13 = Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor2.g, var_366_11)
								local var_366_14 = Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor2.b, var_366_11)

								iter_366_5.color = Color.New(var_366_12, var_366_13, var_366_14)
							else
								local var_366_15 = Mathf.Lerp(iter_366_5.color.r, 0.5, var_366_11)

								iter_366_5.color = Color.New(var_366_15, var_366_15, var_366_15)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_9 + var_366_10 and arg_363_1.time_ < var_366_9 + var_366_10 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps10059 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_366_7 then
						if arg_363_1.isInRecall_ then
							iter_366_7.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10059 = nil
			end

			local var_366_16 = 0
			local var_366_17 = 0.85

			if var_366_16 < arg_363_1.time_ and arg_363_1.time_ <= var_366_16 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(410161088)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 34
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_17 or var_366_17 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_17 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_16 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_16
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_23 = math.max(var_366_17, arg_363_1.talkMaxDuration)

			if var_366_16 <= arg_363_1.time_ and arg_363_1.time_ < var_366_16 + var_366_23 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_16) / var_366_23

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_16 + var_366_23 and arg_363_1.time_ < var_366_16 + var_366_23 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play410161089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 410161089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play410161090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.925

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

				local var_370_2 = arg_367_1:GetWordFromCfg(410161089)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 37
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
	Play410161090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 410161090
		arg_371_1.duration_ = 14.6

		local var_371_0 = {
			ja = 14.6,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_371_0:Play410161091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10059"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos10059 = var_374_0.localPosition
				var_374_0.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10059", 4)

				local var_374_2 = var_374_0.childCount

				for iter_374_0 = 0, var_374_2 - 1 do
					local var_374_3 = var_374_0:GetChild(iter_374_0)

					if var_374_3.name == "" or not string.find(var_374_3.name, "split") then
						var_374_3.gameObject:SetActive(true)
					else
						var_374_3.gameObject:SetActive(false)
					end
				end
			end

			local var_374_4 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_4 then
				local var_374_5 = (arg_371_1.time_ - var_374_1) / var_374_4
				local var_374_6 = Vector3.New(390, -530, 35)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10059, var_374_6, var_374_5)
			end

			if arg_371_1.time_ >= var_374_1 + var_374_4 and arg_371_1.time_ < var_374_1 + var_374_4 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_374_7 = arg_371_1.actors_["10059"]
			local var_374_8 = 0

			if var_374_8 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 and not isNil(var_374_7) and arg_371_1.var_.actorSpriteComps10059 == nil then
				arg_371_1.var_.actorSpriteComps10059 = var_374_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_9 = 0.034

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_9 and not isNil(var_374_7) then
				local var_374_10 = (arg_371_1.time_ - var_374_8) / var_374_9

				if arg_371_1.var_.actorSpriteComps10059 then
					for iter_374_1, iter_374_2 in pairs(arg_371_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_374_2 then
							if arg_371_1.isInRecall_ then
								local var_374_11 = Mathf.Lerp(iter_374_2.color.r, arg_371_1.hightColor1.r, var_374_10)
								local var_374_12 = Mathf.Lerp(iter_374_2.color.g, arg_371_1.hightColor1.g, var_374_10)
								local var_374_13 = Mathf.Lerp(iter_374_2.color.b, arg_371_1.hightColor1.b, var_374_10)

								iter_374_2.color = Color.New(var_374_11, var_374_12, var_374_13)
							else
								local var_374_14 = Mathf.Lerp(iter_374_2.color.r, 1, var_374_10)

								iter_374_2.color = Color.New(var_374_14, var_374_14, var_374_14)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_8 + var_374_9 and arg_371_1.time_ < var_374_8 + var_374_9 + arg_374_0 and not isNil(var_374_7) and arg_371_1.var_.actorSpriteComps10059 then
				for iter_374_3, iter_374_4 in pairs(arg_371_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_374_4 then
						if arg_371_1.isInRecall_ then
							iter_374_4.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10059 = nil
			end

			local var_374_15 = 0
			local var_374_16 = 1.35

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[596].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(410161090)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161090", "story_v_out_410161.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161090", "story_v_out_410161.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_410161", "410161090", "story_v_out_410161.awb")

						arg_371_1:RecordAudio("410161090", var_374_24)
						arg_371_1:RecordAudio("410161090", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_410161", "410161090", "story_v_out_410161.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_410161", "410161090", "story_v_out_410161.awb")
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
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play410161091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 410161091
		arg_375_1.duration_ = 7.93

		local var_375_0 = {
			ja = 7.933,
			CriLanguages = 6.633,
			zh = 6.633
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play410161092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10059"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos10059 = var_378_0.localPosition
				var_378_0.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10059", 4)

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
				local var_378_6 = Vector3.New(390, -530, 35)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10059, var_378_6, var_378_5)
			end

			if arg_375_1.time_ >= var_378_1 + var_378_4 and arg_375_1.time_ < var_378_1 + var_378_4 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_378_7 = arg_375_1.actors_["10059"]
			local var_378_8 = 0

			if var_378_8 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 and not isNil(var_378_7) and arg_375_1.var_.actorSpriteComps10059 == nil then
				arg_375_1.var_.actorSpriteComps10059 = var_378_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_9 = 0.034

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_9 and not isNil(var_378_7) then
				local var_378_10 = (arg_375_1.time_ - var_378_8) / var_378_9

				if arg_375_1.var_.actorSpriteComps10059 then
					for iter_378_1, iter_378_2 in pairs(arg_375_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_378_2 then
							if arg_375_1.isInRecall_ then
								local var_378_11 = Mathf.Lerp(iter_378_2.color.r, arg_375_1.hightColor1.r, var_378_10)
								local var_378_12 = Mathf.Lerp(iter_378_2.color.g, arg_375_1.hightColor1.g, var_378_10)
								local var_378_13 = Mathf.Lerp(iter_378_2.color.b, arg_375_1.hightColor1.b, var_378_10)

								iter_378_2.color = Color.New(var_378_11, var_378_12, var_378_13)
							else
								local var_378_14 = Mathf.Lerp(iter_378_2.color.r, 1, var_378_10)

								iter_378_2.color = Color.New(var_378_14, var_378_14, var_378_14)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_8 + var_378_9 and arg_375_1.time_ < var_378_8 + var_378_9 + arg_378_0 and not isNil(var_378_7) and arg_375_1.var_.actorSpriteComps10059 then
				for iter_378_3, iter_378_4 in pairs(arg_375_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_378_4 then
						if arg_375_1.isInRecall_ then
							iter_378_4.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10059 = nil
			end

			local var_378_15 = 0
			local var_378_16 = 0.9

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[596].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(410161091)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 36
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161091", "story_v_out_410161.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161091", "story_v_out_410161.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_410161", "410161091", "story_v_out_410161.awb")

						arg_375_1:RecordAudio("410161091", var_378_24)
						arg_375_1:RecordAudio("410161091", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_410161", "410161091", "story_v_out_410161.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_410161", "410161091", "story_v_out_410161.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410161092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 410161092
		arg_379_1.duration_ = 10.1

		local var_379_0 = {
			ja = 10.1,
			CriLanguages = 9.3,
			zh = 9.3
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
				arg_379_0:Play410161093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1061"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1061 = var_382_0.localPosition
				var_382_0.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("1061", 2)

				local var_382_2 = var_382_0.childCount

				for iter_382_0 = 0, var_382_2 - 1 do
					local var_382_3 = var_382_0:GetChild(iter_382_0)

					if var_382_3.name == "" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_4 then
				local var_382_5 = (arg_379_1.time_ - var_382_1) / var_382_4
				local var_382_6 = Vector3.New(-390, -490, 18)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1061, var_382_6, var_382_5)
			end

			if arg_379_1.time_ >= var_382_1 + var_382_4 and arg_379_1.time_ < var_382_1 + var_382_4 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_382_7 = arg_379_1.actors_["1061"]
			local var_382_8 = 0

			if var_382_8 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 and not isNil(var_382_7) and arg_379_1.var_.actorSpriteComps1061 == nil then
				arg_379_1.var_.actorSpriteComps1061 = var_382_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_9 = 0.034

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_9 and not isNil(var_382_7) then
				local var_382_10 = (arg_379_1.time_ - var_382_8) / var_382_9

				if arg_379_1.var_.actorSpriteComps1061 then
					for iter_382_1, iter_382_2 in pairs(arg_379_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_382_2 then
							if arg_379_1.isInRecall_ then
								local var_382_11 = Mathf.Lerp(iter_382_2.color.r, arg_379_1.hightColor1.r, var_382_10)
								local var_382_12 = Mathf.Lerp(iter_382_2.color.g, arg_379_1.hightColor1.g, var_382_10)
								local var_382_13 = Mathf.Lerp(iter_382_2.color.b, arg_379_1.hightColor1.b, var_382_10)

								iter_382_2.color = Color.New(var_382_11, var_382_12, var_382_13)
							else
								local var_382_14 = Mathf.Lerp(iter_382_2.color.r, 1, var_382_10)

								iter_382_2.color = Color.New(var_382_14, var_382_14, var_382_14)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_8 + var_382_9 and arg_379_1.time_ < var_382_8 + var_382_9 + arg_382_0 and not isNil(var_382_7) and arg_379_1.var_.actorSpriteComps1061 then
				for iter_382_3, iter_382_4 in pairs(arg_379_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_382_4 then
						if arg_379_1.isInRecall_ then
							iter_382_4.color = arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_382_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps1061 = nil
			end

			local var_382_15 = arg_379_1.actors_["10059"]
			local var_382_16 = 0

			if var_382_16 < arg_379_1.time_ and arg_379_1.time_ <= var_382_16 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.actorSpriteComps10059 == nil then
				arg_379_1.var_.actorSpriteComps10059 = var_382_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_17 = 0.034

			if var_382_16 <= arg_379_1.time_ and arg_379_1.time_ < var_382_16 + var_382_17 and not isNil(var_382_15) then
				local var_382_18 = (arg_379_1.time_ - var_382_16) / var_382_17

				if arg_379_1.var_.actorSpriteComps10059 then
					for iter_382_5, iter_382_6 in pairs(arg_379_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_382_6 then
							if arg_379_1.isInRecall_ then
								local var_382_19 = Mathf.Lerp(iter_382_6.color.r, arg_379_1.hightColor2.r, var_382_18)
								local var_382_20 = Mathf.Lerp(iter_382_6.color.g, arg_379_1.hightColor2.g, var_382_18)
								local var_382_21 = Mathf.Lerp(iter_382_6.color.b, arg_379_1.hightColor2.b, var_382_18)

								iter_382_6.color = Color.New(var_382_19, var_382_20, var_382_21)
							else
								local var_382_22 = Mathf.Lerp(iter_382_6.color.r, 0.5, var_382_18)

								iter_382_6.color = Color.New(var_382_22, var_382_22, var_382_22)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_16 + var_382_17 and arg_379_1.time_ < var_382_16 + var_382_17 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.actorSpriteComps10059 then
				for iter_382_7, iter_382_8 in pairs(arg_379_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_382_8 then
						if arg_379_1.isInRecall_ then
							iter_382_8.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps10059 = nil
			end

			local var_382_23 = 0
			local var_382_24 = 0.9

			if var_382_23 < arg_379_1.time_ and arg_379_1.time_ <= var_382_23 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_25 = arg_379_1:FormatText(StoryNameCfg[612].name)

				arg_379_1.leftNameTxt_.text = var_382_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_26 = arg_379_1:GetWordFromCfg(410161092)
				local var_382_27 = arg_379_1:FormatText(var_382_26.content)

				arg_379_1.text_.text = var_382_27

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_28 = 36
				local var_382_29 = utf8.len(var_382_27)
				local var_382_30 = var_382_28 <= 0 and var_382_24 or var_382_24 * (var_382_29 / var_382_28)

				if var_382_30 > 0 and var_382_24 < var_382_30 then
					arg_379_1.talkMaxDuration = var_382_30

					if var_382_30 + var_382_23 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_30 + var_382_23
					end
				end

				arg_379_1.text_.text = var_382_27
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161092", "story_v_out_410161.awb") ~= 0 then
					local var_382_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161092", "story_v_out_410161.awb") / 1000

					if var_382_31 + var_382_23 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_31 + var_382_23
					end

					if var_382_26.prefab_name ~= "" and arg_379_1.actors_[var_382_26.prefab_name] ~= nil then
						local var_382_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_26.prefab_name].transform, "story_v_out_410161", "410161092", "story_v_out_410161.awb")

						arg_379_1:RecordAudio("410161092", var_382_32)
						arg_379_1:RecordAudio("410161092", var_382_32)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_410161", "410161092", "story_v_out_410161.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_410161", "410161092", "story_v_out_410161.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_33 = math.max(var_382_24, arg_379_1.talkMaxDuration)

			if var_382_23 <= arg_379_1.time_ and arg_379_1.time_ < var_382_23 + var_382_33 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_23) / var_382_33

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_23 + var_382_33 and arg_379_1.time_ < var_382_23 + var_382_33 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410161093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 410161093
		arg_383_1.duration_ = 7.73

		local var_383_0 = {
			ja = 7.733,
			CriLanguages = 6.033,
			zh = 6.033
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
				arg_383_0:Play410161094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1061"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1061 = var_386_0.localPosition
				var_386_0.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1061", 2)

				local var_386_2 = var_386_0.childCount

				for iter_386_0 = 0, var_386_2 - 1 do
					local var_386_3 = var_386_0:GetChild(iter_386_0)

					if var_386_3.name == "" or not string.find(var_386_3.name, "split") then
						var_386_3.gameObject:SetActive(true)
					else
						var_386_3.gameObject:SetActive(false)
					end
				end
			end

			local var_386_4 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_4 then
				local var_386_5 = (arg_383_1.time_ - var_386_1) / var_386_4
				local var_386_6 = Vector3.New(-390, -490, 18)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1061, var_386_6, var_386_5)
			end

			if arg_383_1.time_ >= var_386_1 + var_386_4 and arg_383_1.time_ < var_386_1 + var_386_4 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_386_7 = arg_383_1.actors_["1061"]
			local var_386_8 = 0

			if var_386_8 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps1061 == nil then
				arg_383_1.var_.actorSpriteComps1061 = var_386_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_9 = 0.034

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_9 and not isNil(var_386_7) then
				local var_386_10 = (arg_383_1.time_ - var_386_8) / var_386_9

				if arg_383_1.var_.actorSpriteComps1061 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								local var_386_11 = Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor1.r, var_386_10)
								local var_386_12 = Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor1.g, var_386_10)
								local var_386_13 = Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor1.b, var_386_10)

								iter_386_2.color = Color.New(var_386_11, var_386_12, var_386_13)
							else
								local var_386_14 = Mathf.Lerp(iter_386_2.color.r, 1, var_386_10)

								iter_386_2.color = Color.New(var_386_14, var_386_14, var_386_14)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_8 + var_386_9 and arg_383_1.time_ < var_386_8 + var_386_9 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps1061 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_386_4 then
						if arg_383_1.isInRecall_ then
							iter_386_4.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps1061 = nil
			end

			local var_386_15 = 0
			local var_386_16 = 0.7

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[612].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_18 = arg_383_1:GetWordFromCfg(410161093)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 28
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_16 or var_386_16 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_16 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22

					if var_386_22 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161093", "story_v_out_410161.awb") ~= 0 then
					local var_386_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161093", "story_v_out_410161.awb") / 1000

					if var_386_23 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_23 + var_386_15
					end

					if var_386_18.prefab_name ~= "" and arg_383_1.actors_[var_386_18.prefab_name] ~= nil then
						local var_386_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_18.prefab_name].transform, "story_v_out_410161", "410161093", "story_v_out_410161.awb")

						arg_383_1:RecordAudio("410161093", var_386_24)
						arg_383_1:RecordAudio("410161093", var_386_24)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_410161", "410161093", "story_v_out_410161.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_410161", "410161093", "story_v_out_410161.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_25 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_25 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_25

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_25 and arg_383_1.time_ < var_386_15 + var_386_25 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play410161094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 410161094
		arg_387_1.duration_ = 15.67

		local var_387_0 = {
			ja = 15.666,
			CriLanguages = 13.433,
			zh = 13.433
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play410161095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1061"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1061 = var_390_0.localPosition
				var_390_0.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("1061", 2)

				local var_390_2 = var_390_0.childCount

				for iter_390_0 = 0, var_390_2 - 1 do
					local var_390_3 = var_390_0:GetChild(iter_390_0)

					if var_390_3.name == "" or not string.find(var_390_3.name, "split") then
						var_390_3.gameObject:SetActive(true)
					else
						var_390_3.gameObject:SetActive(false)
					end
				end
			end

			local var_390_4 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_4 then
				local var_390_5 = (arg_387_1.time_ - var_390_1) / var_390_4
				local var_390_6 = Vector3.New(-390, -490, 18)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1061, var_390_6, var_390_5)
			end

			if arg_387_1.time_ >= var_390_1 + var_390_4 and arg_387_1.time_ < var_390_1 + var_390_4 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_390_7 = arg_387_1.actors_["1061"]
			local var_390_8 = 0

			if var_390_8 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 and not isNil(var_390_7) and arg_387_1.var_.actorSpriteComps1061 == nil then
				arg_387_1.var_.actorSpriteComps1061 = var_390_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_9 = 0.034

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_9 and not isNil(var_390_7) then
				local var_390_10 = (arg_387_1.time_ - var_390_8) / var_390_9

				if arg_387_1.var_.actorSpriteComps1061 then
					for iter_390_1, iter_390_2 in pairs(arg_387_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_390_2 then
							if arg_387_1.isInRecall_ then
								local var_390_11 = Mathf.Lerp(iter_390_2.color.r, arg_387_1.hightColor1.r, var_390_10)
								local var_390_12 = Mathf.Lerp(iter_390_2.color.g, arg_387_1.hightColor1.g, var_390_10)
								local var_390_13 = Mathf.Lerp(iter_390_2.color.b, arg_387_1.hightColor1.b, var_390_10)

								iter_390_2.color = Color.New(var_390_11, var_390_12, var_390_13)
							else
								local var_390_14 = Mathf.Lerp(iter_390_2.color.r, 1, var_390_10)

								iter_390_2.color = Color.New(var_390_14, var_390_14, var_390_14)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_8 + var_390_9 and arg_387_1.time_ < var_390_8 + var_390_9 + arg_390_0 and not isNil(var_390_7) and arg_387_1.var_.actorSpriteComps1061 then
				for iter_390_3, iter_390_4 in pairs(arg_387_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_390_4 then
						if arg_387_1.isInRecall_ then
							iter_390_4.color = arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_390_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps1061 = nil
			end

			local var_390_15 = 0
			local var_390_16 = 1.425

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[612].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(410161094)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 57
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_16 or var_390_16 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_16 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22

					if var_390_22 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_15
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161094", "story_v_out_410161.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161094", "story_v_out_410161.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_410161", "410161094", "story_v_out_410161.awb")

						arg_387_1:RecordAudio("410161094", var_390_24)
						arg_387_1:RecordAudio("410161094", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_410161", "410161094", "story_v_out_410161.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_410161", "410161094", "story_v_out_410161.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = math.max(var_390_16, arg_387_1.talkMaxDuration)

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_25 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_15) / var_390_25

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_15 + var_390_25 and arg_387_1.time_ < var_390_15 + var_390_25 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play410161095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 410161095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play410161096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1061"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.actorSpriteComps1061 == nil then
				arg_391_1.var_.actorSpriteComps1061 = var_394_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_2 = 0.034

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.actorSpriteComps1061 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								local var_394_4 = Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor2.r, var_394_3)
								local var_394_5 = Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor2.g, var_394_3)
								local var_394_6 = Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor2.b, var_394_3)

								iter_394_1.color = Color.New(var_394_4, var_394_5, var_394_6)
							else
								local var_394_7 = Mathf.Lerp(iter_394_1.color.r, 0.5, var_394_3)

								iter_394_1.color = Color.New(var_394_7, var_394_7, var_394_7)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.actorSpriteComps1061 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_394_3 then
						if arg_391_1.isInRecall_ then
							iter_394_3.color = arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_394_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_391_1.var_.actorSpriteComps1061 = nil
			end

			local var_394_8 = arg_391_1.actors_["10059"]
			local var_394_9 = 0

			if var_394_9 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 and not isNil(var_394_8) and arg_391_1.var_.actorSpriteComps10059 == nil then
				arg_391_1.var_.actorSpriteComps10059 = var_394_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_10 = 0.034

			if var_394_9 <= arg_391_1.time_ and arg_391_1.time_ < var_394_9 + var_394_10 and not isNil(var_394_8) then
				local var_394_11 = (arg_391_1.time_ - var_394_9) / var_394_10

				if arg_391_1.var_.actorSpriteComps10059 then
					for iter_394_4, iter_394_5 in pairs(arg_391_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_394_5 then
							if arg_391_1.isInRecall_ then
								local var_394_12 = Mathf.Lerp(iter_394_5.color.r, arg_391_1.hightColor2.r, var_394_11)
								local var_394_13 = Mathf.Lerp(iter_394_5.color.g, arg_391_1.hightColor2.g, var_394_11)
								local var_394_14 = Mathf.Lerp(iter_394_5.color.b, arg_391_1.hightColor2.b, var_394_11)

								iter_394_5.color = Color.New(var_394_12, var_394_13, var_394_14)
							else
								local var_394_15 = Mathf.Lerp(iter_394_5.color.r, 0.5, var_394_11)

								iter_394_5.color = Color.New(var_394_15, var_394_15, var_394_15)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= var_394_9 + var_394_10 and arg_391_1.time_ < var_394_9 + var_394_10 + arg_394_0 and not isNil(var_394_8) and arg_391_1.var_.actorSpriteComps10059 then
				for iter_394_6, iter_394_7 in pairs(arg_391_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_394_7 then
						if arg_391_1.isInRecall_ then
							iter_394_7.color = arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_394_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_391_1.var_.actorSpriteComps10059 = nil
			end

			local var_394_16 = 0
			local var_394_17 = 1

			if var_394_16 < arg_391_1.time_ and arg_391_1.time_ <= var_394_16 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(410161095)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 40
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_17 or var_394_17 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_17 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22

					if var_394_22 + var_394_16 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_16
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_23 = math.max(var_394_17, arg_391_1.talkMaxDuration)

			if var_394_16 <= arg_391_1.time_ and arg_391_1.time_ < var_394_16 + var_394_23 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_16) / var_394_23

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_16 + var_394_23 and arg_391_1.time_ < var_394_16 + var_394_23 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play410161096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 410161096
		arg_395_1.duration_ = 6.77

		local var_395_0 = {
			ja = 6.766,
			CriLanguages = 3.833,
			zh = 3.833
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play410161097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["10059"].transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.var_.moveOldPos10059 = var_398_0.localPosition
				var_398_0.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10059", 4)

				local var_398_2 = var_398_0.childCount

				for iter_398_0 = 0, var_398_2 - 1 do
					local var_398_3 = var_398_0:GetChild(iter_398_0)

					if var_398_3.name == "" or not string.find(var_398_3.name, "split") then
						var_398_3.gameObject:SetActive(true)
					else
						var_398_3.gameObject:SetActive(false)
					end
				end
			end

			local var_398_4 = 0.001

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_4 then
				local var_398_5 = (arg_395_1.time_ - var_398_1) / var_398_4
				local var_398_6 = Vector3.New(390, -530, 35)

				var_398_0.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10059, var_398_6, var_398_5)
			end

			if arg_395_1.time_ >= var_398_1 + var_398_4 and arg_395_1.time_ < var_398_1 + var_398_4 + arg_398_0 then
				var_398_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_398_7 = arg_395_1.actors_["10059"]
			local var_398_8 = 0

			if var_398_8 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 and not isNil(var_398_7) and arg_395_1.var_.actorSpriteComps10059 == nil then
				arg_395_1.var_.actorSpriteComps10059 = var_398_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_9 = 0.034

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_9 and not isNil(var_398_7) then
				local var_398_10 = (arg_395_1.time_ - var_398_8) / var_398_9

				if arg_395_1.var_.actorSpriteComps10059 then
					for iter_398_1, iter_398_2 in pairs(arg_395_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_398_2 then
							if arg_395_1.isInRecall_ then
								local var_398_11 = Mathf.Lerp(iter_398_2.color.r, arg_395_1.hightColor1.r, var_398_10)
								local var_398_12 = Mathf.Lerp(iter_398_2.color.g, arg_395_1.hightColor1.g, var_398_10)
								local var_398_13 = Mathf.Lerp(iter_398_2.color.b, arg_395_1.hightColor1.b, var_398_10)

								iter_398_2.color = Color.New(var_398_11, var_398_12, var_398_13)
							else
								local var_398_14 = Mathf.Lerp(iter_398_2.color.r, 1, var_398_10)

								iter_398_2.color = Color.New(var_398_14, var_398_14, var_398_14)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= var_398_8 + var_398_9 and arg_395_1.time_ < var_398_8 + var_398_9 + arg_398_0 and not isNil(var_398_7) and arg_395_1.var_.actorSpriteComps10059 then
				for iter_398_3, iter_398_4 in pairs(arg_395_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_398_4 then
						if arg_395_1.isInRecall_ then
							iter_398_4.color = arg_395_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_398_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_395_1.var_.actorSpriteComps10059 = nil
			end

			local var_398_15 = 0
			local var_398_16 = 0.4

			if var_398_15 < arg_395_1.time_ and arg_395_1.time_ <= var_398_15 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_17 = arg_395_1:FormatText(StoryNameCfg[596].name)

				arg_395_1.leftNameTxt_.text = var_398_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_18 = arg_395_1:GetWordFromCfg(410161096)
				local var_398_19 = arg_395_1:FormatText(var_398_18.content)

				arg_395_1.text_.text = var_398_19

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_20 = 16
				local var_398_21 = utf8.len(var_398_19)
				local var_398_22 = var_398_20 <= 0 and var_398_16 or var_398_16 * (var_398_21 / var_398_20)

				if var_398_22 > 0 and var_398_16 < var_398_22 then
					arg_395_1.talkMaxDuration = var_398_22

					if var_398_22 + var_398_15 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_22 + var_398_15
					end
				end

				arg_395_1.text_.text = var_398_19
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161096", "story_v_out_410161.awb") ~= 0 then
					local var_398_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161096", "story_v_out_410161.awb") / 1000

					if var_398_23 + var_398_15 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_23 + var_398_15
					end

					if var_398_18.prefab_name ~= "" and arg_395_1.actors_[var_398_18.prefab_name] ~= nil then
						local var_398_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_18.prefab_name].transform, "story_v_out_410161", "410161096", "story_v_out_410161.awb")

						arg_395_1:RecordAudio("410161096", var_398_24)
						arg_395_1:RecordAudio("410161096", var_398_24)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_410161", "410161096", "story_v_out_410161.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_410161", "410161096", "story_v_out_410161.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_25 = math.max(var_398_16, arg_395_1.talkMaxDuration)

			if var_398_15 <= arg_395_1.time_ and arg_395_1.time_ < var_398_15 + var_398_25 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_15) / var_398_25

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_15 + var_398_25 and arg_395_1.time_ < var_398_15 + var_398_25 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play410161097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 410161097
		arg_399_1.duration_ = 10.27

		local var_399_0 = {
			ja = 10.266,
			CriLanguages = 5,
			zh = 5
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play410161098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1061"].transform
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.var_.moveOldPos1061 = var_402_0.localPosition
				var_402_0.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("1061", 2)

				local var_402_2 = var_402_0.childCount

				for iter_402_0 = 0, var_402_2 - 1 do
					local var_402_3 = var_402_0:GetChild(iter_402_0)

					if var_402_3.name == "split_5" or not string.find(var_402_3.name, "split") then
						var_402_3.gameObject:SetActive(true)
					else
						var_402_3.gameObject:SetActive(false)
					end
				end
			end

			local var_402_4 = 0.001

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_4 then
				local var_402_5 = (arg_399_1.time_ - var_402_1) / var_402_4
				local var_402_6 = Vector3.New(-390, -490, 18)

				var_402_0.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1061, var_402_6, var_402_5)
			end

			if arg_399_1.time_ >= var_402_1 + var_402_4 and arg_399_1.time_ < var_402_1 + var_402_4 + arg_402_0 then
				var_402_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_402_7 = arg_399_1.actors_["1061"]
			local var_402_8 = 0

			if var_402_8 < arg_399_1.time_ and arg_399_1.time_ <= var_402_8 + arg_402_0 and not isNil(var_402_7) and arg_399_1.var_.actorSpriteComps1061 == nil then
				arg_399_1.var_.actorSpriteComps1061 = var_402_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_9 = 0.034

			if var_402_8 <= arg_399_1.time_ and arg_399_1.time_ < var_402_8 + var_402_9 and not isNil(var_402_7) then
				local var_402_10 = (arg_399_1.time_ - var_402_8) / var_402_9

				if arg_399_1.var_.actorSpriteComps1061 then
					for iter_402_1, iter_402_2 in pairs(arg_399_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_402_2 then
							if arg_399_1.isInRecall_ then
								local var_402_11 = Mathf.Lerp(iter_402_2.color.r, arg_399_1.hightColor1.r, var_402_10)
								local var_402_12 = Mathf.Lerp(iter_402_2.color.g, arg_399_1.hightColor1.g, var_402_10)
								local var_402_13 = Mathf.Lerp(iter_402_2.color.b, arg_399_1.hightColor1.b, var_402_10)

								iter_402_2.color = Color.New(var_402_11, var_402_12, var_402_13)
							else
								local var_402_14 = Mathf.Lerp(iter_402_2.color.r, 1, var_402_10)

								iter_402_2.color = Color.New(var_402_14, var_402_14, var_402_14)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_8 + var_402_9 and arg_399_1.time_ < var_402_8 + var_402_9 + arg_402_0 and not isNil(var_402_7) and arg_399_1.var_.actorSpriteComps1061 then
				for iter_402_3, iter_402_4 in pairs(arg_399_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_402_4 then
						if arg_399_1.isInRecall_ then
							iter_402_4.color = arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_402_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps1061 = nil
			end

			local var_402_15 = arg_399_1.actors_["10059"]
			local var_402_16 = 0

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.actorSpriteComps10059 == nil then
				arg_399_1.var_.actorSpriteComps10059 = var_402_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_17 = 0.034

			if var_402_16 <= arg_399_1.time_ and arg_399_1.time_ < var_402_16 + var_402_17 and not isNil(var_402_15) then
				local var_402_18 = (arg_399_1.time_ - var_402_16) / var_402_17

				if arg_399_1.var_.actorSpriteComps10059 then
					for iter_402_5, iter_402_6 in pairs(arg_399_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_402_6 then
							if arg_399_1.isInRecall_ then
								local var_402_19 = Mathf.Lerp(iter_402_6.color.r, arg_399_1.hightColor2.r, var_402_18)
								local var_402_20 = Mathf.Lerp(iter_402_6.color.g, arg_399_1.hightColor2.g, var_402_18)
								local var_402_21 = Mathf.Lerp(iter_402_6.color.b, arg_399_1.hightColor2.b, var_402_18)

								iter_402_6.color = Color.New(var_402_19, var_402_20, var_402_21)
							else
								local var_402_22 = Mathf.Lerp(iter_402_6.color.r, 0.5, var_402_18)

								iter_402_6.color = Color.New(var_402_22, var_402_22, var_402_22)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_16 + var_402_17 and arg_399_1.time_ < var_402_16 + var_402_17 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.actorSpriteComps10059 then
				for iter_402_7, iter_402_8 in pairs(arg_399_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_402_8 then
						if arg_399_1.isInRecall_ then
							iter_402_8.color = arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_402_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps10059 = nil
			end

			local var_402_23 = 0
			local var_402_24 = 0.575

			if var_402_23 < arg_399_1.time_ and arg_399_1.time_ <= var_402_23 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_25 = arg_399_1:FormatText(StoryNameCfg[612].name)

				arg_399_1.leftNameTxt_.text = var_402_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_26 = arg_399_1:GetWordFromCfg(410161097)
				local var_402_27 = arg_399_1:FormatText(var_402_26.content)

				arg_399_1.text_.text = var_402_27

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_28 = 23
				local var_402_29 = utf8.len(var_402_27)
				local var_402_30 = var_402_28 <= 0 and var_402_24 or var_402_24 * (var_402_29 / var_402_28)

				if var_402_30 > 0 and var_402_24 < var_402_30 then
					arg_399_1.talkMaxDuration = var_402_30

					if var_402_30 + var_402_23 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_30 + var_402_23
					end
				end

				arg_399_1.text_.text = var_402_27
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161097", "story_v_out_410161.awb") ~= 0 then
					local var_402_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161097", "story_v_out_410161.awb") / 1000

					if var_402_31 + var_402_23 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_31 + var_402_23
					end

					if var_402_26.prefab_name ~= "" and arg_399_1.actors_[var_402_26.prefab_name] ~= nil then
						local var_402_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_26.prefab_name].transform, "story_v_out_410161", "410161097", "story_v_out_410161.awb")

						arg_399_1:RecordAudio("410161097", var_402_32)
						arg_399_1:RecordAudio("410161097", var_402_32)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_410161", "410161097", "story_v_out_410161.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_410161", "410161097", "story_v_out_410161.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_33 = math.max(var_402_24, arg_399_1.talkMaxDuration)

			if var_402_23 <= arg_399_1.time_ and arg_399_1.time_ < var_402_23 + var_402_33 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_23) / var_402_33

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_23 + var_402_33 and arg_399_1.time_ < var_402_23 + var_402_33 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play410161098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 410161098
		arg_403_1.duration_ = 6.87

		local var_403_0 = {
			ja = 6.866,
			CriLanguages = 3.633,
			zh = 3.633
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play410161099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10059"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos10059 = var_406_0.localPosition
				var_406_0.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10059", 4)

				local var_406_2 = var_406_0.childCount

				for iter_406_0 = 0, var_406_2 - 1 do
					local var_406_3 = var_406_0:GetChild(iter_406_0)

					if var_406_3.name == "" or not string.find(var_406_3.name, "split") then
						var_406_3.gameObject:SetActive(true)
					else
						var_406_3.gameObject:SetActive(false)
					end
				end
			end

			local var_406_4 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_4 then
				local var_406_5 = (arg_403_1.time_ - var_406_1) / var_406_4
				local var_406_6 = Vector3.New(390, -530, 35)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10059, var_406_6, var_406_5)
			end

			if arg_403_1.time_ >= var_406_1 + var_406_4 and arg_403_1.time_ < var_406_1 + var_406_4 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_406_7 = arg_403_1.actors_["10059"]
			local var_406_8 = 0

			if var_406_8 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 and not isNil(var_406_7) and arg_403_1.var_.actorSpriteComps10059 == nil then
				arg_403_1.var_.actorSpriteComps10059 = var_406_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_9 = 0.034

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_9 and not isNil(var_406_7) then
				local var_406_10 = (arg_403_1.time_ - var_406_8) / var_406_9

				if arg_403_1.var_.actorSpriteComps10059 then
					for iter_406_1, iter_406_2 in pairs(arg_403_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_406_2 then
							if arg_403_1.isInRecall_ then
								local var_406_11 = Mathf.Lerp(iter_406_2.color.r, arg_403_1.hightColor1.r, var_406_10)
								local var_406_12 = Mathf.Lerp(iter_406_2.color.g, arg_403_1.hightColor1.g, var_406_10)
								local var_406_13 = Mathf.Lerp(iter_406_2.color.b, arg_403_1.hightColor1.b, var_406_10)

								iter_406_2.color = Color.New(var_406_11, var_406_12, var_406_13)
							else
								local var_406_14 = Mathf.Lerp(iter_406_2.color.r, 1, var_406_10)

								iter_406_2.color = Color.New(var_406_14, var_406_14, var_406_14)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_8 + var_406_9 and arg_403_1.time_ < var_406_8 + var_406_9 + arg_406_0 and not isNil(var_406_7) and arg_403_1.var_.actorSpriteComps10059 then
				for iter_406_3, iter_406_4 in pairs(arg_403_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_406_4 then
						if arg_403_1.isInRecall_ then
							iter_406_4.color = arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_406_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10059 = nil
			end

			local var_406_15 = arg_403_1.actors_["1061"]
			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 and not isNil(var_406_15) and arg_403_1.var_.actorSpriteComps1061 == nil then
				arg_403_1.var_.actorSpriteComps1061 = var_406_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_17 = 0.034

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 and not isNil(var_406_15) then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17

				if arg_403_1.var_.actorSpriteComps1061 then
					for iter_406_5, iter_406_6 in pairs(arg_403_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_406_6 then
							if arg_403_1.isInRecall_ then
								local var_406_19 = Mathf.Lerp(iter_406_6.color.r, arg_403_1.hightColor2.r, var_406_18)
								local var_406_20 = Mathf.Lerp(iter_406_6.color.g, arg_403_1.hightColor2.g, var_406_18)
								local var_406_21 = Mathf.Lerp(iter_406_6.color.b, arg_403_1.hightColor2.b, var_406_18)

								iter_406_6.color = Color.New(var_406_19, var_406_20, var_406_21)
							else
								local var_406_22 = Mathf.Lerp(iter_406_6.color.r, 0.5, var_406_18)

								iter_406_6.color = Color.New(var_406_22, var_406_22, var_406_22)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 and not isNil(var_406_15) and arg_403_1.var_.actorSpriteComps1061 then
				for iter_406_7, iter_406_8 in pairs(arg_403_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_406_8 then
						if arg_403_1.isInRecall_ then
							iter_406_8.color = arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_406_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps1061 = nil
			end

			local var_406_23 = 0
			local var_406_24 = 0.325

			if var_406_23 < arg_403_1.time_ and arg_403_1.time_ <= var_406_23 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_25 = arg_403_1:FormatText(StoryNameCfg[596].name)

				arg_403_1.leftNameTxt_.text = var_406_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_26 = arg_403_1:GetWordFromCfg(410161098)
				local var_406_27 = arg_403_1:FormatText(var_406_26.content)

				arg_403_1.text_.text = var_406_27

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_28 = 13
				local var_406_29 = utf8.len(var_406_27)
				local var_406_30 = var_406_28 <= 0 and var_406_24 or var_406_24 * (var_406_29 / var_406_28)

				if var_406_30 > 0 and var_406_24 < var_406_30 then
					arg_403_1.talkMaxDuration = var_406_30

					if var_406_30 + var_406_23 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_30 + var_406_23
					end
				end

				arg_403_1.text_.text = var_406_27
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161098", "story_v_out_410161.awb") ~= 0 then
					local var_406_31 = manager.audio:GetVoiceLength("story_v_out_410161", "410161098", "story_v_out_410161.awb") / 1000

					if var_406_31 + var_406_23 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_31 + var_406_23
					end

					if var_406_26.prefab_name ~= "" and arg_403_1.actors_[var_406_26.prefab_name] ~= nil then
						local var_406_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_26.prefab_name].transform, "story_v_out_410161", "410161098", "story_v_out_410161.awb")

						arg_403_1:RecordAudio("410161098", var_406_32)
						arg_403_1:RecordAudio("410161098", var_406_32)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_410161", "410161098", "story_v_out_410161.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_410161", "410161098", "story_v_out_410161.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_33 = math.max(var_406_24, arg_403_1.talkMaxDuration)

			if var_406_23 <= arg_403_1.time_ and arg_403_1.time_ < var_406_23 + var_406_33 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_23) / var_406_33

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_23 + var_406_33 and arg_403_1.time_ < var_406_23 + var_406_33 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play410161099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 410161099
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play410161100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1061"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos1061 = var_410_0.localPosition
				var_410_0.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1061", 7)

				local var_410_2 = var_410_0.childCount

				for iter_410_0 = 0, var_410_2 - 1 do
					local var_410_3 = var_410_0:GetChild(iter_410_0)

					if var_410_3.name == "" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_4 then
				local var_410_5 = (arg_407_1.time_ - var_410_1) / var_410_4
				local var_410_6 = Vector3.New(0, -2000, 18)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1061, var_410_6, var_410_5)
			end

			if arg_407_1.time_ >= var_410_1 + var_410_4 and arg_407_1.time_ < var_410_1 + var_410_4 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_410_7 = arg_407_1.actors_["10059"].transform
			local var_410_8 = 0

			if var_410_8 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.var_.moveOldPos10059 = var_410_7.localPosition
				var_410_7.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10059", 3)

				local var_410_9 = var_410_7.childCount

				for iter_410_1 = 0, var_410_9 - 1 do
					local var_410_10 = var_410_7:GetChild(iter_410_1)

					if var_410_10.name == "" or not string.find(var_410_10.name, "split") then
						var_410_10.gameObject:SetActive(true)
					else
						var_410_10.gameObject:SetActive(false)
					end
				end
			end

			local var_410_11 = 0.001

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_11 then
				local var_410_12 = (arg_407_1.time_ - var_410_8) / var_410_11
				local var_410_13 = Vector3.New(0, -530, 35)

				var_410_7.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10059, var_410_13, var_410_12)
			end

			if arg_407_1.time_ >= var_410_8 + var_410_11 and arg_407_1.time_ < var_410_8 + var_410_11 + arg_410_0 then
				var_410_7.localPosition = Vector3.New(0, -530, 35)
			end

			local var_410_14 = arg_407_1.actors_["1061"]
			local var_410_15 = 0

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 and not isNil(var_410_14) and arg_407_1.var_.actorSpriteComps1061 == nil then
				arg_407_1.var_.actorSpriteComps1061 = var_410_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_16 = 0.034

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_16 and not isNil(var_410_14) then
				local var_410_17 = (arg_407_1.time_ - var_410_15) / var_410_16

				if arg_407_1.var_.actorSpriteComps1061 then
					for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_410_3 then
							if arg_407_1.isInRecall_ then
								local var_410_18 = Mathf.Lerp(iter_410_3.color.r, arg_407_1.hightColor2.r, var_410_17)
								local var_410_19 = Mathf.Lerp(iter_410_3.color.g, arg_407_1.hightColor2.g, var_410_17)
								local var_410_20 = Mathf.Lerp(iter_410_3.color.b, arg_407_1.hightColor2.b, var_410_17)

								iter_410_3.color = Color.New(var_410_18, var_410_19, var_410_20)
							else
								local var_410_21 = Mathf.Lerp(iter_410_3.color.r, 0.5, var_410_17)

								iter_410_3.color = Color.New(var_410_21, var_410_21, var_410_21)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_15 + var_410_16 and arg_407_1.time_ < var_410_15 + var_410_16 + arg_410_0 and not isNil(var_410_14) and arg_407_1.var_.actorSpriteComps1061 then
				for iter_410_4, iter_410_5 in pairs(arg_407_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_410_5 then
						if arg_407_1.isInRecall_ then
							iter_410_5.color = arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_410_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps1061 = nil
			end

			local var_410_22 = arg_407_1.actors_["10059"]
			local var_410_23 = 0

			if var_410_23 < arg_407_1.time_ and arg_407_1.time_ <= var_410_23 + arg_410_0 and not isNil(var_410_22) and arg_407_1.var_.actorSpriteComps10059 == nil then
				arg_407_1.var_.actorSpriteComps10059 = var_410_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_24 = 0.034

			if var_410_23 <= arg_407_1.time_ and arg_407_1.time_ < var_410_23 + var_410_24 and not isNil(var_410_22) then
				local var_410_25 = (arg_407_1.time_ - var_410_23) / var_410_24

				if arg_407_1.var_.actorSpriteComps10059 then
					for iter_410_6, iter_410_7 in pairs(arg_407_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_410_7 then
							if arg_407_1.isInRecall_ then
								local var_410_26 = Mathf.Lerp(iter_410_7.color.r, arg_407_1.hightColor2.r, var_410_25)
								local var_410_27 = Mathf.Lerp(iter_410_7.color.g, arg_407_1.hightColor2.g, var_410_25)
								local var_410_28 = Mathf.Lerp(iter_410_7.color.b, arg_407_1.hightColor2.b, var_410_25)

								iter_410_7.color = Color.New(var_410_26, var_410_27, var_410_28)
							else
								local var_410_29 = Mathf.Lerp(iter_410_7.color.r, 0.5, var_410_25)

								iter_410_7.color = Color.New(var_410_29, var_410_29, var_410_29)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_23 + var_410_24 and arg_407_1.time_ < var_410_23 + var_410_24 + arg_410_0 and not isNil(var_410_22) and arg_407_1.var_.actorSpriteComps10059 then
				for iter_410_8, iter_410_9 in pairs(arg_407_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_410_9 then
						if arg_407_1.isInRecall_ then
							iter_410_9.color = arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_410_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps10059 = nil
			end

			local var_410_30 = 0
			local var_410_31 = 0.8

			if var_410_30 < arg_407_1.time_ and arg_407_1.time_ <= var_410_30 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_32 = arg_407_1:GetWordFromCfg(410161099)
				local var_410_33 = arg_407_1:FormatText(var_410_32.content)

				arg_407_1.text_.text = var_410_33

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_34 = 32
				local var_410_35 = utf8.len(var_410_33)
				local var_410_36 = var_410_34 <= 0 and var_410_31 or var_410_31 * (var_410_35 / var_410_34)

				if var_410_36 > 0 and var_410_31 < var_410_36 then
					arg_407_1.talkMaxDuration = var_410_36

					if var_410_36 + var_410_30 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_36 + var_410_30
					end
				end

				arg_407_1.text_.text = var_410_33
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_37 = math.max(var_410_31, arg_407_1.talkMaxDuration)

			if var_410_30 <= arg_407_1.time_ and arg_407_1.time_ < var_410_30 + var_410_37 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_30) / var_410_37

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_30 + var_410_37 and arg_407_1.time_ < var_410_30 + var_410_37 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play410161100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 410161100
		arg_411_1.duration_ = 4.23

		local var_411_0 = {
			ja = 4.233,
			CriLanguages = 4,
			zh = 4
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
			arg_411_1.auto_ = false
		end

		function arg_411_1.playNext_(arg_413_0)
			arg_411_1.onStoryFinished_()
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10059"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos10059 = var_414_0.localPosition
				var_414_0.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10059", 3)

				local var_414_2 = var_414_0.childCount

				for iter_414_0 = 0, var_414_2 - 1 do
					local var_414_3 = var_414_0:GetChild(iter_414_0)

					if var_414_3.name == "" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_4 then
				local var_414_5 = (arg_411_1.time_ - var_414_1) / var_414_4
				local var_414_6 = Vector3.New(0, -530, 35)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10059, var_414_6, var_414_5)
			end

			if arg_411_1.time_ >= var_414_1 + var_414_4 and arg_411_1.time_ < var_414_1 + var_414_4 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, -530, 35)
			end

			local var_414_7 = arg_411_1.actors_["10059"]
			local var_414_8 = 0

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10059 == nil then
				arg_411_1.var_.actorSpriteComps10059 = var_414_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_9 = 0.034

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_9 and not isNil(var_414_7) then
				local var_414_10 = (arg_411_1.time_ - var_414_8) / var_414_9

				if arg_411_1.var_.actorSpriteComps10059 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								local var_414_11 = Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor1.r, var_414_10)
								local var_414_12 = Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor1.g, var_414_10)
								local var_414_13 = Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor1.b, var_414_10)

								iter_414_2.color = Color.New(var_414_11, var_414_12, var_414_13)
							else
								local var_414_14 = Mathf.Lerp(iter_414_2.color.r, 1, var_414_10)

								iter_414_2.color = Color.New(var_414_14, var_414_14, var_414_14)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_8 + var_414_9 and arg_411_1.time_ < var_414_8 + var_414_9 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10059 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_414_4 then
						if arg_411_1.isInRecall_ then
							iter_414_4.color = arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_414_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10059 = nil
			end

			local var_414_15 = 0
			local var_414_16 = 0.325

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_17 = arg_411_1:FormatText(StoryNameCfg[596].name)

				arg_411_1.leftNameTxt_.text = var_414_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_18 = arg_411_1:GetWordFromCfg(410161100)
				local var_414_19 = arg_411_1:FormatText(var_414_18.content)

				arg_411_1.text_.text = var_414_19

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_20 = 13
				local var_414_21 = utf8.len(var_414_19)
				local var_414_22 = var_414_20 <= 0 and var_414_16 or var_414_16 * (var_414_21 / var_414_20)

				if var_414_22 > 0 and var_414_16 < var_414_22 then
					arg_411_1.talkMaxDuration = var_414_22

					if var_414_22 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_22 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_19
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410161", "410161100", "story_v_out_410161.awb") ~= 0 then
					local var_414_23 = manager.audio:GetVoiceLength("story_v_out_410161", "410161100", "story_v_out_410161.awb") / 1000

					if var_414_23 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_15
					end

					if var_414_18.prefab_name ~= "" and arg_411_1.actors_[var_414_18.prefab_name] ~= nil then
						local var_414_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_18.prefab_name].transform, "story_v_out_410161", "410161100", "story_v_out_410161.awb")

						arg_411_1:RecordAudio("410161100", var_414_24)
						arg_411_1:RecordAudio("410161100", var_414_24)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_410161", "410161100", "story_v_out_410161.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_410161", "410161100", "story_v_out_410161.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_25 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_25 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_25

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_25 and arg_411_1.time_ < var_414_15 + var_414_25 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/L04f",
		"TextureConfig/Background/ST62",
		"TextureConfig/Background/ST63"
	},
	voices = {
		"story_v_out_410161.awb"
	}
}
