return {
	Play320092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320092001
		arg_1_1.duration_ = 9.23

		local var_1_0 = {
			zh = 7.032999999999,
			ja = 9.232999999999
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
				arg_1_0:Play320092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L07i"

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
				local var_4_5 = arg_1_1.bgs_.L07i

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
					if iter_4_0 ~= "L07i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

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
			local var_4_37 = 0.55

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[1039].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(320092001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092001", "story_v_out_320092.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_320092", "320092001", "story_v_out_320092.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_320092", "320092001", "story_v_out_320092.awb")

						arg_1_1:RecordAudio("320092001", var_4_46)
						arg_1_1:RecordAudio("320092001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320092", "320092001", "story_v_out_320092.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320092", "320092001", "story_v_out_320092.awb")
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
	Play320092002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320092002
		arg_9_1.duration_ = 10.6

		local var_9_0 = {
			zh = 6.233,
			ja = 10.6
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
				arg_9_0:Play320092003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.825

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1042].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(320092002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092002", "story_v_out_320092.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092002", "story_v_out_320092.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_320092", "320092002", "story_v_out_320092.awb")

						arg_9_1:RecordAudio("320092002", var_12_9)
						arg_9_1:RecordAudio("320092002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320092", "320092002", "story_v_out_320092.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320092", "320092002", "story_v_out_320092.awb")
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
	Play320092003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320092003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 2.9,
			ja = 3.433
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
				arg_13_0:Play320092004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.475

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1038].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(320092003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092003", "story_v_out_320092.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092003", "story_v_out_320092.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_320092", "320092003", "story_v_out_320092.awb")

						arg_13_1:RecordAudio("320092003", var_16_9)
						arg_13_1:RecordAudio("320092003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320092", "320092003", "story_v_out_320092.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320092", "320092003", "story_v_out_320092.awb")
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
	Play320092004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320092004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320092005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.9

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

				local var_20_2 = arg_17_1:GetWordFromCfg(320092004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 36
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
	Play320092005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320092005
		arg_21_1.duration_ = 8.67

		local var_21_0 = {
			zh = 6.133,
			ja = 8.666
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
				arg_21_0:Play320092006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1043].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(320092005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092005", "story_v_out_320092.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092005", "story_v_out_320092.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320092", "320092005", "story_v_out_320092.awb")

						arg_21_1:RecordAudio("320092005", var_24_9)
						arg_21_1:RecordAudio("320092005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320092", "320092005", "story_v_out_320092.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320092", "320092005", "story_v_out_320092.awb")
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
	Play320092006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320092006
		arg_25_1.duration_ = 3.37

		local var_25_0 = {
			zh = 2.066,
			ja = 3.366
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
				arg_25_0:Play320092007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.2

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1038].name)

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

				local var_28_3 = arg_25_1:GetWordFromCfg(320092006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092006", "story_v_out_320092.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092006", "story_v_out_320092.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_320092", "320092006", "story_v_out_320092.awb")

						arg_25_1:RecordAudio("320092006", var_28_9)
						arg_25_1:RecordAudio("320092006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320092", "320092006", "story_v_out_320092.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320092", "320092006", "story_v_out_320092.awb")
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
	Play320092007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320092007
		arg_29_1.duration_ = 9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play320092008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "L07l"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.L07l

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "L07l" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 3.96666666666667

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_17 = 0.3

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_19 = 2

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 then
				local var_32_20 = (arg_29_1.time_ - var_32_18) / var_32_19
				local var_32_21 = Color.New(0, 0, 0)

				var_32_21.a = Mathf.Lerp(0, 1, var_32_20)
				arg_29_1.mask_.color = var_32_21
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 then
				local var_32_22 = Color.New(0, 0, 0)

				var_32_22.a = 1
				arg_29_1.mask_.color = var_32_22
			end

			local var_32_23 = 2

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24
				local var_32_26 = Color.New(0, 0, 0)

				var_32_26.a = Mathf.Lerp(1, 0, var_32_25)
				arg_29_1.mask_.color = var_32_26
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				local var_32_27 = Color.New(0, 0, 0)
				local var_32_28 = 0

				arg_29_1.mask_.enabled = false
				var_32_27.a = var_32_28
				arg_29_1.mask_.color = var_32_27
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_29 = 4
			local var_32_30 = 0.775

			if var_32_29 < arg_29_1.time_ and arg_29_1.time_ <= var_32_29 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_31 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_31:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_32 = arg_29_1:GetWordFromCfg(320092007)
				local var_32_33 = arg_29_1:FormatText(var_32_32.content)

				arg_29_1.text_.text = var_32_33

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_34 = 31
				local var_32_35 = utf8.len(var_32_33)
				local var_32_36 = var_32_34 <= 0 and var_32_30 or var_32_30 * (var_32_35 / var_32_34)

				if var_32_36 > 0 and var_32_30 < var_32_36 then
					arg_29_1.talkMaxDuration = var_32_36
					var_32_29 = var_32_29 + 0.3

					if var_32_36 + var_32_29 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_29
					end
				end

				arg_29_1.text_.text = var_32_33
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_37 = var_32_29 + 0.3
			local var_32_38 = math.max(var_32_30, arg_29_1.talkMaxDuration)

			if var_32_37 <= arg_29_1.time_ and arg_29_1.time_ < var_32_37 + var_32_38 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_37) / var_32_38

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_37 + var_32_38 and arg_29_1.time_ < var_32_37 + var_32_38 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320092008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 320092008
		arg_35_1.duration_ = 2.47

		local var_35_0 = {
			zh = 2.466,
			ja = 2.266
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
				arg_35_0:Play320092009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.275

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[1042].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(320092008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092008", "story_v_out_320092.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092008", "story_v_out_320092.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_320092", "320092008", "story_v_out_320092.awb")

						arg_35_1:RecordAudio("320092008", var_38_9)
						arg_35_1:RecordAudio("320092008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_320092", "320092008", "story_v_out_320092.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_320092", "320092008", "story_v_out_320092.awb")
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
	Play320092009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 320092009
		arg_39_1.duration_ = 6

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play320092010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_1 = 1

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_1 then
				local var_42_2 = (arg_39_1.time_ - var_42_0) / var_42_1
				local var_42_3 = Color.New(1, 1, 1)

				var_42_3.a = Mathf.Lerp(1, 0, var_42_2)
				arg_39_1.mask_.color = var_42_3
			end

			if arg_39_1.time_ >= var_42_0 + var_42_1 and arg_39_1.time_ < var_42_0 + var_42_1 + arg_42_0 then
				local var_42_4 = Color.New(1, 1, 1)
				local var_42_5 = 0

				arg_39_1.mask_.enabled = false
				var_42_4.a = var_42_5
				arg_39_1.mask_.color = var_42_4
			end

			local var_42_6 = manager.ui.mainCamera.transform
			local var_42_7 = 0

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				local var_42_8 = arg_39_1.var_.effectranshao1
				local var_42_9
				local var_42_10 = var_42_6

				if not var_42_8 then
					var_42_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), var_42_10)
					var_42_8.name = "ranshao1"
					arg_39_1.var_.effectranshao1 = var_42_8
				else
					var_42_8.transform:SetParent(var_42_10)
				end

				var_42_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_42_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_42_11 = manager.ui.mainCameraCom_
				local var_42_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_42_11.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_42_13 = var_42_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_42_14 = 15
				local var_42_15 = 2 * var_42_14 * Mathf.Tan(var_42_11.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_42_11.aspect
				local var_42_16 = 1
				local var_42_17 = 1.7777777777777777

				if var_42_17 < var_42_11.aspect then
					var_42_16 = var_42_15 / (2 * var_42_14 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_42_17)
				end

				for iter_42_0, iter_42_1 in ipairs(var_42_13) do
					local var_42_18 = iter_42_1.transform.localScale

					iter_42_1.transform.localScale = Vector3.New(var_42_18.x / var_42_12 * var_42_16, var_42_18.y / var_42_12, var_42_18.z)
				end
			end

			local var_42_19 = 0
			local var_42_20 = 1

			if var_42_19 < arg_39_1.time_ and arg_39_1.time_ <= var_42_19 + arg_42_0 then
				local var_42_21 = "play"
				local var_42_22 = "effect"

				arg_39_1:AudioAction(var_42_21, var_42_22, "se_story_128", "se_story_128_burn", "")
			end

			local var_42_23 = 0.1
			local var_42_24 = 1

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				local var_42_25 = "play"
				local var_42_26 = "effect"

				arg_39_1:AudioAction(var_42_25, var_42_26, "se_story_17", "se_story_17_fire_loop", "")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_27 = 1
			local var_42_28 = 0.575

			if var_42_27 < arg_39_1.time_ and arg_39_1.time_ <= var_42_27 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_29 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_29:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_30 = arg_39_1:GetWordFromCfg(320092009)
				local var_42_31 = arg_39_1:FormatText(var_42_30.content)

				arg_39_1.text_.text = var_42_31

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_32 = 23
				local var_42_33 = utf8.len(var_42_31)
				local var_42_34 = var_42_32 <= 0 and var_42_28 or var_42_28 * (var_42_33 / var_42_32)

				if var_42_34 > 0 and var_42_28 < var_42_34 then
					arg_39_1.talkMaxDuration = var_42_34
					var_42_27 = var_42_27 + 0.3

					if var_42_34 + var_42_27 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_34 + var_42_27
					end
				end

				arg_39_1.text_.text = var_42_31
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_35 = var_42_27 + 0.3
			local var_42_36 = math.max(var_42_28, arg_39_1.talkMaxDuration)

			if var_42_35 <= arg_39_1.time_ and arg_39_1.time_ < var_42_35 + var_42_36 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_35) / var_42_36

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_35 + var_42_36 and arg_39_1.time_ < var_42_35 + var_42_36 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play320092010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320092010
		arg_45_1.duration_ = 3.4

		local var_45_0 = {
			zh = 2.266,
			ja = 3.4
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
				arg_45_0:Play320092011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.25

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1038].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(320092010)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 10
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092010", "story_v_out_320092.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092010", "story_v_out_320092.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_320092", "320092010", "story_v_out_320092.awb")

						arg_45_1:RecordAudio("320092010", var_48_9)
						arg_45_1:RecordAudio("320092010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320092", "320092010", "story_v_out_320092.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320092", "320092010", "story_v_out_320092.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320092011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320092011
		arg_49_1.duration_ = 3.8

		local var_49_0 = {
			zh = 3.8,
			ja = 2.866
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
				arg_49_0:Play320092012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.425

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1039].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(320092011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092011", "story_v_out_320092.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092011", "story_v_out_320092.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_320092", "320092011", "story_v_out_320092.awb")

						arg_49_1:RecordAudio("320092011", var_52_9)
						arg_49_1:RecordAudio("320092011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320092", "320092011", "story_v_out_320092.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320092", "320092011", "story_v_out_320092.awb")
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
	Play320092012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320092012
		arg_53_1.duration_ = 1.27

		local var_53_0 = {
			zh = 1.266,
			ja = 0.999999999999
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
				arg_53_0:Play320092013(arg_53_1)
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

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1038].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(320092012)
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092012", "story_v_out_320092.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092012", "story_v_out_320092.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_320092", "320092012", "story_v_out_320092.awb")

						arg_53_1:RecordAudio("320092012", var_56_9)
						arg_53_1:RecordAudio("320092012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320092", "320092012", "story_v_out_320092.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320092", "320092012", "story_v_out_320092.awb")
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
	Play320092013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320092013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play320092014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.225
			local var_60_1 = 1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_2 = "play"
				local var_60_3 = "effect"

				arg_57_1:AudioAction(var_60_2, var_60_3, "se_story_123_01", "se_story_123_01_gun", "")
			end

			local var_60_4 = 0
			local var_60_5 = 1

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				local var_60_6 = "stop"
				local var_60_7 = "music"

				arg_57_1:AudioAction(var_60_6, var_60_7, "se_story_17", "se_story_17_fire_loop", "")

				local var_60_8 = ""
				local var_60_9 = manager.audio:GetAudioName("se_story_17", "se_story_17_fire_loop")

				if var_60_9 ~= "" then
					if arg_57_1.bgmTxt_.text ~= var_60_9 and arg_57_1.bgmTxt_.text ~= "" then
						if arg_57_1.bgmTxt2_.text ~= "" then
							arg_57_1.bgmTxt_.text = arg_57_1.bgmTxt2_.text
						end

						arg_57_1.bgmTxt2_.text = var_60_9

						arg_57_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_57_1.bgmTxt_.text = var_60_9
						arg_57_1.bgmTxt2_.text = var_60_9
					end

					if arg_57_1.bgmTimer then
						arg_57_1.bgmTimer:Stop()

						arg_57_1.bgmTimer = nil
					end

					if arg_57_1.settingData.show_music_name == 1 then
						arg_57_1.musicController:SetSelectedState("show")
						arg_57_1.musicAnimator_:Play("open", 0, 0)

						if arg_57_1.settingData.music_time ~= 0 then
							arg_57_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_57_1.settingData.music_time), function()
								if arg_57_1 == nil or isNil(arg_57_1.bgmTxt_) then
									return
								end

								arg_57_1.musicController:SetSelectedState("hide")
								arg_57_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_60_10 = 0
			local var_60_11 = 1.225

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_12 = arg_57_1:GetWordFromCfg(320092013)
				local var_60_13 = arg_57_1:FormatText(var_60_12.content)

				arg_57_1.text_.text = var_60_13

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_14 = 49
				local var_60_15 = utf8.len(var_60_13)
				local var_60_16 = var_60_14 <= 0 and var_60_11 or var_60_11 * (var_60_15 / var_60_14)

				if var_60_16 > 0 and var_60_11 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_10
					end
				end

				arg_57_1.text_.text = var_60_13
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_17 = math.max(var_60_11, arg_57_1.talkMaxDuration)

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_17 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_10) / var_60_17

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_10 + var_60_17 and arg_57_1.time_ < var_60_10 + var_60_17 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320092014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 320092014
		arg_62_1.duration_ = 6.7

		local var_62_0 = {
			zh = 4.333,
			ja = 6.7
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
				arg_62_0:Play320092015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.35

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[1025].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(320092014)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 14
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092014", "story_v_out_320092.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092014", "story_v_out_320092.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_320092", "320092014", "story_v_out_320092.awb")

						arg_62_1:RecordAudio("320092014", var_65_9)
						arg_62_1:RecordAudio("320092014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_320092", "320092014", "story_v_out_320092.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_320092", "320092014", "story_v_out_320092.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play320092015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 320092015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play320092016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				local var_69_2 = "play"
				local var_69_3 = "effect"

				arg_66_1:AudioAction(var_69_2, var_69_3, "se_story_123_01", "se_story_123_01_gun", "")
			end

			local var_69_4 = 0
			local var_69_5 = 0.8

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(320092015)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_8 = 32
				local var_69_9 = utf8.len(var_69_7)
				local var_69_10 = var_69_8 <= 0 and var_69_5 or var_69_5 * (var_69_9 / var_69_8)

				if var_69_10 > 0 and var_69_5 < var_69_10 then
					arg_66_1.talkMaxDuration = var_69_10

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_11 and arg_66_1.time_ < var_69_4 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play320092016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 320092016
		arg_70_1.duration_ = 4.97

		local var_70_0 = {
			zh = 3.5,
			ja = 4.966
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
				arg_70_0:Play320092017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.4

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1042].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(320092016)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 16
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092016", "story_v_out_320092.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092016", "story_v_out_320092.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_320092", "320092016", "story_v_out_320092.awb")

						arg_70_1:RecordAudio("320092016", var_73_9)
						arg_70_1:RecordAudio("320092016", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_320092", "320092016", "story_v_out_320092.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_320092", "320092016", "story_v_out_320092.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play320092017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 320092017
		arg_74_1.duration_ = 3.53

		local var_74_0 = {
			zh = 2.866,
			ja = 3.533
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
				arg_74_0:Play320092018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.275

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1025].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(320092017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 11
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092017", "story_v_out_320092.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092017", "story_v_out_320092.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_320092", "320092017", "story_v_out_320092.awb")

						arg_74_1:RecordAudio("320092017", var_77_9)
						arg_74_1:RecordAudio("320092017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_320092", "320092017", "story_v_out_320092.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_320092", "320092017", "story_v_out_320092.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play320092018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 320092018
		arg_78_1.duration_ = 5.83

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play320092019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.3
			local var_81_1 = 1

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_2 = "play"
				local var_81_3 = "effect"

				arg_78_1:AudioAction(var_81_2, var_81_3, "se_story_121_04", "se_story_121_04_hitdown", "")
			end

			local var_81_4 = manager.ui.mainCamera.transform
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.var_.shakeOldPos = var_81_4.localPosition
			end

			local var_81_6 = 1.3

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / 0.066
				local var_81_8, var_81_9 = math.modf(var_81_7)

				var_81_4.localPosition = Vector3.New(var_81_9 * 0.13, var_81_9 * 0.13, var_81_9 * 0.13) + arg_78_1.var_.shakeOldPos
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 then
				var_81_4.localPosition = arg_78_1.var_.shakeOldPos
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_11 = 1.3

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_12 = 0.833333333333333
			local var_81_13 = 1.3

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_14 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_14:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_15 = arg_78_1:GetWordFromCfg(320092018)
				local var_81_16 = arg_78_1:FormatText(var_81_15.content)

				arg_78_1.text_.text = var_81_16

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_17 = 52
				local var_81_18 = utf8.len(var_81_16)
				local var_81_19 = var_81_17 <= 0 and var_81_13 or var_81_13 * (var_81_18 / var_81_17)

				if var_81_19 > 0 and var_81_13 < var_81_19 then
					arg_78_1.talkMaxDuration = var_81_19
					var_81_12 = var_81_12 + 0.3

					if var_81_19 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_12
					end
				end

				arg_78_1.text_.text = var_81_16
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_20 = var_81_12 + 0.3
			local var_81_21 = math.max(var_81_13, arg_78_1.talkMaxDuration)

			if var_81_20 <= arg_78_1.time_ and arg_78_1.time_ < var_81_20 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_20) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_20 + var_81_21 and arg_78_1.time_ < var_81_20 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play320092019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 320092019
		arg_84_1.duration_ = 5.57

		local var_84_0 = {
			zh = 5.033,
			ja = 5.566
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
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.425

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1025].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(320092019)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320092", "320092019", "story_v_out_320092.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_320092", "320092019", "story_v_out_320092.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_320092", "320092019", "story_v_out_320092.awb")

						arg_84_1:RecordAudio("320092019", var_87_9)
						arg_84_1:RecordAudio("320092019", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_320092", "320092019", "story_v_out_320092.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_320092", "320092019", "story_v_out_320092.awb")
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
	assets = {
		"TextureConfig/Background/L07i",
		"TextureConfig/Background/L07l"
	},
	voices = {
		"story_v_out_320092.awb"
	}
}
