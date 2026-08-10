return {
	Play423132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423132001
		arg_1_1.duration_ = 7.6

		local var_1_0 = {
			zh = 7.6,
			ja = 7.066
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
				arg_1_0:Play423132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I26f"

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
				local var_4_5 = arg_1_1.bgs_.I26f

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
					if iter_4_0 ~= "I26f" then
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

			local var_4_30 = 0.500666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			local var_4_36 = 0.166666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.675

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

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[1335].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(423132001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132001", "story_v_out_423132.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_423132", "423132001", "story_v_out_423132.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_423132", "423132001", "story_v_out_423132.awb")

						arg_1_1:RecordAudio("423132001", var_4_50)
						arg_1_1:RecordAudio("423132001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423132", "423132001", "story_v_out_423132.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423132", "423132001", "story_v_out_423132.awb")
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
	Play423132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423132002
		arg_9_1.duration_ = 5.8

		local var_9_0 = {
			zh = 3.933,
			ja = 5.8
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
				arg_9_0:Play423132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 2.36666666666667
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_144", "se_story_144_gun01", "")
			end

			local var_12_4 = 0
			local var_12_5 = 0.4

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_6 = arg_9_1:FormatText(StoryNameCfg[1335].name)

				arg_9_1.leftNameTxt_.text = var_12_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_7 = arg_9_1:GetWordFromCfg(423132002)
				local var_12_8 = arg_9_1:FormatText(var_12_7.content)

				arg_9_1.text_.text = var_12_8

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 16
				local var_12_10 = utf8.len(var_12_8)
				local var_12_11 = var_12_9 <= 0 and var_12_5 or var_12_5 * (var_12_10 / var_12_9)

				if var_12_11 > 0 and var_12_5 < var_12_11 then
					arg_9_1.talkMaxDuration = var_12_11

					if var_12_11 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_8
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132002", "story_v_out_423132.awb") ~= 0 then
					local var_12_12 = manager.audio:GetVoiceLength("story_v_out_423132", "423132002", "story_v_out_423132.awb") / 1000

					if var_12_12 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_4
					end

					if var_12_7.prefab_name ~= "" and arg_9_1.actors_[var_12_7.prefab_name] ~= nil then
						local var_12_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_7.prefab_name].transform, "story_v_out_423132", "423132002", "story_v_out_423132.awb")

						arg_9_1:RecordAudio("423132002", var_12_13)
						arg_9_1:RecordAudio("423132002", var_12_13)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423132", "423132002", "story_v_out_423132.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423132", "423132002", "story_v_out_423132.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_14 and arg_9_1.time_ < var_12_4 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423132003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.05

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(423132003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 42
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423132004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.25

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

				local var_20_2 = arg_17_1:GetWordFromCfg(423132004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 50
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
	Play423132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423132005
		arg_21_1.duration_ = 6.2

		local var_21_0 = {
			zh = 5.333,
			ja = 6.2
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
				arg_21_0:Play423132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10148"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(var_24_1, arg_21_1.canvasGo_.transform)

					var_24_2.transform:SetSiblingIndex(1)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs(var_24_3) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["10148"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps10148 == nil then
				arg_21_1.var_.actorSpriteComps10148 = var_24_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.actorSpriteComps10148 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_8 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_7)
								local var_24_9 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_7)
								local var_24_10 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_7)

								iter_24_3.color = Color.New(var_24_8, var_24_9, var_24_10)
							else
								local var_24_11 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_7)

								iter_24_3.color = Color.New(var_24_11, var_24_11, var_24_11)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps10148 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10148 = nil
			end

			local var_24_12 = arg_21_1.actors_["10148"].transform
			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.var_.moveOldPos10148 = var_24_12.localPosition
				var_24_12.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10148", 2)

				local var_24_14 = var_24_12.childCount

				for iter_24_6 = 0, var_24_14 - 1 do
					local var_24_15 = var_24_12:GetChild(iter_24_6)

					if var_24_15.name == "split_4" or not string.find(var_24_15.name, "split") then
						var_24_15.gameObject:SetActive(true)
					else
						var_24_15.gameObject:SetActive(false)
					end
				end
			end

			local var_24_16 = 0.001

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_13) / var_24_16
				local var_24_18 = Vector3.New(-390, -350, -270)

				var_24_12.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10148, var_24_18, var_24_17)
			end

			if arg_21_1.time_ >= var_24_13 + var_24_16 and arg_21_1.time_ < var_24_13 + var_24_16 + arg_24_0 then
				var_24_12.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_24_19 = 0
			local var_24_20 = 0.4

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_21 = arg_21_1:FormatText(StoryNameCfg[1331].name)

				arg_21_1.leftNameTxt_.text = var_24_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_22 = arg_21_1:GetWordFromCfg(423132005)
				local var_24_23 = arg_21_1:FormatText(var_24_22.content)

				arg_21_1.text_.text = var_24_23

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_24 = 16
				local var_24_25 = utf8.len(var_24_23)
				local var_24_26 = var_24_24 <= 0 and var_24_20 or var_24_20 * (var_24_25 / var_24_24)

				if var_24_26 > 0 and var_24_20 < var_24_26 then
					arg_21_1.talkMaxDuration = var_24_26

					if var_24_26 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_19
					end
				end

				arg_21_1.text_.text = var_24_23
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132005", "story_v_out_423132.awb") ~= 0 then
					local var_24_27 = manager.audio:GetVoiceLength("story_v_out_423132", "423132005", "story_v_out_423132.awb") / 1000

					if var_24_27 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_19
					end

					if var_24_22.prefab_name ~= "" and arg_21_1.actors_[var_24_22.prefab_name] ~= nil then
						local var_24_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_22.prefab_name].transform, "story_v_out_423132", "423132005", "story_v_out_423132.awb")

						arg_21_1:RecordAudio("423132005", var_24_28)
						arg_21_1:RecordAudio("423132005", var_24_28)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423132", "423132005", "story_v_out_423132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423132", "423132005", "story_v_out_423132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_29 = math.max(var_24_20, arg_21_1.talkMaxDuration)

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_19) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_19 + var_24_29 and arg_21_1.time_ < var_24_19 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play423132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423132006
		arg_25_1.duration_ = 3.83

		local var_25_0 = {
			zh = 2.666,
			ja = 3.833
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
				arg_25_0:Play423132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1083"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["1083"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps1083 == nil then
				arg_25_1.var_.actorSpriteComps1083 = var_28_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.2

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.actorSpriteComps1083 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								local var_28_8 = Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, var_28_7)
								local var_28_9 = Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, var_28_7)
								local var_28_10 = Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, var_28_7)

								iter_28_3.color = Color.New(var_28_8, var_28_9, var_28_10)
							else
								local var_28_11 = Mathf.Lerp(iter_28_3.color.r, 1, var_28_7)

								iter_28_3.color = Color.New(var_28_11, var_28_11, var_28_11)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps1083 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_28_5 then
						if arg_25_1.isInRecall_ then
							iter_28_5.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1083 = nil
			end

			local var_28_12 = arg_25_1.actors_["10148"]
			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 and not isNil(var_28_12) and arg_25_1.var_.actorSpriteComps10148 == nil then
				arg_25_1.var_.actorSpriteComps10148 = var_28_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_14 = 0.2

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_14 and not isNil(var_28_12) then
				local var_28_15 = (arg_25_1.time_ - var_28_13) / var_28_14

				if arg_25_1.var_.actorSpriteComps10148 then
					for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_28_7 then
							if arg_25_1.isInRecall_ then
								local var_28_16 = Mathf.Lerp(iter_28_7.color.r, arg_25_1.hightColor2.r, var_28_15)
								local var_28_17 = Mathf.Lerp(iter_28_7.color.g, arg_25_1.hightColor2.g, var_28_15)
								local var_28_18 = Mathf.Lerp(iter_28_7.color.b, arg_25_1.hightColor2.b, var_28_15)

								iter_28_7.color = Color.New(var_28_16, var_28_17, var_28_18)
							else
								local var_28_19 = Mathf.Lerp(iter_28_7.color.r, 0.5, var_28_15)

								iter_28_7.color = Color.New(var_28_19, var_28_19, var_28_19)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_13 + var_28_14 and arg_25_1.time_ < var_28_13 + var_28_14 + arg_28_0 and not isNil(var_28_12) and arg_25_1.var_.actorSpriteComps10148 then
				for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_28_9 then
						if arg_25_1.isInRecall_ then
							iter_28_9.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10148 = nil
			end

			local var_28_20 = arg_25_1.actors_["1083"].transform
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.var_.moveOldPos1083 = var_28_20.localPosition
				var_28_20.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1083", 4)

				local var_28_22 = var_28_20.childCount

				for iter_28_10 = 0, var_28_22 - 1 do
					local var_28_23 = var_28_20:GetChild(iter_28_10)

					if var_28_23.name == "split_7" or not string.find(var_28_23.name, "split") then
						var_28_23.gameObject:SetActive(true)
					else
						var_28_23.gameObject:SetActive(false)
					end
				end
			end

			local var_28_24 = 0.001

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_24 then
				local var_28_25 = (arg_25_1.time_ - var_28_21) / var_28_24
				local var_28_26 = Vector3.New(390, -345, -345)

				var_28_20.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1083, var_28_26, var_28_25)
			end

			if arg_25_1.time_ >= var_28_21 + var_28_24 and arg_25_1.time_ < var_28_21 + var_28_24 + arg_28_0 then
				var_28_20.localPosition = Vector3.New(390, -345, -345)
			end

			local var_28_27 = 0
			local var_28_28 = 0.325

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_29 = arg_25_1:FormatText(StoryNameCfg[1332].name)

				arg_25_1.leftNameTxt_.text = var_28_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_30 = arg_25_1:GetWordFromCfg(423132006)
				local var_28_31 = arg_25_1:FormatText(var_28_30.content)

				arg_25_1.text_.text = var_28_31

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_32 = 13
				local var_28_33 = utf8.len(var_28_31)
				local var_28_34 = var_28_32 <= 0 and var_28_28 or var_28_28 * (var_28_33 / var_28_32)

				if var_28_34 > 0 and var_28_28 < var_28_34 then
					arg_25_1.talkMaxDuration = var_28_34

					if var_28_34 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_31
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132006", "story_v_out_423132.awb") ~= 0 then
					local var_28_35 = manager.audio:GetVoiceLength("story_v_out_423132", "423132006", "story_v_out_423132.awb") / 1000

					if var_28_35 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_27
					end

					if var_28_30.prefab_name ~= "" and arg_25_1.actors_[var_28_30.prefab_name] ~= nil then
						local var_28_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_30.prefab_name].transform, "story_v_out_423132", "423132006", "story_v_out_423132.awb")

						arg_25_1:RecordAudio("423132006", var_28_36)
						arg_25_1:RecordAudio("423132006", var_28_36)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423132", "423132006", "story_v_out_423132.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423132", "423132006", "story_v_out_423132.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_37 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_27) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_27 + var_28_37 and arg_25_1.time_ < var_28_27 + var_28_37 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play423132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423132007
		arg_29_1.duration_ = 6

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1083"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1083 == nil then
				arg_29_1.var_.actorSpriteComps1083 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1083 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1083 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1083 = nil
			end

			local var_32_8 = arg_29_1.actors_["1083"].transform
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.var_.moveOldPos1083 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1083", 7)

				local var_32_10 = var_32_8.childCount

				for iter_32_4 = 0, var_32_10 - 1 do
					local var_32_11 = var_32_8:GetChild(iter_32_4)

					if var_32_11.name == "" or not string.find(var_32_11.name, "split") then
						var_32_11.gameObject:SetActive(true)
					else
						var_32_11.gameObject:SetActive(false)
					end
				end
			end

			local var_32_12 = 0.001

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_12 then
				local var_32_13 = (arg_29_1.time_ - var_32_9) / var_32_12
				local var_32_14 = Vector3.New(0, -2000, 0)

				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1083, var_32_14, var_32_13)
			end

			if arg_29_1.time_ >= var_32_9 + var_32_12 and arg_29_1.time_ < var_32_9 + var_32_12 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_15 = arg_29_1.actors_["10148"].transform
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.var_.moveOldPos10148 = var_32_15.localPosition
				var_32_15.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10148", 7)

				local var_32_17 = var_32_15.childCount

				for iter_32_5 = 0, var_32_17 - 1 do
					local var_32_18 = var_32_15:GetChild(iter_32_5)

					if var_32_18.name == "" or not string.find(var_32_18.name, "split") then
						var_32_18.gameObject:SetActive(true)
					else
						var_32_18.gameObject:SetActive(false)
					end
				end
			end

			local var_32_19 = 0.001

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_19 then
				local var_32_20 = (arg_29_1.time_ - var_32_16) / var_32_19
				local var_32_21 = Vector3.New(0, -2000, 0)

				var_32_15.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10148, var_32_21, var_32_20)
			end

			if arg_29_1.time_ >= var_32_16 + var_32_19 and arg_29_1.time_ < var_32_16 + var_32_19 + arg_32_0 then
				var_32_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_22 = manager.ui.mainCamera.transform
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.var_.shakeOldPos = var_32_22.localPosition
			end

			local var_32_24 = 1

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / 0.066
				local var_32_26, var_32_27 = math.modf(var_32_25)

				var_32_22.localPosition = Vector3.New(var_32_27 * 0.13, var_32_27 * 0.13, var_32_27 * 0.13) + arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				var_32_22.localPosition = arg_29_1.var_.shakeOldPos
			end

			local var_32_28 = manager.ui.mainCamera.transform
			local var_32_29 = 0

			if var_32_29 < arg_29_1.time_ and arg_29_1.time_ <= var_32_29 + arg_32_0 then
				local var_32_30 = arg_29_1.var_.effectfangunaishi1
				local var_32_31
				local var_32_32 = var_32_28

				if not var_32_30 then
					var_32_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_32_32)
					var_32_30.name = "fangunaishi1"
					arg_29_1.var_.effectfangunaishi1 = var_32_30
				else
					var_32_30.transform:SetParent(var_32_32)
				end

				var_32_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_32_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_32_33 = manager.ui.mainCameraCom_
				local var_32_34 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_32_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_32_35 = var_32_30.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_32_36 = 15
				local var_32_37 = 2 * var_32_36 * Mathf.Tan(var_32_33.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_32_33.aspect
				local var_32_38 = 1
				local var_32_39 = 1.7777777777777777

				if var_32_39 < var_32_33.aspect then
					var_32_38 = var_32_37 / (2 * var_32_36 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_32_39)
				end

				for iter_32_6, iter_32_7 in ipairs(var_32_35) do
					local var_32_40 = iter_32_7.transform.localScale

					iter_32_7.transform.localScale = Vector3.New(var_32_40.x / var_32_34 * var_32_38, var_32_40.y / var_32_34, var_32_40.z)
				end
			end

			local var_32_41 = manager.ui.mainCamera.transform
			local var_32_42 = 1

			if var_32_42 < arg_29_1.time_ and arg_29_1.time_ <= var_32_42 + arg_32_0 then
				local var_32_43 = arg_29_1.var_.effectfangunaishi1

				if var_32_43 then
					Object.Destroy(var_32_43)

					arg_29_1.var_.effectfangunaishi1 = nil
				end
			end

			local var_32_44 = 1.66666666666667
			local var_32_45 = 1

			if var_32_44 < arg_29_1.time_ and arg_29_1.time_ <= var_32_44 + arg_32_0 then
				local var_32_46 = "play"
				local var_32_47 = "effect"

				arg_29_1:AudioAction(var_32_46, var_32_47, "se_story_144", "se_story_144_countdown", "")
			end

			local var_32_48 = 0.034
			local var_32_49 = 1

			if var_32_48 < arg_29_1.time_ and arg_29_1.time_ <= var_32_48 + arg_32_0 then
				local var_32_50 = "play"
				local var_32_51 = "effect"

				arg_29_1:AudioAction(var_32_50, var_32_51, "se_story_144", "se_story_144_fall", "")
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_52 = 1
			local var_32_53 = 1.4

			if var_32_52 < arg_29_1.time_ and arg_29_1.time_ <= var_32_52 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_54 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_54:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_55 = arg_29_1:GetWordFromCfg(423132007)
				local var_32_56 = arg_29_1:FormatText(var_32_55.content)

				arg_29_1.text_.text = var_32_56

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_57 = 56
				local var_32_58 = utf8.len(var_32_56)
				local var_32_59 = var_32_57 <= 0 and var_32_53 or var_32_53 * (var_32_58 / var_32_57)

				if var_32_59 > 0 and var_32_53 < var_32_59 then
					arg_29_1.talkMaxDuration = var_32_59
					var_32_52 = var_32_52 + 0.3

					if var_32_59 + var_32_52 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_59 + var_32_52
					end
				end

				arg_29_1.text_.text = var_32_56
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_60 = var_32_52 + 0.3
			local var_32_61 = math.max(var_32_53, arg_29_1.talkMaxDuration)

			if var_32_60 <= arg_29_1.time_ and arg_29_1.time_ < var_32_60 + var_32_61 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_60) / var_32_61

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_60 + var_32_61 and arg_29_1.time_ < var_32_60 + var_32_61 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play423132008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 423132008
		arg_35_1.duration_ = 7

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play423132009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = manager.ui.mainCamera.transform
			local var_38_1 = 0.533333333333333

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				local var_38_2 = arg_35_1.var_.effectcaisezhadan1
				local var_38_3
				local var_38_4 = var_38_0

				if not var_38_2 then
					var_38_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_38_4)
					var_38_2.name = "caisezhadan1"
					arg_35_1.var_.effectcaisezhadan1 = var_38_2
				else
					var_38_2.transform:SetParent(var_38_4)
				end

				var_38_2.transform.localPosition = Vector3.New(0, 0, -1.06)
				var_38_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_38_5 = manager.ui.mainCameraCom_
				local var_38_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_38_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_38_7 = var_38_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_38_8 = 15
				local var_38_9 = 2 * var_38_8 * Mathf.Tan(var_38_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_38_5.aspect
				local var_38_10 = 1
				local var_38_11 = 1.7777777777777777

				if var_38_11 < var_38_5.aspect then
					var_38_10 = var_38_9 / (2 * var_38_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_38_11)
				end

				for iter_38_0, iter_38_1 in ipairs(var_38_7) do
					local var_38_12 = iter_38_1.transform.localScale

					iter_38_1.transform.localScale = Vector3.New(var_38_12.x / var_38_6 * var_38_10, var_38_12.y / var_38_6, var_38_12.z)
				end
			end

			local var_38_13 = manager.ui.mainCamera.transform
			local var_38_14 = 2.53333333333333

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				local var_38_15 = arg_35_1.var_.effectcaisezhadan1

				if var_38_15 then
					Object.Destroy(var_38_15)

					arg_35_1.var_.effectcaisezhadan1 = nil
				end
			end

			local var_38_16 = manager.ui.mainCamera.transform
			local var_38_17 = 0

			if var_38_17 < arg_35_1.time_ and arg_35_1.time_ <= var_38_17 + arg_38_0 then
				local var_38_18 = arg_35_1.var_.effectcaisezhadan2
				local var_38_19
				local var_38_20 = var_38_16

				if not var_38_18 then
					var_38_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_38_20)
					var_38_18.name = "caisezhadan2"
					arg_35_1.var_.effectcaisezhadan2 = var_38_18
				else
					var_38_18.transform:SetParent(var_38_20)
				end

				var_38_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_38_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_38_21 = manager.ui.mainCameraCom_
				local var_38_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_38_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_38_23 = var_38_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_38_24 = 15
				local var_38_25 = 2 * var_38_24 * Mathf.Tan(var_38_21.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_38_21.aspect
				local var_38_26 = 1
				local var_38_27 = 1.7777777777777777

				if var_38_27 < var_38_21.aspect then
					var_38_26 = var_38_25 / (2 * var_38_24 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_38_27)
				end

				for iter_38_2, iter_38_3 in ipairs(var_38_23) do
					local var_38_28 = iter_38_3.transform.localScale

					iter_38_3.transform.localScale = Vector3.New(var_38_28.x / var_38_22 * var_38_26, var_38_28.y / var_38_22, var_38_28.z)
				end
			end

			local var_38_29 = manager.ui.mainCamera.transform
			local var_38_30 = 2

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				local var_38_31 = arg_35_1.var_.effectcaisezhadan2

				if var_38_31 then
					Object.Destroy(var_38_31)

					arg_35_1.var_.effectcaisezhadan2 = nil
				end
			end

			local var_38_32 = manager.ui.mainCamera.transform
			local var_38_33 = 0.533333333333333

			if var_38_33 < arg_35_1.time_ and arg_35_1.time_ <= var_38_33 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_32.localPosition
			end

			local var_38_34 = 2

			if var_38_33 <= arg_35_1.time_ and arg_35_1.time_ < var_38_33 + var_38_34 then
				local var_38_35 = (arg_35_1.time_ - var_38_33) / 0.066
				local var_38_36, var_38_37 = math.modf(var_38_35)

				var_38_32.localPosition = Vector3.New(var_38_37 * 0.2, var_38_37 * 0.2, var_38_37 * 0.2) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_33 + var_38_34 and arg_35_1.time_ < var_38_33 + var_38_34 + arg_38_0 then
				var_38_32.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_38 = 0

			if var_38_38 < arg_35_1.time_ and arg_35_1.time_ <= var_38_38 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			local var_38_39 = 2

			if arg_35_1.time_ >= var_38_38 + var_38_39 and arg_35_1.time_ < var_38_38 + var_38_39 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			local var_38_40 = 0.0333333333333333
			local var_38_41 = 1

			if var_38_40 < arg_35_1.time_ and arg_35_1.time_ <= var_38_40 + arg_38_0 then
				local var_38_42 = "play"
				local var_38_43 = "effect"

				arg_35_1:AudioAction(var_38_42, var_38_43, "se_story_144", "se_story_144_firework", "")
			end

			local var_38_44 = manager.ui.mainCamera.transform
			local var_38_45 = 0.533333333333333

			if var_38_45 < arg_35_1.time_ and arg_35_1.time_ <= var_38_45 + arg_38_0 then
				local var_38_46 = arg_35_1.var_.effectyanhualiangjingjing1
				local var_38_47
				local var_38_48 = var_38_44

				if not var_38_46 then
					var_38_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_38_48)
					var_38_46.name = "yanhualiangjingjing1"
					arg_35_1.var_.effectyanhualiangjingjing1 = var_38_46
				else
					var_38_46.transform:SetParent(var_38_48)
				end

				var_38_46.transform.localPosition = Vector3.New(0, 0, -10)
				var_38_46.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_38_49 = manager.ui.mainCameraCom_
				local var_38_50 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_38_49.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_38_51 = var_38_46.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_38_52 = 15
				local var_38_53 = 2 * var_38_52 * Mathf.Tan(var_38_49.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_38_49.aspect
				local var_38_54 = 1
				local var_38_55 = 1.7777777777777777

				if var_38_55 < var_38_49.aspect then
					var_38_54 = var_38_53 / (2 * var_38_52 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_38_55)
				end

				for iter_38_4, iter_38_5 in ipairs(var_38_51) do
					local var_38_56 = iter_38_5.transform.localScale

					iter_38_5.transform.localScale = Vector3.New(var_38_56.x / var_38_50 * var_38_54, var_38_56.y / var_38_50, var_38_56.z)
				end
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_57 = 2
			local var_38_58 = 1.3

			if var_38_57 < arg_35_1.time_ and arg_35_1.time_ <= var_38_57 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_59 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_59:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_60 = arg_35_1:GetWordFromCfg(423132008)
				local var_38_61 = arg_35_1:FormatText(var_38_60.content)

				arg_35_1.text_.text = var_38_61

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_62 = 52
				local var_38_63 = utf8.len(var_38_61)
				local var_38_64 = var_38_62 <= 0 and var_38_58 or var_38_58 * (var_38_63 / var_38_62)

				if var_38_64 > 0 and var_38_58 < var_38_64 then
					arg_35_1.talkMaxDuration = var_38_64
					var_38_57 = var_38_57 + 0.3

					if var_38_64 + var_38_57 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_64 + var_38_57
					end
				end

				arg_35_1.text_.text = var_38_61
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_65 = var_38_57 + 0.3
			local var_38_66 = math.max(var_38_58, arg_35_1.talkMaxDuration)

			if var_38_65 <= arg_35_1.time_ and arg_35_1.time_ < var_38_65 + var_38_66 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_65) / var_38_66

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_65 + var_38_66 and arg_35_1.time_ < var_38_65 + var_38_66 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play423132009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423132009
		arg_41_1.duration_ = 6.73

		local var_41_0 = {
			zh = 6.2,
			ja = 6.733
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
				arg_41_0:Play423132010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10148"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10148 == nil then
				arg_41_1.var_.actorSpriteComps10148 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10148 = nil
			end

			local var_44_8 = arg_41_1.actors_["10148"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 2)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "split_4" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(-390, -350, -270)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_44_15 = 0
			local var_44_16 = 0.575

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[1331].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(423132009)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 23
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132009", "story_v_out_423132.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_423132", "423132009", "story_v_out_423132.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_423132", "423132009", "story_v_out_423132.awb")

						arg_41_1:RecordAudio("423132009", var_44_24)
						arg_41_1:RecordAudio("423132009", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423132", "423132009", "story_v_out_423132.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423132", "423132009", "story_v_out_423132.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play423132010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423132010
		arg_45_1.duration_ = 8.97

		local var_45_0 = {
			zh = 6.5,
			ja = 8.966
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
				arg_45_0:Play423132011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1083"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1083 == nil then
				arg_45_1.var_.actorSpriteComps1083 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1083 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1083 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1083 = nil
			end

			local var_48_8 = arg_45_1.actors_["10148"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10148 == nil then
				arg_45_1.var_.actorSpriteComps10148 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps10148 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor2.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor2.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor2.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 0.5, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10148 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10148 = nil
			end

			local var_48_16 = arg_45_1.actors_["1083"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 4)

				local var_48_18 = var_48_16.childCount

				for iter_48_8 = 0, var_48_18 - 1 do
					local var_48_19 = var_48_16:GetChild(iter_48_8)

					if var_48_19.name == "split_7" or not string.find(var_48_19.name, "split") then
						var_48_19.gameObject:SetActive(true)
					else
						var_48_19.gameObject:SetActive(false)
					end
				end
			end

			local var_48_20 = 0.001

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_17) / var_48_20
				local var_48_22 = Vector3.New(390, -345, -345)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(390, -345, -345)
			end

			local var_48_23 = 0
			local var_48_24 = 0.8

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[1332].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(423132010)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 32
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132010", "story_v_out_423132.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_423132", "423132010", "story_v_out_423132.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_423132", "423132010", "story_v_out_423132.awb")

						arg_45_1:RecordAudio("423132010", var_48_32)
						arg_45_1:RecordAudio("423132010", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423132", "423132010", "story_v_out_423132.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423132", "423132010", "story_v_out_423132.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play423132011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423132011
		arg_49_1.duration_ = 3.37

		local var_49_0 = {
			zh = 3.366,
			ja = 2.8
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
				arg_49_0:Play423132012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1332].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(423132011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132011", "story_v_out_423132.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_423132", "423132011", "story_v_out_423132.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_423132", "423132011", "story_v_out_423132.awb")

						arg_49_1:RecordAudio("423132011", var_52_9)
						arg_49_1:RecordAudio("423132011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423132", "423132011", "story_v_out_423132.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423132", "423132011", "story_v_out_423132.awb")
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
	Play423132012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423132012
		arg_53_1.duration_ = 3.03

		local var_53_0 = {
			zh = 3.033,
			ja = 2.566
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
				arg_53_0:Play423132013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1083"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_7" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(390, -345, -345)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(390, -345, -345)
			end

			local var_56_7 = 0
			local var_56_8 = 0.525

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_9 = arg_53_1:FormatText(StoryNameCfg[1332].name)

				arg_53_1.leftNameTxt_.text = var_56_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(423132012)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 21
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_8 or var_56_8 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_8 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132012", "story_v_out_423132.awb") ~= 0 then
					local var_56_15 = manager.audio:GetVoiceLength("story_v_out_423132", "423132012", "story_v_out_423132.awb") / 1000

					if var_56_15 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_7
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_423132", "423132012", "story_v_out_423132.awb")

						arg_53_1:RecordAudio("423132012", var_56_16)
						arg_53_1:RecordAudio("423132012", var_56_16)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423132", "423132012", "story_v_out_423132.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423132", "423132012", "story_v_out_423132.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_17 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_17 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_7) / var_56_17

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_7 + var_56_17 and arg_53_1.time_ < var_56_7 + var_56_17 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423132013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423132013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play423132014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1083"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1083 == nil then
				arg_57_1.var_.actorSpriteComps1083 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1083 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1083 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1083 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.475

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("calling")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_11 = arg_57_1:GetWordFromCfg(423132013)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 19
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423132014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423132014
		arg_61_1.duration_ = 5.57

		local var_61_0 = {
			zh = 4.3,
			ja = 5.566
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
				arg_61_0:Play423132015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1083"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1083 == nil then
				arg_61_1.var_.actorSpriteComps1083 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1083 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1083 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1083 = nil
			end

			local var_64_8 = arg_61_1.actors_["1083"].transform
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.var_.moveOldPos1083 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1083", 4)

				local var_64_10 = var_64_8.childCount

				for iter_64_4 = 0, var_64_10 - 1 do
					local var_64_11 = var_64_8:GetChild(iter_64_4)

					if var_64_11.name == "" or not string.find(var_64_11.name, "split") then
						var_64_11.gameObject:SetActive(true)
					else
						var_64_11.gameObject:SetActive(false)
					end
				end
			end

			local var_64_12 = 0.001

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_12 then
				local var_64_13 = (arg_61_1.time_ - var_64_9) / var_64_12
				local var_64_14 = Vector3.New(390, -345, -345)

				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1083, var_64_14, var_64_13)
			end

			if arg_61_1.time_ >= var_64_9 + var_64_12 and arg_61_1.time_ < var_64_9 + var_64_12 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(390, -345, -345)
			end

			local var_64_15 = 0
			local var_64_16 = 0.475

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[1332].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(423132014)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 19
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423132", "423132014", "story_v_out_423132.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_423132", "423132014", "story_v_out_423132.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_423132", "423132014", "story_v_out_423132.awb")

						arg_61_1:RecordAudio("423132014", var_64_24)
						arg_61_1:RecordAudio("423132014", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423132", "423132014", "story_v_out_423132.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423132", "423132014", "story_v_out_423132.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play423132015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423132015
		arg_65_1.duration_ = 6.75

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423132016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1083"]
			local var_68_1 = 1

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1083 == nil then
				arg_65_1.var_.actorSpriteComps1083 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1083 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1083 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1083 = nil
			end

			local var_68_8 = manager.ui.mainCamera.transform
			local var_68_9 = 1

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				local var_68_10 = arg_65_1.var_.effectyanhualiangjingjing1

				if var_68_10 then
					Object.Destroy(var_68_10)

					arg_65_1.var_.effectyanhualiangjingjing1 = nil
				end
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_12 = 1

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_11) / var_68_12
				local var_68_14 = Color.New(0, 0, 0)

				var_68_14.a = Mathf.Lerp(0, 1, var_68_13)
				arg_65_1.mask_.color = var_68_14
			end

			if arg_65_1.time_ >= var_68_11 + var_68_12 and arg_65_1.time_ < var_68_11 + var_68_12 + arg_68_0 then
				local var_68_15 = Color.New(0, 0, 0)

				var_68_15.a = 1
				arg_65_1.mask_.color = var_68_15
			end

			local var_68_16 = 1

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_17 = 1

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Color.New(0, 0, 0)

				var_68_19.a = Mathf.Lerp(1, 0, var_68_18)
				arg_65_1.mask_.color = var_68_19
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				local var_68_20 = Color.New(0, 0, 0)
				local var_68_21 = 0

				arg_65_1.mask_.enabled = false
				var_68_20.a = var_68_21
				arg_65_1.mask_.color = var_68_20
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_22 = 1.75
			local var_68_23 = 0.25

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_24 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_24:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("calling")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_26 = arg_65_1:GetWordFromCfg(423132015)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 10
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_23 or var_68_23 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_23 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30
					var_68_22 = var_68_22 + 0.3

					if var_68_30 + var_68_22 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_22
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = var_68_22 + 0.3
			local var_68_32 = math.max(var_68_23, arg_65_1.talkMaxDuration)

			if var_68_31 <= arg_65_1.time_ and arg_65_1.time_ < var_68_31 + var_68_32 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_31) / var_68_32

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_31 + var_68_32 and arg_65_1.time_ < var_68_31 + var_68_32 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423132016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 423132016
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
			arg_71_1.auto_ = false
		end

		function arg_71_1.playNext_(arg_73_0)
			arg_71_1.onStoryFinished_()
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1083"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1083 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1083", 7)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -2000, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1083, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_7 = arg_71_1.actors_["10148"].transform
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.var_.moveOldPos10148 = var_74_7.localPosition
				var_74_7.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10148", 7)

				local var_74_9 = var_74_7.childCount

				for iter_74_1 = 0, var_74_9 - 1 do
					local var_74_10 = var_74_7:GetChild(iter_74_1)

					if var_74_10.name == "" or not string.find(var_74_10.name, "split") then
						var_74_10.gameObject:SetActive(true)
					else
						var_74_10.gameObject:SetActive(false)
					end
				end
			end

			local var_74_11 = 0.001

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_8) / var_74_11
				local var_74_13 = Vector3.New(0, -2000, 0)

				var_74_7.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10148, var_74_13, var_74_12)
			end

			if arg_71_1.time_ >= var_74_8 + var_74_11 and arg_71_1.time_ < var_74_8 + var_74_11 + arg_74_0 then
				var_74_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_14 = 0
			local var_74_15 = 1.375

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_16 = arg_71_1:GetWordFromCfg(423132016)
				local var_74_17 = arg_71_1:FormatText(var_74_16.content)

				arg_71_1.text_.text = var_74_17

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_18 = 55
				local var_74_19 = utf8.len(var_74_17)
				local var_74_20 = var_74_18 <= 0 and var_74_15 or var_74_15 * (var_74_19 / var_74_18)

				if var_74_20 > 0 and var_74_15 < var_74_20 then
					arg_71_1.talkMaxDuration = var_74_20

					if var_74_20 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_14
					end
				end

				arg_71_1.text_.text = var_74_17
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_15, arg_71_1.talkMaxDuration)

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_14) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_14 + var_74_21 and arg_71_1.time_ < var_74_14 + var_74_21 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I26f"
	},
	voices = {
		"story_v_out_423132.awb"
	}
}
