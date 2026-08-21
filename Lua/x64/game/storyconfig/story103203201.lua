return {
	Play320321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320321001
		arg_1_1.duration_ = 12.9

		local var_1_0 = {
			zh = 10.799999999999,
			ja = 12.899999999999
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
				arg_1_0:Play320321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 1

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "L07f"

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
				local var_4_7 = arg_1_1.bgs_.L07f

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
					if iter_4_0 ~= "L07f" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.333333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.9

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[1066].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(320321001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 36
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321001", "story_v_out_320321.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_320321", "320321001", "story_v_out_320321.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_320321", "320321001", "story_v_out_320321.awb")

						arg_1_1:RecordAudio("320321001", var_4_46)
						arg_1_1:RecordAudio("320321001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320321", "320321001", "story_v_out_320321.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320321", "320321001", "story_v_out_320321.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320321002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320321002
		arg_9_1.duration_ = 4.53

		local var_9_0 = {
			zh = 3.5,
			ja = 4.533
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
				arg_9_0:Play320321003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.425

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1066].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(320321002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321002", "story_v_out_320321.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321002", "story_v_out_320321.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_320321", "320321002", "story_v_out_320321.awb")

						arg_9_1:RecordAudio("320321002", var_12_9)
						arg_9_1:RecordAudio("320321002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320321", "320321002", "story_v_out_320321.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320321", "320321002", "story_v_out_320321.awb")
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
	Play320321003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320321003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320321004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.4

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

				local var_16_2 = arg_13_1:GetWordFromCfg(320321003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 56
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
	Play320321004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320321004
		arg_17_1.duration_ = 7.73

		local var_17_0 = {
			zh = 6.1,
			ja = 7.733
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
				arg_17_0:Play320321005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.575

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[1044].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(320321004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321004", "story_v_out_320321.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321004", "story_v_out_320321.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_320321", "320321004", "story_v_out_320321.awb")

						arg_17_1:RecordAudio("320321004", var_20_9)
						arg_17_1:RecordAudio("320321004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320321", "320321004", "story_v_out_320321.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320321", "320321004", "story_v_out_320321.awb")
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
	Play320321005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320321005
		arg_21_1.duration_ = 8.27

		local var_21_0 = {
			zh = 8.266,
			ja = 6
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
				arg_21_0:Play320321006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.025

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1066].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(320321005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321005", "story_v_out_320321.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321005", "story_v_out_320321.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320321", "320321005", "story_v_out_320321.awb")

						arg_21_1:RecordAudio("320321005", var_24_9)
						arg_21_1:RecordAudio("320321005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320321", "320321005", "story_v_out_320321.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320321", "320321005", "story_v_out_320321.awb")
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
	Play320321006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320321006
		arg_25_1.duration_ = 7.13

		local var_25_0 = {
			zh = 7.133,
			ja = 7
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
				arg_25_0:Play320321007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.775

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1066].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(320321006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321006", "story_v_out_320321.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321006", "story_v_out_320321.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_320321", "320321006", "story_v_out_320321.awb")

						arg_25_1:RecordAudio("320321006", var_28_9)
						arg_25_1:RecordAudio("320321006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320321", "320321006", "story_v_out_320321.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320321", "320321006", "story_v_out_320321.awb")
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
	Play320321007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320321007
		arg_29_1.duration_ = 3.8

		local var_29_0 = {
			zh = 3.333,
			ja = 3.8
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
				arg_29_0:Play320321008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_1 = 0.166666666666667

			if arg_29_1.time_ >= var_32_0 + var_32_1 and arg_29_1.time_ < var_32_0 + var_32_1 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_2 = 0
			local var_32_3 = 0.35

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_4 = arg_29_1:FormatText(StoryNameCfg[1044].name)

				arg_29_1.leftNameTxt_.text = var_32_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_5 = arg_29_1:GetWordFromCfg(320321007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 14
				local var_32_8 = utf8.len(var_32_6)
				local var_32_9 = var_32_7 <= 0 and var_32_3 or var_32_3 * (var_32_8 / var_32_7)

				if var_32_9 > 0 and var_32_3 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321007", "story_v_out_320321.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_320321", "320321007", "story_v_out_320321.awb") / 1000

					if var_32_10 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_2
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_out_320321", "320321007", "story_v_out_320321.awb")

						arg_29_1:RecordAudio("320321007", var_32_11)
						arg_29_1:RecordAudio("320321007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320321", "320321007", "story_v_out_320321.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320321", "320321007", "story_v_out_320321.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_12 and arg_29_1.time_ < var_32_2 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320321008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320321008
		arg_33_1.duration_ = 2.4

		local var_33_0 = {
			zh = 2.4,
			ja = 1.5
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
				arg_33_0:Play320321009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			local var_36_1 = 0.2

			if arg_33_1.time_ >= var_36_0 + var_36_1 and arg_33_1.time_ < var_36_0 + var_36_1 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_2 = 0
			local var_36_3 = 0.2

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[1066].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_5 = arg_33_1:GetWordFromCfg(320321008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 8
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321008", "story_v_out_320321.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_320321", "320321008", "story_v_out_320321.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_320321", "320321008", "story_v_out_320321.awb")

						arg_33_1:RecordAudio("320321008", var_36_11)
						arg_33_1:RecordAudio("320321008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320321", "320321008", "story_v_out_320321.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320321", "320321008", "story_v_out_320321.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320321009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320321009
		arg_37_1.duration_ = 13.8

		local var_37_0 = {
			zh = 11.1,
			ja = 13.8
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
				arg_37_0:Play320321010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.25

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1044].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(320321009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321009", "story_v_out_320321.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321009", "story_v_out_320321.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_320321", "320321009", "story_v_out_320321.awb")

						arg_37_1:RecordAudio("320321009", var_40_9)
						arg_37_1:RecordAudio("320321009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320321", "320321009", "story_v_out_320321.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320321", "320321009", "story_v_out_320321.awb")
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
	Play320321010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320321010
		arg_41_1.duration_ = 7.77

		local var_41_0 = {
			zh = 6.033,
			ja = 7.766
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
				arg_41_0:Play320321011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.45

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1066].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(320321010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321010", "story_v_out_320321.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321010", "story_v_out_320321.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_320321", "320321010", "story_v_out_320321.awb")

						arg_41_1:RecordAudio("320321010", var_44_9)
						arg_41_1:RecordAudio("320321010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320321", "320321010", "story_v_out_320321.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320321", "320321010", "story_v_out_320321.awb")
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
	Play320321011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320321011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320321012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.425

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

				local var_48_2 = arg_45_1:GetWordFromCfg(320321011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 57
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
	Play320321012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320321012
		arg_49_1.duration_ = 4.27

		local var_49_0 = {
			zh = 4.033,
			ja = 4.266
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
				arg_49_0:Play320321013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.866666666666667

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1044].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(320321012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321012", "story_v_out_320321.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321012", "story_v_out_320321.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_320321", "320321012", "story_v_out_320321.awb")

						arg_49_1:RecordAudio("320321012", var_52_9)
						arg_49_1:RecordAudio("320321012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320321", "320321012", "story_v_out_320321.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320321", "320321012", "story_v_out_320321.awb")
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
	Play320321013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320321013
		arg_53_1.duration_ = 3

		local var_53_0 = {
			zh = 3,
			ja = 2.533
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
				arg_53_0:Play320321014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.4

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1032].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(320321013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321013", "story_v_out_320321.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321013", "story_v_out_320321.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_320321", "320321013", "story_v_out_320321.awb")

						arg_53_1:RecordAudio("320321013", var_56_9)
						arg_53_1:RecordAudio("320321013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320321", "320321013", "story_v_out_320321.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320321", "320321013", "story_v_out_320321.awb")
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
	Play320321014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320321014
		arg_57_1.duration_ = 2.53

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_57_0:Play320321015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "1056ui_story"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_57_1.stage_.transform)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentInChildren(typeof(CharacterEffect))

					var_60_3.enabled = true

					local var_60_4 = GameObjectTools.GetOrAddComponent(var_60_2, typeof(DynamicBoneHelper))

					if var_60_4 then
						var_60_4:EnableDynamicBone(false)
					end

					arg_57_1:ShowWeapon(var_60_3.transform, false)

					arg_57_1.var_[var_60_0 .. "Animator"] = var_60_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_57_1.var_[var_60_0 .. "Animator"].applyRootMotion = true
					arg_57_1.var_[var_60_0 .. "LipSync"] = var_60_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_60_5 = arg_57_1.actors_["1056ui_story"].transform
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.var_.moveOldPos1056ui_story = var_60_5.localPosition
			end

			local var_60_7 = 0.001

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7
				local var_60_9 = Vector3.New(0, -1, -5.75)

				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1056ui_story, var_60_9, var_60_8)

				local var_60_10 = manager.ui.mainCamera.transform.position - var_60_5.position

				var_60_5.forward = Vector3.New(var_60_10.x, var_60_10.y, var_60_10.z)

				local var_60_11 = var_60_5.localEulerAngles

				var_60_11.z = 0
				var_60_11.x = 0
				var_60_5.localEulerAngles = var_60_11
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -1, -5.75)

				local var_60_12 = manager.ui.mainCamera.transform.position - var_60_5.position

				var_60_5.forward = Vector3.New(var_60_12.x, var_60_12.y, var_60_12.z)

				local var_60_13 = var_60_5.localEulerAngles

				var_60_13.z = 0
				var_60_13.x = 0
				var_60_5.localEulerAngles = var_60_13
			end

			local var_60_14 = arg_57_1.actors_["1056ui_story"]
			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.characterEffect1056ui_story == nil then
				arg_57_1.var_.characterEffect1056ui_story = var_60_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_16 = 0.200000002980232

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_16 and not isNil(var_60_14) then
				local var_60_17 = (arg_57_1.time_ - var_60_15) / var_60_16

				if arg_57_1.var_.characterEffect1056ui_story and not isNil(var_60_14) then
					arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 and not isNil(var_60_14) and arg_57_1.var_.characterEffect1056ui_story then
				arg_57_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_60_18 = 0

			if var_60_18 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_60_19 = 0

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_60_20 = 0
			local var_60_21 = 0.25

			if var_60_20 < arg_57_1.time_ and arg_57_1.time_ <= var_60_20 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_22 = arg_57_1:FormatText(StoryNameCfg[605].name)

				arg_57_1.leftNameTxt_.text = var_60_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_23 = arg_57_1:GetWordFromCfg(320321014)
				local var_60_24 = arg_57_1:FormatText(var_60_23.content)

				arg_57_1.text_.text = var_60_24

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_25 = 10
				local var_60_26 = utf8.len(var_60_24)
				local var_60_27 = var_60_25 <= 0 and var_60_21 or var_60_21 * (var_60_26 / var_60_25)

				if var_60_27 > 0 and var_60_21 < var_60_27 then
					arg_57_1.talkMaxDuration = var_60_27

					if var_60_27 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_27 + var_60_20
					end
				end

				arg_57_1.text_.text = var_60_24
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321014", "story_v_out_320321.awb") ~= 0 then
					local var_60_28 = manager.audio:GetVoiceLength("story_v_out_320321", "320321014", "story_v_out_320321.awb") / 1000

					if var_60_28 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_20
					end

					if var_60_23.prefab_name ~= "" and arg_57_1.actors_[var_60_23.prefab_name] ~= nil then
						local var_60_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_23.prefab_name].transform, "story_v_out_320321", "320321014", "story_v_out_320321.awb")

						arg_57_1:RecordAudio("320321014", var_60_29)
						arg_57_1:RecordAudio("320321014", var_60_29)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320321", "320321014", "story_v_out_320321.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320321", "320321014", "story_v_out_320321.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_30 = math.max(var_60_21, arg_57_1.talkMaxDuration)

			if var_60_20 <= arg_57_1.time_ and arg_57_1.time_ < var_60_20 + var_60_30 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_20) / var_60_30

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_20 + var_60_30 and arg_57_1.time_ < var_60_20 + var_60_30 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play320321015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320321015
		arg_61_1.duration_ = 2.97

		local var_61_0 = {
			zh = 2.4,
			ja = 2.966
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
				arg_61_0:Play320321016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1056ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1056ui_story == nil then
				arg_61_1.var_.characterEffect1056ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1056ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1056ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1056ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1056ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.2

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[1044].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(320321015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321015", "story_v_out_320321.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_320321", "320321015", "story_v_out_320321.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_320321", "320321015", "story_v_out_320321.awb")

						arg_61_1:RecordAudio("320321015", var_64_15)
						arg_61_1:RecordAudio("320321015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320321", "320321015", "story_v_out_320321.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320321", "320321015", "story_v_out_320321.awb")
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
	Play320321016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320321016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320321017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1056ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1056ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1056ui_story, var_68_4, var_68_3)

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

			local var_68_9 = arg_65_1.actors_["1056ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1056ui_story == nil then
				arg_65_1.var_.characterEffect1056ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1056ui_story and not isNil(var_68_9) then
					local var_68_13 = Mathf.Lerp(0, 0.5, var_68_12)

					arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1056ui_story.fillRatio = var_68_13
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1056ui_story then
				local var_68_14 = 0.5

				arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1056ui_story.fillRatio = var_68_14
			end

			local var_68_15 = 0
			local var_68_16 = 0.825

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_17 = arg_65_1:GetWordFromCfg(320321016)
				local var_68_18 = arg_65_1:FormatText(var_68_17.content)

				arg_65_1.text_.text = var_68_18

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_19 = 33
				local var_68_20 = utf8.len(var_68_18)
				local var_68_21 = var_68_19 <= 0 and var_68_16 or var_68_16 * (var_68_20 / var_68_19)

				if var_68_21 > 0 and var_68_16 < var_68_21 then
					arg_65_1.talkMaxDuration = var_68_21

					if var_68_21 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_18
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_22 and arg_65_1.time_ < var_68_15 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play320321017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320321017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320321018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.3

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(320321017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 52
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320321018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320321018
		arg_73_1.duration_ = 7.07

		local var_73_0 = {
			zh = 3.566,
			ja = 7.066
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
				arg_73_0:Play320321019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1056ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1056ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -1, -5.75)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1056ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1056ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1056ui_story == nil then
				arg_73_1.var_.characterEffect1056ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1056ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1056ui_story then
				arg_73_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_15 = 0
			local var_76_16 = 0.35

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[605].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(320321018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 14
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321018", "story_v_out_320321.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_320321", "320321018", "story_v_out_320321.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_320321", "320321018", "story_v_out_320321.awb")

						arg_73_1:RecordAudio("320321018", var_76_24)
						arg_73_1:RecordAudio("320321018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320321", "320321018", "story_v_out_320321.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320321", "320321018", "story_v_out_320321.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play320321019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320321019
		arg_77_1.duration_ = 12.4

		local var_77_0 = {
			zh = 4.7,
			ja = 12.4
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
				arg_77_0:Play320321020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1056ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1056ui_story == nil then
				arg_77_1.var_.characterEffect1056ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1056ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1056ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1056ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1056ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.525

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[1044].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(320321019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 21
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321019", "story_v_out_320321.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_320321", "320321019", "story_v_out_320321.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_out_320321", "320321019", "story_v_out_320321.awb")

						arg_77_1:RecordAudio("320321019", var_80_15)
						arg_77_1:RecordAudio("320321019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320321", "320321019", "story_v_out_320321.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320321", "320321019", "story_v_out_320321.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_16 and arg_77_1.time_ < var_80_6 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320321020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320321020
		arg_81_1.duration_ = 13.47

		local var_81_0 = {
			zh = 9.233,
			ja = 13.466
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
				arg_81_0:Play320321021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.15

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1044].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(320321020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 46
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321020", "story_v_out_320321.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321020", "story_v_out_320321.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_320321", "320321020", "story_v_out_320321.awb")

						arg_81_1:RecordAudio("320321020", var_84_9)
						arg_81_1:RecordAudio("320321020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320321", "320321020", "story_v_out_320321.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320321", "320321020", "story_v_out_320321.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320321021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320321021
		arg_85_1.duration_ = 12.87

		local var_85_0 = {
			zh = 4.033,
			ja = 12.866
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
				arg_85_0:Play320321022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.5

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[1044].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(320321021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 20
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321021", "story_v_out_320321.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321021", "story_v_out_320321.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_320321", "320321021", "story_v_out_320321.awb")

						arg_85_1:RecordAudio("320321021", var_88_9)
						arg_85_1:RecordAudio("320321021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320321", "320321021", "story_v_out_320321.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320321", "320321021", "story_v_out_320321.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320321022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320321022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320321023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1056ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1056ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1056ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0
			local var_92_10 = 1.05

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_11 = arg_89_1:GetWordFromCfg(320321022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 42
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_10 or var_92_10 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_10 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_16 and arg_89_1.time_ < var_92_9 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play320321023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320321023
		arg_93_1.duration_ = 6.93

		local var_93_0 = {
			zh = 5.733,
			ja = 6.933
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
				arg_93_0:Play320321024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.6

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1032].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(320321023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321023", "story_v_out_320321.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321023", "story_v_out_320321.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_320321", "320321023", "story_v_out_320321.awb")

						arg_93_1:RecordAudio("320321023", var_96_9)
						arg_93_1:RecordAudio("320321023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320321", "320321023", "story_v_out_320321.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320321", "320321023", "story_v_out_320321.awb")
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
	Play320321024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320321024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320321025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.675

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(320321024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 27
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320321025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320321025
		arg_101_1.duration_ = 3.9

		local var_101_0 = {
			zh = 3.9,
			ja = 3.433
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
				arg_101_0:Play320321026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1056ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1056ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1, -5.75)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1056ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1056ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1056ui_story == nil then
				arg_101_1.var_.characterEffect1056ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1056ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1056ui_story then
				arg_101_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action7_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_104_15 = 0
			local var_104_16 = 0.375

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[605].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(320321025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 15
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321025", "story_v_out_320321.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_320321", "320321025", "story_v_out_320321.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_320321", "320321025", "story_v_out_320321.awb")

						arg_101_1:RecordAudio("320321025", var_104_24)
						arg_101_1:RecordAudio("320321025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320321", "320321025", "story_v_out_320321.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320321", "320321025", "story_v_out_320321.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play320321026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320321026
		arg_105_1.duration_ = 11.58

		local var_105_0 = {
			zh = 6.375,
			ja = 11.575
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
				arg_105_0:Play320321027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_1 = 3.15833333333333

			if arg_105_1.time_ >= var_108_0 + var_108_1 and arg_105_1.time_ < var_108_0 + var_108_1 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_2 = "ST61"

			if arg_105_1.bgs_[var_108_2] == nil then
				local var_108_3 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_2)
				var_108_3.name = var_108_2
				var_108_3.transform.parent = arg_105_1.stage_.transform
				var_108_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_2] = var_108_3
			end

			local var_108_4 = 1.5

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				local var_108_5 = manager.ui.mainCamera.transform.localPosition
				local var_108_6 = Vector3.New(0, 0, 10) + Vector3.New(var_108_5.x, var_108_5.y, 0)
				local var_108_7 = arg_105_1.bgs_.ST61

				var_108_7.transform.localPosition = var_108_6
				var_108_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_8 = var_108_7:GetComponent("SpriteRenderer")

				if var_108_8 and var_108_8.sprite then
					local var_108_9 = (var_108_7.transform.localPosition - var_108_5).z
					local var_108_10 = manager.ui.mainCameraCom_
					local var_108_11 = 2 * var_108_9 * Mathf.Tan(var_108_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_12 = var_108_11 * var_108_10.aspect
					local var_108_13 = var_108_8.sprite.bounds.size.x
					local var_108_14 = var_108_8.sprite.bounds.size.y
					local var_108_15 = var_108_12 / var_108_13
					local var_108_16 = var_108_11 / var_108_14
					local var_108_17 = var_108_16 < var_108_15 and var_108_15 or var_108_16

					var_108_7.transform.localScale = Vector3.New(var_108_17, var_108_17, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST61" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_18 = 0

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_19 = 1.5

			if var_108_18 <= arg_105_1.time_ and arg_105_1.time_ < var_108_18 + var_108_19 then
				local var_108_20 = (arg_105_1.time_ - var_108_18) / var_108_19
				local var_108_21 = Color.New(0, 0, 0)

				var_108_21.a = Mathf.Lerp(0, 1, var_108_20)
				arg_105_1.mask_.color = var_108_21
			end

			if arg_105_1.time_ >= var_108_18 + var_108_19 and arg_105_1.time_ < var_108_18 + var_108_19 + arg_108_0 then
				local var_108_22 = Color.New(0, 0, 0)

				var_108_22.a = 1
				arg_105_1.mask_.color = var_108_22
			end

			local var_108_23 = 1.5

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_24 = 1.875

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_24 then
				local var_108_25 = (arg_105_1.time_ - var_108_23) / var_108_24
				local var_108_26 = Color.New(0, 0, 0)

				var_108_26.a = Mathf.Lerp(1, 0, var_108_25)
				arg_105_1.mask_.color = var_108_26
			end

			if arg_105_1.time_ >= var_108_23 + var_108_24 and arg_105_1.time_ < var_108_23 + var_108_24 + arg_108_0 then
				local var_108_27 = Color.New(0, 0, 0)
				local var_108_28 = 0

				arg_105_1.mask_.enabled = false
				var_108_27.a = var_108_28
				arg_105_1.mask_.color = var_108_27
			end

			local var_108_29 = arg_105_1.actors_["1056ui_story"].transform
			local var_108_30 = 1.46599999815226

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.var_.moveOldPos1056ui_story = var_108_29.localPosition
			end

			local var_108_31 = 0.001

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_31 then
				local var_108_32 = (arg_105_1.time_ - var_108_30) / var_108_31
				local var_108_33 = Vector3.New(0, 100, 0)

				var_108_29.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1056ui_story, var_108_33, var_108_32)

				local var_108_34 = manager.ui.mainCamera.transform.position - var_108_29.position

				var_108_29.forward = Vector3.New(var_108_34.x, var_108_34.y, var_108_34.z)

				local var_108_35 = var_108_29.localEulerAngles

				var_108_35.z = 0
				var_108_35.x = 0
				var_108_29.localEulerAngles = var_108_35
			end

			if arg_105_1.time_ >= var_108_30 + var_108_31 and arg_105_1.time_ < var_108_30 + var_108_31 + arg_108_0 then
				var_108_29.localPosition = Vector3.New(0, 100, 0)

				local var_108_36 = manager.ui.mainCamera.transform.position - var_108_29.position

				var_108_29.forward = Vector3.New(var_108_36.x, var_108_36.y, var_108_36.z)

				local var_108_37 = var_108_29.localEulerAngles

				var_108_37.z = 0
				var_108_37.x = 0
				var_108_29.localEulerAngles = var_108_37
			end

			local var_108_38 = "1089ui_story"

			if arg_105_1.actors_[var_108_38] == nil then
				local var_108_39 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_108_39) then
					local var_108_40 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_105_1.stage_.transform)

					var_108_40.name = var_108_38
					var_108_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_38] = var_108_40

					local var_108_41 = var_108_40:GetComponentInChildren(typeof(CharacterEffect))

					var_108_41.enabled = true

					local var_108_42 = GameObjectTools.GetOrAddComponent(var_108_40, typeof(DynamicBoneHelper))

					if var_108_42 then
						var_108_42:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_41.transform, false)

					arg_105_1.var_[var_108_38 .. "Animator"] = var_108_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_38 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_38 .. "LipSync"] = var_108_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_43 = arg_105_1.actors_["1089ui_story"].transform
			local var_108_44 = 2.99933333148559

			if var_108_44 < arg_105_1.time_ and arg_105_1.time_ <= var_108_44 + arg_108_0 then
				arg_105_1.var_.moveOldPos1089ui_story = var_108_43.localPosition
			end

			local var_108_45 = 0.001

			if var_108_44 <= arg_105_1.time_ and arg_105_1.time_ < var_108_44 + var_108_45 then
				local var_108_46 = (arg_105_1.time_ - var_108_44) / var_108_45
				local var_108_47 = Vector3.New(0, -1.1, -6.17)

				var_108_43.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1089ui_story, var_108_47, var_108_46)

				local var_108_48 = manager.ui.mainCamera.transform.position - var_108_43.position

				var_108_43.forward = Vector3.New(var_108_48.x, var_108_48.y, var_108_48.z)

				local var_108_49 = var_108_43.localEulerAngles

				var_108_49.z = 0
				var_108_49.x = 0
				var_108_43.localEulerAngles = var_108_49
			end

			if arg_105_1.time_ >= var_108_44 + var_108_45 and arg_105_1.time_ < var_108_44 + var_108_45 + arg_108_0 then
				var_108_43.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_108_50 = manager.ui.mainCamera.transform.position - var_108_43.position

				var_108_43.forward = Vector3.New(var_108_50.x, var_108_50.y, var_108_50.z)

				local var_108_51 = var_108_43.localEulerAngles

				var_108_51.z = 0
				var_108_51.x = 0
				var_108_43.localEulerAngles = var_108_51
			end

			local var_108_52 = arg_105_1.actors_["1089ui_story"]
			local var_108_53 = 3

			if var_108_53 < arg_105_1.time_ and arg_105_1.time_ <= var_108_53 + arg_108_0 and not isNil(var_108_52) and arg_105_1.var_.characterEffect1089ui_story == nil then
				arg_105_1.var_.characterEffect1089ui_story = var_108_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_54 = 0.200000002980232

			if var_108_53 <= arg_105_1.time_ and arg_105_1.time_ < var_108_53 + var_108_54 and not isNil(var_108_52) then
				local var_108_55 = (arg_105_1.time_ - var_108_53) / var_108_54

				if arg_105_1.var_.characterEffect1089ui_story and not isNil(var_108_52) then
					arg_105_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_53 + var_108_54 and arg_105_1.time_ < var_108_53 + var_108_54 + arg_108_0 and not isNil(var_108_52) and arg_105_1.var_.characterEffect1089ui_story then
				arg_105_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_108_56 = 2.99933333148559

			if var_108_56 < arg_105_1.time_ and arg_105_1.time_ <= var_108_56 + arg_108_0 then
				arg_105_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			local var_108_57 = 2.99933333148559

			if var_108_57 < arg_105_1.time_ and arg_105_1.time_ <= var_108_57 + arg_108_0 then
				arg_105_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_58 = 3.375
			local var_108_59 = 0.125

			if var_108_58 < arg_105_1.time_ and arg_105_1.time_ <= var_108_58 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_60 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_60:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_61 = arg_105_1:FormatText(StoryNameCfg[1031].name)

				arg_105_1.leftNameTxt_.text = var_108_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_62 = arg_105_1:GetWordFromCfg(320321026)
				local var_108_63 = arg_105_1:FormatText(var_108_62.content)

				arg_105_1.text_.text = var_108_63

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_64 = 5
				local var_108_65 = utf8.len(var_108_63)
				local var_108_66 = var_108_64 <= 0 and var_108_59 or var_108_59 * (var_108_65 / var_108_64)

				if var_108_66 > 0 and var_108_59 < var_108_66 then
					arg_105_1.talkMaxDuration = var_108_66
					var_108_58 = var_108_58 + 0.3

					if var_108_66 + var_108_58 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_66 + var_108_58
					end
				end

				arg_105_1.text_.text = var_108_63
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321026", "story_v_out_320321.awb") ~= 0 then
					local var_108_67 = manager.audio:GetVoiceLength("story_v_out_320321", "320321026", "story_v_out_320321.awb") / 1000

					if var_108_67 + var_108_58 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_67 + var_108_58
					end

					if var_108_62.prefab_name ~= "" and arg_105_1.actors_[var_108_62.prefab_name] ~= nil then
						local var_108_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_62.prefab_name].transform, "story_v_out_320321", "320321026", "story_v_out_320321.awb")

						arg_105_1:RecordAudio("320321026", var_108_68)
						arg_105_1:RecordAudio("320321026", var_108_68)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320321", "320321026", "story_v_out_320321.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320321", "320321026", "story_v_out_320321.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_69 = var_108_58 + 0.3
			local var_108_70 = math.max(var_108_59, arg_105_1.talkMaxDuration)

			if var_108_69 <= arg_105_1.time_ and arg_105_1.time_ < var_108_69 + var_108_70 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_69) / var_108_70

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_69 + var_108_70 and arg_105_1.time_ < var_108_69 + var_108_70 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.99933333148559,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play320321027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 320321027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play320321028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1089ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1089ui_story == nil then
				arg_111_1.var_.characterEffect1089ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.0166666666666667

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1089ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1089ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1089ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1089ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 1.25

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(320321027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 50
				local var_114_11 = utf8.len(var_114_9)
				local var_114_12 = var_114_10 <= 0 and var_114_7 or var_114_7 * (var_114_11 / var_114_10)

				if var_114_12 > 0 and var_114_7 < var_114_12 then
					arg_111_1.talkMaxDuration = var_114_12

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_13 and arg_111_1.time_ < var_114_6 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play320321028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 320321028
		arg_115_1.duration_ = 8.2

		local var_115_0 = {
			zh = 8.2,
			ja = 6.833
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play320321029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1089ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1089ui_story == nil then
				arg_115_1.var_.characterEffect1089ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1089ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1089ui_story then
				arg_115_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_118_6 = 0
			local var_118_7 = 0.7

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[1031].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_9 = arg_115_1:GetWordFromCfg(320321028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 28
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321028", "story_v_out_320321.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_320321", "320321028", "story_v_out_320321.awb") / 1000

					if var_118_14 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_6
					end

					if var_118_9.prefab_name ~= "" and arg_115_1.actors_[var_118_9.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_9.prefab_name].transform, "story_v_out_320321", "320321028", "story_v_out_320321.awb")

						arg_115_1:RecordAudio("320321028", var_118_15)
						arg_115_1:RecordAudio("320321028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_320321", "320321028", "story_v_out_320321.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_320321", "320321028", "story_v_out_320321.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_16 and arg_115_1.time_ < var_118_6 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play320321029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 320321029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play320321030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1089ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1089ui_story == nil then
				arg_119_1.var_.characterEffect1089ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.1

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1089ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1089ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1089ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1089ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.525

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(320321029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 21
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play320321030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320321030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320321031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.625

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(320321030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 65
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play320321031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320321031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play320321032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 1.45

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(320321031)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 58
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play320321032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 320321032
		arg_131_1.duration_ = 8.13

		local var_131_0 = {
			zh = 7.4,
			ja = 8.133
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play320321033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1089ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1089ui_story == nil then
				arg_131_1.var_.characterEffect1089ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1089ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1089ui_story then
				arg_131_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_134_6 = 0
			local var_134_7 = 0.75

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[1031].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_9 = arg_131_1:GetWordFromCfg(320321032)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 30
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321032", "story_v_out_320321.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_320321", "320321032", "story_v_out_320321.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_out_320321", "320321032", "story_v_out_320321.awb")

						arg_131_1:RecordAudio("320321032", var_134_15)
						arg_131_1:RecordAudio("320321032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_320321", "320321032", "story_v_out_320321.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_320321", "320321032", "story_v_out_320321.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_16 and arg_131_1.time_ < var_134_6 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play320321033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 320321033
		arg_135_1.duration_ = 3.8

		local var_135_0 = {
			zh = 3.266,
			ja = 3.8
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
				arg_135_0:Play320321034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.275

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1031].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(320321033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 11
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321033", "story_v_out_320321.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321033", "story_v_out_320321.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_320321", "320321033", "story_v_out_320321.awb")

						arg_135_1:RecordAudio("320321033", var_138_9)
						arg_135_1:RecordAudio("320321033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_320321", "320321033", "story_v_out_320321.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_320321", "320321033", "story_v_out_320321.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play320321034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 320321034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play320321035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1089ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1089ui_story == nil then
				arg_139_1.var_.characterEffect1089ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.0666666666666667

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1089ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1089ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1089ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1089ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.75

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(320321034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 30
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play320321035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 320321035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play320321036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.15

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(320321035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 46
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play320321036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 320321036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play320321037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.425

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(320321036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 17
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play320321037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 320321037
		arg_151_1.duration_ = 10.5

		local var_151_0 = {
			zh = 6.233,
			ja = 10.5
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
				arg_151_0:Play320321038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1089ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1089ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -1.1, -6.17)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1089ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1089ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1089ui_story == nil then
				arg_151_1.var_.characterEffect1089ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1089ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1089ui_story then
				arg_151_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action435")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_154_15 = 0
			local var_154_16 = 0.625

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[1031].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(320321037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 25
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321037", "story_v_out_320321.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_320321", "320321037", "story_v_out_320321.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_320321", "320321037", "story_v_out_320321.awb")

						arg_151_1:RecordAudio("320321037", var_154_24)
						arg_151_1:RecordAudio("320321037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_320321", "320321037", "story_v_out_320321.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_320321", "320321037", "story_v_out_320321.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play320321038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 320321038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play320321039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1089ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1089ui_story == nil then
				arg_155_1.var_.characterEffect1089ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.075

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1089ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1089ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1089ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1089ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.075

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_9 = arg_155_1:GetWordFromCfg(320321038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 3
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play320321039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 320321039
		arg_159_1.duration_ = 14.3

		local var_159_0 = {
			zh = 10.166,
			ja = 14.3
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
				arg_159_0:Play320321040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1089ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1089ui_story == nil then
				arg_159_1.var_.characterEffect1089ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1089ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1089ui_story then
				arg_159_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_162_5 = 0
			local var_162_6 = 0.975

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_7 = arg_159_1:FormatText(StoryNameCfg[1031].name)

				arg_159_1.leftNameTxt_.text = var_162_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(320321039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 39
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_6 or var_162_6 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_6 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321039", "story_v_out_320321.awb") ~= 0 then
					local var_162_13 = manager.audio:GetVoiceLength("story_v_out_320321", "320321039", "story_v_out_320321.awb") / 1000

					if var_162_13 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_5
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_320321", "320321039", "story_v_out_320321.awb")

						arg_159_1:RecordAudio("320321039", var_162_14)
						arg_159_1:RecordAudio("320321039", var_162_14)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_320321", "320321039", "story_v_out_320321.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_320321", "320321039", "story_v_out_320321.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_15 and arg_159_1.time_ < var_162_5 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play320321040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 320321040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play320321041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1089ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1089ui_story == nil then
				arg_163_1.var_.characterEffect1089ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.0666666666666667

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1089ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1089ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1089ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1089ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.425

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(320321040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 17
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play320321041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 320321041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play320321042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.225

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(320321041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 49
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play320321042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320321042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play320321043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_174_1 = 0
			local var_174_2 = 0.825

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_3 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_4 = arg_171_1:GetWordFromCfg(320321042)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_6 = 33
				local var_174_7 = utf8.len(var_174_5)
				local var_174_8 = var_174_6 <= 0 and var_174_2 or var_174_2 * (var_174_7 / var_174_6)

				if var_174_8 > 0 and var_174_2 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_9 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_9 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_9

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_9 and arg_171_1.time_ < var_174_1 + var_174_9 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play320321043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320321043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play320321044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.075

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(320321043)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 43
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play320321044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320321044
		arg_179_1.duration_ = 8.37

		local var_179_0 = {
			zh = 3.1,
			ja = 8.366
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
				arg_179_0:Play320321045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1089ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1089ui_story == nil then
				arg_179_1.var_.characterEffect1089ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1089ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1089ui_story then
				arg_179_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_182_4 = 0
			local var_182_5 = 0.325

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_6 = arg_179_1:FormatText(StoryNameCfg[1031].name)

				arg_179_1.leftNameTxt_.text = var_182_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(320321044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 13
				local var_182_10 = utf8.len(var_182_8)
				local var_182_11 = var_182_9 <= 0 and var_182_5 or var_182_5 * (var_182_10 / var_182_9)

				if var_182_11 > 0 and var_182_5 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321044", "story_v_out_320321.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_320321", "320321044", "story_v_out_320321.awb") / 1000

					if var_182_12 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_4
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_320321", "320321044", "story_v_out_320321.awb")

						arg_179_1:RecordAudio("320321044", var_182_13)
						arg_179_1:RecordAudio("320321044", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_320321", "320321044", "story_v_out_320321.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_320321", "320321044", "story_v_out_320321.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_14 and arg_179_1.time_ < var_182_4 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play320321045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320321045
		arg_183_1.duration_ = 5.33

		local var_183_0 = {
			zh = 5.333,
			ja = 5.166
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
				arg_183_0:Play320321046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_1 = 0.4
			local var_186_2 = 0.55

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_3 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_3:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_4 = arg_183_1:FormatText(StoryNameCfg[1031].name)

				arg_183_1.leftNameTxt_.text = var_186_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(320321045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 22
				local var_186_8 = utf8.len(var_186_6)
				local var_186_9 = var_186_7 <= 0 and var_186_2 or var_186_2 * (var_186_8 / var_186_7)

				if var_186_9 > 0 and var_186_2 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9
					var_186_1 = var_186_1 + 0.3

					if var_186_9 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321045", "story_v_out_320321.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_320321", "320321045", "story_v_out_320321.awb") / 1000

					if var_186_10 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_1
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_320321", "320321045", "story_v_out_320321.awb")

						arg_183_1:RecordAudio("320321045", var_186_11)
						arg_183_1:RecordAudio("320321045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320321", "320321045", "story_v_out_320321.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320321", "320321045", "story_v_out_320321.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = var_186_1 + 0.3
			local var_186_13 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_13 and arg_183_1.time_ < var_186_12 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play320321046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320321046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play320321047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1089ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1089ui_story == nil then
				arg_189_1.var_.characterEffect1089ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.05

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1089ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1089ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1089ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1089ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.166666666666667

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(320321046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 2
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play320321047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320321047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320321048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1089ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1089ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, 100, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1089ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, 100, 0)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = 0
			local var_196_10 = 1

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_11 = arg_193_1:GetWordFromCfg(320321047)
				local var_196_12 = arg_193_1:FormatText(var_196_11.content)

				arg_193_1.text_.text = var_196_12

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 40
				local var_196_14 = utf8.len(var_196_12)
				local var_196_15 = var_196_13 <= 0 and var_196_10 or var_196_10 * (var_196_14 / var_196_13)

				if var_196_15 > 0 and var_196_10 < var_196_15 then
					arg_193_1.talkMaxDuration = var_196_15

					if var_196_15 + var_196_9 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_15 + var_196_9
					end
				end

				arg_193_1.text_.text = var_196_12
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_10, arg_193_1.talkMaxDuration)

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_9) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_9 + var_196_16 and arg_193_1.time_ < var_196_9 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play320321048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320321048
		arg_197_1.duration_ = 3.97

		local var_197_0 = {
			zh = 3.966,
			ja = 3.633
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
				arg_197_0:Play320321049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "10102ui_story"

			if arg_197_1.actors_[var_200_0] == nil then
				local var_200_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_200_1) then
					local var_200_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_197_1.stage_.transform)

					var_200_2.name = var_200_0
					var_200_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_197_1.actors_[var_200_0] = var_200_2

					local var_200_3 = var_200_2:GetComponentInChildren(typeof(CharacterEffect))

					var_200_3.enabled = true

					local var_200_4 = GameObjectTools.GetOrAddComponent(var_200_2, typeof(DynamicBoneHelper))

					if var_200_4 then
						var_200_4:EnableDynamicBone(false)
					end

					arg_197_1:ShowWeapon(var_200_3.transform, false)

					arg_197_1.var_[var_200_0 .. "Animator"] = var_200_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_197_1.var_[var_200_0 .. "Animator"].applyRootMotion = true
					arg_197_1.var_[var_200_0 .. "LipSync"] = var_200_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_200_5 = arg_197_1.actors_["10102ui_story"].transform
			local var_200_6 = 0

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.var_.moveOldPos10102ui_story = var_200_5.localPosition
			end

			local var_200_7 = 0.001

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_7 then
				local var_200_8 = (arg_197_1.time_ - var_200_6) / var_200_7
				local var_200_9 = Vector3.New(0, -0.985, -6.275)

				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10102ui_story, var_200_9, var_200_8)

				local var_200_10 = manager.ui.mainCamera.transform.position - var_200_5.position

				var_200_5.forward = Vector3.New(var_200_10.x, var_200_10.y, var_200_10.z)

				local var_200_11 = var_200_5.localEulerAngles

				var_200_11.z = 0
				var_200_11.x = 0
				var_200_5.localEulerAngles = var_200_11
			end

			if arg_197_1.time_ >= var_200_6 + var_200_7 and arg_197_1.time_ < var_200_6 + var_200_7 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_200_12 = manager.ui.mainCamera.transform.position - var_200_5.position

				var_200_5.forward = Vector3.New(var_200_12.x, var_200_12.y, var_200_12.z)

				local var_200_13 = var_200_5.localEulerAngles

				var_200_13.z = 0
				var_200_13.x = 0
				var_200_5.localEulerAngles = var_200_13
			end

			local var_200_14 = arg_197_1.actors_["10102ui_story"]
			local var_200_15 = 0

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.characterEffect10102ui_story == nil then
				arg_197_1.var_.characterEffect10102ui_story = var_200_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_16 = 0.200000002980232

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_16 and not isNil(var_200_14) then
				local var_200_17 = (arg_197_1.time_ - var_200_15) / var_200_16

				if arg_197_1.var_.characterEffect10102ui_story and not isNil(var_200_14) then
					arg_197_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_15 + var_200_16 and arg_197_1.time_ < var_200_15 + var_200_16 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.characterEffect10102ui_story then
				arg_197_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_200_18 = 0

			if var_200_18 < arg_197_1.time_ and arg_197_1.time_ <= var_200_18 + arg_200_0 then
				arg_197_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_200_20 = 0
			local var_200_21 = 0.5

			if var_200_20 < arg_197_1.time_ and arg_197_1.time_ <= var_200_20 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_22 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_23 = arg_197_1:GetWordFromCfg(320321048)
				local var_200_24 = arg_197_1:FormatText(var_200_23.content)

				arg_197_1.text_.text = var_200_24

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_25 = 20
				local var_200_26 = utf8.len(var_200_24)
				local var_200_27 = var_200_25 <= 0 and var_200_21 or var_200_21 * (var_200_26 / var_200_25)

				if var_200_27 > 0 and var_200_21 < var_200_27 then
					arg_197_1.talkMaxDuration = var_200_27

					if var_200_27 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_27 + var_200_20
					end
				end

				arg_197_1.text_.text = var_200_24
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321048", "story_v_out_320321.awb") ~= 0 then
					local var_200_28 = manager.audio:GetVoiceLength("story_v_out_320321", "320321048", "story_v_out_320321.awb") / 1000

					if var_200_28 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_20
					end

					if var_200_23.prefab_name ~= "" and arg_197_1.actors_[var_200_23.prefab_name] ~= nil then
						local var_200_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_23.prefab_name].transform, "story_v_out_320321", "320321048", "story_v_out_320321.awb")

						arg_197_1:RecordAudio("320321048", var_200_29)
						arg_197_1:RecordAudio("320321048", var_200_29)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320321", "320321048", "story_v_out_320321.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320321", "320321048", "story_v_out_320321.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_30 = math.max(var_200_21, arg_197_1.talkMaxDuration)

			if var_200_20 <= arg_197_1.time_ and arg_197_1.time_ < var_200_20 + var_200_30 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_20) / var_200_30

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_20 + var_200_30 and arg_197_1.time_ < var_200_20 + var_200_30 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play320321049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320321049
		arg_201_1.duration_ = 8.03

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play320321050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = "ST0505"

			if arg_201_1.bgs_[var_204_0] == nil then
				local var_204_1 = Object.Instantiate(arg_201_1.paintGo_)

				var_204_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_204_0)
				var_204_1.name = var_204_0
				var_204_1.transform.parent = arg_201_1.stage_.transform
				var_204_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.bgs_[var_204_0] = var_204_1
			end

			local var_204_2 = 1.5

			if var_204_2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				local var_204_3 = manager.ui.mainCamera.transform.localPosition
				local var_204_4 = Vector3.New(0, 0, 10) + Vector3.New(var_204_3.x, var_204_3.y, 0)
				local var_204_5 = arg_201_1.bgs_.ST0505

				var_204_5.transform.localPosition = var_204_4
				var_204_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_6 = var_204_5:GetComponent("SpriteRenderer")

				if var_204_6 and var_204_6.sprite then
					local var_204_7 = (var_204_5.transform.localPosition - var_204_3).z
					local var_204_8 = manager.ui.mainCameraCom_
					local var_204_9 = 2 * var_204_7 * Mathf.Tan(var_204_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_10 = var_204_9 * var_204_8.aspect
					local var_204_11 = var_204_6.sprite.bounds.size.x
					local var_204_12 = var_204_6.sprite.bounds.size.y
					local var_204_13 = var_204_10 / var_204_11
					local var_204_14 = var_204_9 / var_204_12
					local var_204_15 = var_204_14 < var_204_13 and var_204_13 or var_204_14

					var_204_5.transform.localScale = Vector3.New(var_204_15, var_204_15, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "ST0505" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_17 = 3.03333333333333

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_18 = 0

			if var_204_18 < arg_201_1.time_ and arg_201_1.time_ <= var_204_18 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_19 = 1.5

			if var_204_18 <= arg_201_1.time_ and arg_201_1.time_ < var_204_18 + var_204_19 then
				local var_204_20 = (arg_201_1.time_ - var_204_18) / var_204_19
				local var_204_21 = Color.New(0, 0, 0)

				var_204_21.a = Mathf.Lerp(0, 1, var_204_20)
				arg_201_1.mask_.color = var_204_21
			end

			if arg_201_1.time_ >= var_204_18 + var_204_19 and arg_201_1.time_ < var_204_18 + var_204_19 + arg_204_0 then
				local var_204_22 = Color.New(0, 0, 0)

				var_204_22.a = 1
				arg_201_1.mask_.color = var_204_22
			end

			local var_204_23 = 1.5

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_24 = 1.53333333333333

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24
				local var_204_26 = Color.New(0, 0, 0)

				var_204_26.a = Mathf.Lerp(1, 0, var_204_25)
				arg_201_1.mask_.color = var_204_26
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 then
				local var_204_27 = Color.New(0, 0, 0)
				local var_204_28 = 0

				arg_201_1.mask_.enabled = false
				var_204_27.a = var_204_28
				arg_201_1.mask_.color = var_204_27
			end

			local var_204_29 = arg_201_1.actors_["10102ui_story"].transform
			local var_204_30 = 1.46666666666667

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.var_.moveOldPos10102ui_story = var_204_29.localPosition
			end

			local var_204_31 = 0.001

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_31 then
				local var_204_32 = (arg_201_1.time_ - var_204_30) / var_204_31
				local var_204_33 = Vector3.New(0, 100, 0)

				var_204_29.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10102ui_story, var_204_33, var_204_32)

				local var_204_34 = manager.ui.mainCamera.transform.position - var_204_29.position

				var_204_29.forward = Vector3.New(var_204_34.x, var_204_34.y, var_204_34.z)

				local var_204_35 = var_204_29.localEulerAngles

				var_204_35.z = 0
				var_204_35.x = 0
				var_204_29.localEulerAngles = var_204_35
			end

			if arg_201_1.time_ >= var_204_30 + var_204_31 and arg_201_1.time_ < var_204_30 + var_204_31 + arg_204_0 then
				var_204_29.localPosition = Vector3.New(0, 100, 0)

				local var_204_36 = manager.ui.mainCamera.transform.position - var_204_29.position

				var_204_29.forward = Vector3.New(var_204_36.x, var_204_36.y, var_204_36.z)

				local var_204_37 = var_204_29.localEulerAngles

				var_204_37.z = 0
				var_204_37.x = 0
				var_204_29.localEulerAngles = var_204_37
			end

			local var_204_38 = 0
			local var_204_39 = 0.2

			if var_204_38 < arg_201_1.time_ and arg_201_1.time_ <= var_204_38 + arg_204_0 then
				local var_204_40 = "play"
				local var_204_41 = "music"

				arg_201_1:AudioAction(var_204_40, var_204_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_204_42 = ""
				local var_204_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_204_43 ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_43 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_43

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_43
						arg_201_1.bgmTxt2_.text = var_204_43
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_204_44 = 1.03333333333333
			local var_204_45 = 1

			if var_204_44 < arg_201_1.time_ and arg_201_1.time_ <= var_204_44 + arg_204_0 then
				local var_204_46 = "play"
				local var_204_47 = "music"

				arg_201_1:AudioAction(var_204_46, var_204_47, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_204_48 = ""
				local var_204_49 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_204_49 ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_49 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_49

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_49
						arg_201_1.bgmTxt2_.text = var_204_49
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_50 = 3.03333333333333
			local var_204_51 = 0.7

			if var_204_50 < arg_201_1.time_ and arg_201_1.time_ <= var_204_50 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_52 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_52:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_201_1.dialogCg_.alpha = arg_207_0
				end))
				var_204_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_53 = arg_201_1:GetWordFromCfg(320321049)
				local var_204_54 = arg_201_1:FormatText(var_204_53.content)

				arg_201_1.text_.text = var_204_54

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_55 = 28
				local var_204_56 = utf8.len(var_204_54)
				local var_204_57 = var_204_55 <= 0 and var_204_51 or var_204_51 * (var_204_56 / var_204_55)

				if var_204_57 > 0 and var_204_51 < var_204_57 then
					arg_201_1.talkMaxDuration = var_204_57
					var_204_50 = var_204_50 + 0.3

					if var_204_57 + var_204_50 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_57 + var_204_50
					end
				end

				arg_201_1.text_.text = var_204_54
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_58 = var_204_50 + 0.3
			local var_204_59 = math.max(var_204_51, arg_201_1.talkMaxDuration)

			if var_204_58 <= arg_201_1.time_ and arg_201_1.time_ < var_204_58 + var_204_59 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_58) / var_204_59

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_58 + var_204_59 and arg_201_1.time_ < var_204_58 + var_204_59 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play320321050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320321050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play320321051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_1 = 1

			if arg_209_1.time_ >= var_212_0 + var_212_1 and arg_209_1.time_ < var_212_0 + var_212_1 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_2 = 0
			local var_212_3 = 1.55

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(320321050)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 62
				local var_212_7 = utf8.len(var_212_5)
				local var_212_8 = var_212_6 <= 0 and var_212_3 or var_212_3 * (var_212_7 / var_212_6)

				if var_212_8 > 0 and var_212_3 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_9 and arg_209_1.time_ < var_212_2 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play320321051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320321051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play320321052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.425

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(320321051)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 57
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320321052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320321052
		arg_217_1.duration_ = 3.33

		local var_217_0 = {
			zh = 3.333,
			ja = 3.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320321053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = "1011ui_story"

			if arg_217_1.actors_[var_220_0] == nil then
				local var_220_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_220_1) then
					local var_220_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_217_1.stage_.transform)

					var_220_2.name = var_220_0
					var_220_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_217_1.actors_[var_220_0] = var_220_2

					local var_220_3 = var_220_2:GetComponentInChildren(typeof(CharacterEffect))

					var_220_3.enabled = true

					local var_220_4 = GameObjectTools.GetOrAddComponent(var_220_2, typeof(DynamicBoneHelper))

					if var_220_4 then
						var_220_4:EnableDynamicBone(false)
					end

					arg_217_1:ShowWeapon(var_220_3.transform, false)

					arg_217_1.var_[var_220_0 .. "Animator"] = var_220_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_217_1.var_[var_220_0 .. "Animator"].applyRootMotion = true
					arg_217_1.var_[var_220_0 .. "LipSync"] = var_220_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_220_5 = arg_217_1.actors_["1011ui_story"].transform
			local var_220_6 = 0

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.var_.moveOldPos1011ui_story = var_220_5.localPosition
			end

			local var_220_7 = 0.001

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_7 then
				local var_220_8 = (arg_217_1.time_ - var_220_6) / var_220_7
				local var_220_9 = Vector3.New(0, -0.71, -6)

				var_220_5.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1011ui_story, var_220_9, var_220_8)

				local var_220_10 = manager.ui.mainCamera.transform.position - var_220_5.position

				var_220_5.forward = Vector3.New(var_220_10.x, var_220_10.y, var_220_10.z)

				local var_220_11 = var_220_5.localEulerAngles

				var_220_11.z = 0
				var_220_11.x = 0
				var_220_5.localEulerAngles = var_220_11
			end

			if arg_217_1.time_ >= var_220_6 + var_220_7 and arg_217_1.time_ < var_220_6 + var_220_7 + arg_220_0 then
				var_220_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_220_12 = manager.ui.mainCamera.transform.position - var_220_5.position

				var_220_5.forward = Vector3.New(var_220_12.x, var_220_12.y, var_220_12.z)

				local var_220_13 = var_220_5.localEulerAngles

				var_220_13.z = 0
				var_220_13.x = 0
				var_220_5.localEulerAngles = var_220_13
			end

			local var_220_14 = arg_217_1.actors_["1011ui_story"]
			local var_220_15 = 0

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = var_220_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_16 = 0.200000002980232

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_16 and not isNil(var_220_14) then
				local var_220_17 = (arg_217_1.time_ - var_220_15) / var_220_16

				if arg_217_1.var_.characterEffect1011ui_story and not isNil(var_220_14) then
					arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_15 + var_220_16 and arg_217_1.time_ < var_220_15 + var_220_16 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.characterEffect1011ui_story then
				arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_220_18 = 0

			if var_220_18 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_220_20 = 0
			local var_220_21 = 0.175

			if var_220_20 < arg_217_1.time_ and arg_217_1.time_ <= var_220_20 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_22 = arg_217_1:FormatText(StoryNameCfg[37].name)

				arg_217_1.leftNameTxt_.text = var_220_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_23 = arg_217_1:GetWordFromCfg(320321052)
				local var_220_24 = arg_217_1:FormatText(var_220_23.content)

				arg_217_1.text_.text = var_220_24

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_25 = 7
				local var_220_26 = utf8.len(var_220_24)
				local var_220_27 = var_220_25 <= 0 and var_220_21 or var_220_21 * (var_220_26 / var_220_25)

				if var_220_27 > 0 and var_220_21 < var_220_27 then
					arg_217_1.talkMaxDuration = var_220_27

					if var_220_27 + var_220_20 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_27 + var_220_20
					end
				end

				arg_217_1.text_.text = var_220_24
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321052", "story_v_out_320321.awb") ~= 0 then
					local var_220_28 = manager.audio:GetVoiceLength("story_v_out_320321", "320321052", "story_v_out_320321.awb") / 1000

					if var_220_28 + var_220_20 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_28 + var_220_20
					end

					if var_220_23.prefab_name ~= "" and arg_217_1.actors_[var_220_23.prefab_name] ~= nil then
						local var_220_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_23.prefab_name].transform, "story_v_out_320321", "320321052", "story_v_out_320321.awb")

						arg_217_1:RecordAudio("320321052", var_220_29)
						arg_217_1:RecordAudio("320321052", var_220_29)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320321", "320321052", "story_v_out_320321.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320321", "320321052", "story_v_out_320321.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_30 = math.max(var_220_21, arg_217_1.talkMaxDuration)

			if var_220_20 <= arg_217_1.time_ and arg_217_1.time_ < var_220_20 + var_220_30 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_20) / var_220_30

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_20 + var_220_30 and arg_217_1.time_ < var_220_20 + var_220_30 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play320321053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320321053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play320321054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1011ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1011ui_story == nil then
				arg_221_1.var_.characterEffect1011ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1011ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1011ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1011ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1011ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0
			local var_224_7 = 0.475

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_9 = arg_221_1:GetWordFromCfg(320321053)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 19
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320321054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320321054
		arg_225_1.duration_ = 16.2

		local var_225_0 = {
			zh = 9.8,
			ja = 16.2
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play320321055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1011ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1011ui_story == nil then
				arg_225_1.var_.characterEffect1011ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1011ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1011ui_story then
				arg_225_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_228_4 = 0
			local var_228_5 = 0.925

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_6 = arg_225_1:FormatText(StoryNameCfg[37].name)

				arg_225_1.leftNameTxt_.text = var_228_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(320321054)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 37
				local var_228_10 = utf8.len(var_228_8)
				local var_228_11 = var_228_9 <= 0 and var_228_5 or var_228_5 * (var_228_10 / var_228_9)

				if var_228_11 > 0 and var_228_5 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321054", "story_v_out_320321.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_320321", "320321054", "story_v_out_320321.awb") / 1000

					if var_228_12 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_4
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_320321", "320321054", "story_v_out_320321.awb")

						arg_225_1:RecordAudio("320321054", var_228_13)
						arg_225_1:RecordAudio("320321054", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320321", "320321054", "story_v_out_320321.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320321", "320321054", "story_v_out_320321.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_14 and arg_225_1.time_ < var_228_4 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320321055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320321055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320321056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1011ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1011ui_story == nil then
				arg_229_1.var_.characterEffect1011ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.0166666666666667

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1011ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1011ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1011ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1011ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.95

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_8 = arg_229_1:GetWordFromCfg(320321055)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 38
				local var_232_11 = utf8.len(var_232_9)
				local var_232_12 = var_232_10 <= 0 and var_232_7 or var_232_7 * (var_232_11 / var_232_10)

				if var_232_12 > 0 and var_232_7 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12

					if var_232_12 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_13 and arg_229_1.time_ < var_232_6 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320321056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320321056
		arg_233_1.duration_ = 5.73

		local var_233_0 = {
			zh = 4.933,
			ja = 5.733
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320321057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1011ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1011ui_story == nil then
				arg_233_1.var_.characterEffect1011ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.1

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1011ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1011ui_story then
				arg_233_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_236_4 = 0

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_236_6 = 0
			local var_236_7 = 0.4

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_8 = arg_233_1:FormatText(StoryNameCfg[37].name)

				arg_233_1.leftNameTxt_.text = var_236_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_9 = arg_233_1:GetWordFromCfg(320321056)
				local var_236_10 = arg_233_1:FormatText(var_236_9.content)

				arg_233_1.text_.text = var_236_10

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 16
				local var_236_12 = utf8.len(var_236_10)
				local var_236_13 = var_236_11 <= 0 and var_236_7 or var_236_7 * (var_236_12 / var_236_11)

				if var_236_13 > 0 and var_236_7 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_10
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321056", "story_v_out_320321.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_320321", "320321056", "story_v_out_320321.awb") / 1000

					if var_236_14 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_6
					end

					if var_236_9.prefab_name ~= "" and arg_233_1.actors_[var_236_9.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_9.prefab_name].transform, "story_v_out_320321", "320321056", "story_v_out_320321.awb")

						arg_233_1:RecordAudio("320321056", var_236_15)
						arg_233_1:RecordAudio("320321056", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320321", "320321056", "story_v_out_320321.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320321", "320321056", "story_v_out_320321.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_16 and arg_233_1.time_ < var_236_6 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320321057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320321057
		arg_237_1.duration_ = 5.63

		local var_237_0 = {
			zh = 5.633,
			ja = 3.8
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320321058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.6

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[37].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(320321057)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 24
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321057", "story_v_out_320321.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321057", "story_v_out_320321.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_320321", "320321057", "story_v_out_320321.awb")

						arg_237_1:RecordAudio("320321057", var_240_9)
						arg_237_1:RecordAudio("320321057", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320321", "320321057", "story_v_out_320321.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320321", "320321057", "story_v_out_320321.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320321058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320321058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320321059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1011ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1011ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1011ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = 0
			local var_244_10 = 0.3

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_11 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_12 = arg_241_1:GetWordFromCfg(320321058)
				local var_244_13 = arg_241_1:FormatText(var_244_12.content)

				arg_241_1.text_.text = var_244_13

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_14 = 12
				local var_244_15 = utf8.len(var_244_13)
				local var_244_16 = var_244_14 <= 0 and var_244_10 or var_244_10 * (var_244_15 / var_244_14)

				if var_244_16 > 0 and var_244_10 < var_244_16 then
					arg_241_1.talkMaxDuration = var_244_16

					if var_244_16 + var_244_9 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_9
					end
				end

				arg_241_1.text_.text = var_244_13
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_17 = math.max(var_244_10, arg_241_1.talkMaxDuration)

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_17 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_9) / var_244_17

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_9 + var_244_17 and arg_241_1.time_ < var_244_9 + var_244_17 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play320321059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320321059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320321060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.55

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(320321059)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 22
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320321060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320321060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320321061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.275

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

				local var_252_2 = arg_249_1:GetWordFromCfg(320321060)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 51
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
	Play320321061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320321061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320321062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.875

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

				local var_256_2 = arg_253_1:GetWordFromCfg(320321061)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 35
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
	Play320321062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320321062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320321063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.975

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

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

				local var_260_3 = arg_257_1:GetWordFromCfg(320321062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 39
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320321063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320321063
		arg_261_1.duration_ = 7.2

		local var_261_0 = {
			zh = 7,
			ja = 7.2
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
				arg_261_0:Play320321064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1011ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1011ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, -0.71, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1011ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1011ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1011ui_story == nil then
				arg_261_1.var_.characterEffect1011ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1011ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1011ui_story then
				arg_261_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action456")
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_264_15 = 0
			local var_264_16 = 0.575

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[37].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(320321063)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 23
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321063", "story_v_out_320321.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_320321", "320321063", "story_v_out_320321.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_320321", "320321063", "story_v_out_320321.awb")

						arg_261_1:RecordAudio("320321063", var_264_24)
						arg_261_1:RecordAudio("320321063", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320321", "320321063", "story_v_out_320321.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320321", "320321063", "story_v_out_320321.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play320321064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320321064
		arg_265_1.duration_ = 7.8

		local var_265_0 = {
			zh = 4.4,
			ja = 7.8
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
				arg_265_0:Play320321065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.25

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[37].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(320321064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 10
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321064", "story_v_out_320321.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321064", "story_v_out_320321.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_320321", "320321064", "story_v_out_320321.awb")

						arg_265_1:RecordAudio("320321064", var_268_9)
						arg_265_1:RecordAudio("320321064", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320321", "320321064", "story_v_out_320321.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320321", "320321064", "story_v_out_320321.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320321065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320321065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320321066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1011ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1011ui_story == nil then
				arg_269_1.var_.characterEffect1011ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1011ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1011ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1011ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1011ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 0.55

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_8 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_9 = arg_269_1:GetWordFromCfg(320321065)
				local var_272_10 = arg_269_1:FormatText(var_272_9.content)

				arg_269_1.text_.text = var_272_10

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 22
				local var_272_12 = utf8.len(var_272_10)
				local var_272_13 = var_272_11 <= 0 and var_272_7 or var_272_7 * (var_272_12 / var_272_11)

				if var_272_13 > 0 and var_272_7 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_10
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320321066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320321066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320321067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1011ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1011ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1011ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0
			local var_276_10 = 0.75

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_11 = arg_273_1:GetWordFromCfg(320321066)
				local var_276_12 = arg_273_1:FormatText(var_276_11.content)

				arg_273_1.text_.text = var_276_12

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 30
				local var_276_14 = utf8.len(var_276_12)
				local var_276_15 = var_276_13 <= 0 and var_276_10 or var_276_10 * (var_276_14 / var_276_13)

				if var_276_15 > 0 and var_276_10 < var_276_15 then
					arg_273_1.talkMaxDuration = var_276_15

					if var_276_15 + var_276_9 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_9
					end
				end

				arg_273_1.text_.text = var_276_12
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_10, arg_273_1.talkMaxDuration)

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_9) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_9 + var_276_16 and arg_273_1.time_ < var_276_9 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play320321067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320321067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320321068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.35

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(320321067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 14
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320321068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320321068
		arg_281_1.duration_ = 7.67

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320321069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.33333333333333

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_1 = manager.ui.mainCamera.transform.localPosition
				local var_284_2 = Vector3.New(0, 0, 10) + Vector3.New(var_284_1.x, var_284_1.y, 0)
				local var_284_3 = arg_281_1.bgs_.ST61

				var_284_3.transform.localPosition = var_284_2
				var_284_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_4 = var_284_3:GetComponent("SpriteRenderer")

				if var_284_4 and var_284_4.sprite then
					local var_284_5 = (var_284_3.transform.localPosition - var_284_1).z
					local var_284_6 = manager.ui.mainCameraCom_
					local var_284_7 = 2 * var_284_5 * Mathf.Tan(var_284_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_284_8 = var_284_7 * var_284_6.aspect
					local var_284_9 = var_284_4.sprite.bounds.size.x
					local var_284_10 = var_284_4.sprite.bounds.size.y
					local var_284_11 = var_284_8 / var_284_9
					local var_284_12 = var_284_7 / var_284_10
					local var_284_13 = var_284_12 < var_284_11 and var_284_11 or var_284_12

					var_284_3.transform.localScale = Vector3.New(var_284_13, var_284_13, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST61" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_15 = 1.33333333333333

			if var_284_14 <= arg_281_1.time_ and arg_281_1.time_ < var_284_14 + var_284_15 then
				local var_284_16 = (arg_281_1.time_ - var_284_14) / var_284_15
				local var_284_17 = Color.New(0, 0, 0)

				var_284_17.a = Mathf.Lerp(0, 1, var_284_16)
				arg_281_1.mask_.color = var_284_17
			end

			if arg_281_1.time_ >= var_284_14 + var_284_15 and arg_281_1.time_ < var_284_14 + var_284_15 + arg_284_0 then
				local var_284_18 = Color.New(0, 0, 0)

				var_284_18.a = 1
				arg_281_1.mask_.color = var_284_18
			end

			local var_284_19 = 1.33333333333333

			if var_284_19 < arg_281_1.time_ and arg_281_1.time_ <= var_284_19 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_20 = 1.33333333333333

			if var_284_19 <= arg_281_1.time_ and arg_281_1.time_ < var_284_19 + var_284_20 then
				local var_284_21 = (arg_281_1.time_ - var_284_19) / var_284_20
				local var_284_22 = Color.New(0, 0, 0)

				var_284_22.a = Mathf.Lerp(1, 0, var_284_21)
				arg_281_1.mask_.color = var_284_22
			end

			if arg_281_1.time_ >= var_284_19 + var_284_20 and arg_281_1.time_ < var_284_19 + var_284_20 + arg_284_0 then
				local var_284_23 = Color.New(0, 0, 0)
				local var_284_24 = 0

				arg_281_1.mask_.enabled = false
				var_284_23.a = var_284_24
				arg_281_1.mask_.color = var_284_23
			end

			local var_284_25 = arg_281_1.actors_["1011ui_story"].transform
			local var_284_26 = 1.33333333333333

			if var_284_26 < arg_281_1.time_ and arg_281_1.time_ <= var_284_26 + arg_284_0 then
				arg_281_1.var_.moveOldPos1011ui_story = var_284_25.localPosition
			end

			local var_284_27 = 0.001

			if var_284_26 <= arg_281_1.time_ and arg_281_1.time_ < var_284_26 + var_284_27 then
				local var_284_28 = (arg_281_1.time_ - var_284_26) / var_284_27
				local var_284_29 = Vector3.New(0, 100, 0)

				var_284_25.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1011ui_story, var_284_29, var_284_28)

				local var_284_30 = manager.ui.mainCamera.transform.position - var_284_25.position

				var_284_25.forward = Vector3.New(var_284_30.x, var_284_30.y, var_284_30.z)

				local var_284_31 = var_284_25.localEulerAngles

				var_284_31.z = 0
				var_284_31.x = 0
				var_284_25.localEulerAngles = var_284_31
			end

			if arg_281_1.time_ >= var_284_26 + var_284_27 and arg_281_1.time_ < var_284_26 + var_284_27 + arg_284_0 then
				var_284_25.localPosition = Vector3.New(0, 100, 0)

				local var_284_32 = manager.ui.mainCamera.transform.position - var_284_25.position

				var_284_25.forward = Vector3.New(var_284_32.x, var_284_32.y, var_284_32.z)

				local var_284_33 = var_284_25.localEulerAngles

				var_284_33.z = 0
				var_284_33.x = 0
				var_284_25.localEulerAngles = var_284_33
			end

			local var_284_34 = arg_281_1.actors_["1011ui_story"]
			local var_284_35 = 1.33333333333333

			if var_284_35 < arg_281_1.time_ and arg_281_1.time_ <= var_284_35 + arg_284_0 and not isNil(var_284_34) and arg_281_1.var_.characterEffect1011ui_story == nil then
				arg_281_1.var_.characterEffect1011ui_story = var_284_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_36 = 0.200000002980232

			if var_284_35 <= arg_281_1.time_ and arg_281_1.time_ < var_284_35 + var_284_36 and not isNil(var_284_34) then
				local var_284_37 = (arg_281_1.time_ - var_284_35) / var_284_36

				if arg_281_1.var_.characterEffect1011ui_story and not isNil(var_284_34) then
					local var_284_38 = Mathf.Lerp(0, 0.5, var_284_37)

					arg_281_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1011ui_story.fillRatio = var_284_38
				end
			end

			if arg_281_1.time_ >= var_284_35 + var_284_36 and arg_281_1.time_ < var_284_35 + var_284_36 + arg_284_0 and not isNil(var_284_34) and arg_281_1.var_.characterEffect1011ui_story then
				local var_284_39 = 0.5

				arg_281_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1011ui_story.fillRatio = var_284_39
			end

			local var_284_40 = 0
			local var_284_41 = 0.2

			if var_284_40 < arg_281_1.time_ and arg_281_1.time_ <= var_284_40 + arg_284_0 then
				local var_284_42 = "play"
				local var_284_43 = "music"

				arg_281_1:AudioAction(var_284_42, var_284_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_284_44 = ""
				local var_284_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_284_45 ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_45 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_45

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_45
						arg_281_1.bgmTxt2_.text = var_284_45
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_284_46 = 0.766666666666667
			local var_284_47 = 1

			if var_284_46 < arg_281_1.time_ and arg_281_1.time_ <= var_284_46 + arg_284_0 then
				local var_284_48 = "play"
				local var_284_49 = "music"

				arg_281_1:AudioAction(var_284_48, var_284_49, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_284_50 = ""
				local var_284_51 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if var_284_51 ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_51 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_51

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_51
						arg_281_1.bgmTxt2_.text = var_284_51
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_52 = 2.66666666666667
			local var_284_53 = 0.425

			if var_284_52 < arg_281_1.time_ and arg_281_1.time_ <= var_284_52 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_54 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_54:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_281_1.dialogCg_.alpha = arg_287_0
				end))
				var_284_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_55 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_56 = arg_281_1:GetWordFromCfg(320321068)
				local var_284_57 = arg_281_1:FormatText(var_284_56.content)

				arg_281_1.text_.text = var_284_57

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_58 = 17
				local var_284_59 = utf8.len(var_284_57)
				local var_284_60 = var_284_58 <= 0 and var_284_53 or var_284_53 * (var_284_59 / var_284_58)

				if var_284_60 > 0 and var_284_53 < var_284_60 then
					arg_281_1.talkMaxDuration = var_284_60
					var_284_52 = var_284_52 + 0.3

					if var_284_60 + var_284_52 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_60 + var_284_52
					end
				end

				arg_281_1.text_.text = var_284_57
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_61 = var_284_52 + 0.3
			local var_284_62 = math.max(var_284_53, arg_281_1.talkMaxDuration)

			if var_284_61 <= arg_281_1.time_ and arg_281_1.time_ < var_284_61 + var_284_62 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_61) / var_284_62

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_61 + var_284_62 and arg_281_1.time_ < var_284_61 + var_284_62 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play320321069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 320321069
		arg_289_1.duration_ = 7.27

		local var_289_0 = {
			zh = 7.266,
			ja = 7
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
				arg_289_0:Play320321070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.8

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[1030].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_289_1.callingController_:SetSelectedState("calling")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(320321069)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 32
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321069", "story_v_out_320321.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321069", "story_v_out_320321.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_320321", "320321069", "story_v_out_320321.awb")

						arg_289_1:RecordAudio("320321069", var_292_9)
						arg_289_1:RecordAudio("320321069", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_320321", "320321069", "story_v_out_320321.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_320321", "320321069", "story_v_out_320321.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play320321070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 320321070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play320321071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.525

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(320321070)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 21
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play320321071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320321071
		arg_297_1.duration_ = 14.57

		local var_297_0 = {
			zh = 6.8,
			ja = 14.566
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
				arg_297_0:Play320321072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.75

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[1030].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_297_1.callingController_:SetSelectedState("calling")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(320321071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 30
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321071", "story_v_out_320321.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321071", "story_v_out_320321.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_320321", "320321071", "story_v_out_320321.awb")

						arg_297_1:RecordAudio("320321071", var_300_9)
						arg_297_1:RecordAudio("320321071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_320321", "320321071", "story_v_out_320321.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_320321", "320321071", "story_v_out_320321.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320321072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 320321072
		arg_301_1.duration_ = 6.6

		local var_301_0 = {
			zh = 3.6,
			ja = 6.6
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
				arg_301_0:Play320321073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.425

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[1030].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_301_1.callingController_:SetSelectedState("calling")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(320321072)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321072", "story_v_out_320321.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321072", "story_v_out_320321.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_320321", "320321072", "story_v_out_320321.awb")

						arg_301_1:RecordAudio("320321072", var_304_9)
						arg_301_1:RecordAudio("320321072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_320321", "320321072", "story_v_out_320321.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_320321", "320321072", "story_v_out_320321.awb")
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
	Play320321073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 320321073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play320321074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.275

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("calling")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(320321073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 11
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play320321074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 320321074
		arg_309_1.duration_ = 9.9

		local var_309_0 = {
			zh = 8.733,
			ja = 9.9
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
				arg_309_0:Play320321075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[1030].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_309_1.callingController_:SetSelectedState("calling")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(320321074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 40
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321074", "story_v_out_320321.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321074", "story_v_out_320321.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_320321", "320321074", "story_v_out_320321.awb")

						arg_309_1:RecordAudio("320321074", var_312_9)
						arg_309_1:RecordAudio("320321074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_320321", "320321074", "story_v_out_320321.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_320321", "320321074", "story_v_out_320321.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play320321075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320321075
		arg_313_1.duration_ = 12.7

		local var_313_0 = {
			zh = 12.566,
			ja = 12.7
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
				arg_313_0:Play320321076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 1.25

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[1030].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_313_1.callingController_:SetSelectedState("calling")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(320321075)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 50
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321075", "story_v_out_320321.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321075", "story_v_out_320321.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_320321", "320321075", "story_v_out_320321.awb")

						arg_313_1:RecordAudio("320321075", var_316_9)
						arg_313_1:RecordAudio("320321075", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_320321", "320321075", "story_v_out_320321.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_320321", "320321075", "story_v_out_320321.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320321076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320321076
		arg_317_1.duration_ = 10.7

		local var_317_0 = {
			zh = 5.633,
			ja = 10.7
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320321077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.725

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[1030].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_317_1.callingController_:SetSelectedState("calling")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:GetWordFromCfg(320321076)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 29
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321076", "story_v_out_320321.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321076", "story_v_out_320321.awb") / 1000

					if var_320_8 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_0
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_out_320321", "320321076", "story_v_out_320321.awb")

						arg_317_1:RecordAudio("320321076", var_320_9)
						arg_317_1:RecordAudio("320321076", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_320321", "320321076", "story_v_out_320321.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_320321", "320321076", "story_v_out_320321.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_10 and arg_317_1.time_ < var_320_0 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320321077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320321077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play320321078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.325

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(320321077)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 13
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play320321078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320321078
		arg_325_1.duration_ = 3.07

		local var_325_0 = {
			zh = 2.233,
			ja = 3.066
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320321079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.225

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[1030].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_325_1.callingController_:SetSelectedState("calling")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(320321078)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 9
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321078", "story_v_out_320321.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_320321", "320321078", "story_v_out_320321.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_320321", "320321078", "story_v_out_320321.awb")

						arg_325_1:RecordAudio("320321078", var_328_9)
						arg_325_1:RecordAudio("320321078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320321", "320321078", "story_v_out_320321.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320321", "320321078", "story_v_out_320321.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play320321079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320321079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320321080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1.425

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(320321079)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 57
				local var_332_5 = utf8.len(var_332_3)
				local var_332_6 = var_332_4 <= 0 and var_332_1 or var_332_1 * (var_332_5 / var_332_4)

				if var_332_6 > 0 and var_332_1 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_7 and arg_329_1.time_ < var_332_0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play320321080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320321080
		arg_333_1.duration_ = 2

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320321081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = "1020ui_story"

			if arg_333_1.actors_[var_336_0] == nil then
				local var_336_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_336_1) then
					local var_336_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_333_1.stage_.transform)

					var_336_2.name = var_336_0
					var_336_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_333_1.actors_[var_336_0] = var_336_2

					local var_336_3 = var_336_2:GetComponentInChildren(typeof(CharacterEffect))

					var_336_3.enabled = true

					local var_336_4 = GameObjectTools.GetOrAddComponent(var_336_2, typeof(DynamicBoneHelper))

					if var_336_4 then
						var_336_4:EnableDynamicBone(false)
					end

					arg_333_1:ShowWeapon(var_336_3.transform, false)

					arg_333_1.var_[var_336_0 .. "Animator"] = var_336_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_333_1.var_[var_336_0 .. "Animator"].applyRootMotion = true
					arg_333_1.var_[var_336_0 .. "LipSync"] = var_336_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_336_5 = arg_333_1.actors_["1020ui_story"].transform
			local var_336_6 = 0

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.var_.moveOldPos1020ui_story = var_336_5.localPosition
			end

			local var_336_7 = 0.001

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_7 then
				local var_336_8 = (arg_333_1.time_ - var_336_6) / var_336_7
				local var_336_9 = Vector3.New(0, -0.85, -6.25)

				var_336_5.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1020ui_story, var_336_9, var_336_8)

				local var_336_10 = manager.ui.mainCamera.transform.position - var_336_5.position

				var_336_5.forward = Vector3.New(var_336_10.x, var_336_10.y, var_336_10.z)

				local var_336_11 = var_336_5.localEulerAngles

				var_336_11.z = 0
				var_336_11.x = 0
				var_336_5.localEulerAngles = var_336_11
			end

			if arg_333_1.time_ >= var_336_6 + var_336_7 and arg_333_1.time_ < var_336_6 + var_336_7 + arg_336_0 then
				var_336_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_336_12 = manager.ui.mainCamera.transform.position - var_336_5.position

				var_336_5.forward = Vector3.New(var_336_12.x, var_336_12.y, var_336_12.z)

				local var_336_13 = var_336_5.localEulerAngles

				var_336_13.z = 0
				var_336_13.x = 0
				var_336_5.localEulerAngles = var_336_13
			end

			local var_336_14 = arg_333_1.actors_["1020ui_story"]
			local var_336_15 = 0

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.characterEffect1020ui_story == nil then
				arg_333_1.var_.characterEffect1020ui_story = var_336_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_16 = 0.200000002980232

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_16 and not isNil(var_336_14) then
				local var_336_17 = (arg_333_1.time_ - var_336_15) / var_336_16

				if arg_333_1.var_.characterEffect1020ui_story and not isNil(var_336_14) then
					arg_333_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_15 + var_336_16 and arg_333_1.time_ < var_336_15 + var_336_16 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.characterEffect1020ui_story then
				arg_333_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_336_18 = 0

			if var_336_18 < arg_333_1.time_ and arg_333_1.time_ <= var_336_18 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_336_19 = 0

			if var_336_19 < arg_333_1.time_ and arg_333_1.time_ <= var_336_19 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_336_20 = 0
			local var_336_21 = 0.125

			if var_336_20 < arg_333_1.time_ and arg_333_1.time_ <= var_336_20 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_22 = arg_333_1:FormatText(StoryNameCfg[613].name)

				arg_333_1.leftNameTxt_.text = var_336_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_23 = arg_333_1:GetWordFromCfg(320321080)
				local var_336_24 = arg_333_1:FormatText(var_336_23.content)

				arg_333_1.text_.text = var_336_24

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_25 = 5
				local var_336_26 = utf8.len(var_336_24)
				local var_336_27 = var_336_25 <= 0 and var_336_21 or var_336_21 * (var_336_26 / var_336_25)

				if var_336_27 > 0 and var_336_21 < var_336_27 then
					arg_333_1.talkMaxDuration = var_336_27

					if var_336_27 + var_336_20 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_27 + var_336_20
					end
				end

				arg_333_1.text_.text = var_336_24
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321080", "story_v_out_320321.awb") ~= 0 then
					local var_336_28 = manager.audio:GetVoiceLength("story_v_out_320321", "320321080", "story_v_out_320321.awb") / 1000

					if var_336_28 + var_336_20 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_28 + var_336_20
					end

					if var_336_23.prefab_name ~= "" and arg_333_1.actors_[var_336_23.prefab_name] ~= nil then
						local var_336_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_23.prefab_name].transform, "story_v_out_320321", "320321080", "story_v_out_320321.awb")

						arg_333_1:RecordAudio("320321080", var_336_29)
						arg_333_1:RecordAudio("320321080", var_336_29)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320321", "320321080", "story_v_out_320321.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320321", "320321080", "story_v_out_320321.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_30 = math.max(var_336_21, arg_333_1.talkMaxDuration)

			if var_336_20 <= arg_333_1.time_ and arg_333_1.time_ < var_336_20 + var_336_30 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_20) / var_336_30

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_20 + var_336_30 and arg_333_1.time_ < var_336_20 + var_336_30 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play320321081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320321081
		arg_337_1.duration_ = 7.7

		local var_337_0 = {
			zh = 4.966,
			ja = 7.7
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
				arg_337_0:Play320321082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_340_1 = 0
			local var_340_2 = 0.725

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_3 = arg_337_1:FormatText(StoryNameCfg[613].name)

				arg_337_1.leftNameTxt_.text = var_340_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(320321081)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 29
				local var_340_7 = utf8.len(var_340_5)
				local var_340_8 = var_340_6 <= 0 and var_340_2 or var_340_2 * (var_340_7 / var_340_6)

				if var_340_8 > 0 and var_340_2 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321081", "story_v_out_320321.awb") ~= 0 then
					local var_340_9 = manager.audio:GetVoiceLength("story_v_out_320321", "320321081", "story_v_out_320321.awb") / 1000

					if var_340_9 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_1
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_320321", "320321081", "story_v_out_320321.awb")

						arg_337_1:RecordAudio("320321081", var_340_10)
						arg_337_1:RecordAudio("320321081", var_340_10)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_320321", "320321081", "story_v_out_320321.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_320321", "320321081", "story_v_out_320321.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_11 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_11 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_11

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_11 and arg_337_1.time_ < var_340_1 + var_340_11 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play320321082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320321082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320321083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1020ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1020ui_story == nil then
				arg_341_1.var_.characterEffect1020ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1020ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1020ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1020ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1020ui_story.fillRatio = var_344_5
			end

			local var_344_6 = 0
			local var_344_7 = 0.425

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_9 = arg_341_1:GetWordFromCfg(320321082)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 17
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_14 and arg_341_1.time_ < var_344_6 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320321083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 320321083
		arg_345_1.duration_ = 11.63

		local var_345_0 = {
			zh = 6.7,
			ja = 11.633
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
				arg_345_0:Play320321084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1020ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1020ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0, -0.85, -6.25)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1020ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["1020ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1020ui_story == nil then
				arg_345_1.var_.characterEffect1020ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect1020ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1020ui_story then
				arg_345_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_348_14 = 0
			local var_348_15 = 0.6

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_16 = arg_345_1:FormatText(StoryNameCfg[613].name)

				arg_345_1.leftNameTxt_.text = var_348_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_17 = arg_345_1:GetWordFromCfg(320321083)
				local var_348_18 = arg_345_1:FormatText(var_348_17.content)

				arg_345_1.text_.text = var_348_18

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_19 = 24
				local var_348_20 = utf8.len(var_348_18)
				local var_348_21 = var_348_19 <= 0 and var_348_15 or var_348_15 * (var_348_20 / var_348_19)

				if var_348_21 > 0 and var_348_15 < var_348_21 then
					arg_345_1.talkMaxDuration = var_348_21

					if var_348_21 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_21 + var_348_14
					end
				end

				arg_345_1.text_.text = var_348_18
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320321", "320321083", "story_v_out_320321.awb") ~= 0 then
					local var_348_22 = manager.audio:GetVoiceLength("story_v_out_320321", "320321083", "story_v_out_320321.awb") / 1000

					if var_348_22 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_14
					end

					if var_348_17.prefab_name ~= "" and arg_345_1.actors_[var_348_17.prefab_name] ~= nil then
						local var_348_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_17.prefab_name].transform, "story_v_out_320321", "320321083", "story_v_out_320321.awb")

						arg_345_1:RecordAudio("320321083", var_348_23)
						arg_345_1:RecordAudio("320321083", var_348_23)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_320321", "320321083", "story_v_out_320321.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_320321", "320321083", "story_v_out_320321.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_24 = math.max(var_348_15, arg_345_1.talkMaxDuration)

			if var_348_14 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_24 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_14) / var_348_24

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_14 + var_348_24 and arg_345_1.time_ < var_348_14 + var_348_24 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play320321084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 320321084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
			arg_349_1.auto_ = false
		end

		function arg_349_1.playNext_(arg_351_0)
			arg_349_1.onStoryFinished_()
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1020ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1020ui_story == nil then
				arg_349_1.var_.characterEffect1020ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1020ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1020ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1020ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1020ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.275

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_9 = arg_349_1:GetWordFromCfg(320321084)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 11
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L07f",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST0505"
	},
	voices = {
		"story_v_out_320321.awb"
	}
}
