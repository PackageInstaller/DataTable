return {
	Play426011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426011001
		arg_1_1.duration_ = 2.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"

			SetActive(arg_1_1.choicesGo_, true)

			for iter_2_0, iter_2_1 in ipairs(arg_1_1.choices_) do
				local var_2_0 = iter_2_0 <= 2

				SetActive(iter_2_1.go, var_2_0)
			end

			arg_1_1.choices_[1].txt.text = arg_1_1:FormatText(StoryChoiceCfg[1599].name)
			arg_1_1.choices_[2].txt.text = arg_1_1:FormatText(StoryChoiceCfg[1600].name)
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426011002(arg_1_1)
			end

			if arg_3_0 == 2 then
				arg_1_0:Play426011002(arg_1_1)
			end

			arg_1_1:RecordChoiceLog(426011001, 1599, 1600)
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

			local var_4_16 = 2

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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 426011002
		arg_6_1.duration_ = 4.6

		local var_6_0 = {
			zh = 3.8,
			ja = 4.6
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play426011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "ST2007"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.ST2007

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST2007" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 2

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_17 = 0.3

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_19 = 2

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				local var_9_20 = (arg_6_1.time_ - var_9_18) / var_9_19
				local var_9_21 = Color.New(0, 0, 0)

				var_9_21.a = Mathf.Lerp(1, 0, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)
				local var_9_23 = 0

				arg_6_1.mask_.enabled = false
				var_9_22.a = var_9_23
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_24 = 0
			local var_9_25 = 0.3

			if var_9_24 < arg_6_1.time_ and arg_6_1.time_ <= var_9_24 + arg_9_0 then
				local var_9_26 = "play"
				local var_9_27 = "music"

				arg_6_1:AudioAction(var_9_26, var_9_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_9_28 = ""
				local var_9_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_9_29 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_29 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_29

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_29
						arg_6_1.bgmTxt2_.text = var_9_29
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_30 = 0.433333333333333
			local var_9_31 = 1

			if var_9_30 < arg_6_1.time_ and arg_6_1.time_ <= var_9_30 + arg_9_0 then
				local var_9_32 = "play"
				local var_9_33 = "music"

				arg_6_1:AudioAction(var_9_32, var_9_33, "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_9_34 = ""
				local var_9_35 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if var_9_35 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_35 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_35

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_35
						arg_6_1.bgmTxt2_.text = var_9_35
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_36 = 0.3
			local var_9_37 = 1

			if var_9_36 < arg_6_1.time_ and arg_6_1.time_ <= var_9_36 + arg_9_0 then
				local var_9_38 = "play"
				local var_9_39 = "effect"

				arg_6_1:AudioAction(var_9_38, var_9_39, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_40 = 2
			local var_9_41 = 0.075

			if var_9_40 < arg_6_1.time_ and arg_6_1.time_ <= var_9_40 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_42 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_42:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_6_1.dialogCg_.alpha = arg_12_0
				end))
				var_9_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_43 = arg_6_1:FormatText(StoryNameCfg[1487].name)

				arg_6_1.leftNameTxt_.text = var_9_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, true)
				arg_6_1.iconController_:SetSelectedState("hero")

				arg_6_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_6_1.callingController_:SetSelectedState("normal")

				arg_6_1.keyicon_.color = Color.New(1, 1, 1)
				arg_6_1.icon_.color = Color.New(1, 1, 1)

				local var_9_44 = arg_6_1:GetWordFromCfg(426011002)
				local var_9_45 = arg_6_1:FormatText(var_9_44.content)

				arg_6_1.text_.text = var_9_45

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_46 = 3
				local var_9_47 = utf8.len(var_9_45)
				local var_9_48 = var_9_46 <= 0 and var_9_41 or var_9_41 * (var_9_47 / var_9_46)

				if var_9_48 > 0 and var_9_41 < var_9_48 then
					arg_6_1.talkMaxDuration = var_9_48
					var_9_40 = var_9_40 + 0.3

					if var_9_48 + var_9_40 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_48 + var_9_40
					end
				end

				arg_6_1.text_.text = var_9_45
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011002", "story_v_out_426011.awb") ~= 0 then
					local var_9_49 = manager.audio:GetVoiceLength("story_v_out_426011", "426011002", "story_v_out_426011.awb") / 1000

					if var_9_49 + var_9_40 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_49 + var_9_40
					end

					if var_9_44.prefab_name ~= "" and arg_6_1.actors_[var_9_44.prefab_name] ~= nil then
						local var_9_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_44.prefab_name].transform, "story_v_out_426011", "426011002", "story_v_out_426011.awb")

						arg_6_1:RecordAudio("426011002", var_9_50)
						arg_6_1:RecordAudio("426011002", var_9_50)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_426011", "426011002", "story_v_out_426011.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_426011", "426011002", "story_v_out_426011.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_51 = var_9_40 + 0.3
			local var_9_52 = math.max(var_9_41, arg_6_1.talkMaxDuration)

			if var_9_51 <= arg_6_1.time_ and arg_6_1.time_ < var_9_51 + var_9_52 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_51) / var_9_52

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_51 + var_9_52 and arg_6_1.time_ < var_9_51 + var_9_52 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play426011003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 426011003
		arg_14_1.duration_ = 5.63

		local var_14_0 = {
			zh = 2.1,
			ja = 5.633
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play426011004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.1

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_2 = arg_14_1:FormatText(StoryNameCfg[1488].name)

				arg_14_1.leftNameTxt_.text = var_17_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_3 = arg_14_1:GetWordFromCfg(426011003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 4
				local var_17_6 = utf8.len(var_17_4)
				local var_17_7 = var_17_5 <= 0 and var_17_1 or var_17_1 * (var_17_6 / var_17_5)

				if var_17_7 > 0 and var_17_1 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011003", "story_v_out_426011.awb") ~= 0 then
					local var_17_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011003", "story_v_out_426011.awb") / 1000

					if var_17_8 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_8 + var_17_0
					end

					if var_17_3.prefab_name ~= "" and arg_14_1.actors_[var_17_3.prefab_name] ~= nil then
						local var_17_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_3.prefab_name].transform, "story_v_out_426011", "426011003", "story_v_out_426011.awb")

						arg_14_1:RecordAudio("426011003", var_17_9)
						arg_14_1:RecordAudio("426011003", var_17_9)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_426011", "426011003", "story_v_out_426011.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_426011", "426011003", "story_v_out_426011.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_10 and arg_14_1.time_ < var_17_0 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play426011004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 426011004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play426011005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.15

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(426011004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 46
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play426011005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 426011005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play426011006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.575

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(426011005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 23
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
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_8 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_8 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_8

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_8 and arg_22_1.time_ < var_25_0 + var_25_8 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play426011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 426011006
		arg_26_1.duration_ = 6.27

		local var_26_0 = {
			zh = 3.233,
			ja = 6.266
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
				arg_26_0:Play426011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "6148ui_story"

			if arg_26_1.actors_[var_29_0] == nil then
				local var_29_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_29_1) then
					local var_29_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_26_1.stage_.transform)

					var_29_2.name = var_29_0
					var_29_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_26_1.actors_[var_29_0] = var_29_2

					local var_29_3 = var_29_2:GetComponentInChildren(typeof(CharacterEffect))

					var_29_3.enabled = true

					local var_29_4 = GameObjectTools.GetOrAddComponent(var_29_2, typeof(DynamicBoneHelper))

					if var_29_4 then
						var_29_4:EnableDynamicBone(false)
					end

					arg_26_1:ShowWeapon(var_29_3.transform, false)

					arg_26_1.var_[var_29_0 .. "Animator"] = var_29_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_26_1.var_[var_29_0 .. "Animator"].applyRootMotion = true
					arg_26_1.var_[var_29_0 .. "LipSync"] = var_29_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_29_5 = arg_26_1.actors_["6148ui_story"].transform
			local var_29_6 = 0

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.var_.moveOldPos6148ui_story = var_29_5.localPosition

				local var_29_7 = GameObjectTools.GetOrAddComponent(var_29_5.gameObject, typeof(DynamicBoneHelper))

				if var_29_7 then
					var_29_7:EnableDynamicBone(false)
				end
			end

			local var_29_8 = 0.001

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_8 then
				local var_29_9 = (arg_26_1.time_ - var_29_6) / var_29_8
				local var_29_10 = Vector3.New(0, -0.985, -6)

				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos6148ui_story, var_29_10, var_29_9)

				local var_29_11 = manager.ui.mainCamera.transform.position - var_29_5.position

				var_29_5.forward = Vector3.New(var_29_11.x, var_29_11.y, var_29_11.z)

				local var_29_12 = var_29_5.localEulerAngles

				var_29_12.z = 0
				var_29_12.x = 0
				var_29_5.localEulerAngles = var_29_12
			end

			if arg_26_1.time_ >= var_29_6 + var_29_8 and arg_26_1.time_ < var_29_6 + var_29_8 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_29_13 = manager.ui.mainCamera.transform.position - var_29_5.position

				var_29_5.forward = Vector3.New(var_29_13.x, var_29_13.y, var_29_13.z)

				local var_29_14 = var_29_5.localEulerAngles

				var_29_14.z = 0
				var_29_14.x = 0
				var_29_5.localEulerAngles = var_29_14

				local var_29_15 = GameObjectTools.GetOrAddComponent(var_29_5.gameObject, typeof(DynamicBoneHelper))

				if var_29_15 then
					var_29_15:EnableDynamicBone(true)
				end
			end

			local var_29_16 = arg_26_1.actors_["6148ui_story"]
			local var_29_17 = 0

			if var_29_17 < arg_26_1.time_ and arg_26_1.time_ <= var_29_17 + arg_29_0 and not isNil(var_29_16) and arg_26_1.var_.characterEffect6148ui_story == nil then
				arg_26_1.var_.characterEffect6148ui_story = var_29_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_18 = 0.200000002980232

			if var_29_17 <= arg_26_1.time_ and arg_26_1.time_ < var_29_17 + var_29_18 and not isNil(var_29_16) then
				local var_29_19 = (arg_26_1.time_ - var_29_17) / var_29_18

				if arg_26_1.var_.characterEffect6148ui_story and not isNil(var_29_16) then
					arg_26_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_17 + var_29_18 and arg_26_1.time_ < var_29_17 + var_29_18 + arg_29_0 and not isNil(var_29_16) and arg_26_1.var_.characterEffect6148ui_story then
				arg_26_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_29_20 = 0

			if var_29_20 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			local var_29_21 = 0

			if var_29_21 < arg_26_1.time_ and arg_26_1.time_ <= var_29_21 + arg_29_0 then
				arg_26_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_29_22 = 0
			local var_29_23 = 0.25

			if var_29_22 < arg_26_1.time_ and arg_26_1.time_ <= var_29_22 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_24 = arg_26_1:FormatText(StoryNameCfg[1488].name)

				arg_26_1.leftNameTxt_.text = var_29_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_25 = arg_26_1:GetWordFromCfg(426011006)
				local var_29_26 = arg_26_1:FormatText(var_29_25.content)

				arg_26_1.text_.text = var_29_26

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_27 = 10
				local var_29_28 = utf8.len(var_29_26)
				local var_29_29 = var_29_27 <= 0 and var_29_23 or var_29_23 * (var_29_28 / var_29_27)

				if var_29_29 > 0 and var_29_23 < var_29_29 then
					arg_26_1.talkMaxDuration = var_29_29

					if var_29_29 + var_29_22 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_29 + var_29_22
					end
				end

				arg_26_1.text_.text = var_29_26
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011006", "story_v_out_426011.awb") ~= 0 then
					local var_29_30 = manager.audio:GetVoiceLength("story_v_out_426011", "426011006", "story_v_out_426011.awb") / 1000

					if var_29_30 + var_29_22 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_30 + var_29_22
					end

					if var_29_25.prefab_name ~= "" and arg_26_1.actors_[var_29_25.prefab_name] ~= nil then
						local var_29_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_25.prefab_name].transform, "story_v_out_426011", "426011006", "story_v_out_426011.awb")

						arg_26_1:RecordAudio("426011006", var_29_31)
						arg_26_1:RecordAudio("426011006", var_29_31)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_426011", "426011006", "story_v_out_426011.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_426011", "426011006", "story_v_out_426011.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_32 = math.max(var_29_23, arg_26_1.talkMaxDuration)

			if var_29_22 <= arg_26_1.time_ and arg_26_1.time_ < var_29_22 + var_29_32 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_22) / var_29_32

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_22 + var_29_32 and arg_26_1.time_ < var_29_22 + var_29_32 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play426011007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 426011007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play426011008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["6148ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect6148ui_story == nil then
				arg_30_1.var_.characterEffect6148ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect6148ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_30_1.var_.characterEffect6148ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect6148ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_30_1.var_.characterEffect6148ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 0.275

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_9 = arg_30_1:GetWordFromCfg(426011007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 11
				local var_33_12 = utf8.len(var_33_10)
				local var_33_13 = var_33_11 <= 0 and var_33_7 or var_33_7 * (var_33_12 / var_33_11)

				if var_33_13 > 0 and var_33_7 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_10
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_14 and arg_30_1.time_ < var_33_6 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play426011008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 426011008
		arg_34_1.duration_ = 9.73

		local var_34_0 = {
			zh = 8.233,
			ja = 9.733
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
				arg_34_0:Play426011009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["6148ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6148ui_story == nil then
				arg_34_1.var_.characterEffect6148ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect6148ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6148ui_story then
				arg_34_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_37_4 = 0

			if var_37_4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_6 = 0
			local var_37_7 = 0.825

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[1488].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_9 = arg_34_1:GetWordFromCfg(426011008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011008", "story_v_out_426011.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_426011", "426011008", "story_v_out_426011.awb") / 1000

					if var_37_14 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_6
					end

					if var_37_9.prefab_name ~= "" and arg_34_1.actors_[var_37_9.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_9.prefab_name].transform, "story_v_out_426011", "426011008", "story_v_out_426011.awb")

						arg_34_1:RecordAudio("426011008", var_37_15)
						arg_34_1:RecordAudio("426011008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_426011", "426011008", "story_v_out_426011.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_426011", "426011008", "story_v_out_426011.awb")
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
	Play426011009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 426011009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play426011010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["6148ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6148ui_story == nil then
				arg_38_1.var_.characterEffect6148ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect6148ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_38_1.var_.characterEffect6148ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6148ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_38_1.var_.characterEffect6148ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.375

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(426011009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 15
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play426011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 426011010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play426011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["6148ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos6148ui_story = var_45_0.localPosition

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end
			end

			local var_45_3 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_3 then
				local var_45_4 = (arg_42_1.time_ - var_45_1) / var_45_3
				local var_45_5 = Vector3.New(0, 100, 0)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos6148ui_story, var_45_5, var_45_4)

				local var_45_6 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_6.x, var_45_6.y, var_45_6.z)

				local var_45_7 = var_45_0.localEulerAngles

				var_45_7.z = 0
				var_45_7.x = 0
				var_45_0.localEulerAngles = var_45_7
			end

			if arg_42_1.time_ >= var_45_1 + var_45_3 and arg_42_1.time_ < var_45_1 + var_45_3 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, 100, 0)

				local var_45_8 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_8.x, var_45_8.y, var_45_8.z)

				local var_45_9 = var_45_0.localEulerAngles

				var_45_9.z = 0
				var_45_9.x = 0
				var_45_0.localEulerAngles = var_45_9

				local var_45_10 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_10 then
					var_45_10:EnableDynamicBone(true)
				end
			end

			local var_45_11 = 0.133333333333333
			local var_45_12 = 1

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_13 = "play"
				local var_45_14 = "effect"

				arg_42_1:AudioAction(var_45_13, var_45_14, "se_story_145", "se_story_145_ui01", "")
			end

			local var_45_15 = 0
			local var_45_16 = 0.975

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_17 = arg_42_1:GetWordFromCfg(426011010)
				local var_45_18 = arg_42_1:FormatText(var_45_17.content)

				arg_42_1.text_.text = var_45_18

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 39
				local var_45_20 = utf8.len(var_45_18)
				local var_45_21 = var_45_19 <= 0 and var_45_16 or var_45_16 * (var_45_20 / var_45_19)

				if var_45_21 > 0 and var_45_16 < var_45_21 then
					arg_42_1.talkMaxDuration = var_45_21

					if var_45_21 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_21 + var_45_15
					end
				end

				arg_42_1.text_.text = var_45_18
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = math.max(var_45_16, arg_42_1.talkMaxDuration)

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_22 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_15) / var_45_22

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_15 + var_45_22 and arg_42_1.time_ < var_45_15 + var_45_22 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play426011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 426011011
		arg_46_1.duration_ = 6.97

		local var_46_0 = {
			zh = 3.366,
			ja = 6.966
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
				arg_46_0:Play426011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "1054ui_story"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_46_1.stage_.transform)

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

			local var_49_5 = arg_46_1.actors_["1054ui_story"].transform
			local var_49_6 = 0

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.var_.moveOldPos1054ui_story = var_49_5.localPosition

				local var_49_7 = GameObjectTools.GetOrAddComponent(var_49_5.gameObject, typeof(DynamicBoneHelper))

				if var_49_7 then
					var_49_7:EnableDynamicBone(false)
				end
			end

			local var_49_8 = 0.001

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_8 then
				local var_49_9 = (arg_46_1.time_ - var_49_6) / var_49_8
				local var_49_10 = Vector3.New(0, -0.985, -6)

				var_49_5.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1054ui_story, var_49_10, var_49_9)

				local var_49_11 = manager.ui.mainCamera.transform.position - var_49_5.position

				var_49_5.forward = Vector3.New(var_49_11.x, var_49_11.y, var_49_11.z)

				local var_49_12 = var_49_5.localEulerAngles

				var_49_12.z = 0
				var_49_12.x = 0
				var_49_5.localEulerAngles = var_49_12
			end

			if arg_46_1.time_ >= var_49_6 + var_49_8 and arg_46_1.time_ < var_49_6 + var_49_8 + arg_49_0 then
				var_49_5.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_49_16 = arg_46_1.actors_["1054ui_story"]
			local var_49_17 = 0

			if var_49_17 < arg_46_1.time_ and arg_46_1.time_ <= var_49_17 + arg_49_0 and not isNil(var_49_16) and arg_46_1.var_.characterEffect1054ui_story == nil then
				arg_46_1.var_.characterEffect1054ui_story = var_49_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_18 = 0.200000002980232

			if var_49_17 <= arg_46_1.time_ and arg_46_1.time_ < var_49_17 + var_49_18 and not isNil(var_49_16) then
				local var_49_19 = (arg_46_1.time_ - var_49_17) / var_49_18

				if arg_46_1.var_.characterEffect1054ui_story and not isNil(var_49_16) then
					arg_46_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_17 + var_49_18 and arg_46_1.time_ < var_49_17 + var_49_18 + arg_49_0 and not isNil(var_49_16) and arg_46_1.var_.characterEffect1054ui_story then
				arg_46_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_49_20 = 0

			if var_49_20 < arg_46_1.time_ and arg_46_1.time_ <= var_49_20 + arg_49_0 then
				arg_46_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_49_22 = 0
			local var_49_23 = 0.25

			if var_49_22 < arg_46_1.time_ and arg_46_1.time_ <= var_49_22 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_24 = arg_46_1:FormatText(StoryNameCfg[1487].name)

				arg_46_1.leftNameTxt_.text = var_49_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_25 = arg_46_1:GetWordFromCfg(426011011)
				local var_49_26 = arg_46_1:FormatText(var_49_25.content)

				arg_46_1.text_.text = var_49_26

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_27 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011011", "story_v_out_426011.awb") ~= 0 then
					local var_49_30 = manager.audio:GetVoiceLength("story_v_out_426011", "426011011", "story_v_out_426011.awb") / 1000

					if var_49_30 + var_49_22 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_30 + var_49_22
					end

					if var_49_25.prefab_name ~= "" and arg_46_1.actors_[var_49_25.prefab_name] ~= nil then
						local var_49_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_25.prefab_name].transform, "story_v_out_426011", "426011011", "story_v_out_426011.awb")

						arg_46_1:RecordAudio("426011011", var_49_31)
						arg_46_1:RecordAudio("426011011", var_49_31)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_426011", "426011011", "story_v_out_426011.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_426011", "426011011", "story_v_out_426011.awb")
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
				actorName = "1054ui_story",
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
	Play426011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 426011012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play426011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1054ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1054ui_story == nil then
				arg_50_1.var_.characterEffect1054ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1054ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1054ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1054ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1054ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.4

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(426011012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 16
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play426011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 426011013
		arg_54_1.duration_ = 4.4

		local var_54_0 = {
			zh = 4.4,
			ja = 3.066
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
				arg_54_0:Play426011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1054ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1054ui_story = var_57_0.localPosition

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end
			end

			local var_57_3 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_3 then
				local var_57_4 = (arg_54_1.time_ - var_57_1) / var_57_3
				local var_57_5 = Vector3.New(0, -0.985, -6)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1054ui_story, var_57_5, var_57_4)

				local var_57_6 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_6.x, var_57_6.y, var_57_6.z)

				local var_57_7 = var_57_0.localEulerAngles

				var_57_7.z = 0
				var_57_7.x = 0
				var_57_0.localEulerAngles = var_57_7
			end

			if arg_54_1.time_ >= var_57_1 + var_57_3 and arg_54_1.time_ < var_57_1 + var_57_3 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_57_8 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_8.x, var_57_8.y, var_57_8.z)

				local var_57_9 = var_57_0.localEulerAngles

				var_57_9.z = 0
				var_57_9.x = 0
				var_57_0.localEulerAngles = var_57_9

				local var_57_10 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_10 then
					var_57_10:EnableDynamicBone(true)
				end
			end

			local var_57_11 = arg_54_1.actors_["1054ui_story"]
			local var_57_12 = 0

			if var_57_12 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 and not isNil(var_57_11) and arg_54_1.var_.characterEffect1054ui_story == nil then
				arg_54_1.var_.characterEffect1054ui_story = var_57_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_13 = 0.200000002980232

			if var_57_12 <= arg_54_1.time_ and arg_54_1.time_ < var_57_12 + var_57_13 and not isNil(var_57_11) then
				local var_57_14 = (arg_54_1.time_ - var_57_12) / var_57_13

				if arg_54_1.var_.characterEffect1054ui_story and not isNil(var_57_11) then
					arg_54_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_12 + var_57_13 and arg_54_1.time_ < var_57_12 + var_57_13 + arg_57_0 and not isNil(var_57_11) and arg_54_1.var_.characterEffect1054ui_story then
				arg_54_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_57_15 = 0

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_2")
			end

			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_17 = 0
			local var_57_18 = 0.325

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_19 = arg_54_1:FormatText(StoryNameCfg[1487].name)

				arg_54_1.leftNameTxt_.text = var_57_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_20 = arg_54_1:GetWordFromCfg(426011013)
				local var_57_21 = arg_54_1:FormatText(var_57_20.content)

				arg_54_1.text_.text = var_57_21

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_22 = 13
				local var_57_23 = utf8.len(var_57_21)
				local var_57_24 = var_57_22 <= 0 and var_57_18 or var_57_18 * (var_57_23 / var_57_22)

				if var_57_24 > 0 and var_57_18 < var_57_24 then
					arg_54_1.talkMaxDuration = var_57_24

					if var_57_24 + var_57_17 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_24 + var_57_17
					end
				end

				arg_54_1.text_.text = var_57_21
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011013", "story_v_out_426011.awb") ~= 0 then
					local var_57_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011013", "story_v_out_426011.awb") / 1000

					if var_57_25 + var_57_17 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_25 + var_57_17
					end

					if var_57_20.prefab_name ~= "" and arg_54_1.actors_[var_57_20.prefab_name] ~= nil then
						local var_57_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_20.prefab_name].transform, "story_v_out_426011", "426011013", "story_v_out_426011.awb")

						arg_54_1:RecordAudio("426011013", var_57_26)
						arg_54_1:RecordAudio("426011013", var_57_26)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_426011", "426011013", "story_v_out_426011.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_426011", "426011013", "story_v_out_426011.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_27 = math.max(var_57_18, arg_54_1.talkMaxDuration)

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_27 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_17) / var_57_27

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_17 + var_57_27 and arg_54_1.time_ < var_57_17 + var_57_27 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play426011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 426011014
		arg_58_1.duration_ = 7.37

		local var_58_0 = {
			zh = 6.5,
			ja = 7.366
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
				arg_58_0:Play426011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["6148ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos6148ui_story = var_61_0.localPosition

				local var_61_2 = GameObjectTools.GetOrAddComponent(var_61_0.gameObject, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(false)
				end
			end

			local var_61_3 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_3 then
				local var_61_4 = (arg_58_1.time_ - var_61_1) / var_61_3
				local var_61_5 = Vector3.New(0.7, -0.985, -6)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos6148ui_story, var_61_5, var_61_4)

				local var_61_6 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_6.x, var_61_6.y, var_61_6.z)

				local var_61_7 = var_61_0.localEulerAngles

				var_61_7.z = 0
				var_61_7.x = 0
				var_61_0.localEulerAngles = var_61_7
			end

			if arg_58_1.time_ >= var_61_1 + var_61_3 and arg_58_1.time_ < var_61_1 + var_61_3 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_61_8 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_8.x, var_61_8.y, var_61_8.z)

				local var_61_9 = var_61_0.localEulerAngles

				var_61_9.z = 0
				var_61_9.x = 0
				var_61_0.localEulerAngles = var_61_9

				local var_61_10 = GameObjectTools.GetOrAddComponent(var_61_0.gameObject, typeof(DynamicBoneHelper))

				if var_61_10 then
					var_61_10:EnableDynamicBone(true)
				end
			end

			local var_61_11 = arg_58_1.actors_["1054ui_story"].transform
			local var_61_12 = 0

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.var_.moveOldPos1054ui_story = var_61_11.localPosition

				local var_61_13 = GameObjectTools.GetOrAddComponent(var_61_11.gameObject, typeof(DynamicBoneHelper))

				if var_61_13 then
					var_61_13:EnableDynamicBone(false)
				end
			end

			local var_61_14 = 0.001

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_14 then
				local var_61_15 = (arg_58_1.time_ - var_61_12) / var_61_14
				local var_61_16 = Vector3.New(-0.7, -0.985, -6)

				var_61_11.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1054ui_story, var_61_16, var_61_15)

				local var_61_17 = manager.ui.mainCamera.transform.position - var_61_11.position

				var_61_11.forward = Vector3.New(var_61_17.x, var_61_17.y, var_61_17.z)

				local var_61_18 = var_61_11.localEulerAngles

				var_61_18.z = 0
				var_61_18.x = 0
				var_61_11.localEulerAngles = var_61_18
			end

			if arg_58_1.time_ >= var_61_12 + var_61_14 and arg_58_1.time_ < var_61_12 + var_61_14 + arg_61_0 then
				var_61_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_61_19 = manager.ui.mainCamera.transform.position - var_61_11.position

				var_61_11.forward = Vector3.New(var_61_19.x, var_61_19.y, var_61_19.z)

				local var_61_20 = var_61_11.localEulerAngles

				var_61_20.z = 0
				var_61_20.x = 0
				var_61_11.localEulerAngles = var_61_20

				local var_61_21 = GameObjectTools.GetOrAddComponent(var_61_11.gameObject, typeof(DynamicBoneHelper))

				if var_61_21 then
					var_61_21:EnableDynamicBone(true)
				end
			end

			local var_61_22 = arg_58_1.actors_["6148ui_story"]
			local var_61_23 = 0

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect6148ui_story == nil then
				arg_58_1.var_.characterEffect6148ui_story = var_61_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_24 = 0.200000002980232

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_24 and not isNil(var_61_22) then
				local var_61_25 = (arg_58_1.time_ - var_61_23) / var_61_24

				if arg_58_1.var_.characterEffect6148ui_story and not isNil(var_61_22) then
					arg_58_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_23 + var_61_24 and arg_58_1.time_ < var_61_23 + var_61_24 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect6148ui_story then
				arg_58_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_61_26 = arg_58_1.actors_["1054ui_story"]
			local var_61_27 = 0

			if var_61_27 < arg_58_1.time_ and arg_58_1.time_ <= var_61_27 + arg_61_0 and not isNil(var_61_26) and arg_58_1.var_.characterEffect1054ui_story == nil then
				arg_58_1.var_.characterEffect1054ui_story = var_61_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_28 = 0.200000002980232

			if var_61_27 <= arg_58_1.time_ and arg_58_1.time_ < var_61_27 + var_61_28 and not isNil(var_61_26) then
				local var_61_29 = (arg_58_1.time_ - var_61_27) / var_61_28

				if arg_58_1.var_.characterEffect1054ui_story and not isNil(var_61_26) then
					local var_61_30 = Mathf.Lerp(0, 0.5, var_61_29)

					arg_58_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1054ui_story.fillRatio = var_61_30
				end
			end

			if arg_58_1.time_ >= var_61_27 + var_61_28 and arg_58_1.time_ < var_61_27 + var_61_28 + arg_61_0 and not isNil(var_61_26) and arg_58_1.var_.characterEffect1054ui_story then
				local var_61_31 = 0.5

				arg_58_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1054ui_story.fillRatio = var_61_31
			end

			local var_61_32 = 0

			if var_61_32 < arg_58_1.time_ and arg_58_1.time_ <= var_61_32 + arg_61_0 then
				arg_58_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_61_33 = 0

			if var_61_33 < arg_58_1.time_ and arg_58_1.time_ <= var_61_33 + arg_61_0 then
				arg_58_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_34 = 0
			local var_61_35 = 0.7

			if var_61_34 < arg_58_1.time_ and arg_58_1.time_ <= var_61_34 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_36 = arg_58_1:FormatText(StoryNameCfg[1488].name)

				arg_58_1.leftNameTxt_.text = var_61_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_37 = arg_58_1:GetWordFromCfg(426011014)
				local var_61_38 = arg_58_1:FormatText(var_61_37.content)

				arg_58_1.text_.text = var_61_38

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_39 = 28
				local var_61_40 = utf8.len(var_61_38)
				local var_61_41 = var_61_39 <= 0 and var_61_35 or var_61_35 * (var_61_40 / var_61_39)

				if var_61_41 > 0 and var_61_35 < var_61_41 then
					arg_58_1.talkMaxDuration = var_61_41

					if var_61_41 + var_61_34 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_41 + var_61_34
					end
				end

				arg_58_1.text_.text = var_61_38
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011014", "story_v_out_426011.awb") ~= 0 then
					local var_61_42 = manager.audio:GetVoiceLength("story_v_out_426011", "426011014", "story_v_out_426011.awb") / 1000

					if var_61_42 + var_61_34 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_42 + var_61_34
					end

					if var_61_37.prefab_name ~= "" and arg_58_1.actors_[var_61_37.prefab_name] ~= nil then
						local var_61_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_37.prefab_name].transform, "story_v_out_426011", "426011014", "story_v_out_426011.awb")

						arg_58_1:RecordAudio("426011014", var_61_43)
						arg_58_1:RecordAudio("426011014", var_61_43)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_426011", "426011014", "story_v_out_426011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_426011", "426011014", "story_v_out_426011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_44 = math.max(var_61_35, arg_58_1.talkMaxDuration)

			if var_61_34 <= arg_58_1.time_ and arg_58_1.time_ < var_61_34 + var_61_44 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_34) / var_61_44

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_34 + var_61_44 and arg_58_1.time_ < var_61_34 + var_61_44 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play426011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 426011015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play426011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["6148ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect6148ui_story == nil then
				arg_62_1.var_.characterEffect6148ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect6148ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_62_1.var_.characterEffect6148ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect6148ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_62_1.var_.characterEffect6148ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.275

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(426011015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 11
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play426011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 426011016
		arg_66_1.duration_ = 2

		local var_66_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_66_0:Play426011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["6148ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos6148ui_story = var_69_0.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_3 then
				local var_69_4 = (arg_66_1.time_ - var_69_1) / var_69_3
				local var_69_5 = Vector3.New(0.7, -0.985, -6)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos6148ui_story, var_69_5, var_69_4)

				local var_69_6 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_6.x, var_69_6.y, var_69_6.z)

				local var_69_7 = var_69_0.localEulerAngles

				var_69_7.z = 0
				var_69_7.x = 0
				var_69_0.localEulerAngles = var_69_7
			end

			if arg_66_1.time_ >= var_69_1 + var_69_3 and arg_66_1.time_ < var_69_1 + var_69_3 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_69_8 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_8.x, var_69_8.y, var_69_8.z)

				local var_69_9 = var_69_0.localEulerAngles

				var_69_9.z = 0
				var_69_9.x = 0
				var_69_0.localEulerAngles = var_69_9

				local var_69_10 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_10 then
					var_69_10:EnableDynamicBone(true)
				end
			end

			local var_69_11 = arg_66_1.actors_["6148ui_story"]
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect6148ui_story == nil then
				arg_66_1.var_.characterEffect6148ui_story = var_69_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_13 = 0.200000002980232

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 and not isNil(var_69_11) then
				local var_69_14 = (arg_66_1.time_ - var_69_12) / var_69_13

				if arg_66_1.var_.characterEffect6148ui_story and not isNil(var_69_11) then
					arg_66_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect6148ui_story then
				arg_66_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_69_17 = 0
			local var_69_18 = 0.075

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_19 = arg_66_1:FormatText(StoryNameCfg[1488].name)

				arg_66_1.leftNameTxt_.text = var_69_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(426011016)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_22 = 3
				local var_69_23 = utf8.len(var_69_21)
				local var_69_24 = var_69_22 <= 0 and var_69_18 or var_69_18 * (var_69_23 / var_69_22)

				if var_69_24 > 0 and var_69_18 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24

					if var_69_24 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_17
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011016", "story_v_out_426011.awb") ~= 0 then
					local var_69_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011016", "story_v_out_426011.awb") / 1000

					if var_69_25 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_17
					end

					if var_69_20.prefab_name ~= "" and arg_66_1.actors_[var_69_20.prefab_name] ~= nil then
						local var_69_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_20.prefab_name].transform, "story_v_out_426011", "426011016", "story_v_out_426011.awb")

						arg_66_1:RecordAudio("426011016", var_69_26)
						arg_66_1:RecordAudio("426011016", var_69_26)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_426011", "426011016", "story_v_out_426011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_426011", "426011016", "story_v_out_426011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_27 = math.max(var_69_18, arg_66_1.talkMaxDuration)

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_27 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_17) / var_69_27

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_17 + var_69_27 and arg_66_1.time_ < var_69_17 + var_69_27 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play426011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 426011017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play426011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1054ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1054ui_story = var_73_0.localPosition

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(-0.7, -0.985, -6)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1054ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_73_8 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_8.x, var_73_8.y, var_73_8.z)

				local var_73_9 = var_73_0.localEulerAngles

				var_73_9.z = 0
				var_73_9.x = 0
				var_73_0.localEulerAngles = var_73_9

				local var_73_10 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_10 then
					var_73_10:EnableDynamicBone(true)
				end
			end

			local var_73_11 = arg_70_1.actors_["1054ui_story"]
			local var_73_12 = 0

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 and not isNil(var_73_11) and arg_70_1.var_.characterEffect1054ui_story == nil then
				arg_70_1.var_.characterEffect1054ui_story = var_73_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_13 = 0.200000002980232

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_13 and not isNil(var_73_11) then
				local var_73_14 = (arg_70_1.time_ - var_73_12) / var_73_13

				if arg_70_1.var_.characterEffect1054ui_story and not isNil(var_73_11) then
					arg_70_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_12 + var_73_13 and arg_70_1.time_ < var_73_12 + var_73_13 + arg_73_0 and not isNil(var_73_11) and arg_70_1.var_.characterEffect1054ui_story then
				arg_70_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_73_15 = arg_70_1.actors_["6148ui_story"]
			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 and not isNil(var_73_15) and arg_70_1.var_.characterEffect6148ui_story == nil then
				arg_70_1.var_.characterEffect6148ui_story = var_73_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_17 = 0.200000002980232

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_17 and not isNil(var_73_15) then
				local var_73_18 = (arg_70_1.time_ - var_73_16) / var_73_17

				if arg_70_1.var_.characterEffect6148ui_story and not isNil(var_73_15) then
					local var_73_19 = Mathf.Lerp(0, 0.5, var_73_18)

					arg_70_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_70_1.var_.characterEffect6148ui_story.fillRatio = var_73_19
				end
			end

			if arg_70_1.time_ >= var_73_16 + var_73_17 and arg_70_1.time_ < var_73_16 + var_73_17 + arg_73_0 and not isNil(var_73_15) and arg_70_1.var_.characterEffect6148ui_story then
				local var_73_20 = 0.5

				arg_70_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_70_1.var_.characterEffect6148ui_story.fillRatio = var_73_20
			end

			local var_73_21 = 0

			if var_73_21 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 then
				arg_70_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_73_22 = 0

			if var_73_22 < arg_70_1.time_ and arg_70_1.time_ <= var_73_22 + arg_73_0 then
				arg_70_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_73_23 = 0
			local var_73_24 = 0.05

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_25 = arg_70_1:FormatText(StoryNameCfg[1487].name)

				arg_70_1.leftNameTxt_.text = var_73_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_26 = arg_70_1:GetWordFromCfg(426011017)
				local var_73_27 = arg_70_1:FormatText(var_73_26.content)

				arg_70_1.text_.text = var_73_27

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_28 = 2
				local var_73_29 = utf8.len(var_73_27)
				local var_73_30 = var_73_28 <= 0 and var_73_24 or var_73_24 * (var_73_29 / var_73_28)

				if var_73_30 > 0 and var_73_24 < var_73_30 then
					arg_70_1.talkMaxDuration = var_73_30

					if var_73_30 + var_73_23 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_30 + var_73_23
					end
				end

				arg_70_1.text_.text = var_73_27
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011017", "story_v_out_426011.awb") ~= 0 then
					local var_73_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011017", "story_v_out_426011.awb") / 1000

					if var_73_31 + var_73_23 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_31 + var_73_23
					end

					if var_73_26.prefab_name ~= "" and arg_70_1.actors_[var_73_26.prefab_name] ~= nil then
						local var_73_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_26.prefab_name].transform, "story_v_out_426011", "426011017", "story_v_out_426011.awb")

						arg_70_1:RecordAudio("426011017", var_73_32)
						arg_70_1:RecordAudio("426011017", var_73_32)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_426011", "426011017", "story_v_out_426011.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_426011", "426011017", "story_v_out_426011.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_33 = math.max(var_73_24, arg_70_1.talkMaxDuration)

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_33 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_23) / var_73_33

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_23 + var_73_33 and arg_70_1.time_ < var_73_23 + var_73_33 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play426011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 426011018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play426011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1054ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1054ui_story == nil then
				arg_74_1.var_.characterEffect1054ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1054ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1054ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1054ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1054ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 0
			local var_77_7 = 0.175

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_9 = arg_74_1:GetWordFromCfg(426011018)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 7
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_14 and arg_74_1.time_ < var_77_6 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play426011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 426011019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play426011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1054ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1054ui_story = var_81_0.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_3 then
				local var_81_4 = (arg_78_1.time_ - var_81_1) / var_81_3
				local var_81_5 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1054ui_story, var_81_5, var_81_4)

				local var_81_6 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_6.x, var_81_6.y, var_81_6.z)

				local var_81_7 = var_81_0.localEulerAngles

				var_81_7.z = 0
				var_81_7.x = 0
				var_81_0.localEulerAngles = var_81_7
			end

			if arg_78_1.time_ >= var_81_1 + var_81_3 and arg_78_1.time_ < var_81_1 + var_81_3 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_8 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_8.x, var_81_8.y, var_81_8.z)

				local var_81_9 = var_81_0.localEulerAngles

				var_81_9.z = 0
				var_81_9.x = 0
				var_81_0.localEulerAngles = var_81_9

				local var_81_10 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_10 then
					var_81_10:EnableDynamicBone(true)
				end
			end

			local var_81_11 = arg_78_1.actors_["6148ui_story"].transform
			local var_81_12 = 0

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.var_.moveOldPos6148ui_story = var_81_11.localPosition

				local var_81_13 = GameObjectTools.GetOrAddComponent(var_81_11.gameObject, typeof(DynamicBoneHelper))

				if var_81_13 then
					var_81_13:EnableDynamicBone(false)
				end
			end

			local var_81_14 = 0.001

			if var_81_12 <= arg_78_1.time_ and arg_78_1.time_ < var_81_12 + var_81_14 then
				local var_81_15 = (arg_78_1.time_ - var_81_12) / var_81_14
				local var_81_16 = Vector3.New(0, 100, 0)

				var_81_11.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos6148ui_story, var_81_16, var_81_15)

				local var_81_17 = manager.ui.mainCamera.transform.position - var_81_11.position

				var_81_11.forward = Vector3.New(var_81_17.x, var_81_17.y, var_81_17.z)

				local var_81_18 = var_81_11.localEulerAngles

				var_81_18.z = 0
				var_81_18.x = 0
				var_81_11.localEulerAngles = var_81_18
			end

			if arg_78_1.time_ >= var_81_12 + var_81_14 and arg_78_1.time_ < var_81_12 + var_81_14 + arg_81_0 then
				var_81_11.localPosition = Vector3.New(0, 100, 0)

				local var_81_19 = manager.ui.mainCamera.transform.position - var_81_11.position

				var_81_11.forward = Vector3.New(var_81_19.x, var_81_19.y, var_81_19.z)

				local var_81_20 = var_81_11.localEulerAngles

				var_81_20.z = 0
				var_81_20.x = 0
				var_81_11.localEulerAngles = var_81_20

				local var_81_21 = GameObjectTools.GetOrAddComponent(var_81_11.gameObject, typeof(DynamicBoneHelper))

				if var_81_21 then
					var_81_21:EnableDynamicBone(true)
				end
			end

			local var_81_22 = 0
			local var_81_23 = 1.4

			if var_81_22 < arg_78_1.time_ and arg_78_1.time_ <= var_81_22 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_24 = arg_78_1:GetWordFromCfg(426011019)
				local var_81_25 = arg_78_1:FormatText(var_81_24.content)

				arg_78_1.text_.text = var_81_25

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_26 = 56
				local var_81_27 = utf8.len(var_81_25)
				local var_81_28 = var_81_26 <= 0 and var_81_23 or var_81_23 * (var_81_27 / var_81_26)

				if var_81_28 > 0 and var_81_23 < var_81_28 then
					arg_78_1.talkMaxDuration = var_81_28

					if var_81_28 + var_81_22 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_28 + var_81_22
					end
				end

				arg_78_1.text_.text = var_81_25
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_29 = math.max(var_81_23, arg_78_1.talkMaxDuration)

			if var_81_22 <= arg_78_1.time_ and arg_78_1.time_ < var_81_22 + var_81_29 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_22) / var_81_29

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_22 + var_81_29 and arg_78_1.time_ < var_81_22 + var_81_29 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 426011020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play426011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.675

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(426011020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 27
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play426011021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 426011021
		arg_86_1.duration_ = 4.1

		local var_86_0 = {
			zh = 2.866,
			ja = 4.1
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
				arg_86_0:Play426011022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["6148ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(-0.7, -0.985, -6)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["6148ui_story"]
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect6148ui_story == nil then
				arg_86_1.var_.characterEffect6148ui_story = var_89_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_13 = 0.200000002980232

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_13 and not isNil(var_89_11) then
				local var_89_14 = (arg_86_1.time_ - var_89_12) / var_89_13

				if arg_86_1.var_.characterEffect6148ui_story and not isNil(var_89_11) then
					arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_12 + var_89_13 and arg_86_1.time_ < var_89_12 + var_89_13 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect6148ui_story then
				arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_89_17 = 0
			local var_89_18 = 0.175

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_19 = arg_86_1:FormatText(StoryNameCfg[1488].name)

				arg_86_1.leftNameTxt_.text = var_89_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_20 = arg_86_1:GetWordFromCfg(426011021)
				local var_89_21 = arg_86_1:FormatText(var_89_20.content)

				arg_86_1.text_.text = var_89_21

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_22 = 7
				local var_89_23 = utf8.len(var_89_21)
				local var_89_24 = var_89_22 <= 0 and var_89_18 or var_89_18 * (var_89_23 / var_89_22)

				if var_89_24 > 0 and var_89_18 < var_89_24 then
					arg_86_1.talkMaxDuration = var_89_24

					if var_89_24 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_24 + var_89_17
					end
				end

				arg_86_1.text_.text = var_89_21
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011021", "story_v_out_426011.awb") ~= 0 then
					local var_89_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011021", "story_v_out_426011.awb") / 1000

					if var_89_25 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_25 + var_89_17
					end

					if var_89_20.prefab_name ~= "" and arg_86_1.actors_[var_89_20.prefab_name] ~= nil then
						local var_89_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_20.prefab_name].transform, "story_v_out_426011", "426011021", "story_v_out_426011.awb")

						arg_86_1:RecordAudio("426011021", var_89_26)
						arg_86_1:RecordAudio("426011021", var_89_26)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_426011", "426011021", "story_v_out_426011.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_426011", "426011021", "story_v_out_426011.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_27 = math.max(var_89_18, arg_86_1.talkMaxDuration)

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_27 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_17) / var_89_27

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_17 + var_89_27 and arg_86_1.time_ < var_89_17 + var_89_27 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 426011022
		arg_90_1.duration_ = 4.03

		local var_90_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_90_0:Play426011023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1054ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1054ui_story = var_93_0.localPosition

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end
			end

			local var_93_3 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_3 then
				local var_93_4 = (arg_90_1.time_ - var_93_1) / var_93_3
				local var_93_5 = Vector3.New(0.7, -0.985, -6)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1054ui_story, var_93_5, var_93_4)

				local var_93_6 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_6.x, var_93_6.y, var_93_6.z)

				local var_93_7 = var_93_0.localEulerAngles

				var_93_7.z = 0
				var_93_7.x = 0
				var_93_0.localEulerAngles = var_93_7
			end

			if arg_90_1.time_ >= var_93_1 + var_93_3 and arg_90_1.time_ < var_93_1 + var_93_3 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_93_8 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_8.x, var_93_8.y, var_93_8.z)

				local var_93_9 = var_93_0.localEulerAngles

				var_93_9.z = 0
				var_93_9.x = 0
				var_93_0.localEulerAngles = var_93_9

				local var_93_10 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_10 then
					var_93_10:EnableDynamicBone(true)
				end
			end

			local var_93_11 = arg_90_1.actors_["1054ui_story"]
			local var_93_12 = 0

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect1054ui_story == nil then
				arg_90_1.var_.characterEffect1054ui_story = var_93_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_13 = 0.200000002980232

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_13 and not isNil(var_93_11) then
				local var_93_14 = (arg_90_1.time_ - var_93_12) / var_93_13

				if arg_90_1.var_.characterEffect1054ui_story and not isNil(var_93_11) then
					arg_90_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_12 + var_93_13 and arg_90_1.time_ < var_93_12 + var_93_13 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect1054ui_story then
				arg_90_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_93_15 = arg_90_1.actors_["6148ui_story"]
			local var_93_16 = 0

			if var_93_16 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 and not isNil(var_93_15) and arg_90_1.var_.characterEffect6148ui_story == nil then
				arg_90_1.var_.characterEffect6148ui_story = var_93_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_17 = 0.200000002980232

			if var_93_16 <= arg_90_1.time_ and arg_90_1.time_ < var_93_16 + var_93_17 and not isNil(var_93_15) then
				local var_93_18 = (arg_90_1.time_ - var_93_16) / var_93_17

				if arg_90_1.var_.characterEffect6148ui_story and not isNil(var_93_15) then
					local var_93_19 = Mathf.Lerp(0, 0.5, var_93_18)

					arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_90_1.var_.characterEffect6148ui_story.fillRatio = var_93_19
				end
			end

			if arg_90_1.time_ >= var_93_16 + var_93_17 and arg_90_1.time_ < var_93_16 + var_93_17 + arg_93_0 and not isNil(var_93_15) and arg_90_1.var_.characterEffect6148ui_story then
				local var_93_20 = 0.5

				arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_90_1.var_.characterEffect6148ui_story.fillRatio = var_93_20
			end

			local var_93_21 = 0

			if var_93_21 < arg_90_1.time_ and arg_90_1.time_ <= var_93_21 + arg_93_0 then
				arg_90_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_93_22 = 0

			if var_93_22 < arg_90_1.time_ and arg_90_1.time_ <= var_93_22 + arg_93_0 then
				arg_90_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_93_23 = 0
			local var_93_24 = 0.2

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_25 = arg_90_1:FormatText(StoryNameCfg[1487].name)

				arg_90_1.leftNameTxt_.text = var_93_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_26 = arg_90_1:GetWordFromCfg(426011022)
				local var_93_27 = arg_90_1:FormatText(var_93_26.content)

				arg_90_1.text_.text = var_93_27

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_28 = 8
				local var_93_29 = utf8.len(var_93_27)
				local var_93_30 = var_93_28 <= 0 and var_93_24 or var_93_24 * (var_93_29 / var_93_28)

				if var_93_30 > 0 and var_93_24 < var_93_30 then
					arg_90_1.talkMaxDuration = var_93_30

					if var_93_30 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_30 + var_93_23
					end
				end

				arg_90_1.text_.text = var_93_27
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011022", "story_v_out_426011.awb") ~= 0 then
					local var_93_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011022", "story_v_out_426011.awb") / 1000

					if var_93_31 + var_93_23 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_31 + var_93_23
					end

					if var_93_26.prefab_name ~= "" and arg_90_1.actors_[var_93_26.prefab_name] ~= nil then
						local var_93_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_26.prefab_name].transform, "story_v_out_426011", "426011022", "story_v_out_426011.awb")

						arg_90_1:RecordAudio("426011022", var_93_32)
						arg_90_1:RecordAudio("426011022", var_93_32)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_426011", "426011022", "story_v_out_426011.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_426011", "426011022", "story_v_out_426011.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_33 = math.max(var_93_24, arg_90_1.talkMaxDuration)

			if var_93_23 <= arg_90_1.time_ and arg_90_1.time_ < var_93_23 + var_93_33 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_23) / var_93_33

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_23 + var_93_33 and arg_90_1.time_ < var_93_23 + var_93_33 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play426011023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 426011023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play426011024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1054ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1054ui_story == nil then
				arg_94_1.var_.characterEffect1054ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1054ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1054ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1054ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1054ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.475

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(426011023)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 19
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play426011024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 426011024
		arg_98_1.duration_ = 8

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play426011025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "J27g"

			if arg_98_1.bgs_[var_101_0] == nil then
				local var_101_1 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_0)
				var_101_1.name = var_101_0
				var_101_1.transform.parent = arg_98_1.stage_.transform
				var_101_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_0] = var_101_1
			end

			local var_101_2 = 1

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				local var_101_3 = manager.ui.mainCamera.transform.localPosition
				local var_101_4 = Vector3.New(0, 0, 10) + Vector3.New(var_101_3.x, var_101_3.y, 0)
				local var_101_5 = arg_98_1.bgs_.J27g

				var_101_5.transform.localPosition = var_101_4
				var_101_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_6 = var_101_5:GetComponent("SpriteRenderer")

				if var_101_6 and var_101_6.sprite then
					local var_101_7 = (var_101_5.transform.localPosition - var_101_3).z
					local var_101_8 = manager.ui.mainCameraCom_
					local var_101_9 = 2 * var_101_7 * Mathf.Tan(var_101_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_10 = var_101_9 * var_101_8.aspect
					local var_101_11 = var_101_6.sprite.bounds.size.x
					local var_101_12 = var_101_6.sprite.bounds.size.y
					local var_101_13 = var_101_10 / var_101_11
					local var_101_14 = var_101_9 / var_101_12
					local var_101_15 = var_101_14 < var_101_13 and var_101_13 or var_101_14

					var_101_5.transform.localScale = Vector3.New(var_101_15, var_101_15, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "J27g" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_16 = 3

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_17 = 0.3

			if arg_98_1.time_ >= var_101_16 + var_101_17 and arg_98_1.time_ < var_101_16 + var_101_17 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_18 = manager.ui.mainCamera.transform
			local var_101_19 = 0

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				local var_101_20 = arg_98_1.var_.effectqiuyunshanzhuanchang1
				local var_101_21
				local var_101_22 = var_101_18

				if not var_101_20 then
					var_101_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_101_22)
					var_101_20.name = "qiuyunshanzhuanchang1"
					arg_98_1.var_.effectqiuyunshanzhuanchang1 = var_101_20
				else
					var_101_20.transform:SetParent(var_101_22)
				end

				var_101_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_101_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_101_23 = 1.7777777777777777
				local var_101_24 = Screen.width / Screen.height
				local var_101_25 = var_101_24 / var_101_23
				local var_101_26 = Mathf.Max(var_101_23 / var_101_24, 1)

				var_101_20.transform.localScale = Vector3.New(var_101_20.transform.localScale.x * var_101_25, var_101_20.transform.localScale.y * var_101_26, var_101_20.transform.localScale.z)
			end

			local var_101_27 = arg_98_1.actors_["1054ui_story"].transform
			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1.var_.moveOldPos1054ui_story = var_101_27.localPosition

				local var_101_29 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_29 then
					var_101_29:EnableDynamicBone(false)
				end
			end

			local var_101_30 = 0.001

			if var_101_28 <= arg_98_1.time_ and arg_98_1.time_ < var_101_28 + var_101_30 then
				local var_101_31 = (arg_98_1.time_ - var_101_28) / var_101_30
				local var_101_32 = Vector3.New(0, 100, 0)

				var_101_27.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1054ui_story, var_101_32, var_101_31)

				local var_101_33 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_33.x, var_101_33.y, var_101_33.z)

				local var_101_34 = var_101_27.localEulerAngles

				var_101_34.z = 0
				var_101_34.x = 0
				var_101_27.localEulerAngles = var_101_34
			end

			if arg_98_1.time_ >= var_101_28 + var_101_30 and arg_98_1.time_ < var_101_28 + var_101_30 + arg_101_0 then
				var_101_27.localPosition = Vector3.New(0, 100, 0)

				local var_101_35 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_35.x, var_101_35.y, var_101_35.z)

				local var_101_36 = var_101_27.localEulerAngles

				var_101_36.z = 0
				var_101_36.x = 0
				var_101_27.localEulerAngles = var_101_36

				local var_101_37 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_37 then
					var_101_37:EnableDynamicBone(true)
				end
			end

			local var_101_38 = arg_98_1.actors_["6148ui_story"].transform
			local var_101_39 = 0

			if var_101_39 < arg_98_1.time_ and arg_98_1.time_ <= var_101_39 + arg_101_0 then
				arg_98_1.var_.moveOldPos6148ui_story = var_101_38.localPosition

				local var_101_40 = GameObjectTools.GetOrAddComponent(var_101_38.gameObject, typeof(DynamicBoneHelper))

				if var_101_40 then
					var_101_40:EnableDynamicBone(false)
				end
			end

			local var_101_41 = 0.001

			if var_101_39 <= arg_98_1.time_ and arg_98_1.time_ < var_101_39 + var_101_41 then
				local var_101_42 = (arg_98_1.time_ - var_101_39) / var_101_41
				local var_101_43 = Vector3.New(0, 100, 0)

				var_101_38.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos6148ui_story, var_101_43, var_101_42)

				local var_101_44 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_44.x, var_101_44.y, var_101_44.z)

				local var_101_45 = var_101_38.localEulerAngles

				var_101_45.z = 0
				var_101_45.x = 0
				var_101_38.localEulerAngles = var_101_45
			end

			if arg_98_1.time_ >= var_101_39 + var_101_41 and arg_98_1.time_ < var_101_39 + var_101_41 + arg_101_0 then
				var_101_38.localPosition = Vector3.New(0, 100, 0)

				local var_101_46 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_46.x, var_101_46.y, var_101_46.z)

				local var_101_47 = var_101_38.localEulerAngles

				var_101_47.z = 0
				var_101_47.x = 0
				var_101_38.localEulerAngles = var_101_47

				local var_101_48 = GameObjectTools.GetOrAddComponent(var_101_38.gameObject, typeof(DynamicBoneHelper))

				if var_101_48 then
					var_101_48:EnableDynamicBone(true)
				end
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_49 = 3.000000000001
			local var_101_50 = 0.725

			if var_101_49 < arg_98_1.time_ and arg_98_1.time_ <= var_101_49 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_51 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_51:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_52 = arg_98_1:GetWordFromCfg(426011024)
				local var_101_53 = arg_98_1:FormatText(var_101_52.content)

				arg_98_1.text_.text = var_101_53

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_54 = 29
				local var_101_55 = utf8.len(var_101_53)
				local var_101_56 = var_101_54 <= 0 and var_101_50 or var_101_50 * (var_101_55 / var_101_54)

				if var_101_56 > 0 and var_101_50 < var_101_56 then
					arg_98_1.talkMaxDuration = var_101_56
					var_101_49 = var_101_49 + 0.3

					if var_101_56 + var_101_49 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_56 + var_101_49
					end
				end

				arg_98_1.text_.text = var_101_53
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_57 = var_101_49 + 0.3
			local var_101_58 = math.max(var_101_50, arg_98_1.talkMaxDuration)

			if var_101_57 <= arg_98_1.time_ and arg_98_1.time_ < var_101_57 + var_101_58 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_57) / var_101_58

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_57 + var_101_58 and arg_98_1.time_ < var_101_57 + var_101_58 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play426011025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 426011025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play426011026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.8

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(426011025)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 32
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play426011026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 426011026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play426011027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.6
			local var_111_1 = 1

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				local var_111_2 = "play"
				local var_111_3 = "effect"

				arg_108_1:AudioAction(var_111_2, var_111_3, "se_story_143", "se_story_143_hungry01", "")
			end

			local var_111_4 = 0
			local var_111_5 = 1.1

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(426011026)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_8 = 44
				local var_111_9 = utf8.len(var_111_7)
				local var_111_10 = var_111_8 <= 0 and var_111_5 or var_111_5 * (var_111_9 / var_111_8)

				if var_111_10 > 0 and var_111_5 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_11 and arg_108_1.time_ < var_111_4 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play426011027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 426011027
		arg_112_1.duration_ = 8.4

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play426011028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.399999999999

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				local var_115_1 = manager.ui.mainCamera.transform.localPosition
				local var_115_2 = Vector3.New(0, 0, 10) + Vector3.New(var_115_1.x, var_115_1.y, 0)
				local var_115_3 = arg_112_1.bgs_.ST2007

				var_115_3.transform.localPosition = var_115_2
				var_115_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_4 = var_115_3:GetComponent("SpriteRenderer")

				if var_115_4 and var_115_4.sprite then
					local var_115_5 = (var_115_3.transform.localPosition - var_115_1).z
					local var_115_6 = manager.ui.mainCameraCom_
					local var_115_7 = 2 * var_115_5 * Mathf.Tan(var_115_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_115_8 = var_115_7 * var_115_6.aspect
					local var_115_9 = var_115_4.sprite.bounds.size.x
					local var_115_10 = var_115_4.sprite.bounds.size.y
					local var_115_11 = var_115_8 / var_115_9
					local var_115_12 = var_115_7 / var_115_10
					local var_115_13 = var_115_12 < var_115_11 and var_115_11 or var_115_12

					var_115_3.transform.localScale = Vector3.New(var_115_13, var_115_13, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "ST2007" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_14 = 3.399999999998

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			local var_115_15 = 0.3

			if arg_112_1.time_ >= var_115_14 + var_115_15 and arg_112_1.time_ < var_115_14 + var_115_15 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end

			local var_115_16 = manager.ui.mainCamera.transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				local var_115_18 = arg_112_1.var_.effectqiuyunshanzhuanchang1
				local var_115_19
				local var_115_20 = var_115_16

				if not var_115_18 then
					var_115_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_115_20)
					var_115_18.name = "qiuyunshanzhuanchang1"
					arg_112_1.var_.effectqiuyunshanzhuanchang1 = var_115_18
				else
					var_115_18.transform:SetParent(var_115_20)
				end

				var_115_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_115_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_21 = 3.399999999999
			local var_115_22 = 0.6

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_23 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_23:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_24 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_25 = arg_112_1:GetWordFromCfg(426011027)
				local var_115_26 = arg_112_1:FormatText(var_115_25.content)

				arg_112_1.text_.text = var_115_26

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_27 = 24
				local var_115_28 = utf8.len(var_115_26)
				local var_115_29 = var_115_27 <= 0 and var_115_22 or var_115_22 * (var_115_28 / var_115_27)

				if var_115_29 > 0 and var_115_22 < var_115_29 then
					arg_112_1.talkMaxDuration = var_115_29
					var_115_21 = var_115_21 + 0.3

					if var_115_29 + var_115_21 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_21
					end
				end

				arg_112_1.text_.text = var_115_26
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_30 = var_115_21 + 0.3
			local var_115_31 = math.max(var_115_22, arg_112_1.talkMaxDuration)

			if var_115_30 <= arg_112_1.time_ and arg_112_1.time_ < var_115_30 + var_115_31 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_30) / var_115_31

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_30 + var_115_31 and arg_112_1.time_ < var_115_30 + var_115_31 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play426011028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 426011028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play426011029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.166666666666667
			local var_121_1 = 1

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				local var_121_2 = "play"
				local var_121_3 = "effect"

				arg_118_1:AudioAction(var_121_2, var_121_3, "se_story_150", "se_story_150_footstep", "")
			end

			local var_121_4 = 0
			local var_121_5 = 0.775

			if var_121_4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(426011028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_8 = 31
				local var_121_9 = utf8.len(var_121_7)
				local var_121_10 = var_121_8 <= 0 and var_121_5 or var_121_5 * (var_121_9 / var_121_8)

				if var_121_10 > 0 and var_121_5 < var_121_10 then
					arg_118_1.talkMaxDuration = var_121_10

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_11 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_11 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_11

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_11 and arg_118_1.time_ < var_121_4 + var_121_11 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play426011029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 426011029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play426011030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1.075

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

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(426011029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 43
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
	Play426011030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 426011030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play426011031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.3

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(426011030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 12
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_8 and arg_126_1.time_ < var_129_0 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play426011031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 426011031
		arg_130_1.duration_ = 9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play426011032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 2

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				local var_133_1 = manager.ui.mainCamera.transform.localPosition
				local var_133_2 = Vector3.New(0, 0, 10) + Vector3.New(var_133_1.x, var_133_1.y, 0)
				local var_133_3 = arg_130_1.bgs_.ST2007

				var_133_3.transform.localPosition = var_133_2
				var_133_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_4 = var_133_3:GetComponent("SpriteRenderer")

				if var_133_4 and var_133_4.sprite then
					local var_133_5 = (var_133_3.transform.localPosition - var_133_1).z
					local var_133_6 = manager.ui.mainCameraCom_
					local var_133_7 = 2 * var_133_5 * Mathf.Tan(var_133_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_8 = var_133_7 * var_133_6.aspect
					local var_133_9 = var_133_4.sprite.bounds.size.x
					local var_133_10 = var_133_4.sprite.bounds.size.y
					local var_133_11 = var_133_8 / var_133_9
					local var_133_12 = var_133_7 / var_133_10
					local var_133_13 = var_133_12 < var_133_11 and var_133_11 or var_133_12

					var_133_3.transform.localScale = Vector3.New(var_133_13, var_133_13, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST2007" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_14 = 4

			if var_133_14 < arg_130_1.time_ and arg_130_1.time_ <= var_133_14 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_15 = 0.3

			if arg_130_1.time_ >= var_133_14 + var_133_15 and arg_130_1.time_ < var_133_14 + var_133_15 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_17 = 2

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Color.New(0, 0, 0)

				var_133_19.a = Mathf.Lerp(0, 1, var_133_18)
				arg_130_1.mask_.color = var_133_19
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				local var_133_20 = Color.New(0, 0, 0)

				var_133_20.a = 1
				arg_130_1.mask_.color = var_133_20
			end

			local var_133_21 = 2

			if var_133_21 < arg_130_1.time_ and arg_130_1.time_ <= var_133_21 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_22 = 2

			if var_133_21 <= arg_130_1.time_ and arg_130_1.time_ < var_133_21 + var_133_22 then
				local var_133_23 = (arg_130_1.time_ - var_133_21) / var_133_22
				local var_133_24 = Color.New(0, 0, 0)

				var_133_24.a = Mathf.Lerp(1, 0, var_133_23)
				arg_130_1.mask_.color = var_133_24
			end

			if arg_130_1.time_ >= var_133_21 + var_133_22 and arg_130_1.time_ < var_133_21 + var_133_22 + arg_133_0 then
				local var_133_25 = Color.New(0, 0, 0)
				local var_133_26 = 0

				arg_130_1.mask_.enabled = false
				var_133_25.a = var_133_26
				arg_130_1.mask_.color = var_133_25
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_27 = 4
			local var_133_28 = 0.5

			if var_133_27 < arg_130_1.time_ and arg_130_1.time_ <= var_133_27 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_29 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_29:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_30 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_31 = arg_130_1:GetWordFromCfg(426011031)
				local var_133_32 = arg_130_1:FormatText(var_133_31.content)

				arg_130_1.text_.text = var_133_32

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_33 = 20
				local var_133_34 = utf8.len(var_133_32)
				local var_133_35 = var_133_33 <= 0 and var_133_28 or var_133_28 * (var_133_34 / var_133_33)

				if var_133_35 > 0 and var_133_28 < var_133_35 then
					arg_130_1.talkMaxDuration = var_133_35
					var_133_27 = var_133_27 + 0.3

					if var_133_35 + var_133_27 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_35 + var_133_27
					end
				end

				arg_130_1.text_.text = var_133_32
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_36 = var_133_27 + 0.3
			local var_133_37 = math.max(var_133_28, arg_130_1.talkMaxDuration)

			if var_133_36 <= arg_130_1.time_ and arg_130_1.time_ < var_133_36 + var_133_37 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_36) / var_133_37

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_36 + var_133_37 and arg_130_1.time_ < var_133_36 + var_133_37 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play426011032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 426011032
		arg_136_1.duration_ = 5

		local var_136_0 = {
			zh = 4.3,
			ja = 5
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
				arg_136_0:Play426011033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["6148ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos6148ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, -0.985, -6)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos6148ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["6148ui_story"]
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect6148ui_story == nil then
				arg_136_1.var_.characterEffect6148ui_story = var_139_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_13 = 0.200000002980232

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_13 and not isNil(var_139_11) then
				local var_139_14 = (arg_136_1.time_ - var_139_12) / var_139_13

				if arg_136_1.var_.characterEffect6148ui_story and not isNil(var_139_11) then
					arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_12 + var_139_13 and arg_136_1.time_ < var_139_12 + var_139_13 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect6148ui_story then
				arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_139_17 = 0
			local var_139_18 = 0.5

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_19 = arg_136_1:FormatText(StoryNameCfg[1488].name)

				arg_136_1.leftNameTxt_.text = var_139_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_20 = arg_136_1:GetWordFromCfg(426011032)
				local var_139_21 = arg_136_1:FormatText(var_139_20.content)

				arg_136_1.text_.text = var_139_21

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_22 = 20
				local var_139_23 = utf8.len(var_139_21)
				local var_139_24 = var_139_22 <= 0 and var_139_18 or var_139_18 * (var_139_23 / var_139_22)

				if var_139_24 > 0 and var_139_18 < var_139_24 then
					arg_136_1.talkMaxDuration = var_139_24

					if var_139_24 + var_139_17 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_17
					end
				end

				arg_136_1.text_.text = var_139_21
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011032", "story_v_out_426011.awb") ~= 0 then
					local var_139_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011032", "story_v_out_426011.awb") / 1000

					if var_139_25 + var_139_17 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_25 + var_139_17
					end

					if var_139_20.prefab_name ~= "" and arg_136_1.actors_[var_139_20.prefab_name] ~= nil then
						local var_139_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_20.prefab_name].transform, "story_v_out_426011", "426011032", "story_v_out_426011.awb")

						arg_136_1:RecordAudio("426011032", var_139_26)
						arg_136_1:RecordAudio("426011032", var_139_26)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_426011", "426011032", "story_v_out_426011.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_426011", "426011032", "story_v_out_426011.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_27 = math.max(var_139_18, arg_136_1.talkMaxDuration)

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_27 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_17) / var_139_27

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_17 + var_139_27 and arg_136_1.time_ < var_139_17 + var_139_27 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play426011033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 426011033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play426011034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["6148ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect6148ui_story == nil then
				arg_140_1.var_.characterEffect6148ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect6148ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_140_1.var_.characterEffect6148ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect6148ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_140_1.var_.characterEffect6148ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.375

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(426011033)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 15
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play426011034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 426011034
		arg_144_1.duration_ = 9.93

		local var_144_0 = {
			zh = 6.6,
			ja = 9.933
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
				arg_144_0:Play426011035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["6148ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos6148ui_story = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(0, -0.985, -6)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos6148ui_story, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_147_8 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_8.x, var_147_8.y, var_147_8.z)

				local var_147_9 = var_147_0.localEulerAngles

				var_147_9.z = 0
				var_147_9.x = 0
				var_147_0.localEulerAngles = var_147_9

				local var_147_10 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_10 then
					var_147_10:EnableDynamicBone(true)
				end
			end

			local var_147_11 = arg_144_1.actors_["6148ui_story"]
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect6148ui_story == nil then
				arg_144_1.var_.characterEffect6148ui_story = var_147_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_13 = 0.200000002980232

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_13 and not isNil(var_147_11) then
				local var_147_14 = (arg_144_1.time_ - var_147_12) / var_147_13

				if arg_144_1.var_.characterEffect6148ui_story and not isNil(var_147_11) then
					arg_144_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_12 + var_147_13 and arg_144_1.time_ < var_147_12 + var_147_13 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect6148ui_story then
				arg_144_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_147_15 = 0

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_17 = 0
			local var_147_18 = 0.675

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_19 = arg_144_1:FormatText(StoryNameCfg[1488].name)

				arg_144_1.leftNameTxt_.text = var_147_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_20 = arg_144_1:GetWordFromCfg(426011034)
				local var_147_21 = arg_144_1:FormatText(var_147_20.content)

				arg_144_1.text_.text = var_147_21

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_22 = 27
				local var_147_23 = utf8.len(var_147_21)
				local var_147_24 = var_147_22 <= 0 and var_147_18 or var_147_18 * (var_147_23 / var_147_22)

				if var_147_24 > 0 and var_147_18 < var_147_24 then
					arg_144_1.talkMaxDuration = var_147_24

					if var_147_24 + var_147_17 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_17
					end
				end

				arg_144_1.text_.text = var_147_21
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011034", "story_v_out_426011.awb") ~= 0 then
					local var_147_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011034", "story_v_out_426011.awb") / 1000

					if var_147_25 + var_147_17 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_25 + var_147_17
					end

					if var_147_20.prefab_name ~= "" and arg_144_1.actors_[var_147_20.prefab_name] ~= nil then
						local var_147_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_20.prefab_name].transform, "story_v_out_426011", "426011034", "story_v_out_426011.awb")

						arg_144_1:RecordAudio("426011034", var_147_26)
						arg_144_1:RecordAudio("426011034", var_147_26)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_426011", "426011034", "story_v_out_426011.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_426011", "426011034", "story_v_out_426011.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_27 = math.max(var_147_18, arg_144_1.talkMaxDuration)

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_27 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_17) / var_147_27

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_17 + var_147_27 and arg_144_1.time_ < var_147_17 + var_147_27 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play426011035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 426011035
		arg_148_1.duration_ = 9

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play426011036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 2

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				local var_151_1 = manager.ui.mainCamera.transform.localPosition
				local var_151_2 = Vector3.New(0, 0, 10) + Vector3.New(var_151_1.x, var_151_1.y, 0)
				local var_151_3 = arg_148_1.bgs_.ST2007

				var_151_3.transform.localPosition = var_151_2
				var_151_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_4 = var_151_3:GetComponent("SpriteRenderer")

				if var_151_4 and var_151_4.sprite then
					local var_151_5 = (var_151_3.transform.localPosition - var_151_1).z
					local var_151_6 = manager.ui.mainCameraCom_
					local var_151_7 = 2 * var_151_5 * Mathf.Tan(var_151_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_8 = var_151_7 * var_151_6.aspect
					local var_151_9 = var_151_4.sprite.bounds.size.x
					local var_151_10 = var_151_4.sprite.bounds.size.y
					local var_151_11 = var_151_8 / var_151_9
					local var_151_12 = var_151_7 / var_151_10
					local var_151_13 = var_151_12 < var_151_11 and var_151_11 or var_151_12

					var_151_3.transform.localScale = Vector3.New(var_151_13, var_151_13, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "ST2007" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_14 = 4

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_15 = 0.3

			if arg_148_1.time_ >= var_151_14 + var_151_15 and arg_148_1.time_ < var_151_14 + var_151_15 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_17 = 2

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17
				local var_151_19 = Color.New(0, 0, 0)

				var_151_19.a = Mathf.Lerp(0, 1, var_151_18)
				arg_148_1.mask_.color = var_151_19
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				local var_151_20 = Color.New(0, 0, 0)

				var_151_20.a = 1
				arg_148_1.mask_.color = var_151_20
			end

			local var_151_21 = 2

			if var_151_21 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_22 = 2

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_22 then
				local var_151_23 = (arg_148_1.time_ - var_151_21) / var_151_22
				local var_151_24 = Color.New(0, 0, 0)

				var_151_24.a = Mathf.Lerp(1, 0, var_151_23)
				arg_148_1.mask_.color = var_151_24
			end

			if arg_148_1.time_ >= var_151_21 + var_151_22 and arg_148_1.time_ < var_151_21 + var_151_22 + arg_151_0 then
				local var_151_25 = Color.New(0, 0, 0)
				local var_151_26 = 0

				arg_148_1.mask_.enabled = false
				var_151_25.a = var_151_26
				arg_148_1.mask_.color = var_151_25
			end

			local var_151_27 = arg_148_1.actors_["1054ui_story"].transform
			local var_151_28 = 1.96599999815226

			if var_151_28 < arg_148_1.time_ and arg_148_1.time_ <= var_151_28 + arg_151_0 then
				arg_148_1.var_.moveOldPos1054ui_story = var_151_27.localPosition

				local var_151_29 = GameObjectTools.GetOrAddComponent(var_151_27.gameObject, typeof(DynamicBoneHelper))

				if var_151_29 then
					var_151_29:EnableDynamicBone(false)
				end
			end

			local var_151_30 = 0.001

			if var_151_28 <= arg_148_1.time_ and arg_148_1.time_ < var_151_28 + var_151_30 then
				local var_151_31 = (arg_148_1.time_ - var_151_28) / var_151_30
				local var_151_32 = Vector3.New(0, 100, 0)

				var_151_27.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1054ui_story, var_151_32, var_151_31)

				local var_151_33 = manager.ui.mainCamera.transform.position - var_151_27.position

				var_151_27.forward = Vector3.New(var_151_33.x, var_151_33.y, var_151_33.z)

				local var_151_34 = var_151_27.localEulerAngles

				var_151_34.z = 0
				var_151_34.x = 0
				var_151_27.localEulerAngles = var_151_34
			end

			if arg_148_1.time_ >= var_151_28 + var_151_30 and arg_148_1.time_ < var_151_28 + var_151_30 + arg_151_0 then
				var_151_27.localPosition = Vector3.New(0, 100, 0)

				local var_151_35 = manager.ui.mainCamera.transform.position - var_151_27.position

				var_151_27.forward = Vector3.New(var_151_35.x, var_151_35.y, var_151_35.z)

				local var_151_36 = var_151_27.localEulerAngles

				var_151_36.z = 0
				var_151_36.x = 0
				var_151_27.localEulerAngles = var_151_36

				local var_151_37 = GameObjectTools.GetOrAddComponent(var_151_27.gameObject, typeof(DynamicBoneHelper))

				if var_151_37 then
					var_151_37:EnableDynamicBone(true)
				end
			end

			local var_151_38 = arg_148_1.actors_["6148ui_story"]
			local var_151_39 = 1.96599999815226

			if var_151_39 < arg_148_1.time_ and arg_148_1.time_ <= var_151_39 + arg_151_0 and not isNil(var_151_38) and arg_148_1.var_.characterEffect6148ui_story == nil then
				arg_148_1.var_.characterEffect6148ui_story = var_151_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_40 = 0.034000001847744

			if var_151_39 <= arg_148_1.time_ and arg_148_1.time_ < var_151_39 + var_151_40 and not isNil(var_151_38) then
				local var_151_41 = (arg_148_1.time_ - var_151_39) / var_151_40

				if arg_148_1.var_.characterEffect6148ui_story and not isNil(var_151_38) then
					local var_151_42 = Mathf.Lerp(0, 0.5, var_151_41)

					arg_148_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_148_1.var_.characterEffect6148ui_story.fillRatio = var_151_42
				end
			end

			if arg_148_1.time_ >= var_151_39 + var_151_40 and arg_148_1.time_ < var_151_39 + var_151_40 + arg_151_0 and not isNil(var_151_38) and arg_148_1.var_.characterEffect6148ui_story then
				local var_151_43 = 0.5

				arg_148_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_148_1.var_.characterEffect6148ui_story.fillRatio = var_151_43
			end

			local var_151_44 = arg_148_1.actors_["6148ui_story"].transform
			local var_151_45 = 1.96599999815226

			if var_151_45 < arg_148_1.time_ and arg_148_1.time_ <= var_151_45 + arg_151_0 then
				arg_148_1.var_.moveOldPos6148ui_story = var_151_44.localPosition

				local var_151_46 = GameObjectTools.GetOrAddComponent(var_151_44.gameObject, typeof(DynamicBoneHelper))

				if var_151_46 then
					var_151_46:EnableDynamicBone(false)
				end
			end

			local var_151_47 = 0.001

			if var_151_45 <= arg_148_1.time_ and arg_148_1.time_ < var_151_45 + var_151_47 then
				local var_151_48 = (arg_148_1.time_ - var_151_45) / var_151_47
				local var_151_49 = Vector3.New(0, 100, 0)

				var_151_44.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos6148ui_story, var_151_49, var_151_48)

				local var_151_50 = manager.ui.mainCamera.transform.position - var_151_44.position

				var_151_44.forward = Vector3.New(var_151_50.x, var_151_50.y, var_151_50.z)

				local var_151_51 = var_151_44.localEulerAngles

				var_151_51.z = 0
				var_151_51.x = 0
				var_151_44.localEulerAngles = var_151_51
			end

			if arg_148_1.time_ >= var_151_45 + var_151_47 and arg_148_1.time_ < var_151_45 + var_151_47 + arg_151_0 then
				var_151_44.localPosition = Vector3.New(0, 100, 0)

				local var_151_52 = manager.ui.mainCamera.transform.position - var_151_44.position

				var_151_44.forward = Vector3.New(var_151_52.x, var_151_52.y, var_151_52.z)

				local var_151_53 = var_151_44.localEulerAngles

				var_151_53.z = 0
				var_151_53.x = 0
				var_151_44.localEulerAngles = var_151_53

				local var_151_54 = GameObjectTools.GetOrAddComponent(var_151_44.gameObject, typeof(DynamicBoneHelper))

				if var_151_54 then
					var_151_54:EnableDynamicBone(true)
				end
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_55 = 4
			local var_151_56 = 0.975

			if var_151_55 < arg_148_1.time_ and arg_148_1.time_ <= var_151_55 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_57 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_57:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_58 = arg_148_1:GetWordFromCfg(426011035)
				local var_151_59 = arg_148_1:FormatText(var_151_58.content)

				arg_148_1.text_.text = var_151_59

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_60 = 39
				local var_151_61 = utf8.len(var_151_59)
				local var_151_62 = var_151_60 <= 0 and var_151_56 or var_151_56 * (var_151_61 / var_151_60)

				if var_151_62 > 0 and var_151_56 < var_151_62 then
					arg_148_1.talkMaxDuration = var_151_62
					var_151_55 = var_151_55 + 0.3

					if var_151_62 + var_151_55 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_62 + var_151_55
					end
				end

				arg_148_1.text_.text = var_151_59
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_63 = var_151_55 + 0.3
			local var_151_64 = math.max(var_151_56, arg_148_1.talkMaxDuration)

			if var_151_63 <= arg_148_1.time_ and arg_148_1.time_ < var_151_63 + var_151_64 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_63) / var_151_64

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_63 + var_151_64 and arg_148_1.time_ < var_151_63 + var_151_64 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play426011036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 426011036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play426011037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 1.275

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(426011036)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 51
				local var_157_5 = utf8.len(var_157_3)
				local var_157_6 = var_157_4 <= 0 and var_157_1 or var_157_1 * (var_157_5 / var_157_4)

				if var_157_6 > 0 and var_157_1 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_7 and arg_154_1.time_ < var_157_0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play426011037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 426011037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play426011038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.225

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(426011037)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 9
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_8 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_8 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_8

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_8 and arg_158_1.time_ < var_161_0 + var_161_8 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play426011038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 426011038
		arg_162_1.duration_ = 6.8

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play426011039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1054ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1054ui_story = var_165_0.localPosition

				local var_165_2 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(false)
				end
			end

			local var_165_3 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_3 then
				local var_165_4 = (arg_162_1.time_ - var_165_1) / var_165_3
				local var_165_5 = Vector3.New(0, -0.985, -6)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1054ui_story, var_165_5, var_165_4)

				local var_165_6 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_6.x, var_165_6.y, var_165_6.z)

				local var_165_7 = var_165_0.localEulerAngles

				var_165_7.z = 0
				var_165_7.x = 0
				var_165_0.localEulerAngles = var_165_7
			end

			if arg_162_1.time_ >= var_165_1 + var_165_3 and arg_162_1.time_ < var_165_1 + var_165_3 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_165_8 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_8.x, var_165_8.y, var_165_8.z)

				local var_165_9 = var_165_0.localEulerAngles

				var_165_9.z = 0
				var_165_9.x = 0
				var_165_0.localEulerAngles = var_165_9

				local var_165_10 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_10 then
					var_165_10:EnableDynamicBone(true)
				end
			end

			local var_165_11 = arg_162_1.actors_["1054ui_story"]
			local var_165_12 = 0

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect1054ui_story == nil then
				arg_162_1.var_.characterEffect1054ui_story = var_165_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_13 = 0.200000002980232

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_13 and not isNil(var_165_11) then
				local var_165_14 = (arg_162_1.time_ - var_165_12) / var_165_13

				if arg_162_1.var_.characterEffect1054ui_story and not isNil(var_165_11) then
					arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_12 + var_165_13 and arg_162_1.time_ < var_165_12 + var_165_13 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect1054ui_story then
				arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_165_15 = 0

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_165_16 = 0

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_165_17 = 0
			local var_165_18 = 0.6

			if var_165_17 < arg_162_1.time_ and arg_162_1.time_ <= var_165_17 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_19 = arg_162_1:FormatText(StoryNameCfg[1487].name)

				arg_162_1.leftNameTxt_.text = var_165_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_20 = arg_162_1:GetWordFromCfg(426011038)
				local var_165_21 = arg_162_1:FormatText(var_165_20.content)

				arg_162_1.text_.text = var_165_21

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_22 = 24
				local var_165_23 = utf8.len(var_165_21)
				local var_165_24 = var_165_22 <= 0 and var_165_18 or var_165_18 * (var_165_23 / var_165_22)

				if var_165_24 > 0 and var_165_18 < var_165_24 then
					arg_162_1.talkMaxDuration = var_165_24

					if var_165_24 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_24 + var_165_17
					end
				end

				arg_162_1.text_.text = var_165_21
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011038", "story_v_out_426011.awb") ~= 0 then
					local var_165_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011038", "story_v_out_426011.awb") / 1000

					if var_165_25 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_25 + var_165_17
					end

					if var_165_20.prefab_name ~= "" and arg_162_1.actors_[var_165_20.prefab_name] ~= nil then
						local var_165_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_20.prefab_name].transform, "story_v_out_426011", "426011038", "story_v_out_426011.awb")

						arg_162_1:RecordAudio("426011038", var_165_26)
						arg_162_1:RecordAudio("426011038", var_165_26)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_426011", "426011038", "story_v_out_426011.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_426011", "426011038", "story_v_out_426011.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_27 = math.max(var_165_18, arg_162_1.talkMaxDuration)

			if var_165_17 <= arg_162_1.time_ and arg_162_1.time_ < var_165_17 + var_165_27 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_17) / var_165_27

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_17 + var_165_27 and arg_162_1.time_ < var_165_17 + var_165_27 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426011039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 426011039
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play426011040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1054ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1054ui_story == nil then
				arg_166_1.var_.characterEffect1054ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1054ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1054ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1054ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1054ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 0.6

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_9 = arg_166_1:GetWordFromCfg(426011039)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 24
				local var_169_12 = utf8.len(var_169_10)
				local var_169_13 = var_169_11 <= 0 and var_169_7 or var_169_7 * (var_169_12 / var_169_11)

				if var_169_13 > 0 and var_169_7 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play426011040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 426011040
		arg_170_1.duration_ = 9.53

		local var_170_0 = {
			zh = 8.4,
			ja = 9.533
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
				arg_170_0:Play426011041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["6148ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos6148ui_story = var_173_0.localPosition

				local var_173_2 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(false)
				end
			end

			local var_173_3 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_3 then
				local var_173_4 = (arg_170_1.time_ - var_173_1) / var_173_3
				local var_173_5 = Vector3.New(0.7, -0.985, -6)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos6148ui_story, var_173_5, var_173_4)

				local var_173_6 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_6.x, var_173_6.y, var_173_6.z)

				local var_173_7 = var_173_0.localEulerAngles

				var_173_7.z = 0
				var_173_7.x = 0
				var_173_0.localEulerAngles = var_173_7
			end

			if arg_170_1.time_ >= var_173_1 + var_173_3 and arg_170_1.time_ < var_173_1 + var_173_3 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_173_8 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_8.x, var_173_8.y, var_173_8.z)

				local var_173_9 = var_173_0.localEulerAngles

				var_173_9.z = 0
				var_173_9.x = 0
				var_173_0.localEulerAngles = var_173_9

				local var_173_10 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_10 then
					var_173_10:EnableDynamicBone(true)
				end
			end

			local var_173_11 = arg_170_1.actors_["1054ui_story"].transform
			local var_173_12 = 0

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.var_.moveOldPos1054ui_story = var_173_11.localPosition

				local var_173_13 = GameObjectTools.GetOrAddComponent(var_173_11.gameObject, typeof(DynamicBoneHelper))

				if var_173_13 then
					var_173_13:EnableDynamicBone(false)
				end
			end

			local var_173_14 = 0.001

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_14 then
				local var_173_15 = (arg_170_1.time_ - var_173_12) / var_173_14
				local var_173_16 = Vector3.New(-0.7, -0.985, -6)

				var_173_11.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1054ui_story, var_173_16, var_173_15)

				local var_173_17 = manager.ui.mainCamera.transform.position - var_173_11.position

				var_173_11.forward = Vector3.New(var_173_17.x, var_173_17.y, var_173_17.z)

				local var_173_18 = var_173_11.localEulerAngles

				var_173_18.z = 0
				var_173_18.x = 0
				var_173_11.localEulerAngles = var_173_18
			end

			if arg_170_1.time_ >= var_173_12 + var_173_14 and arg_170_1.time_ < var_173_12 + var_173_14 + arg_173_0 then
				var_173_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_173_19 = manager.ui.mainCamera.transform.position - var_173_11.position

				var_173_11.forward = Vector3.New(var_173_19.x, var_173_19.y, var_173_19.z)

				local var_173_20 = var_173_11.localEulerAngles

				var_173_20.z = 0
				var_173_20.x = 0
				var_173_11.localEulerAngles = var_173_20

				local var_173_21 = GameObjectTools.GetOrAddComponent(var_173_11.gameObject, typeof(DynamicBoneHelper))

				if var_173_21 then
					var_173_21:EnableDynamicBone(true)
				end
			end

			local var_173_22 = arg_170_1.actors_["6148ui_story"]
			local var_173_23 = 0

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 and not isNil(var_173_22) and arg_170_1.var_.characterEffect6148ui_story == nil then
				arg_170_1.var_.characterEffect6148ui_story = var_173_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_24 = 0.200000002980232

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_24 and not isNil(var_173_22) then
				local var_173_25 = (arg_170_1.time_ - var_173_23) / var_173_24

				if arg_170_1.var_.characterEffect6148ui_story and not isNil(var_173_22) then
					arg_170_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_23 + var_173_24 and arg_170_1.time_ < var_173_23 + var_173_24 + arg_173_0 and not isNil(var_173_22) and arg_170_1.var_.characterEffect6148ui_story then
				arg_170_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_173_26 = 0

			if var_173_26 < arg_170_1.time_ and arg_170_1.time_ <= var_173_26 + arg_173_0 then
				arg_170_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_173_27 = 0
			local var_173_28 = 0.9

			if var_173_27 < arg_170_1.time_ and arg_170_1.time_ <= var_173_27 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_29 = arg_170_1:FormatText(StoryNameCfg[1488].name)

				arg_170_1.leftNameTxt_.text = var_173_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_30 = arg_170_1:GetWordFromCfg(426011040)
				local var_173_31 = arg_170_1:FormatText(var_173_30.content)

				arg_170_1.text_.text = var_173_31

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_32 = 36
				local var_173_33 = utf8.len(var_173_31)
				local var_173_34 = var_173_32 <= 0 and var_173_28 or var_173_28 * (var_173_33 / var_173_32)

				if var_173_34 > 0 and var_173_28 < var_173_34 then
					arg_170_1.talkMaxDuration = var_173_34

					if var_173_34 + var_173_27 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_34 + var_173_27
					end
				end

				arg_170_1.text_.text = var_173_31
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011040", "story_v_out_426011.awb") ~= 0 then
					local var_173_35 = manager.audio:GetVoiceLength("story_v_out_426011", "426011040", "story_v_out_426011.awb") / 1000

					if var_173_35 + var_173_27 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_35 + var_173_27
					end

					if var_173_30.prefab_name ~= "" and arg_170_1.actors_[var_173_30.prefab_name] ~= nil then
						local var_173_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_30.prefab_name].transform, "story_v_out_426011", "426011040", "story_v_out_426011.awb")

						arg_170_1:RecordAudio("426011040", var_173_36)
						arg_170_1:RecordAudio("426011040", var_173_36)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_426011", "426011040", "story_v_out_426011.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_426011", "426011040", "story_v_out_426011.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_37 = math.max(var_173_28, arg_170_1.talkMaxDuration)

			if var_173_27 <= arg_170_1.time_ and arg_170_1.time_ < var_173_27 + var_173_37 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_27) / var_173_37

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_27 + var_173_37 and arg_170_1.time_ < var_173_27 + var_173_37 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play426011041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 426011041
		arg_174_1.duration_ = 12.7

		local var_174_0 = {
			zh = 12.7,
			ja = 11.333
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
				arg_174_0:Play426011042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.625

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[1488].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_3 = arg_174_1:GetWordFromCfg(426011041)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 65
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011041", "story_v_out_426011.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011041", "story_v_out_426011.awb") / 1000

					if var_177_8 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_0
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_426011", "426011041", "story_v_out_426011.awb")

						arg_174_1:RecordAudio("426011041", var_177_9)
						arg_174_1:RecordAudio("426011041", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_426011", "426011041", "story_v_out_426011.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_426011", "426011041", "story_v_out_426011.awb")
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
	Play426011042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 426011042
		arg_178_1.duration_ = 12.47

		local var_178_0 = {
			zh = 8.133,
			ja = 12.466
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
				arg_178_0:Play426011043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1.1

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[1488].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(426011042)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011042", "story_v_out_426011.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011042", "story_v_out_426011.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_426011", "426011042", "story_v_out_426011.awb")

						arg_178_1:RecordAudio("426011042", var_181_9)
						arg_178_1:RecordAudio("426011042", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_426011", "426011042", "story_v_out_426011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_426011", "426011042", "story_v_out_426011.awb")
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
	Play426011043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 426011043
		arg_182_1.duration_ = 10.9

		local var_182_0 = {
			zh = 6.333,
			ja = 10.9
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
				arg_182_0:Play426011044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["6148ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos6148ui_story = var_185_0.localPosition

				local var_185_2 = GameObjectTools.GetOrAddComponent(var_185_0.gameObject, typeof(DynamicBoneHelper))

				if var_185_2 then
					var_185_2:EnableDynamicBone(false)
				end
			end

			local var_185_3 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_3 then
				local var_185_4 = (arg_182_1.time_ - var_185_1) / var_185_3
				local var_185_5 = Vector3.New(0.7, -0.985, -6)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos6148ui_story, var_185_5, var_185_4)

				local var_185_6 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_6.x, var_185_6.y, var_185_6.z)

				local var_185_7 = var_185_0.localEulerAngles

				var_185_7.z = 0
				var_185_7.x = 0
				var_185_0.localEulerAngles = var_185_7
			end

			if arg_182_1.time_ >= var_185_1 + var_185_3 and arg_182_1.time_ < var_185_1 + var_185_3 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_185_8 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_8.x, var_185_8.y, var_185_8.z)

				local var_185_9 = var_185_0.localEulerAngles

				var_185_9.z = 0
				var_185_9.x = 0
				var_185_0.localEulerAngles = var_185_9

				local var_185_10 = GameObjectTools.GetOrAddComponent(var_185_0.gameObject, typeof(DynamicBoneHelper))

				if var_185_10 then
					var_185_10:EnableDynamicBone(true)
				end
			end

			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_185_12 = 0
			local var_185_13 = 0.875

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_14 = arg_182_1:FormatText(StoryNameCfg[1488].name)

				arg_182_1.leftNameTxt_.text = var_185_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_15 = arg_182_1:GetWordFromCfg(426011043)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 35
				local var_185_18 = utf8.len(var_185_16)
				local var_185_19 = var_185_17 <= 0 and var_185_13 or var_185_13 * (var_185_18 / var_185_17)

				if var_185_19 > 0 and var_185_13 < var_185_19 then
					arg_182_1.talkMaxDuration = var_185_19

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011043", "story_v_out_426011.awb") ~= 0 then
					local var_185_20 = manager.audio:GetVoiceLength("story_v_out_426011", "426011043", "story_v_out_426011.awb") / 1000

					if var_185_20 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_426011", "426011043", "story_v_out_426011.awb")

						arg_182_1:RecordAudio("426011043", var_185_21)
						arg_182_1:RecordAudio("426011043", var_185_21)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_426011", "426011043", "story_v_out_426011.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_426011", "426011043", "story_v_out_426011.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_22 and arg_182_1.time_ < var_185_12 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 426011044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play426011045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["6148ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect6148ui_story == nil then
				arg_186_1.var_.characterEffect6148ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect6148ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_186_1.var_.characterEffect6148ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect6148ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_186_1.var_.characterEffect6148ui_story.fillRatio = var_189_5
			end

			local var_189_6 = 0
			local var_189_7 = 0.475

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_8 = arg_186_1:FormatText(StoryNameCfg[7].name)

				arg_186_1.leftNameTxt_.text = var_189_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_9 = arg_186_1:GetWordFromCfg(426011044)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 19
				local var_189_12 = utf8.len(var_189_10)
				local var_189_13 = var_189_11 <= 0 and var_189_7 or var_189_7 * (var_189_12 / var_189_11)

				if var_189_13 > 0 and var_189_7 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_14 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_14 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_14

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_14 and arg_186_1.time_ < var_189_6 + var_189_14 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play426011045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 426011045
		arg_190_1.duration_ = 6.4

		local var_190_0 = {
			zh = 6.266,
			ja = 6.4
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
				arg_190_0:Play426011046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1054ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1054ui_story = var_193_0.localPosition

				local var_193_2 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_2 then
					var_193_2:EnableDynamicBone(false)
				end
			end

			local var_193_3 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_3 then
				local var_193_4 = (arg_190_1.time_ - var_193_1) / var_193_3
				local var_193_5 = Vector3.New(-0.7, -0.985, -6)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1054ui_story, var_193_5, var_193_4)

				local var_193_6 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_6.x, var_193_6.y, var_193_6.z)

				local var_193_7 = var_193_0.localEulerAngles

				var_193_7.z = 0
				var_193_7.x = 0
				var_193_0.localEulerAngles = var_193_7
			end

			if arg_190_1.time_ >= var_193_1 + var_193_3 and arg_190_1.time_ < var_193_1 + var_193_3 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_193_8 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_8.x, var_193_8.y, var_193_8.z)

				local var_193_9 = var_193_0.localEulerAngles

				var_193_9.z = 0
				var_193_9.x = 0
				var_193_0.localEulerAngles = var_193_9

				local var_193_10 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_10 then
					var_193_10:EnableDynamicBone(true)
				end
			end

			local var_193_11 = arg_190_1.actors_["1054ui_story"]
			local var_193_12 = 0

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect1054ui_story == nil then
				arg_190_1.var_.characterEffect1054ui_story = var_193_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_13 = 0.200000002980232

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_13 and not isNil(var_193_11) then
				local var_193_14 = (arg_190_1.time_ - var_193_12) / var_193_13

				if arg_190_1.var_.characterEffect1054ui_story and not isNil(var_193_11) then
					arg_190_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_12 + var_193_13 and arg_190_1.time_ < var_193_12 + var_193_13 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect1054ui_story then
				arg_190_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_193_15 = 0

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_193_16 = 0
			local var_193_17 = 0.7

			if var_193_16 < arg_190_1.time_ and arg_190_1.time_ <= var_193_16 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_18 = arg_190_1:FormatText(StoryNameCfg[1487].name)

				arg_190_1.leftNameTxt_.text = var_193_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_19 = arg_190_1:GetWordFromCfg(426011045)
				local var_193_20 = arg_190_1:FormatText(var_193_19.content)

				arg_190_1.text_.text = var_193_20

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_21 = 28
				local var_193_22 = utf8.len(var_193_20)
				local var_193_23 = var_193_21 <= 0 and var_193_17 or var_193_17 * (var_193_22 / var_193_21)

				if var_193_23 > 0 and var_193_17 < var_193_23 then
					arg_190_1.talkMaxDuration = var_193_23

					if var_193_23 + var_193_16 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_16
					end
				end

				arg_190_1.text_.text = var_193_20
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011045", "story_v_out_426011.awb") ~= 0 then
					local var_193_24 = manager.audio:GetVoiceLength("story_v_out_426011", "426011045", "story_v_out_426011.awb") / 1000

					if var_193_24 + var_193_16 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_24 + var_193_16
					end

					if var_193_19.prefab_name ~= "" and arg_190_1.actors_[var_193_19.prefab_name] ~= nil then
						local var_193_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_19.prefab_name].transform, "story_v_out_426011", "426011045", "story_v_out_426011.awb")

						arg_190_1:RecordAudio("426011045", var_193_25)
						arg_190_1:RecordAudio("426011045", var_193_25)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_426011", "426011045", "story_v_out_426011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_426011", "426011045", "story_v_out_426011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_26 = math.max(var_193_17, arg_190_1.talkMaxDuration)

			if var_193_16 <= arg_190_1.time_ and arg_190_1.time_ < var_193_16 + var_193_26 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_16) / var_193_26

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_16 + var_193_26 and arg_190_1.time_ < var_193_16 + var_193_26 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426011046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 426011046
		arg_194_1.duration_ = 9.07

		local var_194_0 = {
			zh = 8.133,
			ja = 9.066
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
				arg_194_0:Play426011047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["6148ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos6148ui_story = var_197_0.localPosition

				local var_197_2 = GameObjectTools.GetOrAddComponent(var_197_0.gameObject, typeof(DynamicBoneHelper))

				if var_197_2 then
					var_197_2:EnableDynamicBone(false)
				end
			end

			local var_197_3 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_3 then
				local var_197_4 = (arg_194_1.time_ - var_197_1) / var_197_3
				local var_197_5 = Vector3.New(0.7, -0.985, -6)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos6148ui_story, var_197_5, var_197_4)

				local var_197_6 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_6.x, var_197_6.y, var_197_6.z)

				local var_197_7 = var_197_0.localEulerAngles

				var_197_7.z = 0
				var_197_7.x = 0
				var_197_0.localEulerAngles = var_197_7
			end

			if arg_194_1.time_ >= var_197_1 + var_197_3 and arg_194_1.time_ < var_197_1 + var_197_3 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_197_8 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_8.x, var_197_8.y, var_197_8.z)

				local var_197_9 = var_197_0.localEulerAngles

				var_197_9.z = 0
				var_197_9.x = 0
				var_197_0.localEulerAngles = var_197_9

				local var_197_10 = GameObjectTools.GetOrAddComponent(var_197_0.gameObject, typeof(DynamicBoneHelper))

				if var_197_10 then
					var_197_10:EnableDynamicBone(true)
				end
			end

			local var_197_11 = arg_194_1.actors_["6148ui_story"]
			local var_197_12 = 0

			if var_197_12 < arg_194_1.time_ and arg_194_1.time_ <= var_197_12 + arg_197_0 and not isNil(var_197_11) and arg_194_1.var_.characterEffect6148ui_story == nil then
				arg_194_1.var_.characterEffect6148ui_story = var_197_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_13 = 0.200000002980232

			if var_197_12 <= arg_194_1.time_ and arg_194_1.time_ < var_197_12 + var_197_13 and not isNil(var_197_11) then
				local var_197_14 = (arg_194_1.time_ - var_197_12) / var_197_13

				if arg_194_1.var_.characterEffect6148ui_story and not isNil(var_197_11) then
					arg_194_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_12 + var_197_13 and arg_194_1.time_ < var_197_12 + var_197_13 + arg_197_0 and not isNil(var_197_11) and arg_194_1.var_.characterEffect6148ui_story then
				arg_194_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_197_15 = arg_194_1.actors_["1054ui_story"]
			local var_197_16 = 0

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect1054ui_story == nil then
				arg_194_1.var_.characterEffect1054ui_story = var_197_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_17 = 0.200000002980232

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 and not isNil(var_197_15) then
				local var_197_18 = (arg_194_1.time_ - var_197_16) / var_197_17

				if arg_194_1.var_.characterEffect1054ui_story and not isNil(var_197_15) then
					local var_197_19 = Mathf.Lerp(0, 0.5, var_197_18)

					arg_194_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1054ui_story.fillRatio = var_197_19
				end
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 and not isNil(var_197_15) and arg_194_1.var_.characterEffect1054ui_story then
				local var_197_20 = 0.5

				arg_194_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1054ui_story.fillRatio = var_197_20
			end

			local var_197_21 = 0

			if var_197_21 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_197_22 = 0
			local var_197_23 = 1.05

			if var_197_22 < arg_194_1.time_ and arg_194_1.time_ <= var_197_22 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_24 = arg_194_1:FormatText(StoryNameCfg[1488].name)

				arg_194_1.leftNameTxt_.text = var_197_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_25 = arg_194_1:GetWordFromCfg(426011046)
				local var_197_26 = arg_194_1:FormatText(var_197_25.content)

				arg_194_1.text_.text = var_197_26

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_27 = 42
				local var_197_28 = utf8.len(var_197_26)
				local var_197_29 = var_197_27 <= 0 and var_197_23 or var_197_23 * (var_197_28 / var_197_27)

				if var_197_29 > 0 and var_197_23 < var_197_29 then
					arg_194_1.talkMaxDuration = var_197_29

					if var_197_29 + var_197_22 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_29 + var_197_22
					end
				end

				arg_194_1.text_.text = var_197_26
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011046", "story_v_out_426011.awb") ~= 0 then
					local var_197_30 = manager.audio:GetVoiceLength("story_v_out_426011", "426011046", "story_v_out_426011.awb") / 1000

					if var_197_30 + var_197_22 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_30 + var_197_22
					end

					if var_197_25.prefab_name ~= "" and arg_194_1.actors_[var_197_25.prefab_name] ~= nil then
						local var_197_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_25.prefab_name].transform, "story_v_out_426011", "426011046", "story_v_out_426011.awb")

						arg_194_1:RecordAudio("426011046", var_197_31)
						arg_194_1:RecordAudio("426011046", var_197_31)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_426011", "426011046", "story_v_out_426011.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_426011", "426011046", "story_v_out_426011.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_32 = math.max(var_197_23, arg_194_1.talkMaxDuration)

			if var_197_22 <= arg_194_1.time_ and arg_194_1.time_ < var_197_22 + var_197_32 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_22) / var_197_32

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_22 + var_197_32 and arg_194_1.time_ < var_197_22 + var_197_32 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 426011047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play426011048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["6148ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect6148ui_story == nil then
				arg_198_1.var_.characterEffect6148ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect6148ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_198_1.var_.characterEffect6148ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect6148ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_198_1.var_.characterEffect6148ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.45

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

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(426011047)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 18
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
	Play426011048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 426011048
		arg_202_1.duration_ = 6.3

		local var_202_0 = {
			zh = 5.966,
			ja = 6.3
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
				arg_202_0:Play426011049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["6148ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos6148ui_story = var_205_0.localPosition

				local var_205_2 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(false)
				end
			end

			local var_205_3 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_3 then
				local var_205_4 = (arg_202_1.time_ - var_205_1) / var_205_3
				local var_205_5 = Vector3.New(0.7, -0.985, -6)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos6148ui_story, var_205_5, var_205_4)

				local var_205_6 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_6.x, var_205_6.y, var_205_6.z)

				local var_205_7 = var_205_0.localEulerAngles

				var_205_7.z = 0
				var_205_7.x = 0
				var_205_0.localEulerAngles = var_205_7
			end

			if arg_202_1.time_ >= var_205_1 + var_205_3 and arg_202_1.time_ < var_205_1 + var_205_3 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_205_8 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_8.x, var_205_8.y, var_205_8.z)

				local var_205_9 = var_205_0.localEulerAngles

				var_205_9.z = 0
				var_205_9.x = 0
				var_205_0.localEulerAngles = var_205_9

				local var_205_10 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_10 then
					var_205_10:EnableDynamicBone(true)
				end
			end

			local var_205_11 = arg_202_1.actors_["6148ui_story"]
			local var_205_12 = 0

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.characterEffect6148ui_story == nil then
				arg_202_1.var_.characterEffect6148ui_story = var_205_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_13 = 0.200000002980232

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_13 and not isNil(var_205_11) then
				local var_205_14 = (arg_202_1.time_ - var_205_12) / var_205_13

				if arg_202_1.var_.characterEffect6148ui_story and not isNil(var_205_11) then
					arg_202_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_12 + var_205_13 and arg_202_1.time_ < var_205_12 + var_205_13 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.characterEffect6148ui_story then
				arg_202_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_205_15 = 0

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_205_16 = 0
			local var_205_17 = 0.675

			if var_205_16 < arg_202_1.time_ and arg_202_1.time_ <= var_205_16 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_18 = arg_202_1:FormatText(StoryNameCfg[1488].name)

				arg_202_1.leftNameTxt_.text = var_205_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_19 = arg_202_1:GetWordFromCfg(426011048)
				local var_205_20 = arg_202_1:FormatText(var_205_19.content)

				arg_202_1.text_.text = var_205_20

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_21 = 27
				local var_205_22 = utf8.len(var_205_20)
				local var_205_23 = var_205_21 <= 0 and var_205_17 or var_205_17 * (var_205_22 / var_205_21)

				if var_205_23 > 0 and var_205_17 < var_205_23 then
					arg_202_1.talkMaxDuration = var_205_23

					if var_205_23 + var_205_16 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_16
					end
				end

				arg_202_1.text_.text = var_205_20
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011048", "story_v_out_426011.awb") ~= 0 then
					local var_205_24 = manager.audio:GetVoiceLength("story_v_out_426011", "426011048", "story_v_out_426011.awb") / 1000

					if var_205_24 + var_205_16 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_24 + var_205_16
					end

					if var_205_19.prefab_name ~= "" and arg_202_1.actors_[var_205_19.prefab_name] ~= nil then
						local var_205_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_19.prefab_name].transform, "story_v_out_426011", "426011048", "story_v_out_426011.awb")

						arg_202_1:RecordAudio("426011048", var_205_25)
						arg_202_1:RecordAudio("426011048", var_205_25)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_426011", "426011048", "story_v_out_426011.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_426011", "426011048", "story_v_out_426011.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_26 = math.max(var_205_17, arg_202_1.talkMaxDuration)

			if var_205_16 <= arg_202_1.time_ and arg_202_1.time_ < var_205_16 + var_205_26 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_16) / var_205_26

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_16 + var_205_26 and arg_202_1.time_ < var_205_16 + var_205_26 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 426011049
		arg_206_1.duration_ = 11.1

		local var_206_0 = {
			zh = 5.466,
			ja = 11.1
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
				arg_206_0:Play426011050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.75

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[1488].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:GetWordFromCfg(426011049)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011049", "story_v_out_426011.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011049", "story_v_out_426011.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_426011", "426011049", "story_v_out_426011.awb")

						arg_206_1:RecordAudio("426011049", var_209_9)
						arg_206_1:RecordAudio("426011049", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_426011", "426011049", "story_v_out_426011.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_426011", "426011049", "story_v_out_426011.awb")
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
	Play426011050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 426011050
		arg_210_1.duration_ = 7.67

		local var_210_0 = {
			zh = 5.733,
			ja = 7.666
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
				arg_210_0:Play426011051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["6148ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos6148ui_story = var_213_0.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_3 then
				local var_213_4 = (arg_210_1.time_ - var_213_1) / var_213_3
				local var_213_5 = Vector3.New(0.7, -0.985, -6)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos6148ui_story, var_213_5, var_213_4)

				local var_213_6 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_6.x, var_213_6.y, var_213_6.z)

				local var_213_7 = var_213_0.localEulerAngles

				var_213_7.z = 0
				var_213_7.x = 0
				var_213_0.localEulerAngles = var_213_7
			end

			if arg_210_1.time_ >= var_213_1 + var_213_3 and arg_210_1.time_ < var_213_1 + var_213_3 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_213_8 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_8.x, var_213_8.y, var_213_8.z)

				local var_213_9 = var_213_0.localEulerAngles

				var_213_9.z = 0
				var_213_9.x = 0
				var_213_0.localEulerAngles = var_213_9

				local var_213_10 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_10 then
					var_213_10:EnableDynamicBone(true)
				end
			end

			local var_213_11 = 0

			if var_213_11 < arg_210_1.time_ and arg_210_1.time_ <= var_213_11 + arg_213_0 then
				arg_210_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_213_12 = 0

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 then
				arg_210_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_213_13 = 0
			local var_213_14 = 0.7

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_15 = arg_210_1:FormatText(StoryNameCfg[1488].name)

				arg_210_1.leftNameTxt_.text = var_213_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_16 = arg_210_1:GetWordFromCfg(426011050)
				local var_213_17 = arg_210_1:FormatText(var_213_16.content)

				arg_210_1.text_.text = var_213_17

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_18 = 28
				local var_213_19 = utf8.len(var_213_17)
				local var_213_20 = var_213_18 <= 0 and var_213_14 or var_213_14 * (var_213_19 / var_213_18)

				if var_213_20 > 0 and var_213_14 < var_213_20 then
					arg_210_1.talkMaxDuration = var_213_20

					if var_213_20 + var_213_13 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_20 + var_213_13
					end
				end

				arg_210_1.text_.text = var_213_17
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011050", "story_v_out_426011.awb") ~= 0 then
					local var_213_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011050", "story_v_out_426011.awb") / 1000

					if var_213_21 + var_213_13 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_21 + var_213_13
					end

					if var_213_16.prefab_name ~= "" and arg_210_1.actors_[var_213_16.prefab_name] ~= nil then
						local var_213_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_16.prefab_name].transform, "story_v_out_426011", "426011050", "story_v_out_426011.awb")

						arg_210_1:RecordAudio("426011050", var_213_22)
						arg_210_1:RecordAudio("426011050", var_213_22)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_426011", "426011050", "story_v_out_426011.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_426011", "426011050", "story_v_out_426011.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_23 = math.max(var_213_14, arg_210_1.talkMaxDuration)

			if var_213_13 <= arg_210_1.time_ and arg_210_1.time_ < var_213_13 + var_213_23 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_13) / var_213_23

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_13 + var_213_23 and arg_210_1.time_ < var_213_13 + var_213_23 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 426011051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play426011052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["6148ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect6148ui_story == nil then
				arg_214_1.var_.characterEffect6148ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect6148ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_214_1.var_.characterEffect6148ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect6148ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_214_1.var_.characterEffect6148ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.65

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

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(426011051)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 26
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
	Play426011052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 426011052
		arg_218_1.duration_ = 7.57

		local var_218_0 = {
			zh = 5.7,
			ja = 7.566
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
				arg_218_0:Play426011053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["6148ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos6148ui_story = var_221_0.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_3 then
				local var_221_4 = (arg_218_1.time_ - var_221_1) / var_221_3
				local var_221_5 = Vector3.New(0.7, -0.985, -6)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos6148ui_story, var_221_5, var_221_4)

				local var_221_6 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_6.x, var_221_6.y, var_221_6.z)

				local var_221_7 = var_221_0.localEulerAngles

				var_221_7.z = 0
				var_221_7.x = 0
				var_221_0.localEulerAngles = var_221_7
			end

			if arg_218_1.time_ >= var_221_1 + var_221_3 and arg_218_1.time_ < var_221_1 + var_221_3 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_221_8 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_8.x, var_221_8.y, var_221_8.z)

				local var_221_9 = var_221_0.localEulerAngles

				var_221_9.z = 0
				var_221_9.x = 0
				var_221_0.localEulerAngles = var_221_9

				local var_221_10 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_10 then
					var_221_10:EnableDynamicBone(true)
				end
			end

			local var_221_11 = arg_218_1.actors_["6148ui_story"]
			local var_221_12 = 0

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect6148ui_story == nil then
				arg_218_1.var_.characterEffect6148ui_story = var_221_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_13 = 0.200000002980232

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_13 and not isNil(var_221_11) then
				local var_221_14 = (arg_218_1.time_ - var_221_12) / var_221_13

				if arg_218_1.var_.characterEffect6148ui_story and not isNil(var_221_11) then
					arg_218_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_12 + var_221_13 and arg_218_1.time_ < var_221_12 + var_221_13 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect6148ui_story then
				arg_218_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_221_15 = 0

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_221_16 = 0

			if var_221_16 < arg_218_1.time_ and arg_218_1.time_ <= var_221_16 + arg_221_0 then
				arg_218_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_221_17 = 0
			local var_221_18 = 0.75

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_19 = arg_218_1:FormatText(StoryNameCfg[1488].name)

				arg_218_1.leftNameTxt_.text = var_221_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_20 = arg_218_1:GetWordFromCfg(426011052)
				local var_221_21 = arg_218_1:FormatText(var_221_20.content)

				arg_218_1.text_.text = var_221_21

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_22 = 30
				local var_221_23 = utf8.len(var_221_21)
				local var_221_24 = var_221_22 <= 0 and var_221_18 or var_221_18 * (var_221_23 / var_221_22)

				if var_221_24 > 0 and var_221_18 < var_221_24 then
					arg_218_1.talkMaxDuration = var_221_24

					if var_221_24 + var_221_17 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_24 + var_221_17
					end
				end

				arg_218_1.text_.text = var_221_21
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011052", "story_v_out_426011.awb") ~= 0 then
					local var_221_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011052", "story_v_out_426011.awb") / 1000

					if var_221_25 + var_221_17 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_25 + var_221_17
					end

					if var_221_20.prefab_name ~= "" and arg_218_1.actors_[var_221_20.prefab_name] ~= nil then
						local var_221_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_20.prefab_name].transform, "story_v_out_426011", "426011052", "story_v_out_426011.awb")

						arg_218_1:RecordAudio("426011052", var_221_26)
						arg_218_1:RecordAudio("426011052", var_221_26)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_426011", "426011052", "story_v_out_426011.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_426011", "426011052", "story_v_out_426011.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_27 = math.max(var_221_18, arg_218_1.talkMaxDuration)

			if var_221_17 <= arg_218_1.time_ and arg_218_1.time_ < var_221_17 + var_221_27 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_17) / var_221_27

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_17 + var_221_27 and arg_218_1.time_ < var_221_17 + var_221_27 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 426011053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play426011054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["6148ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect6148ui_story == nil then
				arg_222_1.var_.characterEffect6148ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect6148ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_222_1.var_.characterEffect6148ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect6148ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_222_1.var_.characterEffect6148ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.525

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_8 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_9 = arg_222_1:GetWordFromCfg(426011053)
				local var_225_10 = arg_222_1:FormatText(var_225_9.content)

				arg_222_1.text_.text = var_225_10

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 21
				local var_225_12 = utf8.len(var_225_10)
				local var_225_13 = var_225_11 <= 0 and var_225_7 or var_225_7 * (var_225_12 / var_225_11)

				if var_225_13 > 0 and var_225_7 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_10
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play426011054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 426011054
		arg_226_1.duration_ = 11.3

		local var_226_0 = {
			zh = 8.133,
			ja = 11.3
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
				arg_226_0:Play426011055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["6148ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos6148ui_story = var_229_0.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_3 then
				local var_229_4 = (arg_226_1.time_ - var_229_1) / var_229_3
				local var_229_5 = Vector3.New(0.7, -0.985, -6)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos6148ui_story, var_229_5, var_229_4)

				local var_229_6 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_6.x, var_229_6.y, var_229_6.z)

				local var_229_7 = var_229_0.localEulerAngles

				var_229_7.z = 0
				var_229_7.x = 0
				var_229_0.localEulerAngles = var_229_7
			end

			if arg_226_1.time_ >= var_229_1 + var_229_3 and arg_226_1.time_ < var_229_1 + var_229_3 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_229_8 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_8.x, var_229_8.y, var_229_8.z)

				local var_229_9 = var_229_0.localEulerAngles

				var_229_9.z = 0
				var_229_9.x = 0
				var_229_0.localEulerAngles = var_229_9

				local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_10 then
					var_229_10:EnableDynamicBone(true)
				end
			end

			local var_229_11 = arg_226_1.actors_["6148ui_story"]
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect6148ui_story == nil then
				arg_226_1.var_.characterEffect6148ui_story = var_229_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_13 = 0.200000002980232

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 and not isNil(var_229_11) then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13

				if arg_226_1.var_.characterEffect6148ui_story and not isNil(var_229_11) then
					arg_226_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect6148ui_story then
				arg_226_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_229_15 = 0

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_229_17 = 0
			local var_229_18 = 0.925

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_19 = arg_226_1:FormatText(StoryNameCfg[1488].name)

				arg_226_1.leftNameTxt_.text = var_229_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_20 = arg_226_1:GetWordFromCfg(426011054)
				local var_229_21 = arg_226_1:FormatText(var_229_20.content)

				arg_226_1.text_.text = var_229_21

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_22 = 37
				local var_229_23 = utf8.len(var_229_21)
				local var_229_24 = var_229_22 <= 0 and var_229_18 or var_229_18 * (var_229_23 / var_229_22)

				if var_229_24 > 0 and var_229_18 < var_229_24 then
					arg_226_1.talkMaxDuration = var_229_24

					if var_229_24 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_24 + var_229_17
					end
				end

				arg_226_1.text_.text = var_229_21
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011054", "story_v_out_426011.awb") ~= 0 then
					local var_229_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011054", "story_v_out_426011.awb") / 1000

					if var_229_25 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_25 + var_229_17
					end

					if var_229_20.prefab_name ~= "" and arg_226_1.actors_[var_229_20.prefab_name] ~= nil then
						local var_229_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_20.prefab_name].transform, "story_v_out_426011", "426011054", "story_v_out_426011.awb")

						arg_226_1:RecordAudio("426011054", var_229_26)
						arg_226_1:RecordAudio("426011054", var_229_26)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_426011", "426011054", "story_v_out_426011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_426011", "426011054", "story_v_out_426011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_27 = math.max(var_229_18, arg_226_1.talkMaxDuration)

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_27 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_17) / var_229_27

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_17 + var_229_27 and arg_226_1.time_ < var_229_17 + var_229_27 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play426011055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 426011055
		arg_230_1.duration_ = 13.93

		local var_230_0 = {
			zh = 8.733,
			ja = 13.933
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
				arg_230_0:Play426011056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 1.125

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[1488].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(426011055)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011055", "story_v_out_426011.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011055", "story_v_out_426011.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_426011", "426011055", "story_v_out_426011.awb")

						arg_230_1:RecordAudio("426011055", var_233_9)
						arg_230_1:RecordAudio("426011055", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_426011", "426011055", "story_v_out_426011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_426011", "426011055", "story_v_out_426011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_10 and arg_230_1.time_ < var_233_0 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play426011056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 426011056
		arg_234_1.duration_ = 5.1

		local var_234_0 = {
			zh = 5.1,
			ja = 2.733
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
				arg_234_0:Play426011057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["6148ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos6148ui_story = var_237_0.localPosition

				local var_237_2 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(false)
				end
			end

			local var_237_3 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_3 then
				local var_237_4 = (arg_234_1.time_ - var_237_1) / var_237_3
				local var_237_5 = Vector3.New(0.7, -0.985, -6)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos6148ui_story, var_237_5, var_237_4)

				local var_237_6 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_6.x, var_237_6.y, var_237_6.z)

				local var_237_7 = var_237_0.localEulerAngles

				var_237_7.z = 0
				var_237_7.x = 0
				var_237_0.localEulerAngles = var_237_7
			end

			if arg_234_1.time_ >= var_237_1 + var_237_3 and arg_234_1.time_ < var_237_1 + var_237_3 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_237_8 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_8.x, var_237_8.y, var_237_8.z)

				local var_237_9 = var_237_0.localEulerAngles

				var_237_9.z = 0
				var_237_9.x = 0
				var_237_0.localEulerAngles = var_237_9

				local var_237_10 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_10 then
					var_237_10:EnableDynamicBone(true)
				end
			end

			local var_237_11 = 0

			if var_237_11 < arg_234_1.time_ and arg_234_1.time_ <= var_237_11 + arg_237_0 then
				arg_234_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_237_12 = 0

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 then
				arg_234_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_237_13 = 0
			local var_237_14 = 0.475

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_15 = arg_234_1:FormatText(StoryNameCfg[1488].name)

				arg_234_1.leftNameTxt_.text = var_237_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_16 = arg_234_1:GetWordFromCfg(426011056)
				local var_237_17 = arg_234_1:FormatText(var_237_16.content)

				arg_234_1.text_.text = var_237_17

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_18 = 19
				local var_237_19 = utf8.len(var_237_17)
				local var_237_20 = var_237_18 <= 0 and var_237_14 or var_237_14 * (var_237_19 / var_237_18)

				if var_237_20 > 0 and var_237_14 < var_237_20 then
					arg_234_1.talkMaxDuration = var_237_20

					if var_237_20 + var_237_13 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_20 + var_237_13
					end
				end

				arg_234_1.text_.text = var_237_17
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011056", "story_v_out_426011.awb") ~= 0 then
					local var_237_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011056", "story_v_out_426011.awb") / 1000

					if var_237_21 + var_237_13 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_21 + var_237_13
					end

					if var_237_16.prefab_name ~= "" and arg_234_1.actors_[var_237_16.prefab_name] ~= nil then
						local var_237_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_16.prefab_name].transform, "story_v_out_426011", "426011056", "story_v_out_426011.awb")

						arg_234_1:RecordAudio("426011056", var_237_22)
						arg_234_1:RecordAudio("426011056", var_237_22)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_426011", "426011056", "story_v_out_426011.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_426011", "426011056", "story_v_out_426011.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_23 = math.max(var_237_14, arg_234_1.talkMaxDuration)

			if var_237_13 <= arg_234_1.time_ and arg_234_1.time_ < var_237_13 + var_237_23 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_13) / var_237_23

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_13 + var_237_23 and arg_234_1.time_ < var_237_13 + var_237_23 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play426011057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 426011057
		arg_238_1.duration_ = 1

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"

			SetActive(arg_238_1.choicesGo_, true)

			for iter_239_0, iter_239_1 in ipairs(arg_238_1.choices_) do
				local var_239_0 = iter_239_0 <= 2

				SetActive(iter_239_1.go, var_239_0)
			end

			arg_238_1.choices_[1].txt.text = arg_238_1:FormatText(StoryChoiceCfg[1601].name)
			arg_238_1.choices_[2].txt.text = arg_238_1:FormatText(StoryChoiceCfg[1602].name)
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play426011058(arg_238_1)
			end

			if arg_240_0 == 2 then
				arg_238_0:Play426011060(arg_238_1)
			end

			arg_238_1:RecordChoiceLog(426011057, 1601, 1602)
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["6148ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect6148ui_story == nil then
				arg_238_1.var_.characterEffect6148ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect6148ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_238_1.var_.characterEffect6148ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect6148ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_238_1.var_.characterEffect6148ui_story.fillRatio = var_241_5
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play426011058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 426011058
		arg_242_1.duration_ = 2

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play426011059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["6148ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos6148ui_story = var_245_0.localPosition

				local var_245_2 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(false)
				end
			end

			local var_245_3 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_3 then
				local var_245_4 = (arg_242_1.time_ - var_245_1) / var_245_3
				local var_245_5 = Vector3.New(0.7, -0.985, -6)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos6148ui_story, var_245_5, var_245_4)

				local var_245_6 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_6.x, var_245_6.y, var_245_6.z)

				local var_245_7 = var_245_0.localEulerAngles

				var_245_7.z = 0
				var_245_7.x = 0
				var_245_0.localEulerAngles = var_245_7
			end

			if arg_242_1.time_ >= var_245_1 + var_245_3 and arg_242_1.time_ < var_245_1 + var_245_3 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_245_8 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_8.x, var_245_8.y, var_245_8.z)

				local var_245_9 = var_245_0.localEulerAngles

				var_245_9.z = 0
				var_245_9.x = 0
				var_245_0.localEulerAngles = var_245_9

				local var_245_10 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_10 then
					var_245_10:EnableDynamicBone(true)
				end
			end

			local var_245_11 = arg_242_1.actors_["6148ui_story"]
			local var_245_12 = 0

			if var_245_12 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect6148ui_story == nil then
				arg_242_1.var_.characterEffect6148ui_story = var_245_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_13 = 0.200000002980232

			if var_245_12 <= arg_242_1.time_ and arg_242_1.time_ < var_245_12 + var_245_13 and not isNil(var_245_11) then
				local var_245_14 = (arg_242_1.time_ - var_245_12) / var_245_13

				if arg_242_1.var_.characterEffect6148ui_story and not isNil(var_245_11) then
					arg_242_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_12 + var_245_13 and arg_242_1.time_ < var_245_12 + var_245_13 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect6148ui_story then
				arg_242_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_245_15 = 0

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_245_17 = 0
			local var_245_18 = 0.075

			if var_245_17 < arg_242_1.time_ and arg_242_1.time_ <= var_245_17 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_19 = arg_242_1:FormatText(StoryNameCfg[1488].name)

				arg_242_1.leftNameTxt_.text = var_245_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_20 = arg_242_1:GetWordFromCfg(426011058)
				local var_245_21 = arg_242_1:FormatText(var_245_20.content)

				arg_242_1.text_.text = var_245_21

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_22 = 3
				local var_245_23 = utf8.len(var_245_21)
				local var_245_24 = var_245_22 <= 0 and var_245_18 or var_245_18 * (var_245_23 / var_245_22)

				if var_245_24 > 0 and var_245_18 < var_245_24 then
					arg_242_1.talkMaxDuration = var_245_24

					if var_245_24 + var_245_17 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_24 + var_245_17
					end
				end

				arg_242_1.text_.text = var_245_21
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011058", "story_v_out_426011.awb") ~= 0 then
					local var_245_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011058", "story_v_out_426011.awb") / 1000

					if var_245_25 + var_245_17 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_17
					end

					if var_245_20.prefab_name ~= "" and arg_242_1.actors_[var_245_20.prefab_name] ~= nil then
						local var_245_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_20.prefab_name].transform, "story_v_out_426011", "426011058", "story_v_out_426011.awb")

						arg_242_1:RecordAudio("426011058", var_245_26)
						arg_242_1:RecordAudio("426011058", var_245_26)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_426011", "426011058", "story_v_out_426011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_426011", "426011058", "story_v_out_426011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_27 = math.max(var_245_18, arg_242_1.talkMaxDuration)

			if var_245_17 <= arg_242_1.time_ and arg_242_1.time_ < var_245_17 + var_245_27 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_17) / var_245_27

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_17 + var_245_27 and arg_242_1.time_ < var_245_17 + var_245_27 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play426011059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 426011059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play426011062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["6148ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect6148ui_story == nil then
				arg_246_1.var_.characterEffect6148ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect6148ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_246_1.var_.characterEffect6148ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect6148ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_246_1.var_.characterEffect6148ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 0.15

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_9 = arg_246_1:GetWordFromCfg(426011059)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 6
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play426011062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 426011062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play426011063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.675

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(426011062)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 27
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
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_8 and arg_250_1.time_ < var_253_0 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play426011063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 426011063
		arg_254_1.duration_ = 8.97

		local var_254_0 = {
			zh = 5.4,
			ja = 8.966
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
				arg_254_0:Play426011064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["6148ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos6148ui_story = var_257_0.localPosition

				local var_257_2 = GameObjectTools.GetOrAddComponent(var_257_0.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(false)
				end
			end

			local var_257_3 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_3 then
				local var_257_4 = (arg_254_1.time_ - var_257_1) / var_257_3
				local var_257_5 = Vector3.New(0.7, -0.985, -6)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos6148ui_story, var_257_5, var_257_4)

				local var_257_6 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_6.x, var_257_6.y, var_257_6.z)

				local var_257_7 = var_257_0.localEulerAngles

				var_257_7.z = 0
				var_257_7.x = 0
				var_257_0.localEulerAngles = var_257_7
			end

			if arg_254_1.time_ >= var_257_1 + var_257_3 and arg_254_1.time_ < var_257_1 + var_257_3 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_257_8 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_8.x, var_257_8.y, var_257_8.z)

				local var_257_9 = var_257_0.localEulerAngles

				var_257_9.z = 0
				var_257_9.x = 0
				var_257_0.localEulerAngles = var_257_9

				local var_257_10 = GameObjectTools.GetOrAddComponent(var_257_0.gameObject, typeof(DynamicBoneHelper))

				if var_257_10 then
					var_257_10:EnableDynamicBone(true)
				end
			end

			local var_257_11 = arg_254_1.actors_["6148ui_story"]
			local var_257_12 = 0

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.characterEffect6148ui_story == nil then
				arg_254_1.var_.characterEffect6148ui_story = var_257_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_13 = 0.200000002980232

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_13 and not isNil(var_257_11) then
				local var_257_14 = (arg_254_1.time_ - var_257_12) / var_257_13

				if arg_254_1.var_.characterEffect6148ui_story and not isNil(var_257_11) then
					arg_254_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_12 + var_257_13 and arg_254_1.time_ < var_257_12 + var_257_13 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.characterEffect6148ui_story then
				arg_254_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_257_15 = 0

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_257_16 = 0
			local var_257_17 = 0.65

			if var_257_16 < arg_254_1.time_ and arg_254_1.time_ <= var_257_16 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_18 = arg_254_1:FormatText(StoryNameCfg[1488].name)

				arg_254_1.leftNameTxt_.text = var_257_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_19 = arg_254_1:GetWordFromCfg(426011063)
				local var_257_20 = arg_254_1:FormatText(var_257_19.content)

				arg_254_1.text_.text = var_257_20

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_21 = 26
				local var_257_22 = utf8.len(var_257_20)
				local var_257_23 = var_257_21 <= 0 and var_257_17 or var_257_17 * (var_257_22 / var_257_21)

				if var_257_23 > 0 and var_257_17 < var_257_23 then
					arg_254_1.talkMaxDuration = var_257_23

					if var_257_23 + var_257_16 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_23 + var_257_16
					end
				end

				arg_254_1.text_.text = var_257_20
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011063", "story_v_out_426011.awb") ~= 0 then
					local var_257_24 = manager.audio:GetVoiceLength("story_v_out_426011", "426011063", "story_v_out_426011.awb") / 1000

					if var_257_24 + var_257_16 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_24 + var_257_16
					end

					if var_257_19.prefab_name ~= "" and arg_254_1.actors_[var_257_19.prefab_name] ~= nil then
						local var_257_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_19.prefab_name].transform, "story_v_out_426011", "426011063", "story_v_out_426011.awb")

						arg_254_1:RecordAudio("426011063", var_257_25)
						arg_254_1:RecordAudio("426011063", var_257_25)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_426011", "426011063", "story_v_out_426011.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_426011", "426011063", "story_v_out_426011.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_26 = math.max(var_257_17, arg_254_1.talkMaxDuration)

			if var_257_16 <= arg_254_1.time_ and arg_254_1.time_ < var_257_16 + var_257_26 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_16) / var_257_26

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_16 + var_257_26 and arg_254_1.time_ < var_257_16 + var_257_26 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play426011064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 426011064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play426011065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["6148ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect6148ui_story == nil then
				arg_258_1.var_.characterEffect6148ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect6148ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_258_1.var_.characterEffect6148ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect6148ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_258_1.var_.characterEffect6148ui_story.fillRatio = var_261_5
			end

			local var_261_6 = 0
			local var_261_7 = 0.575

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_8 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_9 = arg_258_1:GetWordFromCfg(426011064)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 23
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_7 or var_261_7 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_7 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play426011065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 426011065
		arg_262_1.duration_ = 6.23

		local var_262_0 = {
			zh = 3.533,
			ja = 6.233
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
				arg_262_0:Play426011066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["6148ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos6148ui_story = var_265_0.localPosition

				local var_265_2 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(false)
				end
			end

			local var_265_3 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_3 then
				local var_265_4 = (arg_262_1.time_ - var_265_1) / var_265_3
				local var_265_5 = Vector3.New(0.7, -0.985, -6)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos6148ui_story, var_265_5, var_265_4)

				local var_265_6 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_6.x, var_265_6.y, var_265_6.z)

				local var_265_7 = var_265_0.localEulerAngles

				var_265_7.z = 0
				var_265_7.x = 0
				var_265_0.localEulerAngles = var_265_7
			end

			if arg_262_1.time_ >= var_265_1 + var_265_3 and arg_262_1.time_ < var_265_1 + var_265_3 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_265_8 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_8.x, var_265_8.y, var_265_8.z)

				local var_265_9 = var_265_0.localEulerAngles

				var_265_9.z = 0
				var_265_9.x = 0
				var_265_0.localEulerAngles = var_265_9

				local var_265_10 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_10 then
					var_265_10:EnableDynamicBone(true)
				end
			end

			local var_265_11 = arg_262_1.actors_["6148ui_story"]
			local var_265_12 = 0

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 and not isNil(var_265_11) and arg_262_1.var_.characterEffect6148ui_story == nil then
				arg_262_1.var_.characterEffect6148ui_story = var_265_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_13 = 0.200000002980232

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_13 and not isNil(var_265_11) then
				local var_265_14 = (arg_262_1.time_ - var_265_12) / var_265_13

				if arg_262_1.var_.characterEffect6148ui_story and not isNil(var_265_11) then
					arg_262_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_12 + var_265_13 and arg_262_1.time_ < var_265_12 + var_265_13 + arg_265_0 and not isNil(var_265_11) and arg_262_1.var_.characterEffect6148ui_story then
				arg_262_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_265_15 = 0

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_265_16 = 0

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_265_17 = 0
			local var_265_18 = 0.3

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_19 = arg_262_1:FormatText(StoryNameCfg[1488].name)

				arg_262_1.leftNameTxt_.text = var_265_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_20 = arg_262_1:GetWordFromCfg(426011065)
				local var_265_21 = arg_262_1:FormatText(var_265_20.content)

				arg_262_1.text_.text = var_265_21

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_22 = 12
				local var_265_23 = utf8.len(var_265_21)
				local var_265_24 = var_265_22 <= 0 and var_265_18 or var_265_18 * (var_265_23 / var_265_22)

				if var_265_24 > 0 and var_265_18 < var_265_24 then
					arg_262_1.talkMaxDuration = var_265_24

					if var_265_24 + var_265_17 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_24 + var_265_17
					end
				end

				arg_262_1.text_.text = var_265_21
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011065", "story_v_out_426011.awb") ~= 0 then
					local var_265_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011065", "story_v_out_426011.awb") / 1000

					if var_265_25 + var_265_17 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_25 + var_265_17
					end

					if var_265_20.prefab_name ~= "" and arg_262_1.actors_[var_265_20.prefab_name] ~= nil then
						local var_265_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_20.prefab_name].transform, "story_v_out_426011", "426011065", "story_v_out_426011.awb")

						arg_262_1:RecordAudio("426011065", var_265_26)
						arg_262_1:RecordAudio("426011065", var_265_26)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_426011", "426011065", "story_v_out_426011.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_426011", "426011065", "story_v_out_426011.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_27 = math.max(var_265_18, arg_262_1.talkMaxDuration)

			if var_265_17 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_27 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_17) / var_265_27

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_17 + var_265_27 and arg_262_1.time_ < var_265_17 + var_265_27 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play426011066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 426011066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play426011067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["6148ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect6148ui_story == nil then
				arg_266_1.var_.characterEffect6148ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect6148ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_266_1.var_.characterEffect6148ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect6148ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_266_1.var_.characterEffect6148ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0
			local var_269_7 = 0.55

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(426011066)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 22
				local var_269_11 = utf8.len(var_269_9)
				local var_269_12 = var_269_10 <= 0 and var_269_7 or var_269_7 * (var_269_11 / var_269_10)

				if var_269_12 > 0 and var_269_7 < var_269_12 then
					arg_266_1.talkMaxDuration = var_269_12

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_13 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_13 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_13

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_13 and arg_266_1.time_ < var_269_6 + var_269_13 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play426011067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 426011067
		arg_270_1.duration_ = 12.3

		local var_270_0 = {
			zh = 8.833,
			ja = 12.3
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
				arg_270_0:Play426011068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1054ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1054ui_story = var_273_0.localPosition

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_0.gameObject, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end
			end

			local var_273_3 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_3 then
				local var_273_4 = (arg_270_1.time_ - var_273_1) / var_273_3
				local var_273_5 = Vector3.New(-0.7, -0.985, -6)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1054ui_story, var_273_5, var_273_4)

				local var_273_6 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_6.x, var_273_6.y, var_273_6.z)

				local var_273_7 = var_273_0.localEulerAngles

				var_273_7.z = 0
				var_273_7.x = 0
				var_273_0.localEulerAngles = var_273_7
			end

			if arg_270_1.time_ >= var_273_1 + var_273_3 and arg_270_1.time_ < var_273_1 + var_273_3 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_273_8 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_8.x, var_273_8.y, var_273_8.z)

				local var_273_9 = var_273_0.localEulerAngles

				var_273_9.z = 0
				var_273_9.x = 0
				var_273_0.localEulerAngles = var_273_9

				local var_273_10 = GameObjectTools.GetOrAddComponent(var_273_0.gameObject, typeof(DynamicBoneHelper))

				if var_273_10 then
					var_273_10:EnableDynamicBone(true)
				end
			end

			local var_273_11 = arg_270_1.actors_["1054ui_story"]
			local var_273_12 = 0

			if var_273_12 < arg_270_1.time_ and arg_270_1.time_ <= var_273_12 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.characterEffect1054ui_story == nil then
				arg_270_1.var_.characterEffect1054ui_story = var_273_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_13 = 0.200000002980232

			if var_273_12 <= arg_270_1.time_ and arg_270_1.time_ < var_273_12 + var_273_13 and not isNil(var_273_11) then
				local var_273_14 = (arg_270_1.time_ - var_273_12) / var_273_13

				if arg_270_1.var_.characterEffect1054ui_story and not isNil(var_273_11) then
					arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_12 + var_273_13 and arg_270_1.time_ < var_273_12 + var_273_13 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.characterEffect1054ui_story then
				arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_273_15 = 0

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_273_16 = 0

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_273_17 = 0
			local var_273_18 = 0.775

			if var_273_17 < arg_270_1.time_ and arg_270_1.time_ <= var_273_17 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_19 = arg_270_1:FormatText(StoryNameCfg[1487].name)

				arg_270_1.leftNameTxt_.text = var_273_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_20 = arg_270_1:GetWordFromCfg(426011067)
				local var_273_21 = arg_270_1:FormatText(var_273_20.content)

				arg_270_1.text_.text = var_273_21

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_22 = 31
				local var_273_23 = utf8.len(var_273_21)
				local var_273_24 = var_273_22 <= 0 and var_273_18 or var_273_18 * (var_273_23 / var_273_22)

				if var_273_24 > 0 and var_273_18 < var_273_24 then
					arg_270_1.talkMaxDuration = var_273_24

					if var_273_24 + var_273_17 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_24 + var_273_17
					end
				end

				arg_270_1.text_.text = var_273_21
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011067", "story_v_out_426011.awb") ~= 0 then
					local var_273_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011067", "story_v_out_426011.awb") / 1000

					if var_273_25 + var_273_17 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_25 + var_273_17
					end

					if var_273_20.prefab_name ~= "" and arg_270_1.actors_[var_273_20.prefab_name] ~= nil then
						local var_273_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_20.prefab_name].transform, "story_v_out_426011", "426011067", "story_v_out_426011.awb")

						arg_270_1:RecordAudio("426011067", var_273_26)
						arg_270_1:RecordAudio("426011067", var_273_26)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_426011", "426011067", "story_v_out_426011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_426011", "426011067", "story_v_out_426011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_27 = math.max(var_273_18, arg_270_1.talkMaxDuration)

			if var_273_17 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_27 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_17) / var_273_27

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_17 + var_273_27 and arg_270_1.time_ < var_273_17 + var_273_27 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426011068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 426011068
		arg_274_1.duration_ = 9.67

		local var_274_0 = {
			zh = 8.8,
			ja = 9.666
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play426011069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1054ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1054ui_story = var_277_0.localPosition

				local var_277_2 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(false)
				end
			end

			local var_277_3 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_3 then
				local var_277_4 = (arg_274_1.time_ - var_277_1) / var_277_3
				local var_277_5 = Vector3.New(-0.7, -0.985, -6)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1054ui_story, var_277_5, var_277_4)

				local var_277_6 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_6.x, var_277_6.y, var_277_6.z)

				local var_277_7 = var_277_0.localEulerAngles

				var_277_7.z = 0
				var_277_7.x = 0
				var_277_0.localEulerAngles = var_277_7
			end

			if arg_274_1.time_ >= var_277_1 + var_277_3 and arg_274_1.time_ < var_277_1 + var_277_3 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_277_8 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_8.x, var_277_8.y, var_277_8.z)

				local var_277_9 = var_277_0.localEulerAngles

				var_277_9.z = 0
				var_277_9.x = 0
				var_277_0.localEulerAngles = var_277_9

				local var_277_10 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_10 then
					var_277_10:EnableDynamicBone(true)
				end
			end

			local var_277_11 = 0

			if var_277_11 < arg_274_1.time_ and arg_274_1.time_ <= var_277_11 + arg_277_0 then
				arg_274_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action454")
			end

			local var_277_12 = 0

			if var_277_12 < arg_274_1.time_ and arg_274_1.time_ <= var_277_12 + arg_277_0 then
				arg_274_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_277_13 = 0
			local var_277_14 = 0.8

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_15 = arg_274_1:FormatText(StoryNameCfg[1487].name)

				arg_274_1.leftNameTxt_.text = var_277_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_16 = arg_274_1:GetWordFromCfg(426011068)
				local var_277_17 = arg_274_1:FormatText(var_277_16.content)

				arg_274_1.text_.text = var_277_17

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_18 = 32
				local var_277_19 = utf8.len(var_277_17)
				local var_277_20 = var_277_18 <= 0 and var_277_14 or var_277_14 * (var_277_19 / var_277_18)

				if var_277_20 > 0 and var_277_14 < var_277_20 then
					arg_274_1.talkMaxDuration = var_277_20

					if var_277_20 + var_277_13 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_20 + var_277_13
					end
				end

				arg_274_1.text_.text = var_277_17
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011068", "story_v_out_426011.awb") ~= 0 then
					local var_277_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011068", "story_v_out_426011.awb") / 1000

					if var_277_21 + var_277_13 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_21 + var_277_13
					end

					if var_277_16.prefab_name ~= "" and arg_274_1.actors_[var_277_16.prefab_name] ~= nil then
						local var_277_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_16.prefab_name].transform, "story_v_out_426011", "426011068", "story_v_out_426011.awb")

						arg_274_1:RecordAudio("426011068", var_277_22)
						arg_274_1:RecordAudio("426011068", var_277_22)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_426011", "426011068", "story_v_out_426011.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_426011", "426011068", "story_v_out_426011.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_23 = math.max(var_277_14, arg_274_1.talkMaxDuration)

			if var_277_13 <= arg_274_1.time_ and arg_274_1.time_ < var_277_13 + var_277_23 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_13) / var_277_23

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_13 + var_277_23 and arg_274_1.time_ < var_277_13 + var_277_23 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play426011069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 426011069
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play426011070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1054ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1054ui_story == nil then
				arg_278_1.var_.characterEffect1054ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1054ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1054ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1054ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1054ui_story.fillRatio = var_281_5
			end

			local var_281_6 = 0

			if var_281_6 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_281_7 = 0
			local var_281_8 = 0.675

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_9 = arg_278_1:GetWordFromCfg(426011069)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 27
				local var_281_12 = utf8.len(var_281_10)
				local var_281_13 = var_281_11 <= 0 and var_281_8 or var_281_8 * (var_281_12 / var_281_11)

				if var_281_13 > 0 and var_281_8 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_7 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_7
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_14 = math.max(var_281_8, arg_278_1.talkMaxDuration)

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_14 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_7) / var_281_14

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_7 + var_281_14 and arg_278_1.time_ < var_281_7 + var_281_14 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play426011070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 426011070
		arg_282_1.duration_ = 7

		local var_282_0 = {
			zh = 6.266,
			ja = 7
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play426011071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["6148ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos6148ui_story = var_285_0.localPosition

				local var_285_2 = GameObjectTools.GetOrAddComponent(var_285_0.gameObject, typeof(DynamicBoneHelper))

				if var_285_2 then
					var_285_2:EnableDynamicBone(false)
				end
			end

			local var_285_3 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_3 then
				local var_285_4 = (arg_282_1.time_ - var_285_1) / var_285_3
				local var_285_5 = Vector3.New(0.7, -0.985, -6)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos6148ui_story, var_285_5, var_285_4)

				local var_285_6 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_6.x, var_285_6.y, var_285_6.z)

				local var_285_7 = var_285_0.localEulerAngles

				var_285_7.z = 0
				var_285_7.x = 0
				var_285_0.localEulerAngles = var_285_7
			end

			if arg_282_1.time_ >= var_285_1 + var_285_3 and arg_282_1.time_ < var_285_1 + var_285_3 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_285_8 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_8.x, var_285_8.y, var_285_8.z)

				local var_285_9 = var_285_0.localEulerAngles

				var_285_9.z = 0
				var_285_9.x = 0
				var_285_0.localEulerAngles = var_285_9

				local var_285_10 = GameObjectTools.GetOrAddComponent(var_285_0.gameObject, typeof(DynamicBoneHelper))

				if var_285_10 then
					var_285_10:EnableDynamicBone(true)
				end
			end

			local var_285_11 = arg_282_1.actors_["6148ui_story"]
			local var_285_12 = 0

			if var_285_12 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 and not isNil(var_285_11) and arg_282_1.var_.characterEffect6148ui_story == nil then
				arg_282_1.var_.characterEffect6148ui_story = var_285_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_13 = 0.200000002980232

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_13 and not isNil(var_285_11) then
				local var_285_14 = (arg_282_1.time_ - var_285_12) / var_285_13

				if arg_282_1.var_.characterEffect6148ui_story and not isNil(var_285_11) then
					arg_282_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_12 + var_285_13 and arg_282_1.time_ < var_285_12 + var_285_13 + arg_285_0 and not isNil(var_285_11) and arg_282_1.var_.characterEffect6148ui_story then
				arg_282_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_285_15 = 0

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_285_16 = 0

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_285_17 = 0
			local var_285_18 = 0.775

			if var_285_17 < arg_282_1.time_ and arg_282_1.time_ <= var_285_17 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_19 = arg_282_1:FormatText(StoryNameCfg[1488].name)

				arg_282_1.leftNameTxt_.text = var_285_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_20 = arg_282_1:GetWordFromCfg(426011070)
				local var_285_21 = arg_282_1:FormatText(var_285_20.content)

				arg_282_1.text_.text = var_285_21

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_22 = 31
				local var_285_23 = utf8.len(var_285_21)
				local var_285_24 = var_285_22 <= 0 and var_285_18 or var_285_18 * (var_285_23 / var_285_22)

				if var_285_24 > 0 and var_285_18 < var_285_24 then
					arg_282_1.talkMaxDuration = var_285_24

					if var_285_24 + var_285_17 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_24 + var_285_17
					end
				end

				arg_282_1.text_.text = var_285_21
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011070", "story_v_out_426011.awb") ~= 0 then
					local var_285_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011070", "story_v_out_426011.awb") / 1000

					if var_285_25 + var_285_17 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_25 + var_285_17
					end

					if var_285_20.prefab_name ~= "" and arg_282_1.actors_[var_285_20.prefab_name] ~= nil then
						local var_285_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_20.prefab_name].transform, "story_v_out_426011", "426011070", "story_v_out_426011.awb")

						arg_282_1:RecordAudio("426011070", var_285_26)
						arg_282_1:RecordAudio("426011070", var_285_26)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_426011", "426011070", "story_v_out_426011.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_426011", "426011070", "story_v_out_426011.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_27 = math.max(var_285_18, arg_282_1.talkMaxDuration)

			if var_285_17 <= arg_282_1.time_ and arg_282_1.time_ < var_285_17 + var_285_27 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_17) / var_285_27

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_17 + var_285_27 and arg_282_1.time_ < var_285_17 + var_285_27 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 426011071
		arg_286_1.duration_ = 8.2

		local var_286_0 = {
			zh = 8.2,
			ja = 7.833
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
				arg_286_0:Play426011072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.975

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[1488].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(426011071)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 39
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011071", "story_v_out_426011.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011071", "story_v_out_426011.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_426011", "426011071", "story_v_out_426011.awb")

						arg_286_1:RecordAudio("426011071", var_289_9)
						arg_286_1:RecordAudio("426011071", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_426011", "426011071", "story_v_out_426011.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_426011", "426011071", "story_v_out_426011.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play426011072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 426011072
		arg_290_1.duration_ = 13.17

		local var_290_0 = {
			zh = 8.833,
			ja = 13.166
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play426011073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["6148ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos6148ui_story = var_293_0.localPosition

				local var_293_2 = GameObjectTools.GetOrAddComponent(var_293_0.gameObject, typeof(DynamicBoneHelper))

				if var_293_2 then
					var_293_2:EnableDynamicBone(false)
				end
			end

			local var_293_3 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_3 then
				local var_293_4 = (arg_290_1.time_ - var_293_1) / var_293_3
				local var_293_5 = Vector3.New(0.7, -0.985, -6)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos6148ui_story, var_293_5, var_293_4)

				local var_293_6 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_6.x, var_293_6.y, var_293_6.z)

				local var_293_7 = var_293_0.localEulerAngles

				var_293_7.z = 0
				var_293_7.x = 0
				var_293_0.localEulerAngles = var_293_7
			end

			if arg_290_1.time_ >= var_293_1 + var_293_3 and arg_290_1.time_ < var_293_1 + var_293_3 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_293_8 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_8.x, var_293_8.y, var_293_8.z)

				local var_293_9 = var_293_0.localEulerAngles

				var_293_9.z = 0
				var_293_9.x = 0
				var_293_0.localEulerAngles = var_293_9

				local var_293_10 = GameObjectTools.GetOrAddComponent(var_293_0.gameObject, typeof(DynamicBoneHelper))

				if var_293_10 then
					var_293_10:EnableDynamicBone(true)
				end
			end

			local var_293_11 = 0

			if var_293_11 < arg_290_1.time_ and arg_290_1.time_ <= var_293_11 + arg_293_0 then
				arg_290_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_293_12 = 0

			if var_293_12 < arg_290_1.time_ and arg_290_1.time_ <= var_293_12 + arg_293_0 then
				arg_290_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_293_13 = 0
			local var_293_14 = 0.925

			if var_293_13 < arg_290_1.time_ and arg_290_1.time_ <= var_293_13 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_15 = arg_290_1:FormatText(StoryNameCfg[1488].name)

				arg_290_1.leftNameTxt_.text = var_293_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_16 = arg_290_1:GetWordFromCfg(426011072)
				local var_293_17 = arg_290_1:FormatText(var_293_16.content)

				arg_290_1.text_.text = var_293_17

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_18 = 37
				local var_293_19 = utf8.len(var_293_17)
				local var_293_20 = var_293_18 <= 0 and var_293_14 or var_293_14 * (var_293_19 / var_293_18)

				if var_293_20 > 0 and var_293_14 < var_293_20 then
					arg_290_1.talkMaxDuration = var_293_20

					if var_293_20 + var_293_13 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_20 + var_293_13
					end
				end

				arg_290_1.text_.text = var_293_17
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011072", "story_v_out_426011.awb") ~= 0 then
					local var_293_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011072", "story_v_out_426011.awb") / 1000

					if var_293_21 + var_293_13 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_21 + var_293_13
					end

					if var_293_16.prefab_name ~= "" and arg_290_1.actors_[var_293_16.prefab_name] ~= nil then
						local var_293_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_16.prefab_name].transform, "story_v_out_426011", "426011072", "story_v_out_426011.awb")

						arg_290_1:RecordAudio("426011072", var_293_22)
						arg_290_1:RecordAudio("426011072", var_293_22)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_426011", "426011072", "story_v_out_426011.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_426011", "426011072", "story_v_out_426011.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_23 = math.max(var_293_14, arg_290_1.talkMaxDuration)

			if var_293_13 <= arg_290_1.time_ and arg_290_1.time_ < var_293_13 + var_293_23 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_13) / var_293_23

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_13 + var_293_23 and arg_290_1.time_ < var_293_13 + var_293_23 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play426011073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 426011073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play426011074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["6148ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect6148ui_story == nil then
				arg_294_1.var_.characterEffect6148ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect6148ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_294_1.var_.characterEffect6148ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect6148ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_294_1.var_.characterEffect6148ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 0.45

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(426011073)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 18
				local var_297_11 = utf8.len(var_297_9)
				local var_297_12 = var_297_10 <= 0 and var_297_7 or var_297_7 * (var_297_11 / var_297_10)

				if var_297_12 > 0 and var_297_7 < var_297_12 then
					arg_294_1.talkMaxDuration = var_297_12

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_13 and arg_294_1.time_ < var_297_6 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play426011074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 426011074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play426011075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 1.125

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(426011074)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 45
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play426011075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426011075
		arg_302_1.duration_ = 6

		local var_302_0 = {
			zh = 3.566,
			ja = 6
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play426011076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1054ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1054ui_story == nil then
				arg_302_1.var_.characterEffect1054ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1054ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1054ui_story then
				arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_305_4 = 0

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_305_5 = 0
			local var_305_6 = 0.3

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_7 = arg_302_1:FormatText(StoryNameCfg[1487].name)

				arg_302_1.leftNameTxt_.text = var_305_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(426011075)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 12
				local var_305_11 = utf8.len(var_305_9)
				local var_305_12 = var_305_10 <= 0 and var_305_6 or var_305_6 * (var_305_11 / var_305_10)

				if var_305_12 > 0 and var_305_6 < var_305_12 then
					arg_302_1.talkMaxDuration = var_305_12

					if var_305_12 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011075", "story_v_out_426011.awb") ~= 0 then
					local var_305_13 = manager.audio:GetVoiceLength("story_v_out_426011", "426011075", "story_v_out_426011.awb") / 1000

					if var_305_13 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_5
					end

					if var_305_8.prefab_name ~= "" and arg_302_1.actors_[var_305_8.prefab_name] ~= nil then
						local var_305_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_8.prefab_name].transform, "story_v_out_426011", "426011075", "story_v_out_426011.awb")

						arg_302_1:RecordAudio("426011075", var_305_14)
						arg_302_1:RecordAudio("426011075", var_305_14)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_426011", "426011075", "story_v_out_426011.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_426011", "426011075", "story_v_out_426011.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_15 = math.max(var_305_6, arg_302_1.talkMaxDuration)

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_15 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_5) / var_305_15

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_5 + var_305_15 and arg_302_1.time_ < var_305_5 + var_305_15 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play426011076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426011076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play426011077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1054ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1054ui_story == nil then
				arg_306_1.var_.characterEffect1054ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1054ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1054ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1054ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1054ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.4

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_9 = arg_306_1:GetWordFromCfg(426011076)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 16
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play426011077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426011077
		arg_310_1.duration_ = 4.53

		local var_310_0 = {
			zh = 2.666,
			ja = 4.533
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play426011078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["6148ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos6148ui_story = var_313_0.localPosition

				local var_313_2 = GameObjectTools.GetOrAddComponent(var_313_0.gameObject, typeof(DynamicBoneHelper))

				if var_313_2 then
					var_313_2:EnableDynamicBone(false)
				end
			end

			local var_313_3 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_3 then
				local var_313_4 = (arg_310_1.time_ - var_313_1) / var_313_3
				local var_313_5 = Vector3.New(0.7, -0.985, -6)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos6148ui_story, var_313_5, var_313_4)

				local var_313_6 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_6.x, var_313_6.y, var_313_6.z)

				local var_313_7 = var_313_0.localEulerAngles

				var_313_7.z = 0
				var_313_7.x = 0
				var_313_0.localEulerAngles = var_313_7
			end

			if arg_310_1.time_ >= var_313_1 + var_313_3 and arg_310_1.time_ < var_313_1 + var_313_3 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_313_8 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_8.x, var_313_8.y, var_313_8.z)

				local var_313_9 = var_313_0.localEulerAngles

				var_313_9.z = 0
				var_313_9.x = 0
				var_313_0.localEulerAngles = var_313_9

				local var_313_10 = GameObjectTools.GetOrAddComponent(var_313_0.gameObject, typeof(DynamicBoneHelper))

				if var_313_10 then
					var_313_10:EnableDynamicBone(true)
				end
			end

			local var_313_11 = arg_310_1.actors_["6148ui_story"]
			local var_313_12 = 0

			if var_313_12 < arg_310_1.time_ and arg_310_1.time_ <= var_313_12 + arg_313_0 and not isNil(var_313_11) and arg_310_1.var_.characterEffect6148ui_story == nil then
				arg_310_1.var_.characterEffect6148ui_story = var_313_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_13 = 0.200000002980232

			if var_313_12 <= arg_310_1.time_ and arg_310_1.time_ < var_313_12 + var_313_13 and not isNil(var_313_11) then
				local var_313_14 = (arg_310_1.time_ - var_313_12) / var_313_13

				if arg_310_1.var_.characterEffect6148ui_story and not isNil(var_313_11) then
					arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_12 + var_313_13 and arg_310_1.time_ < var_313_12 + var_313_13 + arg_313_0 and not isNil(var_313_11) and arg_310_1.var_.characterEffect6148ui_story then
				arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_313_15 = 0

			if var_313_15 < arg_310_1.time_ and arg_310_1.time_ <= var_313_15 + arg_313_0 then
				arg_310_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_313_16 = 0

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_313_17 = 0
			local var_313_18 = 0.375

			if var_313_17 < arg_310_1.time_ and arg_310_1.time_ <= var_313_17 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_19 = arg_310_1:FormatText(StoryNameCfg[1488].name)

				arg_310_1.leftNameTxt_.text = var_313_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_20 = arg_310_1:GetWordFromCfg(426011077)
				local var_313_21 = arg_310_1:FormatText(var_313_20.content)

				arg_310_1.text_.text = var_313_21

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_22 = 15
				local var_313_23 = utf8.len(var_313_21)
				local var_313_24 = var_313_22 <= 0 and var_313_18 or var_313_18 * (var_313_23 / var_313_22)

				if var_313_24 > 0 and var_313_18 < var_313_24 then
					arg_310_1.talkMaxDuration = var_313_24

					if var_313_24 + var_313_17 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_24 + var_313_17
					end
				end

				arg_310_1.text_.text = var_313_21
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011077", "story_v_out_426011.awb") ~= 0 then
					local var_313_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011077", "story_v_out_426011.awb") / 1000

					if var_313_25 + var_313_17 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_25 + var_313_17
					end

					if var_313_20.prefab_name ~= "" and arg_310_1.actors_[var_313_20.prefab_name] ~= nil then
						local var_313_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_20.prefab_name].transform, "story_v_out_426011", "426011077", "story_v_out_426011.awb")

						arg_310_1:RecordAudio("426011077", var_313_26)
						arg_310_1:RecordAudio("426011077", var_313_26)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_426011", "426011077", "story_v_out_426011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_426011", "426011077", "story_v_out_426011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_27 = math.max(var_313_18, arg_310_1.talkMaxDuration)

			if var_313_17 <= arg_310_1.time_ and arg_310_1.time_ < var_313_17 + var_313_27 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_17) / var_313_27

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_17 + var_313_27 and arg_310_1.time_ < var_313_17 + var_313_27 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play426011078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426011078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426011079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["6148ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect6148ui_story == nil then
				arg_314_1.var_.characterEffect6148ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect6148ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_314_1.var_.characterEffect6148ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect6148ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_314_1.var_.characterEffect6148ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0.133333333333333
			local var_317_7 = 1

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				local var_317_8 = "play"
				local var_317_9 = "effect"

				arg_314_1:AudioAction(var_317_8, var_317_9, "se_story_150", "se_story_150_sword", "")
			end

			local var_317_10 = 0
			local var_317_11 = 0.775

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_12 = arg_314_1:GetWordFromCfg(426011078)
				local var_317_13 = arg_314_1:FormatText(var_317_12.content)

				arg_314_1.text_.text = var_317_13

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_14 = 31
				local var_317_15 = utf8.len(var_317_13)
				local var_317_16 = var_317_14 <= 0 and var_317_11 or var_317_11 * (var_317_15 / var_317_14)

				if var_317_16 > 0 and var_317_11 < var_317_16 then
					arg_314_1.talkMaxDuration = var_317_16

					if var_317_16 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_16 + var_317_10
					end
				end

				arg_314_1.text_.text = var_317_13
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_17 = math.max(var_317_11, arg_314_1.talkMaxDuration)

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_17 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_10) / var_317_17

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_10 + var_317_17 and arg_314_1.time_ < var_317_10 + var_317_17 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play426011079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426011079
		arg_318_1.duration_ = 8.17

		local var_318_0 = {
			zh = 5.366,
			ja = 8.166
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play426011080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["6148ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos6148ui_story = var_321_0.localPosition

				local var_321_2 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_2 then
					var_321_2:EnableDynamicBone(false)
				end
			end

			local var_321_3 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_3 then
				local var_321_4 = (arg_318_1.time_ - var_321_1) / var_321_3
				local var_321_5 = Vector3.New(0.7, -0.985, -6)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos6148ui_story, var_321_5, var_321_4)

				local var_321_6 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_6.x, var_321_6.y, var_321_6.z)

				local var_321_7 = var_321_0.localEulerAngles

				var_321_7.z = 0
				var_321_7.x = 0
				var_321_0.localEulerAngles = var_321_7
			end

			if arg_318_1.time_ >= var_321_1 + var_321_3 and arg_318_1.time_ < var_321_1 + var_321_3 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_321_8 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_8.x, var_321_8.y, var_321_8.z)

				local var_321_9 = var_321_0.localEulerAngles

				var_321_9.z = 0
				var_321_9.x = 0
				var_321_0.localEulerAngles = var_321_9

				local var_321_10 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_10 then
					var_321_10:EnableDynamicBone(true)
				end
			end

			local var_321_11 = arg_318_1.actors_["6148ui_story"]
			local var_321_12 = 0

			if var_321_12 < arg_318_1.time_ and arg_318_1.time_ <= var_321_12 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect6148ui_story == nil then
				arg_318_1.var_.characterEffect6148ui_story = var_321_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_13 = 0.200000002980232

			if var_321_12 <= arg_318_1.time_ and arg_318_1.time_ < var_321_12 + var_321_13 and not isNil(var_321_11) then
				local var_321_14 = (arg_318_1.time_ - var_321_12) / var_321_13

				if arg_318_1.var_.characterEffect6148ui_story and not isNil(var_321_11) then
					arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_12 + var_321_13 and arg_318_1.time_ < var_321_12 + var_321_13 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect6148ui_story then
				arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_321_15 = 0

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_321_16 = 0
			local var_321_17 = 0.65

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_18 = arg_318_1:FormatText(StoryNameCfg[1488].name)

				arg_318_1.leftNameTxt_.text = var_321_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_19 = arg_318_1:GetWordFromCfg(426011079)
				local var_321_20 = arg_318_1:FormatText(var_321_19.content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_21 = 26
				local var_321_22 = utf8.len(var_321_20)
				local var_321_23 = var_321_21 <= 0 and var_321_17 or var_321_17 * (var_321_22 / var_321_21)

				if var_321_23 > 0 and var_321_17 < var_321_23 then
					arg_318_1.talkMaxDuration = var_321_23

					if var_321_23 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_16
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011079", "story_v_out_426011.awb") ~= 0 then
					local var_321_24 = manager.audio:GetVoiceLength("story_v_out_426011", "426011079", "story_v_out_426011.awb") / 1000

					if var_321_24 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_16
					end

					if var_321_19.prefab_name ~= "" and arg_318_1.actors_[var_321_19.prefab_name] ~= nil then
						local var_321_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_19.prefab_name].transform, "story_v_out_426011", "426011079", "story_v_out_426011.awb")

						arg_318_1:RecordAudio("426011079", var_321_25)
						arg_318_1:RecordAudio("426011079", var_321_25)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_426011", "426011079", "story_v_out_426011.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_426011", "426011079", "story_v_out_426011.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_26 = math.max(var_321_17, arg_318_1.talkMaxDuration)

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_26 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_16) / var_321_26

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_16 + var_321_26 and arg_318_1.time_ < var_321_16 + var_321_26 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426011080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 426011080
		arg_322_1.duration_ = 11.8

		local var_322_0 = {
			zh = 9,
			ja = 11.8
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play426011081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["6148ui_story"].transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.moveOldPos6148ui_story = var_325_0.localPosition

				local var_325_2 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(false)
				end
			end

			local var_325_3 = 0.001

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_3 then
				local var_325_4 = (arg_322_1.time_ - var_325_1) / var_325_3
				local var_325_5 = Vector3.New(0.7, -0.985, -6)

				var_325_0.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos6148ui_story, var_325_5, var_325_4)

				local var_325_6 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_6.x, var_325_6.y, var_325_6.z)

				local var_325_7 = var_325_0.localEulerAngles

				var_325_7.z = 0
				var_325_7.x = 0
				var_325_0.localEulerAngles = var_325_7
			end

			if arg_322_1.time_ >= var_325_1 + var_325_3 and arg_322_1.time_ < var_325_1 + var_325_3 + arg_325_0 then
				var_325_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_325_8 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_8.x, var_325_8.y, var_325_8.z)

				local var_325_9 = var_325_0.localEulerAngles

				var_325_9.z = 0
				var_325_9.x = 0
				var_325_0.localEulerAngles = var_325_9

				local var_325_10 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_10 then
					var_325_10:EnableDynamicBone(true)
				end
			end

			local var_325_11 = 0

			if var_325_11 < arg_322_1.time_ and arg_322_1.time_ <= var_325_11 + arg_325_0 then
				arg_322_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			local var_325_12 = 0

			if var_325_12 < arg_322_1.time_ and arg_322_1.time_ <= var_325_12 + arg_325_0 then
				arg_322_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_325_13 = 0
			local var_325_14 = 1.15

			if var_325_13 < arg_322_1.time_ and arg_322_1.time_ <= var_325_13 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_15 = arg_322_1:FormatText(StoryNameCfg[1488].name)

				arg_322_1.leftNameTxt_.text = var_325_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_16 = arg_322_1:GetWordFromCfg(426011080)
				local var_325_17 = arg_322_1:FormatText(var_325_16.content)

				arg_322_1.text_.text = var_325_17

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_18 = 46
				local var_325_19 = utf8.len(var_325_17)
				local var_325_20 = var_325_18 <= 0 and var_325_14 or var_325_14 * (var_325_19 / var_325_18)

				if var_325_20 > 0 and var_325_14 < var_325_20 then
					arg_322_1.talkMaxDuration = var_325_20

					if var_325_20 + var_325_13 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_20 + var_325_13
					end
				end

				arg_322_1.text_.text = var_325_17
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011080", "story_v_out_426011.awb") ~= 0 then
					local var_325_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011080", "story_v_out_426011.awb") / 1000

					if var_325_21 + var_325_13 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_21 + var_325_13
					end

					if var_325_16.prefab_name ~= "" and arg_322_1.actors_[var_325_16.prefab_name] ~= nil then
						local var_325_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_16.prefab_name].transform, "story_v_out_426011", "426011080", "story_v_out_426011.awb")

						arg_322_1:RecordAudio("426011080", var_325_22)
						arg_322_1:RecordAudio("426011080", var_325_22)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_426011", "426011080", "story_v_out_426011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_426011", "426011080", "story_v_out_426011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_23 = math.max(var_325_14, arg_322_1.talkMaxDuration)

			if var_325_13 <= arg_322_1.time_ and arg_322_1.time_ < var_325_13 + var_325_23 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_13) / var_325_23

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_13 + var_325_23 and arg_322_1.time_ < var_325_13 + var_325_23 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play426011081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 426011081
		arg_326_1.duration_ = 10.73

		local var_326_0 = {
			zh = 7.666,
			ja = 10.733
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play426011082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1054ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos1054ui_story = var_329_0.localPosition

				local var_329_2 = GameObjectTools.GetOrAddComponent(var_329_0.gameObject, typeof(DynamicBoneHelper))

				if var_329_2 then
					var_329_2:EnableDynamicBone(false)
				end
			end

			local var_329_3 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_3 then
				local var_329_4 = (arg_326_1.time_ - var_329_1) / var_329_3
				local var_329_5 = Vector3.New(-0.7, -0.985, -6)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1054ui_story, var_329_5, var_329_4)

				local var_329_6 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_6.x, var_329_6.y, var_329_6.z)

				local var_329_7 = var_329_0.localEulerAngles

				var_329_7.z = 0
				var_329_7.x = 0
				var_329_0.localEulerAngles = var_329_7
			end

			if arg_326_1.time_ >= var_329_1 + var_329_3 and arg_326_1.time_ < var_329_1 + var_329_3 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_329_8 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_8.x, var_329_8.y, var_329_8.z)

				local var_329_9 = var_329_0.localEulerAngles

				var_329_9.z = 0
				var_329_9.x = 0
				var_329_0.localEulerAngles = var_329_9

				local var_329_10 = GameObjectTools.GetOrAddComponent(var_329_0.gameObject, typeof(DynamicBoneHelper))

				if var_329_10 then
					var_329_10:EnableDynamicBone(true)
				end
			end

			local var_329_11 = arg_326_1.actors_["1054ui_story"]
			local var_329_12 = 0

			if var_329_12 < arg_326_1.time_ and arg_326_1.time_ <= var_329_12 + arg_329_0 and not isNil(var_329_11) and arg_326_1.var_.characterEffect1054ui_story == nil then
				arg_326_1.var_.characterEffect1054ui_story = var_329_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_13 = 0.200000002980232

			if var_329_12 <= arg_326_1.time_ and arg_326_1.time_ < var_329_12 + var_329_13 and not isNil(var_329_11) then
				local var_329_14 = (arg_326_1.time_ - var_329_12) / var_329_13

				if arg_326_1.var_.characterEffect1054ui_story and not isNil(var_329_11) then
					arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_12 + var_329_13 and arg_326_1.time_ < var_329_12 + var_329_13 + arg_329_0 and not isNil(var_329_11) and arg_326_1.var_.characterEffect1054ui_story then
				arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_329_15 = arg_326_1.actors_["6148ui_story"]
			local var_329_16 = 0

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 and not isNil(var_329_15) and arg_326_1.var_.characterEffect6148ui_story == nil then
				arg_326_1.var_.characterEffect6148ui_story = var_329_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_17 = 0.200000002980232

			if var_329_16 <= arg_326_1.time_ and arg_326_1.time_ < var_329_16 + var_329_17 and not isNil(var_329_15) then
				local var_329_18 = (arg_326_1.time_ - var_329_16) / var_329_17

				if arg_326_1.var_.characterEffect6148ui_story and not isNil(var_329_15) then
					local var_329_19 = Mathf.Lerp(0, 0.5, var_329_18)

					arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_326_1.var_.characterEffect6148ui_story.fillRatio = var_329_19
				end
			end

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 and not isNil(var_329_15) and arg_326_1.var_.characterEffect6148ui_story then
				local var_329_20 = 0.5

				arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_326_1.var_.characterEffect6148ui_story.fillRatio = var_329_20
			end

			local var_329_21 = 0

			if var_329_21 < arg_326_1.time_ and arg_326_1.time_ <= var_329_21 + arg_329_0 then
				arg_326_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_329_22 = 0

			if var_329_22 < arg_326_1.time_ and arg_326_1.time_ <= var_329_22 + arg_329_0 then
				arg_326_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_329_23 = 0
			local var_329_24 = 0.725

			if var_329_23 < arg_326_1.time_ and arg_326_1.time_ <= var_329_23 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_25 = arg_326_1:FormatText(StoryNameCfg[1487].name)

				arg_326_1.leftNameTxt_.text = var_329_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_26 = arg_326_1:GetWordFromCfg(426011081)
				local var_329_27 = arg_326_1:FormatText(var_329_26.content)

				arg_326_1.text_.text = var_329_27

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_28 = 29
				local var_329_29 = utf8.len(var_329_27)
				local var_329_30 = var_329_28 <= 0 and var_329_24 or var_329_24 * (var_329_29 / var_329_28)

				if var_329_30 > 0 and var_329_24 < var_329_30 then
					arg_326_1.talkMaxDuration = var_329_30

					if var_329_30 + var_329_23 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_30 + var_329_23
					end
				end

				arg_326_1.text_.text = var_329_27
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011081", "story_v_out_426011.awb") ~= 0 then
					local var_329_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011081", "story_v_out_426011.awb") / 1000

					if var_329_31 + var_329_23 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_31 + var_329_23
					end

					if var_329_26.prefab_name ~= "" and arg_326_1.actors_[var_329_26.prefab_name] ~= nil then
						local var_329_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_26.prefab_name].transform, "story_v_out_426011", "426011081", "story_v_out_426011.awb")

						arg_326_1:RecordAudio("426011081", var_329_32)
						arg_326_1:RecordAudio("426011081", var_329_32)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_426011", "426011081", "story_v_out_426011.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_426011", "426011081", "story_v_out_426011.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_33 = math.max(var_329_24, arg_326_1.talkMaxDuration)

			if var_329_23 <= arg_326_1.time_ and arg_326_1.time_ < var_329_23 + var_329_33 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_23) / var_329_33

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_23 + var_329_33 and arg_326_1.time_ < var_329_23 + var_329_33 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play426011082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 426011082
		arg_330_1.duration_ = 12.83

		local var_330_0 = {
			zh = 10.333,
			ja = 12.833
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
				arg_330_0:Play426011083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["6148ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect6148ui_story == nil then
				arg_330_1.var_.characterEffect6148ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect6148ui_story and not isNil(var_333_0) then
					arg_330_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect6148ui_story then
				arg_330_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_333_4 = arg_330_1.actors_["1054ui_story"]
			local var_333_5 = 0

			if var_333_5 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 and not isNil(var_333_4) and arg_330_1.var_.characterEffect1054ui_story == nil then
				arg_330_1.var_.characterEffect1054ui_story = var_333_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_6 = 0.200000002980232

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_6 and not isNil(var_333_4) then
				local var_333_7 = (arg_330_1.time_ - var_333_5) / var_333_6

				if arg_330_1.var_.characterEffect1054ui_story and not isNil(var_333_4) then
					local var_333_8 = Mathf.Lerp(0, 0.5, var_333_7)

					arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1054ui_story.fillRatio = var_333_8
				end
			end

			if arg_330_1.time_ >= var_333_5 + var_333_6 and arg_330_1.time_ < var_333_5 + var_333_6 + arg_333_0 and not isNil(var_333_4) and arg_330_1.var_.characterEffect1054ui_story then
				local var_333_9 = 0.5

				arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1054ui_story.fillRatio = var_333_9
			end

			local var_333_10 = 0

			if var_333_10 < arg_330_1.time_ and arg_330_1.time_ <= var_333_10 + arg_333_0 then
				arg_330_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_2")
			end

			local var_333_11 = 0
			local var_333_12 = 1.125

			if var_333_11 < arg_330_1.time_ and arg_330_1.time_ <= var_333_11 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_13 = arg_330_1:FormatText(StoryNameCfg[1488].name)

				arg_330_1.leftNameTxt_.text = var_333_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_14 = arg_330_1:GetWordFromCfg(426011082)
				local var_333_15 = arg_330_1:FormatText(var_333_14.content)

				arg_330_1.text_.text = var_333_15

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_16 = 45
				local var_333_17 = utf8.len(var_333_15)
				local var_333_18 = var_333_16 <= 0 and var_333_12 or var_333_12 * (var_333_17 / var_333_16)

				if var_333_18 > 0 and var_333_12 < var_333_18 then
					arg_330_1.talkMaxDuration = var_333_18

					if var_333_18 + var_333_11 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_18 + var_333_11
					end
				end

				arg_330_1.text_.text = var_333_15
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011082", "story_v_out_426011.awb") ~= 0 then
					local var_333_19 = manager.audio:GetVoiceLength("story_v_out_426011", "426011082", "story_v_out_426011.awb") / 1000

					if var_333_19 + var_333_11 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_19 + var_333_11
					end

					if var_333_14.prefab_name ~= "" and arg_330_1.actors_[var_333_14.prefab_name] ~= nil then
						local var_333_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_14.prefab_name].transform, "story_v_out_426011", "426011082", "story_v_out_426011.awb")

						arg_330_1:RecordAudio("426011082", var_333_20)
						arg_330_1:RecordAudio("426011082", var_333_20)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_426011", "426011082", "story_v_out_426011.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_426011", "426011082", "story_v_out_426011.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_21 = math.max(var_333_12, arg_330_1.talkMaxDuration)

			if var_333_11 <= arg_330_1.time_ and arg_330_1.time_ < var_333_11 + var_333_21 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_11) / var_333_21

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_11 + var_333_21 and arg_330_1.time_ < var_333_11 + var_333_21 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play426011083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 426011083
		arg_334_1.duration_ = 9.17

		local var_334_0 = {
			zh = 7.733,
			ja = 9.166
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
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play426011084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.925

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[1488].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(426011083)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 37
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011083", "story_v_out_426011.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011083", "story_v_out_426011.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_426011", "426011083", "story_v_out_426011.awb")

						arg_334_1:RecordAudio("426011083", var_337_9)
						arg_334_1:RecordAudio("426011083", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_426011", "426011083", "story_v_out_426011.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_426011", "426011083", "story_v_out_426011.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play426011084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 426011084
		arg_338_1.duration_ = 12.53

		local var_338_0 = {
			zh = 7.266,
			ja = 12.533
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
				arg_338_0:Play426011085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["6148ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos6148ui_story = var_341_0.localPosition

				local var_341_2 = GameObjectTools.GetOrAddComponent(var_341_0.gameObject, typeof(DynamicBoneHelper))

				if var_341_2 then
					var_341_2:EnableDynamicBone(false)
				end
			end

			local var_341_3 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_3 then
				local var_341_4 = (arg_338_1.time_ - var_341_1) / var_341_3
				local var_341_5 = Vector3.New(0.7, -0.985, -6)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos6148ui_story, var_341_5, var_341_4)

				local var_341_6 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_6.x, var_341_6.y, var_341_6.z)

				local var_341_7 = var_341_0.localEulerAngles

				var_341_7.z = 0
				var_341_7.x = 0
				var_341_0.localEulerAngles = var_341_7
			end

			if arg_338_1.time_ >= var_341_1 + var_341_3 and arg_338_1.time_ < var_341_1 + var_341_3 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_341_8 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_8.x, var_341_8.y, var_341_8.z)

				local var_341_9 = var_341_0.localEulerAngles

				var_341_9.z = 0
				var_341_9.x = 0
				var_341_0.localEulerAngles = var_341_9

				local var_341_10 = GameObjectTools.GetOrAddComponent(var_341_0.gameObject, typeof(DynamicBoneHelper))

				if var_341_10 then
					var_341_10:EnableDynamicBone(true)
				end
			end

			local var_341_11 = 0

			if var_341_11 < arg_338_1.time_ and arg_338_1.time_ <= var_341_11 + arg_341_0 then
				arg_338_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_341_12 = 0

			if var_341_12 < arg_338_1.time_ and arg_338_1.time_ <= var_341_12 + arg_341_0 then
				arg_338_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_341_13 = 0
			local var_341_14 = 0.85

			if var_341_13 < arg_338_1.time_ and arg_338_1.time_ <= var_341_13 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_15 = arg_338_1:FormatText(StoryNameCfg[1488].name)

				arg_338_1.leftNameTxt_.text = var_341_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_16 = arg_338_1:GetWordFromCfg(426011084)
				local var_341_17 = arg_338_1:FormatText(var_341_16.content)

				arg_338_1.text_.text = var_341_17

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_18 = 34
				local var_341_19 = utf8.len(var_341_17)
				local var_341_20 = var_341_18 <= 0 and var_341_14 or var_341_14 * (var_341_19 / var_341_18)

				if var_341_20 > 0 and var_341_14 < var_341_20 then
					arg_338_1.talkMaxDuration = var_341_20

					if var_341_20 + var_341_13 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_20 + var_341_13
					end
				end

				arg_338_1.text_.text = var_341_17
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011084", "story_v_out_426011.awb") ~= 0 then
					local var_341_21 = manager.audio:GetVoiceLength("story_v_out_426011", "426011084", "story_v_out_426011.awb") / 1000

					if var_341_21 + var_341_13 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_21 + var_341_13
					end

					if var_341_16.prefab_name ~= "" and arg_338_1.actors_[var_341_16.prefab_name] ~= nil then
						local var_341_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_16.prefab_name].transform, "story_v_out_426011", "426011084", "story_v_out_426011.awb")

						arg_338_1:RecordAudio("426011084", var_341_22)
						arg_338_1:RecordAudio("426011084", var_341_22)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_426011", "426011084", "story_v_out_426011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_426011", "426011084", "story_v_out_426011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_23 = math.max(var_341_14, arg_338_1.talkMaxDuration)

			if var_341_13 <= arg_338_1.time_ and arg_338_1.time_ < var_341_13 + var_341_23 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_13) / var_341_23

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_13 + var_341_23 and arg_338_1.time_ < var_341_13 + var_341_23 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play426011085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 426011085
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play426011086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["6148ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect6148ui_story == nil then
				arg_342_1.var_.characterEffect6148ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect6148ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_342_1.var_.characterEffect6148ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect6148ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_342_1.var_.characterEffect6148ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.5

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_9 = arg_342_1:GetWordFromCfg(426011085)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 20
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_14 and arg_342_1.time_ < var_345_6 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play426011086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 426011086
		arg_346_1.duration_ = 7.7

		local var_346_0 = {
			zh = 7.1,
			ja = 7.7
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play426011087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["6148ui_story"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos6148ui_story = var_349_0.localPosition

				local var_349_2 = GameObjectTools.GetOrAddComponent(var_349_0.gameObject, typeof(DynamicBoneHelper))

				if var_349_2 then
					var_349_2:EnableDynamicBone(false)
				end
			end

			local var_349_3 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_3 then
				local var_349_4 = (arg_346_1.time_ - var_349_1) / var_349_3
				local var_349_5 = Vector3.New(0.7, -0.985, -6)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos6148ui_story, var_349_5, var_349_4)

				local var_349_6 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_6.x, var_349_6.y, var_349_6.z)

				local var_349_7 = var_349_0.localEulerAngles

				var_349_7.z = 0
				var_349_7.x = 0
				var_349_0.localEulerAngles = var_349_7
			end

			if arg_346_1.time_ >= var_349_1 + var_349_3 and arg_346_1.time_ < var_349_1 + var_349_3 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_349_8 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_8.x, var_349_8.y, var_349_8.z)

				local var_349_9 = var_349_0.localEulerAngles

				var_349_9.z = 0
				var_349_9.x = 0
				var_349_0.localEulerAngles = var_349_9

				local var_349_10 = GameObjectTools.GetOrAddComponent(var_349_0.gameObject, typeof(DynamicBoneHelper))

				if var_349_10 then
					var_349_10:EnableDynamicBone(true)
				end
			end

			local var_349_11 = arg_346_1.actors_["6148ui_story"]
			local var_349_12 = 0

			if var_349_12 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 and not isNil(var_349_11) and arg_346_1.var_.characterEffect6148ui_story == nil then
				arg_346_1.var_.characterEffect6148ui_story = var_349_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_13 = 0.200000002980232

			if var_349_12 <= arg_346_1.time_ and arg_346_1.time_ < var_349_12 + var_349_13 and not isNil(var_349_11) then
				local var_349_14 = (arg_346_1.time_ - var_349_12) / var_349_13

				if arg_346_1.var_.characterEffect6148ui_story and not isNil(var_349_11) then
					arg_346_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_12 + var_349_13 and arg_346_1.time_ < var_349_12 + var_349_13 + arg_349_0 and not isNil(var_349_11) and arg_346_1.var_.characterEffect6148ui_story then
				arg_346_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_349_15 = 0

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 then
				arg_346_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_349_17 = 0
			local var_349_18 = 0.85

			if var_349_17 < arg_346_1.time_ and arg_346_1.time_ <= var_349_17 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_19 = arg_346_1:FormatText(StoryNameCfg[1488].name)

				arg_346_1.leftNameTxt_.text = var_349_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_20 = arg_346_1:GetWordFromCfg(426011086)
				local var_349_21 = arg_346_1:FormatText(var_349_20.content)

				arg_346_1.text_.text = var_349_21

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_22 = 34
				local var_349_23 = utf8.len(var_349_21)
				local var_349_24 = var_349_22 <= 0 and var_349_18 or var_349_18 * (var_349_23 / var_349_22)

				if var_349_24 > 0 and var_349_18 < var_349_24 then
					arg_346_1.talkMaxDuration = var_349_24

					if var_349_24 + var_349_17 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_24 + var_349_17
					end
				end

				arg_346_1.text_.text = var_349_21
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011086", "story_v_out_426011.awb") ~= 0 then
					local var_349_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011086", "story_v_out_426011.awb") / 1000

					if var_349_25 + var_349_17 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_25 + var_349_17
					end

					if var_349_20.prefab_name ~= "" and arg_346_1.actors_[var_349_20.prefab_name] ~= nil then
						local var_349_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_20.prefab_name].transform, "story_v_out_426011", "426011086", "story_v_out_426011.awb")

						arg_346_1:RecordAudio("426011086", var_349_26)
						arg_346_1:RecordAudio("426011086", var_349_26)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_426011", "426011086", "story_v_out_426011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_426011", "426011086", "story_v_out_426011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_27 = math.max(var_349_18, arg_346_1.talkMaxDuration)

			if var_349_17 <= arg_346_1.time_ and arg_346_1.time_ < var_349_17 + var_349_27 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_17) / var_349_27

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_17 + var_349_27 and arg_346_1.time_ < var_349_17 + var_349_27 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play426011087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 426011087
		arg_350_1.duration_ = 3.87

		local var_350_0 = {
			zh = 3.4,
			ja = 3.866
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play426011088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.45

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[1488].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:GetWordFromCfg(426011087)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 16
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011087", "story_v_out_426011.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011087", "story_v_out_426011.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_out_426011", "426011087", "story_v_out_426011.awb")

						arg_350_1:RecordAudio("426011087", var_353_9)
						arg_350_1:RecordAudio("426011087", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_426011", "426011087", "story_v_out_426011.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_426011", "426011087", "story_v_out_426011.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_10 and arg_350_1.time_ < var_353_0 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play426011088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 426011088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play426011089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["6148ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect6148ui_story == nil then
				arg_354_1.var_.characterEffect6148ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect6148ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_354_1.var_.characterEffect6148ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect6148ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_354_1.var_.characterEffect6148ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.55

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_9 = arg_354_1:GetWordFromCfg(426011088)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 22
				local var_357_12 = utf8.len(var_357_10)
				local var_357_13 = var_357_11 <= 0 and var_357_7 or var_357_7 * (var_357_12 / var_357_11)

				if var_357_13 > 0 and var_357_7 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_14 and arg_354_1.time_ < var_357_6 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play426011089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 426011089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play426011090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.65

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(426011089)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 26
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_8 and arg_358_1.time_ < var_361_0 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play426011090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 426011090
		arg_362_1.duration_ = 9.1

		local var_362_0 = {
			zh = 6.366,
			ja = 9.1
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play426011091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["6148ui_story"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos6148ui_story = var_365_0.localPosition

				local var_365_2 = GameObjectTools.GetOrAddComponent(var_365_0.gameObject, typeof(DynamicBoneHelper))

				if var_365_2 then
					var_365_2:EnableDynamicBone(false)
				end
			end

			local var_365_3 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_3 then
				local var_365_4 = (arg_362_1.time_ - var_365_1) / var_365_3
				local var_365_5 = Vector3.New(0.7, -0.985, -6)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos6148ui_story, var_365_5, var_365_4)

				local var_365_6 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_6.x, var_365_6.y, var_365_6.z)

				local var_365_7 = var_365_0.localEulerAngles

				var_365_7.z = 0
				var_365_7.x = 0
				var_365_0.localEulerAngles = var_365_7
			end

			if arg_362_1.time_ >= var_365_1 + var_365_3 and arg_362_1.time_ < var_365_1 + var_365_3 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_365_8 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_8.x, var_365_8.y, var_365_8.z)

				local var_365_9 = var_365_0.localEulerAngles

				var_365_9.z = 0
				var_365_9.x = 0
				var_365_0.localEulerAngles = var_365_9

				local var_365_10 = GameObjectTools.GetOrAddComponent(var_365_0.gameObject, typeof(DynamicBoneHelper))

				if var_365_10 then
					var_365_10:EnableDynamicBone(true)
				end
			end

			local var_365_11 = arg_362_1.actors_["6148ui_story"]
			local var_365_12 = 0

			if var_365_12 < arg_362_1.time_ and arg_362_1.time_ <= var_365_12 + arg_365_0 and not isNil(var_365_11) and arg_362_1.var_.characterEffect6148ui_story == nil then
				arg_362_1.var_.characterEffect6148ui_story = var_365_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_13 = 0.200000002980232

			if var_365_12 <= arg_362_1.time_ and arg_362_1.time_ < var_365_12 + var_365_13 and not isNil(var_365_11) then
				local var_365_14 = (arg_362_1.time_ - var_365_12) / var_365_13

				if arg_362_1.var_.characterEffect6148ui_story and not isNil(var_365_11) then
					arg_362_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_12 + var_365_13 and arg_362_1.time_ < var_365_12 + var_365_13 + arg_365_0 and not isNil(var_365_11) and arg_362_1.var_.characterEffect6148ui_story then
				arg_362_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_365_15 = 0

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				arg_362_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_365_16 = 0

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_365_17 = 0
			local var_365_18 = 0.8

			if var_365_17 < arg_362_1.time_ and arg_362_1.time_ <= var_365_17 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_19 = arg_362_1:FormatText(StoryNameCfg[1488].name)

				arg_362_1.leftNameTxt_.text = var_365_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_20 = arg_362_1:GetWordFromCfg(426011090)
				local var_365_21 = arg_362_1:FormatText(var_365_20.content)

				arg_362_1.text_.text = var_365_21

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_22 = 32
				local var_365_23 = utf8.len(var_365_21)
				local var_365_24 = var_365_22 <= 0 and var_365_18 or var_365_18 * (var_365_23 / var_365_22)

				if var_365_24 > 0 and var_365_18 < var_365_24 then
					arg_362_1.talkMaxDuration = var_365_24

					if var_365_24 + var_365_17 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_24 + var_365_17
					end
				end

				arg_362_1.text_.text = var_365_21
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011090", "story_v_out_426011.awb") ~= 0 then
					local var_365_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011090", "story_v_out_426011.awb") / 1000

					if var_365_25 + var_365_17 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_25 + var_365_17
					end

					if var_365_20.prefab_name ~= "" and arg_362_1.actors_[var_365_20.prefab_name] ~= nil then
						local var_365_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_20.prefab_name].transform, "story_v_out_426011", "426011090", "story_v_out_426011.awb")

						arg_362_1:RecordAudio("426011090", var_365_26)
						arg_362_1:RecordAudio("426011090", var_365_26)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_426011", "426011090", "story_v_out_426011.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_426011", "426011090", "story_v_out_426011.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_27 = math.max(var_365_18, arg_362_1.talkMaxDuration)

			if var_365_17 <= arg_362_1.time_ and arg_362_1.time_ < var_365_17 + var_365_27 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_17) / var_365_27

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_17 + var_365_27 and arg_362_1.time_ < var_365_17 + var_365_27 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play426011091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 426011091
		arg_366_1.duration_ = 8.47

		local var_366_0 = {
			zh = 8.466,
			ja = 8.433
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
				arg_366_0:Play426011092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1054ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1054ui_story = var_369_0.localPosition

				local var_369_2 = GameObjectTools.GetOrAddComponent(var_369_0.gameObject, typeof(DynamicBoneHelper))

				if var_369_2 then
					var_369_2:EnableDynamicBone(false)
				end
			end

			local var_369_3 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_3 then
				local var_369_4 = (arg_366_1.time_ - var_369_1) / var_369_3
				local var_369_5 = Vector3.New(-0.7, -0.985, -6)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1054ui_story, var_369_5, var_369_4)

				local var_369_6 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_6.x, var_369_6.y, var_369_6.z)

				local var_369_7 = var_369_0.localEulerAngles

				var_369_7.z = 0
				var_369_7.x = 0
				var_369_0.localEulerAngles = var_369_7
			end

			if arg_366_1.time_ >= var_369_1 + var_369_3 and arg_366_1.time_ < var_369_1 + var_369_3 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_369_8 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_8.x, var_369_8.y, var_369_8.z)

				local var_369_9 = var_369_0.localEulerAngles

				var_369_9.z = 0
				var_369_9.x = 0
				var_369_0.localEulerAngles = var_369_9

				local var_369_10 = GameObjectTools.GetOrAddComponent(var_369_0.gameObject, typeof(DynamicBoneHelper))

				if var_369_10 then
					var_369_10:EnableDynamicBone(true)
				end
			end

			local var_369_11 = arg_366_1.actors_["1054ui_story"]
			local var_369_12 = 0

			if var_369_12 < arg_366_1.time_ and arg_366_1.time_ <= var_369_12 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect1054ui_story == nil then
				arg_366_1.var_.characterEffect1054ui_story = var_369_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_13 = 0.200000002980232

			if var_369_12 <= arg_366_1.time_ and arg_366_1.time_ < var_369_12 + var_369_13 and not isNil(var_369_11) then
				local var_369_14 = (arg_366_1.time_ - var_369_12) / var_369_13

				if arg_366_1.var_.characterEffect1054ui_story and not isNil(var_369_11) then
					arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_12 + var_369_13 and arg_366_1.time_ < var_369_12 + var_369_13 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect1054ui_story then
				arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_369_15 = arg_366_1.actors_["6148ui_story"]
			local var_369_16 = 0

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 and not isNil(var_369_15) and arg_366_1.var_.characterEffect6148ui_story == nil then
				arg_366_1.var_.characterEffect6148ui_story = var_369_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_17 = 0.200000002980232

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_17 and not isNil(var_369_15) then
				local var_369_18 = (arg_366_1.time_ - var_369_16) / var_369_17

				if arg_366_1.var_.characterEffect6148ui_story and not isNil(var_369_15) then
					local var_369_19 = Mathf.Lerp(0, 0.5, var_369_18)

					arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_366_1.var_.characterEffect6148ui_story.fillRatio = var_369_19
				end
			end

			if arg_366_1.time_ >= var_369_16 + var_369_17 and arg_366_1.time_ < var_369_16 + var_369_17 + arg_369_0 and not isNil(var_369_15) and arg_366_1.var_.characterEffect6148ui_story then
				local var_369_20 = 0.5

				arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_366_1.var_.characterEffect6148ui_story.fillRatio = var_369_20
			end

			local var_369_21 = 0

			if var_369_21 < arg_366_1.time_ and arg_366_1.time_ <= var_369_21 + arg_369_0 then
				arg_366_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_369_22 = 0

			if var_369_22 < arg_366_1.time_ and arg_366_1.time_ <= var_369_22 + arg_369_0 then
				arg_366_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_369_23 = 0
			local var_369_24 = 0.85

			if var_369_23 < arg_366_1.time_ and arg_366_1.time_ <= var_369_23 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_25 = arg_366_1:FormatText(StoryNameCfg[1487].name)

				arg_366_1.leftNameTxt_.text = var_369_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_26 = arg_366_1:GetWordFromCfg(426011091)
				local var_369_27 = arg_366_1:FormatText(var_369_26.content)

				arg_366_1.text_.text = var_369_27

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_28 = 34
				local var_369_29 = utf8.len(var_369_27)
				local var_369_30 = var_369_28 <= 0 and var_369_24 or var_369_24 * (var_369_29 / var_369_28)

				if var_369_30 > 0 and var_369_24 < var_369_30 then
					arg_366_1.talkMaxDuration = var_369_30

					if var_369_30 + var_369_23 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_30 + var_369_23
					end
				end

				arg_366_1.text_.text = var_369_27
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011091", "story_v_out_426011.awb") ~= 0 then
					local var_369_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011091", "story_v_out_426011.awb") / 1000

					if var_369_31 + var_369_23 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_31 + var_369_23
					end

					if var_369_26.prefab_name ~= "" and arg_366_1.actors_[var_369_26.prefab_name] ~= nil then
						local var_369_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_26.prefab_name].transform, "story_v_out_426011", "426011091", "story_v_out_426011.awb")

						arg_366_1:RecordAudio("426011091", var_369_32)
						arg_366_1:RecordAudio("426011091", var_369_32)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_426011", "426011091", "story_v_out_426011.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_426011", "426011091", "story_v_out_426011.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_33 = math.max(var_369_24, arg_366_1.talkMaxDuration)

			if var_369_23 <= arg_366_1.time_ and arg_366_1.time_ < var_369_23 + var_369_33 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_23) / var_369_33

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_23 + var_369_33 and arg_366_1.time_ < var_369_23 + var_369_33 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play426011092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 426011092
		arg_370_1.duration_ = 4.7

		local var_370_0 = {
			zh = 4.5,
			ja = 4.7
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play426011093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.45

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[1487].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_3 = arg_370_1:GetWordFromCfg(426011092)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 18
				local var_373_6 = utf8.len(var_373_4)
				local var_373_7 = var_373_5 <= 0 and var_373_1 or var_373_1 * (var_373_6 / var_373_5)

				if var_373_7 > 0 and var_373_1 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011092", "story_v_out_426011.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_out_426011", "426011092", "story_v_out_426011.awb") / 1000

					if var_373_8 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_0
					end

					if var_373_3.prefab_name ~= "" and arg_370_1.actors_[var_373_3.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_3.prefab_name].transform, "story_v_out_426011", "426011092", "story_v_out_426011.awb")

						arg_370_1:RecordAudio("426011092", var_373_9)
						arg_370_1:RecordAudio("426011092", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_426011", "426011092", "story_v_out_426011.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_426011", "426011092", "story_v_out_426011.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_10 and arg_370_1.time_ < var_373_0 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play426011093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 426011093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play426011094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1054ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1054ui_story == nil then
				arg_374_1.var_.characterEffect1054ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1054ui_story and not isNil(var_377_0) then
					local var_377_4 = Mathf.Lerp(0, 0.5, var_377_3)

					arg_374_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1054ui_story.fillRatio = var_377_4
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1054ui_story then
				local var_377_5 = 0.5

				arg_374_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1054ui_story.fillRatio = var_377_5
			end

			local var_377_6 = 0
			local var_377_7 = 0.125

			if var_377_6 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_8 = arg_374_1:FormatText(StoryNameCfg[7].name)

				arg_374_1.leftNameTxt_.text = var_377_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_9 = arg_374_1:GetWordFromCfg(426011093)
				local var_377_10 = arg_374_1:FormatText(var_377_9.content)

				arg_374_1.text_.text = var_377_10

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_11 = 5
				local var_377_12 = utf8.len(var_377_10)
				local var_377_13 = var_377_11 <= 0 and var_377_7 or var_377_7 * (var_377_12 / var_377_11)

				if var_377_13 > 0 and var_377_7 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_6
					end
				end

				arg_374_1.text_.text = var_377_10
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_14 = math.max(var_377_7, arg_374_1.talkMaxDuration)

			if var_377_6 <= arg_374_1.time_ and arg_374_1.time_ < var_377_6 + var_377_14 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_6) / var_377_14

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_6 + var_377_14 and arg_374_1.time_ < var_377_6 + var_377_14 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play426011094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 426011094
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play426011095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1054ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1054ui_story = var_381_0.localPosition

				local var_381_2 = GameObjectTools.GetOrAddComponent(var_381_0.gameObject, typeof(DynamicBoneHelper))

				if var_381_2 then
					var_381_2:EnableDynamicBone(false)
				end
			end

			local var_381_3 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_3 then
				local var_381_4 = (arg_378_1.time_ - var_381_1) / var_381_3
				local var_381_5 = Vector3.New(0, 100, 0)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1054ui_story, var_381_5, var_381_4)

				local var_381_6 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_6.x, var_381_6.y, var_381_6.z)

				local var_381_7 = var_381_0.localEulerAngles

				var_381_7.z = 0
				var_381_7.x = 0
				var_381_0.localEulerAngles = var_381_7
			end

			if arg_378_1.time_ >= var_381_1 + var_381_3 and arg_378_1.time_ < var_381_1 + var_381_3 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0, 100, 0)

				local var_381_8 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_8.x, var_381_8.y, var_381_8.z)

				local var_381_9 = var_381_0.localEulerAngles

				var_381_9.z = 0
				var_381_9.x = 0
				var_381_0.localEulerAngles = var_381_9

				local var_381_10 = GameObjectTools.GetOrAddComponent(var_381_0.gameObject, typeof(DynamicBoneHelper))

				if var_381_10 then
					var_381_10:EnableDynamicBone(true)
				end
			end

			local var_381_11 = arg_378_1.actors_["6148ui_story"].transform
			local var_381_12 = 0

			if var_381_12 < arg_378_1.time_ and arg_378_1.time_ <= var_381_12 + arg_381_0 then
				arg_378_1.var_.moveOldPos6148ui_story = var_381_11.localPosition

				local var_381_13 = GameObjectTools.GetOrAddComponent(var_381_11.gameObject, typeof(DynamicBoneHelper))

				if var_381_13 then
					var_381_13:EnableDynamicBone(false)
				end
			end

			local var_381_14 = 0.001

			if var_381_12 <= arg_378_1.time_ and arg_378_1.time_ < var_381_12 + var_381_14 then
				local var_381_15 = (arg_378_1.time_ - var_381_12) / var_381_14
				local var_381_16 = Vector3.New(0, 100, 0)

				var_381_11.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos6148ui_story, var_381_16, var_381_15)

				local var_381_17 = manager.ui.mainCamera.transform.position - var_381_11.position

				var_381_11.forward = Vector3.New(var_381_17.x, var_381_17.y, var_381_17.z)

				local var_381_18 = var_381_11.localEulerAngles

				var_381_18.z = 0
				var_381_18.x = 0
				var_381_11.localEulerAngles = var_381_18
			end

			if arg_378_1.time_ >= var_381_12 + var_381_14 and arg_378_1.time_ < var_381_12 + var_381_14 + arg_381_0 then
				var_381_11.localPosition = Vector3.New(0, 100, 0)

				local var_381_19 = manager.ui.mainCamera.transform.position - var_381_11.position

				var_381_11.forward = Vector3.New(var_381_19.x, var_381_19.y, var_381_19.z)

				local var_381_20 = var_381_11.localEulerAngles

				var_381_20.z = 0
				var_381_20.x = 0
				var_381_11.localEulerAngles = var_381_20

				local var_381_21 = GameObjectTools.GetOrAddComponent(var_381_11.gameObject, typeof(DynamicBoneHelper))

				if var_381_21 then
					var_381_21:EnableDynamicBone(true)
				end
			end

			local var_381_22 = 0
			local var_381_23 = 1.1

			if var_381_22 < arg_378_1.time_ and arg_378_1.time_ <= var_381_22 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_24 = arg_378_1:GetWordFromCfg(426011094)
				local var_381_25 = arg_378_1:FormatText(var_381_24.content)

				arg_378_1.text_.text = var_381_25

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_26 = 44
				local var_381_27 = utf8.len(var_381_25)
				local var_381_28 = var_381_26 <= 0 and var_381_23 or var_381_23 * (var_381_27 / var_381_26)

				if var_381_28 > 0 and var_381_23 < var_381_28 then
					arg_378_1.talkMaxDuration = var_381_28

					if var_381_28 + var_381_22 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_28 + var_381_22
					end
				end

				arg_378_1.text_.text = var_381_25
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_29 = math.max(var_381_23, arg_378_1.talkMaxDuration)

			if var_381_22 <= arg_378_1.time_ and arg_378_1.time_ < var_381_22 + var_381_29 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_22) / var_381_29

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_22 + var_381_29 and arg_378_1.time_ < var_381_22 + var_381_29 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play426011095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 426011095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play426011096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.975

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(426011095)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 39
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play426011096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 426011096
		arg_386_1.duration_ = 9.47

		local var_386_0 = {
			zh = 5.4,
			ja = 9.466
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play426011097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["6148ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos6148ui_story = var_389_0.localPosition

				local var_389_2 = GameObjectTools.GetOrAddComponent(var_389_0.gameObject, typeof(DynamicBoneHelper))

				if var_389_2 then
					var_389_2:EnableDynamicBone(false)
				end
			end

			local var_389_3 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_3 then
				local var_389_4 = (arg_386_1.time_ - var_389_1) / var_389_3
				local var_389_5 = Vector3.New(0, -0.985, -6)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos6148ui_story, var_389_5, var_389_4)

				local var_389_6 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_6.x, var_389_6.y, var_389_6.z)

				local var_389_7 = var_389_0.localEulerAngles

				var_389_7.z = 0
				var_389_7.x = 0
				var_389_0.localEulerAngles = var_389_7
			end

			if arg_386_1.time_ >= var_389_1 + var_389_3 and arg_386_1.time_ < var_389_1 + var_389_3 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_389_8 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_8.x, var_389_8.y, var_389_8.z)

				local var_389_9 = var_389_0.localEulerAngles

				var_389_9.z = 0
				var_389_9.x = 0
				var_389_0.localEulerAngles = var_389_9

				local var_389_10 = GameObjectTools.GetOrAddComponent(var_389_0.gameObject, typeof(DynamicBoneHelper))

				if var_389_10 then
					var_389_10:EnableDynamicBone(true)
				end
			end

			local var_389_11 = arg_386_1.actors_["6148ui_story"]
			local var_389_12 = 0

			if var_389_12 < arg_386_1.time_ and arg_386_1.time_ <= var_389_12 + arg_389_0 and not isNil(var_389_11) and arg_386_1.var_.characterEffect6148ui_story == nil then
				arg_386_1.var_.characterEffect6148ui_story = var_389_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_13 = 0.200000002980232

			if var_389_12 <= arg_386_1.time_ and arg_386_1.time_ < var_389_12 + var_389_13 and not isNil(var_389_11) then
				local var_389_14 = (arg_386_1.time_ - var_389_12) / var_389_13

				if arg_386_1.var_.characterEffect6148ui_story and not isNil(var_389_11) then
					arg_386_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_12 + var_389_13 and arg_386_1.time_ < var_389_12 + var_389_13 + arg_389_0 and not isNil(var_389_11) and arg_386_1.var_.characterEffect6148ui_story then
				arg_386_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_389_15 = 0

			if var_389_15 < arg_386_1.time_ and arg_386_1.time_ <= var_389_15 + arg_389_0 then
				arg_386_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_389_16 = 0

			if var_389_16 < arg_386_1.time_ and arg_386_1.time_ <= var_389_16 + arg_389_0 then
				arg_386_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_389_17 = 0
			local var_389_18 = 0.625

			if var_389_17 < arg_386_1.time_ and arg_386_1.time_ <= var_389_17 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_19 = arg_386_1:FormatText(StoryNameCfg[1488].name)

				arg_386_1.leftNameTxt_.text = var_389_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_20 = arg_386_1:GetWordFromCfg(426011096)
				local var_389_21 = arg_386_1:FormatText(var_389_20.content)

				arg_386_1.text_.text = var_389_21

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_22 = 25
				local var_389_23 = utf8.len(var_389_21)
				local var_389_24 = var_389_22 <= 0 and var_389_18 or var_389_18 * (var_389_23 / var_389_22)

				if var_389_24 > 0 and var_389_18 < var_389_24 then
					arg_386_1.talkMaxDuration = var_389_24

					if var_389_24 + var_389_17 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_24 + var_389_17
					end
				end

				arg_386_1.text_.text = var_389_21
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011096", "story_v_out_426011.awb") ~= 0 then
					local var_389_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011096", "story_v_out_426011.awb") / 1000

					if var_389_25 + var_389_17 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_25 + var_389_17
					end

					if var_389_20.prefab_name ~= "" and arg_386_1.actors_[var_389_20.prefab_name] ~= nil then
						local var_389_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_20.prefab_name].transform, "story_v_out_426011", "426011096", "story_v_out_426011.awb")

						arg_386_1:RecordAudio("426011096", var_389_26)
						arg_386_1:RecordAudio("426011096", var_389_26)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_426011", "426011096", "story_v_out_426011.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_426011", "426011096", "story_v_out_426011.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_27 = math.max(var_389_18, arg_386_1.talkMaxDuration)

			if var_389_17 <= arg_386_1.time_ and arg_386_1.time_ < var_389_17 + var_389_27 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_17) / var_389_27

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_17 + var_389_27 and arg_386_1.time_ < var_389_17 + var_389_27 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play426011097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 426011097
		arg_390_1.duration_ = 7.27

		local var_390_0 = {
			zh = 5.766,
			ja = 7.266
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play426011098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["6148ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos6148ui_story = var_393_0.localPosition

				local var_393_2 = GameObjectTools.GetOrAddComponent(var_393_0.gameObject, typeof(DynamicBoneHelper))

				if var_393_2 then
					var_393_2:EnableDynamicBone(false)
				end
			end

			local var_393_3 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_3 then
				local var_393_4 = (arg_390_1.time_ - var_393_1) / var_393_3
				local var_393_5 = Vector3.New(0, -0.985, -6)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos6148ui_story, var_393_5, var_393_4)

				local var_393_6 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_6.x, var_393_6.y, var_393_6.z)

				local var_393_7 = var_393_0.localEulerAngles

				var_393_7.z = 0
				var_393_7.x = 0
				var_393_0.localEulerAngles = var_393_7
			end

			if arg_390_1.time_ >= var_393_1 + var_393_3 and arg_390_1.time_ < var_393_1 + var_393_3 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_393_8 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_8.x, var_393_8.y, var_393_8.z)

				local var_393_9 = var_393_0.localEulerAngles

				var_393_9.z = 0
				var_393_9.x = 0
				var_393_0.localEulerAngles = var_393_9

				local var_393_10 = GameObjectTools.GetOrAddComponent(var_393_0.gameObject, typeof(DynamicBoneHelper))

				if var_393_10 then
					var_393_10:EnableDynamicBone(true)
				end
			end

			local var_393_11 = 0

			if var_393_11 < arg_390_1.time_ and arg_390_1.time_ <= var_393_11 + arg_393_0 then
				arg_390_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_393_12 = 0
			local var_393_13 = 0.75

			if var_393_12 < arg_390_1.time_ and arg_390_1.time_ <= var_393_12 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_14 = arg_390_1:FormatText(StoryNameCfg[1488].name)

				arg_390_1.leftNameTxt_.text = var_393_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_15 = arg_390_1:GetWordFromCfg(426011097)
				local var_393_16 = arg_390_1:FormatText(var_393_15.content)

				arg_390_1.text_.text = var_393_16

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_17 = 30
				local var_393_18 = utf8.len(var_393_16)
				local var_393_19 = var_393_17 <= 0 and var_393_13 or var_393_13 * (var_393_18 / var_393_17)

				if var_393_19 > 0 and var_393_13 < var_393_19 then
					arg_390_1.talkMaxDuration = var_393_19

					if var_393_19 + var_393_12 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_19 + var_393_12
					end
				end

				arg_390_1.text_.text = var_393_16
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011097", "story_v_out_426011.awb") ~= 0 then
					local var_393_20 = manager.audio:GetVoiceLength("story_v_out_426011", "426011097", "story_v_out_426011.awb") / 1000

					if var_393_20 + var_393_12 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_20 + var_393_12
					end

					if var_393_15.prefab_name ~= "" and arg_390_1.actors_[var_393_15.prefab_name] ~= nil then
						local var_393_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_15.prefab_name].transform, "story_v_out_426011", "426011097", "story_v_out_426011.awb")

						arg_390_1:RecordAudio("426011097", var_393_21)
						arg_390_1:RecordAudio("426011097", var_393_21)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_426011", "426011097", "story_v_out_426011.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_426011", "426011097", "story_v_out_426011.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_22 = math.max(var_393_13, arg_390_1.talkMaxDuration)

			if var_393_12 <= arg_390_1.time_ and arg_390_1.time_ < var_393_12 + var_393_22 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_12) / var_393_22

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_12 + var_393_22 and arg_390_1.time_ < var_393_12 + var_393_22 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play426011098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 426011098
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play426011099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["6148ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect6148ui_story == nil then
				arg_394_1.var_.characterEffect6148ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect6148ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_394_1.var_.characterEffect6148ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect6148ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_394_1.var_.characterEffect6148ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.7

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(426011098)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 28
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_14 and arg_394_1.time_ < var_397_6 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play426011099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 426011099
		arg_398_1.duration_ = 5.97

		local var_398_0 = {
			zh = 2.966,
			ja = 5.966
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play426011100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1054ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1054ui_story = var_401_0.localPosition

				local var_401_2 = GameObjectTools.GetOrAddComponent(var_401_0.gameObject, typeof(DynamicBoneHelper))

				if var_401_2 then
					var_401_2:EnableDynamicBone(false)
				end
			end

			local var_401_3 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_3 then
				local var_401_4 = (arg_398_1.time_ - var_401_1) / var_401_3
				local var_401_5 = Vector3.New(0.7, -0.985, -6)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1054ui_story, var_401_5, var_401_4)

				local var_401_6 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_6.x, var_401_6.y, var_401_6.z)

				local var_401_7 = var_401_0.localEulerAngles

				var_401_7.z = 0
				var_401_7.x = 0
				var_401_0.localEulerAngles = var_401_7
			end

			if arg_398_1.time_ >= var_401_1 + var_401_3 and arg_398_1.time_ < var_401_1 + var_401_3 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_401_8 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_8.x, var_401_8.y, var_401_8.z)

				local var_401_9 = var_401_0.localEulerAngles

				var_401_9.z = 0
				var_401_9.x = 0
				var_401_0.localEulerAngles = var_401_9

				local var_401_10 = GameObjectTools.GetOrAddComponent(var_401_0.gameObject, typeof(DynamicBoneHelper))

				if var_401_10 then
					var_401_10:EnableDynamicBone(true)
				end
			end

			local var_401_11 = arg_398_1.actors_["6148ui_story"].transform
			local var_401_12 = 0

			if var_401_12 < arg_398_1.time_ and arg_398_1.time_ <= var_401_12 + arg_401_0 then
				arg_398_1.var_.moveOldPos6148ui_story = var_401_11.localPosition

				local var_401_13 = GameObjectTools.GetOrAddComponent(var_401_11.gameObject, typeof(DynamicBoneHelper))

				if var_401_13 then
					var_401_13:EnableDynamicBone(false)
				end
			end

			local var_401_14 = 0.001

			if var_401_12 <= arg_398_1.time_ and arg_398_1.time_ < var_401_12 + var_401_14 then
				local var_401_15 = (arg_398_1.time_ - var_401_12) / var_401_14
				local var_401_16 = Vector3.New(-0.7, -0.985, -6)

				var_401_11.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos6148ui_story, var_401_16, var_401_15)

				local var_401_17 = manager.ui.mainCamera.transform.position - var_401_11.position

				var_401_11.forward = Vector3.New(var_401_17.x, var_401_17.y, var_401_17.z)

				local var_401_18 = var_401_11.localEulerAngles

				var_401_18.z = 0
				var_401_18.x = 0
				var_401_11.localEulerAngles = var_401_18
			end

			if arg_398_1.time_ >= var_401_12 + var_401_14 and arg_398_1.time_ < var_401_12 + var_401_14 + arg_401_0 then
				var_401_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_401_19 = manager.ui.mainCamera.transform.position - var_401_11.position

				var_401_11.forward = Vector3.New(var_401_19.x, var_401_19.y, var_401_19.z)

				local var_401_20 = var_401_11.localEulerAngles

				var_401_20.z = 0
				var_401_20.x = 0
				var_401_11.localEulerAngles = var_401_20

				local var_401_21 = GameObjectTools.GetOrAddComponent(var_401_11.gameObject, typeof(DynamicBoneHelper))

				if var_401_21 then
					var_401_21:EnableDynamicBone(true)
				end
			end

			local var_401_22 = arg_398_1.actors_["1054ui_story"]
			local var_401_23 = 0

			if var_401_23 < arg_398_1.time_ and arg_398_1.time_ <= var_401_23 + arg_401_0 and not isNil(var_401_22) and arg_398_1.var_.characterEffect1054ui_story == nil then
				arg_398_1.var_.characterEffect1054ui_story = var_401_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_24 = 0.200000002980232

			if var_401_23 <= arg_398_1.time_ and arg_398_1.time_ < var_401_23 + var_401_24 and not isNil(var_401_22) then
				local var_401_25 = (arg_398_1.time_ - var_401_23) / var_401_24

				if arg_398_1.var_.characterEffect1054ui_story and not isNil(var_401_22) then
					arg_398_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_23 + var_401_24 and arg_398_1.time_ < var_401_23 + var_401_24 + arg_401_0 and not isNil(var_401_22) and arg_398_1.var_.characterEffect1054ui_story then
				arg_398_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_401_26 = 0

			if var_401_26 < arg_398_1.time_ and arg_398_1.time_ <= var_401_26 + arg_401_0 then
				arg_398_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_401_27 = 0

			if var_401_27 < arg_398_1.time_ and arg_398_1.time_ <= var_401_27 + arg_401_0 then
				arg_398_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_401_28 = 0
			local var_401_29 = 0.3

			if var_401_28 < arg_398_1.time_ and arg_398_1.time_ <= var_401_28 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_30 = arg_398_1:FormatText(StoryNameCfg[1487].name)

				arg_398_1.leftNameTxt_.text = var_401_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_31 = arg_398_1:GetWordFromCfg(426011099)
				local var_401_32 = arg_398_1:FormatText(var_401_31.content)

				arg_398_1.text_.text = var_401_32

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_33 = 12
				local var_401_34 = utf8.len(var_401_32)
				local var_401_35 = var_401_33 <= 0 and var_401_29 or var_401_29 * (var_401_34 / var_401_33)

				if var_401_35 > 0 and var_401_29 < var_401_35 then
					arg_398_1.talkMaxDuration = var_401_35

					if var_401_35 + var_401_28 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_35 + var_401_28
					end
				end

				arg_398_1.text_.text = var_401_32
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011099", "story_v_out_426011.awb") ~= 0 then
					local var_401_36 = manager.audio:GetVoiceLength("story_v_out_426011", "426011099", "story_v_out_426011.awb") / 1000

					if var_401_36 + var_401_28 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_36 + var_401_28
					end

					if var_401_31.prefab_name ~= "" and arg_398_1.actors_[var_401_31.prefab_name] ~= nil then
						local var_401_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_31.prefab_name].transform, "story_v_out_426011", "426011099", "story_v_out_426011.awb")

						arg_398_1:RecordAudio("426011099", var_401_37)
						arg_398_1:RecordAudio("426011099", var_401_37)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_426011", "426011099", "story_v_out_426011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_426011", "426011099", "story_v_out_426011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_38 = math.max(var_401_29, arg_398_1.talkMaxDuration)

			if var_401_28 <= arg_398_1.time_ and arg_398_1.time_ < var_401_28 + var_401_38 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_28) / var_401_38

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_28 + var_401_38 and arg_398_1.time_ < var_401_28 + var_401_38 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play426011100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 426011100
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play426011101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1054ui_story"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1054ui_story == nil then
				arg_402_1.var_.characterEffect1054ui_story = var_405_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.characterEffect1054ui_story and not isNil(var_405_0) then
					local var_405_4 = Mathf.Lerp(0, 0.5, var_405_3)

					arg_402_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1054ui_story.fillRatio = var_405_4
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1054ui_story then
				local var_405_5 = 0.5

				arg_402_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1054ui_story.fillRatio = var_405_5
			end

			local var_405_6 = 0
			local var_405_7 = 0.075

			if var_405_6 < arg_402_1.time_ and arg_402_1.time_ <= var_405_6 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_8 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_9 = arg_402_1:GetWordFromCfg(426011100)
				local var_405_10 = arg_402_1:FormatText(var_405_9.content)

				arg_402_1.text_.text = var_405_10

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_11 = 3
				local var_405_12 = utf8.len(var_405_10)
				local var_405_13 = var_405_11 <= 0 and var_405_7 or var_405_7 * (var_405_12 / var_405_11)

				if var_405_13 > 0 and var_405_7 < var_405_13 then
					arg_402_1.talkMaxDuration = var_405_13

					if var_405_13 + var_405_6 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_13 + var_405_6
					end
				end

				arg_402_1.text_.text = var_405_10
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_14 = math.max(var_405_7, arg_402_1.talkMaxDuration)

			if var_405_6 <= arg_402_1.time_ and arg_402_1.time_ < var_405_6 + var_405_14 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_6) / var_405_14

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_6 + var_405_14 and arg_402_1.time_ < var_405_6 + var_405_14 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play426011101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 426011101
		arg_406_1.duration_ = 4.33

		local var_406_0 = {
			zh = 3.166,
			ja = 4.333
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play426011102(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1054ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1054ui_story == nil then
				arg_406_1.var_.characterEffect1054ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1054ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1054ui_story then
				arg_406_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_409_4 = 0

			if var_409_4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_409_5 = 0
			local var_409_6 = 0.35

			if var_409_5 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_7 = arg_406_1:FormatText(StoryNameCfg[1487].name)

				arg_406_1.leftNameTxt_.text = var_409_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_8 = arg_406_1:GetWordFromCfg(426011101)
				local var_409_9 = arg_406_1:FormatText(var_409_8.content)

				arg_406_1.text_.text = var_409_9

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_10 = 14
				local var_409_11 = utf8.len(var_409_9)
				local var_409_12 = var_409_10 <= 0 and var_409_6 or var_409_6 * (var_409_11 / var_409_10)

				if var_409_12 > 0 and var_409_6 < var_409_12 then
					arg_406_1.talkMaxDuration = var_409_12

					if var_409_12 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_12 + var_409_5
					end
				end

				arg_406_1.text_.text = var_409_9
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011101", "story_v_out_426011.awb") ~= 0 then
					local var_409_13 = manager.audio:GetVoiceLength("story_v_out_426011", "426011101", "story_v_out_426011.awb") / 1000

					if var_409_13 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_5
					end

					if var_409_8.prefab_name ~= "" and arg_406_1.actors_[var_409_8.prefab_name] ~= nil then
						local var_409_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_8.prefab_name].transform, "story_v_out_426011", "426011101", "story_v_out_426011.awb")

						arg_406_1:RecordAudio("426011101", var_409_14)
						arg_406_1:RecordAudio("426011101", var_409_14)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_426011", "426011101", "story_v_out_426011.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_426011", "426011101", "story_v_out_426011.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_15 = math.max(var_409_6, arg_406_1.talkMaxDuration)

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_15 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_5) / var_409_15

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_5 + var_409_15 and arg_406_1.time_ < var_409_5 + var_409_15 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play426011102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 426011102
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play426011103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1054ui_story"]
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1054ui_story == nil then
				arg_410_1.var_.characterEffect1054ui_story = var_413_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 and not isNil(var_413_0) then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2

				if arg_410_1.var_.characterEffect1054ui_story and not isNil(var_413_0) then
					local var_413_4 = Mathf.Lerp(0, 0.5, var_413_3)

					arg_410_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1054ui_story.fillRatio = var_413_4
				end
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 and not isNil(var_413_0) and arg_410_1.var_.characterEffect1054ui_story then
				local var_413_5 = 0.5

				arg_410_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1054ui_story.fillRatio = var_413_5
			end

			local var_413_6 = 0
			local var_413_7 = 0.6

			if var_413_6 < arg_410_1.time_ and arg_410_1.time_ <= var_413_6 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_8 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_9 = arg_410_1:GetWordFromCfg(426011102)
				local var_413_10 = arg_410_1:FormatText(var_413_9.content)

				arg_410_1.text_.text = var_413_10

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_11 = 24
				local var_413_12 = utf8.len(var_413_10)
				local var_413_13 = var_413_11 <= 0 and var_413_7 or var_413_7 * (var_413_12 / var_413_11)

				if var_413_13 > 0 and var_413_7 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_6 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_6
					end
				end

				arg_410_1.text_.text = var_413_10
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_14 = math.max(var_413_7, arg_410_1.talkMaxDuration)

			if var_413_6 <= arg_410_1.time_ and arg_410_1.time_ < var_413_6 + var_413_14 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_6) / var_413_14

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_6 + var_413_14 and arg_410_1.time_ < var_413_6 + var_413_14 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play426011103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 426011103
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play426011104(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.775

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(426011103)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 31
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play426011104 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 426011104
		arg_418_1.duration_ = 2.2

		local var_418_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play426011105(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1054ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1054ui_story == nil then
				arg_418_1.var_.characterEffect1054ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1054ui_story and not isNil(var_421_0) then
					arg_418_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1054ui_story then
				arg_418_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_421_4 = arg_418_1.actors_["6148ui_story"]
			local var_421_5 = 0

			if var_421_5 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect6148ui_story == nil then
				arg_418_1.var_.characterEffect6148ui_story = var_421_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_6 = 0.200000002980232

			if var_421_5 <= arg_418_1.time_ and arg_418_1.time_ < var_421_5 + var_421_6 and not isNil(var_421_4) then
				local var_421_7 = (arg_418_1.time_ - var_421_5) / var_421_6

				if arg_418_1.var_.characterEffect6148ui_story and not isNil(var_421_4) then
					arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_5 + var_421_6 and arg_418_1.time_ < var_421_5 + var_421_6 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect6148ui_story then
				arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_421_8 = 0

			if var_421_8 < arg_418_1.time_ and arg_418_1.time_ <= var_421_8 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_421_9 = 0

			if var_421_9 < arg_418_1.time_ and arg_418_1.time_ <= var_421_9 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_421_10 = 0

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 then
				arg_418_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_421_11 = 0
			local var_421_12 = 0.1

			if var_421_11 < arg_418_1.time_ and arg_418_1.time_ <= var_421_11 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_13 = arg_418_1:FormatText(StoryNameCfg[1489].name)

				arg_418_1.leftNameTxt_.text = var_421_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_14 = arg_418_1:GetWordFromCfg(426011104)
				local var_421_15 = arg_418_1:FormatText(var_421_14.content)

				arg_418_1.text_.text = var_421_15

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_16 = 4
				local var_421_17 = utf8.len(var_421_15)
				local var_421_18 = var_421_16 <= 0 and var_421_12 or var_421_12 * (var_421_17 / var_421_16)

				if var_421_18 > 0 and var_421_12 < var_421_18 then
					arg_418_1.talkMaxDuration = var_421_18

					if var_421_18 + var_421_11 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_18 + var_421_11
					end
				end

				arg_418_1.text_.text = var_421_15
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011104", "story_v_out_426011.awb") ~= 0 then
					local var_421_19 = manager.audio:GetVoiceLength("story_v_out_426011", "426011104", "story_v_out_426011.awb") / 1000

					if var_421_19 + var_421_11 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_19 + var_421_11
					end

					if var_421_14.prefab_name ~= "" and arg_418_1.actors_[var_421_14.prefab_name] ~= nil then
						local var_421_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_14.prefab_name].transform, "story_v_out_426011", "426011104", "story_v_out_426011.awb")

						arg_418_1:RecordAudio("426011104", var_421_20)
						arg_418_1:RecordAudio("426011104", var_421_20)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_426011", "426011104", "story_v_out_426011.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_426011", "426011104", "story_v_out_426011.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_21 = math.max(var_421_12, arg_418_1.talkMaxDuration)

			if var_421_11 <= arg_418_1.time_ and arg_418_1.time_ < var_421_11 + var_421_21 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_11) / var_421_21

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_11 + var_421_21 and arg_418_1.time_ < var_421_11 + var_421_21 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play426011105 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 426011105
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play426011106(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1054ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1054ui_story == nil then
				arg_422_1.var_.characterEffect1054ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1054ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1054ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1054ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1054ui_story.fillRatio = var_425_5
			end

			local var_425_6 = arg_422_1.actors_["6148ui_story"]
			local var_425_7 = 0

			if var_425_7 < arg_422_1.time_ and arg_422_1.time_ <= var_425_7 + arg_425_0 and not isNil(var_425_6) and arg_422_1.var_.characterEffect6148ui_story == nil then
				arg_422_1.var_.characterEffect6148ui_story = var_425_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_8 = 0.200000002980232

			if var_425_7 <= arg_422_1.time_ and arg_422_1.time_ < var_425_7 + var_425_8 and not isNil(var_425_6) then
				local var_425_9 = (arg_422_1.time_ - var_425_7) / var_425_8

				if arg_422_1.var_.characterEffect6148ui_story and not isNil(var_425_6) then
					local var_425_10 = Mathf.Lerp(0, 0.5, var_425_9)

					arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_422_1.var_.characterEffect6148ui_story.fillRatio = var_425_10
				end
			end

			if arg_422_1.time_ >= var_425_7 + var_425_8 and arg_422_1.time_ < var_425_7 + var_425_8 + arg_425_0 and not isNil(var_425_6) and arg_422_1.var_.characterEffect6148ui_story then
				local var_425_11 = 0.5

				arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_422_1.var_.characterEffect6148ui_story.fillRatio = var_425_11
			end

			local var_425_12 = 0
			local var_425_13 = 0.1

			if var_425_12 < arg_422_1.time_ and arg_422_1.time_ <= var_425_12 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_14 = arg_422_1:FormatText(StoryNameCfg[7].name)

				arg_422_1.leftNameTxt_.text = var_425_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_15 = arg_422_1:GetWordFromCfg(426011105)
				local var_425_16 = arg_422_1:FormatText(var_425_15.content)

				arg_422_1.text_.text = var_425_16

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_17 = 4
				local var_425_18 = utf8.len(var_425_16)
				local var_425_19 = var_425_17 <= 0 and var_425_13 or var_425_13 * (var_425_18 / var_425_17)

				if var_425_19 > 0 and var_425_13 < var_425_19 then
					arg_422_1.talkMaxDuration = var_425_19

					if var_425_19 + var_425_12 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_19 + var_425_12
					end
				end

				arg_422_1.text_.text = var_425_16
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_20 = math.max(var_425_13, arg_422_1.talkMaxDuration)

			if var_425_12 <= arg_422_1.time_ and arg_422_1.time_ < var_425_12 + var_425_20 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_12) / var_425_20

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_12 + var_425_20 and arg_422_1.time_ < var_425_12 + var_425_20 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play426011106 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 426011106
		arg_426_1.duration_ = 3.3

		local var_426_0 = {
			zh = 3.2,
			ja = 3.3
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play426011107(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["6148ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos6148ui_story = var_429_0.localPosition

				local var_429_2 = GameObjectTools.GetOrAddComponent(var_429_0.gameObject, typeof(DynamicBoneHelper))

				if var_429_2 then
					var_429_2:EnableDynamicBone(false)
				end
			end

			local var_429_3 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_3 then
				local var_429_4 = (arg_426_1.time_ - var_429_1) / var_429_3
				local var_429_5 = Vector3.New(-0.7, -0.985, -6)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos6148ui_story, var_429_5, var_429_4)

				local var_429_6 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_6.x, var_429_6.y, var_429_6.z)

				local var_429_7 = var_429_0.localEulerAngles

				var_429_7.z = 0
				var_429_7.x = 0
				var_429_0.localEulerAngles = var_429_7
			end

			if arg_426_1.time_ >= var_429_1 + var_429_3 and arg_426_1.time_ < var_429_1 + var_429_3 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_429_8 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_8.x, var_429_8.y, var_429_8.z)

				local var_429_9 = var_429_0.localEulerAngles

				var_429_9.z = 0
				var_429_9.x = 0
				var_429_0.localEulerAngles = var_429_9

				local var_429_10 = GameObjectTools.GetOrAddComponent(var_429_0.gameObject, typeof(DynamicBoneHelper))

				if var_429_10 then
					var_429_10:EnableDynamicBone(true)
				end
			end

			local var_429_11 = arg_426_1.actors_["6148ui_story"]
			local var_429_12 = 0

			if var_429_12 < arg_426_1.time_ and arg_426_1.time_ <= var_429_12 + arg_429_0 and not isNil(var_429_11) and arg_426_1.var_.characterEffect6148ui_story == nil then
				arg_426_1.var_.characterEffect6148ui_story = var_429_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_13 = 0.200000002980232

			if var_429_12 <= arg_426_1.time_ and arg_426_1.time_ < var_429_12 + var_429_13 and not isNil(var_429_11) then
				local var_429_14 = (arg_426_1.time_ - var_429_12) / var_429_13

				if arg_426_1.var_.characterEffect6148ui_story and not isNil(var_429_11) then
					arg_426_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_12 + var_429_13 and arg_426_1.time_ < var_429_12 + var_429_13 + arg_429_0 and not isNil(var_429_11) and arg_426_1.var_.characterEffect6148ui_story then
				arg_426_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_429_15 = 0

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 then
				arg_426_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_429_16 = 0

			if var_429_16 < arg_426_1.time_ and arg_426_1.time_ <= var_429_16 + arg_429_0 then
				arg_426_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_429_17 = 0
			local var_429_18 = 0.375

			if var_429_17 < arg_426_1.time_ and arg_426_1.time_ <= var_429_17 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_19 = arg_426_1:FormatText(StoryNameCfg[1488].name)

				arg_426_1.leftNameTxt_.text = var_429_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_20 = arg_426_1:GetWordFromCfg(426011106)
				local var_429_21 = arg_426_1:FormatText(var_429_20.content)

				arg_426_1.text_.text = var_429_21

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_22 = 15
				local var_429_23 = utf8.len(var_429_21)
				local var_429_24 = var_429_22 <= 0 and var_429_18 or var_429_18 * (var_429_23 / var_429_22)

				if var_429_24 > 0 and var_429_18 < var_429_24 then
					arg_426_1.talkMaxDuration = var_429_24

					if var_429_24 + var_429_17 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_24 + var_429_17
					end
				end

				arg_426_1.text_.text = var_429_21
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011106", "story_v_out_426011.awb") ~= 0 then
					local var_429_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011106", "story_v_out_426011.awb") / 1000

					if var_429_25 + var_429_17 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_25 + var_429_17
					end

					if var_429_20.prefab_name ~= "" and arg_426_1.actors_[var_429_20.prefab_name] ~= nil then
						local var_429_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_20.prefab_name].transform, "story_v_out_426011", "426011106", "story_v_out_426011.awb")

						arg_426_1:RecordAudio("426011106", var_429_26)
						arg_426_1:RecordAudio("426011106", var_429_26)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_426011", "426011106", "story_v_out_426011.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_426011", "426011106", "story_v_out_426011.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_27 = math.max(var_429_18, arg_426_1.talkMaxDuration)

			if var_429_17 <= arg_426_1.time_ and arg_426_1.time_ < var_429_17 + var_429_27 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_17) / var_429_27

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_17 + var_429_27 and arg_426_1.time_ < var_429_17 + var_429_27 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play426011107 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 426011107
		arg_430_1.duration_ = 7.87

		local var_430_0 = {
			zh = 7.3,
			ja = 7.866
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play426011108(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["6148ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos6148ui_story = var_433_0.localPosition

				local var_433_2 = GameObjectTools.GetOrAddComponent(var_433_0.gameObject, typeof(DynamicBoneHelper))

				if var_433_2 then
					var_433_2:EnableDynamicBone(false)
				end
			end

			local var_433_3 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_3 then
				local var_433_4 = (arg_430_1.time_ - var_433_1) / var_433_3
				local var_433_5 = Vector3.New(-0.7, -0.985, -6)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos6148ui_story, var_433_5, var_433_4)

				local var_433_6 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_6.x, var_433_6.y, var_433_6.z)

				local var_433_7 = var_433_0.localEulerAngles

				var_433_7.z = 0
				var_433_7.x = 0
				var_433_0.localEulerAngles = var_433_7
			end

			if arg_430_1.time_ >= var_433_1 + var_433_3 and arg_430_1.time_ < var_433_1 + var_433_3 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_433_8 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_8.x, var_433_8.y, var_433_8.z)

				local var_433_9 = var_433_0.localEulerAngles

				var_433_9.z = 0
				var_433_9.x = 0
				var_433_0.localEulerAngles = var_433_9

				local var_433_10 = GameObjectTools.GetOrAddComponent(var_433_0.gameObject, typeof(DynamicBoneHelper))

				if var_433_10 then
					var_433_10:EnableDynamicBone(true)
				end
			end

			local var_433_11 = 0

			if var_433_11 < arg_430_1.time_ and arg_430_1.time_ <= var_433_11 + arg_433_0 then
				arg_430_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_433_12 = 0
			local var_433_13 = 1

			if var_433_12 < arg_430_1.time_ and arg_430_1.time_ <= var_433_12 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_14 = arg_430_1:FormatText(StoryNameCfg[1488].name)

				arg_430_1.leftNameTxt_.text = var_433_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_15 = arg_430_1:GetWordFromCfg(426011107)
				local var_433_16 = arg_430_1:FormatText(var_433_15.content)

				arg_430_1.text_.text = var_433_16

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_17 = 38
				local var_433_18 = utf8.len(var_433_16)
				local var_433_19 = var_433_17 <= 0 and var_433_13 or var_433_13 * (var_433_18 / var_433_17)

				if var_433_19 > 0 and var_433_13 < var_433_19 then
					arg_430_1.talkMaxDuration = var_433_19

					if var_433_19 + var_433_12 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_19 + var_433_12
					end
				end

				arg_430_1.text_.text = var_433_16
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011107", "story_v_out_426011.awb") ~= 0 then
					local var_433_20 = manager.audio:GetVoiceLength("story_v_out_426011", "426011107", "story_v_out_426011.awb") / 1000

					if var_433_20 + var_433_12 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_20 + var_433_12
					end

					if var_433_15.prefab_name ~= "" and arg_430_1.actors_[var_433_15.prefab_name] ~= nil then
						local var_433_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_15.prefab_name].transform, "story_v_out_426011", "426011107", "story_v_out_426011.awb")

						arg_430_1:RecordAudio("426011107", var_433_21)
						arg_430_1:RecordAudio("426011107", var_433_21)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_426011", "426011107", "story_v_out_426011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_426011", "426011107", "story_v_out_426011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_22 = math.max(var_433_13, arg_430_1.talkMaxDuration)

			if var_433_12 <= arg_430_1.time_ and arg_430_1.time_ < var_433_12 + var_433_22 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_12) / var_433_22

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_12 + var_433_22 and arg_430_1.time_ < var_433_12 + var_433_22 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play426011108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 426011108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play426011109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["6148ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect6148ui_story == nil then
				arg_434_1.var_.characterEffect6148ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect6148ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_434_1.var_.characterEffect6148ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect6148ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_434_1.var_.characterEffect6148ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 0.3

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_9 = arg_434_1:GetWordFromCfg(426011108)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 12
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_14 and arg_434_1.time_ < var_437_6 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play426011109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 426011109
		arg_438_1.duration_ = 2

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play426011110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1054ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1054ui_story = var_441_0.localPosition

				local var_441_2 = GameObjectTools.GetOrAddComponent(var_441_0.gameObject, typeof(DynamicBoneHelper))

				if var_441_2 then
					var_441_2:EnableDynamicBone(false)
				end
			end

			local var_441_3 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_3 then
				local var_441_4 = (arg_438_1.time_ - var_441_1) / var_441_3
				local var_441_5 = Vector3.New(0.7, -0.985, -6)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1054ui_story, var_441_5, var_441_4)

				local var_441_6 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_6.x, var_441_6.y, var_441_6.z)

				local var_441_7 = var_441_0.localEulerAngles

				var_441_7.z = 0
				var_441_7.x = 0
				var_441_0.localEulerAngles = var_441_7
			end

			if arg_438_1.time_ >= var_441_1 + var_441_3 and arg_438_1.time_ < var_441_1 + var_441_3 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_441_8 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_8.x, var_441_8.y, var_441_8.z)

				local var_441_9 = var_441_0.localEulerAngles

				var_441_9.z = 0
				var_441_9.x = 0
				var_441_0.localEulerAngles = var_441_9

				local var_441_10 = GameObjectTools.GetOrAddComponent(var_441_0.gameObject, typeof(DynamicBoneHelper))

				if var_441_10 then
					var_441_10:EnableDynamicBone(true)
				end
			end

			local var_441_11 = arg_438_1.actors_["1054ui_story"]
			local var_441_12 = 0

			if var_441_12 < arg_438_1.time_ and arg_438_1.time_ <= var_441_12 + arg_441_0 and not isNil(var_441_11) and arg_438_1.var_.characterEffect1054ui_story == nil then
				arg_438_1.var_.characterEffect1054ui_story = var_441_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_13 = 0.200000002980232

			if var_441_12 <= arg_438_1.time_ and arg_438_1.time_ < var_441_12 + var_441_13 and not isNil(var_441_11) then
				local var_441_14 = (arg_438_1.time_ - var_441_12) / var_441_13

				if arg_438_1.var_.characterEffect1054ui_story and not isNil(var_441_11) then
					arg_438_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_12 + var_441_13 and arg_438_1.time_ < var_441_12 + var_441_13 + arg_441_0 and not isNil(var_441_11) and arg_438_1.var_.characterEffect1054ui_story then
				arg_438_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_441_15 = 0

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_441_16 = 0

			if var_441_16 < arg_438_1.time_ and arg_438_1.time_ <= var_441_16 + arg_441_0 then
				arg_438_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_441_17 = 0
			local var_441_18 = 0.1

			if var_441_17 < arg_438_1.time_ and arg_438_1.time_ <= var_441_17 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_19 = arg_438_1:FormatText(StoryNameCfg[1487].name)

				arg_438_1.leftNameTxt_.text = var_441_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_20 = arg_438_1:GetWordFromCfg(426011109)
				local var_441_21 = arg_438_1:FormatText(var_441_20.content)

				arg_438_1.text_.text = var_441_21

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_22 = 4
				local var_441_23 = utf8.len(var_441_21)
				local var_441_24 = var_441_22 <= 0 and var_441_18 or var_441_18 * (var_441_23 / var_441_22)

				if var_441_24 > 0 and var_441_18 < var_441_24 then
					arg_438_1.talkMaxDuration = var_441_24

					if var_441_24 + var_441_17 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_24 + var_441_17
					end
				end

				arg_438_1.text_.text = var_441_21
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011109", "story_v_out_426011.awb") ~= 0 then
					local var_441_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011109", "story_v_out_426011.awb") / 1000

					if var_441_25 + var_441_17 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_25 + var_441_17
					end

					if var_441_20.prefab_name ~= "" and arg_438_1.actors_[var_441_20.prefab_name] ~= nil then
						local var_441_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_20.prefab_name].transform, "story_v_out_426011", "426011109", "story_v_out_426011.awb")

						arg_438_1:RecordAudio("426011109", var_441_26)
						arg_438_1:RecordAudio("426011109", var_441_26)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_426011", "426011109", "story_v_out_426011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_426011", "426011109", "story_v_out_426011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_27 = math.max(var_441_18, arg_438_1.talkMaxDuration)

			if var_441_17 <= arg_438_1.time_ and arg_438_1.time_ < var_441_17 + var_441_27 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_17) / var_441_27

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_17 + var_441_27 and arg_438_1.time_ < var_441_17 + var_441_27 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play426011110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 426011110
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play426011111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1054ui_story"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1054ui_story == nil then
				arg_442_1.var_.characterEffect1054ui_story = var_445_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.characterEffect1054ui_story and not isNil(var_445_0) then
					local var_445_4 = Mathf.Lerp(0, 0.5, var_445_3)

					arg_442_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1054ui_story.fillRatio = var_445_4
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1054ui_story then
				local var_445_5 = 0.5

				arg_442_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1054ui_story.fillRatio = var_445_5
			end

			local var_445_6 = 0
			local var_445_7 = 0.725

			if var_445_6 < arg_442_1.time_ and arg_442_1.time_ <= var_445_6 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_8 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_9 = arg_442_1:GetWordFromCfg(426011110)
				local var_445_10 = arg_442_1:FormatText(var_445_9.content)

				arg_442_1.text_.text = var_445_10

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_11 = 29
				local var_445_12 = utf8.len(var_445_10)
				local var_445_13 = var_445_11 <= 0 and var_445_7 or var_445_7 * (var_445_12 / var_445_11)

				if var_445_13 > 0 and var_445_7 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_6 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_6
					end
				end

				arg_442_1.text_.text = var_445_10
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_14 = math.max(var_445_7, arg_442_1.talkMaxDuration)

			if var_445_6 <= arg_442_1.time_ and arg_442_1.time_ < var_445_6 + var_445_14 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_6) / var_445_14

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_6 + var_445_14 and arg_442_1.time_ < var_445_6 + var_445_14 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play426011111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 426011111
		arg_446_1.duration_ = 7.33

		local var_446_0 = {
			zh = 6.133,
			ja = 7.333
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play426011112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["6148ui_story"].transform
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.var_.moveOldPos6148ui_story = var_449_0.localPosition

				local var_449_2 = GameObjectTools.GetOrAddComponent(var_449_0.gameObject, typeof(DynamicBoneHelper))

				if var_449_2 then
					var_449_2:EnableDynamicBone(false)
				end
			end

			local var_449_3 = 0.001

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_3 then
				local var_449_4 = (arg_446_1.time_ - var_449_1) / var_449_3
				local var_449_5 = Vector3.New(-0.7, -0.985, -6)

				var_449_0.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos6148ui_story, var_449_5, var_449_4)

				local var_449_6 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_6.x, var_449_6.y, var_449_6.z)

				local var_449_7 = var_449_0.localEulerAngles

				var_449_7.z = 0
				var_449_7.x = 0
				var_449_0.localEulerAngles = var_449_7
			end

			if arg_446_1.time_ >= var_449_1 + var_449_3 and arg_446_1.time_ < var_449_1 + var_449_3 + arg_449_0 then
				var_449_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_449_8 = manager.ui.mainCamera.transform.position - var_449_0.position

				var_449_0.forward = Vector3.New(var_449_8.x, var_449_8.y, var_449_8.z)

				local var_449_9 = var_449_0.localEulerAngles

				var_449_9.z = 0
				var_449_9.x = 0
				var_449_0.localEulerAngles = var_449_9

				local var_449_10 = GameObjectTools.GetOrAddComponent(var_449_0.gameObject, typeof(DynamicBoneHelper))

				if var_449_10 then
					var_449_10:EnableDynamicBone(true)
				end
			end

			local var_449_11 = arg_446_1.actors_["6148ui_story"]
			local var_449_12 = 0

			if var_449_12 < arg_446_1.time_ and arg_446_1.time_ <= var_449_12 + arg_449_0 and not isNil(var_449_11) and arg_446_1.var_.characterEffect6148ui_story == nil then
				arg_446_1.var_.characterEffect6148ui_story = var_449_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_13 = 0.200000002980232

			if var_449_12 <= arg_446_1.time_ and arg_446_1.time_ < var_449_12 + var_449_13 and not isNil(var_449_11) then
				local var_449_14 = (arg_446_1.time_ - var_449_12) / var_449_13

				if arg_446_1.var_.characterEffect6148ui_story and not isNil(var_449_11) then
					arg_446_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_12 + var_449_13 and arg_446_1.time_ < var_449_12 + var_449_13 + arg_449_0 and not isNil(var_449_11) and arg_446_1.var_.characterEffect6148ui_story then
				arg_446_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_449_15 = 0

			if var_449_15 < arg_446_1.time_ and arg_446_1.time_ <= var_449_15 + arg_449_0 then
				arg_446_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_449_16 = 0

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_449_17 = 0
			local var_449_18 = 0.7

			if var_449_17 < arg_446_1.time_ and arg_446_1.time_ <= var_449_17 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_19 = arg_446_1:FormatText(StoryNameCfg[1488].name)

				arg_446_1.leftNameTxt_.text = var_449_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_20 = arg_446_1:GetWordFromCfg(426011111)
				local var_449_21 = arg_446_1:FormatText(var_449_20.content)

				arg_446_1.text_.text = var_449_21

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_22 = 28
				local var_449_23 = utf8.len(var_449_21)
				local var_449_24 = var_449_22 <= 0 and var_449_18 or var_449_18 * (var_449_23 / var_449_22)

				if var_449_24 > 0 and var_449_18 < var_449_24 then
					arg_446_1.talkMaxDuration = var_449_24

					if var_449_24 + var_449_17 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_24 + var_449_17
					end
				end

				arg_446_1.text_.text = var_449_21
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011111", "story_v_out_426011.awb") ~= 0 then
					local var_449_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011111", "story_v_out_426011.awb") / 1000

					if var_449_25 + var_449_17 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_25 + var_449_17
					end

					if var_449_20.prefab_name ~= "" and arg_446_1.actors_[var_449_20.prefab_name] ~= nil then
						local var_449_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_20.prefab_name].transform, "story_v_out_426011", "426011111", "story_v_out_426011.awb")

						arg_446_1:RecordAudio("426011111", var_449_26)
						arg_446_1:RecordAudio("426011111", var_449_26)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_426011", "426011111", "story_v_out_426011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_426011", "426011111", "story_v_out_426011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_27 = math.max(var_449_18, arg_446_1.talkMaxDuration)

			if var_449_17 <= arg_446_1.time_ and arg_446_1.time_ < var_449_17 + var_449_27 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_17) / var_449_27

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_17 + var_449_27 and arg_446_1.time_ < var_449_17 + var_449_27 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play426011112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 426011112
		arg_450_1.duration_ = 2.03

		local var_450_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play426011113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1054ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos1054ui_story = var_453_0.localPosition

				local var_453_2 = GameObjectTools.GetOrAddComponent(var_453_0.gameObject, typeof(DynamicBoneHelper))

				if var_453_2 then
					var_453_2:EnableDynamicBone(false)
				end
			end

			local var_453_3 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_3 then
				local var_453_4 = (arg_450_1.time_ - var_453_1) / var_453_3
				local var_453_5 = Vector3.New(0.7, -0.985, -6)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1054ui_story, var_453_5, var_453_4)

				local var_453_6 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_6.x, var_453_6.y, var_453_6.z)

				local var_453_7 = var_453_0.localEulerAngles

				var_453_7.z = 0
				var_453_7.x = 0
				var_453_0.localEulerAngles = var_453_7
			end

			if arg_450_1.time_ >= var_453_1 + var_453_3 and arg_450_1.time_ < var_453_1 + var_453_3 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_453_8 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_8.x, var_453_8.y, var_453_8.z)

				local var_453_9 = var_453_0.localEulerAngles

				var_453_9.z = 0
				var_453_9.x = 0
				var_453_0.localEulerAngles = var_453_9

				local var_453_10 = GameObjectTools.GetOrAddComponent(var_453_0.gameObject, typeof(DynamicBoneHelper))

				if var_453_10 then
					var_453_10:EnableDynamicBone(true)
				end
			end

			local var_453_11 = arg_450_1.actors_["1054ui_story"]
			local var_453_12 = 0

			if var_453_12 < arg_450_1.time_ and arg_450_1.time_ <= var_453_12 + arg_453_0 and not isNil(var_453_11) and arg_450_1.var_.characterEffect1054ui_story == nil then
				arg_450_1.var_.characterEffect1054ui_story = var_453_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_13 = 0.200000002980232

			if var_453_12 <= arg_450_1.time_ and arg_450_1.time_ < var_453_12 + var_453_13 and not isNil(var_453_11) then
				local var_453_14 = (arg_450_1.time_ - var_453_12) / var_453_13

				if arg_450_1.var_.characterEffect1054ui_story and not isNil(var_453_11) then
					arg_450_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_12 + var_453_13 and arg_450_1.time_ < var_453_12 + var_453_13 + arg_453_0 and not isNil(var_453_11) and arg_450_1.var_.characterEffect1054ui_story then
				arg_450_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_453_15 = arg_450_1.actors_["6148ui_story"]
			local var_453_16 = 0

			if var_453_16 < arg_450_1.time_ and arg_450_1.time_ <= var_453_16 + arg_453_0 and not isNil(var_453_15) and arg_450_1.var_.characterEffect6148ui_story == nil then
				arg_450_1.var_.characterEffect6148ui_story = var_453_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_17 = 0.200000002980232

			if var_453_16 <= arg_450_1.time_ and arg_450_1.time_ < var_453_16 + var_453_17 and not isNil(var_453_15) then
				local var_453_18 = (arg_450_1.time_ - var_453_16) / var_453_17

				if arg_450_1.var_.characterEffect6148ui_story and not isNil(var_453_15) then
					local var_453_19 = Mathf.Lerp(0, 0.5, var_453_18)

					arg_450_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_450_1.var_.characterEffect6148ui_story.fillRatio = var_453_19
				end
			end

			if arg_450_1.time_ >= var_453_16 + var_453_17 and arg_450_1.time_ < var_453_16 + var_453_17 + arg_453_0 and not isNil(var_453_15) and arg_450_1.var_.characterEffect6148ui_story then
				local var_453_20 = 0.5

				arg_450_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_450_1.var_.characterEffect6148ui_story.fillRatio = var_453_20
			end

			local var_453_21 = 0

			if var_453_21 < arg_450_1.time_ and arg_450_1.time_ <= var_453_21 + arg_453_0 then
				arg_450_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_453_22 = 0

			if var_453_22 < arg_450_1.time_ and arg_450_1.time_ <= var_453_22 + arg_453_0 then
				arg_450_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_453_23 = 0
			local var_453_24 = 0.075

			if var_453_23 < arg_450_1.time_ and arg_450_1.time_ <= var_453_23 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_25 = arg_450_1:FormatText(StoryNameCfg[1487].name)

				arg_450_1.leftNameTxt_.text = var_453_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_26 = arg_450_1:GetWordFromCfg(426011112)
				local var_453_27 = arg_450_1:FormatText(var_453_26.content)

				arg_450_1.text_.text = var_453_27

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_28 = 3
				local var_453_29 = utf8.len(var_453_27)
				local var_453_30 = var_453_28 <= 0 and var_453_24 or var_453_24 * (var_453_29 / var_453_28)

				if var_453_30 > 0 and var_453_24 < var_453_30 then
					arg_450_1.talkMaxDuration = var_453_30

					if var_453_30 + var_453_23 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_30 + var_453_23
					end
				end

				arg_450_1.text_.text = var_453_27
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011112", "story_v_out_426011.awb") ~= 0 then
					local var_453_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011112", "story_v_out_426011.awb") / 1000

					if var_453_31 + var_453_23 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_31 + var_453_23
					end

					if var_453_26.prefab_name ~= "" and arg_450_1.actors_[var_453_26.prefab_name] ~= nil then
						local var_453_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_26.prefab_name].transform, "story_v_out_426011", "426011112", "story_v_out_426011.awb")

						arg_450_1:RecordAudio("426011112", var_453_32)
						arg_450_1:RecordAudio("426011112", var_453_32)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_426011", "426011112", "story_v_out_426011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_426011", "426011112", "story_v_out_426011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_33 = math.max(var_453_24, arg_450_1.talkMaxDuration)

			if var_453_23 <= arg_450_1.time_ and arg_450_1.time_ < var_453_23 + var_453_33 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_23) / var_453_33

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_23 + var_453_33 and arg_450_1.time_ < var_453_23 + var_453_33 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play426011113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 426011113
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play426011114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1054ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1054ui_story == nil then
				arg_454_1.var_.characterEffect1054ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1054ui_story and not isNil(var_457_0) then
					local var_457_4 = Mathf.Lerp(0, 0.5, var_457_3)

					arg_454_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1054ui_story.fillRatio = var_457_4
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1054ui_story then
				local var_457_5 = 0.5

				arg_454_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1054ui_story.fillRatio = var_457_5
			end

			local var_457_6 = 0
			local var_457_7 = 0.575

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_8 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_9 = arg_454_1:GetWordFromCfg(426011113)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 23
				local var_457_12 = utf8.len(var_457_10)
				local var_457_13 = var_457_11 <= 0 and var_457_7 or var_457_7 * (var_457_12 / var_457_11)

				if var_457_13 > 0 and var_457_7 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_14 and arg_454_1.time_ < var_457_6 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play426011114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 426011114
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play426011115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_461_2 = 0
			local var_461_3 = 0.95

			if var_461_2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:GetWordFromCfg(426011114)
				local var_461_5 = arg_458_1:FormatText(var_461_4.content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 38
				local var_461_7 = utf8.len(var_461_5)
				local var_461_8 = var_461_6 <= 0 and var_461_3 or var_461_3 * (var_461_7 / var_461_6)

				if var_461_8 > 0 and var_461_3 < var_461_8 then
					arg_458_1.talkMaxDuration = var_461_8

					if var_461_8 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_9 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_9 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_9

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_9 and arg_458_1.time_ < var_461_2 + var_461_9 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play426011115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 426011115
		arg_462_1.duration_ = 4.83

		local var_462_0 = {
			zh = 4,
			ja = 4.833
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play426011116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1054ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos1054ui_story = var_465_0.localPosition

				local var_465_2 = GameObjectTools.GetOrAddComponent(var_465_0.gameObject, typeof(DynamicBoneHelper))

				if var_465_2 then
					var_465_2:EnableDynamicBone(false)
				end
			end

			local var_465_3 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_3 then
				local var_465_4 = (arg_462_1.time_ - var_465_1) / var_465_3
				local var_465_5 = Vector3.New(0.7, -0.985, -6)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1054ui_story, var_465_5, var_465_4)

				local var_465_6 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_6.x, var_465_6.y, var_465_6.z)

				local var_465_7 = var_465_0.localEulerAngles

				var_465_7.z = 0
				var_465_7.x = 0
				var_465_0.localEulerAngles = var_465_7
			end

			if arg_462_1.time_ >= var_465_1 + var_465_3 and arg_462_1.time_ < var_465_1 + var_465_3 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_465_8 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_8.x, var_465_8.y, var_465_8.z)

				local var_465_9 = var_465_0.localEulerAngles

				var_465_9.z = 0
				var_465_9.x = 0
				var_465_0.localEulerAngles = var_465_9

				local var_465_10 = GameObjectTools.GetOrAddComponent(var_465_0.gameObject, typeof(DynamicBoneHelper))

				if var_465_10 then
					var_465_10:EnableDynamicBone(true)
				end
			end

			local var_465_11 = arg_462_1.actors_["1054ui_story"]
			local var_465_12 = 0

			if var_465_12 < arg_462_1.time_ and arg_462_1.time_ <= var_465_12 + arg_465_0 and not isNil(var_465_11) and arg_462_1.var_.characterEffect1054ui_story == nil then
				arg_462_1.var_.characterEffect1054ui_story = var_465_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_13 = 0.200000002980232

			if var_465_12 <= arg_462_1.time_ and arg_462_1.time_ < var_465_12 + var_465_13 and not isNil(var_465_11) then
				local var_465_14 = (arg_462_1.time_ - var_465_12) / var_465_13

				if arg_462_1.var_.characterEffect1054ui_story and not isNil(var_465_11) then
					arg_462_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_12 + var_465_13 and arg_462_1.time_ < var_465_12 + var_465_13 + arg_465_0 and not isNil(var_465_11) and arg_462_1.var_.characterEffect1054ui_story then
				arg_462_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_465_15 = 0

			if var_465_15 < arg_462_1.time_ and arg_462_1.time_ <= var_465_15 + arg_465_0 then
				arg_462_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_465_16 = 0

			if var_465_16 < arg_462_1.time_ and arg_462_1.time_ <= var_465_16 + arg_465_0 then
				arg_462_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_465_17 = 0
			local var_465_18 = 0.25

			if var_465_17 < arg_462_1.time_ and arg_462_1.time_ <= var_465_17 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_19 = arg_462_1:FormatText(StoryNameCfg[1487].name)

				arg_462_1.leftNameTxt_.text = var_465_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_20 = arg_462_1:GetWordFromCfg(426011115)
				local var_465_21 = arg_462_1:FormatText(var_465_20.content)

				arg_462_1.text_.text = var_465_21

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_22 = 10
				local var_465_23 = utf8.len(var_465_21)
				local var_465_24 = var_465_22 <= 0 and var_465_18 or var_465_18 * (var_465_23 / var_465_22)

				if var_465_24 > 0 and var_465_18 < var_465_24 then
					arg_462_1.talkMaxDuration = var_465_24

					if var_465_24 + var_465_17 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_24 + var_465_17
					end
				end

				arg_462_1.text_.text = var_465_21
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011115", "story_v_out_426011.awb") ~= 0 then
					local var_465_25 = manager.audio:GetVoiceLength("story_v_out_426011", "426011115", "story_v_out_426011.awb") / 1000

					if var_465_25 + var_465_17 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_25 + var_465_17
					end

					if var_465_20.prefab_name ~= "" and arg_462_1.actors_[var_465_20.prefab_name] ~= nil then
						local var_465_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_20.prefab_name].transform, "story_v_out_426011", "426011115", "story_v_out_426011.awb")

						arg_462_1:RecordAudio("426011115", var_465_26)
						arg_462_1:RecordAudio("426011115", var_465_26)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_426011", "426011115", "story_v_out_426011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_426011", "426011115", "story_v_out_426011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_27 = math.max(var_465_18, arg_462_1.talkMaxDuration)

			if var_465_17 <= arg_462_1.time_ and arg_462_1.time_ < var_465_17 + var_465_27 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_17) / var_465_27

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_17 + var_465_27 and arg_462_1.time_ < var_465_17 + var_465_27 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play426011116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 426011116
		arg_466_1.duration_ = 9.53

		local var_466_0 = {
			zh = 6.833,
			ja = 9.533
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play426011117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["6148ui_story"].transform
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.var_.moveOldPos6148ui_story = var_469_0.localPosition

				local var_469_2 = GameObjectTools.GetOrAddComponent(var_469_0.gameObject, typeof(DynamicBoneHelper))

				if var_469_2 then
					var_469_2:EnableDynamicBone(false)
				end
			end

			local var_469_3 = 0.001

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_3 then
				local var_469_4 = (arg_466_1.time_ - var_469_1) / var_469_3
				local var_469_5 = Vector3.New(-0.7, -0.985, -6)

				var_469_0.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos6148ui_story, var_469_5, var_469_4)

				local var_469_6 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_6.x, var_469_6.y, var_469_6.z)

				local var_469_7 = var_469_0.localEulerAngles

				var_469_7.z = 0
				var_469_7.x = 0
				var_469_0.localEulerAngles = var_469_7
			end

			if arg_466_1.time_ >= var_469_1 + var_469_3 and arg_466_1.time_ < var_469_1 + var_469_3 + arg_469_0 then
				var_469_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_469_8 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_8.x, var_469_8.y, var_469_8.z)

				local var_469_9 = var_469_0.localEulerAngles

				var_469_9.z = 0
				var_469_9.x = 0
				var_469_0.localEulerAngles = var_469_9

				local var_469_10 = GameObjectTools.GetOrAddComponent(var_469_0.gameObject, typeof(DynamicBoneHelper))

				if var_469_10 then
					var_469_10:EnableDynamicBone(true)
				end
			end

			local var_469_11 = arg_466_1.actors_["6148ui_story"]
			local var_469_12 = 0

			if var_469_12 < arg_466_1.time_ and arg_466_1.time_ <= var_469_12 + arg_469_0 and not isNil(var_469_11) and arg_466_1.var_.characterEffect6148ui_story == nil then
				arg_466_1.var_.characterEffect6148ui_story = var_469_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_13 = 0.200000002980232

			if var_469_12 <= arg_466_1.time_ and arg_466_1.time_ < var_469_12 + var_469_13 and not isNil(var_469_11) then
				local var_469_14 = (arg_466_1.time_ - var_469_12) / var_469_13

				if arg_466_1.var_.characterEffect6148ui_story and not isNil(var_469_11) then
					arg_466_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_12 + var_469_13 and arg_466_1.time_ < var_469_12 + var_469_13 + arg_469_0 and not isNil(var_469_11) and arg_466_1.var_.characterEffect6148ui_story then
				arg_466_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_469_15 = arg_466_1.actors_["1054ui_story"]
			local var_469_16 = 0

			if var_469_16 < arg_466_1.time_ and arg_466_1.time_ <= var_469_16 + arg_469_0 and not isNil(var_469_15) and arg_466_1.var_.characterEffect1054ui_story == nil then
				arg_466_1.var_.characterEffect1054ui_story = var_469_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_17 = 0.200000002980232

			if var_469_16 <= arg_466_1.time_ and arg_466_1.time_ < var_469_16 + var_469_17 and not isNil(var_469_15) then
				local var_469_18 = (arg_466_1.time_ - var_469_16) / var_469_17

				if arg_466_1.var_.characterEffect1054ui_story and not isNil(var_469_15) then
					local var_469_19 = Mathf.Lerp(0, 0.5, var_469_18)

					arg_466_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1054ui_story.fillRatio = var_469_19
				end
			end

			if arg_466_1.time_ >= var_469_16 + var_469_17 and arg_466_1.time_ < var_469_16 + var_469_17 + arg_469_0 and not isNil(var_469_15) and arg_466_1.var_.characterEffect1054ui_story then
				local var_469_20 = 0.5

				arg_466_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1054ui_story.fillRatio = var_469_20
			end

			local var_469_21 = 0

			if var_469_21 < arg_466_1.time_ and arg_466_1.time_ <= var_469_21 + arg_469_0 then
				arg_466_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_469_22 = 0

			if var_469_22 < arg_466_1.time_ and arg_466_1.time_ <= var_469_22 + arg_469_0 then
				arg_466_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_469_23 = 0
			local var_469_24 = 0.9

			if var_469_23 < arg_466_1.time_ and arg_466_1.time_ <= var_469_23 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_25 = arg_466_1:FormatText(StoryNameCfg[1488].name)

				arg_466_1.leftNameTxt_.text = var_469_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_26 = arg_466_1:GetWordFromCfg(426011116)
				local var_469_27 = arg_466_1:FormatText(var_469_26.content)

				arg_466_1.text_.text = var_469_27

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_28 = 36
				local var_469_29 = utf8.len(var_469_27)
				local var_469_30 = var_469_28 <= 0 and var_469_24 or var_469_24 * (var_469_29 / var_469_28)

				if var_469_30 > 0 and var_469_24 < var_469_30 then
					arg_466_1.talkMaxDuration = var_469_30

					if var_469_30 + var_469_23 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_30 + var_469_23
					end
				end

				arg_466_1.text_.text = var_469_27
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011116", "story_v_out_426011.awb") ~= 0 then
					local var_469_31 = manager.audio:GetVoiceLength("story_v_out_426011", "426011116", "story_v_out_426011.awb") / 1000

					if var_469_31 + var_469_23 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_31 + var_469_23
					end

					if var_469_26.prefab_name ~= "" and arg_466_1.actors_[var_469_26.prefab_name] ~= nil then
						local var_469_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_26.prefab_name].transform, "story_v_out_426011", "426011116", "story_v_out_426011.awb")

						arg_466_1:RecordAudio("426011116", var_469_32)
						arg_466_1:RecordAudio("426011116", var_469_32)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_426011", "426011116", "story_v_out_426011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_426011", "426011116", "story_v_out_426011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_33 = math.max(var_469_24, arg_466_1.talkMaxDuration)

			if var_469_23 <= arg_466_1.time_ and arg_466_1.time_ < var_469_23 + var_469_33 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_23) / var_469_33

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_23 + var_469_33 and arg_466_1.time_ < var_469_23 + var_469_33 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play426011117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 426011117
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play426011118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["6148ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect6148ui_story == nil then
				arg_470_1.var_.characterEffect6148ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect6148ui_story and not isNil(var_473_0) then
					local var_473_4 = Mathf.Lerp(0, 0.5, var_473_3)

					arg_470_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_470_1.var_.characterEffect6148ui_story.fillRatio = var_473_4
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect6148ui_story then
				local var_473_5 = 0.5

				arg_470_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_470_1.var_.characterEffect6148ui_story.fillRatio = var_473_5
			end

			local var_473_6 = 0
			local var_473_7 = 0.625

			if var_473_6 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_8 = arg_470_1:FormatText(StoryNameCfg[7].name)

				arg_470_1.leftNameTxt_.text = var_473_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_9 = arg_470_1:GetWordFromCfg(426011117)
				local var_473_10 = arg_470_1:FormatText(var_473_9.content)

				arg_470_1.text_.text = var_473_10

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_11 = 25
				local var_473_12 = utf8.len(var_473_10)
				local var_473_13 = var_473_11 <= 0 and var_473_7 or var_473_7 * (var_473_12 / var_473_11)

				if var_473_13 > 0 and var_473_7 < var_473_13 then
					arg_470_1.talkMaxDuration = var_473_13

					if var_473_13 + var_473_6 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_13 + var_473_6
					end
				end

				arg_470_1.text_.text = var_473_10
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_14 = math.max(var_473_7, arg_470_1.talkMaxDuration)

			if var_473_6 <= arg_470_1.time_ and arg_470_1.time_ < var_473_6 + var_473_14 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_6) / var_473_14

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_6 + var_473_14 and arg_470_1.time_ < var_473_6 + var_473_14 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play426011118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 426011118
		arg_474_1.duration_ = 2.37

		local var_474_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play426011119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1054ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect1054ui_story == nil then
				arg_474_1.var_.characterEffect1054ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect1054ui_story and not isNil(var_477_0) then
					arg_474_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect1054ui_story then
				arg_474_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_477_4 = arg_474_1.actors_["6148ui_story"]
			local var_477_5 = 0

			if var_477_5 < arg_474_1.time_ and arg_474_1.time_ <= var_477_5 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect6148ui_story == nil then
				arg_474_1.var_.characterEffect6148ui_story = var_477_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_6 = 0.200000002980232

			if var_477_5 <= arg_474_1.time_ and arg_474_1.time_ < var_477_5 + var_477_6 and not isNil(var_477_4) then
				local var_477_7 = (arg_474_1.time_ - var_477_5) / var_477_6

				if arg_474_1.var_.characterEffect6148ui_story and not isNil(var_477_4) then
					arg_474_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_5 + var_477_6 and arg_474_1.time_ < var_477_5 + var_477_6 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect6148ui_story then
				arg_474_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_477_8 = 0

			if var_477_8 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				arg_474_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_477_9 = 0

			if var_477_9 < arg_474_1.time_ and arg_474_1.time_ <= var_477_9 + arg_477_0 then
				arg_474_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 then
				arg_474_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_477_11 = 0
			local var_477_12 = 0.075

			if var_477_11 < arg_474_1.time_ and arg_474_1.time_ <= var_477_11 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_13 = arg_474_1:FormatText(StoryNameCfg[1489].name)

				arg_474_1.leftNameTxt_.text = var_477_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_14 = arg_474_1:GetWordFromCfg(426011118)
				local var_477_15 = arg_474_1:FormatText(var_477_14.content)

				arg_474_1.text_.text = var_477_15

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_16 = 3
				local var_477_17 = utf8.len(var_477_15)
				local var_477_18 = var_477_16 <= 0 and var_477_12 or var_477_12 * (var_477_17 / var_477_16)

				if var_477_18 > 0 and var_477_12 < var_477_18 then
					arg_474_1.talkMaxDuration = var_477_18

					if var_477_18 + var_477_11 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_18 + var_477_11
					end
				end

				arg_474_1.text_.text = var_477_15
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011118", "story_v_out_426011.awb") ~= 0 then
					local var_477_19 = manager.audio:GetVoiceLength("story_v_out_426011", "426011118", "story_v_out_426011.awb") / 1000

					if var_477_19 + var_477_11 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_19 + var_477_11
					end

					if var_477_14.prefab_name ~= "" and arg_474_1.actors_[var_477_14.prefab_name] ~= nil then
						local var_477_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_14.prefab_name].transform, "story_v_out_426011", "426011118", "story_v_out_426011.awb")

						arg_474_1:RecordAudio("426011118", var_477_20)
						arg_474_1:RecordAudio("426011118", var_477_20)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_426011", "426011118", "story_v_out_426011.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_426011", "426011118", "story_v_out_426011.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_21 = math.max(var_477_12, arg_474_1.talkMaxDuration)

			if var_477_11 <= arg_474_1.time_ and arg_474_1.time_ < var_477_11 + var_477_21 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_11) / var_477_21

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_11 + var_477_21 and arg_474_1.time_ < var_477_11 + var_477_21 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play426011119 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 426011119
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
			arg_478_1.auto_ = false
		end

		function arg_478_1.playNext_(arg_480_0)
			arg_478_1.onStoryFinished_()
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1054ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect1054ui_story == nil then
				arg_478_1.var_.characterEffect1054ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect1054ui_story and not isNil(var_481_0) then
					local var_481_4 = Mathf.Lerp(0, 0.5, var_481_3)

					arg_478_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1054ui_story.fillRatio = var_481_4
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect1054ui_story then
				local var_481_5 = 0.5

				arg_478_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1054ui_story.fillRatio = var_481_5
			end

			local var_481_6 = arg_478_1.actors_["6148ui_story"]
			local var_481_7 = 0

			if var_481_7 < arg_478_1.time_ and arg_478_1.time_ <= var_481_7 + arg_481_0 and not isNil(var_481_6) and arg_478_1.var_.characterEffect6148ui_story == nil then
				arg_478_1.var_.characterEffect6148ui_story = var_481_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_8 = 0.200000002980232

			if var_481_7 <= arg_478_1.time_ and arg_478_1.time_ < var_481_7 + var_481_8 and not isNil(var_481_6) then
				local var_481_9 = (arg_478_1.time_ - var_481_7) / var_481_8

				if arg_478_1.var_.characterEffect6148ui_story and not isNil(var_481_6) then
					local var_481_10 = Mathf.Lerp(0, 0.5, var_481_9)

					arg_478_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_478_1.var_.characterEffect6148ui_story.fillRatio = var_481_10
				end
			end

			if arg_478_1.time_ >= var_481_7 + var_481_8 and arg_478_1.time_ < var_481_7 + var_481_8 + arg_481_0 and not isNil(var_481_6) and arg_478_1.var_.characterEffect6148ui_story then
				local var_481_11 = 0.5

				arg_478_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_478_1.var_.characterEffect6148ui_story.fillRatio = var_481_11
			end

			local var_481_12 = 0
			local var_481_13 = 0.225

			if var_481_12 < arg_478_1.time_ and arg_478_1.time_ <= var_481_12 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_14 = arg_478_1:FormatText(StoryNameCfg[7].name)

				arg_478_1.leftNameTxt_.text = var_481_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_15 = arg_478_1:GetWordFromCfg(426011119)
				local var_481_16 = arg_478_1:FormatText(var_481_15.content)

				arg_478_1.text_.text = var_481_16

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_17 = 9
				local var_481_18 = utf8.len(var_481_16)
				local var_481_19 = var_481_17 <= 0 and var_481_13 or var_481_13 * (var_481_18 / var_481_17)

				if var_481_19 > 0 and var_481_13 < var_481_19 then
					arg_478_1.talkMaxDuration = var_481_19

					if var_481_19 + var_481_12 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_19 + var_481_12
					end
				end

				arg_478_1.text_.text = var_481_16
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_20 = math.max(var_481_13, arg_478_1.talkMaxDuration)

			if var_481_12 <= arg_478_1.time_ and arg_478_1.time_ < var_481_12 + var_481_20 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_12) / var_481_20

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_12 + var_481_20 and arg_478_1.time_ < var_481_12 + var_481_20 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play426011060 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 426011060
		arg_482_1.duration_ = 7.47

		local var_482_0 = {
			zh = 7.466,
			ja = 6.5
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play426011061(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1054ui_story"].transform
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.var_.moveOldPos1054ui_story = var_485_0.localPosition

				local var_485_2 = GameObjectTools.GetOrAddComponent(var_485_0.gameObject, typeof(DynamicBoneHelper))

				if var_485_2 then
					var_485_2:EnableDynamicBone(false)
				end
			end

			local var_485_3 = 0.001

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_3 then
				local var_485_4 = (arg_482_1.time_ - var_485_1) / var_485_3
				local var_485_5 = Vector3.New(-0.7, -0.985, -6)

				var_485_0.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos1054ui_story, var_485_5, var_485_4)

				local var_485_6 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_6.x, var_485_6.y, var_485_6.z)

				local var_485_7 = var_485_0.localEulerAngles

				var_485_7.z = 0
				var_485_7.x = 0
				var_485_0.localEulerAngles = var_485_7
			end

			if arg_482_1.time_ >= var_485_1 + var_485_3 and arg_482_1.time_ < var_485_1 + var_485_3 + arg_485_0 then
				var_485_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_485_8 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_8.x, var_485_8.y, var_485_8.z)

				local var_485_9 = var_485_0.localEulerAngles

				var_485_9.z = 0
				var_485_9.x = 0
				var_485_0.localEulerAngles = var_485_9

				local var_485_10 = GameObjectTools.GetOrAddComponent(var_485_0.gameObject, typeof(DynamicBoneHelper))

				if var_485_10 then
					var_485_10:EnableDynamicBone(true)
				end
			end

			local var_485_11 = arg_482_1.actors_["1054ui_story"]
			local var_485_12 = 0

			if var_485_12 < arg_482_1.time_ and arg_482_1.time_ <= var_485_12 + arg_485_0 and not isNil(var_485_11) and arg_482_1.var_.characterEffect1054ui_story == nil then
				arg_482_1.var_.characterEffect1054ui_story = var_485_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_13 = 0.200000002980232

			if var_485_12 <= arg_482_1.time_ and arg_482_1.time_ < var_485_12 + var_485_13 and not isNil(var_485_11) then
				local var_485_14 = (arg_482_1.time_ - var_485_12) / var_485_13

				if arg_482_1.var_.characterEffect1054ui_story and not isNil(var_485_11) then
					arg_482_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_12 + var_485_13 and arg_482_1.time_ < var_485_12 + var_485_13 + arg_485_0 and not isNil(var_485_11) and arg_482_1.var_.characterEffect1054ui_story then
				arg_482_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_485_15 = "1054ui_story"

			if arg_482_1.actors_[var_485_15] == nil then
				local var_485_16 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_485_16) then
					local var_485_17 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_482_1.stage_.transform)

					var_485_17.name = var_485_15
					var_485_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_482_1.actors_[var_485_15] = var_485_17

					local var_485_18 = var_485_17:GetComponentInChildren(typeof(CharacterEffect))

					var_485_18.enabled = true

					local var_485_19 = GameObjectTools.GetOrAddComponent(var_485_17, typeof(DynamicBoneHelper))

					if var_485_19 then
						var_485_19:EnableDynamicBone(false)
					end

					arg_482_1:ShowWeapon(var_485_18.transform, false)

					arg_482_1.var_[var_485_15 .. "Animator"] = var_485_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_482_1.var_[var_485_15 .. "Animator"].applyRootMotion = true
					arg_482_1.var_[var_485_15 .. "LipSync"] = var_485_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_485_20 = 0

			if var_485_20 < arg_482_1.time_ and arg_482_1.time_ <= var_485_20 + arg_485_0 then
				arg_482_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_485_21 = "1054ui_story"

			if arg_482_1.actors_[var_485_21] == nil then
				local var_485_22 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_485_22) then
					local var_485_23 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_482_1.stage_.transform)

					var_485_23.name = var_485_21
					var_485_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_482_1.actors_[var_485_21] = var_485_23

					local var_485_24 = var_485_23:GetComponentInChildren(typeof(CharacterEffect))

					var_485_24.enabled = true

					local var_485_25 = GameObjectTools.GetOrAddComponent(var_485_23, typeof(DynamicBoneHelper))

					if var_485_25 then
						var_485_25:EnableDynamicBone(false)
					end

					arg_482_1:ShowWeapon(var_485_24.transform, false)

					arg_482_1.var_[var_485_21 .. "Animator"] = var_485_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_482_1.var_[var_485_21 .. "Animator"].applyRootMotion = true
					arg_482_1.var_[var_485_21 .. "LipSync"] = var_485_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_485_26 = 0

			if var_485_26 < arg_482_1.time_ and arg_482_1.time_ <= var_485_26 + arg_485_0 then
				arg_482_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_485_27 = 0
			local var_485_28 = 0.65

			if var_485_27 < arg_482_1.time_ and arg_482_1.time_ <= var_485_27 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_29 = arg_482_1:FormatText(StoryNameCfg[1487].name)

				arg_482_1.leftNameTxt_.text = var_485_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_30 = arg_482_1:GetWordFromCfg(426011060)
				local var_485_31 = arg_482_1:FormatText(var_485_30.content)

				arg_482_1.text_.text = var_485_31

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_32 = 26
				local var_485_33 = utf8.len(var_485_31)
				local var_485_34 = var_485_32 <= 0 and var_485_28 or var_485_28 * (var_485_33 / var_485_32)

				if var_485_34 > 0 and var_485_28 < var_485_34 then
					arg_482_1.talkMaxDuration = var_485_34

					if var_485_34 + var_485_27 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_34 + var_485_27
					end
				end

				arg_482_1.text_.text = var_485_31
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426011", "426011060", "story_v_out_426011.awb") ~= 0 then
					local var_485_35 = manager.audio:GetVoiceLength("story_v_out_426011", "426011060", "story_v_out_426011.awb") / 1000

					if var_485_35 + var_485_27 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_35 + var_485_27
					end

					if var_485_30.prefab_name ~= "" and arg_482_1.actors_[var_485_30.prefab_name] ~= nil then
						local var_485_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_30.prefab_name].transform, "story_v_out_426011", "426011060", "story_v_out_426011.awb")

						arg_482_1:RecordAudio("426011060", var_485_36)
						arg_482_1:RecordAudio("426011060", var_485_36)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_426011", "426011060", "story_v_out_426011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_426011", "426011060", "story_v_out_426011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_37 = math.max(var_485_28, arg_482_1.talkMaxDuration)

			if var_485_27 <= arg_482_1.time_ and arg_482_1.time_ < var_485_27 + var_485_37 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_27) / var_485_37

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_27 + var_485_37 and arg_482_1.time_ < var_485_27 + var_485_37 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play426011061 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 426011061
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play426011062(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1054ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1054ui_story == nil then
				arg_486_1.var_.characterEffect1054ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect1054ui_story and not isNil(var_489_0) then
					local var_489_4 = Mathf.Lerp(0, 0.5, var_489_3)

					arg_486_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1054ui_story.fillRatio = var_489_4
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1054ui_story then
				local var_489_5 = 0.5

				arg_486_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1054ui_story.fillRatio = var_489_5
			end

			local var_489_6 = 0
			local var_489_7 = 0.325

			if var_489_6 < arg_486_1.time_ and arg_486_1.time_ <= var_489_6 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_8 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_9 = arg_486_1:GetWordFromCfg(426011061)
				local var_489_10 = arg_486_1:FormatText(var_489_9.content)

				arg_486_1.text_.text = var_489_10

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_11 = 13
				local var_489_12 = utf8.len(var_489_10)
				local var_489_13 = var_489_11 <= 0 and var_489_7 or var_489_7 * (var_489_12 / var_489_11)

				if var_489_13 > 0 and var_489_7 < var_489_13 then
					arg_486_1.talkMaxDuration = var_489_13

					if var_489_13 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_13 + var_489_6
					end
				end

				arg_486_1.text_.text = var_489_10
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_14 = math.max(var_489_7, arg_486_1.talkMaxDuration)

			if var_489_6 <= arg_486_1.time_ and arg_486_1.time_ < var_489_6 + var_489_14 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_6) / var_489_14

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_6 + var_489_14 and arg_486_1.time_ < var_489_6 + var_489_14 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27g"
	},
	voices = {
		"story_v_out_426011.awb"
	}
}
