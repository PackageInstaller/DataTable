return {
	Play324031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324031001
		arg_1_1.duration_ = 4.6

		local var_1_0 = {
			zh = 4.599999999999,
			ja = 3.499999999999
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
				arg_1_0:Play324031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST42"

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
				local var_4_5 = arg_1_1.bgs_.ST42

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
					if iter_4_0 ~= "ST42" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.999999999999
			local var_4_39 = 0.125

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[384].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(324031001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031001", "story_v_out_324031.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_324031", "324031001", "story_v_out_324031.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_324031", "324031001", "story_v_out_324031.awb")

						arg_1_1:RecordAudio("324031001", var_4_48)
						arg_1_1:RecordAudio("324031001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324031", "324031001", "story_v_out_324031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324031", "324031001", "story_v_out_324031.awb")
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
	Play324031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324031002
		arg_8_1.duration_ = 1.3

		local var_8_0 = {
			zh = 1.066,
			ja = 1.3
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
				arg_8_0:Play324031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.075

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[472].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10039")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(324031002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031002", "story_v_out_324031.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031002", "story_v_out_324031.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_324031", "324031002", "story_v_out_324031.awb")

						arg_8_1:RecordAudio("324031002", var_11_9)
						arg_8_1:RecordAudio("324031002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324031", "324031002", "story_v_out_324031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324031", "324031002", "story_v_out_324031.awb")
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
	Play324031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324031003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.325

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(324031003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 53
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.725

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(324031004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 69
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324031005
		arg_20_1.duration_ = 2.57

		local var_20_0 = {
			zh = 2,
			ja = 2.566
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
				arg_20_0:Play324031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "10039ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["10039ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos10039ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0, -0.8, -6.2)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10039ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = arg_20_1.actors_["10039ui_story"]
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10039ui_story == nil then
				arg_20_1.var_.characterEffect10039ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_16 = 0.200000002980232

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 and not isNil(var_23_14) then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16

				if arg_20_1.var_.characterEffect10039ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10039ui_story then
				arg_20_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_20 = 0
			local var_23_21 = 0.2

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[472].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(324031005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 8
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031005", "story_v_out_324031.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_324031", "324031005", "story_v_out_324031.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_324031", "324031005", "story_v_out_324031.awb")

						arg_20_1:RecordAudio("324031005", var_23_29)
						arg_20_1:RecordAudio("324031005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324031", "324031005", "story_v_out_324031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324031", "324031005", "story_v_out_324031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play324031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324031006
		arg_24_1.duration_ = 12.33

		local var_24_0 = {
			zh = 8.633,
			ja = 12.333
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10039ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10039ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(-0.7, -0.8, -6.2)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10039ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = "1071ui_story"

			if arg_24_1.actors_[var_27_9] == nil then
				local var_27_10 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_27_10) then
					local var_27_11 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_24_1.stage_.transform)

					var_27_11.name = var_27_9
					var_27_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_9] = var_27_11

					local var_27_12 = var_27_11:GetComponentInChildren(typeof(CharacterEffect))

					var_27_12.enabled = true

					local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11, typeof(DynamicBoneHelper))

					if var_27_13 then
						var_27_13:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_12.transform, false)

					arg_24_1.var_[var_27_9 .. "Animator"] = var_27_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_9 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_9 .. "LipSync"] = var_27_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_14 = arg_24_1.actors_["1071ui_story"].transform
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.var_.moveOldPos1071ui_story = var_27_14.localPosition
			end

			local var_27_16 = 0.001

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16
				local var_27_18 = Vector3.New(0.7, -1.05, -6.2)

				var_27_14.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1071ui_story, var_27_18, var_27_17)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_14.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_14.localEulerAngles = var_27_20
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 then
				var_27_14.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_27_21 = manager.ui.mainCamera.transform.position - var_27_14.position

				var_27_14.forward = Vector3.New(var_27_21.x, var_27_21.y, var_27_21.z)

				local var_27_22 = var_27_14.localEulerAngles

				var_27_22.z = 0
				var_27_22.x = 0
				var_27_14.localEulerAngles = var_27_22
			end

			local var_27_23 = arg_24_1.actors_["1071ui_story"]
			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 and not isNil(var_27_23) and arg_24_1.var_.characterEffect1071ui_story == nil then
				arg_24_1.var_.characterEffect1071ui_story = var_27_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_25 = 0.200000002980232

			if var_27_24 <= arg_24_1.time_ and arg_24_1.time_ < var_27_24 + var_27_25 and not isNil(var_27_23) then
				local var_27_26 = (arg_24_1.time_ - var_27_24) / var_27_25

				if arg_24_1.var_.characterEffect1071ui_story and not isNil(var_27_23) then
					arg_24_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_24 + var_27_25 and arg_24_1.time_ < var_27_24 + var_27_25 + arg_27_0 and not isNil(var_27_23) and arg_24_1.var_.characterEffect1071ui_story then
				arg_24_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_27_27 = arg_24_1.actors_["10039ui_story"]
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect10039ui_story == nil then
				arg_24_1.var_.characterEffect10039ui_story = var_27_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_29 = 0.200000002980232

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_29 and not isNil(var_27_27) then
				local var_27_30 = (arg_24_1.time_ - var_27_28) / var_27_29

				if arg_24_1.var_.characterEffect10039ui_story and not isNil(var_27_27) then
					local var_27_31 = Mathf.Lerp(0, 0.5, var_27_30)

					arg_24_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10039ui_story.fillRatio = var_27_31
				end
			end

			if arg_24_1.time_ >= var_27_28 + var_27_29 and arg_24_1.time_ < var_27_28 + var_27_29 + arg_27_0 and not isNil(var_27_27) and arg_24_1.var_.characterEffect10039ui_story then
				local var_27_32 = 0.5

				arg_24_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10039ui_story.fillRatio = var_27_32
			end

			local var_27_33 = 0

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				arg_24_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_27_35 = 0
			local var_27_36 = 0.875

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_37 = arg_24_1:FormatText(StoryNameCfg[384].name)

				arg_24_1.leftNameTxt_.text = var_27_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_38 = arg_24_1:GetWordFromCfg(324031006)
				local var_27_39 = arg_24_1:FormatText(var_27_38.content)

				arg_24_1.text_.text = var_27_39

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_40 = 35
				local var_27_41 = utf8.len(var_27_39)
				local var_27_42 = var_27_40 <= 0 and var_27_36 or var_27_36 * (var_27_41 / var_27_40)

				if var_27_42 > 0 and var_27_36 < var_27_42 then
					arg_24_1.talkMaxDuration = var_27_42

					if var_27_42 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_35
					end
				end

				arg_24_1.text_.text = var_27_39
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031006", "story_v_out_324031.awb") ~= 0 then
					local var_27_43 = manager.audio:GetVoiceLength("story_v_out_324031", "324031006", "story_v_out_324031.awb") / 1000

					if var_27_43 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_35
					end

					if var_27_38.prefab_name ~= "" and arg_24_1.actors_[var_27_38.prefab_name] ~= nil then
						local var_27_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_38.prefab_name].transform, "story_v_out_324031", "324031006", "story_v_out_324031.awb")

						arg_24_1:RecordAudio("324031006", var_27_44)
						arg_24_1:RecordAudio("324031006", var_27_44)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324031", "324031006", "story_v_out_324031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324031", "324031006", "story_v_out_324031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_45 = math.max(var_27_36, arg_24_1.talkMaxDuration)

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_45 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_35) / var_27_45

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_45 and arg_24_1.time_ < var_27_35 + var_27_45 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324031007
		arg_28_1.duration_ = 4.47

		local var_28_0 = {
			zh = 4.066,
			ja = 4.466
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10039ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10039ui_story == nil then
				arg_28_1.var_.characterEffect10039ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10039ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10039ui_story then
				arg_28_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1071ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1071ui_story == nil then
				arg_28_1.var_.characterEffect1071ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1071ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1071ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1071ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1071ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_31_11 = 0
			local var_31_12 = 0.4

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[472].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(324031007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 16
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031007", "story_v_out_324031.awb") ~= 0 then
					local var_31_19 = manager.audio:GetVoiceLength("story_v_out_324031", "324031007", "story_v_out_324031.awb") / 1000

					if var_31_19 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_11
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_324031", "324031007", "story_v_out_324031.awb")

						arg_28_1:RecordAudio("324031007", var_31_20)
						arg_28_1:RecordAudio("324031007", var_31_20)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324031", "324031007", "story_v_out_324031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324031", "324031007", "story_v_out_324031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_21 and arg_28_1.time_ < var_31_11 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324031008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1071ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1071ui_story == nil then
				arg_32_1.var_.characterEffect1071ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1071ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1071ui_story then
				arg_32_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["10039ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10039ui_story == nil then
				arg_32_1.var_.characterEffect10039ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect10039ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10039ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10039ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10039ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_35_11 = 0
			local var_35_12 = 0.1

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_13 = arg_32_1:FormatText(StoryNameCfg[384].name)

				arg_32_1.leftNameTxt_.text = var_35_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(324031008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 4
				local var_35_17 = utf8.len(var_35_15)
				local var_35_18 = var_35_16 <= 0 and var_35_12 or var_35_12 * (var_35_17 / var_35_16)

				if var_35_18 > 0 and var_35_12 < var_35_18 then
					arg_32_1.talkMaxDuration = var_35_18

					if var_35_18 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031008", "story_v_out_324031.awb") ~= 0 then
					local var_35_19 = manager.audio:GetVoiceLength("story_v_out_324031", "324031008", "story_v_out_324031.awb") / 1000

					if var_35_19 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_11
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_324031", "324031008", "story_v_out_324031.awb")

						arg_32_1:RecordAudio("324031008", var_35_20)
						arg_32_1:RecordAudio("324031008", var_35_20)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324031", "324031008", "story_v_out_324031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324031", "324031008", "story_v_out_324031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_21 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_21

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_21 and arg_32_1.time_ < var_35_11 + var_35_21 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324031009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10039ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10039ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10039ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1071ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1071ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1071ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = arg_36_1.actors_["1071ui_story"]
			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1071ui_story == nil then
				arg_36_1.var_.characterEffect1071ui_story = var_39_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_20 = 0.200000002980232

			if var_39_19 <= arg_36_1.time_ and arg_36_1.time_ < var_39_19 + var_39_20 and not isNil(var_39_18) then
				local var_39_21 = (arg_36_1.time_ - var_39_19) / var_39_20

				if arg_36_1.var_.characterEffect1071ui_story and not isNil(var_39_18) then
					local var_39_22 = Mathf.Lerp(0, 0.5, var_39_21)

					arg_36_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1071ui_story.fillRatio = var_39_22
				end
			end

			if arg_36_1.time_ >= var_39_19 + var_39_20 and arg_36_1.time_ < var_39_19 + var_39_20 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1071ui_story then
				local var_39_23 = 0.5

				arg_36_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1071ui_story.fillRatio = var_39_23
			end

			local var_39_24 = 0
			local var_39_25 = 1.275

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(324031009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 51
				local var_39_29 = utf8.len(var_39_27)
				local var_39_30 = var_39_28 <= 0 and var_39_25 or var_39_25 * (var_39_29 / var_39_28)

				if var_39_30 > 0 and var_39_25 < var_39_30 then
					arg_36_1.talkMaxDuration = var_39_30

					if var_39_30 + var_39_24 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_24
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_31 = math.max(var_39_25, arg_36_1.talkMaxDuration)

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_31 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_24) / var_39_31

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_24 + var_39_31 and arg_36_1.time_ < var_39_24 + var_39_31 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play324031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324031010
		arg_40_1.duration_ = 3.87

		local var_40_0 = {
			zh = 2.033,
			ja = 3.866
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10039ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10039ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(-0.7, -0.8, -6.2)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10039ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["10039ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10039ui_story == nil then
				arg_40_1.var_.characterEffect10039ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect10039ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10039ui_story then
				arg_40_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_15 = 0
			local var_43_16 = 0.2

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[472].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(324031010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 8
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031010", "story_v_out_324031.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031010", "story_v_out_324031.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_324031", "324031010", "story_v_out_324031.awb")

						arg_40_1:RecordAudio("324031010", var_43_24)
						arg_40_1:RecordAudio("324031010", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324031", "324031010", "story_v_out_324031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324031", "324031010", "story_v_out_324031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324031011
		arg_44_1.duration_ = 8.77

		local var_44_0 = {
			zh = 5.133,
			ja = 8.766
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1071ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1071ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0.7, -1.05, -6.2)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1071ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1071ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1071ui_story == nil then
				arg_44_1.var_.characterEffect1071ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1071ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1071ui_story then
				arg_44_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_47_13 = arg_44_1.actors_["10039ui_story"]
			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 and not isNil(var_47_13) and arg_44_1.var_.characterEffect10039ui_story == nil then
				arg_44_1.var_.characterEffect10039ui_story = var_47_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_15 = 0.200000002980232

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_15 and not isNil(var_47_13) then
				local var_47_16 = (arg_44_1.time_ - var_47_14) / var_47_15

				if arg_44_1.var_.characterEffect10039ui_story and not isNil(var_47_13) then
					local var_47_17 = Mathf.Lerp(0, 0.5, var_47_16)

					arg_44_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10039ui_story.fillRatio = var_47_17
				end
			end

			if arg_44_1.time_ >= var_47_14 + var_47_15 and arg_44_1.time_ < var_47_14 + var_47_15 + arg_47_0 and not isNil(var_47_13) and arg_44_1.var_.characterEffect10039ui_story then
				local var_47_18 = 0.5

				arg_44_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10039ui_story.fillRatio = var_47_18
			end

			local var_47_19 = 0

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				arg_44_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_47_20 = 0

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_47_21 = 0
			local var_47_22 = 0.8

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_23 = arg_44_1:FormatText(StoryNameCfg[384].name)

				arg_44_1.leftNameTxt_.text = var_47_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_24 = arg_44_1:GetWordFromCfg(324031011)
				local var_47_25 = arg_44_1:FormatText(var_47_24.content)

				arg_44_1.text_.text = var_47_25

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_26 = 32
				local var_47_27 = utf8.len(var_47_25)
				local var_47_28 = var_47_26 <= 0 and var_47_22 or var_47_22 * (var_47_27 / var_47_26)

				if var_47_28 > 0 and var_47_22 < var_47_28 then
					arg_44_1.talkMaxDuration = var_47_28

					if var_47_28 + var_47_21 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_21
					end
				end

				arg_44_1.text_.text = var_47_25
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031011", "story_v_out_324031.awb") ~= 0 then
					local var_47_29 = manager.audio:GetVoiceLength("story_v_out_324031", "324031011", "story_v_out_324031.awb") / 1000

					if var_47_29 + var_47_21 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_29 + var_47_21
					end

					if var_47_24.prefab_name ~= "" and arg_44_1.actors_[var_47_24.prefab_name] ~= nil then
						local var_47_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_24.prefab_name].transform, "story_v_out_324031", "324031011", "story_v_out_324031.awb")

						arg_44_1:RecordAudio("324031011", var_47_30)
						arg_44_1:RecordAudio("324031011", var_47_30)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324031", "324031011", "story_v_out_324031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324031", "324031011", "story_v_out_324031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_31 = math.max(var_47_22, arg_44_1.talkMaxDuration)

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_31 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_21) / var_47_31

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_21 + var_47_31 and arg_44_1.time_ < var_47_21 + var_47_31 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play324031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324031012
		arg_48_1.duration_ = 8.03

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "ST41"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 1.43333333333333

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.ST41

				var_51_5.transform.localPosition = var_51_4
				var_51_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_6 = var_51_5:GetComponent("SpriteRenderer")

				if var_51_6 and var_51_6.sprite then
					local var_51_7 = (var_51_5.transform.localPosition - var_51_3).z
					local var_51_8 = manager.ui.mainCameraCom_
					local var_51_9 = 2 * var_51_7 * Mathf.Tan(var_51_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_10 = var_51_9 * var_51_8.aspect
					local var_51_11 = var_51_6.sprite.bounds.size.x
					local var_51_12 = var_51_6.sprite.bounds.size.y
					local var_51_13 = var_51_10 / var_51_11
					local var_51_14 = var_51_9 / var_51_12
					local var_51_15 = var_51_14 < var_51_13 and var_51_13 or var_51_14

					var_51_5.transform.localScale = Vector3.New(var_51_15, var_51_15, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "ST41" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 1.43333333333333

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_17 = 0.3

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_19 = 1.43333333333333

			if var_51_18 <= arg_48_1.time_ and arg_48_1.time_ < var_51_18 + var_51_19 then
				local var_51_20 = (arg_48_1.time_ - var_51_18) / var_51_19
				local var_51_21 = Color.New(0, 0, 0)

				var_51_21.a = Mathf.Lerp(0, 1, var_51_20)
				arg_48_1.mask_.color = var_51_21
			end

			if arg_48_1.time_ >= var_51_18 + var_51_19 and arg_48_1.time_ < var_51_18 + var_51_19 + arg_51_0 then
				local var_51_22 = Color.New(0, 0, 0)

				var_51_22.a = 1
				arg_48_1.mask_.color = var_51_22
			end

			local var_51_23 = 1.43333333333333

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_24 = 2

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24
				local var_51_26 = Color.New(0, 0, 0)

				var_51_26.a = Mathf.Lerp(1, 0, var_51_25)
				arg_48_1.mask_.color = var_51_26
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 then
				local var_51_27 = Color.New(0, 0, 0)
				local var_51_28 = 0

				arg_48_1.mask_.enabled = false
				var_51_27.a = var_51_28
				arg_48_1.mask_.color = var_51_27
			end

			local var_51_29 = arg_48_1.actors_["10039ui_story"].transform
			local var_51_30 = 1.43333333333333

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.var_.moveOldPos10039ui_story = var_51_29.localPosition
			end

			local var_51_31 = 0.001

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_31 then
				local var_51_32 = (arg_48_1.time_ - var_51_30) / var_51_31
				local var_51_33 = Vector3.New(0, 100, 0)

				var_51_29.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10039ui_story, var_51_33, var_51_32)

				local var_51_34 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_34.x, var_51_34.y, var_51_34.z)

				local var_51_35 = var_51_29.localEulerAngles

				var_51_35.z = 0
				var_51_35.x = 0
				var_51_29.localEulerAngles = var_51_35
			end

			if arg_48_1.time_ >= var_51_30 + var_51_31 and arg_48_1.time_ < var_51_30 + var_51_31 + arg_51_0 then
				var_51_29.localPosition = Vector3.New(0, 100, 0)

				local var_51_36 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_36.x, var_51_36.y, var_51_36.z)

				local var_51_37 = var_51_29.localEulerAngles

				var_51_37.z = 0
				var_51_37.x = 0
				var_51_29.localEulerAngles = var_51_37
			end

			local var_51_38 = arg_48_1.actors_["1071ui_story"].transform
			local var_51_39 = 1.43333333333333

			if var_51_39 < arg_48_1.time_ and arg_48_1.time_ <= var_51_39 + arg_51_0 then
				arg_48_1.var_.moveOldPos1071ui_story = var_51_38.localPosition
			end

			local var_51_40 = 0.001

			if var_51_39 <= arg_48_1.time_ and arg_48_1.time_ < var_51_39 + var_51_40 then
				local var_51_41 = (arg_48_1.time_ - var_51_39) / var_51_40
				local var_51_42 = Vector3.New(0, 100, 0)

				var_51_38.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1071ui_story, var_51_42, var_51_41)

				local var_51_43 = manager.ui.mainCamera.transform.position - var_51_38.position

				var_51_38.forward = Vector3.New(var_51_43.x, var_51_43.y, var_51_43.z)

				local var_51_44 = var_51_38.localEulerAngles

				var_51_44.z = 0
				var_51_44.x = 0
				var_51_38.localEulerAngles = var_51_44
			end

			if arg_48_1.time_ >= var_51_39 + var_51_40 and arg_48_1.time_ < var_51_39 + var_51_40 + arg_51_0 then
				var_51_38.localPosition = Vector3.New(0, 100, 0)

				local var_51_45 = manager.ui.mainCamera.transform.position - var_51_38.position

				var_51_38.forward = Vector3.New(var_51_45.x, var_51_45.y, var_51_45.z)

				local var_51_46 = var_51_38.localEulerAngles

				var_51_46.z = 0
				var_51_46.x = 0
				var_51_38.localEulerAngles = var_51_46
			end

			local var_51_47 = arg_48_1.actors_["1071ui_story"]
			local var_51_48 = 1.43333333333333

			if var_51_48 < arg_48_1.time_ and arg_48_1.time_ <= var_51_48 + arg_51_0 and not isNil(var_51_47) and arg_48_1.var_.characterEffect1071ui_story == nil then
				arg_48_1.var_.characterEffect1071ui_story = var_51_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_49 = 0.200000002980232

			if var_51_48 <= arg_48_1.time_ and arg_48_1.time_ < var_51_48 + var_51_49 and not isNil(var_51_47) then
				local var_51_50 = (arg_48_1.time_ - var_51_48) / var_51_49

				if arg_48_1.var_.characterEffect1071ui_story and not isNil(var_51_47) then
					local var_51_51 = Mathf.Lerp(0, 0.5, var_51_50)

					arg_48_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1071ui_story.fillRatio = var_51_51
				end
			end

			if arg_48_1.time_ >= var_51_48 + var_51_49 and arg_48_1.time_ < var_51_48 + var_51_49 + arg_51_0 and not isNil(var_51_47) and arg_48_1.var_.characterEffect1071ui_story then
				local var_51_52 = 0.5

				arg_48_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1071ui_story.fillRatio = var_51_52
			end

			local var_51_53 = 1.2
			local var_51_54 = 1

			if var_51_53 < arg_48_1.time_ and arg_48_1.time_ <= var_51_53 + arg_51_0 then
				local var_51_55 = "play"
				local var_51_56 = "effect"

				arg_48_1:AudioAction(var_51_55, var_51_56, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_51_57 = 0.1
			local var_51_58 = 1

			if var_51_57 < arg_48_1.time_ and arg_48_1.time_ <= var_51_57 + arg_51_0 then
				local var_51_59 = "stop"
				local var_51_60 = "effect"

				arg_48_1:AudioAction(var_51_59, var_51_60, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_51_61 = 1.7
			local var_51_62 = 1

			if var_51_61 < arg_48_1.time_ and arg_48_1.time_ <= var_51_61 + arg_51_0 then
				local var_51_63 = "play"
				local var_51_64 = "effect"

				arg_48_1:AudioAction(var_51_63, var_51_64, "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_65 = 3.03333333333333
			local var_51_66 = 0.75

			if var_51_65 < arg_48_1.time_ and arg_48_1.time_ <= var_51_65 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_67 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_67:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_68 = arg_48_1:GetWordFromCfg(324031012)
				local var_51_69 = arg_48_1:FormatText(var_51_68.content)

				arg_48_1.text_.text = var_51_69

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_70 = 30
				local var_51_71 = utf8.len(var_51_69)
				local var_51_72 = var_51_70 <= 0 and var_51_66 or var_51_66 * (var_51_71 / var_51_70)

				if var_51_72 > 0 and var_51_66 < var_51_72 then
					arg_48_1.talkMaxDuration = var_51_72
					var_51_65 = var_51_65 + 0.3

					if var_51_72 + var_51_65 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_72 + var_51_65
					end
				end

				arg_48_1.text_.text = var_51_69
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_73 = var_51_65 + 0.3
			local var_51_74 = math.max(var_51_66, arg_48_1.talkMaxDuration)

			if var_51_73 <= arg_48_1.time_ and arg_48_1.time_ < var_51_73 + var_51_74 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_73) / var_51_74

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_73 + var_51_74 and arg_48_1.time_ < var_51_73 + var_51_74 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play324031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324031013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 1.475

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(324031013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 59
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324031014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.5

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(324031014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 60
				local var_61_5 = utf8.len(var_61_3)
				local var_61_6 = var_61_4 <= 0 and var_61_1 or var_61_1 * (var_61_5 / var_61_4)

				if var_61_6 > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_7 and arg_58_1.time_ < var_61_0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324031015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.55

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_2

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

				local var_65_3 = arg_62_1:GetWordFromCfg(324031015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 22
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
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_8 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_8 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_8

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_8 and arg_62_1.time_ < var_65_0 + var_65_8 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324031016
		arg_66_1.duration_ = 2.9

		local var_66_0 = {
			zh = 2.433,
			ja = 2.9
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
				arg_66_0:Play324031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1071ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1071ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, -1.05, -6.2)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1071ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1071ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1071ui_story == nil then
				arg_66_1.var_.characterEffect1071ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect1071ui_story and not isNil(var_69_9) then
					arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1071ui_story then
				arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_69_15 = 0
			local var_69_16 = 0.325

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[384].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(324031016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 13
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031016", "story_v_out_324031.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031016", "story_v_out_324031.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_324031", "324031016", "story_v_out_324031.awb")

						arg_66_1:RecordAudio("324031016", var_69_24)
						arg_66_1:RecordAudio("324031016", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324031", "324031016", "story_v_out_324031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324031", "324031016", "story_v_out_324031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324031017
		arg_70_1.duration_ = 6.33

		local var_70_0 = {
			zh = 4.433,
			ja = 6.333
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
				arg_70_0:Play324031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.5

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[384].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(324031017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031017", "story_v_out_324031.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031017", "story_v_out_324031.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_324031", "324031017", "story_v_out_324031.awb")

						arg_70_1:RecordAudio("324031017", var_73_9)
						arg_70_1:RecordAudio("324031017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324031", "324031017", "story_v_out_324031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324031", "324031017", "story_v_out_324031.awb")
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
	Play324031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324031018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1071ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1071ui_story == nil then
				arg_74_1.var_.characterEffect1071ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1071ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1071ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1071ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1071ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 1
			local var_77_7 = 1

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				local var_77_8 = "play"
				local var_77_9 = "effect"

				arg_74_1:AudioAction(var_77_8, var_77_9, "se_story_150", "se_story_150_footstep01", "")
			end

			local var_77_10 = 0
			local var_77_11 = 1.2

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_12 = arg_74_1:GetWordFromCfg(324031018)
				local var_77_13 = arg_74_1:FormatText(var_77_12.content)

				arg_74_1.text_.text = var_77_13

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_14 = 48
				local var_77_15 = utf8.len(var_77_13)
				local var_77_16 = var_77_14 <= 0 and var_77_11 or var_77_11 * (var_77_15 / var_77_14)

				if var_77_16 > 0 and var_77_11 < var_77_16 then
					arg_74_1.talkMaxDuration = var_77_16

					if var_77_16 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_16 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_13
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_17 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_17 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_17

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_17 and arg_74_1.time_ < var_77_10 + var_77_17 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play324031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324031019
		arg_78_1.duration_ = 4.6

		local var_78_0 = {
			zh = 3.166,
			ja = 4.6
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1071ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1071ui_story == nil then
				arg_78_1.var_.characterEffect1071ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1071ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1071ui_story then
				arg_78_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_1")
			end

			local var_81_5 = 0
			local var_81_6 = 0.35

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_7 = arg_78_1:FormatText(StoryNameCfg[384].name)

				arg_78_1.leftNameTxt_.text = var_81_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(324031019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 14
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_6 or var_81_6 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_6 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031019", "story_v_out_324031.awb") ~= 0 then
					local var_81_13 = manager.audio:GetVoiceLength("story_v_out_324031", "324031019", "story_v_out_324031.awb") / 1000

					if var_81_13 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_5
					end

					if var_81_8.prefab_name ~= "" and arg_78_1.actors_[var_81_8.prefab_name] ~= nil then
						local var_81_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_8.prefab_name].transform, "story_v_out_324031", "324031019", "story_v_out_324031.awb")

						arg_78_1:RecordAudio("324031019", var_81_14)
						arg_78_1:RecordAudio("324031019", var_81_14)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324031", "324031019", "story_v_out_324031.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324031", "324031019", "story_v_out_324031.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_15 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_15 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_15

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_15 and arg_78_1.time_ < var_81_5 + var_81_15 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324031020
		arg_82_1.duration_ = 4.13

		local var_82_0 = {
			zh = 2.9,
			ja = 4.133
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
				arg_82_0:Play324031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1071ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1071ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1071ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["10039ui_story"].transform
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.var_.moveOldPos10039ui_story = var_85_9.localPosition
			end

			local var_85_11 = 0.001

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11
				local var_85_13 = Vector3.New(0.7, -0.8, -6.2)

				var_85_9.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10039ui_story, var_85_13, var_85_12)

				local var_85_14 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_14.x, var_85_14.y, var_85_14.z)

				local var_85_15 = var_85_9.localEulerAngles

				var_85_15.z = 0
				var_85_15.x = 0
				var_85_9.localEulerAngles = var_85_15
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 then
				var_85_9.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_85_16 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_16.x, var_85_16.y, var_85_16.z)

				local var_85_17 = var_85_9.localEulerAngles

				var_85_17.z = 0
				var_85_17.x = 0
				var_85_9.localEulerAngles = var_85_17
			end

			local var_85_18 = arg_82_1.actors_["10039ui_story"]
			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 and not isNil(var_85_18) and arg_82_1.var_.characterEffect10039ui_story == nil then
				arg_82_1.var_.characterEffect10039ui_story = var_85_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_20 = 0.200000002980232

			if var_85_19 <= arg_82_1.time_ and arg_82_1.time_ < var_85_19 + var_85_20 and not isNil(var_85_18) then
				local var_85_21 = (arg_82_1.time_ - var_85_19) / var_85_20

				if arg_82_1.var_.characterEffect10039ui_story and not isNil(var_85_18) then
					arg_82_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_19 + var_85_20 and arg_82_1.time_ < var_85_19 + var_85_20 + arg_85_0 and not isNil(var_85_18) and arg_82_1.var_.characterEffect10039ui_story then
				arg_82_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_85_22 = arg_82_1.actors_["1071ui_story"]
			local var_85_23 = 0

			if var_85_23 < arg_82_1.time_ and arg_82_1.time_ <= var_85_23 + arg_85_0 and not isNil(var_85_22) and arg_82_1.var_.characterEffect1071ui_story == nil then
				arg_82_1.var_.characterEffect1071ui_story = var_85_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_24 = 0.200000002980232

			if var_85_23 <= arg_82_1.time_ and arg_82_1.time_ < var_85_23 + var_85_24 and not isNil(var_85_22) then
				local var_85_25 = (arg_82_1.time_ - var_85_23) / var_85_24

				if arg_82_1.var_.characterEffect1071ui_story and not isNil(var_85_22) then
					local var_85_26 = Mathf.Lerp(0, 0.5, var_85_25)

					arg_82_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1071ui_story.fillRatio = var_85_26
				end
			end

			if arg_82_1.time_ >= var_85_23 + var_85_24 and arg_82_1.time_ < var_85_23 + var_85_24 + arg_85_0 and not isNil(var_85_22) and arg_82_1.var_.characterEffect1071ui_story then
				local var_85_27 = 0.5

				arg_82_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1071ui_story.fillRatio = var_85_27
			end

			local var_85_28 = 0

			if var_85_28 < arg_82_1.time_ and arg_82_1.time_ <= var_85_28 + arg_85_0 then
				arg_82_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_85_29 = 0
			local var_85_30 = 0.25

			if var_85_29 < arg_82_1.time_ and arg_82_1.time_ <= var_85_29 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_31 = arg_82_1:FormatText(StoryNameCfg[472].name)

				arg_82_1.leftNameTxt_.text = var_85_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_32 = arg_82_1:GetWordFromCfg(324031020)
				local var_85_33 = arg_82_1:FormatText(var_85_32.content)

				arg_82_1.text_.text = var_85_33

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_34 = 10
				local var_85_35 = utf8.len(var_85_33)
				local var_85_36 = var_85_34 <= 0 and var_85_30 or var_85_30 * (var_85_35 / var_85_34)

				if var_85_36 > 0 and var_85_30 < var_85_36 then
					arg_82_1.talkMaxDuration = var_85_36

					if var_85_36 + var_85_29 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_36 + var_85_29
					end
				end

				arg_82_1.text_.text = var_85_33
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031020", "story_v_out_324031.awb") ~= 0 then
					local var_85_37 = manager.audio:GetVoiceLength("story_v_out_324031", "324031020", "story_v_out_324031.awb") / 1000

					if var_85_37 + var_85_29 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_37 + var_85_29
					end

					if var_85_32.prefab_name ~= "" and arg_82_1.actors_[var_85_32.prefab_name] ~= nil then
						local var_85_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_32.prefab_name].transform, "story_v_out_324031", "324031020", "story_v_out_324031.awb")

						arg_82_1:RecordAudio("324031020", var_85_38)
						arg_82_1:RecordAudio("324031020", var_85_38)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324031", "324031020", "story_v_out_324031.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324031", "324031020", "story_v_out_324031.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_39 = math.max(var_85_30, arg_82_1.talkMaxDuration)

			if var_85_29 <= arg_82_1.time_ and arg_82_1.time_ < var_85_29 + var_85_39 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_29) / var_85_39

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_29 + var_85_39 and arg_82_1.time_ < var_85_29 + var_85_39 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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
				actorName = "10039ui_story",
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
	Play324031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324031021
		arg_86_1.duration_ = 6.5

		local var_86_0 = {
			zh = 3.5,
			ja = 6.5
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
				arg_86_0:Play324031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1071ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1071ui_story == nil then
				arg_86_1.var_.characterEffect1071ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1071ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1071ui_story then
				arg_86_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10039ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10039ui_story == nil then
				arg_86_1.var_.characterEffect10039ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10039ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10039ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10039ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10039ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0
			local var_89_11 = 0.45

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_12 = arg_86_1:FormatText(StoryNameCfg[384].name)

				arg_86_1.leftNameTxt_.text = var_89_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_13 = arg_86_1:GetWordFromCfg(324031021)
				local var_89_14 = arg_86_1:FormatText(var_89_13.content)

				arg_86_1.text_.text = var_89_14

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 18
				local var_89_16 = utf8.len(var_89_14)
				local var_89_17 = var_89_15 <= 0 and var_89_11 or var_89_11 * (var_89_16 / var_89_15)

				if var_89_17 > 0 and var_89_11 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_14
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031021", "story_v_out_324031.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_324031", "324031021", "story_v_out_324031.awb") / 1000

					if var_89_18 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_10
					end

					if var_89_13.prefab_name ~= "" and arg_86_1.actors_[var_89_13.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_13.prefab_name].transform, "story_v_out_324031", "324031021", "story_v_out_324031.awb")

						arg_86_1:RecordAudio("324031021", var_89_19)
						arg_86_1:RecordAudio("324031021", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324031", "324031021", "story_v_out_324031.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324031", "324031021", "story_v_out_324031.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_20 and arg_86_1.time_ < var_89_10 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play324031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324031022
		arg_90_1.duration_ = 14.4

		local var_90_0 = {
			zh = 11.633,
			ja = 14.4
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
				arg_90_0:Play324031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_2")
			end

			local var_93_1 = 0
			local var_93_2 = 1.45

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_3 = arg_90_1:FormatText(StoryNameCfg[384].name)

				arg_90_1.leftNameTxt_.text = var_93_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(324031022)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 58
				local var_93_7 = utf8.len(var_93_5)
				local var_93_8 = var_93_6 <= 0 and var_93_2 or var_93_2 * (var_93_7 / var_93_6)

				if var_93_8 > 0 and var_93_2 < var_93_8 then
					arg_90_1.talkMaxDuration = var_93_8

					if var_93_8 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031022", "story_v_out_324031.awb") ~= 0 then
					local var_93_9 = manager.audio:GetVoiceLength("story_v_out_324031", "324031022", "story_v_out_324031.awb") / 1000

					if var_93_9 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_1
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_324031", "324031022", "story_v_out_324031.awb")

						arg_90_1:RecordAudio("324031022", var_93_10)
						arg_90_1:RecordAudio("324031022", var_93_10)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324031", "324031022", "story_v_out_324031.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324031", "324031022", "story_v_out_324031.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_11 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_11 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_11

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_11 and arg_90_1.time_ < var_93_1 + var_93_11 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324031023
		arg_94_1.duration_ = 15.23

		local var_94_0 = {
			zh = 10.233,
			ja = 15.233
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
				arg_94_0:Play324031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.2

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[384].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(324031023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 48
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031023", "story_v_out_324031.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031023", "story_v_out_324031.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_324031", "324031023", "story_v_out_324031.awb")

						arg_94_1:RecordAudio("324031023", var_97_9)
						arg_94_1:RecordAudio("324031023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324031", "324031023", "story_v_out_324031.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324031", "324031023", "story_v_out_324031.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324031024
		arg_98_1.duration_ = 9.6

		local var_98_0 = {
			zh = 8.2,
			ja = 9.6
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
				arg_98_0:Play324031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10039ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10039ui_story == nil then
				arg_98_1.var_.characterEffect10039ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10039ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10039ui_story then
				arg_98_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1071ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1071ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1071ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1071ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_101_11 = 0
			local var_101_12 = 0.675

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_13 = arg_98_1:FormatText(StoryNameCfg[472].name)

				arg_98_1.leftNameTxt_.text = var_101_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(324031024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 27
				local var_101_17 = utf8.len(var_101_15)
				local var_101_18 = var_101_16 <= 0 and var_101_12 or var_101_12 * (var_101_17 / var_101_16)

				if var_101_18 > 0 and var_101_12 < var_101_18 then
					arg_98_1.talkMaxDuration = var_101_18

					if var_101_18 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_11
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031024", "story_v_out_324031.awb") ~= 0 then
					local var_101_19 = manager.audio:GetVoiceLength("story_v_out_324031", "324031024", "story_v_out_324031.awb") / 1000

					if var_101_19 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_11
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_324031", "324031024", "story_v_out_324031.awb")

						arg_98_1:RecordAudio("324031024", var_101_20)
						arg_98_1:RecordAudio("324031024", var_101_20)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324031", "324031024", "story_v_out_324031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324031", "324031024", "story_v_out_324031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_21 = math.max(var_101_12, arg_98_1.talkMaxDuration)

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_21 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_11) / var_101_21

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_11 + var_101_21 and arg_98_1.time_ < var_101_11 + var_101_21 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324031025
		arg_102_1.duration_ = 7.73

		local var_102_0 = {
			zh = 6.166,
			ja = 7.733
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
				arg_102_0:Play324031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1071ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1071ui_story == nil then
				arg_102_1.var_.characterEffect1071ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1071ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1071ui_story then
				arg_102_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["10039ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10039ui_story == nil then
				arg_102_1.var_.characterEffect10039ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect10039ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10039ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10039ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10039ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0
			local var_105_11 = 0.7

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_12 = arg_102_1:FormatText(StoryNameCfg[384].name)

				arg_102_1.leftNameTxt_.text = var_105_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_13 = arg_102_1:GetWordFromCfg(324031025)
				local var_105_14 = arg_102_1:FormatText(var_105_13.content)

				arg_102_1.text_.text = var_105_14

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 28
				local var_105_16 = utf8.len(var_105_14)
				local var_105_17 = var_105_15 <= 0 and var_105_11 or var_105_11 * (var_105_16 / var_105_15)

				if var_105_17 > 0 and var_105_11 < var_105_17 then
					arg_102_1.talkMaxDuration = var_105_17

					if var_105_17 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_17 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_14
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031025", "story_v_out_324031.awb") ~= 0 then
					local var_105_18 = manager.audio:GetVoiceLength("story_v_out_324031", "324031025", "story_v_out_324031.awb") / 1000

					if var_105_18 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_18 + var_105_10
					end

					if var_105_13.prefab_name ~= "" and arg_102_1.actors_[var_105_13.prefab_name] ~= nil then
						local var_105_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_13.prefab_name].transform, "story_v_out_324031", "324031025", "story_v_out_324031.awb")

						arg_102_1:RecordAudio("324031025", var_105_19)
						arg_102_1:RecordAudio("324031025", var_105_19)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324031", "324031025", "story_v_out_324031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324031", "324031025", "story_v_out_324031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_20 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_20 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_10) / var_105_20

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_10 + var_105_20 and arg_102_1.time_ < var_105_10 + var_105_20 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play324031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324031026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10039ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos10039ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10039ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1071ui_story"].transform
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.var_.moveOldPos1071ui_story = var_109_9.localPosition
			end

			local var_109_11 = 0.001

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11
				local var_109_13 = Vector3.New(0, 100, 0)

				var_109_9.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1071ui_story, var_109_13, var_109_12)

				local var_109_14 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_14.x, var_109_14.y, var_109_14.z)

				local var_109_15 = var_109_9.localEulerAngles

				var_109_15.z = 0
				var_109_15.x = 0
				var_109_9.localEulerAngles = var_109_15
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 then
				var_109_9.localPosition = Vector3.New(0, 100, 0)

				local var_109_16 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_16.x, var_109_16.y, var_109_16.z)

				local var_109_17 = var_109_9.localEulerAngles

				var_109_17.z = 0
				var_109_17.x = 0
				var_109_9.localEulerAngles = var_109_17
			end

			local var_109_18 = arg_106_1.actors_["1071ui_story"]
			local var_109_19 = 0

			if var_109_19 < arg_106_1.time_ and arg_106_1.time_ <= var_109_19 + arg_109_0 and not isNil(var_109_18) and arg_106_1.var_.characterEffect1071ui_story == nil then
				arg_106_1.var_.characterEffect1071ui_story = var_109_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_20 = 0.200000002980232

			if var_109_19 <= arg_106_1.time_ and arg_106_1.time_ < var_109_19 + var_109_20 and not isNil(var_109_18) then
				local var_109_21 = (arg_106_1.time_ - var_109_19) / var_109_20

				if arg_106_1.var_.characterEffect1071ui_story and not isNil(var_109_18) then
					local var_109_22 = Mathf.Lerp(0, 0.5, var_109_21)

					arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1071ui_story.fillRatio = var_109_22
				end
			end

			if arg_106_1.time_ >= var_109_19 + var_109_20 and arg_106_1.time_ < var_109_19 + var_109_20 + arg_109_0 and not isNil(var_109_18) and arg_106_1.var_.characterEffect1071ui_story then
				local var_109_23 = 0.5

				arg_106_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1071ui_story.fillRatio = var_109_23
			end

			local var_109_24 = 0
			local var_109_25 = 1.2

			if var_109_24 < arg_106_1.time_ and arg_106_1.time_ <= var_109_24 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(324031026)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 48
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_25 or var_109_25 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_25 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30

					if var_109_30 + var_109_24 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_24
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_31 = math.max(var_109_25, arg_106_1.talkMaxDuration)

			if var_109_24 <= arg_106_1.time_ and arg_106_1.time_ < var_109_24 + var_109_31 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_24) / var_109_31

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_24 + var_109_31 and arg_106_1.time_ < var_109_24 + var_109_31 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play324031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324031027
		arg_110_1.duration_ = 12.77

		local var_110_0 = {
			zh = 7.966,
			ja = 12.766
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1071ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1071ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, -1.05, -6.2)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1071ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1071ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1071ui_story == nil then
				arg_110_1.var_.characterEffect1071ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.200000002980232

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect1071ui_story and not isNil(var_113_9) then
					arg_110_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1071ui_story then
				arg_110_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_113_13 = 0

			if var_113_13 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 then
				arg_110_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_113_15 = 0
			local var_113_16 = 1.075

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_17 = arg_110_1:FormatText(StoryNameCfg[384].name)

				arg_110_1.leftNameTxt_.text = var_113_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(324031027)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 43
				local var_113_21 = utf8.len(var_113_19)
				local var_113_22 = var_113_20 <= 0 and var_113_16 or var_113_16 * (var_113_21 / var_113_20)

				if var_113_22 > 0 and var_113_16 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031027", "story_v_out_324031.awb") ~= 0 then
					local var_113_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031027", "story_v_out_324031.awb") / 1000

					if var_113_23 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_15
					end

					if var_113_18.prefab_name ~= "" and arg_110_1.actors_[var_113_18.prefab_name] ~= nil then
						local var_113_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_18.prefab_name].transform, "story_v_out_324031", "324031027", "story_v_out_324031.awb")

						arg_110_1:RecordAudio("324031027", var_113_24)
						arg_110_1:RecordAudio("324031027", var_113_24)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324031", "324031027", "story_v_out_324031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324031", "324031027", "story_v_out_324031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_25 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_25 and arg_110_1.time_ < var_113_15 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play324031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324031028
		arg_114_1.duration_ = 10.73

		local var_114_0 = {
			zh = 6.5,
			ja = 10.733
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.875

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[384].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(324031028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031028", "story_v_out_324031.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031028", "story_v_out_324031.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_324031", "324031028", "story_v_out_324031.awb")

						arg_114_1:RecordAudio("324031028", var_117_9)
						arg_114_1:RecordAudio("324031028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_324031", "324031028", "story_v_out_324031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_324031", "324031028", "story_v_out_324031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324031029
		arg_118_1.duration_ = 11.2

		local var_118_0 = {
			zh = 10.5,
			ja = 11.2
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
				arg_118_0:Play324031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_121_1 = 0
			local var_121_2 = 1.3

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_3 = arg_118_1:FormatText(StoryNameCfg[384].name)

				arg_118_1.leftNameTxt_.text = var_121_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(324031029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_6 = 52
				local var_121_7 = utf8.len(var_121_5)
				local var_121_8 = var_121_6 <= 0 and var_121_2 or var_121_2 * (var_121_7 / var_121_6)

				if var_121_8 > 0 and var_121_2 < var_121_8 then
					arg_118_1.talkMaxDuration = var_121_8

					if var_121_8 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031029", "story_v_out_324031.awb") ~= 0 then
					local var_121_9 = manager.audio:GetVoiceLength("story_v_out_324031", "324031029", "story_v_out_324031.awb") / 1000

					if var_121_9 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_1
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_324031", "324031029", "story_v_out_324031.awb")

						arg_118_1:RecordAudio("324031029", var_121_10)
						arg_118_1:RecordAudio("324031029", var_121_10)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_324031", "324031029", "story_v_out_324031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_324031", "324031029", "story_v_out_324031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_11 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_11 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_11

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_11 and arg_118_1.time_ < var_121_1 + var_121_11 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324031030
		arg_122_1.duration_ = 10.23

		local var_122_0 = {
			zh = 8,
			ja = 10.233
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1071ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1071ui_story == nil then
				arg_122_1.var_.characterEffect1071ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1071ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1071ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1071ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1071ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.75

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[1499].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(324031030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 30
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031030", "story_v_out_324031.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031030", "story_v_out_324031.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_324031", "324031030", "story_v_out_324031.awb")

						arg_122_1:RecordAudio("324031030", var_125_15)
						arg_122_1:RecordAudio("324031030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_324031", "324031030", "story_v_out_324031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_324031", "324031030", "story_v_out_324031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324031031
		arg_126_1.duration_ = 16.17

		local var_126_0 = {
			zh = 16.166,
			ja = 14.566
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.65

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[1499].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(324031031)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 66
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031031", "story_v_out_324031.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031031", "story_v_out_324031.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_324031", "324031031", "story_v_out_324031.awb")

						arg_126_1:RecordAudio("324031031", var_129_9)
						arg_126_1:RecordAudio("324031031", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324031", "324031031", "story_v_out_324031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324031", "324031031", "story_v_out_324031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324031032
		arg_130_1.duration_ = 2.83

		local var_130_0 = {
			zh = 2.833,
			ja = 2.3
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "1061ui_story"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_130_1.stage_.transform)

					var_133_2.name = var_133_0
					var_133_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_130_1.actors_[var_133_0] = var_133_2

					local var_133_3 = var_133_2:GetComponentInChildren(typeof(CharacterEffect))

					var_133_3.enabled = true

					local var_133_4 = GameObjectTools.GetOrAddComponent(var_133_2, typeof(DynamicBoneHelper))

					if var_133_4 then
						var_133_4:EnableDynamicBone(false)
					end

					arg_130_1:ShowWeapon(var_133_3.transform, false)

					arg_130_1.var_[var_133_0 .. "Animator"] = var_133_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_130_1.var_[var_133_0 .. "Animator"].applyRootMotion = true
					arg_130_1.var_[var_133_0 .. "LipSync"] = var_133_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_133_5 = arg_130_1.actors_["1061ui_story"].transform
			local var_133_6 = 0

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.var_.moveOldPos1061ui_story = var_133_5.localPosition
			end

			local var_133_7 = 0.001

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7
				local var_133_9 = Vector3.New(0, -1.18, -6.15)

				var_133_5.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1061ui_story, var_133_9, var_133_8)

				local var_133_10 = manager.ui.mainCamera.transform.position - var_133_5.position

				var_133_5.forward = Vector3.New(var_133_10.x, var_133_10.y, var_133_10.z)

				local var_133_11 = var_133_5.localEulerAngles

				var_133_11.z = 0
				var_133_11.x = 0
				var_133_5.localEulerAngles = var_133_11
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 then
				var_133_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_133_12 = manager.ui.mainCamera.transform.position - var_133_5.position

				var_133_5.forward = Vector3.New(var_133_12.x, var_133_12.y, var_133_12.z)

				local var_133_13 = var_133_5.localEulerAngles

				var_133_13.z = 0
				var_133_13.x = 0
				var_133_5.localEulerAngles = var_133_13
			end

			local var_133_14 = arg_130_1.actors_["1061ui_story"]
			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 and not isNil(var_133_14) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = var_133_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_16 = 0.200000002980232

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_16 and not isNil(var_133_14) then
				local var_133_17 = (arg_130_1.time_ - var_133_15) / var_133_16

				if arg_130_1.var_.characterEffect1061ui_story and not isNil(var_133_14) then
					arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_15 + var_133_16 and arg_130_1.time_ < var_133_15 + var_133_16 + arg_133_0 and not isNil(var_133_14) and arg_130_1.var_.characterEffect1061ui_story then
				arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_133_18 = 0

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_1")
			end

			local var_133_19 = 0

			if var_133_19 < arg_130_1.time_ and arg_130_1.time_ <= var_133_19 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_20 = arg_130_1.actors_["1071ui_story"].transform
			local var_133_21 = 0

			if var_133_21 < arg_130_1.time_ and arg_130_1.time_ <= var_133_21 + arg_133_0 then
				arg_130_1.var_.moveOldPos1071ui_story = var_133_20.localPosition
			end

			local var_133_22 = 0.001

			if var_133_21 <= arg_130_1.time_ and arg_130_1.time_ < var_133_21 + var_133_22 then
				local var_133_23 = (arg_130_1.time_ - var_133_21) / var_133_22
				local var_133_24 = Vector3.New(0, 100, 0)

				var_133_20.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1071ui_story, var_133_24, var_133_23)

				local var_133_25 = manager.ui.mainCamera.transform.position - var_133_20.position

				var_133_20.forward = Vector3.New(var_133_25.x, var_133_25.y, var_133_25.z)

				local var_133_26 = var_133_20.localEulerAngles

				var_133_26.z = 0
				var_133_26.x = 0
				var_133_20.localEulerAngles = var_133_26
			end

			if arg_130_1.time_ >= var_133_21 + var_133_22 and arg_130_1.time_ < var_133_21 + var_133_22 + arg_133_0 then
				var_133_20.localPosition = Vector3.New(0, 100, 0)

				local var_133_27 = manager.ui.mainCamera.transform.position - var_133_20.position

				var_133_20.forward = Vector3.New(var_133_27.x, var_133_27.y, var_133_27.z)

				local var_133_28 = var_133_20.localEulerAngles

				var_133_28.z = 0
				var_133_28.x = 0
				var_133_20.localEulerAngles = var_133_28
			end

			local var_133_29 = 0
			local var_133_30 = 0.225

			if var_133_29 < arg_130_1.time_ and arg_130_1.time_ <= var_133_29 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_31 = arg_130_1:FormatText(StoryNameCfg[612].name)

				arg_130_1.leftNameTxt_.text = var_133_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_32 = arg_130_1:GetWordFromCfg(324031032)
				local var_133_33 = arg_130_1:FormatText(var_133_32.content)

				arg_130_1.text_.text = var_133_33

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_34 = 9
				local var_133_35 = utf8.len(var_133_33)
				local var_133_36 = var_133_34 <= 0 and var_133_30 or var_133_30 * (var_133_35 / var_133_34)

				if var_133_36 > 0 and var_133_30 < var_133_36 then
					arg_130_1.talkMaxDuration = var_133_36

					if var_133_36 + var_133_29 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_36 + var_133_29
					end
				end

				arg_130_1.text_.text = var_133_33
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031032", "story_v_out_324031.awb") ~= 0 then
					local var_133_37 = manager.audio:GetVoiceLength("story_v_out_324031", "324031032", "story_v_out_324031.awb") / 1000

					if var_133_37 + var_133_29 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_37 + var_133_29
					end

					if var_133_32.prefab_name ~= "" and arg_130_1.actors_[var_133_32.prefab_name] ~= nil then
						local var_133_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_32.prefab_name].transform, "story_v_out_324031", "324031032", "story_v_out_324031.awb")

						arg_130_1:RecordAudio("324031032", var_133_38)
						arg_130_1:RecordAudio("324031032", var_133_38)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_324031", "324031032", "story_v_out_324031.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_324031", "324031032", "story_v_out_324031.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_39 = math.max(var_133_30, arg_130_1.talkMaxDuration)

			if var_133_29 <= arg_130_1.time_ and arg_130_1.time_ < var_133_29 + var_133_39 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_29) / var_133_39

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_29 + var_133_39 and arg_130_1.time_ < var_133_29 + var_133_39 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play324031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324031033
		arg_134_1.duration_ = 14.4

		local var_134_0 = {
			zh = 11.733,
			ja = 14.4
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1061ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 1.275

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[1499].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(324031033)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 51
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031033", "story_v_out_324031.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031033", "story_v_out_324031.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_324031", "324031033", "story_v_out_324031.awb")

						arg_134_1:RecordAudio("324031033", var_137_15)
						arg_134_1:RecordAudio("324031033", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_324031", "324031033", "story_v_out_324031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_324031", "324031033", "story_v_out_324031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324031034
		arg_138_1.duration_ = 18.63

		local var_138_0 = {
			zh = 11.4,
			ja = 18.633
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
				arg_138_0:Play324031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[1499].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(324031034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 40
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031034", "story_v_out_324031.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031034", "story_v_out_324031.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_324031", "324031034", "story_v_out_324031.awb")

						arg_138_1:RecordAudio("324031034", var_141_9)
						arg_138_1:RecordAudio("324031034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_324031", "324031034", "story_v_out_324031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_324031", "324031034", "story_v_out_324031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play324031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324031035
		arg_142_1.duration_ = 5.1

		local var_142_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = "1012ui_story"

			if arg_142_1.actors_[var_145_0] == nil then
				local var_145_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_145_1) then
					local var_145_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_142_1.stage_.transform)

					var_145_2.name = var_145_0
					var_145_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_142_1.actors_[var_145_0] = var_145_2

					local var_145_3 = var_145_2:GetComponentInChildren(typeof(CharacterEffect))

					var_145_3.enabled = true

					local var_145_4 = GameObjectTools.GetOrAddComponent(var_145_2, typeof(DynamicBoneHelper))

					if var_145_4 then
						var_145_4:EnableDynamicBone(false)
					end

					arg_142_1:ShowWeapon(var_145_3.transform, false)

					arg_142_1.var_[var_145_0 .. "Animator"] = var_145_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_142_1.var_[var_145_0 .. "Animator"].applyRootMotion = true
					arg_142_1.var_[var_145_0 .. "LipSync"] = var_145_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_145_5 = arg_142_1.actors_["1012ui_story"].transform
			local var_145_6 = 0

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.var_.moveOldPos1012ui_story = var_145_5.localPosition
			end

			local var_145_7 = 0.001

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_7 then
				local var_145_8 = (arg_142_1.time_ - var_145_6) / var_145_7
				local var_145_9 = Vector3.New(0, -1.05, -6.24)

				var_145_5.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1012ui_story, var_145_9, var_145_8)

				local var_145_10 = manager.ui.mainCamera.transform.position - var_145_5.position

				var_145_5.forward = Vector3.New(var_145_10.x, var_145_10.y, var_145_10.z)

				local var_145_11 = var_145_5.localEulerAngles

				var_145_11.z = 0
				var_145_11.x = 0
				var_145_5.localEulerAngles = var_145_11
			end

			if arg_142_1.time_ >= var_145_6 + var_145_7 and arg_142_1.time_ < var_145_6 + var_145_7 + arg_145_0 then
				var_145_5.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_145_12 = manager.ui.mainCamera.transform.position - var_145_5.position

				var_145_5.forward = Vector3.New(var_145_12.x, var_145_12.y, var_145_12.z)

				local var_145_13 = var_145_5.localEulerAngles

				var_145_13.z = 0
				var_145_13.x = 0
				var_145_5.localEulerAngles = var_145_13
			end

			local var_145_14 = arg_142_1.actors_["1061ui_story"].transform
			local var_145_15 = 0

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.var_.moveOldPos1061ui_story = var_145_14.localPosition
			end

			local var_145_16 = 0.001

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_16 then
				local var_145_17 = (arg_142_1.time_ - var_145_15) / var_145_16
				local var_145_18 = Vector3.New(0, 100, 0)

				var_145_14.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1061ui_story, var_145_18, var_145_17)

				local var_145_19 = manager.ui.mainCamera.transform.position - var_145_14.position

				var_145_14.forward = Vector3.New(var_145_19.x, var_145_19.y, var_145_19.z)

				local var_145_20 = var_145_14.localEulerAngles

				var_145_20.z = 0
				var_145_20.x = 0
				var_145_14.localEulerAngles = var_145_20
			end

			if arg_142_1.time_ >= var_145_15 + var_145_16 and arg_142_1.time_ < var_145_15 + var_145_16 + arg_145_0 then
				var_145_14.localPosition = Vector3.New(0, 100, 0)

				local var_145_21 = manager.ui.mainCamera.transform.position - var_145_14.position

				var_145_14.forward = Vector3.New(var_145_21.x, var_145_21.y, var_145_21.z)

				local var_145_22 = var_145_14.localEulerAngles

				var_145_22.z = 0
				var_145_22.x = 0
				var_145_14.localEulerAngles = var_145_22
			end

			local var_145_23 = arg_142_1.actors_["1012ui_story"]
			local var_145_24 = 0

			if var_145_24 < arg_142_1.time_ and arg_142_1.time_ <= var_145_24 + arg_145_0 and not isNil(var_145_23) and arg_142_1.var_.characterEffect1012ui_story == nil then
				arg_142_1.var_.characterEffect1012ui_story = var_145_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_25 = 0.200000002980232

			if var_145_24 <= arg_142_1.time_ and arg_142_1.time_ < var_145_24 + var_145_25 and not isNil(var_145_23) then
				local var_145_26 = (arg_142_1.time_ - var_145_24) / var_145_25

				if arg_142_1.var_.characterEffect1012ui_story and not isNil(var_145_23) then
					arg_142_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_24 + var_145_25 and arg_142_1.time_ < var_145_24 + var_145_25 + arg_145_0 and not isNil(var_145_23) and arg_142_1.var_.characterEffect1012ui_story then
				arg_142_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_145_27 = 0

			if var_145_27 < arg_142_1.time_ and arg_142_1.time_ <= var_145_27 + arg_145_0 then
				arg_142_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_145_28 = 0

			if var_145_28 < arg_142_1.time_ and arg_142_1.time_ <= var_145_28 + arg_145_0 then
				arg_142_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_145_29 = 0
			local var_145_30 = 0.375

			if var_145_29 < arg_142_1.time_ and arg_142_1.time_ <= var_145_29 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_31 = arg_142_1:FormatText(StoryNameCfg[595].name)

				arg_142_1.leftNameTxt_.text = var_145_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_32 = arg_142_1:GetWordFromCfg(324031035)
				local var_145_33 = arg_142_1:FormatText(var_145_32.content)

				arg_142_1.text_.text = var_145_33

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_34 = 15
				local var_145_35 = utf8.len(var_145_33)
				local var_145_36 = var_145_34 <= 0 and var_145_30 or var_145_30 * (var_145_35 / var_145_34)

				if var_145_36 > 0 and var_145_30 < var_145_36 then
					arg_142_1.talkMaxDuration = var_145_36

					if var_145_36 + var_145_29 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_36 + var_145_29
					end
				end

				arg_142_1.text_.text = var_145_33
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031035", "story_v_out_324031.awb") ~= 0 then
					local var_145_37 = manager.audio:GetVoiceLength("story_v_out_324031", "324031035", "story_v_out_324031.awb") / 1000

					if var_145_37 + var_145_29 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_37 + var_145_29
					end

					if var_145_32.prefab_name ~= "" and arg_142_1.actors_[var_145_32.prefab_name] ~= nil then
						local var_145_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_32.prefab_name].transform, "story_v_out_324031", "324031035", "story_v_out_324031.awb")

						arg_142_1:RecordAudio("324031035", var_145_38)
						arg_142_1:RecordAudio("324031035", var_145_38)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_324031", "324031035", "story_v_out_324031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_324031", "324031035", "story_v_out_324031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_39 = math.max(var_145_30, arg_142_1.talkMaxDuration)

			if var_145_29 <= arg_142_1.time_ and arg_142_1.time_ < var_145_29 + var_145_39 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_29) / var_145_39

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_29 + var_145_39 and arg_142_1.time_ < var_145_29 + var_145_39 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play324031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324031036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1012ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1012ui_story == nil then
				arg_146_1.var_.characterEffect1012ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1012ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1012ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1012ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1012ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 1.575

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(324031036)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 63
				local var_149_11 = utf8.len(var_149_9)
				local var_149_12 = var_149_10 <= 0 and var_149_7 or var_149_7 * (var_149_11 / var_149_10)

				if var_149_12 > 0 and var_149_7 < var_149_12 then
					arg_146_1.talkMaxDuration = var_149_12

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_13 and arg_146_1.time_ < var_149_6 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324031037
		arg_150_1.duration_ = 14.17

		local var_150_0 = {
			zh = 5.033,
			ja = 14.166
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1012ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1012ui_story == nil then
				arg_150_1.var_.characterEffect1012ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1012ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1012ui_story then
				arg_150_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_153_4 = 0
			local var_153_5 = 0.725

			if var_153_4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_6 = arg_150_1:FormatText(StoryNameCfg[595].name)

				arg_150_1.leftNameTxt_.text = var_153_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_7 = arg_150_1:GetWordFromCfg(324031037)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 29
				local var_153_10 = utf8.len(var_153_8)
				local var_153_11 = var_153_9 <= 0 and var_153_5 or var_153_5 * (var_153_10 / var_153_9)

				if var_153_11 > 0 and var_153_5 < var_153_11 then
					arg_150_1.talkMaxDuration = var_153_11

					if var_153_11 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031037", "story_v_out_324031.awb") ~= 0 then
					local var_153_12 = manager.audio:GetVoiceLength("story_v_out_324031", "324031037", "story_v_out_324031.awb") / 1000

					if var_153_12 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_12 + var_153_4
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_out_324031", "324031037", "story_v_out_324031.awb")

						arg_150_1:RecordAudio("324031037", var_153_13)
						arg_150_1:RecordAudio("324031037", var_153_13)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_324031", "324031037", "story_v_out_324031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_324031", "324031037", "story_v_out_324031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_14 and arg_150_1.time_ < var_153_4 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play324031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324031038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play324031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1012ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1012ui_story == nil then
				arg_154_1.var_.characterEffect1012ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1012ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1012ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1012ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1012ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.875

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_9 = arg_154_1:GetWordFromCfg(324031038)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 35
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324031039
		arg_158_1.duration_ = 2

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1012ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1012ui_story == nil then
				arg_158_1.var_.characterEffect1012ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1012ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1012ui_story then
				arg_158_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_161_4 = 0

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_161_5 = 0

			if var_161_5 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_161_6 = 0
			local var_161_7 = 0.05

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[595].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_9 = arg_158_1:GetWordFromCfg(324031039)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031039", "story_v_out_324031.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031039", "story_v_out_324031.awb") / 1000

					if var_161_14 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_6
					end

					if var_161_9.prefab_name ~= "" and arg_158_1.actors_[var_161_9.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_9.prefab_name].transform, "story_v_out_324031", "324031039", "story_v_out_324031.awb")

						arg_158_1:RecordAudio("324031039", var_161_15)
						arg_158_1:RecordAudio("324031039", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_324031", "324031039", "story_v_out_324031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_324031", "324031039", "story_v_out_324031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_16 and arg_158_1.time_ < var_161_6 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play324031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324031040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1012ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1012ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(0, 100, 0)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1012ui_story, var_165_4, var_165_3)

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

			local var_165_9 = arg_162_1.actors_["1012ui_story"]
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1012ui_story == nil then
				arg_162_1.var_.characterEffect1012ui_story = var_165_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_11 = 0.200000002980232

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 and not isNil(var_165_9) then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11

				if arg_162_1.var_.characterEffect1012ui_story and not isNil(var_165_9) then
					local var_165_13 = Mathf.Lerp(0, 0.5, var_165_12)

					arg_162_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1012ui_story.fillRatio = var_165_13
				end
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1012ui_story then
				local var_165_14 = 0.5

				arg_162_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1012ui_story.fillRatio = var_165_14
			end

			local var_165_15 = 0
			local var_165_16 = 0.925

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

				local var_165_17 = arg_162_1:GetWordFromCfg(324031040)
				local var_165_18 = arg_162_1:FormatText(var_165_17.content)

				arg_162_1.text_.text = var_165_18

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_19 = 37
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
				actorName = "1012ui_story",
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
	Play324031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324031041
		arg_166_1.duration_ = 3.57

		local var_166_0 = {
			zh = 2.633,
			ja = 3.566
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
				arg_166_0:Play324031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1071ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1071ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, -1.05, -6.2)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1071ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["1071ui_story"]
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect1071ui_story == nil then
				arg_166_1.var_.characterEffect1071ui_story = var_169_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_11 = 0.200000002980232

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 and not isNil(var_169_9) then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11

				if arg_166_1.var_.characterEffect1071ui_story and not isNil(var_169_9) then
					arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 and not isNil(var_169_9) and arg_166_1.var_.characterEffect1071ui_story then
				arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_169_13 = 0

			if var_169_13 < arg_166_1.time_ and arg_166_1.time_ <= var_169_13 + arg_169_0 then
				arg_166_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_169_14 = 0
			local var_169_15 = 0.3

			if var_169_14 < arg_166_1.time_ and arg_166_1.time_ <= var_169_14 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_16 = arg_166_1:FormatText(StoryNameCfg[384].name)

				arg_166_1.leftNameTxt_.text = var_169_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_17 = arg_166_1:GetWordFromCfg(324031041)
				local var_169_18 = arg_166_1:FormatText(var_169_17.content)

				arg_166_1.text_.text = var_169_18

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_19 = 12
				local var_169_20 = utf8.len(var_169_18)
				local var_169_21 = var_169_19 <= 0 and var_169_15 or var_169_15 * (var_169_20 / var_169_19)

				if var_169_21 > 0 and var_169_15 < var_169_21 then
					arg_166_1.talkMaxDuration = var_169_21

					if var_169_21 + var_169_14 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_21 + var_169_14
					end
				end

				arg_166_1.text_.text = var_169_18
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031041", "story_v_out_324031.awb") ~= 0 then
					local var_169_22 = manager.audio:GetVoiceLength("story_v_out_324031", "324031041", "story_v_out_324031.awb") / 1000

					if var_169_22 + var_169_14 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_14
					end

					if var_169_17.prefab_name ~= "" and arg_166_1.actors_[var_169_17.prefab_name] ~= nil then
						local var_169_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_17.prefab_name].transform, "story_v_out_324031", "324031041", "story_v_out_324031.awb")

						arg_166_1:RecordAudio("324031041", var_169_23)
						arg_166_1:RecordAudio("324031041", var_169_23)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_324031", "324031041", "story_v_out_324031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_324031", "324031041", "story_v_out_324031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_24 = math.max(var_169_15, arg_166_1.talkMaxDuration)

			if var_169_14 <= arg_166_1.time_ and arg_166_1.time_ < var_169_14 + var_169_24 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_14) / var_169_24

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_14 + var_169_24 and arg_166_1.time_ < var_169_14 + var_169_24 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play324031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 324031042
		arg_170_1.duration_ = 13.9

		local var_170_0 = {
			zh = 10.066,
			ja = 13.9
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
				arg_170_0:Play324031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.425

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[384].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(324031042)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 57
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031042", "story_v_out_324031.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031042", "story_v_out_324031.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_324031", "324031042", "story_v_out_324031.awb")

						arg_170_1:RecordAudio("324031042", var_173_9)
						arg_170_1:RecordAudio("324031042", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_324031", "324031042", "story_v_out_324031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_324031", "324031042", "story_v_out_324031.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play324031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 324031043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play324031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1071ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1071ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1071ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["1071ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1071ui_story == nil then
				arg_174_1.var_.characterEffect1071ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect1071ui_story and not isNil(var_177_9) then
					local var_177_13 = Mathf.Lerp(0, 0.5, var_177_12)

					arg_174_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1071ui_story.fillRatio = var_177_13
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1071ui_story then
				local var_177_14 = 0.5

				arg_174_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1071ui_story.fillRatio = var_177_14
			end

			local var_177_15 = 0
			local var_177_16 = 0.85

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_17 = arg_174_1:GetWordFromCfg(324031043)
				local var_177_18 = arg_174_1:FormatText(var_177_17.content)

				arg_174_1.text_.text = var_177_18

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_19 = 34
				local var_177_20 = utf8.len(var_177_18)
				local var_177_21 = var_177_19 <= 0 and var_177_16 or var_177_16 * (var_177_20 / var_177_19)

				if var_177_21 > 0 and var_177_16 < var_177_21 then
					arg_174_1.talkMaxDuration = var_177_21

					if var_177_21 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_21 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_18
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_22 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_22

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_22 and arg_174_1.time_ < var_177_15 + var_177_22 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 324031044
		arg_178_1.duration_ = 10.47

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play324031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1071ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1071ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1.05, -6.2)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1071ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1071ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1071ui_story == nil then
				arg_178_1.var_.characterEffect1071ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1071ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1071ui_story then
				arg_178_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_181_14 = 0
			local var_181_15 = 1.275

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_16 = arg_178_1:FormatText(StoryNameCfg[384].name)

				arg_178_1.leftNameTxt_.text = var_181_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_17 = arg_178_1:GetWordFromCfg(324031044)
				local var_181_18 = arg_178_1:FormatText(var_181_17.content)

				arg_178_1.text_.text = var_181_18

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_19 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031044", "story_v_out_324031.awb") ~= 0 then
					local var_181_22 = manager.audio:GetVoiceLength("story_v_out_324031", "324031044", "story_v_out_324031.awb") / 1000

					if var_181_22 + var_181_14 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_14
					end

					if var_181_17.prefab_name ~= "" and arg_178_1.actors_[var_181_17.prefab_name] ~= nil then
						local var_181_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_17.prefab_name].transform, "story_v_out_324031", "324031044", "story_v_out_324031.awb")

						arg_178_1:RecordAudio("324031044", var_181_23)
						arg_178_1:RecordAudio("324031044", var_181_23)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_324031", "324031044", "story_v_out_324031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_324031", "324031044", "story_v_out_324031.awb")
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
				actorName = "1071ui_story",
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
	Play324031045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 324031045
		arg_182_1.duration_ = 14.27

		local var_182_0 = {
			zh = 11.066,
			ja = 14.266
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
				arg_182_0:Play324031046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 1.075

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[384].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(324031045)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 43
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031045", "story_v_out_324031.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031045", "story_v_out_324031.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_324031", "324031045", "story_v_out_324031.awb")

						arg_182_1:RecordAudio("324031045", var_185_9)
						arg_182_1:RecordAudio("324031045", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_324031", "324031045", "story_v_out_324031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_324031", "324031045", "story_v_out_324031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play324031046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 324031046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play324031047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1071ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1071ui_story == nil then
				arg_186_1.var_.characterEffect1071ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1071ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1071ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1071ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1071ui_story.fillRatio = var_189_5
			end

			local var_189_6 = 0
			local var_189_7 = 0.25

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

				local var_189_9 = arg_186_1:GetWordFromCfg(324031046)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 10
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
	Play324031047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 324031047
		arg_190_1.duration_ = 10.2

		local var_190_0 = {
			zh = 8.3,
			ja = 10.2
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
				arg_190_0:Play324031048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1071ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1071ui_story then
				arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_193_4 = 0

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_193_5 = 0
			local var_193_6 = 0.9

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_7 = arg_190_1:FormatText(StoryNameCfg[384].name)

				arg_190_1.leftNameTxt_.text = var_193_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_8 = arg_190_1:GetWordFromCfg(324031047)
				local var_193_9 = arg_190_1:FormatText(var_193_8.content)

				arg_190_1.text_.text = var_193_9

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_10 = 36
				local var_193_11 = utf8.len(var_193_9)
				local var_193_12 = var_193_10 <= 0 and var_193_6 or var_193_6 * (var_193_11 / var_193_10)

				if var_193_12 > 0 and var_193_6 < var_193_12 then
					arg_190_1.talkMaxDuration = var_193_12

					if var_193_12 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_5
					end
				end

				arg_190_1.text_.text = var_193_9
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031047", "story_v_out_324031.awb") ~= 0 then
					local var_193_13 = manager.audio:GetVoiceLength("story_v_out_324031", "324031047", "story_v_out_324031.awb") / 1000

					if var_193_13 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_5
					end

					if var_193_8.prefab_name ~= "" and arg_190_1.actors_[var_193_8.prefab_name] ~= nil then
						local var_193_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_8.prefab_name].transform, "story_v_out_324031", "324031047", "story_v_out_324031.awb")

						arg_190_1:RecordAudio("324031047", var_193_14)
						arg_190_1:RecordAudio("324031047", var_193_14)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_324031", "324031047", "story_v_out_324031.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_324031", "324031047", "story_v_out_324031.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_15 = math.max(var_193_6, arg_190_1.talkMaxDuration)

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_15 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_5) / var_193_15

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_5 + var_193_15 and arg_190_1.time_ < var_193_5 + var_193_15 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play324031048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 324031048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play324031049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1071ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1071ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, 100, 0)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1071ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, 100, 0)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1071ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1071ui_story == nil then
				arg_194_1.var_.characterEffect1071ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect1071ui_story and not isNil(var_197_9) then
					local var_197_13 = Mathf.Lerp(0, 0.5, var_197_12)

					arg_194_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1071ui_story.fillRatio = var_197_13
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1071ui_story then
				local var_197_14 = 0.5

				arg_194_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1071ui_story.fillRatio = var_197_14
			end

			local var_197_15 = 0
			local var_197_16 = 1.475

			if var_197_15 < arg_194_1.time_ and arg_194_1.time_ <= var_197_15 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_17 = arg_194_1:GetWordFromCfg(324031048)
				local var_197_18 = arg_194_1:FormatText(var_197_17.content)

				arg_194_1.text_.text = var_197_18

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_19 = 59
				local var_197_20 = utf8.len(var_197_18)
				local var_197_21 = var_197_19 <= 0 and var_197_16 or var_197_16 * (var_197_20 / var_197_19)

				if var_197_21 > 0 and var_197_16 < var_197_21 then
					arg_194_1.talkMaxDuration = var_197_21

					if var_197_21 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_21 + var_197_15
					end
				end

				arg_194_1.text_.text = var_197_18
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_22 = math.max(var_197_16, arg_194_1.talkMaxDuration)

			if var_197_15 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_22 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_22

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_22 and arg_194_1.time_ < var_197_15 + var_197_22 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324031049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 324031049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play324031050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 1.35

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(324031049)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 54
				local var_201_5 = utf8.len(var_201_3)
				local var_201_6 = var_201_4 <= 0 and var_201_1 or var_201_1 * (var_201_5 / var_201_4)

				if var_201_6 > 0 and var_201_1 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_7 and arg_198_1.time_ < var_201_0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play324031050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 324031050
		arg_202_1.duration_ = 6.97

		local var_202_0 = {
			zh = 5.7,
			ja = 6.966
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
				arg_202_0:Play324031051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1071ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1071ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, -1.05, -6.2)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1071ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1071ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1071ui_story == nil then
				arg_202_1.var_.characterEffect1071ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1071ui_story and not isNil(var_205_9) then
					arg_202_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1071ui_story then
				arg_202_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_205_13 = 0

			if var_205_13 < arg_202_1.time_ and arg_202_1.time_ <= var_205_13 + arg_205_0 then
				arg_202_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_205_14 = 0
			local var_205_15 = 0.675

			if var_205_14 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_16 = arg_202_1:FormatText(StoryNameCfg[384].name)

				arg_202_1.leftNameTxt_.text = var_205_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_17 = arg_202_1:GetWordFromCfg(324031050)
				local var_205_18 = arg_202_1:FormatText(var_205_17.content)

				arg_202_1.text_.text = var_205_18

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031050", "story_v_out_324031.awb") ~= 0 then
					local var_205_22 = manager.audio:GetVoiceLength("story_v_out_324031", "324031050", "story_v_out_324031.awb") / 1000

					if var_205_22 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_14
					end

					if var_205_17.prefab_name ~= "" and arg_202_1.actors_[var_205_17.prefab_name] ~= nil then
						local var_205_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_17.prefab_name].transform, "story_v_out_324031", "324031050", "story_v_out_324031.awb")

						arg_202_1:RecordAudio("324031050", var_205_23)
						arg_202_1:RecordAudio("324031050", var_205_23)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_324031", "324031050", "story_v_out_324031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_324031", "324031050", "story_v_out_324031.awb")
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
				actorName = "1071ui_story",
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
	Play324031051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 324031051
		arg_206_1.duration_ = 12.4

		local var_206_0 = {
			zh = 10.133,
			ja = 12.4
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
				arg_206_0:Play324031052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 1.125

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[384].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:GetWordFromCfg(324031051)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031051", "story_v_out_324031.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031051", "story_v_out_324031.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_324031", "324031051", "story_v_out_324031.awb")

						arg_206_1:RecordAudio("324031051", var_209_9)
						arg_206_1:RecordAudio("324031051", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_324031", "324031051", "story_v_out_324031.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_324031", "324031051", "story_v_out_324031.awb")
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
	Play324031052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 324031052
		arg_210_1.duration_ = 14.53

		local var_210_0 = {
			zh = 10.566,
			ja = 14.533
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
				arg_210_0:Play324031053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1071ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1071ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, 100, 0)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1071ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, 100, 0)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = "1069ui_story"

			if arg_210_1.actors_[var_213_9] == nil then
				local var_213_10 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_213_10) then
					local var_213_11 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_210_1.stage_.transform)

					var_213_11.name = var_213_9
					var_213_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_210_1.actors_[var_213_9] = var_213_11

					local var_213_12 = var_213_11:GetComponentInChildren(typeof(CharacterEffect))

					var_213_12.enabled = true

					local var_213_13 = GameObjectTools.GetOrAddComponent(var_213_11, typeof(DynamicBoneHelper))

					if var_213_13 then
						var_213_13:EnableDynamicBone(false)
					end

					arg_210_1:ShowWeapon(var_213_12.transform, false)

					arg_210_1.var_[var_213_9 .. "Animator"] = var_213_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_210_1.var_[var_213_9 .. "Animator"].applyRootMotion = true
					arg_210_1.var_[var_213_9 .. "LipSync"] = var_213_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_213_14 = arg_210_1.actors_["1069ui_story"].transform
			local var_213_15 = 0

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.var_.moveOldPos1069ui_story = var_213_14.localPosition
			end

			local var_213_16 = 0.001

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_16 then
				local var_213_17 = (arg_210_1.time_ - var_213_15) / var_213_16
				local var_213_18 = Vector3.New(0, -1, -6)

				var_213_14.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1069ui_story, var_213_18, var_213_17)

				local var_213_19 = manager.ui.mainCamera.transform.position - var_213_14.position

				var_213_14.forward = Vector3.New(var_213_19.x, var_213_19.y, var_213_19.z)

				local var_213_20 = var_213_14.localEulerAngles

				var_213_20.z = 0
				var_213_20.x = 0
				var_213_14.localEulerAngles = var_213_20
			end

			if arg_210_1.time_ >= var_213_15 + var_213_16 and arg_210_1.time_ < var_213_15 + var_213_16 + arg_213_0 then
				var_213_14.localPosition = Vector3.New(0, -1, -6)

				local var_213_21 = manager.ui.mainCamera.transform.position - var_213_14.position

				var_213_14.forward = Vector3.New(var_213_21.x, var_213_21.y, var_213_21.z)

				local var_213_22 = var_213_14.localEulerAngles

				var_213_22.z = 0
				var_213_22.x = 0
				var_213_14.localEulerAngles = var_213_22
			end

			local var_213_23 = arg_210_1.actors_["1069ui_story"]
			local var_213_24 = 0

			if var_213_24 < arg_210_1.time_ and arg_210_1.time_ <= var_213_24 + arg_213_0 and not isNil(var_213_23) and arg_210_1.var_.characterEffect1069ui_story == nil then
				arg_210_1.var_.characterEffect1069ui_story = var_213_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_25 = 0.200000002980232

			if var_213_24 <= arg_210_1.time_ and arg_210_1.time_ < var_213_24 + var_213_25 and not isNil(var_213_23) then
				local var_213_26 = (arg_210_1.time_ - var_213_24) / var_213_25

				if arg_210_1.var_.characterEffect1069ui_story and not isNil(var_213_23) then
					arg_210_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_24 + var_213_25 and arg_210_1.time_ < var_213_24 + var_213_25 + arg_213_0 and not isNil(var_213_23) and arg_210_1.var_.characterEffect1069ui_story then
				arg_210_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_213_27 = arg_210_1.actors_["1071ui_story"]
			local var_213_28 = 0

			if var_213_28 < arg_210_1.time_ and arg_210_1.time_ <= var_213_28 + arg_213_0 and not isNil(var_213_27) and arg_210_1.var_.characterEffect1071ui_story == nil then
				arg_210_1.var_.characterEffect1071ui_story = var_213_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_29 = 0.200000002980232

			if var_213_28 <= arg_210_1.time_ and arg_210_1.time_ < var_213_28 + var_213_29 and not isNil(var_213_27) then
				local var_213_30 = (arg_210_1.time_ - var_213_28) / var_213_29

				if arg_210_1.var_.characterEffect1071ui_story and not isNil(var_213_27) then
					local var_213_31 = Mathf.Lerp(0, 0.5, var_213_30)

					arg_210_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1071ui_story.fillRatio = var_213_31
				end
			end

			if arg_210_1.time_ >= var_213_28 + var_213_29 and arg_210_1.time_ < var_213_28 + var_213_29 + arg_213_0 and not isNil(var_213_27) and arg_210_1.var_.characterEffect1071ui_story then
				local var_213_32 = 0.5

				arg_210_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1071ui_story.fillRatio = var_213_32
			end

			local var_213_33 = 0

			if var_213_33 < arg_210_1.time_ and arg_210_1.time_ <= var_213_33 + arg_213_0 then
				arg_210_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action6_1")
			end

			local var_213_34 = 0

			if var_213_34 < arg_210_1.time_ and arg_210_1.time_ <= var_213_34 + arg_213_0 then
				arg_210_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_35 = 0
			local var_213_36 = 1.25

			if var_213_35 < arg_210_1.time_ and arg_210_1.time_ <= var_213_35 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_37 = arg_210_1:FormatText(StoryNameCfg[378].name)

				arg_210_1.leftNameTxt_.text = var_213_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_38 = arg_210_1:GetWordFromCfg(324031052)
				local var_213_39 = arg_210_1:FormatText(var_213_38.content)

				arg_210_1.text_.text = var_213_39

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_40 = 50
				local var_213_41 = utf8.len(var_213_39)
				local var_213_42 = var_213_40 <= 0 and var_213_36 or var_213_36 * (var_213_41 / var_213_40)

				if var_213_42 > 0 and var_213_36 < var_213_42 then
					arg_210_1.talkMaxDuration = var_213_42

					if var_213_42 + var_213_35 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_42 + var_213_35
					end
				end

				arg_210_1.text_.text = var_213_39
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031052", "story_v_out_324031.awb") ~= 0 then
					local var_213_43 = manager.audio:GetVoiceLength("story_v_out_324031", "324031052", "story_v_out_324031.awb") / 1000

					if var_213_43 + var_213_35 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_43 + var_213_35
					end

					if var_213_38.prefab_name ~= "" and arg_210_1.actors_[var_213_38.prefab_name] ~= nil then
						local var_213_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_38.prefab_name].transform, "story_v_out_324031", "324031052", "story_v_out_324031.awb")

						arg_210_1:RecordAudio("324031052", var_213_44)
						arg_210_1:RecordAudio("324031052", var_213_44)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_324031", "324031052", "story_v_out_324031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_324031", "324031052", "story_v_out_324031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_45 = math.max(var_213_36, arg_210_1.talkMaxDuration)

			if var_213_35 <= arg_210_1.time_ and arg_210_1.time_ < var_213_35 + var_213_45 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_35) / var_213_45

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_35 + var_213_45 and arg_210_1.time_ < var_213_35 + var_213_45 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
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
	Play324031053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 324031053
		arg_214_1.duration_ = 8.3

		local var_214_0 = {
			zh = 8.3,
			ja = 7.1
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
				arg_214_0:Play324031054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 1.05

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[378].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(324031053)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 42
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031053", "story_v_out_324031.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031053", "story_v_out_324031.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_324031", "324031053", "story_v_out_324031.awb")

						arg_214_1:RecordAudio("324031053", var_217_9)
						arg_214_1:RecordAudio("324031053", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_324031", "324031053", "story_v_out_324031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_324031", "324031053", "story_v_out_324031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play324031054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 324031054
		arg_218_1.duration_ = 16.9

		local var_218_0 = {
			zh = 15.1,
			ja = 16.9
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
				arg_218_0:Play324031055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1071ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1071ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1071ui_story, var_221_4, var_221_3)

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

			local var_221_9 = arg_218_1.actors_["1069ui_story"].transform
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1.var_.moveOldPos1069ui_story = var_221_9.localPosition
			end

			local var_221_11 = 0.001

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11
				local var_221_13 = Vector3.New(0, 100, 0)

				var_221_9.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1069ui_story, var_221_13, var_221_12)

				local var_221_14 = manager.ui.mainCamera.transform.position - var_221_9.position

				var_221_9.forward = Vector3.New(var_221_14.x, var_221_14.y, var_221_14.z)

				local var_221_15 = var_221_9.localEulerAngles

				var_221_15.z = 0
				var_221_15.x = 0
				var_221_9.localEulerAngles = var_221_15
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 then
				var_221_9.localPosition = Vector3.New(0, 100, 0)

				local var_221_16 = manager.ui.mainCamera.transform.position - var_221_9.position

				var_221_9.forward = Vector3.New(var_221_16.x, var_221_16.y, var_221_16.z)

				local var_221_17 = var_221_9.localEulerAngles

				var_221_17.z = 0
				var_221_17.x = 0
				var_221_9.localEulerAngles = var_221_17
			end

			local var_221_18 = arg_218_1.actors_["1069ui_story"]
			local var_221_19 = 0

			if var_221_19 < arg_218_1.time_ and arg_218_1.time_ <= var_221_19 + arg_221_0 and not isNil(var_221_18) and arg_218_1.var_.characterEffect1069ui_story == nil then
				arg_218_1.var_.characterEffect1069ui_story = var_221_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_20 = 0.200000002980232

			if var_221_19 <= arg_218_1.time_ and arg_218_1.time_ < var_221_19 + var_221_20 and not isNil(var_221_18) then
				local var_221_21 = (arg_218_1.time_ - var_221_19) / var_221_20

				if arg_218_1.var_.characterEffect1069ui_story and not isNil(var_221_18) then
					local var_221_22 = Mathf.Lerp(0, 0.5, var_221_21)

					arg_218_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1069ui_story.fillRatio = var_221_22
				end
			end

			if arg_218_1.time_ >= var_221_19 + var_221_20 and arg_218_1.time_ < var_221_19 + var_221_20 + arg_221_0 and not isNil(var_221_18) and arg_218_1.var_.characterEffect1069ui_story then
				local var_221_23 = 0.5

				arg_218_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1069ui_story.fillRatio = var_221_23
			end

			local var_221_24 = 0
			local var_221_25 = 1.3

			if var_221_24 < arg_218_1.time_ and arg_218_1.time_ <= var_221_24 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_26 = arg_218_1:FormatText(StoryNameCfg[1499].name)

				arg_218_1.leftNameTxt_.text = var_221_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_27 = arg_218_1:GetWordFromCfg(324031054)
				local var_221_28 = arg_218_1:FormatText(var_221_27.content)

				arg_218_1.text_.text = var_221_28

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_29 = 52
				local var_221_30 = utf8.len(var_221_28)
				local var_221_31 = var_221_29 <= 0 and var_221_25 or var_221_25 * (var_221_30 / var_221_29)

				if var_221_31 > 0 and var_221_25 < var_221_31 then
					arg_218_1.talkMaxDuration = var_221_31

					if var_221_31 + var_221_24 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_31 + var_221_24
					end
				end

				arg_218_1.text_.text = var_221_28
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031054", "story_v_out_324031.awb") ~= 0 then
					local var_221_32 = manager.audio:GetVoiceLength("story_v_out_324031", "324031054", "story_v_out_324031.awb") / 1000

					if var_221_32 + var_221_24 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_32 + var_221_24
					end

					if var_221_27.prefab_name ~= "" and arg_218_1.actors_[var_221_27.prefab_name] ~= nil then
						local var_221_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_27.prefab_name].transform, "story_v_out_324031", "324031054", "story_v_out_324031.awb")

						arg_218_1:RecordAudio("324031054", var_221_33)
						arg_218_1:RecordAudio("324031054", var_221_33)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_324031", "324031054", "story_v_out_324031.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_324031", "324031054", "story_v_out_324031.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_34 = math.max(var_221_25, arg_218_1.talkMaxDuration)

			if var_221_24 <= arg_218_1.time_ and arg_218_1.time_ < var_221_24 + var_221_34 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_24) / var_221_34

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_24 + var_221_34 and arg_218_1.time_ < var_221_24 + var_221_34 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
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
	Play324031055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 324031055
		arg_222_1.duration_ = 10.4

		local var_222_0 = {
			zh = 9.1,
			ja = 10.4
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
				arg_222_0:Play324031056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1.025

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1499].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(324031055)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031055", "story_v_out_324031.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031055", "story_v_out_324031.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_324031", "324031055", "story_v_out_324031.awb")

						arg_222_1:RecordAudio("324031055", var_225_9)
						arg_222_1:RecordAudio("324031055", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_324031", "324031055", "story_v_out_324031.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_324031", "324031055", "story_v_out_324031.awb")
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
	Play324031056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 324031056
		arg_226_1.duration_ = 8.57

		local var_226_0 = {
			zh = 8,
			ja = 8.566
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
				arg_226_0:Play324031057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.725

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[1500].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowgrandpaa")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(324031056)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031056", "story_v_out_324031.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031056", "story_v_out_324031.awb") / 1000

					if var_229_8 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_0
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_324031", "324031056", "story_v_out_324031.awb")

						arg_226_1:RecordAudio("324031056", var_229_9)
						arg_226_1:RecordAudio("324031056", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_324031", "324031056", "story_v_out_324031.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_324031", "324031056", "story_v_out_324031.awb")
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
	Play324031057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 324031057
		arg_230_1.duration_ = 14.57

		local var_230_0 = {
			zh = 8.233,
			ja = 14.566
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
				arg_230_0:Play324031058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.75

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[1500].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowgrandpaa")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:GetWordFromCfg(324031057)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031057", "story_v_out_324031.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031057", "story_v_out_324031.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_324031", "324031057", "story_v_out_324031.awb")

						arg_230_1:RecordAudio("324031057", var_233_9)
						arg_230_1:RecordAudio("324031057", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_324031", "324031057", "story_v_out_324031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_324031", "324031057", "story_v_out_324031.awb")
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
	Play324031058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 324031058
		arg_234_1.duration_ = 10.6

		local var_234_0 = {
			zh = 7.533,
			ja = 10.6
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
				arg_234_0:Play324031059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = "1075ui_story"

			if arg_234_1.actors_[var_237_0] == nil then
				local var_237_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_237_1) then
					local var_237_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_234_1.stage_.transform)

					var_237_2.name = var_237_0
					var_237_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_234_1.actors_[var_237_0] = var_237_2

					local var_237_3 = var_237_2:GetComponentInChildren(typeof(CharacterEffect))

					var_237_3.enabled = true

					local var_237_4 = GameObjectTools.GetOrAddComponent(var_237_2, typeof(DynamicBoneHelper))

					if var_237_4 then
						var_237_4:EnableDynamicBone(false)
					end

					arg_234_1:ShowWeapon(var_237_3.transform, false)

					arg_234_1.var_[var_237_0 .. "Animator"] = var_237_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_234_1.var_[var_237_0 .. "Animator"].applyRootMotion = true
					arg_234_1.var_[var_237_0 .. "LipSync"] = var_237_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_237_5 = arg_234_1.actors_["1075ui_story"].transform
			local var_237_6 = 0

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.var_.moveOldPos1075ui_story = var_237_5.localPosition
			end

			local var_237_7 = 0.001

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_7 then
				local var_237_8 = (arg_234_1.time_ - var_237_6) / var_237_7
				local var_237_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_237_5.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1075ui_story, var_237_9, var_237_8)

				local var_237_10 = manager.ui.mainCamera.transform.position - var_237_5.position

				var_237_5.forward = Vector3.New(var_237_10.x, var_237_10.y, var_237_10.z)

				local var_237_11 = var_237_5.localEulerAngles

				var_237_11.z = 0
				var_237_11.x = 0
				var_237_5.localEulerAngles = var_237_11
			end

			if arg_234_1.time_ >= var_237_6 + var_237_7 and arg_234_1.time_ < var_237_6 + var_237_7 + arg_237_0 then
				var_237_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_237_12 = manager.ui.mainCamera.transform.position - var_237_5.position

				var_237_5.forward = Vector3.New(var_237_12.x, var_237_12.y, var_237_12.z)

				local var_237_13 = var_237_5.localEulerAngles

				var_237_13.z = 0
				var_237_13.x = 0
				var_237_5.localEulerAngles = var_237_13
			end

			local var_237_14 = arg_234_1.actors_["1075ui_story"]
			local var_237_15 = 0

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 and not isNil(var_237_14) and arg_234_1.var_.characterEffect1075ui_story == nil then
				arg_234_1.var_.characterEffect1075ui_story = var_237_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_16 = 0.200000002980232

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_16 and not isNil(var_237_14) then
				local var_237_17 = (arg_234_1.time_ - var_237_15) / var_237_16

				if arg_234_1.var_.characterEffect1075ui_story and not isNil(var_237_14) then
					arg_234_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_15 + var_237_16 and arg_234_1.time_ < var_237_15 + var_237_16 + arg_237_0 and not isNil(var_237_14) and arg_234_1.var_.characterEffect1075ui_story then
				arg_234_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_237_18 = 0

			if var_237_18 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_237_19 = 0

			if var_237_19 < arg_234_1.time_ and arg_234_1.time_ <= var_237_19 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_20 = 0
			local var_237_21 = 0.625

			if var_237_20 < arg_234_1.time_ and arg_234_1.time_ <= var_237_20 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_22 = arg_234_1:FormatText(StoryNameCfg[381].name)

				arg_234_1.leftNameTxt_.text = var_237_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_23 = arg_234_1:GetWordFromCfg(324031058)
				local var_237_24 = arg_234_1:FormatText(var_237_23.content)

				arg_234_1.text_.text = var_237_24

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_25 = 25
				local var_237_26 = utf8.len(var_237_24)
				local var_237_27 = var_237_25 <= 0 and var_237_21 or var_237_21 * (var_237_26 / var_237_25)

				if var_237_27 > 0 and var_237_21 < var_237_27 then
					arg_234_1.talkMaxDuration = var_237_27

					if var_237_27 + var_237_20 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_27 + var_237_20
					end
				end

				arg_234_1.text_.text = var_237_24
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031058", "story_v_out_324031.awb") ~= 0 then
					local var_237_28 = manager.audio:GetVoiceLength("story_v_out_324031", "324031058", "story_v_out_324031.awb") / 1000

					if var_237_28 + var_237_20 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_28 + var_237_20
					end

					if var_237_23.prefab_name ~= "" and arg_234_1.actors_[var_237_23.prefab_name] ~= nil then
						local var_237_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_23.prefab_name].transform, "story_v_out_324031", "324031058", "story_v_out_324031.awb")

						arg_234_1:RecordAudio("324031058", var_237_29)
						arg_234_1:RecordAudio("324031058", var_237_29)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_324031", "324031058", "story_v_out_324031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_324031", "324031058", "story_v_out_324031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_30 = math.max(var_237_21, arg_234_1.talkMaxDuration)

			if var_237_20 <= arg_234_1.time_ and arg_234_1.time_ < var_237_20 + var_237_30 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_20) / var_237_30

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_20 + var_237_30 and arg_234_1.time_ < var_237_20 + var_237_30 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play324031059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 324031059
		arg_238_1.duration_ = 4.7

		local var_238_0 = {
			zh = 4.7,
			ja = 3.4
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
				arg_238_0:Play324031060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10039ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos10039ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0.7, -0.8, -6.2)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10039ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["10039ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect10039ui_story == nil then
				arg_238_1.var_.characterEffect10039ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect10039ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect10039ui_story then
				arg_238_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_241_13 = arg_238_1.actors_["1075ui_story"]
			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 and not isNil(var_241_13) and arg_238_1.var_.characterEffect1075ui_story == nil then
				arg_238_1.var_.characterEffect1075ui_story = var_241_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_15 = 0.200000002980232

			if var_241_14 <= arg_238_1.time_ and arg_238_1.time_ < var_241_14 + var_241_15 and not isNil(var_241_13) then
				local var_241_16 = (arg_238_1.time_ - var_241_14) / var_241_15

				if arg_238_1.var_.characterEffect1075ui_story and not isNil(var_241_13) then
					local var_241_17 = Mathf.Lerp(0, 0.5, var_241_16)

					arg_238_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1075ui_story.fillRatio = var_241_17
				end
			end

			if arg_238_1.time_ >= var_241_14 + var_241_15 and arg_238_1.time_ < var_241_14 + var_241_15 + arg_241_0 and not isNil(var_241_13) and arg_238_1.var_.characterEffect1075ui_story then
				local var_241_18 = 0.5

				arg_238_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1075ui_story.fillRatio = var_241_18
			end

			local var_241_19 = 0

			if var_241_19 < arg_238_1.time_ and arg_238_1.time_ <= var_241_19 + arg_241_0 then
				arg_238_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_241_20 = 0

			if var_241_20 < arg_238_1.time_ and arg_238_1.time_ <= var_241_20 + arg_241_0 then
				arg_238_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_241_21 = 0
			local var_241_22 = 0.4

			if var_241_21 < arg_238_1.time_ and arg_238_1.time_ <= var_241_21 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_23 = arg_238_1:FormatText(StoryNameCfg[472].name)

				arg_238_1.leftNameTxt_.text = var_241_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_24 = arg_238_1:GetWordFromCfg(324031059)
				local var_241_25 = arg_238_1:FormatText(var_241_24.content)

				arg_238_1.text_.text = var_241_25

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_26 = 16
				local var_241_27 = utf8.len(var_241_25)
				local var_241_28 = var_241_26 <= 0 and var_241_22 or var_241_22 * (var_241_27 / var_241_26)

				if var_241_28 > 0 and var_241_22 < var_241_28 then
					arg_238_1.talkMaxDuration = var_241_28

					if var_241_28 + var_241_21 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_28 + var_241_21
					end
				end

				arg_238_1.text_.text = var_241_25
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031059", "story_v_out_324031.awb") ~= 0 then
					local var_241_29 = manager.audio:GetVoiceLength("story_v_out_324031", "324031059", "story_v_out_324031.awb") / 1000

					if var_241_29 + var_241_21 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_29 + var_241_21
					end

					if var_241_24.prefab_name ~= "" and arg_238_1.actors_[var_241_24.prefab_name] ~= nil then
						local var_241_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_24.prefab_name].transform, "story_v_out_324031", "324031059", "story_v_out_324031.awb")

						arg_238_1:RecordAudio("324031059", var_241_30)
						arg_238_1:RecordAudio("324031059", var_241_30)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_324031", "324031059", "story_v_out_324031.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_324031", "324031059", "story_v_out_324031.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_31 = math.max(var_241_22, arg_238_1.talkMaxDuration)

			if var_241_21 <= arg_238_1.time_ and arg_238_1.time_ < var_241_21 + var_241_31 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_21) / var_241_31

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_21 + var_241_31 and arg_238_1.time_ < var_241_21 + var_241_31 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play324031060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 324031060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play324031061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10039ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10039ui_story == nil then
				arg_242_1.var_.characterEffect10039ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10039ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10039ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10039ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10039ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.725

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[7].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_9 = arg_242_1:GetWordFromCfg(324031060)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 29
				local var_245_12 = utf8.len(var_245_10)
				local var_245_13 = var_245_11 <= 0 and var_245_7 or var_245_7 * (var_245_12 / var_245_11)

				if var_245_13 > 0 and var_245_7 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_10
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_14 and arg_242_1.time_ < var_245_6 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play324031061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 324031061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play324031062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 1.125

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_2

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

				local var_249_3 = arg_246_1:GetWordFromCfg(324031061)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 45
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
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_8 and arg_246_1.time_ < var_249_0 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play324031062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 324031062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play324031063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 1.225

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

				local var_253_3 = arg_250_1:GetWordFromCfg(324031062)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 49
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
	Play324031063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 324031063
		arg_254_1.duration_ = 9.4

		local var_254_0 = {
			zh = 9.4,
			ja = 9.266
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
				arg_254_0:Play324031064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = "1072ui_story"

			if arg_254_1.actors_[var_257_0] == nil then
				local var_257_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_257_1) then
					local var_257_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_254_1.stage_.transform)

					var_257_2.name = var_257_0
					var_257_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_254_1.actors_[var_257_0] = var_257_2

					local var_257_3 = var_257_2:GetComponentInChildren(typeof(CharacterEffect))

					var_257_3.enabled = true

					local var_257_4 = GameObjectTools.GetOrAddComponent(var_257_2, typeof(DynamicBoneHelper))

					if var_257_4 then
						var_257_4:EnableDynamicBone(false)
					end

					arg_254_1:ShowWeapon(var_257_3.transform, false)

					arg_254_1.var_[var_257_0 .. "Animator"] = var_257_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_254_1.var_[var_257_0 .. "Animator"].applyRootMotion = true
					arg_254_1.var_[var_257_0 .. "LipSync"] = var_257_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_257_5 = arg_254_1.actors_["1072ui_story"].transform
			local var_257_6 = 0

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.var_.moveOldPos1072ui_story = var_257_5.localPosition
			end

			local var_257_7 = 0.001

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_7 then
				local var_257_8 = (arg_254_1.time_ - var_257_6) / var_257_7
				local var_257_9 = Vector3.New(0, -0.71, -6)

				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1072ui_story, var_257_9, var_257_8)

				local var_257_10 = manager.ui.mainCamera.transform.position - var_257_5.position

				var_257_5.forward = Vector3.New(var_257_10.x, var_257_10.y, var_257_10.z)

				local var_257_11 = var_257_5.localEulerAngles

				var_257_11.z = 0
				var_257_11.x = 0
				var_257_5.localEulerAngles = var_257_11
			end

			if arg_254_1.time_ >= var_257_6 + var_257_7 and arg_254_1.time_ < var_257_6 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_257_12 = manager.ui.mainCamera.transform.position - var_257_5.position

				var_257_5.forward = Vector3.New(var_257_12.x, var_257_12.y, var_257_12.z)

				local var_257_13 = var_257_5.localEulerAngles

				var_257_13.z = 0
				var_257_13.x = 0
				var_257_5.localEulerAngles = var_257_13
			end

			local var_257_14 = arg_254_1.actors_["1072ui_story"]
			local var_257_15 = 0

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 and not isNil(var_257_14) and arg_254_1.var_.characterEffect1072ui_story == nil then
				arg_254_1.var_.characterEffect1072ui_story = var_257_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_16 = 0.200000002980232

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_16 and not isNil(var_257_14) then
				local var_257_17 = (arg_254_1.time_ - var_257_15) / var_257_16

				if arg_254_1.var_.characterEffect1072ui_story and not isNil(var_257_14) then
					arg_254_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_15 + var_257_16 and arg_254_1.time_ < var_257_15 + var_257_16 + arg_257_0 and not isNil(var_257_14) and arg_254_1.var_.characterEffect1072ui_story then
				arg_254_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_257_18 = 0

			if var_257_18 < arg_254_1.time_ and arg_254_1.time_ <= var_257_18 + arg_257_0 then
				arg_254_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_257_19 = 0

			if var_257_19 < arg_254_1.time_ and arg_254_1.time_ <= var_257_19 + arg_257_0 then
				arg_254_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_257_20 = arg_254_1.actors_["1075ui_story"].transform
			local var_257_21 = 0

			if var_257_21 < arg_254_1.time_ and arg_254_1.time_ <= var_257_21 + arg_257_0 then
				arg_254_1.var_.moveOldPos1075ui_story = var_257_20.localPosition
			end

			local var_257_22 = 0.001

			if var_257_21 <= arg_254_1.time_ and arg_254_1.time_ < var_257_21 + var_257_22 then
				local var_257_23 = (arg_254_1.time_ - var_257_21) / var_257_22
				local var_257_24 = Vector3.New(0, 100, 0)

				var_257_20.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1075ui_story, var_257_24, var_257_23)

				local var_257_25 = manager.ui.mainCamera.transform.position - var_257_20.position

				var_257_20.forward = Vector3.New(var_257_25.x, var_257_25.y, var_257_25.z)

				local var_257_26 = var_257_20.localEulerAngles

				var_257_26.z = 0
				var_257_26.x = 0
				var_257_20.localEulerAngles = var_257_26
			end

			if arg_254_1.time_ >= var_257_21 + var_257_22 and arg_254_1.time_ < var_257_21 + var_257_22 + arg_257_0 then
				var_257_20.localPosition = Vector3.New(0, 100, 0)

				local var_257_27 = manager.ui.mainCamera.transform.position - var_257_20.position

				var_257_20.forward = Vector3.New(var_257_27.x, var_257_27.y, var_257_27.z)

				local var_257_28 = var_257_20.localEulerAngles

				var_257_28.z = 0
				var_257_28.x = 0
				var_257_20.localEulerAngles = var_257_28
			end

			local var_257_29 = arg_254_1.actors_["10039ui_story"].transform
			local var_257_30 = 0

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.var_.moveOldPos10039ui_story = var_257_29.localPosition
			end

			local var_257_31 = 0.001

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_31 then
				local var_257_32 = (arg_254_1.time_ - var_257_30) / var_257_31
				local var_257_33 = Vector3.New(0, 100, 0)

				var_257_29.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10039ui_story, var_257_33, var_257_32)

				local var_257_34 = manager.ui.mainCamera.transform.position - var_257_29.position

				var_257_29.forward = Vector3.New(var_257_34.x, var_257_34.y, var_257_34.z)

				local var_257_35 = var_257_29.localEulerAngles

				var_257_35.z = 0
				var_257_35.x = 0
				var_257_29.localEulerAngles = var_257_35
			end

			if arg_254_1.time_ >= var_257_30 + var_257_31 and arg_254_1.time_ < var_257_30 + var_257_31 + arg_257_0 then
				var_257_29.localPosition = Vector3.New(0, 100, 0)

				local var_257_36 = manager.ui.mainCamera.transform.position - var_257_29.position

				var_257_29.forward = Vector3.New(var_257_36.x, var_257_36.y, var_257_36.z)

				local var_257_37 = var_257_29.localEulerAngles

				var_257_37.z = 0
				var_257_37.x = 0
				var_257_29.localEulerAngles = var_257_37
			end

			local var_257_38 = 0
			local var_257_39 = 0.875

			if var_257_38 < arg_254_1.time_ and arg_254_1.time_ <= var_257_38 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_40 = arg_254_1:FormatText(StoryNameCfg[379].name)

				arg_254_1.leftNameTxt_.text = var_257_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_41 = arg_254_1:GetWordFromCfg(324031063)
				local var_257_42 = arg_254_1:FormatText(var_257_41.content)

				arg_254_1.text_.text = var_257_42

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_43 = 35
				local var_257_44 = utf8.len(var_257_42)
				local var_257_45 = var_257_43 <= 0 and var_257_39 or var_257_39 * (var_257_44 / var_257_43)

				if var_257_45 > 0 and var_257_39 < var_257_45 then
					arg_254_1.talkMaxDuration = var_257_45

					if var_257_45 + var_257_38 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_45 + var_257_38
					end
				end

				arg_254_1.text_.text = var_257_42
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031063", "story_v_out_324031.awb") ~= 0 then
					local var_257_46 = manager.audio:GetVoiceLength("story_v_out_324031", "324031063", "story_v_out_324031.awb") / 1000

					if var_257_46 + var_257_38 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_46 + var_257_38
					end

					if var_257_41.prefab_name ~= "" and arg_254_1.actors_[var_257_41.prefab_name] ~= nil then
						local var_257_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_41.prefab_name].transform, "story_v_out_324031", "324031063", "story_v_out_324031.awb")

						arg_254_1:RecordAudio("324031063", var_257_47)
						arg_254_1:RecordAudio("324031063", var_257_47)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_324031", "324031063", "story_v_out_324031.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_324031", "324031063", "story_v_out_324031.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_48 = math.max(var_257_39, arg_254_1.talkMaxDuration)

			if var_257_38 <= arg_254_1.time_ and arg_254_1.time_ < var_257_38 + var_257_48 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_38) / var_257_48

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_38 + var_257_48 and arg_254_1.time_ < var_257_38 + var_257_48 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play324031064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 324031064
		arg_258_1.duration_ = 7.9

		local var_258_0 = {
			zh = 6.466,
			ja = 7.9
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
				arg_258_0:Play324031065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.85

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[379].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(324031064)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031064", "story_v_out_324031.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031064", "story_v_out_324031.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_324031", "324031064", "story_v_out_324031.awb")

						arg_258_1:RecordAudio("324031064", var_261_9)
						arg_258_1:RecordAudio("324031064", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_324031", "324031064", "story_v_out_324031.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_324031", "324031064", "story_v_out_324031.awb")
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
	Play324031065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 324031065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play324031066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1072ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1072ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1072ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1072ui_story"]
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1072ui_story == nil then
				arg_262_1.var_.characterEffect1072ui_story = var_265_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.200000002980232

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 and not isNil(var_265_9) then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11

				if arg_262_1.var_.characterEffect1072ui_story and not isNil(var_265_9) then
					local var_265_13 = Mathf.Lerp(0, 0.5, var_265_12)

					arg_262_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1072ui_story.fillRatio = var_265_13
				end
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1072ui_story then
				local var_265_14 = 0.5

				arg_262_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1072ui_story.fillRatio = var_265_14
			end

			local var_265_15 = 0
			local var_265_16 = 1.05

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_17 = arg_262_1:GetWordFromCfg(324031065)
				local var_265_18 = arg_262_1:FormatText(var_265_17.content)

				arg_262_1.text_.text = var_265_18

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_19 = 42
				local var_265_20 = utf8.len(var_265_18)
				local var_265_21 = var_265_19 <= 0 and var_265_16 or var_265_16 * (var_265_20 / var_265_19)

				if var_265_21 > 0 and var_265_16 < var_265_21 then
					arg_262_1.talkMaxDuration = var_265_21

					if var_265_21 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_21 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_18
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_22 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_22 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_22

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_22 and arg_262_1.time_ < var_265_15 + var_265_22 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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

		arg_262_1:InitPlayNodeList()
	end,
	Play324031066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 324031066
		arg_266_1.duration_ = 11.53

		local var_266_0 = {
			zh = 8.4,
			ja = 11.533
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play324031067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.775

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[1500].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowgrandpaa")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(324031066)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 31
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031066", "story_v_out_324031.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031066", "story_v_out_324031.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_324031", "324031066", "story_v_out_324031.awb")

						arg_266_1:RecordAudio("324031066", var_269_9)
						arg_266_1:RecordAudio("324031066", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_324031", "324031066", "story_v_out_324031.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_324031", "324031066", "story_v_out_324031.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play324031067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 324031067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play324031068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.15

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(324031067)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 6
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play324031068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 324031068
		arg_274_1.duration_ = 9.43

		local var_274_0 = {
			zh = 9.433,
			ja = 9.066
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
				arg_274_0:Play324031069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10039ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos10039ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -0.8, -6.2)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10039ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["10039ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10039ui_story == nil then
				arg_274_1.var_.characterEffect10039ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect10039ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10039ui_story then
				arg_274_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_277_13 = 0
			local var_277_14 = 0.85

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_15 = arg_274_1:FormatText(StoryNameCfg[472].name)

				arg_274_1.leftNameTxt_.text = var_277_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_16 = arg_274_1:GetWordFromCfg(324031068)
				local var_277_17 = arg_274_1:FormatText(var_277_16.content)

				arg_274_1.text_.text = var_277_17

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_18 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031068", "story_v_out_324031.awb") ~= 0 then
					local var_277_21 = manager.audio:GetVoiceLength("story_v_out_324031", "324031068", "story_v_out_324031.awb") / 1000

					if var_277_21 + var_277_13 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_21 + var_277_13
					end

					if var_277_16.prefab_name ~= "" and arg_274_1.actors_[var_277_16.prefab_name] ~= nil then
						local var_277_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_16.prefab_name].transform, "story_v_out_324031", "324031068", "story_v_out_324031.awb")

						arg_274_1:RecordAudio("324031068", var_277_22)
						arg_274_1:RecordAudio("324031068", var_277_22)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_324031", "324031068", "story_v_out_324031.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_324031", "324031068", "story_v_out_324031.awb")
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
				actorName = "10039ui_story",
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
	Play324031069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 324031069
		arg_278_1.duration_ = 9.13

		local var_278_0 = {
			zh = 7.3,
			ja = 9.133
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play324031070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_281_1 = 0
			local var_281_2 = 0.85

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_3 = arg_278_1:FormatText(StoryNameCfg[472].name)

				arg_278_1.leftNameTxt_.text = var_281_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_4 = arg_278_1:GetWordFromCfg(324031069)
				local var_281_5 = arg_278_1:FormatText(var_281_4.content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_6 = 34
				local var_281_7 = utf8.len(var_281_5)
				local var_281_8 = var_281_6 <= 0 and var_281_2 or var_281_2 * (var_281_7 / var_281_6)

				if var_281_8 > 0 and var_281_2 < var_281_8 then
					arg_278_1.talkMaxDuration = var_281_8

					if var_281_8 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031069", "story_v_out_324031.awb") ~= 0 then
					local var_281_9 = manager.audio:GetVoiceLength("story_v_out_324031", "324031069", "story_v_out_324031.awb") / 1000

					if var_281_9 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_1
					end

					if var_281_4.prefab_name ~= "" and arg_278_1.actors_[var_281_4.prefab_name] ~= nil then
						local var_281_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_4.prefab_name].transform, "story_v_out_324031", "324031069", "story_v_out_324031.awb")

						arg_278_1:RecordAudio("324031069", var_281_10)
						arg_278_1:RecordAudio("324031069", var_281_10)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_324031", "324031069", "story_v_out_324031.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_324031", "324031069", "story_v_out_324031.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_11 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_11 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_11

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_11 and arg_278_1.time_ < var_281_1 + var_281_11 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play324031070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 324031070
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play324031071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10039ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10039ui_story == nil then
				arg_282_1.var_.characterEffect10039ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect10039ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10039ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10039ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10039ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.175

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(324031070)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 7
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play324031071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 324031071
		arg_286_1.duration_ = 11.17

		local var_286_0 = {
			zh = 8.466,
			ja = 11.166
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
				arg_286_0:Play324031072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10039ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10039ui_story = var_289_0.localPosition
			end

			local var_289_2 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2
				local var_289_4 = Vector3.New(0, 100, 0)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10039ui_story, var_289_4, var_289_3)

				local var_289_5 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_5.x, var_289_5.y, var_289_5.z)

				local var_289_6 = var_289_0.localEulerAngles

				var_289_6.z = 0
				var_289_6.x = 0
				var_289_0.localEulerAngles = var_289_6
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, 100, 0)

				local var_289_7 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_7.x, var_289_7.y, var_289_7.z)

				local var_289_8 = var_289_0.localEulerAngles

				var_289_8.z = 0
				var_289_8.x = 0
				var_289_0.localEulerAngles = var_289_8
			end

			local var_289_9 = 0
			local var_289_10 = 0.775

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_11 = arg_286_1:FormatText(StoryNameCfg[1499].name)

				arg_286_1.leftNameTxt_.text = var_289_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_12 = arg_286_1:GetWordFromCfg(324031071)
				local var_289_13 = arg_286_1:FormatText(var_289_12.content)

				arg_286_1.text_.text = var_289_13

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_14 = 31
				local var_289_15 = utf8.len(var_289_13)
				local var_289_16 = var_289_14 <= 0 and var_289_10 or var_289_10 * (var_289_15 / var_289_14)

				if var_289_16 > 0 and var_289_10 < var_289_16 then
					arg_286_1.talkMaxDuration = var_289_16

					if var_289_16 + var_289_9 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_16 + var_289_9
					end
				end

				arg_286_1.text_.text = var_289_13
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031071", "story_v_out_324031.awb") ~= 0 then
					local var_289_17 = manager.audio:GetVoiceLength("story_v_out_324031", "324031071", "story_v_out_324031.awb") / 1000

					if var_289_17 + var_289_9 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_17 + var_289_9
					end

					if var_289_12.prefab_name ~= "" and arg_286_1.actors_[var_289_12.prefab_name] ~= nil then
						local var_289_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_12.prefab_name].transform, "story_v_out_324031", "324031071", "story_v_out_324031.awb")

						arg_286_1:RecordAudio("324031071", var_289_18)
						arg_286_1:RecordAudio("324031071", var_289_18)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_324031", "324031071", "story_v_out_324031.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_324031", "324031071", "story_v_out_324031.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_19 = math.max(var_289_10, arg_286_1.talkMaxDuration)

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_19 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_9) / var_289_19

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_9 + var_289_19 and arg_286_1.time_ < var_289_9 + var_289_19 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play324031072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 324031072
		arg_290_1.duration_ = 14.7

		local var_290_0 = {
			zh = 12.733,
			ja = 14.7
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
				arg_290_0:Play324031073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.125

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[1499].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(324031072)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 45
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031072", "story_v_out_324031.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031072", "story_v_out_324031.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_324031", "324031072", "story_v_out_324031.awb")

						arg_290_1:RecordAudio("324031072", var_293_9)
						arg_290_1:RecordAudio("324031072", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_324031", "324031072", "story_v_out_324031.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_324031", "324031072", "story_v_out_324031.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play324031073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 324031073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play324031074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.075

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(324031073)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 43
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play324031074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 324031074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play324031075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.325

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

				local var_301_3 = arg_298_1:GetWordFromCfg(324031074)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 13
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
	Play324031075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 324031075
		arg_302_1.duration_ = 9.7

		local var_302_0 = {
			zh = 9.7,
			ja = 6.8
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
				arg_302_0:Play324031076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10039ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos10039ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -0.8, -6.2)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10039ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["10039ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect10039ui_story == nil then
				arg_302_1.var_.characterEffect10039ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect10039ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect10039ui_story then
				arg_302_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_15 = 0
			local var_305_16 = 0.9

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[472].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(324031075)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 36
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031075", "story_v_out_324031.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031075", "story_v_out_324031.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_out_324031", "324031075", "story_v_out_324031.awb")

						arg_302_1:RecordAudio("324031075", var_305_24)
						arg_302_1:RecordAudio("324031075", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_324031", "324031075", "story_v_out_324031.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_324031", "324031075", "story_v_out_324031.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_25 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_25 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_25

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_25 and arg_302_1.time_ < var_305_15 + var_305_25 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play324031076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 324031076
		arg_306_1.duration_ = 16.53

		local var_306_0 = {
			zh = 9.2,
			ja = 16.533
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
				arg_306_0:Play324031077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.975

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[472].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(324031076)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 39
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031076", "story_v_out_324031.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031076", "story_v_out_324031.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_324031", "324031076", "story_v_out_324031.awb")

						arg_306_1:RecordAudio("324031076", var_309_9)
						arg_306_1:RecordAudio("324031076", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_324031", "324031076", "story_v_out_324031.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_324031", "324031076", "story_v_out_324031.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play324031077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 324031077
		arg_310_1.duration_ = 8.03

		local var_310_0 = {
			zh = 6.5,
			ja = 8.033
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
				arg_310_0:Play324031078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.65

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[472].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_3 = arg_310_1:GetWordFromCfg(324031077)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 26
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031077", "story_v_out_324031.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031077", "story_v_out_324031.awb") / 1000

					if var_313_8 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_0
					end

					if var_313_3.prefab_name ~= "" and arg_310_1.actors_[var_313_3.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_3.prefab_name].transform, "story_v_out_324031", "324031077", "story_v_out_324031.awb")

						arg_310_1:RecordAudio("324031077", var_313_9)
						arg_310_1:RecordAudio("324031077", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_324031", "324031077", "story_v_out_324031.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_324031", "324031077", "story_v_out_324031.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_10 and arg_310_1.time_ < var_313_0 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play324031078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 324031078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play324031079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10039ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10039ui_story == nil then
				arg_314_1.var_.characterEffect10039ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect10039ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10039ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10039ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10039ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0
			local var_317_7 = 0.275

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_9 = arg_314_1:GetWordFromCfg(324031078)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 11
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_14 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_14 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_14

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_14 and arg_314_1.time_ < var_317_6 + var_317_14 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play324031079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 324031079
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play324031080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["10039ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos10039ui_story = var_321_0.localPosition
			end

			local var_321_2 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2
				local var_321_4 = Vector3.New(0, 100, 0)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos10039ui_story, var_321_4, var_321_3)

				local var_321_5 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_5.x, var_321_5.y, var_321_5.z)

				local var_321_6 = var_321_0.localEulerAngles

				var_321_6.z = 0
				var_321_6.x = 0
				var_321_0.localEulerAngles = var_321_6
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, 100, 0)

				local var_321_7 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_7.x, var_321_7.y, var_321_7.z)

				local var_321_8 = var_321_0.localEulerAngles

				var_321_8.z = 0
				var_321_8.x = 0
				var_321_0.localEulerAngles = var_321_8
			end

			local var_321_9 = 0
			local var_321_10 = 1.675

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_11 = arg_318_1:GetWordFromCfg(324031079)
				local var_321_12 = arg_318_1:FormatText(var_321_11.content)

				arg_318_1.text_.text = var_321_12

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 67
				local var_321_14 = utf8.len(var_321_12)
				local var_321_15 = var_321_13 <= 0 and var_321_10 or var_321_10 * (var_321_14 / var_321_13)

				if var_321_15 > 0 and var_321_10 < var_321_15 then
					arg_318_1.talkMaxDuration = var_321_15

					if var_321_15 + var_321_9 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_9
					end
				end

				arg_318_1.text_.text = var_321_12
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_10, arg_318_1.talkMaxDuration)

			if var_321_9 <= arg_318_1.time_ and arg_318_1.time_ < var_321_9 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_9) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_9 + var_321_16 and arg_318_1.time_ < var_321_9 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play324031080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 324031080
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play324031081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 1.025

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(324031080)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 41
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_8 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_8 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_8

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_8 and arg_322_1.time_ < var_325_0 + var_325_8 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play324031081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 324031081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play324031082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.725

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(324031081)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 29
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_8 and arg_326_1.time_ < var_329_0 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play324031082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 324031082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play324031083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1.75

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[7].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(324031082)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 70
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_8 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_8 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_8

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_8 and arg_330_1.time_ < var_333_0 + var_333_8 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play324031083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 324031083
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play324031084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 1.175

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(324031083)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 47
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
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play324031084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 324031084
		arg_338_1.duration_ = 7.2

		local var_338_0 = {
			zh = 5.433,
			ja = 7.2
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
				arg_338_0:Play324031085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.5

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[1499].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(324031084)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031084", "story_v_out_324031.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031084", "story_v_out_324031.awb") / 1000

					if var_341_8 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_0
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_324031", "324031084", "story_v_out_324031.awb")

						arg_338_1:RecordAudio("324031084", var_341_9)
						arg_338_1:RecordAudio("324031084", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_324031", "324031084", "story_v_out_324031.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_324031", "324031084", "story_v_out_324031.awb")
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
	Play324031085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 324031085
		arg_342_1.duration_ = 14.5

		local var_342_0 = {
			zh = 10.366,
			ja = 14.5
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play324031086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.125

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[1499].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(324031085)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 45
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031085", "story_v_out_324031.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031085", "story_v_out_324031.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_324031", "324031085", "story_v_out_324031.awb")

						arg_342_1:RecordAudio("324031085", var_345_9)
						arg_342_1:RecordAudio("324031085", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_324031", "324031085", "story_v_out_324031.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_324031", "324031085", "story_v_out_324031.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play324031086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 324031086
		arg_346_1.duration_ = 11.6

		local var_346_0 = {
			zh = 7.866,
			ja = 11.6
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
				arg_346_0:Play324031087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.825

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[1499].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(324031086)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 33
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031086", "story_v_out_324031.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031086", "story_v_out_324031.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_324031", "324031086", "story_v_out_324031.awb")

						arg_346_1:RecordAudio("324031086", var_349_9)
						arg_346_1:RecordAudio("324031086", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_324031", "324031086", "story_v_out_324031.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_324031", "324031086", "story_v_out_324031.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play324031087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 324031087
		arg_350_1.duration_ = 5.3

		local var_350_0 = {
			zh = 1.966,
			ja = 5.3
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
				arg_350_0:Play324031088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1071ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1071ui_story = var_353_0.localPosition
			end

			local var_353_2 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2
				local var_353_4 = Vector3.New(0, -1.05, -6.2)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1071ui_story, var_353_4, var_353_3)

				local var_353_5 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_5.x, var_353_5.y, var_353_5.z)

				local var_353_6 = var_353_0.localEulerAngles

				var_353_6.z = 0
				var_353_6.x = 0
				var_353_0.localEulerAngles = var_353_6
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_353_7 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_7.x, var_353_7.y, var_353_7.z)

				local var_353_8 = var_353_0.localEulerAngles

				var_353_8.z = 0
				var_353_8.x = 0
				var_353_0.localEulerAngles = var_353_8
			end

			local var_353_9 = arg_350_1.actors_["1071ui_story"]
			local var_353_10 = 0

			if var_353_10 < arg_350_1.time_ and arg_350_1.time_ <= var_353_10 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1071ui_story == nil then
				arg_350_1.var_.characterEffect1071ui_story = var_353_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_11 = 0.200000002980232

			if var_353_10 <= arg_350_1.time_ and arg_350_1.time_ < var_353_10 + var_353_11 and not isNil(var_353_9) then
				local var_353_12 = (arg_350_1.time_ - var_353_10) / var_353_11

				if arg_350_1.var_.characterEffect1071ui_story and not isNil(var_353_9) then
					arg_350_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_10 + var_353_11 and arg_350_1.time_ < var_353_10 + var_353_11 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1071ui_story then
				arg_350_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_353_13 = 0

			if var_353_13 < arg_350_1.time_ and arg_350_1.time_ <= var_353_13 + arg_353_0 then
				arg_350_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_353_14 = 0

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_15 = 0
			local var_353_16 = 0.25

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[384].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(324031087)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 10
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031087", "story_v_out_324031.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031087", "story_v_out_324031.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_out_324031", "324031087", "story_v_out_324031.awb")

						arg_350_1:RecordAudio("324031087", var_353_24)
						arg_350_1:RecordAudio("324031087", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_324031", "324031087", "story_v_out_324031.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_324031", "324031087", "story_v_out_324031.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_25 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_25 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_25

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_25 and arg_350_1.time_ < var_353_15 + var_353_25 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play324031088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 324031088
		arg_354_1.duration_ = 12.7

		local var_354_0 = {
			zh = 11.266,
			ja = 12.7
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play324031089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1071ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1071ui_story == nil then
				arg_354_1.var_.characterEffect1071ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1071ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1071ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1071ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1071ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.85

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[1499].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_9 = arg_354_1:GetWordFromCfg(324031088)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031088", "story_v_out_324031.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031088", "story_v_out_324031.awb") / 1000

					if var_357_14 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_6
					end

					if var_357_9.prefab_name ~= "" and arg_354_1.actors_[var_357_9.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_9.prefab_name].transform, "story_v_out_324031", "324031088", "story_v_out_324031.awb")

						arg_354_1:RecordAudio("324031088", var_357_15)
						arg_354_1:RecordAudio("324031088", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_324031", "324031088", "story_v_out_324031.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_324031", "324031088", "story_v_out_324031.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_16 and arg_354_1.time_ < var_357_6 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play324031089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 324031089
		arg_358_1.duration_ = 13.33

		local var_358_0 = {
			zh = 11.366,
			ja = 13.333
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play324031090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.275

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[1499].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10174")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(324031089)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031089", "story_v_out_324031.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031089", "story_v_out_324031.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_324031", "324031089", "story_v_out_324031.awb")

						arg_358_1:RecordAudio("324031089", var_361_9)
						arg_358_1:RecordAudio("324031089", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_324031", "324031089", "story_v_out_324031.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_324031", "324031089", "story_v_out_324031.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play324031090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 324031090
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play324031091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.225

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(324031090)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 49
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_8 and arg_362_1.time_ < var_365_0 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play324031091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 324031091
		arg_366_1.duration_ = 4.77

		local var_366_0 = {
			zh = 4.766,
			ja = 3.8
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
				arg_366_0:Play324031092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1071ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1071ui_story == nil then
				arg_366_1.var_.characterEffect1071ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect1071ui_story and not isNil(var_369_0) then
					arg_366_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1071ui_story then
				arg_366_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_369_4 = 0

			if var_369_4 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_369_5 = 0
			local var_369_6 = 0.325

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_7 = arg_366_1:FormatText(StoryNameCfg[384].name)

				arg_366_1.leftNameTxt_.text = var_369_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_8 = arg_366_1:GetWordFromCfg(324031091)
				local var_369_9 = arg_366_1:FormatText(var_369_8.content)

				arg_366_1.text_.text = var_369_9

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_10 = 13
				local var_369_11 = utf8.len(var_369_9)
				local var_369_12 = var_369_10 <= 0 and var_369_6 or var_369_6 * (var_369_11 / var_369_10)

				if var_369_12 > 0 and var_369_6 < var_369_12 then
					arg_366_1.talkMaxDuration = var_369_12

					if var_369_12 + var_369_5 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_12 + var_369_5
					end
				end

				arg_366_1.text_.text = var_369_9
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031091", "story_v_out_324031.awb") ~= 0 then
					local var_369_13 = manager.audio:GetVoiceLength("story_v_out_324031", "324031091", "story_v_out_324031.awb") / 1000

					if var_369_13 + var_369_5 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_5
					end

					if var_369_8.prefab_name ~= "" and arg_366_1.actors_[var_369_8.prefab_name] ~= nil then
						local var_369_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_8.prefab_name].transform, "story_v_out_324031", "324031091", "story_v_out_324031.awb")

						arg_366_1:RecordAudio("324031091", var_369_14)
						arg_366_1:RecordAudio("324031091", var_369_14)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_324031", "324031091", "story_v_out_324031.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_324031", "324031091", "story_v_out_324031.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_15 = math.max(var_369_6, arg_366_1.talkMaxDuration)

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_15 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_5) / var_369_15

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_5 + var_369_15 and arg_366_1.time_ < var_369_5 + var_369_15 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play324031092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 324031092
		arg_370_1.duration_ = 15.57

		local var_370_0 = {
			zh = 12.733,
			ja = 15.566
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
				arg_370_0:Play324031093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 1.65

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[384].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_3 = arg_370_1:GetWordFromCfg(324031092)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 66
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031092", "story_v_out_324031.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031092", "story_v_out_324031.awb") / 1000

					if var_373_8 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_0
					end

					if var_373_3.prefab_name ~= "" and arg_370_1.actors_[var_373_3.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_3.prefab_name].transform, "story_v_out_324031", "324031092", "story_v_out_324031.awb")

						arg_370_1:RecordAudio("324031092", var_373_9)
						arg_370_1:RecordAudio("324031092", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_324031", "324031092", "story_v_out_324031.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_324031", "324031092", "story_v_out_324031.awb")
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
	Play324031093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 324031093
		arg_374_1.duration_ = 5.23

		local var_374_0 = {
			zh = 3.3,
			ja = 5.233
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play324031094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1071ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos1071ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1071ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = arg_374_1.actors_["1012ui_story"].transform
			local var_377_10 = 0

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 then
				arg_374_1.var_.moveOldPos1012ui_story = var_377_9.localPosition
			end

			local var_377_11 = 0.001

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_11 then
				local var_377_12 = (arg_374_1.time_ - var_377_10) / var_377_11
				local var_377_13 = Vector3.New(0.7, -1.05, -6.24)

				var_377_9.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1012ui_story, var_377_13, var_377_12)

				local var_377_14 = manager.ui.mainCamera.transform.position - var_377_9.position

				var_377_9.forward = Vector3.New(var_377_14.x, var_377_14.y, var_377_14.z)

				local var_377_15 = var_377_9.localEulerAngles

				var_377_15.z = 0
				var_377_15.x = 0
				var_377_9.localEulerAngles = var_377_15
			end

			if arg_374_1.time_ >= var_377_10 + var_377_11 and arg_374_1.time_ < var_377_10 + var_377_11 + arg_377_0 then
				var_377_9.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_377_16 = manager.ui.mainCamera.transform.position - var_377_9.position

				var_377_9.forward = Vector3.New(var_377_16.x, var_377_16.y, var_377_16.z)

				local var_377_17 = var_377_9.localEulerAngles

				var_377_17.z = 0
				var_377_17.x = 0
				var_377_9.localEulerAngles = var_377_17
			end

			local var_377_18 = arg_374_1.actors_["1012ui_story"]
			local var_377_19 = 0

			if var_377_19 < arg_374_1.time_ and arg_374_1.time_ <= var_377_19 + arg_377_0 and not isNil(var_377_18) and arg_374_1.var_.characterEffect1012ui_story == nil then
				arg_374_1.var_.characterEffect1012ui_story = var_377_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_20 = 0.200000002980232

			if var_377_19 <= arg_374_1.time_ and arg_374_1.time_ < var_377_19 + var_377_20 and not isNil(var_377_18) then
				local var_377_21 = (arg_374_1.time_ - var_377_19) / var_377_20

				if arg_374_1.var_.characterEffect1012ui_story and not isNil(var_377_18) then
					arg_374_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_19 + var_377_20 and arg_374_1.time_ < var_377_19 + var_377_20 + arg_377_0 and not isNil(var_377_18) and arg_374_1.var_.characterEffect1012ui_story then
				arg_374_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_377_22 = arg_374_1.actors_["1071ui_story"]
			local var_377_23 = 0

			if var_377_23 < arg_374_1.time_ and arg_374_1.time_ <= var_377_23 + arg_377_0 and not isNil(var_377_22) and arg_374_1.var_.characterEffect1071ui_story == nil then
				arg_374_1.var_.characterEffect1071ui_story = var_377_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_24 = 0.200000002980232

			if var_377_23 <= arg_374_1.time_ and arg_374_1.time_ < var_377_23 + var_377_24 and not isNil(var_377_22) then
				local var_377_25 = (arg_374_1.time_ - var_377_23) / var_377_24

				if arg_374_1.var_.characterEffect1071ui_story and not isNil(var_377_22) then
					local var_377_26 = Mathf.Lerp(0, 0.5, var_377_25)

					arg_374_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1071ui_story.fillRatio = var_377_26
				end
			end

			if arg_374_1.time_ >= var_377_23 + var_377_24 and arg_374_1.time_ < var_377_23 + var_377_24 + arg_377_0 and not isNil(var_377_22) and arg_374_1.var_.characterEffect1071ui_story then
				local var_377_27 = 0.5

				arg_374_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1071ui_story.fillRatio = var_377_27
			end

			local var_377_28 = 0

			if var_377_28 < arg_374_1.time_ and arg_374_1.time_ <= var_377_28 + arg_377_0 then
				arg_374_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action445")
			end

			local var_377_29 = 0
			local var_377_30 = 0.425

			if var_377_29 < arg_374_1.time_ and arg_374_1.time_ <= var_377_29 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_31 = arg_374_1:FormatText(StoryNameCfg[595].name)

				arg_374_1.leftNameTxt_.text = var_377_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_32 = arg_374_1:GetWordFromCfg(324031093)
				local var_377_33 = arg_374_1:FormatText(var_377_32.content)

				arg_374_1.text_.text = var_377_33

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_34 = 17
				local var_377_35 = utf8.len(var_377_33)
				local var_377_36 = var_377_34 <= 0 and var_377_30 or var_377_30 * (var_377_35 / var_377_34)

				if var_377_36 > 0 and var_377_30 < var_377_36 then
					arg_374_1.talkMaxDuration = var_377_36

					if var_377_36 + var_377_29 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_36 + var_377_29
					end
				end

				arg_374_1.text_.text = var_377_33
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031093", "story_v_out_324031.awb") ~= 0 then
					local var_377_37 = manager.audio:GetVoiceLength("story_v_out_324031", "324031093", "story_v_out_324031.awb") / 1000

					if var_377_37 + var_377_29 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_37 + var_377_29
					end

					if var_377_32.prefab_name ~= "" and arg_374_1.actors_[var_377_32.prefab_name] ~= nil then
						local var_377_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_32.prefab_name].transform, "story_v_out_324031", "324031093", "story_v_out_324031.awb")

						arg_374_1:RecordAudio("324031093", var_377_38)
						arg_374_1:RecordAudio("324031093", var_377_38)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_324031", "324031093", "story_v_out_324031.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_324031", "324031093", "story_v_out_324031.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_39 = math.max(var_377_30, arg_374_1.talkMaxDuration)

			if var_377_29 <= arg_374_1.time_ and arg_374_1.time_ < var_377_29 + var_377_39 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_29) / var_377_39

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_29 + var_377_39 and arg_374_1.time_ < var_377_29 + var_377_39 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play324031094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324031094
		arg_378_1.duration_ = 4.33

		local var_378_0 = {
			zh = 3.6,
			ja = 4.333
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324031095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1071ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1071ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(0, 100, 0)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1071ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0, 100, 0)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = arg_378_1.actors_["1012ui_story"].transform
			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 then
				arg_378_1.var_.moveOldPos1012ui_story = var_381_9.localPosition
			end

			local var_381_11 = 0.001

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_11 then
				local var_381_12 = (arg_378_1.time_ - var_381_10) / var_381_11
				local var_381_13 = Vector3.New(0, 100, 0)

				var_381_9.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1012ui_story, var_381_13, var_381_12)

				local var_381_14 = manager.ui.mainCamera.transform.position - var_381_9.position

				var_381_9.forward = Vector3.New(var_381_14.x, var_381_14.y, var_381_14.z)

				local var_381_15 = var_381_9.localEulerAngles

				var_381_15.z = 0
				var_381_15.x = 0
				var_381_9.localEulerAngles = var_381_15
			end

			if arg_378_1.time_ >= var_381_10 + var_381_11 and arg_378_1.time_ < var_381_10 + var_381_11 + arg_381_0 then
				var_381_9.localPosition = Vector3.New(0, 100, 0)

				local var_381_16 = manager.ui.mainCamera.transform.position - var_381_9.position

				var_381_9.forward = Vector3.New(var_381_16.x, var_381_16.y, var_381_16.z)

				local var_381_17 = var_381_9.localEulerAngles

				var_381_17.z = 0
				var_381_17.x = 0
				var_381_9.localEulerAngles = var_381_17
			end

			local var_381_18 = arg_378_1.actors_["10039ui_story"].transform
			local var_381_19 = 0

			if var_381_19 < arg_378_1.time_ and arg_378_1.time_ <= var_381_19 + arg_381_0 then
				arg_378_1.var_.moveOldPos10039ui_story = var_381_18.localPosition
			end

			local var_381_20 = 0.001

			if var_381_19 <= arg_378_1.time_ and arg_378_1.time_ < var_381_19 + var_381_20 then
				local var_381_21 = (arg_378_1.time_ - var_381_19) / var_381_20
				local var_381_22 = Vector3.New(0, -0.8, -6.2)

				var_381_18.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10039ui_story, var_381_22, var_381_21)

				local var_381_23 = manager.ui.mainCamera.transform.position - var_381_18.position

				var_381_18.forward = Vector3.New(var_381_23.x, var_381_23.y, var_381_23.z)

				local var_381_24 = var_381_18.localEulerAngles

				var_381_24.z = 0
				var_381_24.x = 0
				var_381_18.localEulerAngles = var_381_24
			end

			if arg_378_1.time_ >= var_381_19 + var_381_20 and arg_378_1.time_ < var_381_19 + var_381_20 + arg_381_0 then
				var_381_18.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_381_25 = manager.ui.mainCamera.transform.position - var_381_18.position

				var_381_18.forward = Vector3.New(var_381_25.x, var_381_25.y, var_381_25.z)

				local var_381_26 = var_381_18.localEulerAngles

				var_381_26.z = 0
				var_381_26.x = 0
				var_381_18.localEulerAngles = var_381_26
			end

			local var_381_27 = arg_378_1.actors_["10039ui_story"]
			local var_381_28 = 0

			if var_381_28 < arg_378_1.time_ and arg_378_1.time_ <= var_381_28 + arg_381_0 and not isNil(var_381_27) and arg_378_1.var_.characterEffect10039ui_story == nil then
				arg_378_1.var_.characterEffect10039ui_story = var_381_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_29 = 0.200000002980232

			if var_381_28 <= arg_378_1.time_ and arg_378_1.time_ < var_381_28 + var_381_29 and not isNil(var_381_27) then
				local var_381_30 = (arg_378_1.time_ - var_381_28) / var_381_29

				if arg_378_1.var_.characterEffect10039ui_story and not isNil(var_381_27) then
					arg_378_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_28 + var_381_29 and arg_378_1.time_ < var_381_28 + var_381_29 + arg_381_0 and not isNil(var_381_27) and arg_378_1.var_.characterEffect10039ui_story then
				arg_378_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_381_31 = arg_378_1.actors_["1012ui_story"]
			local var_381_32 = 0

			if var_381_32 < arg_378_1.time_ and arg_378_1.time_ <= var_381_32 + arg_381_0 and not isNil(var_381_31) and arg_378_1.var_.characterEffect1012ui_story == nil then
				arg_378_1.var_.characterEffect1012ui_story = var_381_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_33 = 0.200000002980232

			if var_381_32 <= arg_378_1.time_ and arg_378_1.time_ < var_381_32 + var_381_33 and not isNil(var_381_31) then
				local var_381_34 = (arg_378_1.time_ - var_381_32) / var_381_33

				if arg_378_1.var_.characterEffect1012ui_story and not isNil(var_381_31) then
					local var_381_35 = Mathf.Lerp(0, 0.5, var_381_34)

					arg_378_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1012ui_story.fillRatio = var_381_35
				end
			end

			if arg_378_1.time_ >= var_381_32 + var_381_33 and arg_378_1.time_ < var_381_32 + var_381_33 + arg_381_0 and not isNil(var_381_31) and arg_378_1.var_.characterEffect1012ui_story then
				local var_381_36 = 0.5

				arg_378_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1012ui_story.fillRatio = var_381_36
			end

			local var_381_37 = 0

			if var_381_37 < arg_378_1.time_ and arg_378_1.time_ <= var_381_37 + arg_381_0 then
				arg_378_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_381_38 = 0

			if var_381_38 < arg_378_1.time_ and arg_378_1.time_ <= var_381_38 + arg_381_0 then
				arg_378_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_381_39 = 0
			local var_381_40 = 0.375

			if var_381_39 < arg_378_1.time_ and arg_378_1.time_ <= var_381_39 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_41 = arg_378_1:FormatText(StoryNameCfg[472].name)

				arg_378_1.leftNameTxt_.text = var_381_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_42 = arg_378_1:GetWordFromCfg(324031094)
				local var_381_43 = arg_378_1:FormatText(var_381_42.content)

				arg_378_1.text_.text = var_381_43

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_44 = 15
				local var_381_45 = utf8.len(var_381_43)
				local var_381_46 = var_381_44 <= 0 and var_381_40 or var_381_40 * (var_381_45 / var_381_44)

				if var_381_46 > 0 and var_381_40 < var_381_46 then
					arg_378_1.talkMaxDuration = var_381_46

					if var_381_46 + var_381_39 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_46 + var_381_39
					end
				end

				arg_378_1.text_.text = var_381_43
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031094", "story_v_out_324031.awb") ~= 0 then
					local var_381_47 = manager.audio:GetVoiceLength("story_v_out_324031", "324031094", "story_v_out_324031.awb") / 1000

					if var_381_47 + var_381_39 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_47 + var_381_39
					end

					if var_381_42.prefab_name ~= "" and arg_378_1.actors_[var_381_42.prefab_name] ~= nil then
						local var_381_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_42.prefab_name].transform, "story_v_out_324031", "324031094", "story_v_out_324031.awb")

						arg_378_1:RecordAudio("324031094", var_381_48)
						arg_378_1:RecordAudio("324031094", var_381_48)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_324031", "324031094", "story_v_out_324031.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_324031", "324031094", "story_v_out_324031.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_49 = math.max(var_381_40, arg_378_1.talkMaxDuration)

			if var_381_39 <= arg_378_1.time_ and arg_378_1.time_ < var_381_39 + var_381_49 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_39) / var_381_49

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_39 + var_381_49 and arg_378_1.time_ < var_381_39 + var_381_49 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play324031095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324031095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324031096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10039ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect10039ui_story == nil then
				arg_382_1.var_.characterEffect10039ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect10039ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_382_1.var_.characterEffect10039ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect10039ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_382_1.var_.characterEffect10039ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 1.125

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(324031095)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 45
				local var_385_11 = utf8.len(var_385_9)
				local var_385_12 = var_385_10 <= 0 and var_385_7 or var_385_7 * (var_385_11 / var_385_10)

				if var_385_12 > 0 and var_385_7 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_13 and arg_382_1.time_ < var_385_6 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324031096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324031096
		arg_386_1.duration_ = 4.87

		local var_386_0 = {
			zh = 3.066,
			ja = 4.866
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
				arg_386_0:Play324031097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10039ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10039ui_story == nil then
				arg_386_1.var_.characterEffect10039ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect10039ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10039ui_story then
				arg_386_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_389_4 = 0

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_389_5 = 0
			local var_389_6 = 0.275

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_7 = arg_386_1:FormatText(StoryNameCfg[472].name)

				arg_386_1.leftNameTxt_.text = var_389_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_8 = arg_386_1:GetWordFromCfg(324031096)
				local var_389_9 = arg_386_1:FormatText(var_389_8.content)

				arg_386_1.text_.text = var_389_9

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_10 = 11
				local var_389_11 = utf8.len(var_389_9)
				local var_389_12 = var_389_10 <= 0 and var_389_6 or var_389_6 * (var_389_11 / var_389_10)

				if var_389_12 > 0 and var_389_6 < var_389_12 then
					arg_386_1.talkMaxDuration = var_389_12

					if var_389_12 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_12 + var_389_5
					end
				end

				arg_386_1.text_.text = var_389_9
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031096", "story_v_out_324031.awb") ~= 0 then
					local var_389_13 = manager.audio:GetVoiceLength("story_v_out_324031", "324031096", "story_v_out_324031.awb") / 1000

					if var_389_13 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_5
					end

					if var_389_8.prefab_name ~= "" and arg_386_1.actors_[var_389_8.prefab_name] ~= nil then
						local var_389_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_8.prefab_name].transform, "story_v_out_324031", "324031096", "story_v_out_324031.awb")

						arg_386_1:RecordAudio("324031096", var_389_14)
						arg_386_1:RecordAudio("324031096", var_389_14)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_324031", "324031096", "story_v_out_324031.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_324031", "324031096", "story_v_out_324031.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_15 = math.max(var_389_6, arg_386_1.talkMaxDuration)

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_15 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_5) / var_389_15

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_5 + var_389_15 and arg_386_1.time_ < var_389_5 + var_389_15 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324031097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324031097
		arg_390_1.duration_ = 18.8

		local var_390_0 = {
			zh = 15.033,
			ja = 18.8
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
				arg_390_0:Play324031098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_1 = 0
			local var_393_2 = 1.5

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_3 = arg_390_1:FormatText(StoryNameCfg[472].name)

				arg_390_1.leftNameTxt_.text = var_393_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(324031097)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_6 = 60
				local var_393_7 = utf8.len(var_393_5)
				local var_393_8 = var_393_6 <= 0 and var_393_2 or var_393_2 * (var_393_7 / var_393_6)

				if var_393_8 > 0 and var_393_2 < var_393_8 then
					arg_390_1.talkMaxDuration = var_393_8

					if var_393_8 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031097", "story_v_out_324031.awb") ~= 0 then
					local var_393_9 = manager.audio:GetVoiceLength("story_v_out_324031", "324031097", "story_v_out_324031.awb") / 1000

					if var_393_9 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_1
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_out_324031", "324031097", "story_v_out_324031.awb")

						arg_390_1:RecordAudio("324031097", var_393_10)
						arg_390_1:RecordAudio("324031097", var_393_10)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324031", "324031097", "story_v_out_324031.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324031", "324031097", "story_v_out_324031.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_11 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_11 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_11

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_11 and arg_390_1.time_ < var_393_1 + var_393_11 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play324031098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324031098
		arg_394_1.duration_ = 11.47

		local var_394_0 = {
			zh = 10.2,
			ja = 11.466
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324031099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 1.075

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[472].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_3 = arg_394_1:GetWordFromCfg(324031098)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 43
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031098", "story_v_out_324031.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031098", "story_v_out_324031.awb") / 1000

					if var_397_8 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_0
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_324031", "324031098", "story_v_out_324031.awb")

						arg_394_1:RecordAudio("324031098", var_397_9)
						arg_394_1:RecordAudio("324031098", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_324031", "324031098", "story_v_out_324031.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_324031", "324031098", "story_v_out_324031.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_10 and arg_394_1.time_ < var_397_0 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play324031099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 324031099
		arg_398_1.duration_ = 7.8

		local var_398_0 = {
			zh = 5.433,
			ja = 7.8
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
				arg_398_0:Play324031100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_2 = 0
			local var_401_3 = 0.375

			if var_401_2 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_4 = arg_398_1:FormatText(StoryNameCfg[472].name)

				arg_398_1.leftNameTxt_.text = var_401_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_5 = arg_398_1:GetWordFromCfg(324031099)
				local var_401_6 = arg_398_1:FormatText(var_401_5.content)

				arg_398_1.text_.text = var_401_6

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 15
				local var_401_8 = utf8.len(var_401_6)
				local var_401_9 = var_401_7 <= 0 and var_401_3 or var_401_3 * (var_401_8 / var_401_7)

				if var_401_9 > 0 and var_401_3 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_6
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031099", "story_v_out_324031.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_out_324031", "324031099", "story_v_out_324031.awb") / 1000

					if var_401_10 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_2
					end

					if var_401_5.prefab_name ~= "" and arg_398_1.actors_[var_401_5.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_5.prefab_name].transform, "story_v_out_324031", "324031099", "story_v_out_324031.awb")

						arg_398_1:RecordAudio("324031099", var_401_11)
						arg_398_1:RecordAudio("324031099", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_324031", "324031099", "story_v_out_324031.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_324031", "324031099", "story_v_out_324031.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_12 and arg_398_1.time_ < var_401_2 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play324031100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 324031100
		arg_402_1.duration_ = 8

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play324031101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = "ST31"

			if arg_402_1.bgs_[var_405_0] == nil then
				local var_405_1 = Object.Instantiate(arg_402_1.paintGo_)

				var_405_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_405_0)
				var_405_1.name = var_405_0
				var_405_1.transform.parent = arg_402_1.stage_.transform
				var_405_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_402_1.bgs_[var_405_0] = var_405_1
			end

			local var_405_2 = 1.4

			if var_405_2 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				local var_405_3 = manager.ui.mainCamera.transform.localPosition
				local var_405_4 = Vector3.New(0, 0, 10) + Vector3.New(var_405_3.x, var_405_3.y, 0)
				local var_405_5 = arg_402_1.bgs_.ST31

				var_405_5.transform.localPosition = var_405_4
				var_405_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_405_6 = var_405_5:GetComponent("SpriteRenderer")

				if var_405_6 and var_405_6.sprite then
					local var_405_7 = (var_405_5.transform.localPosition - var_405_3).z
					local var_405_8 = manager.ui.mainCameraCom_
					local var_405_9 = 2 * var_405_7 * Mathf.Tan(var_405_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_405_10 = var_405_9 * var_405_8.aspect
					local var_405_11 = var_405_6.sprite.bounds.size.x
					local var_405_12 = var_405_6.sprite.bounds.size.y
					local var_405_13 = var_405_10 / var_405_11
					local var_405_14 = var_405_9 / var_405_12
					local var_405_15 = var_405_14 < var_405_13 and var_405_13 or var_405_14

					var_405_5.transform.localScale = Vector3.New(var_405_15, var_405_15, 0)
				end

				for iter_405_0, iter_405_1 in pairs(arg_402_1.bgs_) do
					if iter_405_0 ~= "ST31" then
						iter_405_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_405_16 = 1.4

			if var_405_16 < arg_402_1.time_ and arg_402_1.time_ <= var_405_16 + arg_405_0 then
				arg_402_1.allBtn_.enabled = false
			end

			local var_405_17 = 0.3

			if arg_402_1.time_ >= var_405_16 + var_405_17 and arg_402_1.time_ < var_405_16 + var_405_17 + arg_405_0 then
				arg_402_1.allBtn_.enabled = true
			end

			local var_405_18 = 0

			if var_405_18 < arg_402_1.time_ and arg_402_1.time_ <= var_405_18 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_19 = 1.4

			if var_405_18 <= arg_402_1.time_ and arg_402_1.time_ < var_405_18 + var_405_19 then
				local var_405_20 = (arg_402_1.time_ - var_405_18) / var_405_19
				local var_405_21 = Color.New(0, 0, 0)

				var_405_21.a = Mathf.Lerp(0, 1, var_405_20)
				arg_402_1.mask_.color = var_405_21
			end

			if arg_402_1.time_ >= var_405_18 + var_405_19 and arg_402_1.time_ < var_405_18 + var_405_19 + arg_405_0 then
				local var_405_22 = Color.New(0, 0, 0)

				var_405_22.a = 1
				arg_402_1.mask_.color = var_405_22
			end

			local var_405_23 = 1.4

			if var_405_23 < arg_402_1.time_ and arg_402_1.time_ <= var_405_23 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_24 = 2

			if var_405_23 <= arg_402_1.time_ and arg_402_1.time_ < var_405_23 + var_405_24 then
				local var_405_25 = (arg_402_1.time_ - var_405_23) / var_405_24
				local var_405_26 = Color.New(0, 0, 0)

				var_405_26.a = Mathf.Lerp(1, 0, var_405_25)
				arg_402_1.mask_.color = var_405_26
			end

			if arg_402_1.time_ >= var_405_23 + var_405_24 and arg_402_1.time_ < var_405_23 + var_405_24 + arg_405_0 then
				local var_405_27 = Color.New(0, 0, 0)
				local var_405_28 = 0

				arg_402_1.mask_.enabled = false
				var_405_27.a = var_405_28
				arg_402_1.mask_.color = var_405_27
			end

			local var_405_29 = arg_402_1.actors_["10039ui_story"].transform
			local var_405_30 = 1.36666666666667

			if var_405_30 < arg_402_1.time_ and arg_402_1.time_ <= var_405_30 + arg_405_0 then
				arg_402_1.var_.moveOldPos10039ui_story = var_405_29.localPosition
			end

			local var_405_31 = 0.001

			if var_405_30 <= arg_402_1.time_ and arg_402_1.time_ < var_405_30 + var_405_31 then
				local var_405_32 = (arg_402_1.time_ - var_405_30) / var_405_31
				local var_405_33 = Vector3.New(0, 100, 0)

				var_405_29.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10039ui_story, var_405_33, var_405_32)

				local var_405_34 = manager.ui.mainCamera.transform.position - var_405_29.position

				var_405_29.forward = Vector3.New(var_405_34.x, var_405_34.y, var_405_34.z)

				local var_405_35 = var_405_29.localEulerAngles

				var_405_35.z = 0
				var_405_35.x = 0
				var_405_29.localEulerAngles = var_405_35
			end

			if arg_402_1.time_ >= var_405_30 + var_405_31 and arg_402_1.time_ < var_405_30 + var_405_31 + arg_405_0 then
				var_405_29.localPosition = Vector3.New(0, 100, 0)

				local var_405_36 = manager.ui.mainCamera.transform.position - var_405_29.position

				var_405_29.forward = Vector3.New(var_405_36.x, var_405_36.y, var_405_36.z)

				local var_405_37 = var_405_29.localEulerAngles

				var_405_37.z = 0
				var_405_37.x = 0
				var_405_29.localEulerAngles = var_405_37
			end

			local var_405_38 = arg_402_1.actors_["10039ui_story"]
			local var_405_39 = 1.36666666666667

			if var_405_39 < arg_402_1.time_ and arg_402_1.time_ <= var_405_39 + arg_405_0 and not isNil(var_405_38) and arg_402_1.var_.characterEffect10039ui_story == nil then
				arg_402_1.var_.characterEffect10039ui_story = var_405_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_40 = 0.200000002980232

			if var_405_39 <= arg_402_1.time_ and arg_402_1.time_ < var_405_39 + var_405_40 and not isNil(var_405_38) then
				local var_405_41 = (arg_402_1.time_ - var_405_39) / var_405_40

				if arg_402_1.var_.characterEffect10039ui_story and not isNil(var_405_38) then
					local var_405_42 = Mathf.Lerp(0, 0.5, var_405_41)

					arg_402_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_402_1.var_.characterEffect10039ui_story.fillRatio = var_405_42
				end
			end

			if arg_402_1.time_ >= var_405_39 + var_405_40 and arg_402_1.time_ < var_405_39 + var_405_40 + arg_405_0 and not isNil(var_405_38) and arg_402_1.var_.characterEffect10039ui_story then
				local var_405_43 = 0.5

				arg_402_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_402_1.var_.characterEffect10039ui_story.fillRatio = var_405_43
			end

			local var_405_44 = 1.2
			local var_405_45 = 1

			if var_405_44 < arg_402_1.time_ and arg_402_1.time_ <= var_405_44 + arg_405_0 then
				local var_405_46 = "play"
				local var_405_47 = "effect"

				arg_402_1:AudioAction(var_405_46, var_405_47, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_405_48 = 0.1
			local var_405_49 = 1

			if var_405_48 < arg_402_1.time_ and arg_402_1.time_ <= var_405_48 + arg_405_0 then
				local var_405_50 = "stop"
				local var_405_51 = "effect"

				arg_402_1:AudioAction(var_405_50, var_405_51, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_402_1.frameCnt_ <= 1 then
				arg_402_1.dialog_:SetActive(false)
			end

			local var_405_52 = 3
			local var_405_53 = 1.5

			if var_405_52 < arg_402_1.time_ and arg_402_1.time_ <= var_405_52 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0

				arg_402_1.dialog_:SetActive(true)

				arg_402_1.dialogCg_.alpha = 0

				local var_405_54 = LeanTween.value(arg_402_1.dialog_, 0, 1, 0.3)

				var_405_54:setOnUpdate(LuaHelper.FloatAction(function(arg_406_0)
					arg_402_1.dialogCg_.alpha = arg_406_0
				end))
				var_405_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_402_1.dialog_)
					var_405_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_402_1.duration_ = arg_402_1.duration_ + 0.3

				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_55 = arg_402_1:GetWordFromCfg(324031100)
				local var_405_56 = arg_402_1:FormatText(var_405_55.content)

				arg_402_1.text_.text = var_405_56

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_57 = 60
				local var_405_58 = utf8.len(var_405_56)
				local var_405_59 = var_405_57 <= 0 and var_405_53 or var_405_53 * (var_405_58 / var_405_57)

				if var_405_59 > 0 and var_405_53 < var_405_59 then
					arg_402_1.talkMaxDuration = var_405_59
					var_405_52 = var_405_52 + 0.3

					if var_405_59 + var_405_52 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_59 + var_405_52
					end
				end

				arg_402_1.text_.text = var_405_56
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_60 = var_405_52 + 0.3
			local var_405_61 = math.max(var_405_53, arg_402_1.talkMaxDuration)

			if var_405_60 <= arg_402_1.time_ and arg_402_1.time_ < var_405_60 + var_405_61 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_60) / var_405_61

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_60 + var_405_61 and arg_402_1.time_ < var_405_60 + var_405_61 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play324031101 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 324031101
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play324031102(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.75

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[7].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(324031101)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 30
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_8 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_8 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_8

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_8 and arg_408_1.time_ < var_411_0 + var_411_8 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play324031102 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 324031102
		arg_412_1.duration_ = 9.43

		local var_412_0 = {
			zh = 7.166,
			ja = 9.433
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
				arg_412_0:Play324031103(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10039ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos10039ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -0.8, -6.2)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10039ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["10039ui_story"]
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect10039ui_story == nil then
				arg_412_1.var_.characterEffect10039ui_story = var_415_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 and not isNil(var_415_9) then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11

				if arg_412_1.var_.characterEffect10039ui_story and not isNil(var_415_9) then
					arg_412_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect10039ui_story then
				arg_412_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_415_13 = 0

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_415_14 = 0

			if var_415_14 < arg_412_1.time_ and arg_412_1.time_ <= var_415_14 + arg_415_0 then
				arg_412_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_415_15 = 0
			local var_415_16 = 0.775

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[472].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(324031102)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 31
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031102", "story_v_out_324031.awb") ~= 0 then
					local var_415_23 = manager.audio:GetVoiceLength("story_v_out_324031", "324031102", "story_v_out_324031.awb") / 1000

					if var_415_23 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_15
					end

					if var_415_18.prefab_name ~= "" and arg_412_1.actors_[var_415_18.prefab_name] ~= nil then
						local var_415_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_18.prefab_name].transform, "story_v_out_324031", "324031102", "story_v_out_324031.awb")

						arg_412_1:RecordAudio("324031102", var_415_24)
						arg_412_1:RecordAudio("324031102", var_415_24)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_324031", "324031102", "story_v_out_324031.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_324031", "324031102", "story_v_out_324031.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_25 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_25 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_15) / var_415_25

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_15 + var_415_25 and arg_412_1.time_ < var_415_15 + var_415_25 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play324031103 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 324031103
		arg_416_1.duration_ = 7.63

		local var_416_0 = {
			zh = 4.566,
			ja = 7.633
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
				arg_416_0:Play324031104(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.425

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[472].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(324031103)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 17
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031103", "story_v_out_324031.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031103", "story_v_out_324031.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_324031", "324031103", "story_v_out_324031.awb")

						arg_416_1:RecordAudio("324031103", var_419_9)
						arg_416_1:RecordAudio("324031103", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_324031", "324031103", "story_v_out_324031.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_324031", "324031103", "story_v_out_324031.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play324031104 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 324031104
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play324031105(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10039ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10039ui_story == nil then
				arg_420_1.var_.characterEffect10039ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10039ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10039ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10039ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10039ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.95

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[7].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_9 = arg_420_1:GetWordFromCfg(324031104)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 38
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play324031105 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 324031105
		arg_424_1.duration_ = 2.3

		local var_424_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_424_0:Play324031106(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10039ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10039ui_story == nil then
				arg_424_1.var_.characterEffect10039ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect10039ui_story and not isNil(var_427_0) then
					arg_424_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10039ui_story then
				arg_424_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_427_4 = 0

			if var_427_4 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_427_5 = 0
			local var_427_6 = 0.1

			if var_427_5 < arg_424_1.time_ and arg_424_1.time_ <= var_427_5 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_7 = arg_424_1:FormatText(StoryNameCfg[472].name)

				arg_424_1.leftNameTxt_.text = var_427_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_8 = arg_424_1:GetWordFromCfg(324031105)
				local var_427_9 = arg_424_1:FormatText(var_427_8.content)

				arg_424_1.text_.text = var_427_9

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_10 = 4
				local var_427_11 = utf8.len(var_427_9)
				local var_427_12 = var_427_10 <= 0 and var_427_6 or var_427_6 * (var_427_11 / var_427_10)

				if var_427_12 > 0 and var_427_6 < var_427_12 then
					arg_424_1.talkMaxDuration = var_427_12

					if var_427_12 + var_427_5 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_5
					end
				end

				arg_424_1.text_.text = var_427_9
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031105", "story_v_out_324031.awb") ~= 0 then
					local var_427_13 = manager.audio:GetVoiceLength("story_v_out_324031", "324031105", "story_v_out_324031.awb") / 1000

					if var_427_13 + var_427_5 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_5
					end

					if var_427_8.prefab_name ~= "" and arg_424_1.actors_[var_427_8.prefab_name] ~= nil then
						local var_427_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_8.prefab_name].transform, "story_v_out_324031", "324031105", "story_v_out_324031.awb")

						arg_424_1:RecordAudio("324031105", var_427_14)
						arg_424_1:RecordAudio("324031105", var_427_14)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_324031", "324031105", "story_v_out_324031.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_324031", "324031105", "story_v_out_324031.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_15 = math.max(var_427_6, arg_424_1.talkMaxDuration)

			if var_427_5 <= arg_424_1.time_ and arg_424_1.time_ < var_427_5 + var_427_15 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_5) / var_427_15

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_5 + var_427_15 and arg_424_1.time_ < var_427_5 + var_427_15 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play324031106 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 324031106
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play324031107(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10039ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10039ui_story == nil then
				arg_428_1.var_.characterEffect10039ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect10039ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10039ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10039ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10039ui_story.fillRatio = var_431_5
			end

			local var_431_6 = 0
			local var_431_7 = 1.225

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_8 = arg_428_1:GetWordFromCfg(324031106)
				local var_431_9 = arg_428_1:FormatText(var_431_8.content)

				arg_428_1.text_.text = var_431_9

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_10 = 49
				local var_431_11 = utf8.len(var_431_9)
				local var_431_12 = var_431_10 <= 0 and var_431_7 or var_431_7 * (var_431_11 / var_431_10)

				if var_431_12 > 0 and var_431_7 < var_431_12 then
					arg_428_1.talkMaxDuration = var_431_12

					if var_431_12 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_12 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_9
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_13 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_13 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_13

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_13 and arg_428_1.time_ < var_431_6 + var_431_13 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play324031107 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 324031107
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play324031108(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.4

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(324031107)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 16
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_8 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_8 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_8

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_8 and arg_432_1.time_ < var_435_0 + var_435_8 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play324031108 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 324031108
		arg_436_1.duration_ = 5.27

		local var_436_0 = {
			zh = 5.2,
			ja = 5.266
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play324031109(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10039ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10039ui_story == nil then
				arg_436_1.var_.characterEffect10039ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect10039ui_story and not isNil(var_439_0) then
					arg_436_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10039ui_story then
				arg_436_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_439_4 = 0
			local var_439_5 = 0.475

			if var_439_4 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_6 = arg_436_1:FormatText(StoryNameCfg[472].name)

				arg_436_1.leftNameTxt_.text = var_439_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_7 = arg_436_1:GetWordFromCfg(324031108)
				local var_439_8 = arg_436_1:FormatText(var_439_7.content)

				arg_436_1.text_.text = var_439_8

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 19
				local var_439_10 = utf8.len(var_439_8)
				local var_439_11 = var_439_9 <= 0 and var_439_5 or var_439_5 * (var_439_10 / var_439_9)

				if var_439_11 > 0 and var_439_5 < var_439_11 then
					arg_436_1.talkMaxDuration = var_439_11

					if var_439_11 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_11 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_8
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031108", "story_v_out_324031.awb") ~= 0 then
					local var_439_12 = manager.audio:GetVoiceLength("story_v_out_324031", "324031108", "story_v_out_324031.awb") / 1000

					if var_439_12 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_4
					end

					if var_439_7.prefab_name ~= "" and arg_436_1.actors_[var_439_7.prefab_name] ~= nil then
						local var_439_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_7.prefab_name].transform, "story_v_out_324031", "324031108", "story_v_out_324031.awb")

						arg_436_1:RecordAudio("324031108", var_439_13)
						arg_436_1:RecordAudio("324031108", var_439_13)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_324031", "324031108", "story_v_out_324031.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_324031", "324031108", "story_v_out_324031.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_14 and arg_436_1.time_ < var_439_4 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play324031109 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 324031109
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play324031110(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10039ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect10039ui_story == nil then
				arg_440_1.var_.characterEffect10039ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect10039ui_story and not isNil(var_443_0) then
					local var_443_4 = Mathf.Lerp(0, 0.5, var_443_3)

					arg_440_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_440_1.var_.characterEffect10039ui_story.fillRatio = var_443_4
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect10039ui_story then
				local var_443_5 = 0.5

				arg_440_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_440_1.var_.characterEffect10039ui_story.fillRatio = var_443_5
			end

			local var_443_6 = 0
			local var_443_7 = 0.175

			if var_443_6 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_8 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_9 = arg_440_1:GetWordFromCfg(324031109)
				local var_443_10 = arg_440_1:FormatText(var_443_9.content)

				arg_440_1.text_.text = var_443_10

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 7
				local var_443_12 = utf8.len(var_443_10)
				local var_443_13 = var_443_11 <= 0 and var_443_7 or var_443_7 * (var_443_12 / var_443_11)

				if var_443_13 > 0 and var_443_7 < var_443_13 then
					arg_440_1.talkMaxDuration = var_443_13

					if var_443_13 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_13 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_10
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play324031110 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 324031110
		arg_444_1.duration_ = 10.6

		local var_444_0 = {
			zh = 8.166,
			ja = 10.6
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
				arg_444_0:Play324031111(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10039ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect10039ui_story == nil then
				arg_444_1.var_.characterEffect10039ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect10039ui_story and not isNil(var_447_0) then
					arg_444_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect10039ui_story then
				arg_444_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_447_4 = 0

			if var_447_4 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_1")
			end

			local var_447_5 = 0

			if var_447_5 < arg_444_1.time_ and arg_444_1.time_ <= var_447_5 + arg_447_0 then
				arg_444_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_447_6 = 0
			local var_447_7 = 0.925

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_8 = arg_444_1:FormatText(StoryNameCfg[472].name)

				arg_444_1.leftNameTxt_.text = var_447_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_9 = arg_444_1:GetWordFromCfg(324031110)
				local var_447_10 = arg_444_1:FormatText(var_447_9.content)

				arg_444_1.text_.text = var_447_10

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031110", "story_v_out_324031.awb") ~= 0 then
					local var_447_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031110", "story_v_out_324031.awb") / 1000

					if var_447_14 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_14 + var_447_6
					end

					if var_447_9.prefab_name ~= "" and arg_444_1.actors_[var_447_9.prefab_name] ~= nil then
						local var_447_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_9.prefab_name].transform, "story_v_out_324031", "324031110", "story_v_out_324031.awb")

						arg_444_1:RecordAudio("324031110", var_447_15)
						arg_444_1:RecordAudio("324031110", var_447_15)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_324031", "324031110", "story_v_out_324031.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_324031", "324031110", "story_v_out_324031.awb")
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
	Play324031111 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 324031111
		arg_448_1.duration_ = 10.07

		local var_448_0 = {
			zh = 6.6,
			ja = 10.066
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
				arg_448_0:Play324031112(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.75

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[472].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_3 = arg_448_1:GetWordFromCfg(324031111)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 30
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031111", "story_v_out_324031.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031111", "story_v_out_324031.awb") / 1000

					if var_451_8 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_0
					end

					if var_451_3.prefab_name ~= "" and arg_448_1.actors_[var_451_3.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_3.prefab_name].transform, "story_v_out_324031", "324031111", "story_v_out_324031.awb")

						arg_448_1:RecordAudio("324031111", var_451_9)
						arg_448_1:RecordAudio("324031111", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_324031", "324031111", "story_v_out_324031.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_324031", "324031111", "story_v_out_324031.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_10 and arg_448_1.time_ < var_451_0 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play324031112 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 324031112
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play324031113(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["10039ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect10039ui_story == nil then
				arg_452_1.var_.characterEffect10039ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect10039ui_story and not isNil(var_455_0) then
					local var_455_4 = Mathf.Lerp(0, 0.5, var_455_3)

					arg_452_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_452_1.var_.characterEffect10039ui_story.fillRatio = var_455_4
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect10039ui_story then
				local var_455_5 = 0.5

				arg_452_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_452_1.var_.characterEffect10039ui_story.fillRatio = var_455_5
			end

			local var_455_6 = 0
			local var_455_7 = 0.3

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

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_9 = arg_452_1:GetWordFromCfg(324031112)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 12
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
	Play324031113 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 324031113
		arg_456_1.duration_ = 10.23

		local var_456_0 = {
			zh = 8.033,
			ja = 10.233
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
				arg_456_0:Play324031114(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["10039ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect10039ui_story == nil then
				arg_456_1.var_.characterEffect10039ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect10039ui_story and not isNil(var_459_0) then
					arg_456_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect10039ui_story then
				arg_456_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_459_4 = 0

			if var_459_4 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_2")
			end

			local var_459_5 = 0

			if var_459_5 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_459_6 = 0
			local var_459_7 = 0.8

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_8 = arg_456_1:FormatText(StoryNameCfg[472].name)

				arg_456_1.leftNameTxt_.text = var_459_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_9 = arg_456_1:GetWordFromCfg(324031113)
				local var_459_10 = arg_456_1:FormatText(var_459_9.content)

				arg_456_1.text_.text = var_459_10

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_11 = 32
				local var_459_12 = utf8.len(var_459_10)
				local var_459_13 = var_459_11 <= 0 and var_459_7 or var_459_7 * (var_459_12 / var_459_11)

				if var_459_13 > 0 and var_459_7 < var_459_13 then
					arg_456_1.talkMaxDuration = var_459_13

					if var_459_13 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_13 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_10
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031113", "story_v_out_324031.awb") ~= 0 then
					local var_459_14 = manager.audio:GetVoiceLength("story_v_out_324031", "324031113", "story_v_out_324031.awb") / 1000

					if var_459_14 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_14 + var_459_6
					end

					if var_459_9.prefab_name ~= "" and arg_456_1.actors_[var_459_9.prefab_name] ~= nil then
						local var_459_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_9.prefab_name].transform, "story_v_out_324031", "324031113", "story_v_out_324031.awb")

						arg_456_1:RecordAudio("324031113", var_459_15)
						arg_456_1:RecordAudio("324031113", var_459_15)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_324031", "324031113", "story_v_out_324031.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_324031", "324031113", "story_v_out_324031.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_16 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_16 and arg_456_1.time_ < var_459_6 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play324031114 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 324031114
		arg_460_1.duration_ = 12.23

		local var_460_0 = {
			zh = 11.266,
			ja = 12.233
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
				arg_460_0:Play324031115(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 1.15

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[472].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:GetWordFromCfg(324031114)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 46
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031114", "story_v_out_324031.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031114", "story_v_out_324031.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_324031", "324031114", "story_v_out_324031.awb")

						arg_460_1:RecordAudio("324031114", var_463_9)
						arg_460_1:RecordAudio("324031114", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_324031", "324031114", "story_v_out_324031.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_324031", "324031114", "story_v_out_324031.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play324031115 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 324031115
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play324031116(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["10039ui_story"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect10039ui_story == nil then
				arg_464_1.var_.characterEffect10039ui_story = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect10039ui_story and not isNil(var_467_0) then
					local var_467_4 = Mathf.Lerp(0, 0.5, var_467_3)

					arg_464_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_464_1.var_.characterEffect10039ui_story.fillRatio = var_467_4
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect10039ui_story then
				local var_467_5 = 0.5

				arg_464_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_464_1.var_.characterEffect10039ui_story.fillRatio = var_467_5
			end

			local var_467_6 = 0
			local var_467_7 = 0.825

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_8 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_9 = arg_464_1:GetWordFromCfg(324031115)
				local var_467_10 = arg_464_1:FormatText(var_467_9.content)

				arg_464_1.text_.text = var_467_10

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 33
				local var_467_12 = utf8.len(var_467_10)
				local var_467_13 = var_467_11 <= 0 and var_467_7 or var_467_7 * (var_467_12 / var_467_11)

				if var_467_13 > 0 and var_467_7 < var_467_13 then
					arg_464_1.talkMaxDuration = var_467_13

					if var_467_13 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_13 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_10
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_14 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_14 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_14

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_14 and arg_464_1.time_ < var_467_6 + var_467_14 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play324031116 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 324031116
		arg_468_1.duration_ = 14.93

		local var_468_0 = {
			zh = 10.633,
			ja = 14.933
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
				arg_468_0:Play324031117(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["10039ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect10039ui_story == nil then
				arg_468_1.var_.characterEffect10039ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect10039ui_story and not isNil(var_471_0) then
					arg_468_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect10039ui_story then
				arg_468_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_471_4 = 0
			local var_471_5 = 1.075

			if var_471_4 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_6 = arg_468_1:FormatText(StoryNameCfg[472].name)

				arg_468_1.leftNameTxt_.text = var_471_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_7 = arg_468_1:GetWordFromCfg(324031116)
				local var_471_8 = arg_468_1:FormatText(var_471_7.content)

				arg_468_1.text_.text = var_471_8

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031116", "story_v_out_324031.awb") ~= 0 then
					local var_471_12 = manager.audio:GetVoiceLength("story_v_out_324031", "324031116", "story_v_out_324031.awb") / 1000

					if var_471_12 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_12 + var_471_4
					end

					if var_471_7.prefab_name ~= "" and arg_468_1.actors_[var_471_7.prefab_name] ~= nil then
						local var_471_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_7.prefab_name].transform, "story_v_out_324031", "324031116", "story_v_out_324031.awb")

						arg_468_1:RecordAudio("324031116", var_471_13)
						arg_468_1:RecordAudio("324031116", var_471_13)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_324031", "324031116", "story_v_out_324031.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_324031", "324031116", "story_v_out_324031.awb")
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
	Play324031117 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 324031117
		arg_472_1.duration_ = 7.93

		local var_472_0 = {
			zh = 6.333,
			ja = 7.933
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
			arg_472_1.auto_ = false
		end

		function arg_472_1.playNext_(arg_474_0)
			arg_472_1.onStoryFinished_()
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.725

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[472].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(324031117)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 29
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324031", "324031117", "story_v_out_324031.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_324031", "324031117", "story_v_out_324031.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_324031", "324031117", "story_v_out_324031.awb")

						arg_472_1:RecordAudio("324031117", var_475_9)
						arg_472_1:RecordAudio("324031117", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_324031", "324031117", "story_v_out_324031.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_324031", "324031117", "story_v_out_324031.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/ST31"
	},
	voices = {
		"story_v_out_324031.awb"
	}
}
